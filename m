Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTESUJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTESUJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:09:30 -0400
Received: from mail.casabyte.com ([209.63.254.226]:14349 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S262671AbTESUJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:09:27 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>,
       "Davide Libenzi" <davidel@xmailserver.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: recursive spinlocks. Shoot.
Date: Mon, 19 May 2003 13:22:15 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGOEDICMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200305182315.h4INFG428386@oboe.it.uc3m.es>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, it is safe to have the concurrent/race condition for the read of a
lock owner (outside the lock) and the write of a lock owner (inside the
lock) as long as the "current owner" value stored inside the lock is "sent
away" before the recursive lock is unlocked for the last time.

The owner value doesn't even have to be atomic (though it ought to be) The
only "hard" requirement is that there is no mid-update value that can ever
be somebody else.  This requirement can be violated in some odd segmenting
systems if "me" is a pointer.  If me is a machine-primitive scalar the
probability drops to nearly null that a partially written value can match
anybody else  (on an x86 platform, you toss a bus-lock around the
assignment, which is what, I believe, the atomic type assignments do).

Since the logic reads "if not me then wait for lock else increment depth"
you only have to guard against false positives.  That guard case is
accomplished by making sure you don't ever leave "yourself" in the owner
slot when you free up the lock.

So generically:

get_lock():
if owner==me
then
  ++depth;
else
  wait on actual lock primitive
  possibly_atomic_assign(owner = me)
  depth = 1
fi

free_lock()
/* optional debug test */
if owner != me
then
  oops()
fi
if depth > 1
then
  --depth
else
  depth = 0
  possibly_atomic_assign(owner = nobody)
  release actual lock primitive
fi


There needs must be a "nobody" (a well defined quasi-legal value that can
not occur in the legitimate set of owners, like -1 or NULL) assigned to the
owner item so that you cannot encounter your own id in the owner slot when
you don't actually have the lock primitive.

At several glances this structure seems odd and somehow vulnerable, but when
you consider that a thread is never actually competing with itself, you get
closure on the system.  (that is, once you really internalize the fact that
the same thread can not be multiply entrant on both of these routines at the
same time, and you see that all other threads will do a proper wait on the
"real" primitive lock because of conditional exclusion (e.g. they are not
ever the owner at the time of the test, no matter how you update owner in
the sequence, if they are, in fact, not the owner of the lock.)

Hitting the read and write at the same time is not a "bang" because (if the
rest of the code is correct) the value being read, even if it is "trash"
because of a partial update, will not let the reader into the "is me" part
of the logic and the not-me branch is a wait for the "real" spinlock.
Again, you might want to use atomic_read() and atomic_set(), then again,
according to the headers you are only guaranteed 24 bits of atomic
protection anyway, so if the owner is a pointer, it probably won't help that
much.

The finer points include the fact that the depth and owner values are
actually protected values inside the domain of the real lock primitive.
They are just as safe as any other value protected by the lock.  The
inequality test "outside" the lock is actually a microcosm of the
readers/writer kind of behavior.  "Atomicizing" the owner value armors
against the possibility of CPU reading a half-written value that "happens"
to match the enquiring thread ID.  But since the only transition that can
occur is from some existent owner to "nobody", or from "nobody" to the new
owner, a well chosen "nobody" can make the atomic assignment moot anyway.

I use this recursion layer all the time with posix mutex(es) in application
layer code where I don't actually have an atomic_t to begin with.

It is actually provable.

Rob.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Peter T. Breuer
Sent: Sunday, May 18, 2003 4:15 PM
To: Davide Libenzi
Cc: linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.


In article <20030518202013$5297@gated-at.bofh.it> you wrote:
>>
>> > #define nestlock_lock(snl) \
>> > 	do { \
>> > 		if ((snl)->uniq == current) { \
>>
>> That would be able to read uniq while it is being written by something
>> else (which it can, according to the code below). It needs protection.

> No it does not, look better.

I'm afraid I only see that it does!

>> > 			atomic_inc(&(snl)->count); \
>> > 		} else { \
>> > 			spin_lock(&(snl)->lock); \
>> > 			atomic_inc(&(snl)->count); \
>> > 			(snl)->uniq = current; \
>>
>> Hmm .. else we wait for the lock, and then set count and uniq, while
>> somebody else may have entered and be reading it :-). You exit with

> Nope, think about a case were it breaks. False negatives are not possible
> because it is set by the same task and false positives either.

No. This is not true. Imagine two threads, timed as follows ...

    .
    .
    .
    .
if ((snl)->uniq == current) {
atomic_inc(&(snl)->count); 		.
} else { 				.
spin_lock(&(snl)->lock);		.
atomic_inc(&(snl)->count);		.
(snl)->uniq = current; 	  <->	if ((snl)->uniq == current) {
				atomic_inc(&(snl)->count);
				} else {
				spin_lock(&(snl)->lock);
				atomic_inc(&(snl)->count);
				(snl)->uniq = current;


There you are. One hits the read exactly at the time the other does a
write. Bang.


>> Well, it's not assembler either, but at least it's easily comparable
>> with the nonrecursive version. It's essentially got an extra if and
>> an inc in the lock. That's all.

> Well, there's a little difference. In case of contention, you loop with
> your custom try lock while I used the optimized asm code inside spin_lock.
> But again, I believe we didn't lose anything with the removal of this code
> (nested/recursive locks) from the kernel.

We lose hours of programmers time, looking for deadlocks caused by
accidently taking the same spinlock twice and not knowing it.

A question in my mind is whether a fault in a third thread, like
sleeping with a spinlock held, can make a recursive spinlock into
a fault causer ... no, I don't see any way.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTERXCb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 19:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTERXCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 19:02:31 -0400
Received: from smtp03.uc3m.es ([163.117.136.123]:50700 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id S262256AbTERXC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 19:02:26 -0400
Date: Mon, 19 May 2003 01:15:16 +0200
Message-Id: <200305182315.h4INFG428386@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: recursive spinlocks. Shoot.
X-Newsgroups: linux.kernel
In-Reply-To: <20030518202013$5297@gated-at.bofh.it>
Cc: linux-kernel@vger.kernel.org
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272585AbTHPEik (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 00:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272587AbTHPEik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 00:38:40 -0400
Received: from waste.org ([209.173.204.2]:164 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272585AbTHPEig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 00:38:36 -0400
Date: Fri, 15 Aug 2003 23:38:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tytso@mit.edu, jmorris@intercode.com.au, jamie@shareable.org,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030816043816.GC325@waste.org>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030815221211.GA4306@think> <20030815235501.GB325@waste.org> <20030815170532.06e14e89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815170532.06e14e89.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 05:05:32PM -0700, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > I'm pretty sure there was never a time when entropy
> > accounting wasn't racy let alone wrong, SMP or no (fixed in -mm, thank
> > you).
> 
> Well is has been argued that the lack of locking in the random driver is a
> "feature", adding a little more unpredictability.

> Now I don't know if that makes sense or not, but the locking certainly has
> a cost.  If it doesn't actually fix anything then that cost becomes a
> waste.
> 
> IOW: what bug does that locking fix?

Ok, the brief summary is that we're keeping a count of the number of
bits of unguessable environmental data (aka entropy) we've collected.
If we never give out more bits than we take in, we are immune to even
brute force attacks on the state of the pool and therefore the outputs
are unguessable as well (which is why /dev/random blocks where
/dev/urandom does not). If we fail to account for outputs properly, we
lose this property.

a) extract_entropy (pool->lock)

 This can be called simultaneously from different contexts and a race
 will result in extracting more bits from the pool than are accounted
 for or available. This could also underflow. I use the new pool lock
 here to cover the accounting - we rely on the hashing and mixing to
 evenly distribute bits in the extraction itself and we have feedback
 during the extraction as well.

 For nitpickers, there remains a vanishingly small possibility that
 two readers could get identical results from the pool by hitting a
 window immediately after reseeding, after accounting, _and_ after
 feedback mixing. I have another patch I'm still playing with that
 addresses this by hashing a different subset of the pool on each call
 rather than the entire pool, with the position covered by the pool
 lock during accounting. (This has the controversial side effect of
 doubling bandwidth.)

 Note that I added a flag here to limit the amount of entropy pulled
 to what's available. Random_read() formerly would check for the
 number of available bits and then ask for them, and extract_entropy
 would copy out that many bits even if an intervening caller raced and
 depleted the pool.

 The possible contention issue here is that /dev/random and
 /dev/urandom+get_random_bytes() currently share the same pool and
 get_random_bytes gets called moderately frequently by things like
 sequence number generation by numerous places in the network layer
 and various things in filesystems. I suspect this won't ever be a
 noticeable lock but see below.

 [There was also a cute sleeping problem here with random_read.
 random_read used old-style open-coded sleeping, marked itself
 TASK_INTERRUPTIBLE, then called extract_entropy, which would do a
 conditional reschedule, and fall asleep until the next wake up,
 despite having enough entropy to fulfill the request.]

b) add_entropy_words (pool->lock)

 This function folds new words into the pool. The pool lock is taken
 to prevent a race whereby both callers read the same value of for the
 add_ptr and mix on top of each other, again causing an overestimate
 of the entropy in the pool. The lock could be taken and released
 inside the loop, but this tends to get called for a small number of
 words (usually <=8).

c) credit_entropy_store (pool->lock)

 Locking here actually prevents underaccounting, but it also prevents
 overflow. Short and sweet.

d) RNDGETPOOL ioctl (pool->lock)

 The intent of this ioctl is to take an atomic snapshot of the entropy
 pool, entropy count, etc., presumably for debugging purposes. For
 purpose of getting random data, one should simply read(). With the
 addition of a second pool, it's no longer useful for debugging, but
 could be useful for attackers and I'd it to just return -ENOTTY. For
 now, it takes the pool lock. Should be no users, shouldn't increase
 contention.

e) batch_entropy_store && batch_entropy_process (batch_lock)

 This gets really messy without locking. This is a circular buffer
 that gets filled typically from interrupts and emptied by a
 workqueue. Lack of locking here could cause tail to pass head, etc.,
 dropping samples on the ground or replaying a whole buffer worth old
 samples. Rather than hold the lock while we mix the queue, we copy
 the sample ring. (I have a better patch to do this with a flip
 buffer.)

 [By the way, whoever did the workqueue conversion for 2.5 changed this
 code to wakeup the processing worker when the sample pool was half
 full rather on every sample but got the test not quite right. I had
 to stare at this for a bit:

        new = (batch_head+1) & (batch_max-1);
        if ((unsigned)(new - batch_tail) >= (unsigned)(batch_max / 2))
        {

 There was a further problem where extract_entropy was adding zero
 entropy timing samples and filling the sample buffer with useless
 samples. Occassionally the above bug would keep it from scheduling
 batch processing in this case and the code could block permanently,
 throwing out all new samples. Ouch.]

f) change_poolsize (queued for resend)

 The /proc/sys/kernel/random sysctl is writable and lets you change
 the pointer to the input pool out from under callers (boom). Short of
 expanding the pool lock to cover all operations on the pool, there's
 no clean fix for this. And it's not really worth the trouble. As it takes
 quite a number of transactions to empty the 4k+1kbits of entropy we can
 currently hold (enough for dozens of strong keys), if we end up
 waiting for entropy regularly, queueing theory tells us we're
 exceeding our input rate and we're going to lose no matter how big
 the buffer is. 

 On the other hand, the input pool is only 4kbits and rather than keep
 this feature I can save most of those 512 bytes for everyone by deleting the
 resizing code.

g) urandom starves/races random (queued for resend)

 Readers of /dev/urandom and get_random_bytes (both nonblock) pull from
 the same pool as /dev/random readers and without limit. As there are
 numerous users of get_random_bytes as pointed out above, /dev/random
 readers can easily be starved (and previously, race on wakeup), even
 by remote readers. This is rather a problem for the classic
 entropy-source-limited headless web server which may very well be
 trying to use both in, for example, a departmental certificate
 authority.

 My solution is to clean up the pool creation code and add a second
 output pool for nonblocking users. The pool reseeding logic is
 cleaned up to address a bunch of corner cases and has a low watermark
 parameter so that the nonblocking users can avoid draining the input
 pool entirely. The current default is to not let nonblocking readers
 draw the input pool below the point where blocking readers can do two
 catastrophic reseeds.

 The cleanup of the pool code lets this easily become per_cpu output
 pools for the non-blocking readers with about 10 lines of code if the
 above-mentioned contention is an issue. I haven't tried this yet, but
 I already did per_cpu for the cryptoapi stuff and it should be about
 the same.

 We could go completely lockless for the nonblocking pool also, but
 that would require some code duplication.

I can detail some of the non-race accounting issues I fixed but that
message would be similarly long and more tedious.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751731AbWG0QmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWG0QmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbWG0QmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:42:00 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:31880 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751723AbWG0Ql7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:41:59 -0400
From: Christian Borntraeger <borntrae@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] bug in futex unqueue_me
Date: Thu, 27 Jul 2006 18:41:56 +0200
User-Agent: KMail/1.9.1
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>,
       Thomas Gleixner <tglx@timesys.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607271841.56342.borntrae@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntrae@de.ibm.com>

This patch adds a barrier() in futex unqueue_me to avoid aliasing of two 
pointers.

On my s390x system I saw the following oops:

Unable to handle kernel pointer dereference at virtual kernel address 
0000000000000000
Oops: 0004 [#1]
CPU:    0    Not tainted
Process mytool (pid: 13613, task: 000000003ecb6ac0, ksp: 00000000366bdbd8)
Krnl PSW : 0704d00180000000 00000000003c9ac2 (_spin_lock+0xe/0x30)
Krnl GPRS: 00000000ffffffff 000000003ecb6ac0 0000000000000000 0700000000000000
           0000000000000000 0000000000000000 000001fe00002028 00000000000c091f
           000001fe00002054 000001fe00002054 0000000000000000 00000000366bddc0
           00000000005ef8c0 00000000003d00e8 0000000000144f91 00000000366bdcb8
Krnl Code: ba 4e 20 00 12 44 b9 16 00 3e a7 84 00 08 e3 e0 f0 88 00 04
Call Trace:
([<0000000000144f90>] unqueue_me+0x40/0xe4)
 [<0000000000145a0c>] do_futex+0x33c/0xc40
 [<000000000014643e>] sys_futex+0x12e/0x144
 [<000000000010bb00>] sysc_noemu+0x10/0x16
 [<000002000003741c>] 0x2000003741c



The code in question is:

static int unqueue_me(struct futex_q *q)
{
        int ret = 0;
        spinlock_t *lock_ptr;

        /* In the common case we don't take the spinlock, which is nice. */
 retry:
        lock_ptr = q->lock_ptr;
        if (lock_ptr != 0) {
                spin_lock(lock_ptr);                
		/*
                 * q->lock_ptr can change between reading it and
                 * spin_lock(), causing us to take the wrong lock.  This
                 * corrects the race condition.
[...]


and my compiler (gcc 4.1.0) makes the following out of it:

00000000000003c8 <unqueue_me>:
     3c8:       eb bf f0 70 00 24       stmg    %r11,%r15,112(%r15)
     3ce:       c0 d0 00 00 00 00       larl    %r13,3ce <unqueue_me+0x6>
                        3d0: R_390_PC32DBL      .rodata+0x2a
     3d4:       a7 f1 1e 00             tml     %r15,7680
     3d8:       a7 84 00 01             je      3da <unqueue_me+0x12>
     3dc:       b9 04 00 ef             lgr     %r14,%r15
     3e0:       a7 fb ff d0             aghi    %r15,-48
     3e4:       b9 04 00 b2             lgr     %r11,%r2
     3e8:       e3 e0 f0 98 00 24       stg     %r14,152(%r15)
     3ee:       e3 c0 b0 28 00 04       lg      %r12,40(%r11) 
		/* write q->lock_ptr in r12 */
     3f4:       b9 02 00 cc             ltgr    %r12,%r12
     3f8:       a7 84 00 4b             je      48e <unqueue_me+0xc6>
		/* if r12 is zero then jump over the code.... */
     3fc:       e3 20 b0 28 00 04       lg      %r2,40(%r11)
		/* write q->lock_ptr in r2 */
     402:       c0 e5 00 00 00 00       brasl   %r14,402 <unqueue_me+0x3a>
                        404: R_390_PC32DBL      _spin_lock+0x2
		/* use r2 as parameter for spin_lock */

So the code becomes more or less:
if (q->lock_ptr != 0) spin_lock(q->lock_ptr)
instead of
if (lock_ptr != 0) spin_lock(lock_ptr)

Which caused the oops from above.
After adding a barrier gcc creates code without this problem:
[...] (the same)
     3ee:       e3 c0 b0 28 00 04       lg      %r12,40(%r11)
     3f4:       b9 02 00 cc             ltgr    %r12,%r12
     3f8:       b9 04 00 2c             lgr     %r2,%r12
     3fc:       a7 84 00 48             je      48c <unqueue_me+0xc4>
     400:       c0 e5 00 00 00 00       brasl   %r14,400 <unqueue_me+0x38>
                        402: R_390_PC32DBL      _spin_lock+0x2



As a general note, this code of unqueue_me seems a bit fishy. The retry logic 
of unqueue_me only works if we can guarantee, that the original value of 
q->lock_ptr is always a spinlock (Otherwise we overwrite kernel memory). We 
know that q->lock_ptr can change. I dont know what happens with the original 
spinlock, as I am not an expert with the futex code. 

CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Rusty Russell <rusty@rustcorp.com.au>
CC: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@timesys.com>
Signed-off-by: Christian Borntraeger <borntrae@de.ibm.com>
---
 
futex.c |    1 +
 1 file changed, 1 insertion(+)

---
diff --git a/kernel/futex.c b/kernel/futex.c
index cf0c8e2..01aa87c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -930,6 +930,7 @@ static int unqueue_me(struct futex_q *q)
 	/* In the common case we don't take the spinlock, which is nice. */
  retry:
 	lock_ptr = q->lock_ptr;
+	barrier();
 	if (lock_ptr != 0) {
 		spin_lock(lock_ptr);
 		/*




-- 
Mit freundlichen Grüßen / Best Regards

Christian Borntraeger
Linux Software Engineer zSeries Linux & Virtualization




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965283AbWIFXNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbWIFXNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWIFXNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:13:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:50124 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964965AbWIFXCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:02 -0400
Date: Wed, 6 Sep 2006 15:57:04 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Adrian Bunk <bunk@stusta.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Bastian Blank <bastian@waldi.eu.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>,
       Thomas Gleixner <tglx@timesys.com>,
       Christian Borntraeger <borntrae@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 22/37] bug in futex unqueue_me
Message-ID: <20060906225704.GW15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="bug-in-futex-unqueue_me.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
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

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Acked-by: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@timesys.com>
Signed-off-by: Christian Borntraeger <borntrae@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/futex.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17.11.orig/kernel/futex.c
+++ linux-2.6.17.11/kernel/futex.c
@@ -593,6 +593,7 @@ static int unqueue_me(struct futex_q *q)
 	/* In the common case we don't take the spinlock, which is nice. */
  retry:
 	lock_ptr = q->lock_ptr;
+	barrier();
 	if (lock_ptr != 0) {
 		spin_lock(lock_ptr);
 		/*

--

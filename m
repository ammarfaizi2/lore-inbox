Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266870AbRG0PBS>; Fri, 27 Jul 2001 11:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbRG0PBI>; Fri, 27 Jul 2001 11:01:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:55629 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266870AbRG0PAy>; Fri, 27 Jul 2001 11:00:54 -0400
Date: Fri, 27 Jul 2001 17:01:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
Message-ID: <20010727170107.J22784@athlon.random>
In-Reply-To: <200107261746.VAA31697@ms2.inr.ac.ru> <20010726002357.D32148@athlon.random> <200107261746.VAA31697@ms2.inr.ac.ru> <20010726202939.D22784@athlon.random> <4.3.1.0.20010726165025.0574cdc0@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.1.0.20010726165025.0574cdc0@mail1>; from maxk@qualcomm.com on Thu, Jul 26, 2001 at 05:47:50PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 05:47:50PM -0700, Maksim Krasnyanskiy wrote:
> Should we then create generic function (something like netif_rx_from_user) than will call do_softirq 
> after calling netif_rx ?

creating such a function is certainly ok (it must first check pending()
before running do_softirq of course). The name shouldn't be "from user"
because we actually call it from normal kernel context.

> I queue it and do tasklet_schedule(tx_task). Everything works just fine but on SMP machine I noticed that sometimes 
> data is sent in the wrong order. And the only reason why reordering could happen is if several tx_tasks are runing at the 

Do you use tasklet_enable? This patch fixes a bug in tasklet_enable.
(bug found by David Mosemberg) We are thinking at more CPU friendly ways
to handle the tasklet_disable, Linus just had a suggestion, but I don't
have time right now to think much about the alternate approches (i'm at
ols), I will do next week. If you are usng tasklet_enable you may want
to give it a spin.

--- 2.4.7/include/linux/interrupt.h	Sun Jul 22 01:16:45 2001
+++ 2.4.7aa1/include/linux/interrupt.h	Thu Jul 26 21:08:16 2001
@@ -139,24 +139,26 @@
 static inline void tasklet_disable_nosync(struct tasklet_struct *t)
 {
 	atomic_inc(&t->count);
+	smp_mb__after_atomic_inc();
 }
 
 static inline void tasklet_disable(struct tasklet_struct *t)
 {
 	tasklet_disable_nosync(t);
 	tasklet_unlock_wait(t);
+	smp_mb();
 }
 
 static inline void tasklet_enable(struct tasklet_struct *t)
 {
-	if (atomic_dec_and_test(&t->count))
-		tasklet_schedule(t);
+	smp_mb__before_atomic_dec();
+	atomic_dec(&t->count);
 }
 
 static inline void tasklet_hi_enable(struct tasklet_struct *t)
 {
-	if (atomic_dec_and_test(&t->count))
-		tasklet_hi_schedule(t);
+	smp_mb__before_atomic_dec();
+	atomic_dec(&t->count);
 }
 
 extern void tasklet_kill(struct tasklet_struct *t);

Andrea

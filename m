Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319046AbSHWS33>; Fri, 23 Aug 2002 14:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319087AbSHWS33>; Fri, 23 Aug 2002 14:29:29 -0400
Received: from waste.org ([209.173.204.2]:40364 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S319046AbSHWS3W>;
	Fri, 23 Aug 2002 14:29:22 -0400
Date: Fri, 23 Aug 2002 13:33:31 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (5/7) untrusted entropy sources
Message-ID: <20020823183331.GE2224@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[correction: RML's SA_SAMPLE_RANDOM patch is safe after _this_ patch]

This makes irq and blkdev interrupts untrusted and does away with
their superfluous state initialization and tracking.

diff -ur a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
--- a/arch/alpha/kernel/irq.c	2002-08-17 00:30:02.000000000 -0500
+++ b/arch/alpha/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -166,17 +166,6 @@
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-		rand_initialize_irq(irq);
-	}
 
 	/*
 	 * The following block of code has to be executed atomically
diff -ur a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
--- a/arch/arm/kernel/irq.c	2002-08-17 00:30:02.000000000 -0500
+++ b/arch/arm/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -458,17 +458,6 @@
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-	        rand_initialize_irq(irq);
-	}
 
 	/*
 	 * The following block of code has to be executed atomically
diff -ur a/arch/cris/kernel/irq.c b/arch/cris/kernel/irq.c
--- a/arch/cris/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/cris/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -315,9 +315,6 @@
 		shared = 1;
 	}
 
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
 	save_flags(flags);
 	cli();
 	*p = new;
diff -ur a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2002-08-17 00:29:58.000000000 -0500
+++ b/arch/i386/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -733,17 +733,6 @@
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-		rand_initialize_irq(irq);
-	}
 
 	/*
 	 * The following block of code has to be executed atomically
diff -ur a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
--- a/arch/ia64/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/ia64/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -1016,17 +1016,6 @@
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-		rand_initialize_irq(irq);
-	}
 
 	if (new->flags & SA_PERCPU_IRQ) {
 		desc->status |= IRQ_PER_CPU;
diff -ur a/arch/ia64/kernel/irq_ia64.c b/arch/ia64/kernel/irq_ia64.c
--- a/arch/ia64/kernel/irq_ia64.c	2002-07-20 14:11:14.000000000 -0500
+++ b/arch/ia64/kernel/irq_ia64.c	2002-08-23 12:43:29.000000000 -0500
@@ -22,7 +22,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/slab.h>
 #include <linux/ptrace.h>
-#include <linux/random.h>	/* for rand_initialize_irq() */
 #include <linux/signal.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
diff -ur a/arch/mips/baget/irq.c b/arch/mips/baget/irq.c
--- a/arch/mips/baget/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips/baget/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -284,9 +284,6 @@
 		shared = 1;
 	}
 
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
 	save_and_cli(flags);
 	*p = new;
 	restore_flags(flags);
diff -ur a/arch/mips/dec/irq.c b/arch/mips/dec/irq.c
--- a/arch/mips/dec/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips/dec/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -181,8 +181,6 @@
 	} while (old);
 	shared = 1;
     }
-    if (new->flags & SA_SAMPLE_RANDOM)
-	rand_initialize_irq(irq);
 
     save_and_cli(flags);
     *p = new;
diff -ur a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
--- a/arch/mips/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -649,17 +649,6 @@
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-		rand_initialize_irq(irq);
-	}
 
 	/*
 	 * The following block of code has to be executed atomically
diff -ur a/arch/mips/kernel/old-irq.c b/arch/mips/kernel/old-irq.c
--- a/arch/mips/kernel/old-irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips/kernel/old-irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -263,9 +263,6 @@
 		shared = 1;
 	}
 
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
 	save_and_cli(flags);
 	*p = new;
 
diff -ur a/arch/mips/philips/nino/irq.c b/arch/mips/philips/nino/irq.c
--- a/arch/mips/philips/nino/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips/philips/nino/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -227,8 +227,6 @@
 	} while (old);
 	shared = 1;
     }
-    if (new->flags & SA_SAMPLE_RANDOM)
-	rand_initialize_irq(irq);
 
     save_and_cli(flags);
     *p = new;
diff -ur a/arch/mips64/mips-boards/malta/malta_int.c b/arch/mips64/mips-boards/malta/malta_int.c
--- a/arch/mips64/mips-boards/malta/malta_int.c	2002-07-20 14:11:29.000000000 -0500
+++ b/arch/mips64/mips-boards/malta/malta_int.c	2002-08-23 12:43:29.000000000 -0500
@@ -247,9 +247,6 @@
 		shared = 1;
 	}
 
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
 	*p = new;
 	if (!shared)
 		enable_irq(irq);
diff -ur a/arch/mips64/sgi-ip27/ip27-irq.c b/arch/mips64/sgi-ip27/ip27-irq.c
--- a/arch/mips64/sgi-ip27/ip27-irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips64/sgi-ip27/ip27-irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -339,8 +339,6 @@
 		printk("IRQ array overflow %d\n", irq);
 		while(1);
 	}
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
 
 	save_and_cli(flags);
 	p = irq_action + irq;
diff -ur a/arch/ppc/kernel/irq.c b/arch/ppc/kernel/irq.c
--- a/arch/ppc/kernel/irq.c	2002-08-17 00:30:02.000000000 -0500
+++ b/arch/ppc/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -133,17 +133,6 @@
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-		rand_initialize_irq(irq);
-	}
 
 	/*
 	 * The following block of code has to be executed atomically
diff -ur a/arch/ppc64/kernel/irq.c b/arch/ppc64/kernel/irq.c
--- a/arch/ppc64/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/ppc64/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -120,17 +120,6 @@
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-		rand_initialize_irq(irq);
-	}
 
 	/*
 	 * The following block of code has to be executed atomically
diff -ur a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
--- a/arch/sh/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/sh/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -499,17 +499,6 @@
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-		rand_initialize_irq(irq);
-	}
 
 	/*
 	 * The following block of code has to be executed atomically
diff -ur a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
--- a/arch/sparc64/kernel/irq.c	2002-08-17 00:30:02.000000000 -0500
+++ b/arch/sparc64/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -316,20 +316,6 @@
 	if (!handler)
 	    return -EINVAL;
 
-	if ((bucket != &pil0_dummy_bucket) && (irqflags & SA_SAMPLE_RANDOM)) {
-		/*
-	 	 * This function might sleep, we want to call it first,
-	 	 * outside of the atomic block. In SA_STATIC_ALLOC case,
-		 * random driver's kmalloc will fail, but it is safe.
-		 * If already initialized, random driver will not reinit.
-	 	 * Yes, this might clear the entropy pool if the wrong
-	 	 * driver is attempted to be loaded, without actually
-	 	 * installing a new handler, but is this really a problem,
-	 	 * only the sysadmin is able to do this.
-	 	 */
-		rand_initialize_irq(irq);
-	}
-
 	spin_lock_irqsave(&irq_action_lock, flags);
 
 	action = *(bucket->pil + irq_action);
diff -ur a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/x86_64/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
@@ -986,17 +986,6 @@
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-		rand_initialize_irq(irq);
-	}
 
 	/*
 	 * The following block of code has to be executed atomically
diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-08-23 12:43:27.000000000 -0500
+++ b/drivers/char/random.c	2002-08-23 12:43:29.000000000 -0500
@@ -686,14 +686,11 @@
 struct timer_rand_state {
 	__u32		last_time;
 	__s32		last_delta,last_delta2;
-	int		dont_count_entropy:1;
 };
 
 static struct timer_rand_state keyboard_timer_state;
 static struct timer_rand_state mouse_timer_state;
 static struct timer_rand_state extract_timer_state;
-static struct timer_rand_state *irq_timer_state[NR_IRQS];
-static struct timer_rand_state *blkdev_timer_state[MAX_BLKDEV];
 static int trust_break=50, trust_pct=0, trust_min=0, trust_max=100;
 
 /*
@@ -731,7 +728,7 @@
 	 * We take into account the first, second and third-order deltas
 	 * in order to make our estimate.
 	 */
-	if (!state->dont_count_entropy) {
+	if (state) {
 		delta = time - state->last_time;
 		state->last_time = time;
 
@@ -793,24 +790,12 @@
 
 void add_interrupt_randomness(int irq)
 {
-	if (irq >= NR_IRQS || irq_timer_state[irq] == 0)
-		return;
-
-	add_timer_randomness(irq_timer_state[irq], 0x100+irq);
+	add_timer_randomness(0, irq);
 }
 
 void add_blkdev_randomness(int major)
 {
-	if (major >= MAX_BLKDEV)
-		return;
-
-	if (blkdev_timer_state[major] == 0) {
-		rand_initialize_blkdev(major, GFP_ATOMIC);
-		if (blkdev_timer_state[major] == 0)
-			return;
-	}
-		
-	add_timer_randomness(blkdev_timer_state[major], 0x200+major);
+	add_timer_randomness(0, 0x200+major);
 }
 
 /******************************************************************
@@ -1418,53 +1403,10 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif
-	for (i = 0; i < NR_IRQS; i++)
-		irq_timer_state[i] = NULL;
-	for (i = 0; i < MAX_BLKDEV; i++)
-		blkdev_timer_state[i] = NULL;
 	memset(&keyboard_timer_state, 0, sizeof(struct timer_rand_state));
 	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
-	extract_timer_state.dont_count_entropy = 1;
-}
-
-void rand_initialize_irq(int irq)
-{
-	struct timer_rand_state *state;
-	
-	if (irq >= NR_IRQS || irq_timer_state[irq])
-		return;
-
-	/*
-	 * If kmalloc returns null, we just won't use that entropy
-	 * source.
-	 */
-	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
-	if (state) {
-		memset(state, 0, sizeof(struct timer_rand_state));
-		irq_timer_state[irq] = state;
-	}
-}
-
-void rand_initialize_blkdev(int major, int mode)
-{
-	struct timer_rand_state *state;
-	
-	if (major >= MAX_BLKDEV || blkdev_timer_state[major])
-		return;
-
-	/*
-	 * If kmalloc returns null, we just won't use that entropy
-	 * source.
-	 */
-	state = kmalloc(sizeof(struct timer_rand_state), mode);
-	if (state) {
-		memset(state, 0, sizeof(struct timer_rand_state));
-		blkdev_timer_state[major] = state;
-	}
 }
 
-
 static ssize_t
 random_read(struct file * file, char * buf, size_t nbytes, loff_t *ppos)
 {
diff -ur a/include/linux/random.h b/include/linux/random.h
--- a/include/linux/random.h	2002-08-23 12:43:22.000000000 -0500
+++ b/include/linux/random.h	2002-08-23 12:43:29.000000000 -0500
@@ -43,8 +43,6 @@
 #ifdef __KERNEL__
 
 extern void rand_initialize(void);
-extern void rand_initialize_irq(int irq);
-extern void rand_initialize_blkdev(int irq, int mode);
 
 extern void batch_entropy_store(u32 val, int bits);
 


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

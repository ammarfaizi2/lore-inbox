Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWEERJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWEERJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWEERJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:09:20 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:17870 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751167AbWEERJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:09:19 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <15.420169009@selenic.com>
Subject: [PATCH 14/14] random: Remove add_interrupt_randomness
Date: Fri, 05 May 2006 11:42:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove add_interrupt_randomness

This patch removes add_interrupt_randomness, which was only used by
IRQ handlers that used to set SA_SAMPLE_RANDOM.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/char/random.c
===================================================================
--- 2.6.orig/drivers/char/random.c	2006-05-02 17:28:43.000000000 -0500
+++ 2.6/drivers/char/random.c	2006-05-03 16:47:01.000000000 -0500
@@ -127,18 +127,12 @@
  *
  * 	void add_input_randomness(unsigned int type, unsigned int code,
  *                                unsigned int value);
- * 	void add_interrupt_randomness(int irq);
+ *      void add_disk_randomness(struct gendisk *disk);
  *
  * add_input_randomness() uses the input layer interrupt timing, as well as
  * the event type information from the hardware.
  *
- * add_interrupt_randomness() uses the inter-interrupt timing as random
- * inputs to the entropy pool.  Note that not all interrupts are good
- * sources of randomness!  For example, the timer interrupts is not a
- * good choice, because the periodicity of the interrupts is too
- * regular, and hence predictable to an attacker.  Disk interrupts are
- * a better measure, since the timing of the disk interrupts are more
- * unpredictable.
+ * add_disk_randomness() does the same for disk devices.
  *
  * All of these routines try to estimate how many bits of randomness a
  * particular randomness source.  They do this by keeping track of the
@@ -557,7 +551,6 @@ struct timer_rand_state {
 };
 
 static struct timer_rand_state input_timer_state;
-static struct timer_rand_state *irq_timer_state[NR_IRQS];
 
 /*
  * This function adds entropy to the entropy "pool" by using timing
@@ -647,15 +640,6 @@ void add_input_randomness(unsigned int t
 			     (type << 4) ^ code ^ (code >> 4) ^ value);
 }
 
-void add_interrupt_randomness(int irq)
-{
-	if (irq >= NR_IRQS || irq_timer_state[irq] == 0)
-		return;
-
-	DEBUG_ENT("irq event %d\n", irq);
-	add_timer_randomness(irq_timer_state[irq], 0x100 + irq);
-}
-
 void add_disk_randomness(struct gendisk *disk)
 {
 	if (!disk || !disk->random)
@@ -901,24 +885,6 @@ static int __init rand_initialize(void)
 }
 module_init(rand_initialize);
 
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
 void rand_initialize_disk(struct gendisk *disk)
 {
 	struct timer_rand_state *state;
Index: 2.6/include/linux/random.h
===================================================================
--- 2.6.orig/include/linux/random.h	2006-04-20 17:01:10.000000000 -0500
+++ 2.6/include/linux/random.h	2006-05-03 16:44:01.000000000 -0500
@@ -42,12 +42,8 @@ struct rand_pool_info {
 
 #ifdef __KERNEL__
 
-extern void rand_initialize_irq(int irq);
-
 extern void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value);
-extern void add_interrupt_randomness(int irq);
-
 extern void get_random_bytes(void *buf, int nbytes);
 void generate_random_uuid(unsigned char uuid_out[16]);
 

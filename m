Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932415AbWFEFl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWFEFl3 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 01:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWFEFl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 01:41:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:50132 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932415AbWFEFl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 01:41:28 -0400
Subject: [RFC][PATCH] request_irq(...,SA_BOOTMEM);
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 15:40:08 +1000
Message-Id: <1149486009.8543.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In various places, architectures need to request interrupts early during
boot. Before slab is initialized typically. We used to have all sorts of
arch hacks to do so, which ended up being turned into something like:

static struct irqaction xxx_irq = { xxx_irq_handler, 0, CPU_MASK_NONE,
"xxx", NULL, NULL };

 .../...

setup_irq(&xxx_irq);

(for example fpu_irq in i386's i8259.c)

I quite dislike that and would like to propose that patch instead,
adding an SA_BOOTMEM flag that can be used to request IRQs before slab
is initialized. (Note that the register_* calls to the proc code aren't
protected, they shouldn't be a problem as they test for the /proc/irq
root node before doing anything and this can't have been created if slab
doesn't work).

Of course, an SA_BOOTMEM irqaction can't be freed. My proposed patch
"disconnects" it completely and just skips the freeing step but we might
want to refuse with a WARN_ON() attempts to free_irq() such an interrupt
instead. Note that the existing practice using a static descriptor
doesn't protect against such attempts at freeing.

Ben.

Index: linux-work/include/linux/signal.h
===================================================================
--- linux-work.orig/include/linux/signal.h	2006-05-30 13:03:41.000000000 +1000
+++ linux-work/include/linux/signal.h	2006-06-05 15:14:16.000000000 +1000
@@ -19,7 +19,7 @@
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
 #define SA_PROBEIRQ		0x08000000
-
+#define SA_BOOTMEM		0x02000000
 /*
  * As above, these correspond to the IORESOURCE_IRQ_* defines in
  * linux/ioport.h to select the interrupt line behaviour.  When
Index: linux-work/kernel/irq/manage.c
===================================================================
--- linux-work.orig/kernel/irq/manage.c	2006-05-31 11:26:45.000000000 +1000
+++ linux-work/kernel/irq/manage.c	2006-06-05 15:34:27.000000000 +1000
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
+#include <linux/bootmem.h>
 
 #include "internals.h"
 
@@ -206,7 +207,7 @@ int setup_irq(unsigned int irq, struct i
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
+	if ((new->flags & SA_SAMPLE_RANDOM) && !(new->flags & SA_BOOTMEM)) {
 		/*
 		 * This function might sleep, we want to call it first,
 		 * outside of the atomic block.
@@ -363,7 +364,8 @@ void free_irq(unsigned int irq, void *de
 
 			/* Make sure it's not being used on another CPU */
 			synchronize_irq(irq);
-			kfree(action);
+			if (!(action->flags & SA_BOOTMEM))
+				kfree(action);
 			return;
 		}
 		printk(KERN_ERR "Trying to free free IRQ%d\n", irq);
@@ -424,7 +426,10 @@ int request_irq(unsigned int irq,
 	if (!handler)
 		return -EINVAL;
 
-	action = kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
+	if (irqflags & SA_BOOTMEM)
+		action = alloc_bootmem(sizeof(struct irqaction));
+	else
+		action = kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
 	if (!action)
 		return -ENOMEM;
 



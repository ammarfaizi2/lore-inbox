Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWEERJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWEERJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWEERJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:09:52 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:19406 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751179AbWEERJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:09:46 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <14.420169009@selenic.com>
Subject: [PATCH 13/14] random: Remove SA_SAMPLE_RANDOM from IRQ fastpath
Date: Fri, 05 May 2006 11:42:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SA_SAMPLE_RANDOM

This removes the SA_SAMPLE_RANDOM interface which was not used with
sufficient paranoia and introduced an extra branch test into all IRQ
handling.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/arch/arm/kernel/irq.c
===================================================================
--- 2.6.orig/arch/arm/kernel/irq.c	2006-05-02 17:29:26.000000000 -0500
+++ 2.6/arch/arm/kernel/irq.c	2006-05-03 16:42:56.000000000 -0500
@@ -361,9 +361,6 @@ __do_irq(unsigned int irq, struct irqact
 		action = action->next;
 	} while (action);
 
-	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
-
 	spin_lock_irq(&irq_controller_lock);
 
 	return retval;
@@ -670,17 +667,6 @@ int setup_irq(unsigned int irq, struct i
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
Index: 2.6/arch/arm26/kernel/irq.c
===================================================================
--- 2.6.orig/arch/arm26/kernel/irq.c	2006-04-20 17:01:04.000000000 -0500
+++ 2.6/arch/arm26/kernel/irq.c	2006-05-03 16:42:43.000000000 -0500
@@ -202,9 +202,6 @@ __do_irq(unsigned int irq, struct irqact
 		action = action->next;
 	} while (action);
 
-	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
-
 	spin_lock_irq(&irq_controller_lock);
 }
 
@@ -452,17 +449,6 @@ int setup_irq(unsigned int irq, struct i
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
@@ -530,9 +516,6 @@ int setup_irq(unsigned int irq, struct i
  *	SA_SHIRQ		Interrupt is shared
  *
  *	SA_INTERRUPT		Disable local interrupts while processing
- *
- *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
- *
  */
 
 //FIXME - handler used to return void - whats the significance of the change?
Index: 2.6/arch/frv/kernel/irq-routing.c
===================================================================
--- 2.6.orig/arch/frv/kernel/irq-routing.c	2006-05-02 17:29:26.000000000 -0500
+++ 2.6/arch/frv/kernel/irq-routing.c	2006-05-03 16:42:29.000000000 -0500
@@ -90,8 +90,6 @@ void distribute_irqs(struct irq_group *g
 				action = action->next;
 			} while (action);
 
-			if (status & SA_SAMPLE_RANDOM)
-				add_interrupt_randomness(irq);
 			local_irq_disable();
 		}
 	}
Index: 2.6/arch/frv/kernel/irq.c
===================================================================
--- 2.6.orig/arch/frv/kernel/irq.c	2006-05-02 17:29:26.000000000 -0500
+++ 2.6/arch/frv/kernel/irq.c	2006-05-03 16:42:23.000000000 -0500
@@ -345,9 +345,6 @@ asmlinkage void do_NMI(void)
  *	SA_SHIRQ		Interrupt is shared
  *
  *	SA_INTERRUPT		Disable local interrupts while processing
- *
- *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
- *
  */
 
 int request_irq(unsigned int irq,
@@ -577,17 +574,6 @@ int setup_irq(unsigned int irq, struct i
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
 
 	/* must juggle the interrupt processing stuff with interrupts disabled */
 	spin_lock_irqsave(&level->lock, flags);
Index: 2.6/arch/h8300/kernel/ints.c
===================================================================
--- 2.6.orig/arch/h8300/kernel/ints.c	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/arch/h8300/kernel/ints.c	2006-05-03 16:42:06.000000000 -0500
@@ -158,9 +158,6 @@ int request_irq(unsigned int irq, 
 	irq_handle->devname = devname;
 	irq_list[irq] = irq_handle;
 
-	if (irq_handle->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
 	enable_irq(irq);
 	return 0;
 }
@@ -222,8 +219,6 @@ asmlinkage void process_int(int irq, str
 		if (irq_list[irq]) {
 			irq_list[irq]->handler(irq, irq_list[irq]->dev_id, fp);
 			irq_list[irq]->count++;
-			if (irq_list[irq]->flags & SA_SAMPLE_RANDOM)
-				add_interrupt_randomness(irq);
 		}
 	} else {
 		BUG();
Index: 2.6/arch/h8300/platform/h8s/ints.c
===================================================================
--- 2.6.orig/arch/h8300/platform/h8s/ints.c	2006-04-20 17:01:04.000000000 -0500
+++ 2.6/arch/h8300/platform/h8s/ints.c	2006-05-03 16:41:55.000000000 -0500
@@ -192,9 +192,7 @@ int request_irq(unsigned int irq,
 	irq_handle->dev_id  = dev_id;
 	irq_handle->devname = devname;
 	irq_list[irq] = irq_handle;
-	if (irq_handle->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-	
+
 	/* enable interrupt */
 	/* compatible i386  */
 	if (irq >= EXT_IRQ0 && irq <= EXT_IRQ15)
@@ -270,8 +268,6 @@ asmlinkage void process_int(unsigned lon
 		if (irq_list[vec]) {
 			irq_list[vec]->handler(vec, irq_list[vec]->dev_id, fp);
 			irq_list[vec]->count++;
-			if (irq_list[vec]->flags & SA_SAMPLE_RANDOM)
-				add_interrupt_randomness(vec);
 		}
 	} else {
 		BUG();
Index: 2.6/arch/sparc64/kernel/irq.c
===================================================================
--- 2.6.orig/arch/sparc64/kernel/irq.c	2006-05-02 17:28:42.000000000 -0500
+++ 2.6/arch/sparc64/kernel/irq.c	2006-05-03 16:41:41.000000000 -0500
@@ -437,20 +437,6 @@ int request_irq(unsigned int irq, irqret
 	if (unlikely(!bucket->irq_info))
 		return -ENODEV;
 
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
 
 	if (check_irq_sharing(bucket->pil, irqflags)) {
@@ -673,10 +659,6 @@ static void process_bucket(int irq, stru
 		} else {
 			upa_writel(ICLR_IDLE, bp->iclr);
 		}
-
-		/* Test and add entropy */
-		if (random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
 	}
 out:
 	bp->flags &= ~IBF_INPROGRESS;
Index: 2.6/include/asm-mips/signal.h
===================================================================
--- 2.6.orig/include/asm-mips/signal.h	2006-05-02 17:28:46.000000000 -0500
+++ 2.6/include/asm-mips/signal.h	2006-05-03 16:41:15.000000000 -0500
@@ -107,7 +107,6 @@ typedef unsigned long old_sigset_t;		/* 
  * SA_INTERRUPT is also used by the irq handling routines.
  * SA_SHIRQ flag is for shared interrupt support on PCI and EISA.
  */
-#define SA_SAMPLE_RANDOM	SA_RESTART
 
 #ifdef CONFIG_TRAD_SIGNALS
 #define sig_uses_siginfo(ka)	((ka)->sa.sa_flags & SA_SIGINFO)
Index: 2.6/include/asm-xtensa/signal.h
===================================================================
--- 2.6.orig/include/asm-xtensa/signal.h	2006-05-02 17:29:27.000000000 -0500
+++ 2.6/include/asm-xtensa/signal.h	2006-05-03 16:41:12.000000000 -0500
@@ -118,7 +118,6 @@ typedef struct {
  * SA_INTERRUPT is also used by the irq handling routines.
  * SA_SHIRQ is for shared interrupt support on PCI and EISA.
  */
-#define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
 #define SA_PROBEIRQ		0x08000000
 #endif
Index: 2.6/include/linux/signal.h
===================================================================
--- 2.6.orig/include/linux/signal.h	2006-05-02 17:29:27.000000000 -0500
+++ 2.6/include/linux/signal.h	2006-05-03 16:41:07.000000000 -0500
@@ -16,7 +16,6 @@
  * SA_SHIRQ is for shared interrupt support on PCI and EISA.
  * SA_PROBEIRQ is set by callers when they expect sharing mismatches to occur
  */
-#define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
 #define SA_PROBEIRQ		0x08000000
 
Index: 2.6/kernel/irq/handle.c
===================================================================
--- 2.6.orig/kernel/irq/handle.c	2006-04-20 17:00:51.000000000 -0500
+++ 2.6/kernel/irq/handle.c	2006-05-03 16:41:01.000000000 -0500
@@ -92,8 +92,6 @@ fastcall int handle_IRQ_event(unsigned i
 		action = action->next;
 	} while (action);
 
-	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
 	local_irq_disable();
 
 	return retval;
Index: 2.6/kernel/irq/manage.c
===================================================================
--- 2.6.orig/kernel/irq/manage.c	2006-05-02 17:29:28.000000000 -0500
+++ 2.6/kernel/irq/manage.c	2006-05-03 16:40:55.000000000 -0500
@@ -185,17 +185,6 @@ int setup_irq(unsigned int irq, struct i
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
@@ -364,7 +353,6 @@ EXPORT_SYMBOL(free_irq);
  *
  *	SA_SHIRQ		Interrupt is shared
  *	SA_INTERRUPT		Disable local interrupts while processing
- *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
  *
  */
 int request_irq(unsigned int irq,

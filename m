Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbSI1FsF>; Sat, 28 Sep 2002 01:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262732AbSI1Frf>; Sat, 28 Sep 2002 01:47:35 -0400
Received: from waste.org ([209.173.204.2]:22161 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262725AbSI1FqH>;
	Sat, 28 Sep 2002 01:46:07 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] /dev/random cleanup: 06-update-users
Message-Id: <E17vAVh-0002K5-00@ash>
From: Oliver Xymoron <oxymoron@waste.org>
Date: Sat, 28 Sep 2002 00:51:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the old API and updates users to the new one. This also
allows different input devices of the same class (eg mice) to have
their entropy state tracked independently and removes hardwired source
classes from the core.

diff -urN -x '.patch*' -x '*.orig' orig/arch/alpha/kernel/irq.c work/arch/alpha/kernel/irq.c
--- orig/arch/alpha/kernel/irq.c	2002-09-10 12:07:35.000000000 -0500
+++ work/arch/alpha/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -88,7 +88,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	return status;
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
diff -urN -x '.patch*' -x '*.orig' orig/arch/arm/kernel/irq.c work/arch/arm/kernel/irq.c
--- orig/arch/arm/kernel/irq.c	2002-08-17 00:30:02.000000000 -0500
+++ work/arch/arm/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -200,7 +200,7 @@
 	} while (action);
 
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 
 	spin_lock_irq(&irq_controller_lock);
 }
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
diff -urN -x '.patch*' -x '*.orig' orig/arch/cris/kernel/irq.c work/arch/cris/kernel/irq.c
--- orig/arch/cris/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ work/arch/cris/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -275,7 +275,7 @@
                         action = action->next;
                 } while (action);
                 if (do_random & SA_SAMPLE_RANDOM)
-                        add_interrupt_randomness(irq);
+                        add_timer_randomness(0, irq);
                 local_irq_disable();
         }
         irq_exit(cpu);
@@ -315,9 +315,6 @@
 		shared = 1;
 	}
 
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
 	save_flags(flags);
 	cli();
 	*p = new;
diff -urN -x '.patch*' -x '*.orig' orig/arch/i386/kernel/irq.c work/arch/i386/kernel/irq.c
--- orig/arch/i386/kernel/irq.c	2002-09-10 12:07:35.000000000 -0500
+++ work/arch/i386/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -211,7 +211,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	return status;
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
diff -urN -x '.patch*' -x '*.orig' orig/arch/ia64/kernel/irq.c work/arch/ia64/kernel/irq.c
--- orig/arch/ia64/kernel/irq.c	2002-09-22 10:15:52.000000000 -0500
+++ work/arch/ia64/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -228,7 +228,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	return status;
@@ -747,17 +747,6 @@
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
diff -urN -x '.patch*' -x '*.orig' orig/arch/ia64/kernel/irq_ia64.c work/arch/ia64/kernel/irq_ia64.c
--- orig/arch/ia64/kernel/irq_ia64.c	2002-09-04 11:28:47.000000000 -0500
+++ work/arch/ia64/kernel/irq_ia64.c	2002-09-28 00:16:15.000000000 -0500
@@ -22,7 +22,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/slab.h>
 #include <linux/ptrace.h>
-#include <linux/random.h>	/* for rand_initialize_irq() */
 #include <linux/signal.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
diff -urN -x '.patch*' -x '*.orig' orig/arch/mips/baget/irq.c work/arch/mips/baget/irq.c
--- orig/arch/mips/baget/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ work/arch/mips/baget/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -195,7 +195,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	} else {
 		printk("do_IRQ: Unregistered IRQ (0x%X) occurred\n", irq);
@@ -284,9 +284,6 @@
 		shared = 1;
 	}
 
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
 	save_and_cli(flags);
 	*p = new;
 	restore_flags(flags);
diff -urN -x '.patch*' -x '*.orig' orig/arch/mips/dec/irq.c work/arch/mips/dec/irq.c
--- orig/arch/mips/dec/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ work/arch/mips/dec/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -145,7 +145,7 @@
 	    action = action->next;
 	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-	    add_interrupt_randomness(irq);
+	    add_timer_randomness(0, irq);
 	local_irq_disable();
 	unmask_irq(irq);
     }
@@ -181,8 +181,6 @@
 	} while (old);
 	shared = 1;
     }
-    if (new->flags & SA_SAMPLE_RANDOM)
-	rand_initialize_irq(irq);
 
     save_and_cli(flags);
     *p = new;
diff -urN -x '.patch*' -x '*.orig' orig/arch/mips/kernel/irq.c work/arch/mips/kernel/irq.c
--- orig/arch/mips/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ work/arch/mips/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -122,7 +122,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	irq_exit(cpu, irq);
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
diff -urN -x '.patch*' -x '*.orig' orig/arch/mips/kernel/old-irq.c work/arch/mips/kernel/old-irq.c
--- orig/arch/mips/kernel/old-irq.c	2002-08-17 00:29:50.000000000 -0500
+++ work/arch/mips/kernel/old-irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -192,7 +192,7 @@
 		action = action->next;
        	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 	unmask_irq (irq);
 
@@ -228,7 +228,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	}
 	irq_exit(cpu, irq);
@@ -263,9 +263,6 @@
 		shared = 1;
 	}
 
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
 	save_and_cli(flags);
 	*p = new;
 
diff -urN -x '.patch*' -x '*.orig' orig/arch/mips/philips/nino/irq.c work/arch/mips/philips/nino/irq.c
--- orig/arch/mips/philips/nino/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ work/arch/mips/philips/nino/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -185,7 +185,7 @@
 	    action = action->next;
 	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-	    add_interrupt_randomness(irq);
+	    add_timer_randomness(0, irq);
 	unmask_irq(irq);
 	local_irq_disable();
     } else {
@@ -227,8 +227,6 @@
 	} while (old);
 	shared = 1;
     }
-    if (new->flags & SA_SAMPLE_RANDOM)
-	rand_initialize_irq(irq);
 
     save_and_cli(flags);
     *p = new;
diff -urN -x '.patch*' -x '*.orig' orig/arch/mips64/mips-boards/malta/malta_int.c work/arch/mips64/mips-boards/malta/malta_int.c
--- orig/arch/mips64/mips-boards/malta/malta_int.c	2002-07-20 14:11:29.000000000 -0500
+++ work/arch/mips64/mips-boards/malta/malta_int.c	2002-09-28 00:16:15.000000000 -0500
@@ -247,9 +247,6 @@
 		shared = 1;
 	}
 
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
 	*p = new;
 	if (!shared)
 		enable_irq(irq);
diff -urN -x '.patch*' -x '*.orig' orig/arch/mips64/sgi-ip22/ip22-int.c work/arch/mips64/sgi-ip22/ip22-int.c
--- orig/arch/mips64/sgi-ip22/ip22-int.c	2002-08-17 00:29:50.000000000 -0500
+++ work/arch/mips64/sgi-ip22/ip22-int.c	2002-09-28 00:16:15.000000000 -0500
@@ -315,7 +315,7 @@
 			action = action->next;
 		} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	}
 	irq_exit(cpu, irq);
diff -urN -x '.patch*' -x '*.orig' orig/arch/mips64/sgi-ip27/ip27-irq.c work/arch/mips64/sgi-ip27/ip27-irq.c
--- orig/arch/mips64/sgi-ip27/ip27-irq.c	2002-08-17 00:29:50.000000000 -0500
+++ work/arch/mips64/sgi-ip27/ip27-irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -183,7 +183,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	}
 	irq_exit(thiscpu, irq);
@@ -339,8 +339,6 @@
 		printk("IRQ array overflow %d\n", irq);
 		while(1);
 	}
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
 
 	save_and_cli(flags);
 	p = irq_action + irq;
diff -urN -x '.patch*' -x '*.orig' orig/arch/ppc/kernel/irq.c work/arch/ppc/kernel/irq.c
--- orig/arch/ppc/kernel/irq.c	2002-09-20 11:03:27.000000000 -0500
+++ work/arch/ppc/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -129,17 +129,6 @@
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
@@ -408,7 +397,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 }
 
diff -urN -x '.patch*' -x '*.orig' orig/arch/ppc64/kernel/irq.c work/arch/ppc64/kernel/irq.c
--- orig/arch/ppc64/kernel/irq.c	2002-09-20 11:03:28.000000000 -0500
+++ work/arch/ppc64/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -116,17 +116,6 @@
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
@@ -390,7 +379,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 }
 
diff -urN -x '.patch*' -x '*.orig' orig/arch/sh/kernel/irq.c work/arch/sh/kernel/irq.c
--- orig/arch/sh/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ work/arch/sh/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -138,7 +138,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	irq_exit(cpu, irq);
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
diff -urN -x '.patch*' -x '*.orig' orig/arch/sparc64/kernel/irq.c work/arch/sparc64/kernel/irq.c
--- orig/arch/sparc64/kernel/irq.c	2002-09-04 11:28:48.000000000 -0500
+++ work/arch/sparc64/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
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
@@ -793,7 +779,7 @@
 				upa_writel(ICLR_IDLE, bp->iclr);
 				/* Test and add entropy */
 				if (random)
-					add_interrupt_randomness(irq);
+					add_timer_randomness(0, irq);
 			}
 		} else
 			bp->pending = 1;
diff -urN -x '.patch*' -x '*.orig' orig/arch/um/kernel/irq.c work/arch/um/kernel/irq.c
--- orig/arch/um/kernel/irq.c	2002-09-16 10:49:30.000000000 -0500
+++ work/arch/um/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -155,7 +155,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 
 	local_irq_disable();
 
diff -urN -x '.patch*' -x '*.orig' orig/arch/x86_64/kernel/irq.c work/arch/x86_64/kernel/irq.c
--- orig/arch/x86_64/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ work/arch/x86_64/kernel/irq.c	2002-09-28 00:16:15.000000000 -0500
@@ -450,7 +450,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	irq_exit(0, irq);
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
diff -urN -x '.patch*' -x '*.orig' orig/drivers/acorn/char/mouse_ps2.c work/drivers/acorn/char/mouse_ps2.c
--- orig/drivers/acorn/char/mouse_ps2.c	2002-08-17 00:30:02.000000000 -0500
+++ work/drivers/acorn/char/mouse_ps2.c	2002-09-28 00:16:15.000000000 -0500
@@ -34,6 +34,7 @@
 static int aux_count = 0;
 /* used when we send commands to the mouse that expect an ACK. */
 static unsigned char mouse_reply_expected = 0;
+static struct entropy_source *entropy;
 
 #define MAX_RETRIES	60		/* some aux operations take long time*/
 
@@ -107,7 +108,7 @@
 		mouse_reply_expected = 0;
 	}
 
-	add_mouse_randomness(val);
+	add_timer_randomness(entropy, val);
 	if (aux_count) {
 		int head = queue->head;
 
@@ -271,6 +272,8 @@
 	iomd_writeb(0, IOMD_MSECTL);
 	iomd_writeb(8, IOMD_MSECTL);
   
+	entropy = create_entropy_source(1);
+
 	if (misc_register(&psaux_mouse))
 		return -ENODEV;
 	queue = (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
diff -urN -x '.patch*' -x '*.orig' orig/drivers/block/DAC960.c work/drivers/block/DAC960.c
--- orig/drivers/block/DAC960.c	2002-09-27 22:17:11.000000000 -0500
+++ work/drivers/block/DAC960.c	2002-09-28 00:16:15.000000000 -0500
@@ -3003,7 +3003,7 @@
 	      complete(Command->Completion);
 	      Command->Completion = NULL;
 	    }
-	  add_blkdev_randomness(DAC960_MAJOR + Controller->ControllerNumber);
+	  add_timer_randomness(0, DAC960_MAJOR + Controller->ControllerNumber);
 	}
       else if ((CommandStatus == DAC960_V1_IrrecoverableDataError ||
 		CommandStatus == DAC960_V1_BadDataEncountered) &&
@@ -4109,7 +4109,7 @@
 	      complete(Command->Completion);
 	      Command->Completion = NULL;
 	    }
-	  add_blkdev_randomness(DAC960_MAJOR + Controller->ControllerNumber);
+	  add_timer_randomness(0, DAC960_MAJOR + Controller->ControllerNumber);
 	}
       else if (Command->V2.RequestSense.SenseKey
 	       == DAC960_SenseKey_MediumError &&
diff -urN -x '.patch*' -x '*.orig' orig/drivers/block/floppy.c work/drivers/block/floppy.c
--- orig/drivers/block/floppy.c	2002-09-27 22:17:11.000000000 -0500
+++ work/drivers/block/floppy.c	2002-09-28 00:16:15.000000000 -0500
@@ -2301,7 +2301,7 @@
 
 	if (end_that_request_first(req, uptodate, current_count_sectors))
 		return;
-	add_blkdev_randomness(major(dev));
+	add_timer_randomness(0, (unsigned)req);
 	floppy_off(DEVICE_NR(dev));
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
diff -urN -x '.patch*' -x '*.orig' orig/drivers/char/busmouse.c work/drivers/char/busmouse.c
--- orig/drivers/char/busmouse.c	2002-07-20 14:11:11.000000000 -0500
+++ work/drivers/char/busmouse.c	2002-09-28 00:16:15.000000000 -0500
@@ -47,6 +47,7 @@
 	char			ready;
 	int			dxpos;
 	int			dypos;
+	struct entropy_source	*entropy;
 };
 
 #define NR_MICE			15
@@ -84,7 +85,8 @@
 	changed = (dx != 0 || dy != 0 || mse->buttons != buttons);
 
 	if (changed) {
-		add_mouse_randomness((buttons << 16) + (dy << 8) + dx);
+		add_timer_randomness(mse->entropy, 
+				     (buttons << 16) + (dy << 8) + dx);
 
 		mse->buttons = buttons;
 		mse->dxpos += dx;
@@ -387,6 +389,8 @@
 	mse->lock = (spinlock_t)SPIN_LOCK_UNLOCKED;
 	init_waitqueue_head(&mse->wait);
 
+	mse->entropy = create_entropy_source(1);
+
 	busmouse_data[msedev] = mse;
 
 	ret = misc_register(&mse->miscdev);
@@ -419,13 +423,15 @@
 	}
 
 	down(&mouse_sem);
-	
+
 	if (!busmouse_data[mousedev]) {
 		printk(KERN_WARNING "busmouse: trying to free free mouse"
 		       " on mousedev %d\n", mousedev);
 		goto fail;
 	}
 
+	free_entropy_source(busmouse_data[mousedev].entropy);
+
 	if (busmouse_data[mousedev]->active) {
 		printk(KERN_ERR "busmouse: trying to free active mouse"
 		       " on mousedev %d\n", mousedev);
diff -urN -x '.patch*' -x '*.orig' orig/drivers/char/hp_psaux.c work/drivers/char/hp_psaux.c
--- orig/drivers/char/hp_psaux.c	2002-07-20 14:12:22.000000000 -0500
+++ work/drivers/char/hp_psaux.c	2002-09-28 00:16:15.000000000 -0500
@@ -182,6 +182,8 @@
 static void lasi_ps2_init_hw(void)
 {
 	++inited;
+
+	entropy = create_entropy_source(1);
 }
 
 
@@ -205,6 +207,7 @@
 static spinlock_t	kbd_controller_lock = SPIN_LOCK_UNLOCKED;
 static unsigned char	mouse_reply_expected;
 static int 		aux_count;
+static struct entropy_source *entropy;
 
 static int fasync_aux(int fd, struct file *filp, int on)
 {
@@ -233,7 +236,7 @@
 		return;
 	}
 
-	add_mouse_randomness(scancode);
+	add_timer_randomness(entropy, scancode);
 	if (aux_count) {
 		int head = queue->head;
 				
@@ -509,6 +512,8 @@
 		if (!queue)
 			return -ENOMEM;
 
+		entropy = create_entropy_source(1);
+
 		memset(queue, 0, sizeof(*queue));
 		queue->head = queue->tail = 0;
 		init_waitqueue_head(&queue->proc_list);
diff -urN -x '.patch*' -x '*.orig' orig/drivers/char/keyboard.c work/drivers/char/keyboard.c
--- orig/drivers/char/keyboard.c	2002-09-16 10:49:33.000000000 -0500
+++ work/drivers/char/keyboard.c	2002-09-28 00:16:15.000000000 -0500
@@ -132,6 +132,7 @@
 static unsigned char diacr;
 static char rep;					/* flag telling character repeat */
 
+static struct entropy_source *entropy;
 static unsigned char ledstate = 0xff;			/* undefined */
 static unsigned char ledioctl;
 
@@ -994,7 +995,7 @@
 	int shift_final;
 
 	if (down != 2)
-		add_keyboard_randomness((keycode << 1) ^ down);
+		add_timer_randomness(entropy, (keycode << 1) ^ down);
 
 	tty = vc->vc_tty;
 
@@ -1186,6 +1187,8 @@
 {
 	int i;
 
+	entropy = create_entropy_source(1);
+
         kbd0.ledflagstate = kbd0.default_ledflagstate = KBD_DEFLEDS;
         kbd0.ledmode = LED_SHOW_FLAGS;
         kbd0.lockstate = KBD_DEFLOCK;
diff -urN -x '.patch*' -x '*.orig' orig/drivers/char/qtronix.c work/drivers/char/qtronix.c
--- orig/drivers/char/qtronix.c	2002-07-20 14:11:13.000000000 -0500
+++ work/drivers/char/qtronix.c	2002-09-28 00:16:15.000000000 -0500
@@ -93,6 +93,7 @@
 struct cir_port *cir;
 static unsigned char kbdbytes[5];
 static unsigned char cir_data[32]; /* we only need 16 chars */
+static struct entropy_source *entropy;
 
 static void kbd_int_handler(int irq, void *dev_id, struct pt_regs *regs);
 static int handle_data(unsigned char *p_data);
@@ -153,6 +154,7 @@
 				cir->port, IT8172_CIR0_IRQ);
 	}
 #ifdef CONFIG_PSMOUSE
+	entropy = create_entropy_source(1);
 	psaux_init();
 #endif
 }
@@ -441,7 +443,7 @@
 		return;
 	}
 
-	add_mouse_randomness(scancode);
+	add_timer_randomness(entropy, scancode);
 	if (aux_count) {
 		int head = queue->head;
 
diff -urN -x '.patch*' -x '*.orig' orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2002-09-28 00:16:15.000000000 -0500
+++ work/drivers/char/random.c	2002-09-28 00:16:15.000000000 -0500
@@ -673,8 +673,6 @@
 	kfree(src);
 }
 
-static struct entropy_source *generic_kbd, *generic_mouse;
-
 static unsigned long last_ctxt=0, last_jiffies=0;
 static int trust_break=50, trust_pct=0, trust_min=0, trust_max=100;
 
@@ -745,27 +743,6 @@
 	batch_entropy_store(num^time, entropy);
 }
 
-void add_keyboard_randomness(unsigned char scancode)
-{
-	/* autorepeat ignored based on coarse timing */
-	add_timer_randomness(generic_kbd, scancode);
-}
-
-void add_mouse_randomness(__u32 mouse_data)
-{
-	add_timer_randomness(generic_mouse, mouse_data);
-}
-
-void add_interrupt_randomness(int irq)
-{
-	add_timer_randomness(0, irq);
-}
-
-void add_blkdev_randomness(int major)
-{
-	add_timer_randomness(0, 0x200+major);
-}
-
 /******************************************************************
  *
  * Hash function definition
@@ -1354,16 +1331,6 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(input_pool);
 #endif
-	generic_kbd = create_entropy_source(1);
-	generic_mouse = create_entropy_source(1);
-}
-
-void rand_initialize_irq(int irq)
-{
-}
-
-void rand_initialize_blkdev(int major, int mode)
-{
 }
 
 static ssize_t
@@ -2196,10 +2163,6 @@
 EXPORT_SYMBOL(create_entropy_source);
 EXPORT_SYMBOL(free_entropy_source);
 EXPORT_SYMBOL(add_timer_randomness);
-EXPORT_SYMBOL(add_keyboard_randomness);
-EXPORT_SYMBOL(add_mouse_randomness);
-EXPORT_SYMBOL(add_interrupt_randomness);
-EXPORT_SYMBOL(add_blkdev_randomness);
 EXPORT_SYMBOL(batch_entropy_store);
 EXPORT_SYMBOL(generate_random_uuid);
 
diff -urN -x '.patch*' -x '*.orig' orig/drivers/ide/ide.c work/drivers/ide/ide.c
--- orig/drivers/ide/ide.c	2002-09-27 22:17:12.000000000 -0500
+++ work/drivers/ide/ide.c	2002-09-28 00:16:15.000000000 -0500
@@ -153,6 +153,7 @@
 #include <linux/cdrom.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
+#include <linux/random.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -406,7 +407,7 @@
 	}
 
 	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
-		add_blkdev_randomness(major(rq->rq_dev));
+		add_timer_randomness(0, (unsigned)rq);
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
diff -urN -x '.patch*' -x '*.orig' orig/drivers/input/input.c work/drivers/input/input.c
--- orig/drivers/input/input.c	2002-09-16 10:49:33.000000000 -0500
+++ work/drivers/input/input.c	2002-09-28 00:16:15.000000000 -0500
@@ -66,7 +66,7 @@
 	if (type > EV_MAX || !test_bit(type, dev->evbit))
 		return;
 
-	add_mouse_randomness((type << 4) ^ code ^ (code >> 4) ^ value);
+	add_timer_randomness(dev->entropy, (type << 4) ^ code ^ value);
 
 	switch (type) {
 
@@ -411,6 +411,7 @@
 	dev->timer.function = input_repeat_key;
 	dev->rep[REP_DELAY] = HZ/4;
 	dev->rep[REP_PERIOD] = HZ/33;
+	dev->entropy = create_entropy_source(1);
 
 	INIT_LIST_HEAD(&dev->h_list);
 	list_add_tail(&dev->node,&input_dev_list);
diff -urN -x '.patch*' -x '*.orig' orig/drivers/s390/block/dasd.c work/drivers/s390/block/dasd.c
--- orig/drivers/s390/block/dasd.c	2002-09-10 12:07:37.000000000 -0500
+++ work/drivers/s390/block/dasd.c	2002-09-28 00:16:15.000000000 -0500
@@ -1481,7 +1481,7 @@
 {
 	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
 		BUG();
-	add_blkdev_randomness(major(req->rq_dev));
+	add_timer_randomness(0, (unsigned)req);
 	end_that_request_last(req);
 	return;
 }
diff -urN -x '.patch*' -x '*.orig' orig/drivers/s390/char/tapeblock.c work/drivers/s390/char/tapeblock.c
--- orig/drivers/s390/char/tapeblock.c	2002-09-27 22:17:12.000000000 -0500
+++ work/drivers/s390/char/tapeblock.c	2002-09-28 00:16:15.000000000 -0500
@@ -254,9 +254,6 @@
 	bh->b_end_io (bh, uptodate);
     }
     if (!end_that_request_first (td->blk_data.current_request, uptodate, "tBLK")) {
-#ifndef DEVICE_NO_RANDOM
-	add_blkdev_randomness (MAJOR (td->blk_data.current_request->rq_dev));
-#endif
 	end_that_request_last (td->blk_data.current_request);
     }
     if (treq!=NULL) {
diff -urN -x '.patch*' -x '*.orig' orig/drivers/scsi/scsi_lib.c work/drivers/scsi/scsi_lib.c
--- orig/drivers/scsi/scsi_lib.c	2002-09-20 11:03:33.000000000 -0500
+++ work/drivers/scsi/scsi_lib.c	2002-09-28 00:16:15.000000000 -0500
@@ -333,7 +333,7 @@
 		return SCpnt;
 	}
 
-	add_blkdev_randomness(major(req->rq_dev));
+	add_timer_randomness(0, (unsigned)req);
 
 	spin_lock_irqsave(q->queue_lock, flags);
 
diff -urN -x '.patch*' -x '*.orig' orig/include/linux/blk.h work/include/linux/blk.h
--- orig/include/linux/blk.h	2002-07-20 14:11:33.000000000 -0500
+++ work/include/linux/blk.h	2002-09-28 00:16:15.000000000 -0500
@@ -8,7 +8,6 @@
 #include <linux/compiler.h>
 
 extern void set_device_ro(kdev_t dev,int flag);
-extern void add_blkdev_randomness(int major);
 
 #ifdef CONFIG_BLK_DEV_RAM
 
@@ -83,12 +82,14 @@
  * If we have our own end_request, we do not want to include this mess
  */
 #ifndef LOCAL_END_REQUEST
+extern void add_timer_randomness(void *src, int datum);
+
 static inline void end_request(struct request *req, int uptodate)
 {
 	if (end_that_request_first(req, uptodate, req->hard_cur_sectors))
 		return;
 
-	add_blkdev_randomness(major(req->rq_dev));
+	add_timer_randomness(0, (unsigned)req);
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 }
diff -urN -x '.patch*' -x '*.orig' orig/include/linux/input.h work/include/linux/input.h
--- orig/include/linux/input.h	2002-09-04 11:28:43.000000000 -0500
+++ work/include/linux/input.h	2002-09-28 00:16:15.000000000 -0500
@@ -785,6 +785,7 @@
 
 	unsigned int repeat_key;
 	struct timer_list timer;
+	struct entropy_source *entropy;
 
 	struct pm_dev *pm_dev;
 	int state;
diff -urN -x '.patch*' -x '*.orig' orig/include/linux/random.h work/include/linux/random.h
--- orig/include/linux/random.h	2002-09-28 00:16:14.000000000 -0500
+++ work/include/linux/random.h	2002-09-28 00:16:15.000000000 -0500
@@ -43,8 +43,6 @@
 #ifdef __KERNEL__
 
 extern void rand_initialize(void);
-extern void rand_initialize_irq(int irq);
-extern void rand_initialize_blkdev(int irq, int mode);
 
 extern void batch_entropy_store(u32 val, int bits);
 
@@ -52,10 +50,6 @@
 extern struct entropy_source *create_entropy_source(int granularity_khz);
 extern void free_entropy_source(struct entropy_source *src);
 extern void add_timer_randomness(struct entropy_source *src, unsigned num);
-extern void add_keyboard_randomness(unsigned char scancode);
-extern void add_mouse_randomness(__u32 mouse_data);
-extern void add_interrupt_randomness(int irq);
-extern void add_blkdev_randomness(int major);
 
 extern void get_random_bytes(void *buf, int nbytes);
 void generate_random_uuid(unsigned char uuid_out[16]);

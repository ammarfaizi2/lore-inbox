Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318805AbSHRC0F>; Sat, 17 Aug 2002 22:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318806AbSHRC0F>; Sat, 17 Aug 2002 22:26:05 -0400
Received: from waste.org ([209.173.204.2]:44757 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318805AbSHRCZv>;
	Sat, 17 Aug 2002 22:25:51 -0400
Date: Sat, 17 Aug 2002 21:29:49 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (3/4) SA_RANDOM user fixup
Message-ID: <20020818022949.GD21643@waste.org>
References: <20020818021522.GA21643@waste.org> <20020818022308.GB21643@waste.org> <20020818022657.GC21643@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818022657.GC21643@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Users of the SA_RANDOM irq flag are moved to the new untrusted entropy
interface. It is now possible to safely add timing samples from
network devices.

diff -ur a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
--- a/arch/alpha/kernel/irq.c	2002-08-17 00:30:02.000000000 -0500
+++ b/arch/alpha/kernel/irq.c	2002-08-17 02:07:10.000000000 -0500
@@ -88,7 +88,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timing_entropy(0, irq);
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
diff -ur a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
--- a/arch/arm/kernel/irq.c	2002-08-17 00:30:02.000000000 -0500
+++ b/arch/arm/kernel/irq.c	2002-08-17 02:06:30.000000000 -0500
@@ -200,7 +200,7 @@
 	} while (action);
 
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timing_entropy(0, irq);
 
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
diff -ur a/arch/cris/kernel/irq.c b/arch/cris/kernel/irq.c
--- a/arch/cris/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/cris/kernel/irq.c	2002-08-17 02:07:42.000000000 -0500
@@ -275,7 +275,7 @@
                         action = action->next;
                 } while (action);
                 if (do_random & SA_SAMPLE_RANDOM)
-                        add_interrupt_randomness(irq);
+                        add_timing_entropy(0, irq);
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
diff -ur a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2002-08-17 00:29:58.000000000 -0500
+++ b/arch/i386/kernel/irq.c	2002-08-17 02:07:50.000000000 -0500
@@ -212,7 +212,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timing_entropy(0, irq);
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
diff -ur a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
--- a/arch/ia64/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/ia64/kernel/irq.c	2002-08-17 02:07:04.000000000 -0500
@@ -497,7 +497,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timing_entropy(0, irq);
 	local_irq_disable();
 
 	local_irq_exit(irq);
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
+++ b/arch/ia64/kernel/irq_ia64.c	2002-08-17 02:08:50.000000000 -0500
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
+++ b/arch/mips/baget/irq.c	2002-08-17 02:07:15.000000000 -0500
@@ -195,7 +195,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timing_entropy(0, irq);
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
diff -ur a/arch/mips/dec/irq.c b/arch/mips/dec/irq.c
--- a/arch/mips/dec/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips/dec/irq.c	2002-08-17 02:07:38.000000000 -0500
@@ -145,7 +145,7 @@
 	    action = action->next;
 	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-	    add_interrupt_randomness(irq);
+	    add_timing_entropy(0, irq);
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
diff -ur a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
--- a/arch/mips/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips/kernel/irq.c	2002-08-17 02:07:34.000000000 -0500
@@ -122,7 +122,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timing_entropy(0, irq);
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
diff -ur a/arch/mips/kernel/old-irq.c b/arch/mips/kernel/old-irq.c
--- a/arch/mips/kernel/old-irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips/kernel/old-irq.c	2002-08-17 02:07:28.000000000 -0500
@@ -192,7 +192,7 @@
 		action = action->next;
        	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timing_entropy(0, irq);
 	local_irq_disable();
 	unmask_irq (irq);
 
@@ -228,7 +228,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timing_entropy(0, irq);
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
 
diff -ur a/arch/mips/philips/nino/irq.c b/arch/mips/philips/nino/irq.c
--- a/arch/mips/philips/nino/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips/philips/nino/irq.c	2002-08-17 02:07:20.000000000 -0500
@@ -185,7 +185,7 @@
 	    action = action->next;
 	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-	    add_interrupt_randomness(irq);
+	    add_timing_entropy(0, irq);
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
diff -ur a/arch/mips64/mips-boards/malta/malta_int.c b/arch/mips64/mips-boards/malta/malta_int.c
--- a/arch/mips64/mips-boards/malta/malta_int.c	2002-07-20 14:11:29.000000000 -0500
+++ b/arch/mips64/mips-boards/malta/malta_int.c	2002-08-17 02:06:12.000000000 -0500
@@ -247,9 +247,6 @@
 		shared = 1;
 	}
 
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
 	*p = new;
 	if (!shared)
 		enable_irq(irq);
diff -ur a/arch/mips64/sgi-ip22/ip22-int.c b/arch/mips64/sgi-ip22/ip22-int.c
--- a/arch/mips64/sgi-ip22/ip22-int.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips64/sgi-ip22/ip22-int.c	2002-08-17 02:05:16.000000000 -0500
@@ -315,7 +315,7 @@
 			action = action->next;
 		} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timing_entropy(0, irq);
 		local_irq_disable();
 	}
 	irq_exit(cpu, irq);
diff -ur a/arch/mips64/sgi-ip27/ip27-irq.c b/arch/mips64/sgi-ip27/ip27-irq.c
--- a/arch/mips64/sgi-ip27/ip27-irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips64/sgi-ip27/ip27-irq.c	2002-08-17 02:06:17.000000000 -0500
@@ -183,7 +183,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timing_entropy(0, irq);
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
diff -ur a/arch/ppc/kernel/irq.c b/arch/ppc/kernel/irq.c
--- a/arch/ppc/kernel/irq.c	2002-08-17 00:30:02.000000000 -0500
+++ b/arch/ppc/kernel/irq.c	2002-08-17 02:08:08.000000000 -0500
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
@@ -412,7 +401,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timing_entropy(0, irq);
 	local_irq_disable();
 }
 
diff -ur a/arch/ppc64/kernel/irq.c b/arch/ppc64/kernel/irq.c
--- a/arch/ppc64/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/ppc64/kernel/irq.c	2002-08-17 02:06:37.000000000 -0500
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
@@ -396,7 +385,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timing_entropy(0, irq);
 	local_irq_disable();
 }
 
diff -ur a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
--- a/arch/sh/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/sh/kernel/irq.c	2002-08-17 02:06:04.000000000 -0500
@@ -138,7 +138,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timing_entropy(0, irq);
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
diff -ur a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
--- a/arch/sparc64/kernel/irq.c	2002-08-17 00:30:02.000000000 -0500
+++ b/arch/sparc64/kernel/irq.c	2002-08-17 02:08:01.000000000 -0500
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
+					add_timing_entropy(0, irq);
 			}
 		} else
 			bp->pending = 1;
diff -ur a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/x86_64/kernel/irq.c	2002-08-17 02:06:24.000000000 -0500
@@ -450,7 +450,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timing_entropy(0, irq);
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


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261469AbTCGJ5k>; Fri, 7 Mar 2003 04:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbTCGJ5k>; Fri, 7 Mar 2003 04:57:40 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:18322
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261469AbTCGJ5T>; Fri, 7 Mar 2003 04:57:19 -0500
Date: Fri, 7 Mar 2003 05:05:49 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] protect 'action' in show_interrupts
In-Reply-To: <20030306233517.68c922f9.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50.0303070502400.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
 <20030306222328.14b5929c.akpm@digeo.com>
 <Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
 <20030306233517.68c922f9.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch protects a critical section in show_interrupts against 
removal of 'action' during traversal of the handlers. All the 
architectures in one swoop.

Index: linux-2.5.64/arch/alpha/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/alpha/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/alpha/kernel/irq.c	5 Mar 2003 05:08:08 -0000	1.1.1.1
+++ linux-2.5.64/arch/alpha/kernel/irq.c	7 Mar 2003 09:11:01 -0000
@@ -515,6 +515,7 @@
 #endif
 	int i;
 	struct irqaction * action;
+	unsigned long flags;
 
 #ifdef CONFIG_SMP
 	seq_puts(p, "           ");
@@ -537,16 +538,23 @@
 				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		if (!action)
+			goto unlock;
+
 		seq_printf(p, "  %c%s",
-			     (action->flags & SA_INTERRUPT)?'+':' ',
-			     action->name);
+			(action->flags & SA_INTERRUPT)?'+':' ',
+			action->name);
 
 		for (action=action->next; action; action = action->next) {
 			seq_printf(p, ", %c%s",
-				     (action->flags & SA_INTERRUPT)?'+':' ',
-				     action->name);
+				  (action->flags & SA_INTERRUPT)?'+':' ',
+				   action->name);
 		}
+
+unlock:
 		seq_putc(p, '\n');
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	}
 #if CONFIG_SMP
 	seq_puts(p, "IPI: ");
Index: linux-2.5.64/arch/arm/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/arm/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/arm/kernel/irq.c	5 Mar 2003 05:08:11 -0000	1.1.1.1
+++ linux-2.5.64/arch/arm/kernel/irq.c	7 Mar 2003 08:49:53 -0000
@@ -165,17 +165,22 @@
 {
 	int i;
 	struct irqaction * action;
+	unsigned long flags;
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
 	    	action = irq_desc[i].action;
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
 		if (!action)
-			continue;
+			goto unlock;
+
 		seq_printf(p, "%3d: %10u ", i, kstat_irqs(i));
 		seq_printf(p, "  %s", action->name);
-		for (action = action->next; action; action = action->next) {
+		for (action = action->next; action; action = action->next)
 			seq_printf(p, ", %s", action->name);
-		}
+
 		seq_putc(p, '\n');
+unlock:
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	}
 
 #ifdef CONFIG_ARCH_ACORN
Index: linux-2.5.64/arch/cris/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/cris/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/cris/kernel/irq.c	5 Mar 2003 05:08:09 -0000	1.1.1.1
+++ linux-2.5.64/arch/cris/kernel/irq.c	7 Mar 2003 09:09:08 -0000
@@ -228,11 +228,14 @@
 {
 	int i;
 	struct irqaction * action;
+	unsigned long flags;
 
 	for (i = 0; i < NR_IRQS; i++) {
 		action = irq_action[i];
+
+		local_irq_save(flags);
 		if (!action) 
-			continue;
+			goto skip;
 		seq_printf(p, "%2d: %10u %c %s",
 			i, kstat_cpu(0).irqs[i],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -243,6 +246,8 @@
 				action->name);
 		}
 		seq_putc(p, '\n');
+skip:
+		local_irq_restore(flags);
 	}
 	return 0;
 }
Index: linux-2.5.64/arch/i386/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/i386/kernel/irq.c	5 Mar 2003 05:08:03 -0000	1.1.1.1
+++ linux-2.5.64/arch/i386/kernel/irq.c	7 Mar 2003 09:04:43 -0000
 static void register_irq_proc (unsigned int irq);
@@ -135,6 +135,7 @@
 {
 	int i, j;
 	struct irqaction * action;
+	unsigned long flags;
 
 	seq_printf(p, "           ");
 	for (j=0; j<NR_CPUS; j++)
@@ -156,11 +157,17 @@
 					     kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		if (!action)
+			goto unlock;
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
 			seq_printf(p, ", %s", action->name);
+
+unlock:
 		seq_putc(p, '\n');
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	}
 	seq_printf(p, "NMI: ");
 	for (j = 0; j < NR_CPUS; j++)
Index: linux-2.5.64/arch/ia64/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/ia64/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/ia64/kernel/irq.c	5 Mar 2003 05:08:13 -0000	1.1.1.1
+++ linux-2.5.64/arch/ia64/kernel/irq.c	7 Mar 2003 08:41:09 -0000
@@ -154,6 +154,7 @@
 	int i, j;
 	struct irqaction * action;
 	irq_desc_t *idesc;
+	unsigned long flags;
 
 	seq_puts(p, "           ");
 	for (j=0; j<NR_CPUS; j++)
@@ -175,10 +176,13 @@
 				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", idesc->handler->typename);
-		seq_printf(p, "  %s", action->name);
-
-		for (action=action->next; action; action = action->next)
-			seq_printf(p, ", %s", action->name);
+		spin_lock_irqsave(&idesc->lock, flags);
+		if (action) {
+			seq_printf(p, "  %s", action->name);
+			for (action=action->next; action; action = action->next)
+				seq_printf(p, ", %s", action->name);
+		}
+		spin_unlock_irqrestore(&idesc->lock, flags);
 		seq_putc(p, '\n');
 	}
 	seq_puts(p, "NMI: ");
Index: linux-2.5.64/arch/mips/baget/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips/baget/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/mips/baget/irq.c	5 Mar 2003 05:08:09 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips/baget/irq.c	7 Mar 2003 09:48:06 -0000
@@ -146,11 +146,13 @@
 {
 	int i;
 	struct irqaction * action;
+	unsigned long flags;
 
 	for (i = 0 ; i < BAGET_IRQ_NR ; i++) {
 		action = irq_action[i];
+		local_irq_save(flags);
 		if (!action) 
-			continue;
+			goto skip;
 		seq_printf(p, "%2d: %8d %c %s",
 			i, kstat_cpu(0).irqs[i],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -161,6 +163,8 @@
 				action->name);
 		}
 		seq_putc(p, '\n');
+skip:
+		local_irq_restore(flags);
 	}
 	return 0;
 }
Index: linux-2.5.64/arch/mips/dec/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips/dec/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/mips/dec/irq.c	5 Mar 2003 05:08:09 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips/dec/irq.c	7 Mar 2003 09:47:41 -0000
@@ -97,11 +97,13 @@
 {
 	int i;
 	struct irqaction *action;
+	unsigned long flags;
 
 	for (i = 0; i < 32; i++) {
 		action = irq_action[i];
+		local_irq_save(flags);
 		if (!action)
-			continue;
+			goto skip;
 		seq_printf(p, "%2d: %8d %c %s",
 				i, kstat_cpu(0).irqs[i],
 				(action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -112,6 +114,8 @@
 				action->name);
 		}
 		seq_putc(p, '\n');
+skip:
+		local_irq_restore(flags);
 	}
 	return 0;
 }
Index: linux-2.5.64/arch/mips/ite-boards/generic/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips/ite-boards/generic/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/mips/ite-boards/generic/irq.c	5 Mar 2003 05:08:09 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips/ite-boards/generic/irq.c	7 Mar 2003 09:25:42 -0000
@@ -222,6 +222,7 @@
 {
         int i, j;
         struct irqaction * action;
+	unsigned long flags;
 
         seq_printf(p, "           ");
         for (j=0; j<smp_num_cpus; j++)
@@ -230,6 +231,7 @@
 
         for (i = 0 ; i < NR_IRQS ; i++) {
                 action = irq_desc[i].action;
+
                 if ( !action || !action->handler )
                         continue;
                 seq_printf(p, "%3d: ", i);		
@@ -238,11 +240,17 @@
                         seq_printf(p, " %s ", irq_desc[i].handler->typename );
                 else
                         seq_puts(p, "  None      ");
+
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		if (!action)
+			goto unlock;
                 seq_printf(p, "    %s",action->name);
                 for (action=action->next; action; action = action->next) {
                         seq_printf(p, ", %s", action->name);
                 }
+unlock:
                 seq_putc(p, '\n');
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
         }
         seq_printf(p, "BAD: %10lu\n", spurious_count);
         return 0;
Index: linux-2.5.64/arch/mips/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/mips/kernel/irq.c	5 Mar 2003 05:08:09 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips/kernel/irq.c	7 Mar 2003 09:27:16 -0000
@@ -73,8 +73,9 @@
 int show_interrupts(struct seq_file *p, void *v)
 {
 	struct irqaction * action;
+	unsigned long flags;
 	int i;
-
+	
 	seq_puts(p, "           ");
 	for (i=0; i < 1 /*smp_num_cpus*/; i++)
 		seq_printf(p, "CPU%d       ", i);
@@ -82,8 +83,9 @@
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
 		action = irq_desc[i].action;
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
 		if (!action) 
-			continue;
+			goto unlock;
 		seq_printf(p, "%3d: ",i);
 		seq_printf(p, "%10u ", kstat_irqs(i));
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
@@ -92,6 +94,8 @@
 		for (action=action->next; action; action = action->next)
 			seq_printf(p, ", %s", action->name);
 		seq_putc(p, '\n');
+unlock:
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	}
 	seq_printf(p, "ERR: %10lu\n", irq_err_count);
 	return 0;
Index: linux-2.5.64/arch/mips/kernel/old-irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips/kernel/old-irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 old-irq.c
--- linux-2.5.64/arch/mips/kernel/old-irq.c	5 Mar 2003 05:08:09 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips/kernel/old-irq.c	7 Mar 2003 09:45:07 -0000
@@ -128,11 +128,13 @@
 {
 	int i;
 	struct irqaction * action;
+	unsigned long flags;
 
 	for (i = 0 ; i < 32 ; i++) {
 		action = irq_action[i];
+		local_irq_save(flags);
 		if (!action) 
-			continue;
+			goto skip;
 		seq_printf(p, "%2d: %8d %c %s",
 			i, kstat_cpu(0).irqs[i],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -143,6 +145,8 @@
 				action->name);
 		}
 		seq_putc(p, '\n');
+skip:
+		local_irq_restore(flags);
 	}
 	return 0;
 }
Index: linux-2.5.64/arch/mips/mips-boards/atlas/atlas_int.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips/mips-boards/atlas/atlas_int.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 atlas_int.c
--- linux-2.5.64/arch/mips/mips-boards/atlas/atlas_int.c	5 Mar 2003 05:08:09 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips/mips-boards/atlas/atlas_int.c	7 Mar 2003 09:30:36 -0000
@@ -99,11 +99,13 @@
 	int i;
 	int num = 0;
 	struct irqaction *action;
+	unsigned long flags;
 
 	for (i = 0; i < ATLASINT_END; i++, num++) {
 		action = irq_desc[i].action;
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
 		if (!action) 
-			continue;
+			goto unlock;
 		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat_cpu(0).irqs[num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -114,6 +116,8 @@
 				action->name);
 		}
 		seq_printf(p, " [hw0]\n");
+unlock:
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	}
 	return 0;
 }
Index: linux-2.5.64/arch/mips/philips/nino/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips/philips/nino/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/mips/philips/nino/irq.c	5 Mar 2003 05:08:09 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips/philips/nino/irq.c	7 Mar 2003 09:46:43 -0000
@@ -119,11 +119,13 @@
 {
     int i;
     struct irqaction *action;
+    unsigned long flags;
 
     for (i = 0; i < NR_IRQS; i++) {
 	action = irq_action[i];
+	local_irq_save(flags);
 	if (!action)
-	    continue;
+	    goto skip;
 	seq_printf(p, "%2d: %8d %c %s",
 		       i, kstat_cpu(0).irqs[i],
 		       (action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -134,6 +136,8 @@
 			   action->name);
 	}
 	seq_putc(p, '\n');
+skip:
+	local_irq_restore(flags);
     }
     return 0;
 }
Index: linux-2.5.64/arch/mips64/mips-boards/atlas/atlas_int.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips64/mips-boards/atlas/atlas_int.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 atlas_int.c
--- linux-2.5.64/arch/mips64/mips-boards/atlas/atlas_int.c	5 Mar 2003 05:08:15 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips64/mips-boards/atlas/atlas_int.c	7 Mar 2003 09:33:55 -0000
@@ -95,11 +95,13 @@
 	int i;
 	int num = 0;
 	struct irqaction *action;
+	unsigned long flags;
 
 	for (i = 0; i < ATLASINT_END; i++, num++) {
 		action = irq_desc[i].action;
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
 		if (!action) 
-			continue;
+			goto unlock;
 		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat_cpu(0).irqs[num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -110,6 +112,8 @@
 				action->name);
 		}
 		seq_puts(p, " [hw0]\n");
+unlock:
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	}
 	return 0;
 }
Index: linux-2.5.64/arch/mips64/mips-boards/malta/malta_int.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips64/mips-boards/malta/malta_int.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 malta_int.c
--- linux-2.5.64/arch/mips64/mips-boards/malta/malta_int.c	5 Mar 2003 05:08:15 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips64/mips-boards/malta/malta_int.c	7 Mar 2003 09:44:50 -0000
@@ -125,11 +125,13 @@
 	int i;
 	int num = 0;
 	struct irqaction *action;
+	unsigned long flags;
 
 	for (i = 0; i < 8; i++, num++) {
 		action = irq_action[i];
+		local_irq_save(flags);
 		if (!action) 
-			continue;
+			goto skip_1;
 		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat_cpu(0).irqs[num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -140,11 +142,14 @@
 				action->name);
 		}
 		seq_puts(p, " [on-chip]\n");
+skip_1:
+		local_irq_restore(flags);
 	}
 	for (i = 0; i < MALTAINT_END; i++, num++) {
 		action = hw0_irq_action[i];
+		local_irq_save(flags);
 		if (!action) 
-			continue;
+			goto skip_2;
 		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat_cpu(0).irqs[num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -155,6 +160,8 @@
 				action->name);
 		}
 		seq_puts(p, " [hw0]\n");
+skip_2:
+		local_irq_restore(flags);
 	}
 	return 0;
 }
Index: linux-2.5.64/arch/mips64/sgi-ip22/ip22-int.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips64/sgi-ip22/ip22-int.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ip22-int.c
--- linux-2.5.64/arch/mips64/sgi-ip22/ip22-int.c	5 Mar 2003 05:08:15 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips64/sgi-ip22/ip22-int.c	7 Mar 2003 09:41:57 -0000
@@ -237,11 +237,13 @@
 	int i;
 	int num = 0;
 	struct irqaction * action;
+	unsigned long flags;
 
 	for (i = 0 ; i < 16 ; i++, num++) {
 		action = irq_action[i];
+		local_irq_save(flags);
 		if (!action) 
-			continue;
+			goto skip_1;
 		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat_cpu(0).irqs[num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -252,11 +254,14 @@
 				action->name);
 		}
 		seq_puts(p, " [on-chip]\n");
+skip_1:
+		local_irq_restore(flags);
 	}
 	for (i = 0 ; i < 24 ; i++, num++) {
 		action = local_irq_action[i];
+		local_irq_save(flags);
 		if (!action) 
-			continue;
+			goto skip_2;
 		seq_printf(p, "%2d: %8d %c %s",
 			num, kstat_cpu(0).irqs[num],
 			(action->flags & SA_INTERRUPT) ? '+' : ' ',
@@ -267,6 +272,8 @@
 				action->name);
 		}
 		seq_puts(p, " [local]\n");
+skip_2:
+		local_irq_restore(flags);
 	}
 	return 0;
 }
Index: linux-2.5.64/arch/mips64/sgi-ip27/ip27-irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/mips64/sgi-ip27/ip27-irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ip27-irq.c
--- linux-2.5.64/arch/mips64/sgi-ip27/ip27-irq.c	5 Mar 2003 05:08:15 -0000	1.1.1.1
+++ linux-2.5.64/arch/mips64/sgi-ip27/ip27-irq.c	7 Mar 2003 09:43:16 -0000
@@ -141,11 +141,13 @@
 {
 	int i;
 	struct irqaction * action;
+	unsigned long flags;
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
 		action = irq_action[i];
+		local_irq_save(flags);
 		if (!action) 
-			continue;
+			goto skip;
 		seq_printf(p, "%2d: %8d %c %s", i, kstat_cpu(0).irqs[i],
 		               (action->flags & SA_INTERRUPT) ? '+' : ' ',
 		               action->name);
@@ -156,6 +158,8 @@
 			                action->name);
 		}
 		seq_putc(p, '\n');
+skip:
+		local_irq_restore(flags);
 	}
 	return 0;
 }
Index: linux-2.5.64/arch/ppc/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/ppc/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/ppc/kernel/irq.c	5 Mar 2003 05:08:03 -0000	1.1.1.1
+++ linux-2.5.64/arch/ppc/kernel/irq.c	7 Mar 2003 08:43:48 -0000
@@ -346,6 +346,7 @@
 {
 	int i, j;
 	struct irqaction * action;
+	unsigned long flags;
 
 	seq_puts(p, "           ");
 	for (j=0; j<NR_CPUS; j++)
@@ -371,9 +372,13 @@
 		else
 			seq_puts(p, "  None      ");
 		seq_printf(p, "%s", (irq_desc[i].status & IRQ_LEVEL) ? "Level " : "Edge  ");
-		seq_printf(p, "    %s", action->name);
-		for (action = action->next; action; action = action->next)
-			seq_printf(p, ", %s", action->name);
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		if (action) {
+			seq_printf(p, "    %s", action->name);
+			for (action = action->next; action; action = action->next)
+				seq_printf(p, ", %s", action->name);
+		}
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 		seq_putc(p, '\n');
 	}
 #ifdef CONFIG_TAU_INT
Index: linux-2.5.64/arch/ppc64/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/ppc64/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/ppc64/kernel/irq.c	5 Mar 2003 05:08:10 -0000	1.1.1.1
+++ linux-2.5.64/arch/ppc64/kernel/irq.c	7 Mar 2003 08:45:10 -0000
@@ -341,6 +341,7 @@
 {
 	int i, j;
 	struct irqaction * action;
+	unsigned long flags;
 
 	seq_printf(p, "           ");
 	for (j=0; j<NR_CPUS; j++) {
@@ -367,9 +368,13 @@
 		else
 			seq_printf(p, "  None      ");
 		seq_printf(p, "%s", (irq_desc[i].status & IRQ_LEVEL) ? "Level " : "Edge  ");
-		seq_printf(p, "    %s",action->name);
-		for (action=action->next; action; action = action->next)
-			seq_printf(p, ", %s", action->name);
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		if (action) {
+			seq_printf(p, "    %s",action->name);
+			for (action=action->next; action; action = action->next)
+				seq_printf(p, ", %s", action->name);
+		}
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 		seq_putc(p, '\n');
 	}
 	seq_printf(p, "BAD: %10u\n", ppc_spurious_interrupts);
Index: linux-2.5.64/arch/sh/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/sh/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/sh/kernel/irq.c	5 Mar 2003 05:08:16 -0000	1.1.1.1
+++ linux-2.5.64/arch/sh/kernel/irq.c	7 Mar 2003 09:06:38 -0000
@@ -90,6 +90,7 @@
 {
 	int i, j;
 	struct irqaction * action;
+	unsigned long flags;
 
 	seq_puts(p, "           ");
 	for (j=0; j<smp_num_cpus; j++)
@@ -98,8 +99,9 @@
 
 	for (i = 0 ; i < ACTUAL_NR_IRQS ; i++) {
 		action = irq_desc[i].action;
-		if (!action) 
-			continue;
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		if (!action)
+			goto unlock;
 		seq_printf(p, "%3d: ",i);
 		seq_printf(p, "%10u ", kstat_irqs(i));
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
@@ -108,6 +110,8 @@
 		for (action=action->next; action; action = action->next)
 			seq_printf(p, ", %s", action->name);
 		seq_putc(p, '\n');
+unlock:
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	}
 	return 0;
 }
Index: linux-2.5.64/arch/v850/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/v850/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/v850/kernel/irq.c	5 Mar 2003 05:08:16 -0000	1.1.1.1
+++ linux-2.5.64/arch/v850/kernel/irq.c	7 Mar 2003 09:05:29 -0000
@@ -78,6 +78,7 @@
 {
 	int i;
 	struct irqaction * action;
+	unsigned long flags;
 
 	seq_puts(p, "           ");
 	for (i=0; i < 1 /*smp_num_cpus*/; i++)
@@ -108,11 +109,16 @@
 			seq_printf(p, " %*s%d", 14 - prec, type_name, num);
 		} else
 			seq_printf(p, " %14s", type_name);
+		spin_lock_irqsave(&irq_desc[j].lock, flags);
+		if (!action)
+			goto unlock;
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
 			seq_printf(p, ", %s", action->name);
+unlock:
 		seq_putc(p, '\n');
+		spin_unlock_irqrestore(&irq_desc[j].lock, flags);
 	}
 	seq_printf(p, "ERR: %10lu\n", irq_err_count);
 	return 0;
Index: linux-2.5.64/arch/x86_64/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/x86_64/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.64/arch/x86_64/kernel/irq.c	5 Mar 2003 05:08:16 -0000	1.1.1.1
+++ linux-2.5.64/arch/x86_64/kernel/irq.c	7 Mar 2003 09:05:00 -0000
@@ -135,6 +135,7 @@
 {
 	int i, j;
 	struct irqaction * action;
+	unsigned long flags;
 
 	seq_printf(p, "           ");
 	for (j=0; j<NR_CPUS; j++)
@@ -156,11 +157,17 @@
 				kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
+
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		if (!action)
+			goto unlock;
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
 			seq_printf(p, ", %s", action->name);
+unlock:
 		seq_putc(p, '\n');
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	}
 	seq_printf(p, "NMI: ");
 	for (j = 0; j < NR_CPUS; j++)

-- 
function.linuxpower.ca

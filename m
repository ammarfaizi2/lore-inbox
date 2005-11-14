Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVKNHeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVKNHeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 02:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVKNHeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 02:34:46 -0500
Received: from mgate03.necel.com ([203.180.232.83]:30369 "EHLO
	mgate03.necel.com") by vger.kernel.org with ESMTP id S1750951AbVKNHej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 02:34:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Fix show_interrupts
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
From: Miles Bader <miles@gnu.org>
Message-Id: <20051114073404.111CD3A4@dhapc248.dev.necel.com>
Date: Mon, 14 Nov 2005 16:34:04 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A variable was being used in multiple conflicting ways.
I also restructured the code a bit for clarity.

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/irq.c |   81 ++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff -ruN -X../cludes linux-2.6.14-uc0/arch/v850/kernel/irq.c linux-2.6.14-uc0-v850-20051109/arch/v850/kernel/irq.c
--- linux-2.6.14-uc0/arch/v850/kernel/irq.c	2005-11-07 15:06:27.839751000 +0900
+++ linux-2.6.14-uc0-v850-20051109/arch/v850/kernel/irq.c	2005-11-09 11:19:31.202877000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/irq.c -- High-level interrupt handling
  *
- *  Copyright (C) 2001,02,03,04  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03,04  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,04,05  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,04,05  Miles Bader <miles@gnu.org>
  *  Copyright (C) 1994-2000  Ralf Baechle
  *  Copyright (C) 1992  Linus Torvalds
  *
@@ -84,50 +84,55 @@
 
 int show_interrupts(struct seq_file *p, void *v)
 {
-	int i = *(loff_t *) v;
-	struct irqaction * action;
-	unsigned long flags;
+	int irq = *(loff_t *) v;
 
-	if (i == 0) {
+	if (irq == 0) {
+		int cpu;
 		seq_puts(p, "           ");
-		for (i=0; i < 1 /*smp_num_cpus*/; i++)
-			seq_printf(p, "CPU%d       ", i);
+		for (cpu=0; cpu < 1 /*smp_num_cpus*/; cpu++)
+			seq_printf(p, "CPU%d       ", cpu);
 		seq_putc(p, '\n');
 	}
 
-	if (i < NR_IRQS) {
-		int j, count, num;
-		const char *type_name = irq_desc[i].handler->typename;
-		spin_lock_irqsave(&irq_desc[j].lock, flags);
-		action = irq_desc[i].action;
-		if (!action) 
-			goto skip;
-
-		count = 0;
-		num = -1;
-		for (j = 0; j < NR_IRQS; j++)
-			if (irq_desc[j].handler->typename == type_name) {
-				if (i == j)
-					num = count;
-				count++;
-			}
+	if (irq < NR_IRQS) {
+		unsigned long flags;
+		struct irqaction *action;
 
-		seq_printf(p, "%3d: ",i);
-		seq_printf(p, "%10u ", kstat_irqs(i));
-		if (count > 1) {
-			int prec = (num >= 100 ? 3 : num >= 10 ? 2 : 1);
-			seq_printf(p, " %*s%d", 14 - prec, type_name, num);
-		} else
-			seq_printf(p, " %14s", type_name);
+		spin_lock_irqsave(&irq_desc[irq].lock, flags);
+
+		action = irq_desc[irq].action;
+		if (action) {
+			int j;
+			int count = 0;
+			int num = -1;
+			const char *type_name = irq_desc[irq].handler->typename;
+
+			for (j = 0; j < NR_IRQS; j++)
+				if (irq_desc[j].handler->typename == type_name){
+					if (irq == j)
+						num = count;
+					count++;
+				}
+
+			seq_printf(p, "%3d: ",irq);
+			seq_printf(p, "%10u ", kstat_irqs(irq));
+			if (count > 1) {
+				int prec = (num >= 100 ? 3 : num >= 10 ? 2 : 1);
+				seq_printf(p, " %*s%d", 14 - prec,
+					   type_name, num);
+			} else
+				seq_printf(p, " %14s", type_name);
 		
-		seq_printf(p, "  %s", action->name);
-		for (action=action->next; action; action = action->next)
-			seq_printf(p, ", %s", action->name);
-		seq_putc(p, '\n');
-skip:
-		spin_unlock_irqrestore(&irq_desc[j].lock, flags);
-	} else if (i == NR_IRQS)
+			seq_printf(p, "  %s", action->name);
+			for (action=action->next; action; action = action->next)
+				seq_printf(p, ", %s", action->name);
+			seq_putc(p, '\n');
+		}
+
+		spin_unlock_irqrestore(&irq_desc[irq].lock, flags);
+	} else if (irq == NR_IRQS)
 		seq_printf(p, "ERR: %10lu\n", irq_err_count);
+
 	return 0;
 }
 

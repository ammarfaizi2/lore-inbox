Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbTKMRgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 12:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbTKMRgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 12:36:32 -0500
Received: from vena.lwn.net ([206.168.112.25]:15812 "HELO lwn.net")
	by vger.kernel.org with SMTP id S264356AbTKMRg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 12:36:27 -0500
Message-ID: <20031113173626.12557.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] seq_file version of /proc/interrupts
From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 13 Nov 2003 10:36:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I was messing with the seq_file document, I went ahead and hacked up
an implementation of /proc/interrupts.  This will be a first pass; if
nothing else, it breaks every architecture except i386.  Fixing the others
should not be hard, though I can't test them.  I've also misplaced my
100-CPU system somewhere, so I can't verify that it solves the initial
problem.  But it should.

This version should scale to something over 300 processors, after which it
will not be possible to fit even a single line of /proc/interrupts output
into one page.  At that point, if this output format is even remotely
useful, some sort of iterator which tracks interrupt and CPU numbers will
be needed.

This is against -test9, but it should apply just as well against current
BK. 

jon

diff -urN -X dontdiff test9-vanilla/arch/i386/kernel/irq.c test9/arch/i386/kernel/irq.c
--- test9-vanilla/arch/i386/kernel/irq.c	Tue Oct 28 01:47:40 2003
+++ test9/arch/i386/kernel/irq.c	Fri Nov 14 00:37:28 2003
@@ -136,62 +136,106 @@
  * Generic, controller-independent functions:
  */
 
-int show_interrupts(struct seq_file *p, void *v)
+
+/*
+ * Seq_file /proc/interrupts implementation.
+ */
+static void *int_seq_start(struct seq_file *f, loff_t *pos)
+{
+	return (*pos <= NR_IRQS) ? pos : NULL;
+}
+
+static void *int_seq_next(struct seq_file *f, void *v, loff_t *pos)
 {
-	int i, j;
-	struct irqaction * action;
+	(*pos)++;
+	if (*pos > NR_IRQS)
+		return NULL;
+	return pos;
+}
+
+static void int_seq_stop(struct seq_file *f, void *v)
+{
+	/* Nothing to do */
+}
+
+static int int_seq_show(struct seq_file *f, void *v)
+{
+	int irq = *(int *) v, cpu;
 	unsigned long flags;
+	struct irqaction *action;
+
+	/* Put in a header before IRQ 0 */
+	if (irq == 0) {
+		seq_printf(f, "           ");
+		for (cpu = 0; cpu < NR_CPUS; cpu++)
+			if (cpu_online(cpu))
+				seq_printf(f, "CPU%d       ", cpu);
+		seq_putc(f, '\n');
+	}
 
-	seq_printf(p, "           ");
-	for (j=0; j<NR_CPUS; j++)
-		if (cpu_online(j))
-			seq_printf(p, "CPU%d       ",j);
-	seq_putc(p, '\n');
-
-	for (i = 0 ; i < NR_IRQS ; i++) {
-		spin_lock_irqsave(&irq_desc[i].lock, flags);
-		action = irq_desc[i].action;
-		if (!action) 
-			goto skip;
-		seq_printf(p, "%3d: ",i);
+	if (irq < NR_IRQS) {
+		spin_lock_irqsave(&irq_desc[irq].lock, flags);
+		action = irq_desc[irq].action;
+		if (action) {
+			seq_printf(f, "%3d: ", irq);
 #ifndef CONFIG_SMP
-		seq_printf(p, "%10u ", kstat_irqs(i));
+			seq_printf(f, "%10u ", kstat_irqs(irq));
 #else
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+			for (cpu = 0; cpu < NR_CPUS; cpu++)
+				if (cpu_online(cpu))
+					seq_printf(f, "%10u ", kstat_cpu(cpu).irqs[irq]);
 #endif
-		seq_printf(p, " %14s", irq_desc[i].handler->typename);
-		seq_printf(p, "  %s", action->name);
+			seq_printf(f, " %14s", irq_desc[irq].handler->typename);
+			seq_printf(f, "  %s", action->name);
 
-		for (action=action->next; action; action = action->next)
-			seq_printf(p, ", %s", action->name);
+			for (action = action->next; action; action = action->next)
+				seq_printf(f, ", %s", action->name);
 
-		seq_putc(p, '\n');
-skip:
-		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
+			seq_putc(f, '\n');
+		}
+		spin_unlock_irqrestore(&irq_desc[irq].lock, flags);
+		return 0;
 	}
-	seq_printf(p, "NMI: ");
-	for (j = 0; j < NR_CPUS; j++)
-		if (cpu_online(j))
-			seq_printf(p, "%10u ", nmi_count(j));
-	seq_putc(p, '\n');
+
+	/* One last "slot" at the end for misc info */
+	if (irq == NR_IRQS) {
+		seq_printf(f, "NMI: ");
+		for (cpu = 0; cpu < NR_CPUS; cpu++)
+			if (cpu_online(cpu))
+				seq_printf(f, "%10u ", nmi_count(cpu));
+		seq_putc(f, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
-	seq_printf(p, "LOC: ");
-	for (j = 0; j < NR_CPUS; j++)
-		if (cpu_online(j))
-			seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
-	seq_putc(p, '\n');
+		seq_printf(f, "LOC: ");
+		for (cpu = 0; cpu < NR_CPUS; cpu++)
+			if (cpu_online(cpu))
+				seq_printf(f, "%10u ", irq_stat[cpu].apic_timer_irqs);
+		seq_putc(f, '\n');
 #endif
-	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
+		seq_printf(f, "ERR: %10u\n", atomic_read(&irq_err_count));
 #ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
-	seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
+		seq_printf(f, "MIS: %10u\n", atomic_read(&irq_mis_count));
 #endif
 #endif
+	}
+	else
+		return -EINVAL;  /* "should never happen" */
 	return 0;
 }
 
+static struct seq_operations int_seq_ops = {
+	.start = int_seq_start,
+	.next  = int_seq_next,
+	.stop  = int_seq_stop,
+	.show  = int_seq_show
+};
+		
+int interrupts_open(struct inode *inode, struct file *filp)
+{
+	return seq_open(filp, &int_seq_ops);
+}
+
+
 #ifdef CONFIG_SMP
 inline void synchronize_irq(unsigned int irq)
 {
diff -urN -X dontdiff test9-vanilla/fs/proc/proc_misc.c test9/fs/proc/proc_misc.c
--- test9-vanilla/fs/proc/proc_misc.c	Tue Sep 30 00:49:20 2003
+++ test9/fs/proc/proc_misc.c	Fri Nov 14 00:38:00 2003
@@ -473,30 +473,12 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-extern int show_interrupts(struct seq_file *p, void *v);
-static int interrupts_open(struct inode *inode, struct file *file)
-{
-	unsigned size = 4096 * (1 + num_online_cpus() / 8);
-	char *buf = kmalloc(size, GFP_KERNEL);
-	struct seq_file *m;
-	int res;
-
-	if (!buf)
-		return -ENOMEM;
-	res = single_open(file, show_interrupts, NULL);
-	if (!res) {
-		m = file->private_data;
-		m->buf = buf;
-		m->size = size;
-	} else
-		kfree(buf);
-	return res;
-}
+extern int interrupts_open(struct inode *, struct file *); /* In arch code */
 static struct file_operations proc_interrupts_operations = {
 	.open		= interrupts_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= seq_release,
 };
 
 static int filesystems_read_proc(char *page, char **start, off_t off,
Binary files test9-vanilla/scripts/bin2c and test9/scripts/bin2c differ

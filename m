Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTKMVjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 16:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbTKMVjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 16:39:49 -0500
Received: from vena.lwn.net ([206.168.112.25]:64460 "HELO lwn.net")
	by vger.kernel.org with SMTP id S264432AbTKMVjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 16:39:31 -0500
Message-ID: <20031113213927.27114.qmail@lwn.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_file version of /proc/interrupts 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Thu, 13 Nov 2003 19:35:12 GMT."
             <20031113193512.GH24159@parcelfarce.linux.theplanet.co.uk> 
Date: Thu, 13 Nov 2003 14:39:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What the hell?  You *do* realize that seq_read() will increase the buffer
> size if it can't fit the single entry into the current buffer, don't you?

Why, of course I do...now...  Obviously I had missed that before.  That's
cool, no ~300-processor limit.  Just make sure you get a really wide screen
with that monster system.

> You don't *have* to preallocate buffer - it makes sense to do if you know
> that one page will be too tight anyway, but it's not required.

My patch doesn't do any preallocation, didn't seem worthwhile.  A 500
processor system will have the resources to do that performance-critical
/proc/interrupts service twice anyway :).

Here, anyway, is a better version of the patch.  It's less intrusive,
forgoes some "cleanups" I indulged in the first time, and makes it easier
to update other architectures.  I did x86-64, ia_64 and ppc64 just for the
heck of it, but I can't test them.

jon

diff -urN -X dontdiff test9-vanilla/arch/i386/kernel/irq.c test9/arch/i386/kernel/irq.c
--- test9-vanilla/arch/i386/kernel/irq.c	Tue Oct 28 01:47:40 2003
+++ test9/arch/i386/kernel/irq.c	Fri Nov 14 05:11:29 2003
@@ -138,17 +138,19 @@
 
 int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, j;
+	int i = *(int *) v, j;
 	struct irqaction * action;
 	unsigned long flags;
 
-	seq_printf(p, "           ");
-	for (j=0; j<NR_CPUS; j++)
-		if (cpu_online(j))
-			seq_printf(p, "CPU%d       ",j);
-	seq_putc(p, '\n');
+	if (i == 0) {
+		seq_printf(p, "           ");
+		for (j=0; j<NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "CPU%d       ",j);
+		seq_putc(p, '\n');
+	}
 
-	for (i = 0 ; i < NR_IRQS ; i++) {
+	if (i < NR_IRQS) {
 		spin_lock_irqsave(&irq_desc[i].lock, flags);
 		action = irq_desc[i].action;
 		if (!action) 
@@ -170,28 +172,32 @@
 		seq_putc(p, '\n');
 skip:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
-	}
-	seq_printf(p, "NMI: ");
-	for (j = 0; j < NR_CPUS; j++)
-		if (cpu_online(j))
-			seq_printf(p, "%10u ", nmi_count(j));
-	seq_putc(p, '\n');
+	} else if (i == NR_IRQS) {
+		seq_printf(p, "NMI: ");
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ", nmi_count(j));
+		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
-	seq_printf(p, "LOC: ");
-	for (j = 0; j < NR_CPUS; j++)
-		if (cpu_online(j))
-			seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
-	seq_putc(p, '\n');
+		seq_printf(p, "LOC: ");
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
+		seq_putc(p, '\n');
 #endif
-	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
+		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 #ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
-	seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
+		seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
 #endif
 #endif
+	}
 	return 0;
 }
 
+
+
+
 #ifdef CONFIG_SMP
 inline void synchronize_irq(unsigned int irq)
 {
diff -urN -X dontdiff test9-vanilla/arch/ia64/kernel/irq.c test9/arch/ia64/kernel/irq.c
--- test9-vanilla/arch/ia64/kernel/irq.c	Tue Oct 28 01:47:40 2003
+++ test9/arch/ia64/kernel/irq.c	Fri Nov 14 05:04:21 2003
@@ -160,18 +160,20 @@
 
 int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, j;
+	int j, i = *(int *) v;
 	struct irqaction * action;
 	irq_desc_t *idesc;
 	unsigned long flags;
 
-	seq_puts(p, "           ");
-	for (j=0; j<NR_CPUS; j++)
-		if (cpu_online(j))
-			seq_printf(p, "CPU%d       ",j);
-	seq_putc(p, '\n');
+	if (i == 0) {
+		seq_puts(p, "           ");
+		for (j=0; j<NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "CPU%d       ",j);
+		seq_putc(p, '\n');
+	}
 
-	for (i = 0 ; i < NR_IRQS ; i++) {
+	if (i < NR_IRQS) {
 		idesc = irq_descp(i);
 		spin_lock_irqsave(&idesc->lock, flags);
 		action = idesc->action;
@@ -194,25 +196,26 @@
 		seq_putc(p, '\n');
 skip:
 		spin_unlock_irqrestore(&idesc->lock, flags);
-	}
-	seq_puts(p, "NMI: ");
-	for (j = 0; j < NR_CPUS; j++)
-		if (cpu_online(j))
-			seq_printf(p, "%10u ", nmi_count(j));
-	seq_putc(p, '\n');
+	} else if (i == NR_IRQS) {
+		seq_puts(p, "NMI: ");
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ", nmi_count(j));
+		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
-	seq_puts(p, "LOC: ");
-	for (j = 0; j < NR_CPUS; j++)
-		if (cpu_online(j))
-			seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
-	seq_putc(p, '\n');
+		seq_puts(p, "LOC: ");
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
+		seq_putc(p, '\n');
 #endif
-	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
+		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 #ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
-	seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
+		seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
 #endif
 #endif
+	}
 	return 0;
 }
 
diff -urN -X dontdiff test9-vanilla/arch/ppc64/kernel/irq.c test9/arch/ppc64/kernel/irq.c
--- test9-vanilla/arch/ppc64/kernel/irq.c	Tue Oct 21 04:40:13 2003
+++ test9/arch/ppc64/kernel/irq.c	Fri Nov 14 05:10:02 2003
@@ -323,18 +323,20 @@
 
 int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, j;
+	int i = *(int *) v, j;
 	struct irqaction * action;
 	unsigned long flags;
 
-	seq_printf(p, "           ");
-	for (j=0; j<NR_CPUS; j++) {
-		if (cpu_online(j))
-			seq_printf(p, "CPU%d       ",j);
+	if (i == 0) {
+		seq_printf(p, "           ");
+		for (j=0; j<NR_CPUS; j++) {
+			if (cpu_online(j))
+				seq_printf(p, "CPU%d       ",j);
+		}
+		seq_putc(p, '\n');
 	}
-	seq_putc(p, '\n');
-
-	for (i = 0 ; i < NR_IRQS ; i++) {
+
+	if (i < NR_IRQS) {
 		spin_lock_irqsave(&irq_desc[i].lock, flags);
 		action = irq_desc[i].action;
 		if (!action || !action->handler)
@@ -359,8 +361,8 @@
 		seq_putc(p, '\n');
 skip:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
-	}
-	seq_printf(p, "BAD: %10u\n", ppc_spurious_interrupts);
+	} else if (i == NR_IRQS)
+		seq_printf(p, "BAD: %10u\n", ppc_spurious_interrupts);
 	return 0;
 }
 
diff -urN -X dontdiff test9-vanilla/arch/x86_64/kernel/irq.c test9/arch/x86_64/kernel/irq.c
--- test9-vanilla/arch/x86_64/kernel/irq.c	Sat Oct 11 06:00:32 2003
+++ test9/arch/x86_64/kernel/irq.c	Fri Nov 14 05:08:41 2003
@@ -138,17 +138,19 @@
 
 int show_interrupts(struct seq_file *p, void *v)
 {
-	int i, j;
+	int i = *(int *) v, j;
 	struct irqaction * action;
 	unsigned long flags;
 
-	seq_printf(p, "           ");
-	for (j=0; j<NR_CPUS; j++)
-		if (cpu_online(j))
-		seq_printf(p, "CPU%d       ",j);
-	seq_putc(p, '\n');
+	if (i == 0) {
+		seq_printf(p, "           ");
+		for (j=0; j<NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "CPU%d       ",j);
+		seq_putc(p, '\n');
+	}
 
-	for (i = 0 ; i < NR_IRQS ; i++) {
+	if (i < NR_IRQS) {
 		spin_lock_irqsave(&irq_desc[i].lock, flags);
 		action = irq_desc[i].action;
 		if (!action) 
@@ -170,25 +172,26 @@
 		seq_putc(p, '\n');
 skip:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
-	}
-	seq_printf(p, "NMI: ");
-	for (j = 0; j < NR_CPUS; j++)
-		if (cpu_online(j))
-		seq_printf(p, "%10u ", cpu_pda[j].__nmi_count);
-	seq_putc(p, '\n');
+	} else if (i == NR_IRQS) {
+		seq_printf(p, "NMI: ");
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ", cpu_pda[j].__nmi_count);
+		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
-	seq_printf(p, "LOC: ");
-	for (j = 0; j < NR_CPUS; j++)
-		if (cpu_online(j))
-		seq_printf(p, "%10u ", cpu_pda[j].apic_timer_irqs);
-	seq_putc(p, '\n');
+		seq_printf(p, "LOC: ");
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ", cpu_pda[j].apic_timer_irqs);
+		seq_putc(p, '\n');
 #endif
-	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
+		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 #ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
-	seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
+		seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
 #endif
 #endif
+	}
 	return 0;
 }
 
diff -urN -X dontdiff test9-vanilla/fs/proc/proc_misc.c test9/fs/proc/proc_misc.c
--- test9-vanilla/fs/proc/proc_misc.c	Tue Sep 30 00:49:20 2003
+++ test9/fs/proc/proc_misc.c	Fri Nov 14 04:55:35 2003
@@ -473,30 +473,46 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-extern int show_interrupts(struct seq_file *p, void *v);
-static int interrupts_open(struct inode *inode, struct file *file)
+/*
+ * /proc/interrupts
+ */
+static void *int_seq_start(struct seq_file *f, loff_t *pos)
 {
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
+	return (*pos <= NR_IRQS) ? pos : NULL;
 }
+
+static void *int_seq_next(struct seq_file *f, void *v, loff_t *pos)
+{
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
+
+extern int show_interrupts(struct seq_file *f, void *v); /* In arch code */
+static struct seq_operations int_seq_ops = {
+	.start = int_seq_start,
+	.next  = int_seq_next,
+	.stop  = int_seq_stop,
+	.show  = show_interrupts
+};
+		
+int interrupts_open(struct inode *inode, struct file *filp)
+{
+	return seq_open(filp, &int_seq_ops);
+}
+
 static struct file_operations proc_interrupts_operations = {
 	.open		= interrupts_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= seq_release,
 };
 
 static int filesystems_read_proc(char *page, char **start, off_t off,


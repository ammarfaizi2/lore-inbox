Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbTHWCDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 22:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTHWCDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 22:03:20 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38080 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261382AbTHWCDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 22:03:13 -0400
Subject: [RFC] [PATCH] linux-2.4.22-rc2_proc-interrupts-fix_A0.patch
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: marcelo <marcelo@conectiva.com.br>, James <jamesclv@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061603986.21563.106.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Aug 2003 18:59:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Recently I've been seeing memory corruption issues related to
/proc/interrupts on a 16way (32x w/ HT) x440. Basically get_irq_list()
does not do any bounds checking on the page it is given, and can easily
overrun the buffer when the cpu and interrupt count is high enough. 

This patch backports the 2.5 seq_file implementation of /proc/interrupts
for CONFIG_X86 (hopefully leaving other arches alone). 

Obviously this is probably a little late in the game for 2.4.22, but I'd
like to get any feedback at all to help expedite its acceptance into
2.4.23-prex. 

thanks
-john

diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Fri Aug 22 18:45:04 2003
+++ b/arch/i386/kernel/irq.c	Fri Aug 22 18:45:05 2003
@@ -32,6 +32,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -131,55 +132,55 @@
  * Generic, controller-independent functions:
  */
 
-int get_irq_list(char *buf)
+int show_interrupts(struct seq_file *p, void *v)
 {
 	int i, j;
 	struct irqaction * action;
-	char *p = buf;
 
-	p += sprintf(p, "           ");
+	seq_printf(p, "           ");
 	for (j=0; j<smp_num_cpus; j++)
-		p += sprintf(p, "CPU%d       ",j);
-	*p++ = '\n';
+		seq_printf(p, "CPU%d       ",j);
+	seq_putc(p,'\n');
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
 		action = irq_desc[i].action;
 		if (!action) 
 			continue;
-		p += sprintf(p, "%3d: ",i);
+		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
-		p += sprintf(p, "%10u ", kstat_irqs(i));
+		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
 		for (j = 0; j < smp_num_cpus; j++)
-			p += sprintf(p, "%10u ",
+			seq_printf(p, "%10u ",
 				kstat.irqs[cpu_logical_map(j)][i]);
 #endif
-		p += sprintf(p, " %14s", irq_desc[i].handler->typename);
-		p += sprintf(p, "  %s", action->name);
+		seq_printf(p, " %14s", irq_desc[i].handler->typename);
+		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
-			p += sprintf(p, ", %s", action->name);
-		*p++ = '\n';
+			seq_printf(p, ", %s", action->name);
+		seq_putc(p,'\n');
 	}
-	p += sprintf(p, "NMI: ");
+	seq_printf(p, "NMI: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		p += sprintf(p, "%10u ",
+		seq_printf(p, "%10u ",
 			nmi_count(cpu_logical_map(j)));
-	p += sprintf(p, "\n");
+	seq_printf(p, "\n");
 #if CONFIG_X86_LOCAL_APIC
-	p += sprintf(p, "LOC: ");
+	seq_printf(p, "LOC: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		p += sprintf(p, "%10u ",
+		seq_printf(p, "%10u ",
 			apic_timer_irqs[cpu_logical_map(j)]);
-	p += sprintf(p, "\n");
+	seq_printf(p, "\n");
 #endif
-	p += sprintf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
+	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 #ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
-	p += sprintf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
+	seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
 #endif
 #endif
-	return p - buf;
+
+	return 0;
 }
 
 
diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Fri Aug 22 18:45:05 2003
+++ b/fs/proc/proc_misc.c	Fri Aug 22 18:45:05 2003
@@ -58,7 +58,9 @@
 extern int get_device_list(char *);
 extern int get_filesystem_list(char *);
 extern int get_exec_domain_list(char *);
+#ifndef CONFIG_X86
 extern int get_irq_list(char *);
+#endif
 extern int get_dma_list(char *);
 extern int get_locks_status (char *, char **, off_t, int);
 extern int get_swaparea_info (char *);
@@ -389,6 +391,7 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+#ifndef CONFIG_X86
 #if !defined(CONFIG_ARCH_S390)
 static int interrupts_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -398,6 +401,60 @@
 }
 #endif
 
+#else /* !CONFIG_X86 */
+static void *single_start(struct seq_file *p, loff_t *pos)
+{
+	return (void *)(*pos == 0);
+}
+
+static void *single_next(struct seq_file *p, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+
+static void single_stop(struct seq_file *p, void *v)
+{
+}
+
+extern int show_interrupts(struct seq_file *p, void *v);
+static struct seq_operations proc_interrupts_op = {
+	start:	single_start,
+	next:	single_next,
+	stop:	single_stop,
+	show:	show_interrupts,
+};
+
+static int interrupts_open(struct inode *inode, struct file *file)
+{
+	unsigned size = PAGE_SIZE * (1 + smp_num_cpus / 8);
+	/*
+	* probably should depend on NR_CPUS, but that's only rough estimate;
+	* if we'll need more it will be given,
+	*/
+	char *buf = kmalloc(size, GFP_KERNEL);
+	struct seq_file *m;
+	int res;
+
+	if (!buf)
+		return -ENOMEM;
+	res = seq_open(file, &proc_interrupts_op);
+	if (!res) {
+		m = file->private_data;
+		m->buf = buf;
+		m->size = size;
+	} else
+		kfree(buf);
+	return res;
+}
+static struct file_operations proc_interrupts_operations = {
+	open:			interrupts_open,
+	read:			seq_read,
+	llseek:			seq_lseek,
+	release:		seq_release,
+};
+#endif /* !CONFIG_X86 */
+
 static int filesystems_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -588,7 +645,7 @@
 #endif
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
-#if !defined(CONFIG_ARCH_S390)
+#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_X86)
 		{"interrupts",	interrupts_read_proc},
 #endif
 		{"filesystems",	filesystems_read_proc},
@@ -614,6 +671,9 @@
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+#if defined(CONFIG_X86)
+	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
+#endif
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 #ifdef CONFIG_MODULES





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTIAH4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTIAH4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:56:35 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:19688 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262738AbTIAH4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:56:17 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Mark Goodwin <markgw@sgi.com>
To: john stultz <johnstul@us.ibm.com>
Cc: marcelo <marcelo@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Mark Goodwin <markgw@sgi.com>
Subject: Re: [PATCH] linux-2.4.23-pre2_proc-interrupts-fix_A1 
In-reply-to: Your message of "30 Aug 2003 12:20:45 MST."
             <1062271244.1312.1429.camel@cog.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Sep 2003 17:55:39 +1000
Message-ID: <8538.1062402939@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Aug 2003 12:20:45 -0700, 
john stultz <johnstul@us.ibm.com> wrote:
>	This patch converts /proc/interrupts to use the seq_file interface on
>i386 (thanks to Randy for adding the seq "single" code). This prevents
>memory corruption caused by /proc/interrupts overflowing its page sized
>buffer on systems with high cpu and interrupt counts. 


This adds the ia64 equivalent.  Marcelo, please apply after John
Stultz's i386 patch.  Unless all architectures convert to seq_file for
/proc/interrupts, fs/proc/proc_misc.c is going to be ugly.


diff -ur -x '*orig' -x '*rej' 2.4.23-pre2-i386/arch/ia64/kernel/irq.c 2.4.23-pre2-ia64/arch/ia64/kernel/irq.c
--- 2.4.23-pre2-i386/arch/ia64/kernel/irq.c	2003-09-01 13:48:18.000000000 +1000
+++ 2.4.23-pre2-ia64/arch/ia64/kernel/irq.c	2003-09-01 17:44:28.000000000 +1000
@@ -152,58 +152,48 @@
  * Generic, controller-independent functions:
  */
 
-int get_irq_list(char *buf)
+static int
+show_interrupts(struct seq_file *p, void *v)
 {
 	int i, j;
 	struct irqaction * action;
 	irq_desc_t *idesc;
-	char *p = buf;
 
-	p += sprintf(p, "           ");
+	seq_printf(p, "           ");
 	for (j=0; j<smp_num_cpus; j++)
-		p += sprintf(p, "CPU%d       ",j);
-	*p++ = '\n';
+		seq_printf(p, "CPU%d       ",j);
+	seq_putc(p,'\n');
 
-	for (i = 0 ; i < NR_IRQS ; i++) {
-		idesc = irq_desc(i);
+	for (i = 0; i < NR_IRQS; i++) {
 		action = idesc->action;
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
-		p += sprintf(p, " %14s", idesc->handler->typename);
-		p += sprintf(p, "  %s", action->name);
+		seq_printf(p, " %14s", irq_desc[i].handler->typename);
+		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
-			p += sprintf(p, ", %s", action->name);
-		*p++ = '\n';
+			seq_printf(p, ", %s", action->name);
+
+		seq_putc(p, '\n');
 	}
-	p += sprintf(p, "NMI: ");
+	seq_printf(p, "NMI: ");
 	for (j = 0; j < smp_num_cpus; j++)
-		p += sprintf(p, "%10u ",
+		seq_printf(p, "%10u ",
 			nmi_count(cpu_logical_map(j)));
-	p += sprintf(p, "\n");
-#if defined(CONFIG_SMP) && defined(CONFIG_X86)
-	p += sprintf(p, "LOC: ");
-	for (j = 0; j < smp_num_cpus; j++)
-		p += sprintf(p, "%10u ",
-			apic_timer_irqs[cpu_logical_map(j)]);
-	p += sprintf(p, "\n");
-#endif
-	p += sprintf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
-#if defined(CONFIG_X86) && defined(CONFIG_X86_IO_APIC) && defined(APIC_MISMATCH_DEBUG)
-	p += sprintf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
-#endif
-	return p - buf;
-}
-
+	seq_putc(p, '\n');
+	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 
+	return 0;
+}
+  
 /*
  * Global interrupt locks for SMP. Allow interrupts to come in on any
  * CPU, yet make cli/sti act globally to protect critical regions..
diff -ur -x '*orig' -x '*rej' 2.4.23-pre2-i386/fs/proc/proc_misc.c 2.4.23-pre2-ia64/fs/proc/proc_misc.c
--- 2.4.23-pre2-i386/fs/proc/proc_misc.c	2003-09-01 13:50:19.000000000 +1000
+++ 2.4.23-pre2-ia64/fs/proc/proc_misc.c	2003-09-01 17:51:41.000000000 +1000
@@ -391,7 +391,7 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-#ifndef CONFIG_X86
+#if !defined(CONFIG_X86) && !defined(CONFIG_IA64)
 #if !defined(CONFIG_ARCH_S390)
 static int interrupts_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -401,9 +401,10 @@
 }
 #endif
 
-#else /* !CONFIG_X86 */
+#else /* !CONFIG_X86 && !CONFIG_IA64 */
 
 extern int show_interrupts(struct seq_file *p, void *v);
+
 static int interrupts_open(struct inode *inode, struct file *file)
 {
 	unsigned size = PAGE_SIZE * (1 + smp_num_cpus / 8);
@@ -422,13 +423,14 @@
 		kfree(buf);
 	return res;
 }
+
 static struct file_operations proc_interrupts_operations = {
 	.open		= interrupts_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-#endif /* !CONFIG_X86 */
+#endif /* !CONFIG_X86 && !CONFIG_IA64 */
 
 static int filesystems_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)


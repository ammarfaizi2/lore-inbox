Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTIACTq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 22:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbTIACTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 22:19:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:40388 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262839AbTIACTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 22:19:42 -0400
Date: Sun, 31 Aug 2003 19:17:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] convert /proc/stat to seq_file
Message-Id: <20030831191739.3fa956b2.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Anton needs this for ppc64.  He has tested it successfully.

It could use testing/feedback from SGI e.g. with > 128 procs.

Would you put this into -mm for further testing?

Thanks,
--
~Randy



patch_name:	proc_stat_seqfile.patch
patch_version:	2003-08-28.13:48:25
author:		Randy.Dunlap and Zwane Mwaikambo
description:	convert /proc/stat to seq_file;
		truncates trailing '0's on the "intr" line;
product:	Linux
product_versions: 260-test4
diffstat:	=
 fs/proc/proc_misc.c |   68 +++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 54 insertions(+), 14 deletions(-)

memory allocation per usage:
	cpus  cpus/32	+1	*4KB
	1-31	0	1	4
	32-63	1	2	8
	64-95	2	3	12
	96-127	3	4	16

diff -Naurp ./fs/proc/proc_misc.c~seq_stats ./fs/proc/proc_misc.c
--- ./fs/proc/proc_misc.c~seq_stats	2003-08-22 16:52:23.000000000 -0700
+++ ./fs/proc/proc_misc.c	2003-08-28 13:47:37.000000000 -0700
@@ -356,10 +356,9 @@ static struct file_operations proc_slabi
 	.release	= seq_release,
 };
 
-static int kstat_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
+int show_stat(struct seq_file *p, void *v)
 {
-	int i, len;
+	int i;
 	extern unsigned long total_forks;
 	u64 jif;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0, irq = 0, softirq = 0;
@@ -379,10 +378,10 @@ static int kstat_read_proc(char *page, c
 	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) - jif;
 	do_div(jif, HZ);
 
-	for (i = 0 ; i < NR_CPUS; i++) {
+	for (i = 0; i < NR_CPUS; i++) {
 		int j;
 
-		if(!cpu_online(i)) continue;
+		if (!cpu_online(i)) continue;
 		user += kstat_cpu(i).cpustat.user;
 		nice += kstat_cpu(i).cpustat.nice;
 		system += kstat_cpu(i).cpustat.system;
@@ -394,7 +393,7 @@ static int kstat_read_proc(char *page, c
 			sum += kstat_cpu(i).irqs[j];
 	}
 
-	len = sprintf(page, "cpu  %u %u %u %u %u %u %u\n",
+	seq_printf(p, "cpu  %u %u %u %u %u %u %u\n",
 		jiffies_to_clock_t(user),
 		jiffies_to_clock_t(nice),
 		jiffies_to_clock_t(system),
@@ -402,9 +401,9 @@ static int kstat_read_proc(char *page, c
 		jiffies_to_clock_t(iowait),
 		jiffies_to_clock_t(irq),
 		jiffies_to_clock_t(softirq));
-	for (i = 0 ; i < NR_CPUS; i++){
+	for (i = 0; i < NR_CPUS; i++){
 		if (!cpu_online(i)) continue;
-		len += sprintf(page + len, "cpu%d %u %u %u %u %u %u %u\n",
+		seq_printf(p, "cpu%d %u %u %u %u %u %u %u\n",
 			i,
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.user),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.nice),
@@ -414,14 +413,25 @@ static int kstat_read_proc(char *page, c
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.irq),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.softirq));
 	}
-	len += sprintf(page + len, "intr %u", sum);
+	seq_printf(p, "intr %u", sum);
 
 #if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
-	for (i = 0 ; i < NR_IRQS ; i++)
-		len += sprintf(page + len, " %u", kstat_irqs(i));
+{
+	static int last_irq = 0;
+	
+	for (i = last_irq; i < NR_IRQS; i++) {
+		if (irq_desc[i].action) {
+			if (i > last_irq)
+				last_irq = i;
+		}
+	}
+
+	for (i = 0; i <= last_irq; i++)
+		seq_printf(p, " %u", kstat_irqs(i));
+}
 #endif
 
-	len += sprintf(page + len,
+	seq_printf(p,
 		"\nctxt %lu\n"
 		"btime %lu\n"
 		"processes %lu\n"
@@ -433,8 +443,38 @@ static int kstat_read_proc(char *page, c
 		nr_running(),
 		nr_iowait());
 
-	return proc_calc_metrics(page, start, off, count, eof, len);
+	return 0;
+}
+
+static int stat_open(struct inode *inode, struct file *file)
+{
+	unsigned size = 4096 * (1 + num_online_cpus() / 32);
+	char *buf;
+	struct seq_file *m;
+	int res;
+
+	/* don't ask for more than the kmalloc() max size, currently 128 KB */
+	if (size > 128 * 1024)
+		size = 128 * 1024;
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	res = single_open(file, show_stat, NULL);
+	if (!res) {
+		m = file->private_data;
+		m->buf = buf;
+		m->size = size;
+	} else
+		kfree(buf);
+	return res;
 }
+static struct file_operations proc_stat_operations = {
+	.open		= stat_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 
 static int devices_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -626,7 +666,6 @@ void __init proc_misc_init(void)
 #ifdef CONFIG_STRAM_PROC
 		{"stram",	stram_read_proc},
 #endif
-		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
 		{"filesystems",	filesystems_read_proc},
 		{"cmdline",	cmdline_read_proc},
@@ -648,6 +687,7 @@ void __init proc_misc_init(void)
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
+	create_seq_entry("stat", 0, &proc_stat_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);

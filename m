Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSIXRa6>; Tue, 24 Sep 2002 13:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSIXRaU>; Tue, 24 Sep 2002 13:30:20 -0400
Received: from d12lmsgate-4.de.ibm.com ([195.212.91.196]:19597 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261735AbSIXRWr> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 24_proc_misc.
Date: Tue, 24 Sep 2002 19:24:35 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241924.35793.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't create /proc/interrupts on s390.

diff -urN linux-2.5.38/drivers/s390/cio/proc.c linux-2.5.38-s390/drivers/s390/cio/proc.c
--- linux-2.5.38/drivers/s390/cio/proc.c	Tue Sep 24 17:41:38 2002
+++ linux-2.5.38-s390/drivers/s390/cio/proc.c	Tue Sep 24 17:53:32 2002
@@ -17,7 +17,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -31,31 +30,6 @@
 
 static int chan_proc_init (void);
 
-int show_interrupts(struct seq_file *p, void *v)
-{
-	int i, j;
-
-	seq_puts(p, "           ");
-
-	for (j=0; j<num_online_cpus(); j++)
-		seq_printf(p, "CPU%d       ",j);
-
-	seq_putc(p, '\n');
-
-	for (i = 0 ; i < NR_IRQS ; i++) {
-		if (ioinfo[i] == INVALID_STORAGE_AREA)
-			continue;
-
-		seq_printf(p, "%3d: ",i);
-		seq_printf(p, "  %s", ioinfo[i]->irq_desc.name);
-
-		seq_putc(p, '\n');
-	
-	} /* endfor */
-
-	return 0;
-}
-
 /* 
  * Display info on subchannels in /proc/subchannels. 
  * Adapted from procfs stuff in dasd.c by Cornelia Huck, 02/28/01.      
diff -urN linux-2.5.38/fs/proc/proc_misc.c linux-2.5.38-s390/fs/proc/proc_misc.c
--- linux-2.5.38/fs/proc/proc_misc.c	Sun Sep 22 06:25:01 2002
+++ linux-2.5.38-s390/fs/proc/proc_misc.c	Tue Sep 24 17:53:32 2002
@@ -418,6 +418,7 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+#if !defined(CONFIG_ARCH_S390)
 extern int show_interrupts(struct seq_file *p, void *v);
 static int interrupts_open(struct inode *inode, struct file *file)
 {
@@ -447,6 +448,7 @@
 	llseek:		seq_lseek,
 	release:	single_release,
 };
+#endif
 
 static int filesystems_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -629,7 +631,9 @@
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
+#if !defined(CONFIG_ARCH_S390)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
+#endif
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319170AbSIKQGv>; Wed, 11 Sep 2002 12:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319173AbSIKQGv>; Wed, 11 Sep 2002 12:06:51 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:10934 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S319170AbSIKQGt> convert rfc822-to-8bit; Wed, 11 Sep 2002 12:06:49 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.34 s390 fixes (2/10): common code changes.
Date: Wed, 11 Sep 2002 18:07:23 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111800.25369.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
the common code changes for s390:
1) correct includes in ibm.c to make it compile.
2) do not create /proc/interrupts for s390.
3) remove call to s390_init_machine_check in init/main.c

blues skies,
  Martin.

diff -urN linux-2.5.34/fs/partitions/ibm.c linux-2.5.34-s390/fs/partitions/ibm.c
--- linux-2.5.34/fs/partitions/ibm.c	Mon Sep  9 19:35:28 2002
+++ linux-2.5.34-s390/fs/partitions/ibm.c	Tue Sep 10 20:25:48 2002
@@ -12,23 +12,16 @@
  */
 
 #include <linux/config.h>
-#include <linux/fs.h>
-#include <linux/genhd.h>
-#include <linux/kernel.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/blk.h>
-#include <linux/slab.h>
+#include <linux/buffer_head.h>
 #include <linux/hdreg.h>
-#include <linux/ioctl.h>
-#include <linux/version.h>
+#include <linux/slab.h>
+#include <asm/dasd.h>
 #include <asm/ebcdic.h>
 #include <asm/uaccess.h>
-#include <asm/dasd.h>
+#include <asm/vtoc.h>
 
-#include "ibm.h"
 #include "check.h"
-#include <asm/vtoc.h>
+#include "ibm.h"
 
 /*
  * compute the block number from a 
diff -urN linux-2.5.34/fs/proc/proc_misc.c linux-2.5.34-s390/fs/proc/proc_misc.c
--- linux-2.5.34/fs/proc/proc_misc.c	Mon Sep  9 19:35:03 2002
+++ linux-2.5.34-s390/fs/proc/proc_misc.c	Tue Sep 10 20:25:48 2002
@@ -411,6 +411,7 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+#if !defined(CONFIG_ARCH_S390)
 extern int show_interrupts(struct seq_file *p, void *v);
 static int interrupts_open(struct inode *inode, struct file *file)
 {
@@ -440,6 +441,7 @@
 	llseek:		seq_lseek,
 	release:	single_release,
 };
+#endif
 
 static int filesystems_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -622,7 +624,9 @@
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
+#if !defined(CONFIG_ARCH_S390)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
+#endif
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
diff -urN linux-2.5.34/init/main.c linux-2.5.34-s390/init/main.c
--- linux-2.5.34/init/main.c	Mon Sep  9 19:35:04 2002
+++ linux-2.5.34-s390/init/main.c	Tue Sep 10 20:25:48 2002
@@ -503,13 +503,6 @@
 	sysctl_init();
 #endif
 
-	/*
-	 * Ok, at this point all CPU's should be initialized, so
-	 * we can start looking into devices..
-	 */
-#if defined(CONFIG_ARCH_S390)
-	s390_init_machine_check();
-#endif
 	/* Networking initialization needs a process context */ 
 	sock_init();
 


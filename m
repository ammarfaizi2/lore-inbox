Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbTILSJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbTILSJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:09:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:63185 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261813AbTILSHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:07:14 -0400
Date: Fri, 12 Sep 2003 11:06:54 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mtrr w/o proc_fs
Message-Id: <20030912110654.4cb0b22b.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of warnings (and dead code) if MTRR is compiled without /proc

diff -Nru a/arch/i386/kernel/cpu/mtrr/if.c b/arch/i386/kernel/cpu/mtrr/if.c
--- a/arch/i386/kernel/cpu/mtrr/if.c	Fri Sep 12 10:57:50 2003
+++ b/arch/i386/kernel/cpu/mtrr/if.c	Fri Sep 12 10:57:50 2003
@@ -13,7 +13,6 @@
 /* RED-PEN: this is accessed without any locking */
 extern unsigned int *usage_table;
 
-static int mtrr_seq_show(struct seq_file *seq, void *offset);
 
 #define FILE_FCOUNT(f) (((struct seq_file *)((f)->private_data))->private)
 
@@ -33,6 +32,8 @@
 	return (x <= 6) ? mtrr_strings[x] : "?";
 }
 
+#ifdef CONFIG_PROC_FS
+
 static int
 mtrr_file_add(unsigned long base, unsigned long size,
 	      unsigned int type, char increment, struct file *file, int page)
@@ -291,6 +292,8 @@
 	return single_release(ino, file);
 }
 
+static int mtrr_seq_show(struct seq_file *seq, void *offset);
+
 static int mtrr_open(struct inode *inode, struct file *file)
 {
 	if (!mtrr_if) 
@@ -310,11 +313,9 @@
 	.release = mtrr_close,
 };
 
-#  ifdef CONFIG_PROC_FS
 
 static struct proc_dir_entry *proc_root_mtrr;
 
-#  endif			/*  CONFIG_PROC_FS  */
 
 static int mtrr_seq_show(struct seq_file *seq, void *offset)
 {
@@ -351,15 +352,14 @@
 
 static int __init mtrr_if_init(void)
 {
-#ifdef CONFIG_PROC_FS
 	proc_root_mtrr =
 	    create_proc_entry("mtrr", S_IWUSR | S_IRUGO, &proc_root);
 	if (proc_root_mtrr) {
 		proc_root_mtrr->owner = THIS_MODULE;
 		proc_root_mtrr->proc_fops = &mtrr_fops;
 	}
-#endif
 	return 0;
 }
 
 arch_initcall(mtrr_if_init);
+#endif			/*  CONFIG_PROC_FS  */

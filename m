Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSL1Fnb>; Sat, 28 Dec 2002 00:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSL1Fnb>; Sat, 28 Dec 2002 00:43:31 -0500
Received: from fmr05.intel.com ([134.134.136.6]:26048 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S265457AbSL1Fn3>; Sat, 28 Dec 2002 00:43:29 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2601AA1376@pdsmsx32.pd.intel.com>
From: "Zhuang, Louis" <louis.zhuang@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'rusty@rustcorp.com.au'" <rusty@rustcorp.com.au>
Subject: [PATCH 2.5.53] [RESEND] add /proc/ksyms
Date: Sat, 28 Dec 2002 13:49:34 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I make the patch independent on CONFIG_MODULE and resend it... Does anybody
want it too?
  - Louis

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	v2.5.53 -> 1.954  
#	 fs/proc/proc_misc.c	1.60    -> 1.62   
#	    kernel/extable.c	1.1     -> 1.2    
#	     kernel/module.c	1.32    -> 1.35   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/23	torvalds@home.transmeta.com	1.951
# Linux v2.5.53
# --------------------------------------------
# 02/12/27	louis@hawk.sh.intel.com	1.952
# add /proc/ksyms
# --------------------------------------------
# 02/12/27	louis@hawk.sh.intel.com	1.953
# module.c:
#   clean code
# --------------------------------------------
# 02/12/28	louis@hawk.sh.intel.com	1.954
# make ksyms independ on CONFIG_MODULE
# --------------------------------------------
#
diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Sat Dec 28 13:35:25 2002
+++ b/fs/proc/proc_misc.c	Sat Dec 28 13:35:25 2002
@@ -299,6 +299,19 @@
 };
 #endif
 
+extern struct seq_operations ksyms_op;
+static int ksyms_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &ksyms_op);
+}
+static struct file_operations proc_ksyms_operations = {
+	.open		= ksyms_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+
 extern struct seq_operations slabinfo_op;
 extern ssize_t slabinfo_write(struct file *, const char *, size_t, loff_t
*);
 static int slabinfo_open(struct inode *inode, struct file *file)
@@ -596,6 +609,7 @@
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
 #endif
+	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
 		proc_root_kcore->proc_fops = &proc_kcore_operations;
diff -Nru a/kernel/extable.c b/kernel/extable.c
--- a/kernel/extable.c	Sat Dec 28 13:35:25 2002
+++ b/kernel/extable.c	Sat Dec 28 13:35:25 2002
@@ -17,6 +17,7 @@
 */
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 
 #include <asm/semaphore.h>
 
@@ -48,4 +49,51 @@
 	list_add(&kernel_extable.list, &extables);
 }
 
+static void *s_start(struct seq_file *m, loff_t *pos)
+{
+	struct list_head *i;
+	loff_t n = 0;
+
+	list_for_each(i, &symbols) {
+		if (n++ == *pos)
+			break;
+	}
+	if (i == &symbols)
+		return NULL;
+	return i;
+}
+
+static void *s_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	struct list_head *i = p;
+	(*pos)++;
+	if (i->next == &symbols)
+		return NULL;
+	return i->next;
+}
+
+static void s_stop(struct seq_file *m, void *p)
+{
+}
+
+static int s_show(struct seq_file *m, void *p)
+{
+	struct kernel_symbol_group *sg 
+		= list_entry(p, struct kernel_symbol_group, list);
+	int i;
+
+	for (i=0; i < sg->num_syms; i++) {
+		const struct kernel_symbol *sym = &sg->syms[i];
+		seq_printf(m, "%08lx %s\n",
+			   sym->value, sym->name);
+	}
+	return 0;
+}
 
+struct seq_operations ksyms_op = {
+	.start	= s_start,
+	.next	= s_next,
+	.stop	= s_stop,
+	.show	= s_show
+};
+	


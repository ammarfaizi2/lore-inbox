Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSL0HHn>; Fri, 27 Dec 2002 02:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264806AbSL0HHn>; Fri, 27 Dec 2002 02:07:43 -0500
Received: from fmr06.intel.com ([134.134.136.7]:28353 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S264797AbSL0HHl>; Fri, 27 Dec 2002 02:07:41 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2601AA1373@pdsmsx32.pd.intel.com>
From: "Zhuang, Louis" <louis.zhuang@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] add /proc/ksyms against 2.5.53
Date: Fri, 27 Dec 2002 15:13:46 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to see what's in kernel, so add ksyms back into kernel.
Unfortunately Rusty's module tools depends on this file to judge whether
current kernel is new implementation,  a dirty solution is emptying
try_old_version() function in backwards_compat.c

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	v2.5.53 -> 1.953  
#	 fs/proc/proc_misc.c	1.60    -> 1.61   
#	     kernel/module.c	1.32    -> 1.34   
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
#
diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Fri Dec 27 15:08:53 2002
+++ b/fs/proc/proc_misc.c	Fri Dec 27 15:08:53 2002
@@ -297,6 +297,19 @@
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
+
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
 #endif
 
 extern struct seq_operations slabinfo_op;
@@ -595,6 +608,7 @@
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
+	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
 #endif
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Fri Dec 27 15:08:53 2002
+++ b/kernel/module.c	Fri Dec 27 15:08:53 2002
@@ -1402,6 +1402,48 @@
 	print_unload_info(m, mod);
 	return 0;
 }
+
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
+
 struct seq_operations modules_op = {
 	.start	= m_start,
 	.next	= m_next,
@@ -1409,6 +1451,13 @@
 	.show	= m_show
 };
 
+struct seq_operations ksyms_op = {
+	.start	= s_start,
+	.next	= s_next,
+	.stop	= s_stop,
+	.show	= s_show
+};
+	
 /* Obsolete lvalue for broken code which asks about usage */
 int module_dummy_usage = 1;
 EXPORT_SYMBOL(module_dummy_usage);


Yours truly,
Louis Zhuang
------------------------------
I'm only myself, not others

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWDYC56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWDYC56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWDYC56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:57:58 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:9696 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1751355AbWDYC56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:57:58 -0400
Date: Mon, 24 Apr 2006 19:57:47 -0700
Message-Id: <200604250257.k3P2vlEb012502@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, dwalker@mvista.com, hzhong@gmail.com
Subject: [PATCH] Profile likely/unlikely macros
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a very lightweight profiling feature to the
likely/unlikely macros. It should work in all contexts including
NMI, and during boot. The patch is for 2.6.17-rc2 . 

It has a /proc/likely_prof interface which outputs something like 
the following,

Likely Profiling Results
 --------------------------------------------------------------------
[+- ] Type | # True | # False | Function:Filename@Line
 unlikely |        0|        3  tcp_sacktag_write_queue()@:net/ipv4/tcp_input.c@1215
 unlikely |        0|        3  tcp_sacktag_write_queue()@:net/ipv4/tcp_input.c@1214
 unlikely |        0|        3  tcp_sacktag_write_queue()@:net/ipv4/tcp_input.c@1213
+unlikely |     5050|        0  do_sys_vm86()@:arch/i386/kernel/vm86.c@314
 unlikely |        0|     5050  do_sys_vm86()@:arch/i386/kernel/vm86.c@305
+unlikely |    10100|        0  load_esp0()@:include/asm/processor.h@498
+unlikely |    10100|        0  load_esp0()@:include/asm/processor.h@498
-likely   |        0|     1945  audit_free()@:kernel/auditsc.c@715

You can identify which statments are miss labeled from the + or - in front .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/include/linux/compiler.h
===================================================================
--- linux-2.6.16.orig/include/linux/compiler.h
+++ linux-2.6.16/include/linux/compiler.h
@@ -53,14 +53,44 @@ extern void __chk_io_ptr(void __iomem *)
 # include <linux/compiler-intel.h>
 #endif
 
+#ifdef CONFIG_PROFILE_LIKELY
+struct likeliness {
+	const char *func;
+	char *file;
+	int line;
+	int type;
+	unsigned int count[2]; 
+	struct likeliness *next;
+};
+
+extern int do_check_likely(struct likeliness *likeliness, int exp);
+
+# define LIKELY_UNSEEN	4
+
+# define __check_likely(exp, is_likely)							\
+	({										\
+		static __attribute__((__section__(".likely.data")))			\
+			struct likeliness likeliness = {				\
+				.func = __func__,					\
+				.file = __FILE__,					\
+				.line = __LINE__,					\
+				.type = is_likely | LIKELY_UNSEEN,			\
+			};								\
+		do_check_likely(&likeliness, !!(exp));					\
+	})
+
+# define likely(x)	__check_likely(x, 1)
+# define unlikely(x)	__check_likely(x, 0)
+#else
 /*
  * Generic compiler-dependent macros required for kernel
  * build go below this comment. Actual compiler/compiler version
  * specific implementations come from the above header files
  */
 
-#define likely(x)	__builtin_expect(!!(x), 1)
-#define unlikely(x)	__builtin_expect(!!(x), 0)
+# define likely(x)	__builtin_expect(!!(x), 1)
+# define unlikely(x)	__builtin_expect(!!(x), 0)
+#endif
 
 /* Optimization barrier */
 #ifndef barrier
Index: linux-2.6.16/lib/Kconfig.debug
===================================================================
--- linux-2.6.16.orig/lib/Kconfig.debug
+++ linux-2.6.16/lib/Kconfig.debug
@@ -223,3 +223,10 @@ config RCU_TORTURE_TEST
 	  at boot time (you probably don't).
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
+config	PROFILE_LIKELY 
+	bool "Record return values from likely/unlikely macros"
+	default n
+	help
+	  Adds profiling on likely/unlikly macros . To see the
+	  results of the profiling you can view the following,
+		/proc/likely_prof
Index: linux-2.6.16/lib/Makefile
===================================================================
--- linux-2.6.16.orig/lib/Makefile
+++ linux-2.6.16/lib/Makefile
@@ -49,6 +49,8 @@ obj-$(CONFIG_TEXTSEARCH_FSM) += ts_fsm.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
 
+obj-$(CONFIG_PROFILE_LIKELY) += likely_prof.o
+
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
Index: linux-2.6.16/lib/likely_prof.c
===================================================================
--- /dev/null
+++ linux-2.6.16/lib/likely_prof.c
@@ -0,0 +1,134 @@
+/*
+ * This code should enable profiling the likely and unlikely macros.
+ *
+ * Output goes in /prof/likely_prof
+ *
+ * Authors:
+ * Daniel Walker <dwalker@mvista.com> 
+ * Hua Zhong <hzhong@gmail.com>
+ * Andrew Morton <akpm@osdl.org>
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <asm/bug.h>
+#include <asm/atomic.h>
+
+#define WAS_UNLIKELY	0	
+#define WAS_LIKELY	1
+
+static struct likeliness *likeliness_head = NULL; 
+
+static atomic_t likely_lock = ATOMIC_INIT(1);
+
+int do_check_likely(struct likeliness *likeliness, int ret)
+{
+	if (ret)
+		likeliness->count[1]++;
+	else
+		likeliness->count[0]++;
+
+	if (likeliness->type & LIKELY_UNSEEN) {
+		if (atomic_dec_and_test(&likely_lock)) {
+			if (likeliness->type & LIKELY_UNSEEN) {
+				likeliness->type &= (~LIKELY_UNSEEN);
+				likeliness->next = likeliness_head;
+				likeliness_head = likeliness;
+			}
+		}
+		atomic_inc(&likely_lock);
+	}
+
+	return ret;
+}
+
+static void * lp_seq_start(struct seq_file *out, loff_t *pos)
+{
+
+	if (!*pos) {
+
+		seq_printf(out, "Likely Profiling Results\n");
+		seq_printf(out, " --------------------------------------------------------------------\n");
+		seq_printf(out, "[+- ] Type | # True | # False | Function:Filename@Line\n");
+
+		out->private = (void *)likeliness_head;
+	}
+
+	return out->private;
+}
+
+static void * lp_seq_next(struct seq_file *out, void *p, loff_t *pos)
+{
+	struct likeliness * entry = (struct likeliness *) p;
+
+	if (entry->next) {
+		++(*pos);
+		out->private = (void *)entry->next;
+	} else 
+		out->private = NULL;
+
+	return (out->private);
+}
+
+static int lp_seq_show(struct seq_file *out, void *p)
+{
+	struct likeliness * entry = (struct likeliness *)p;
+	int true = entry->count[1], false = entry->count[0];
+	
+	if (entry->type == WAS_UNLIKELY) {
+		if (true > false)
+			seq_printf(out, "+");
+		else
+			seq_printf(out, " ");
+
+		seq_printf(out, "unlikely ");
+	}
+	else if (entry->type == WAS_LIKELY) {
+		if (true < false)
+			seq_printf(out, "-");
+		else
+			seq_printf(out, " ");
+
+		seq_printf(out, "likely   ");
+	} 
+
+	seq_printf(out, "|%9u|%9u\t%s()@:%s@%d\n", true, false,
+			entry->func, entry->file, entry->line); 
+
+	return 0;
+}
+
+static void lp_seq_stop(struct seq_file *m, void *p) { }
+
+struct seq_operations likely_profiling_ops = {
+	.start  = lp_seq_start,
+	.next   = lp_seq_next,
+	.stop   = lp_seq_stop,
+	.show   = lp_seq_show
+};
+
+static int lp_results_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &likely_profiling_ops);
+}
+
+static struct file_operations proc_likely_operations  = {
+	.open           = lp_results_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+};
+
+static int __init init_likely(void)
+{
+	struct proc_dir_entry *entry;
+	entry = create_proc_entry("likely_prof", 0, &proc_root);
+	if (entry) 
+		entry->proc_fops = &proc_likely_operations;
+
+	return 0;
+}
+__initcall(init_likely);

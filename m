Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261774AbSJQTIE>; Thu, 17 Oct 2002 15:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbSJQTID>; Thu, 17 Oct 2002 15:08:03 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:47110
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261774AbSJQTIA>; Thu, 17 Oct 2002 15:08:00 -0400
Subject: [PATCH] pre-decoded wchan output
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Oct 2002 15:14:02 -0400
Message-Id: <1034882043.1072.589.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch implements a /proc/#/wchan which provides a pre-decoded
wchan via kallsyms.  I.e.,

	[15:05:06]rml@phantasy:~$ cat /proc/1228/wchan
	wait4

Which is damn cool to me and will let ps(1) grab wchan information
without having to parse System.map.  It also means procps will not need
System.map.

If CONFIG_KALLSYMS is enabled, /proc/#/wchan exists and exports the
pre-decoded symbol name.  The old wchan value in /proc/#/stat is
hard-coded to zero.

If CONFIG_KALLSYMS is not enabled, /proc/#/wchan does not exist to
conserve memory.  In that case, the old wchan field in /proc/#/stat will
export the usual wchan address.

This will not break procps, however the wchan field will be zero without
an updated version if CONFIG_KALLSYMS is set.  That is fine as 2.5
requires an updated procps anyhow.  If CONFIG_KALLSYMS is not set,
things are unchanged.

The procps patch is available at:

http://tech9.net/rml/procps/patches/procps-wchan-rml-2.0.10.20021011-1.patch

and ready for merging into procps CVS.

Patch is against current BK.  Please, apply.

	Robert Love

Implement /proc/#/wchan, a pre-decoded wchan

 Documentation/filesystems/proc.txt |    1 +
 fs/proc/array.c                    |   10 ++++++----
 fs/proc/base.c                     |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff -urN linux-2.5.43/fs/proc/array.c linux/fs/proc/array.c
--- linux-2.5.43/fs/proc/array.c	2002-10-16 22:55:13.000000000 -0400
+++ linux/fs/proc/array.c	2002-10-16 23:26:19.000000000 -0400
@@ -298,7 +298,7 @@
 
 int proc_pid_stat(struct task_struct *task, char * buffer)
 {
-	unsigned long vsize, eip, esp, wchan;
+	unsigned long vsize, eip, esp;
 	long priority, nice;
 	int tty_pgrp = -1, tty_nr = 0;
 	sigset_t sigign, sigcatch;
@@ -331,8 +331,6 @@
 		up_read(&mm->mmap_sem);
 	}
 
-	wchan = get_wchan(task);
-
 	collect_sigign_sigcatch(task, &sigign, &sigcatch);
 
 	/* scale priority and nice values from timeslices to -20..20 */
@@ -384,7 +382,11 @@
 		task->blocked.sig[0] & 0x7fffffffUL,
 		sigign      .sig[0] & 0x7fffffffUL,
 		sigcatch    .sig[0] & 0x7fffffffUL,
-		wchan,
+#ifndef CONFIG_KALLSYMS
+		get_wchan(task),
+#else
+		0UL,
+#endif
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
diff -urN linux-2.5.43/fs/proc/base.c linux/fs/proc/base.c
--- linux-2.5.43/fs/proc/base.c	2002-10-15 23:28:25.000000000 -0400
+++ linux/fs/proc/base.c	2002-10-16 23:24:17.000000000 -0400
@@ -28,6 +28,7 @@
 #include <linux/namespace.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
+#include <linux/kallsyms.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
@@ -54,6 +55,7 @@
 	PROC_PID_MAPS,
 	PROC_PID_CPU,
 	PROC_PID_MOUNTS,
+	PROC_PID_WCHAN,
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
@@ -81,6 +83,9 @@
   E(PROC_PID_ROOT,	"root",		S_IFLNK|S_IRWXUGO),
   E(PROC_PID_EXE,	"exe",		S_IFLNK|S_IRWXUGO),
   E(PROC_PID_MOUNTS,	"mounts",	S_IFREG|S_IRUGO),
+#ifdef CONFIG_KALLSYMS
+  E(PROC_PID_WCHAN,	"wchan",	S_IFREG|S_IRUGO),
+#endif
   {0,0,NULL,0}
 };
 #undef E
@@ -245,6 +250,28 @@
 	return res;
 }
 
+#ifdef CONFIG_KALLSYMS
+/*
+ * Provides a wchan file via kallsyms in a proper one-value-per-file format.
+ * Returns the resolved symbol.  If that fails, simply return the address.
+ */
+static int proc_pid_wchan(struct task_struct *task, char *buffer)
+{
+	const char *sym_name, *ignore;
+	unsigned long wchan, dummy;
+
+	wchan = get_wchan(task);
+
+	if (!kallsyms_address_to_symbol(wchan, &ignore, &dummy, &dummy,
+			&ignore, &dummy, &dummy, &sym_name,
+			&dummy, &dummy)) {
+		return sprintf(buffer, "%lu", wchan);
+	}
+
+	return sprintf(buffer, "%s", sym_name);
+}
+#endif
+
 /************************************************************************/
 /*                       Here the fs part begins                        */
 /************************************************************************/
@@ -1016,6 +1043,12 @@
 		case PROC_PID_MOUNTS:
 			inode->i_fop = &proc_mounts_operations;
 			break;
+#ifdef CONFIG_KALLSYMS
+		case PROC_PID_WCHAN:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_wchan;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
diff -urN linux-2.5.43/Documentation/filesystems/proc.txt linux/Documentation/filesystems/proc.txt
--- linux-2.5.43/Documentation/filesystems/proc.txt	2002-10-15 23:27:48.000000000 -0400
+++ linux/Documentation/filesystems/proc.txt	2002-10-17 00:14:36.000000000 -0400
@@ -130,6 +130,7 @@
  stat    Process status                                 
  statm   Process memory status information              
  status  Process status in human readable form          
+ wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is


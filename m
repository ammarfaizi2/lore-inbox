Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSJVFpk>; Tue, 22 Oct 2002 01:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSJVFpk>; Tue, 22 Oct 2002 01:45:40 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:58634
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262201AbSJVFpi>; Tue, 22 Oct 2002 01:45:38 -0400
Subject: [patch] 2.5: pre-decoded wchan output
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: hch@infradead.org, akpm@digeo.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 01:52:03 -0400
Message-Id: <1035265924.1044.92.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached patch implements a /proc/#/wchan which provides a pre-decoded
wchan via kallsyms.  I.e.,

        [01:47:26]rml@phantasy:~$ cat /proc/712/wchan
        wait4

Which is damn nifty and will let ps(1) grab wchan information
without having to parse System.map - in fact, procps will no longer need
System.map at all.

If CONFIG_KALLSYMS is enabled, /proc/#/wchan exists and exports the
pre-decoded symbol name.  If it does not exist, neither does the file.

The old interface in /proc/#/stat exists either way, per a suggestion
from Christoph.  I am not sure I agree (I would like to avoid the
get_wchan() in stat if CONFIG_KALLSYMS is set) but for now I agree this
is less invasive.

The procps patch is available at:

	http://tech9.net/rml/procps/patches/procps-wchan-rml-2.0.10.20021011-1.patch

and ready for merging into procps CVS.

Patch is against 2.5.44.  Whoever is one of the secret, mysterious,
incredibly handsome freeze integrators, please apply. :)

	Robert Love

 Documentation/filesystems/proc.txt |    1 +
 fs/proc/base.c                     |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff -urN linux-2.5.44/Documentation/filesystems/proc.txt linux/Documentation/filesystems/proc.txt
--- linux-2.5.44/Documentation/filesystems/proc.txt	2002-10-19 00:01:19.000000000 -0400
+++ linux/Documentation/filesystems/proc.txt	2002-10-22 01:39:33.000000000 -0400
@@ -130,6 +130,7 @@
  stat    Process status                                 
  statm   Process memory status information              
  status  Process status in human readable form          
+ wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is
diff -urN linux-2.5.44/fs/proc/base.c linux/fs/proc/base.c
--- linux-2.5.44/fs/proc/base.c	2002-10-19 00:02:00.000000000 -0400
+++ linux/fs/proc/base.c	2002-10-22 01:39:33.000000000 -0400
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



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSHaUMN>; Sat, 31 Aug 2002 16:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSHaUMN>; Sat, 31 Aug 2002 16:12:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5648 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318008AbSHaUML>;
	Sat, 31 Aug 2002 16:12:11 -0400
Date: Sat, 31 Aug 2002 21:16:38 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.4.19] reboot on out-of-file handles
Message-ID: <20020831201638.GG721@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 21:12:46 up 1 day, 10 min,  1 user,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Please find below a patch that adds the ability to panic if you run
out of file handles (by setting /proc/sys/fs/file-max-panic to none-0).
When combined with reboot-on-panic this means that a server might be
able to get out of a service-gone-mad situation. It calls show_state
before panic'ing to log what was going on - adding something similar
which listed open filehandles would probably be advantageous.

The patch is against a clean 2.4.19 and was tested on sparc64.

Comments?

Dave


diff -urN linux-2.4.19.orig/Documentation/sysctl/fs.txt linux-2.4.19/Documentation/sysctl/fs.txt
--- linux-2.4.19.orig/Documentation/sysctl/fs.txt	2000-01-11 02:15:58.000000000 +0000
+++ linux-2.4.19/Documentation/sysctl/fs.txt	2002-08-31 18:41:41.000000000 +0100
@@ -19,6 +19,7 @@
 - dquot-max
 - dquot-nr
 - file-max
+- file-max-panic
 - file-nr
 - inode-max
 - inode-nr
@@ -71,7 +72,7 @@
 
 ==============================================================
 
-file-max & file-nr:
+file-max, file-nr & file-max-panic:
 
 The kernel allocates file handles dynamically, but as yet it
 doesn't free them again.
@@ -88,6 +89,10 @@
 far behind, you've encountered a peak in your usage of file
 handles and you don't need to increase the maximum.
 
+If file-max-panic is none zero, then when your system runs out
+of file handles it will panic.  While this may seem extreme, when
+combined with rebooting on panic it can be better to have a machine
+reboot itself than sit there unable to open any files.
 ==============================================================
 
 inode-max, inode-nr & inode-state:
diff -urN linux-2.4.19.orig/fs/file_table.c linux-2.4.19/fs/file_table.c
--- linux-2.4.19.orig/fs/file_table.c	2001-09-17 21:16:30.000000000 +0100
+++ linux-2.4.19/fs/file_table.c	2002-08-31 20:46:17.000000000 +0100
@@ -5,6 +5,7 @@
  *  Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/file.h>
@@ -15,6 +16,8 @@
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {0, 0, NR_FILE};
+/* sysctl flag - if !=0 we panic when we run out of file handles */
+int files_panic_nofh=0;
 
 /* Here the new files go */
 static LIST_HEAD(anon_list);
@@ -72,6 +75,15 @@
 	} else if (files_stat.max_files > old_max) {
 		printk(KERN_INFO "VFS: file-max limit %d reached\n", files_stat.max_files);
 		old_max = files_stat.max_files;
+                if (files_panic_nofh)
+		{
+	          /* DAG: chances are that the kernel is still OK it is just a
+		   * user task that has gone mad; so lets dump the state of
+		   * all processes so the victim can find what caused it
+		   */
+	          show_state();
+                  panic("VFS: Out of file handles (files_panic_nofh!=0)\n");
+		}
 	}
 	file_list_unlock();
 	return NULL;
diff -urN linux-2.4.19.orig/include/linux/fs.h linux-2.4.19/include/linux/fs.h
--- linux-2.4.19.orig/include/linux/fs.h	2002-08-03 01:39:45.000000000 +0100
+++ linux-2.4.19/include/linux/fs.h	2002-08-31 19:04:53.000000000 +0100
@@ -53,6 +53,8 @@
 	int max_files;		/* tunable */
 };
 extern struct files_stat_struct files_stat;
+extern int files_panic_nofh;
+
 
 struct inodes_stat_t {
 	int nr_inodes;
diff -urN linux-2.4.19.orig/include/linux/sysctl.h linux-2.4.19/include/linux/sysctl.h
--- linux-2.4.19.orig/include/linux/sysctl.h	2002-08-03 01:39:46.000000000 +0100
+++ linux-2.4.19/include/linux/sysctl.h	2002-08-31 18:12:56.000000000 +0100
@@ -546,6 +546,7 @@
 	FS_LEASES=13,	/* int: leases enabled */
 	FS_DIR_NOTIFY=14,	/* int: directory notification enabled */
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
+        FS_PANICNOFH=16,        /* int: !=0 means panic when run out of fh */
 };
 
 /* CTL_DEBUG names: */
diff -urN linux-2.4.19.orig/kernel/sysctl.c linux-2.4.19/kernel/sysctl.c
--- linux-2.4.19.orig/kernel/sysctl.c	2002-08-03 01:39:46.000000000 +0100
+++ linux-2.4.19/kernel/sysctl.c	2002-08-31 18:39:15.000000000 +0100
@@ -309,6 +309,8 @@
 	 sizeof(int), 0644, NULL, &proc_dointvec},
 	{FS_LEASE_TIME, "lease-break-time", &lease_break_time, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{FS_PANICNOFH, "file-max-panic", &files_panic_nofh, sizeof(int),
+	 0644, NULL, &proc_dointvec},
 	{0}
 };
 
--
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWEVKYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWEVKYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWEVKYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:24:41 -0400
Received: from thunk.org ([69.25.196.29]:3468 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750720AbWEVKYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:24:41 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add user taint flag
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
Date: Sun, 21 May 2006 19:04:32 -0400
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Allow taint flags to be set from userspace by writing to
/proc/sys/kernel/tainted, and add a new taint flag, TAINT_USER, to be
used when userspace is potentially doing something naughty that might
compromise the kernel.  This will allow support personnel to ask further
questions about what may have caused the user taint flag to have been
set.  (For example, by examining the logs of the JVM to determine what
evil things might have been lurking in the hearts of Java programs.  :-)

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>


Index: linux-2.6/include/linux/kernel.h
===================================================================
--- linux-2.6.orig/include/linux/kernel.h	2006-04-28 21:16:55.000000000 -0400
+++ linux-2.6/include/linux/kernel.h	2006-05-21 19:00:15.000000000 -0400
@@ -198,6 +198,7 @@
 #define TAINT_FORCED_RMMOD		(1<<3)
 #define TAINT_MACHINE_CHECK		(1<<4)
 #define TAINT_BAD_PAGE			(1<<5)
+#define TAINT_USER			(1<<6)
 
 extern void dump_stack(void);
 
Index: linux-2.6/include/linux/sysctl.h
===================================================================
--- linux-2.6.orig/include/linux/sysctl.h	2006-03-25 21:26:37.000000000 -0500
+++ linux-2.6/include/linux/sysctl.h	2006-05-21 19:00:15.000000000 -0400
@@ -915,6 +915,8 @@
 			 void __user *, size_t *, loff_t *);
 extern int proc_dointvec_bset(ctl_table *, int, struct file *,
 			      void __user *, size_t *, loff_t *);
+extern int proc_dointvec_taint(ctl_table *, int, struct file *,
+			       void __user *, size_t *, loff_t *);
 extern int proc_dointvec_minmax(ctl_table *, int, struct file *,
 				void __user *, size_t *, loff_t *);
 extern int proc_dointvec_jiffies(ctl_table *, int, struct file *,
Index: linux-2.6/kernel/panic.c
===================================================================
--- linux-2.6.orig/kernel/panic.c	2006-04-28 21:16:55.000000000 -0400
+++ linux-2.6/kernel/panic.c	2006-05-21 19:00:15.000000000 -0400
@@ -150,6 +150,7 @@
  *  'R' - User forced a module unload.
  *  'M' - Machine had a machine check experience.
  *  'B' - System has hit bad_page.
+ *  'U' - Userspace-defined naughtiness.
  *
  *	The string is overwritten by the next call to print_taint().
  */
@@ -158,13 +159,14 @@
 {
 	static char buf[20];
 	if (tainted) {
-		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
+		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c%c",
 			tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
 			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
 			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ',
 			tainted & TAINT_FORCED_RMMOD ? 'R' : ' ',
  			tainted & TAINT_MACHINE_CHECK ? 'M' : ' ',
-			tainted & TAINT_BAD_PAGE ? 'B' : ' ');
+			tainted & TAINT_BAD_PAGE ? 'B' : ' ',
+			tainted & TAINT_USER ? 'U' : ' ');
 	}
 	else
 		snprintf(buf, sizeof(buf), "Not tainted");
Index: linux-2.6/kernel/sysctl.c
===================================================================
--- linux-2.6.orig/kernel/sysctl.c	2006-03-25 21:26:38.000000000 -0500
+++ linux-2.6/kernel/sysctl.c	2006-05-21 19:00:15.000000000 -0400
@@ -305,8 +305,8 @@
 		.procname	= "tainted",
 		.data		= &tainted,
 		.maxlen		= sizeof(int),
-		.mode		= 0444,
-		.proc_handler	= &proc_dointvec,
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_taint,
 	},
 	{
 		.ctl_name	= KERN_CAP_BSET,
@@ -1835,6 +1835,23 @@
 				do_proc_dointvec_bset_conv,&op);
 }
 
+/*
+ *	Taint values can only be increased
+ */
+int proc_dointvec_taint(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int op;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		return -EPERM;
+	}
+
+	op = OP_OR;
+	return do_proc_dointvec(table,write,filp,buffer,lenp,ppos,
+				do_proc_dointvec_bset_conv,&op);
+}
+
 struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;

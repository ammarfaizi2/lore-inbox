Return-Path: <linux-kernel-owner+w=401wt.eu-S1752710AbWLXU26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbWLXU26 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 15:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbWLXU25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 15:28:57 -0500
Received: from mail1.panix.com ([166.84.1.72]:59712 "EHLO mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbWLXU24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 15:28:56 -0500
Message-Id: <20061224202628.996925116@panix.com>
References: <20061224202207.150596681@panix.com>
User-Agent: quilt/0.45-1
Date: Sun, 24 Dec 2006 12:22:09 -0800
From: Zack Weinberg <zackw@panix.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>, Vincent Legoll <vlegoll@9online.fr>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2/4] permission mapping for sys_syslog operations
Content-Disposition: inline; filename=map_perms.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Stephen Smalley: map the various sys_syslog operations
to a smaller set of privilege codes before calling security modules.
This patch changes the security module interface!  There should be no
change in the actual security semantics enforced by dummy, capability,
nor SELinux (with one exception, clearly marked in sys_syslog).

The privilege codes are now in linux/security.h instead of
linux/klog.h, and use the LSM_* naming convention used for other such
constants in that file.

I'm now using a static table to map operations to privilege codes.
This makes it very easy to see the mapping as a whole, and prevents
security operations from cluttering up the body of do_syslog, but does
necessitate some checks to ensure that when new KLOG_* operations are
added, people don't forget to add entries to the table.  If people are
not fans of the idiom I used, I will see about getting a feature added
to gcc to make it less ugly.

Note that after this patch, close() on /proc/kmsg and
sys_syslog(KLOG_CLOSE) do not do security checks; they always succeed.
(IMO close should never fail.) This was always in this patch series,
but used to be in a different stage.

zw

Index: linux-2.6/kernel/printk.c
===================================================================
--- linux-2.6.orig/kernel/printk.c	2006-12-24 11:43:14.000000000 -0800
+++ linux-2.6/kernel/printk.c	2006-12-24 11:43:16.000000000 -0800
@@ -164,6 +164,39 @@
 
 __setup("log_buf_len=", log_buf_len_setup);
 
+/*
+ * This table maps KLOG_* operation codes to LSM_KLOG_* privilege classes.
+ * "unsigned char" is used just to keep it small.
+ */
+
+static const unsigned char klog_privclass[] = {
+	[KLOG_CLOSE]           = 0,  /* close always succeeds */
+	[KLOG_OPEN]            = LSM_KLOG_READ,
+	[KLOG_READ]            = LSM_KLOG_READ,
+	[KLOG_GET_UNREAD]      = LSM_KLOG_READ,
+
+	[KLOG_READ_HIST]       = LSM_KLOG_READHIST,
+	[KLOG_GET_SIZE]        = LSM_KLOG_READHIST,
+	[KLOG_READ_CLEAR_HIST] = LSM_KLOG_READHIST|LSM_KLOG_CLEARHIST,
+	[KLOG_CLEAR_HIST]      = LSM_KLOG_CLEARHIST,
+
+	[KLOG_DISABLE_CONSOLE] = LSM_KLOG_CONSOLE,
+	[KLOG_ENABLE_CONSOLE]  = LSM_KLOG_CONSOLE,
+	[KLOG_SET_CONSOLE_LVL] = LSM_KLOG_CONSOLE,
+};
+
+/* It is essential that there be an entry in the above table for every
+ * KLOG_* code.  The following, er, odd declarations cause compilation
+ * of this file to fail if that is not true.  They do not correspond
+ * to real data objects.
+ */
+extern char klog_privclass_is_missing_an_entry[
+	ARRAY_SIZE(klog_privclass) < KLOG_OPCODE_MAX ? -1 : 1
+];
+extern char klog_privclass_has_too_many_entries[
+	ARRAY_SIZE(klog_privclass) > KLOG_OPCODE_MAX ? -1 : 1
+];
+
 /**
  * do_syslog - operate on the log of kernel messages
  * @type: operation to perform
@@ -185,9 +218,11 @@
 	unsigned long i, j, limit, count;
 	int do_clear = 0;
 	char c;
-	int error = 0;
+	int error;
 
-	error = security_syslog(type);
+	if (type < 0 || type >= KLOG_OPCODE_MAX)
+		return -EINVAL;
+	error = security_syslog(klog_privclass[type]);
 	if (error)
 		return error;
 
Index: linux-2.6/security/commoncap.c
===================================================================
--- linux-2.6.orig/security/commoncap.c	2006-12-23 08:55:16.000000000 -0800
+++ linux-2.6/security/commoncap.c	2006-12-24 11:43:16.000000000 -0800
@@ -311,7 +311,7 @@
 
 int cap_syslog (int type)
 {
-	if ((type != 3 && type != 10) && !capable(CAP_SYS_ADMIN))
+	if ((type & ~LSM_KLOG_READHIST) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
Index: linux-2.6/security/dummy.c
===================================================================
--- linux-2.6.orig/security/dummy.c	2006-12-23 08:55:16.000000000 -0800
+++ linux-2.6/security/dummy.c	2006-12-24 11:43:16.000000000 -0800
@@ -96,7 +96,7 @@
 
 static int dummy_syslog (int type)
 {
-	if ((type != 3 && type != 10) && current->euid)
+	if ((type & ~LSM_KLOG_READHIST) && current->euid)
 		return -EPERM;
 	return 0;
 }
Index: linux-2.6/security/selinux/hooks.c
===================================================================
--- linux-2.6.orig/security/selinux/hooks.c	2006-12-23 08:55:16.000000000 -0800
+++ linux-2.6/security/selinux/hooks.c	2006-12-24 11:43:16.000000000 -0800
@@ -1504,29 +1504,27 @@
 {
 	int rc;
 
+	/* if there are any codes we don't know about, there's a bug */
+	BUG_ON(type & ~(LSM_KLOG_READ|LSM_KLOG_READHIST
+			|LSM_KLOG_CLEARHIST|LSM_KLOG_CONSOLE));
+
 	rc = secondary_ops->syslog(type);
 	if (rc)
 		return rc;
 
-	switch (type) {
-		case 3:         /* Read last kernel messages */
-		case 10:        /* Return size of the log buffer */
-			rc = task_has_system(current, SYSTEM__SYSLOG_READ);
-			break;
-		case 6:         /* Disable logging to console */
-		case 7:         /* Enable logging to console */
-		case 8:		/* Set level of messages printed to console */
-			rc = task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
-			break;
-		case 0:         /* Close log */
-		case 1:         /* Open log */
-		case 2:         /* Read from log */
-		case 4:         /* Read/clear last kernel messages */
-		case 5:         /* Clear ring buffer */
-		default:
-			rc = task_has_system(current, SYSTEM__SYSLOG_MOD);
-			break;
-	}
+	if (type & (LSM_KLOG_READ|LSM_KLOG_CLEARHIST))
+		rc = task_has_system(current, SYSTEM__SYSLOG_MOD);
+	if (rc)
+		return rc;
+
+	if (type & LSM_KLOG_READHIST)
+		rc = task_has_system(current, SYSTEM__SYSLOG_READ);
+	if (rc)
+		return rc;
+
+	if (type & LSM_KLOG_CONSOLE)
+		rc = task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
+
 	return rc;
 }
 
Index: linux-2.6/include/linux/security.h
===================================================================
--- linux-2.6.orig/include/linux/security.h	2006-12-23 08:55:16.000000000 -0800
+++ linux-2.6/include/linux/security.h	2006-12-24 11:43:16.000000000 -0800
@@ -86,6 +86,18 @@
 /* setfsuid or setfsgid, id0 == fsuid or fsgid */
 #define LSM_SETID_FS	8
 
+/*
+ * Values passed to security_syslog to indicate which privilege class
+ * is requested.  requested.  Note these are bitmasks - callers may
+ * request more than one of the privilege classes at once (this is
+ * currently only used for READHIST|CLEARHIST) or no privilege at all
+ * (which should always succeed).
+ */
+#define LSM_KLOG_READ      1  /* read current messages (klogd) */
+#define LSM_KLOG_READHIST  2  /* read message history (dmesg) */
+#define LSM_KLOG_CLEARHIST 4  /* clear message history (dmesg -c) */
+#define LSM_KLOG_CONSOLE   8  /* set or query console log level */
+
 /* forward declares to avoid warnings */
 struct nfsctl_arg;
 struct sched_param;

--


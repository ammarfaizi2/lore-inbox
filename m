Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbTIDQmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTIDQmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:42:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265297AbTIDQmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:42:11 -0400
Date: Thu, 4 Sep 2003 12:41:56 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][SELINUX] make selinux enable param config option, enabled
 by default
Message-ID: <Pine.LNX.4.44.0309041226120.20658-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against current bk makes the recently added SELinux boot
parameter feature a configurable option, and enables SELinux by default
when selected.  These changes were made following feedback including 
discussion on the SELinux list.

The rationale for the changes is to allow SELinux to be be configured and
enabled unconditionally.  If the boot parameter option is selected, then
SELinux is now enabled unless selinux=0 is specified at the kernel command
line.

Please apply.

- James
-- 
James Morris
<jmorris@redhat.com>


diff -urN -X dontdiff bk26.orig/security/selinux/hooks.c bk26.w1/security/selinux/hooks.c
--- bk26.orig/security/selinux/hooks.c	2003-09-05 02:03:13.000000000 +1000
+++ bk26.w1/security/selinux/hooks.c	2003-09-05 02:17:24.000000000 +1000
@@ -73,7 +73,8 @@
 __setup("enforcing=", enforcing_setup);
 #endif
 
-int selinux_enabled = 0;
+#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
+int selinux_enabled = 1;
 
 static int __init selinux_enabled_setup(char *str)
 {
@@ -81,6 +82,7 @@
 	return 1;
 }
 __setup("selinux=", selinux_enabled_setup);
+#endif
 
 /* Original (dummy) security module. */
 static struct security_operations *original_ops = NULL;
@@ -3357,7 +3359,7 @@
 	struct task_security_struct *tsec;
 
 	if (!selinux_enabled) {
-		printk(KERN_INFO "SELinux:  Not enabled at boot.\n");
+		printk(KERN_INFO "SELinux:  Disabled at boot.\n");
 		return 0;
 	}
 
diff -urN -X dontdiff bk26.orig/security/selinux/include/security.h bk26.w1/security/selinux/include/security.h
--- bk26.orig/security/selinux/include/security.h	2003-09-05 02:02:55.000000000 +1000
+++ bk26.w1/security/selinux/include/security.h	2003-09-05 02:17:24.000000000 +1000
@@ -14,6 +14,12 @@
 
 #define SELINUX_MAGIC 0xf97cff8c
 
+#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
+extern int selinux_enabled;
+#else
+#define selinux_enabled 1
+#endif
+
 int security_load_policy(void * data, size_t len);
 
 struct av_decision {
diff -urN -X dontdiff bk26.orig/security/selinux/Kconfig bk26.w1/security/selinux/Kconfig
--- bk26.orig/security/selinux/Kconfig	2003-09-05 02:02:55.000000000 +1000
+++ bk26.w1/security/selinux/Kconfig	2003-09-05 02:17:24.000000000 +1000
@@ -8,11 +8,22 @@
 	  You can obtain the policy compiler (checkpolicy), the utility for
 	  labeling filesystems (setfiles), and an example policy configuration
 	  from http://www.nsa.gov/selinux.
-	  SELinux needs to be explicitly enabled on the kernel command line with
-	  selinux=1.  If you specify selinux=0 or do not use this parameter,
-	  SELinux will not be enabled.
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_SELINUX_BOOTPARAM
+	bool "NSA SELinux boot parameter"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	  This option adds a kernel parameter 'selinux', which allows SELinux
+	  to be disabled at boot.  If this option is selected, SELinux
+	  functionality can be disabled with selinux=0 on the kernel
+	  command line.  The purpose of this option is to allow a single
+	  kernel image to be distributed with SELinux built in, but not
+	  necessarily enabled.
+	  
+	  If you are unsure how to answer this question, answer N.
+	  
 config SECURITY_SELINUX_DEVELOP
 	bool "NSA SELinux Development Support"
 	depends on SECURITY_SELINUX
diff -urN -X dontdiff bk26.orig/security/selinux/selinuxfs.c bk26.w1/security/selinux/selinuxfs.c
--- bk26.orig/security/selinux/selinuxfs.c	2003-09-05 02:03:17.000000000 +1000
+++ bk26.w1/security/selinux/selinuxfs.c	2003-09-05 02:17:24.000000000 +1000
@@ -17,8 +17,6 @@
 #include "security.h"
 #include "objsec.h"
 
-extern int selinux_enabled;
-
 /* Check whether a task is allowed to use a security operation. */
 int task_has_security(struct task_struct *tsk,
 		      u32 perms)


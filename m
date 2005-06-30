Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263058AbVF3UPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbVF3UPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVF3T75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:59:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:48807 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263020AbVF3Tp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:45:59 -0400
Date: Thu, 30 Jun 2005 14:51:50 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
Subject: [patch 6/12] lsm stacking v0.2: stackable capability lsm
Message-ID: <20050630195150.GF23538@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630194458.GA23439@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a version of the capability module which is safe to
stack with SELinux.  It notably does not define the inode_setxattr
and inode_removexattr hooks, as these otherwise prevent selinux from
saving file types to disk.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 Kconfig         |   21 +++++++++++
 Makefile        |    1 
 cap_stack.c     |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 selinux/Kconfig |    2 +
 4 files changed, 124 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc1/security/Kconfig
===================================================================
--- linux-2.6.13-rc1.orig/security/Kconfig	2005-06-30 15:32:43.000000000 -0500
+++ linux-2.6.13-rc1/security/Kconfig	2005-06-30 15:33:43.000000000 -0500
@@ -56,10 +56,29 @@ config SECURITY_NETWORK
 config SECURITY_CAPABILITIES
 	tristate "Default Linux Capabilities"
 	depends on SECURITY
+	depends on SECURITY_SELINUX=n && SECURITY_CAP_STACK=n
 	help
-	  This enables the "default" Linux capabilities functionality.
+	  This enables the default Linux capabilities functionality.
+	  This module may not be used in conjunction with the stackable
+	  capabilities or SELinux modules.
+
 	  If you are unsure how to answer this question, answer Y.
 
+	  If you are using SELinux, answer N here and look at the
+	  Stackable Linux Capabilities instead.
+
+config SECURITY_CAP_STACK
+	tristate "Stackable Linux Capabilities"
+	depends on SECURITY
+	help
+	  This enables the "stackable" Linux capabilities functionality.
+
+	  If you are using SELinux, this option will be automatically
+	  enabled.
+
+	  If you are not using any other LSMs, answer N here and see above
+	  for the Default Linux Capabilities.
+
 config SECURITY_ROOTPLUG
 	tristate "Root Plug Support"
 	depends on USB && SECURITY
Index: linux-2.6.13-rc1/security/Makefile
===================================================================
--- linux-2.6.13-rc1.orig/security/Makefile	2005-06-30 15:32:43.000000000 -0500
+++ linux-2.6.13-rc1/security/Makefile	2005-06-30 15:32:47.000000000 -0500
@@ -16,5 +16,6 @@ obj-$(CONFIG_SECURITY)			+= security.o d
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
+obj-$(CONFIG_SECURITY_CAP_STACK)	+= commoncap.o cap_stack.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
 obj-$(CONFIG_SECURITY_SECLVL)		+= seclvl.o
Index: linux-2.6.13-rc1/security/cap_stack.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc1/security/cap_stack.c	2005-06-30 15:32:47.000000000 -0500
@@ -0,0 +1,101 @@
+/*
+ *  Capabilities Linux Security Module
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+#include <linux/smp_lock.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/ptrace.h>
+#include <linux/moduleparam.h>
+
+static struct security_operations capability_ops = {
+	.ptrace =			cap_ptrace,
+	.capget =			cap_capget,
+	.capset_check =			cap_capset_check,
+	.capset_set =			cap_capset_set,
+	.capable =			cap_capable,
+	.settime =			cap_settime,
+	.netlink_send =			cap_netlink_send,
+	.netlink_recv =			cap_netlink_recv,
+
+	.bprm_apply_creds =		cap_bprm_apply_creds,
+	.bprm_set_security =		cap_bprm_set_security,
+	.bprm_secureexec =		cap_bprm_secureexec,
+
+	.task_post_setuid =		cap_task_post_setuid,
+	.task_reparent_to_init =	cap_task_reparent_to_init,
+
+	.syslog =                       cap_syslog,
+
+	.vm_enough_memory =             cap_vm_enough_memory,
+};
+
+#define MY_NAME __stringify(KBUILD_MODNAME)
+
+/* flag to keep track of how we were registered */
+static int secondary;
+
+static int capability_disable;
+module_param_named(disable, capability_disable, int, 0);
+MODULE_PARM_DESC(disable, "To disable capabilities module set disable = 1");
+
+static int __init capability_init (void)
+{
+	if (capability_disable) {
+		printk(KERN_INFO "Capabilities disabled at initialization\n");
+		return 0;
+	}
+	/* register ourselves with the security framework */
+	if (register_security (&capability_ops)) {
+		/* try registering with primary module */
+		if (mod_reg_security (MY_NAME, &capability_ops)) {
+			printk (KERN_INFO "Failure registering capabilities "
+				"with primary security module.\n");
+			return -EINVAL;
+		}
+		secondary = 1;
+	}
+	printk (KERN_INFO "Capability LSM initialized%s\n",
+		secondary ? " as secondary" : "");
+	return 0;
+}
+
+static void __exit capability_exit (void)
+{
+	if (capability_disable)
+		return;
+	/* remove ourselves from the security framework */
+	if (secondary) {
+		if (mod_unreg_security (MY_NAME, &capability_ops))
+			printk (KERN_INFO "Failure unregistering capabilities "
+				"with primary module.\n");
+		return;
+	}
+
+	if (unregister_security (&capability_ops)) {
+		printk (KERN_INFO
+			"Failure unregistering capabilities with the kernel\n");
+	}
+}
+
+security_initcall (capability_init);
+module_exit (capability_exit);
+
+MODULE_DESCRIPTION("Standard Linux Capabilities Security Module");
+MODULE_LICENSE("GPL");
Index: linux-2.6.13-rc1/security/selinux/Kconfig
===================================================================
--- linux-2.6.13-rc1.orig/security/selinux/Kconfig	2005-06-30 14:15:01.000000000 -0500
+++ linux-2.6.13-rc1/security/selinux/Kconfig	2005-06-30 15:32:47.000000000 -0500
@@ -2,6 +2,8 @@ config SECURITY_SELINUX
 	bool "NSA SELinux Support"
 	depends on SECURITY && NET && INET
 	default n
+	select SECURITY_CAP_STACK
+	select SECURITY_STACKER
 	help
 	  This selects NSA Security-Enhanced Linux (SELinux).
 	  You will also need a policy configuration and a labeled filesystem.

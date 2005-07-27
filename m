Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVG0SUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVG0SUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVG0SUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:20:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:39812 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261332AbVG0SUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:20:19 -0400
Date: Wed, 27 Jul 2005 13:20:39 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Emily Ratliff <emilyr@us.ibm.com>
Subject: [patch 2/15] lsm stacking v0.3: add module * to security_ops
Message-ID: <20050727182039.GC22483@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050727181921.GB22483@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727181921.GB22483@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the owning module to the security_operations struct.  This will allow
stacker to module_get the LSM to prevent its premature unloading.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 include/linux/security.h |    7 +++++++
 security/capability.c    |    1 +
 security/root_plug.c     |    2 ++
 security/seclvl.c        |    1 +
 security/selinux/hooks.c |    2 ++
 5 files changed, 13 insertions(+)

Index: linux-2.6.13-rc3/include/linux/security.h
===================================================================
--- linux-2.6.13-rc3.orig/include/linux/security.h	2005-07-18 15:49:52.000000000 -0500
+++ linux-2.6.13-rc3/include/linux/security.h	2005-07-18 15:51:36.000000000 -0500
@@ -32,6 +32,7 @@
 #include <linux/sched.h>
 
 struct ctl_table;
+struct module;
 
 /*
  * These functions are in security/capability.c and are used
@@ -94,6 +95,10 @@ struct swap_info_struct;
  *
  * Security hooks for program execution operations.
  *
+ *
+ * @owner:
+ *	Module owning this security_operations.  NULL if not a module.
+ *
  * @bprm_alloc_security:
  *	Allocate and attach a security structure to the @bprm->security field.
  *	The security field is initialized to NULL when the bprm structure is
@@ -1027,6 +1032,8 @@ struct swap_info_struct;
  * This is the main security structure.
  */
 struct security_operations {
+	struct module *owner;
+
 	int (*ptrace) (struct task_struct * parent, struct task_struct * child);
 	int (*capget) (struct task_struct * target,
 		       kernel_cap_t * effective,
Index: linux-2.6.13-rc3/security/capability.c
===================================================================
--- linux-2.6.13-rc3.orig/security/capability.c	2005-07-18 15:49:52.000000000 -0500
+++ linux-2.6.13-rc3/security/capability.c	2005-07-18 15:51:36.000000000 -0500
@@ -25,6 +25,7 @@
 #include <linux/moduleparam.h>
 
 static struct security_operations capability_ops = {
+	.owner =			THIS_MODULE,
 	.ptrace =			cap_ptrace,
 	.capget =			cap_capget,
 	.capset_check =			cap_capset_check,
Index: linux-2.6.13-rc3/security/root_plug.c
===================================================================
--- linux-2.6.13-rc3.orig/security/root_plug.c	2005-07-18 15:49:52.000000000 -0500
+++ linux-2.6.13-rc3/security/root_plug.c	2005-07-18 15:51:36.000000000 -0500
@@ -83,6 +83,8 @@ static int rootplug_bprm_check_security 
 }
 
 static struct security_operations rootplug_security_ops = {
+	.owner =			THIS_MODULE,
+
 	/* Use the capability functions for some of the hooks */
 	.ptrace =			cap_ptrace,
 	.capget =			cap_capget,
Index: linux-2.6.13-rc3/security/seclvl.c
===================================================================
--- linux-2.6.13-rc3.orig/security/seclvl.c	2005-07-18 15:49:52.000000000 -0500
+++ linux-2.6.13-rc3/security/seclvl.c	2005-07-18 15:51:36.000000000 -0500
@@ -591,6 +591,7 @@ static int seclvl_umount(struct vfsmount
 }
 
 static struct security_operations seclvl_ops = {
+	.owner = THIS_MODULE,
 	.ptrace = seclvl_ptrace,
 	.capable = seclvl_capable,
 	.inode_permission = seclvl_inode_permission,
Index: linux-2.6.13-rc3/security/selinux/hooks.c
===================================================================
--- linux-2.6.13-rc3.orig/security/selinux/hooks.c	2005-07-18 15:49:52.000000000 -0500
+++ linux-2.6.13-rc3/security/selinux/hooks.c	2005-07-18 15:51:36.000000000 -0500
@@ -4265,6 +4265,8 @@ static int selinux_setprocattr(struct ta
 }
 
 static struct security_operations selinux_ops = {
+	.owner =			THIS_MODULE,
+
 	.ptrace =			selinux_ptrace,
 	.capget =			selinux_capget,
 	.capset_check =			selinux_capset_check,

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbUAPVUj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 16:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUAPVUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 16:20:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:59624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265796AbUAPVUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:20:15 -0500
Date: Fri, 16 Jan 2004 13:20:04 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: Andreas Gruenbacher <agruen@suse.de>,
       Michael Kerrisk <michael.kerrisk@gmx.net>,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: [PATCH 2/2] Default hooks protecting the XATTR_SECURITY_PREFIX namespace
Message-ID: <20040116132004.R19023@osdlab.pdx.osdl.net>
References: <20040116131423.Q19023@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040116131423.Q19023@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Fri, Jan 16, 2004 at 01:14:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add default hooks for both the dummy and capability code to protect the
XATTR_SECURITY_PREFIX namespace.  These EAs were fully accessible to
unauthorized users, so a user that rebooted from an SELinux kernel to a
default kernel would leave those critical EAs unprotected.

 include/linux/security.h |    6 ++++--
 security/capability.c    |    3 +++
 security/commoncap.c     |   22 ++++++++++++++++++++++
 security/dummy.c         |    9 +++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)

===== include/linux/security.h 1.26 vs edited =====
--- 1.26/include/linux/security.h	Thu Oct  2 00:12:10 2003
+++ edited/include/linux/security.h	Fri Jan 16 12:14:15 2004
@@ -46,6 +46,8 @@
 extern int cap_bprm_set_security (struct linux_binprm *bprm);
 extern void cap_bprm_compute_creds (struct linux_binprm *bprm);
 extern int cap_bprm_secureexec(struct linux_binprm *bprm);
+extern int cap_inode_setxattr(struct dentry *dentry, char *name, void *value, size_t size, int flags);
+extern int cap_inode_removexattr(struct dentry *dentry, char *name);
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_reparent_to_init (struct task_struct *p);
 extern int cap_syslog (int type);
@@ -2136,7 +2138,7 @@
 static inline int security_inode_setxattr (struct dentry *dentry, char *name,
 					   void *value, size_t size, int flags)
 {
-	return 0;
+	return cap_inode_setxattr(dentry, name, value, size, flags);
 }
 
 static inline void security_inode_post_setxattr (struct dentry *dentry, char *name,
@@ -2155,7 +2157,7 @@
 
 static inline int security_inode_removexattr (struct dentry *dentry, char *name)
 {
-	return 0;
+	return cap_inode_removexattr(dentry, name);
 }
 
 static inline int security_inode_getsecurity(struct dentry *dentry, const char *name, void *buffer, size_t size)
===== security/capability.c 1.21 vs edited =====
--- 1.21/security/capability.c	Fri Sep 12 08:47:26 2003
+++ edited/security/capability.c	Fri Jan 16 12:14:15 2004
@@ -39,6 +39,9 @@
 	.bprm_set_security =		cap_bprm_set_security,
 	.bprm_secureexec =		cap_bprm_secureexec,
 
+	.inode_setxattr =		cap_inode_setxattr,
+	.inode_removexattr =		cap_inode_removexattr,
+
 	.task_post_setuid =		cap_task_post_setuid,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
 
===== security/commoncap.c 1.1 vs edited =====
--- 1.1/security/commoncap.c	Fri Sep 12 08:47:26 2003
+++ edited/security/commoncap.c	Fri Jan 16 12:14:15 2004
@@ -21,6 +21,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/ptrace.h>
+#include <linux/xattr.h>
 
 int cap_capable (struct task_struct *tsk, int cap)
 {
@@ -171,6 +172,25 @@
 		current->egid != current->gid);
 }
 
+int cap_inode_setxattr(struct dentry *dentry, char *name, void *value,
+		       size_t size, int flags)
+{
+	if (!strncmp(name, XATTR_SECURITY_PREFIX, 
+		     sizeof(XATTR_SECURITY_PREFIX) - 1)  &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	return 0;
+}
+
+int cap_inode_removexattr(struct dentry *dentry, char *name)
+{
+	if (!strncmp(name, XATTR_SECURITY_PREFIX, 
+		     sizeof(XATTR_SECURITY_PREFIX) - 1)  &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	return 0;
+}
+
 /* moved from kernel/sys.c. */
 /* 
  * cap_emulate_setxuid() fixes the effective / permitted capabilities of
@@ -344,6 +364,8 @@
 EXPORT_SYMBOL(cap_bprm_set_security);
 EXPORT_SYMBOL(cap_bprm_compute_creds);
 EXPORT_SYMBOL(cap_bprm_secureexec);
+EXPORT_SYMBOL(cap_inode_setxattr);
+EXPORT_SYMBOL(cap_inode_removexattr);
 EXPORT_SYMBOL(cap_task_post_setuid);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
 EXPORT_SYMBOL(cap_syslog);
===== security/dummy.c 1.28 vs edited =====
--- 1.28/security/dummy.c	Thu Oct  2 00:12:10 2003
+++ edited/security/dummy.c	Fri Jan 16 12:29:24 2004
@@ -24,6 +24,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <net/sock.h>
+#include <linux/xattr.h>
 
 static int dummy_ptrace (struct task_struct *parent, struct task_struct *child)
 {
@@ -387,6 +388,10 @@
 static int dummy_inode_setxattr (struct dentry *dentry, char *name, void *value,
 				size_t size, int flags)
 {
+	if (!strncmp(name, XATTR_SECURITY_PREFIX,
+		     sizeof(XATTR_SECURITY_PREFIX) - 1) &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
 	return 0;
 }
 
@@ -407,6 +412,10 @@
 
 static int dummy_inode_removexattr (struct dentry *dentry, char *name)
 {
+	if (!strncmp(name, XATTR_SECURITY_PREFIX,
+		     sizeof(XATTR_SECURITY_PREFIX) - 1) &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
 	return 0;
 }
 

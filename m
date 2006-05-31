Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWEaTIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWEaTIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWEaTIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:08:40 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:24307 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965099AbWEaTIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:08:39 -0400
Subject: [Fwd: [PATCH] remove unnecessary return value of audit_avc_path]
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-audit@redhat.com, Al Viro <viro@ftp.linux.org.uk>
Content-Type: text/plain
Date: Wed, 31 May 2006 15:08:16 -0400
Message-Id: <1149102496.9978.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm resending this as I've been told, to CC linux-audit. I'm also
adding Al Viro too.)

Is there any reason that audit_avc_path has a return value?  The only
two places in the kernel that it is used, the value is ignored, and when
it is turned off, we get a silly warning about "statement with no
effect".  Even the comment above the function states that it is only
used in one file.

So this patch removes the need to have a return value.

-- Steve

Signed-off-by: Steven Rostedt

Index: linux-2.6.17-rc5/include/linux/audit.h
===================================================================
--- linux-2.6.17-rc5.orig/include/linux/audit.h	2006-05-30 14:39:22.000000000 -0400
+++ linux-2.6.17-rc5/include/linux/audit.h	2006-05-30 14:39:45.000000000 -0400
@@ -324,7 +324,7 @@ extern int audit_ipc_obj(struct kern_ipc
 extern int audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode, struct kern_ipc_perm *ipcp);
 extern int audit_socketcall(int nargs, unsigned long *args);
 extern int audit_sockaddr(int len, void *addr);
-extern int audit_avc_path(struct dentry *dentry, struct vfsmount *mnt);
+extern void audit_avc_path(struct dentry *dentry, struct vfsmount *mnt);
 extern void audit_signal_info(int sig, struct task_struct *t);
 extern int audit_set_macxattr(const char *name);
 #else
@@ -344,7 +344,7 @@ extern int audit_set_macxattr(const char
 #define audit_ipc_set_perm(q,u,g,m,i) ({ 0; })
 #define audit_socketcall(n,a) ({ 0; })
 #define audit_sockaddr(len, addr) ({ 0; })
-#define audit_avc_path(dentry, mnt) ({ 0; })
+#define audit_avc_path(dentry, mnt) do { ; } while (0)
 #define audit_signal_info(s,t) do { ; } while (0)
 #define audit_set_macxattr(n) do { ; } while (0)
 #endif
Index: linux-2.6.17-rc5/kernel/auditsc.c
===================================================================
--- linux-2.6.17-rc5.orig/kernel/auditsc.c	2006-05-30 14:40:00.000000000 -0400
+++ linux-2.6.17-rc5/kernel/auditsc.c	2006-05-30 14:41:56.000000000 -0400
@@ -1292,21 +1292,19 @@ int audit_sockaddr(int len, void *a)
  * @dentry: dentry to record
  * @mnt: mnt to record
  *
- * Returns 0 for success or NULL context or < 0 on error.
- *
  * Called from security/selinux/avc.c::avc_audit()
  */
-int audit_avc_path(struct dentry *dentry, struct vfsmount *mnt)
+void audit_avc_path(struct dentry *dentry, struct vfsmount *mnt)
 {
 	struct audit_aux_data_path *ax;
 	struct audit_context *context = current->audit_context;
 
 	if (likely(!context))
-		return 0;
+		return;
 
 	ax = kmalloc(sizeof(*ax), GFP_ATOMIC);
 	if (!ax)
-		return -ENOMEM;
+		return;
 
 	ax->dentry = dget(dentry);
 	ax->mnt = mntget(mnt);
@@ -1314,7 +1312,7 @@ int audit_avc_path(struct dentry *dentry
 	ax->d.type = AUDIT_AVC_PATH;
 	ax->d.next = context->aux;
 	context->aux = (void *)ax;
-	return 0;
+	return;
 }
 
 /**





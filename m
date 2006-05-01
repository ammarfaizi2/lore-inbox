Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWEAKas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWEAKas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWEAKaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:30:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7048 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751336AbWEAK3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:29:54 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] change lspp ipc auditing
Message-Id: <E1FaVf7-00052V-L5@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:29:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Grubb <sgrubb@redhat.com>
Date: Fri Mar 31 15:22:49 2006 -0500

Hi,

The patch below converts IPC auditing to collect sid's and convert to context
string only if it needs to output an audit record. This patch depends on the
inode audit change patch already being applied.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/linux/security.h   |   16 ----------
 include/linux/selinux.h    |   15 ++++++++++
 kernel/auditsc.c           |   68 ++++++++++++++------------------------------
 security/dummy.c           |    6 ----
 security/selinux/exports.c |   11 +++++++
 security/selinux/hooks.c   |    8 -----
 6 files changed, 47 insertions(+), 77 deletions(-)

9c7aa6aa74fa8a5cda36e54cbbe4fffe0214497d
diff --git a/include/linux/security.h b/include/linux/security.h
index aaa0a5c..1bab48f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -869,11 +869,6 @@ #ifdef CONFIG_SECURITY
  *	@ipcp contains the kernel IPC permission structure
  *	@flag contains the desired (requested) permission set
  *	Return 0 if permission is granted.
- * @ipc_getsecurity:
- *      Copy the security label associated with the ipc object into
- *      @buffer.  @buffer may be NULL to request the size of the buffer 
- *      required.  @size indicates the size of @buffer in bytes. Return 
- *      number of bytes used/required on success.
  *
  * Security hooks for individual messages held in System V IPC message queues
  * @msg_msg_alloc_security:
@@ -1223,7 +1218,6 @@ struct security_operations {
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
-	int (*ipc_getsecurity)(struct kern_ipc_perm *ipcp, void *buffer, size_t size);
 
 	int (*msg_msg_alloc_security) (struct msg_msg * msg);
 	void (*msg_msg_free_security) (struct msg_msg * msg);
@@ -1887,11 +1881,6 @@ static inline int security_ipc_permissio
 	return security_ops->ipc_permission (ipcp, flag);
 }
 
-static inline int security_ipc_getsecurity(struct kern_ipc_perm *ipcp, void *buffer, size_t size)
-{
-	return security_ops->ipc_getsecurity(ipcp, buffer, size);
-}
-
 static inline int security_msg_msg_alloc (struct msg_msg * msg)
 {
 	return security_ops->msg_msg_alloc_security (msg);
@@ -2532,11 +2521,6 @@ static inline int security_ipc_permissio
 	return 0;
 }
 
-static inline int security_ipc_getsecurity(struct kern_ipc_perm *ipcp, void *buffer, size_t size)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int security_msg_msg_alloc (struct msg_msg * msg)
 {
 	return 0;
diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index 84a6c74..413d667 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -16,6 +16,7 @@ #define _LINUX_SELINUX_H
 struct selinux_audit_rule;
 struct audit_context;
 struct inode;
+struct kern_ipc_perm;
 
 #ifdef CONFIG_SECURITY_SELINUX
 
@@ -98,6 +99,15 @@ int selinux_ctxid_to_string(u32 ctxid, c
  */
 void selinux_get_inode_sid(const struct inode *inode, u32 *sid);
 
+/**
+ *     selinux_get_ipc_sid - get the ipc security context ID
+ *     @ipcp: ipc structure to get the sid from.
+ *     @sid: pointer to security context ID to be filled in.
+ *
+ *     Returns nothing
+ */
+void selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid);
+
 #else
 
 static inline int selinux_audit_rule_init(u32 field, u32 op,
@@ -141,6 +151,11 @@ static inline void selinux_get_inode_sid
 	*sid = 0;
 }
 
+static inline void selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid)
+{
+	*sid = 0;
+}
+
 #endif	/* CONFIG_SECURITY_SELINUX */
 
 #endif /* _LINUX_SELINUX_H */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2e123a8..b4f7223 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -107,7 +107,7 @@ struct audit_aux_data_ipcctl {
 	uid_t			uid;
 	gid_t			gid;
 	mode_t			mode;
-	char 			*ctx;
+	u32			osid;
 };
 
 struct audit_aux_data_socketcall {
@@ -432,11 +432,6 @@ static inline void audit_free_aux(struct
 			dput(axi->dentry);
 			mntput(axi->mnt);
 		}
-		if ( aux->type == AUDIT_IPC ) {
-			struct audit_aux_data_ipcctl *axi = (void *)aux;
-			if (axi->ctx)
-				kfree(axi->ctx);
-		}
 
 		context->aux = aux->next;
 		kfree(aux);
@@ -584,7 +579,7 @@ static void audit_log_task_info(struct a
 
 static void audit_log_exit(struct audit_context *context, struct task_struct *tsk)
 {
-	int i;
+	int i, call_panic = 0;
 	struct audit_buffer *ab;
 	struct audit_aux_data *aux;
 	const char *tty;
@@ -635,8 +630,20 @@ static void audit_log_exit(struct audit_
 		case AUDIT_IPC: {
 			struct audit_aux_data_ipcctl *axi = (void *)aux;
 			audit_log_format(ab, 
-					 " qbytes=%lx iuid=%u igid=%u mode=%x obj=%s",
-					 axi->qbytes, axi->uid, axi->gid, axi->mode, axi->ctx);
+				 " qbytes=%lx iuid=%u igid=%u mode=%x",
+				 axi->qbytes, axi->uid, axi->gid, axi->mode);
+			if (axi->osid != 0) {
+				char *ctx = NULL;
+				u32 len;
+				if (selinux_ctxid_to_string(
+						axi->osid, &ctx, &len)) {
+					audit_log_format(ab, " obj=%u",
+							axi->osid);
+					call_panic = 1;
+				} else
+					audit_log_format(ab, " obj=%s", ctx);
+				kfree(ctx);
+			}
 			break; }
 
 		case AUDIT_SOCKETCALL: {
@@ -671,7 +678,6 @@ static void audit_log_exit(struct audit_
 		}
 	}
 	for (i = 0; i < context->name_count; i++) {
-		int call_panic = 0;
 		unsigned long ino  = context->names[i].ino;
 		unsigned long pino = context->names[i].pino;
 
@@ -708,16 +714,16 @@ static void audit_log_exit(struct audit_
 				context->names[i].osid, &ctx, &len)) {
 				audit_log_format(ab, " obj=%u",
 						context->names[i].osid);
-				call_panic = 1;
+				call_panic = 2;
 			} else
 				audit_log_format(ab, " obj=%s", ctx);
 			kfree(ctx);
 		}
 
 		audit_log_end(ab);
-		if (call_panic)
-			audit_panic("error converting sid to string");
 	}
+	if (call_panic)
+		audit_panic("error converting sid to string");
 }
 
 /**
@@ -951,7 +957,7 @@ #if AUDIT_DEBUG
 #endif
 }
 
-void audit_inode_context(int idx, const struct inode *inode)
+static void audit_inode_context(int idx, const struct inode *inode)
 {
 	struct audit_context *context = current->audit_context;
 
@@ -1141,38 +1147,6 @@ uid_t audit_get_loginuid(struct audit_co
 	return ctx ? ctx->loginuid : -1;
 }
 
-static char *audit_ipc_context(struct kern_ipc_perm *ipcp)
-{
-	struct audit_context *context = current->audit_context;
-	char *ctx = NULL;
-	int len = 0;
-
-	if (likely(!context))
-		return NULL;
-
-	len = security_ipc_getsecurity(ipcp, NULL, 0);
-	if (len == -EOPNOTSUPP)
-		goto ret;
-	if (len < 0)
-		goto error_path;
-
-	ctx = kmalloc(len, GFP_ATOMIC);
-	if (!ctx)
-		goto error_path;
-
-	len = security_ipc_getsecurity(ipcp, ctx, len);
-	if (len < 0)
-		goto error_path;
-
-	return ctx;
-
-error_path:
-	kfree(ctx);
-	audit_panic("error in audit_ipc_context");
-ret:
-	return NULL;
-}
-
 /**
  * audit_ipc_perms - record audit data for ipc
  * @qbytes: msgq bytes
@@ -1198,7 +1172,7 @@ int audit_ipc_perms(unsigned long qbytes
 	ax->uid = uid;
 	ax->gid = gid;
 	ax->mode = mode;
-	ax->ctx = audit_ipc_context(ipcp);
+	selinux_get_ipc_sid(ipcp, &ax->osid);
 
 	ax->d.type = AUDIT_IPC;
 	ax->d.next = context->aux;
diff --git a/security/dummy.c b/security/dummy.c
index fd99429..8cccccc 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -563,11 +563,6 @@ static int dummy_ipc_permission (struct 
 	return 0;
 }
 
-static int dummy_ipc_getsecurity(struct kern_ipc_perm *ipcp, void *buffer, size_t size)
-{
-	return -EOPNOTSUPP;
-}
-
 static int dummy_msg_msg_alloc_security (struct msg_msg *msg)
 {
 	return 0;
@@ -976,7 +971,6 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_reparent_to_init);
  	set_to_dummy_if_null(ops, task_to_inode);
 	set_to_dummy_if_null(ops, ipc_permission);
-	set_to_dummy_if_null(ops, ipc_getsecurity);
 	set_to_dummy_if_null(ops, msg_msg_alloc_security);
 	set_to_dummy_if_null(ops, msg_msg_free_security);
 	set_to_dummy_if_null(ops, msg_queue_alloc_security);
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
index 07ddce7..7357cf2 100644
--- a/security/selinux/exports.c
+++ b/security/selinux/exports.c
@@ -15,6 +15,7 @@ #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/selinux.h>
 #include <linux/fs.h>
+#include <linux/ipc.h>
 
 #include "security.h"
 #include "objsec.h"
@@ -50,3 +51,13 @@ void selinux_get_inode_sid(const struct 
 	*sid = 0;
 }
 
+void selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid)
+{
+	if (selinux_enabled) {
+		struct ipc_security_struct *isec = ipcp->security;
+		*sid = isec->sid;
+		return;
+	}
+	*sid = 0;
+}
+
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b61b955..3cf368a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4052,13 +4052,6 @@ static int selinux_ipc_permission(struct
 	return ipc_has_perm(ipcp, av);
 }
 
-static int selinux_ipc_getsecurity(struct kern_ipc_perm *ipcp, void *buffer, size_t size)
-{
-	struct ipc_security_struct *isec = ipcp->security;
-
-	return selinux_getsecurity(isec->sid, buffer, size);
-}
-
 /* module stacking operations */
 static int selinux_register_security (const char *name, struct security_operations *ops)
 {
@@ -4321,7 +4314,6 @@ static struct security_operations selinu
 	.task_to_inode =                selinux_task_to_inode,
 
 	.ipc_permission =		selinux_ipc_permission,
-	.ipc_getsecurity =		selinux_ipc_getsecurity,
 
 	.msg_msg_alloc_security =	selinux_msg_msg_alloc_security,
 	.msg_msg_free_security =	selinux_msg_msg_free_security,
-- 
1.3.0.g0080f


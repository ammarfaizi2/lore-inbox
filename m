Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWEAK3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWEAK3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWEAK3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:29:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:6024 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751329AbWEAK3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:29:44 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] audit inode patch
Message-Id: <E1FaVex-00052B-Kc@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:29:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Grubb <sgrubb@redhat.com>
Date: Mon Apr 3 14:06:13 2006 -0400

Previously, we were gathering the context instead of the sid. Now in this patch,
we gather just the sid and convert to context only if an audit event is being
output.

This patch brings the performance hit from 146% down to 23%

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/linux/selinux.h    |   34 ++++++++++++++++++++++++++++
 kernel/auditsc.c           |   53 +++++++++++++-------------------------------
 security/selinux/exports.c |   24 ++++++++++++++++++++
 3 files changed, 74 insertions(+), 37 deletions(-)

1b50eed9cac0e8e5e4d3a522d8aa267f7f8f8acb
diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index 9d684b1..84a6c74 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -15,6 +15,7 @@ #define _LINUX_SELINUX_H
 
 struct selinux_audit_rule;
 struct audit_context;
+struct inode;
 
 #ifdef CONFIG_SECURITY_SELINUX
 
@@ -76,6 +77,27 @@ void selinux_audit_set_callback(int (*ca
  */
 void selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid);
 
+/**
+ *     selinux_ctxid_to_string - map a security context ID to a string
+ *     @ctxid: security context ID to be converted.
+ *     @ctx: address of context string to be returned
+ *     @ctxlen: length of returned context string.
+ *
+ *     Returns 0 if successful, -errno if not.  On success, the context
+ *     string will be allocated internally, and the caller must call
+ *     kfree() on it after use.
+ */
+int selinux_ctxid_to_string(u32 ctxid, char **ctx, u32 *ctxlen);
+
+/**
+ *     selinux_get_inode_sid - get the inode's security context ID
+ *     @inode: inode structure to get the sid from.
+ *     @sid: pointer to security context ID to be filled in.
+ *
+ *     Returns nothing
+ */
+void selinux_get_inode_sid(const struct inode *inode, u32 *sid);
+
 #else
 
 static inline int selinux_audit_rule_init(u32 field, u32 op,
@@ -107,6 +129,18 @@ static inline void selinux_task_ctxid(st
 	*ctxid = 0;
 }
 
+static inline int selinux_ctxid_to_string(u32 ctxid, char **ctx, u32 *ctxlen)
+{
+       *ctx = NULL;
+       *ctxlen = 0;
+       return 0;
+}
+
+static inline void selinux_get_inode_sid(const struct inode *inode, u32 *sid)
+{
+	*sid = 0;
+}
+
 #endif	/* CONFIG_SECURITY_SELINUX */
 
 #endif /* _LINUX_SELINUX_H */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d3d97d2..2e123a8 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -90,7 +90,7 @@ struct audit_names {
 	uid_t		uid;
 	gid_t		gid;
 	dev_t		rdev;
-	char		*ctx;
+	u32		osid;
 };
 
 struct audit_aux_data {
@@ -410,9 +410,6 @@ #if AUDIT_DEBUG
 #endif
 
 	for (i = 0; i < context->name_count; i++) {
-		char *p = context->names[i].ctx;
-		context->names[i].ctx = NULL;
-		kfree(p);
 		if (context->names[i].name)
 			__putname(context->names[i].name);
 	}
@@ -674,6 +671,7 @@ static void audit_log_exit(struct audit_
 		}
 	}
 	for (i = 0; i < context->name_count; i++) {
+		int call_panic = 0;
 		unsigned long ino  = context->names[i].ino;
 		unsigned long pino = context->names[i].pino;
 
@@ -703,12 +701,22 @@ static void audit_log_exit(struct audit_
 					 context->names[i].gid, 
 					 MAJOR(context->names[i].rdev), 
 					 MINOR(context->names[i].rdev));
-		if (context->names[i].ctx) {
-			audit_log_format(ab, " obj=%s",
-					context->names[i].ctx);
+		if (context->names[i].osid != 0) {
+			char *ctx = NULL;
+			u32 len;
+			if (selinux_ctxid_to_string(
+				context->names[i].osid, &ctx, &len)) {
+				audit_log_format(ab, " obj=%u",
+						context->names[i].osid);
+				call_panic = 1;
+			} else
+				audit_log_format(ab, " obj=%s", ctx);
+			kfree(ctx);
 		}
 
 		audit_log_end(ab);
+		if (call_panic)
+			audit_panic("error converting sid to string");
 	}
 }
 
@@ -946,37 +954,8 @@ #endif
 void audit_inode_context(int idx, const struct inode *inode)
 {
 	struct audit_context *context = current->audit_context;
-	const char *suffix = security_inode_xattr_getsuffix();
-	char *ctx = NULL;
-	int len = 0;
-
-	if (!suffix)
-		goto ret;
-
-	len = security_inode_getsecurity(inode, suffix, NULL, 0, 0);
-	if (len == -EOPNOTSUPP)
-		goto ret;
-	if (len < 0) 
-		goto error_path;
-
-	ctx = kmalloc(len, GFP_KERNEL);
-	if (!ctx) 
-		goto error_path;
-
-	len = security_inode_getsecurity(inode, suffix, ctx, len, 0);
-	if (len < 0)
-		goto error_path;
-
-	kfree(context->names[idx].ctx);
-	context->names[idx].ctx = ctx;
-	goto ret;
 
-error_path:
-	if (ctx)
-		kfree(ctx);
-	audit_panic("error in audit_inode_context");
-ret:
-	return;
+	selinux_get_inode_sid(inode, &context->names[idx].osid);
 }
 
 
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
index 333c4c7..07ddce7 100644
--- a/security/selinux/exports.c
+++ b/security/selinux/exports.c
@@ -14,6 +14,7 @@ #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/selinux.h>
+#include <linux/fs.h>
 
 #include "security.h"
 #include "objsec.h"
@@ -26,3 +27,26 @@ void selinux_task_ctxid(struct task_stru
 	else
 		*ctxid = 0;
 }
+
+int selinux_ctxid_to_string(u32 ctxid, char **ctx, u32 *ctxlen)
+{
+	if (selinux_enabled)
+		return security_sid_to_context(ctxid, ctx, ctxlen);
+	else {
+		*ctx = NULL;
+		*ctxlen = 0;
+	}
+
+	return 0;
+}
+
+void selinux_get_inode_sid(const struct inode *inode, u32 *sid)
+{
+	if (selinux_enabled) {
+		struct inode_security_struct *isec = inode->i_security;
+		*sid = isec->sid;
+		return;
+	}
+	*sid = 0;
+}
+
-- 
1.3.0.g0080f


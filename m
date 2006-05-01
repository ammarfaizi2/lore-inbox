Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWEAKb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWEAKb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWEAKay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:30:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7304 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751173AbWEAKaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:30:04 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] Reworked patch for labels on user space messages
Message-Id: <E1FaVfH-000531-LX@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:30:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Grubb <sgrubb@redhat.com>
Date: Mon Apr 3 09:08:13 2006 -0400

The below patch should be applied after the inode and ipc sid patches.
This patch is a reworking of Tim's patch that has been updated to match
the inode and ipc patches since its similar.

[updated:
>  Stephen Smalley also wanted to change a variable from isec to tsec in the
>  user sid patch.                                                              ]

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/linux/netlink.h    |    1 +
 include/linux/selinux.h    |   16 ++++++++++++++++
 kernel/audit.c             |   22 +++++++++++++++++++---
 net/netlink/af_netlink.c   |    2 ++
 security/selinux/exports.c |   11 +++++++++++
 5 files changed, 49 insertions(+), 3 deletions(-)

e7c3497013a7e5496ce3d5fd3c73b5cf5af7a56e
diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index f8f3d1c..87b8a57 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -143,6 +143,7 @@ struct netlink_skb_parms
 	__u32			dst_group;
 	kernel_cap_t		eff_cap;
 	__u32			loginuid;	/* Login (audit) uid */
+	__u32			sid;		/* SELinux security id */
 };
 
 #define NETLINK_CB(skb)		(*(struct netlink_skb_parms*)&((skb)->cb))
diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index 413d667..4047bcd 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
  * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ * Copyright (C) 2006 IBM Corporation, Timothy R. Chavez <tinytim@us.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2,
@@ -108,6 +109,16 @@ void selinux_get_inode_sid(const struct 
  */
 void selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid);
 
+/**
+ *     selinux_get_task_sid - return the SID of task
+ *     @tsk: the task whose SID will be returned
+ *     @sid: pointer to security context ID to be filled in.
+ *
+ *     Returns nothing
+ */
+void selinux_get_task_sid(struct task_struct *tsk, u32 *sid);
+
+
 #else
 
 static inline int selinux_audit_rule_init(u32 field, u32 op,
@@ -156,6 +167,11 @@ static inline void selinux_get_ipc_sid(c
 	*sid = 0;
 }
 
+static inline void selinux_get_task_sid(struct task_struct *tsk, u32 *sid)
+{
+	*sid = 0;
+}
+
 #endif	/* CONFIG_SECURITY_SELINUX */
 
 #endif /* _LINUX_SELINUX_H */
diff --git a/kernel/audit.c b/kernel/audit.c
index 9060be7..7ec9cca 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -390,7 +390,7 @@ static int audit_netlink_ok(kernel_cap_t
 
 static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 {
-	u32			uid, pid, seq;
+	u32			uid, pid, seq, sid;
 	void			*data;
 	struct audit_status	*status_get, status_set;
 	int			err;
@@ -416,6 +416,7 @@ static int audit_receive_msg(struct sk_b
 	pid  = NETLINK_CREDS(skb)->pid;
 	uid  = NETLINK_CREDS(skb)->uid;
 	loginuid = NETLINK_CB(skb).loginuid;
+	sid  = NETLINK_CB(skb).sid;
 	seq  = nlh->nlmsg_seq;
 	data = NLMSG_DATA(nlh);
 
@@ -468,8 +469,23 @@ static int audit_receive_msg(struct sk_b
 			ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
 			if (ab) {
 				audit_log_format(ab,
-						 "user pid=%d uid=%u auid=%u msg='%.1024s'",
-						 pid, uid, loginuid, (char *)data);
+						 "user pid=%d uid=%u auid=%u",
+						 pid, uid, loginuid);
+				if (sid) {
+					char *ctx = NULL;
+					u32 len;
+					if (selinux_ctxid_to_string(
+							sid, &ctx, &len)) {
+						audit_log_format(ab, 
+							" subj=%u", sid);
+						/* Maybe call audit_panic? */
+					} else
+						audit_log_format(ab, 
+							" subj=%s", ctx);
+					kfree(ctx);
+				}
+				audit_log_format(ab, " msg='%.1024s'",
+					 (char *)data);
 				audit_set_pid(ab, pid);
 				audit_log_end(ab);
 			}
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2a233ff..09fbc4b 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -56,6 +56,7 @@ #include <linux/bitops.h>
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <linux/audit.h>
+#include <linux/selinux.h>
 
 #include <net/sock.h>
 #include <net/scm.h>
@@ -1157,6 +1158,7 @@ static int netlink_sendmsg(struct kiocb 
 	NETLINK_CB(skb).dst_pid = dst_pid;
 	NETLINK_CB(skb).dst_group = dst_group;
 	NETLINK_CB(skb).loginuid = audit_get_loginuid(current->audit_context);
+	selinux_get_task_sid(current, &(NETLINK_CB(skb).sid));
 	memcpy(NETLINK_CREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
 
 	/* What can I do? Netlink is asynchronous, so that
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
index 7357cf2..ae4c73e 100644
--- a/security/selinux/exports.c
+++ b/security/selinux/exports.c
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
  * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ * Copyright (C) 2006 IBM Corporation, Timothy R. Chavez <tinytim@us.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2,
@@ -61,3 +62,13 @@ void selinux_get_ipc_sid(const struct ke
 	*sid = 0;
 }
 
+void selinux_get_task_sid(struct task_struct *tsk, u32 *sid)
+{
+	if (selinux_enabled) {
+		struct task_security_struct *tsec = tsk->security;
+		*sid = tsec->sid;
+		return;
+	}
+	*sid = 0;
+}
+
-- 
1.3.0.g0080f


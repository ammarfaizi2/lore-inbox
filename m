Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVAOUIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVAOUIY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 15:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVAOUIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 15:08:24 -0500
Received: from zimbo.cs.wm.edu ([128.239.2.64]:4247 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S262315AbVAOUHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 15:07:46 -0500
Date: Sat, 15 Jan 2005 15:07:34 -0500
From: "Serge E. Hallyn" <hallyn@CS.WM.EDU>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-audit@redhat.com
Subject: [PATCH] Fix audit control message checks
Message-ID: <20050115200734.GA22087@escher.cs.wm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The audit control messages are sent over netlink.  Permission checks
are done on the process receiving the message, which may not be the
same as the process sending the message.  This patch switches the
netlink_send security hooks to calculate the effective capabilities
based on the sender.  Then audit_receive_msg performs capability checks
based on that.

It also introduces the CAP_AUDIT_WRITE and CAP_AUDIT_CONTROL capabilities,
and replaces the previous CAP_SYS_ADMIN checks in audit code with the
appropriate checks.

Please apply.

Changelog:
	1/15/2005: Simplified dummy_netlink_send given that dummy now
		keeps track of capabilities.
	1/14/2005: Many fixes based on feedback from linux-audit@redhat.com
		list.
	1/14/2005: Removed the netlink_msg_type helper function.
	1/07/2005: Swith to using CAP_AUDIT_WRITE and CAP_AUDIT_CONTROL.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.10/include/linux/capability.h
===================================================================
--- linux-2.6.10.orig/include/linux/capability.h	2005-01-14 23:01:10.000000000 -0600
+++ linux-2.6.10/include/linux/capability.h	2005-01-14 23:01:12.000000000 -0600
@@ -284,6 +284,10 @@ typedef __u32 kernel_cap_t;
 
 #define CAP_LEASE            28
 
+#define CAP_AUDIT_WRITE      29
+
+#define CAP_AUDIT_CONTROL    30
+
 #ifdef __KERNEL__
 /* 
  * Bounding set
Index: linux-2.6.10/kernel/audit.c
===================================================================
--- linux-2.6.10.orig/kernel/audit.c	2005-01-14 23:01:10.000000000 -0600
+++ linux-2.6.10/kernel/audit.c	2005-01-14 23:21:17.000000000 -0600
@@ -300,21 +300,57 @@ nlmsg_failure:			/* Used by NLMSG_PUT */
 		kfree_skb(skb);
 }
 
+/*
+ * Check for appropriate CAP_AUDIT_ capabilities on incoming audit
+ * control messages.
+ */
+int audit_netlink_ok(kernel_cap_t eff_cap, u16 msg_type)
+{
+	int err = 0;
+
+	switch(msg_type) {
+		case AUDIT_GET:
+		case AUDIT_LIST:
+		case AUDIT_SET:
+		case AUDIT_LOGIN:
+		case AUDIT_ADD:
+		case AUDIT_DEL:
+			if (!cap_raised(eff_cap, CAP_AUDIT_CONTROL))
+				err = -EPERM;
+			break;
+
+		case AUDIT_USER:
+			if (!cap_raised(eff_cap, CAP_AUDIT_WRITE))
+				err = -EPERM;
+			break;
+
+		default:  /* bad msg */
+			err = -EINVAL;
+	}
+
+	return err;
+}
+
 static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 {
 	u32			uid, pid, seq;
 	void			*data;
 	struct audit_status	*status_get, status_set;
 	struct audit_login	*login;
-	int			err = 0;
+	int			err;
 	struct audit_buffer	*ab;
+	u16			msg_type = nlh->nlmsg_type;
+
+	err = audit_netlink_ok (NETLINK_CB(skb).eff_cap, msg_type);
+	if (err)
+		return err;
 
 	pid  = NETLINK_CREDS(skb)->pid;
 	uid  = NETLINK_CREDS(skb)->uid;
 	seq  = nlh->nlmsg_seq;
 	data = NLMSG_DATA(nlh);
 
-	switch (nlh->nlmsg_type) {
+	switch (msg_type) {
 	case AUDIT_GET:
 		status_set.enabled	 = audit_enabled;
 		status_set.failure	 = audit_failure;
@@ -327,8 +363,8 @@ static int audit_receive_msg(struct sk_b
 				 &status_set, sizeof(status_set));
 		break;
 	case AUDIT_SET:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
+		if (nlh->nlmsg_len < sizeof(struct audit_status))
+			return -EINVAL;
 		status_get   = (struct audit_status *)data;
 		if (status_get->mask & AUDIT_STATUS_ENABLED) {
 			err = audit_set_enabled(status_get->enabled);
@@ -364,8 +400,8 @@ static int audit_receive_msg(struct sk_b
 		audit_log_end(ab);
 		break;
 	case AUDIT_LOGIN:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
+		if (nlh->nlmsg_len < sizeof(struct audit_login))
+			return -EINVAL;
 		login = (struct audit_login *)data;
 		ab = audit_log_start(NULL);
 		if (ab) {
@@ -384,9 +420,12 @@ static int audit_receive_msg(struct sk_b
 					 login->loginuid);
 #endif
 		break;
-	case AUDIT_LIST:
 	case AUDIT_ADD:
 	case AUDIT_DEL:
+		if (nlh->nlmsg_len < sizeof(struct audit_rule))
+			return -EINVAL;
+		/* fallthrough */
+	case AUDIT_LIST:
 #ifdef CONFIG_AUDITSYSCALL
 		err = audit_receive_filter(nlh->nlmsg_type, pid, uid, seq,
 					   data);
Index: linux-2.6.10/kernel/auditsc.c
===================================================================
--- linux-2.6.10.orig/kernel/auditsc.c	2005-01-14 23:01:10.000000000 -0600
+++ linux-2.6.10/kernel/auditsc.c	2005-01-14 23:01:12.000000000 -0600
@@ -250,8 +250,6 @@ int audit_receive_filter(int type, int p
 		audit_send_reply(pid, seq, AUDIT_LIST, 1, 1, NULL, 0);
 		break;
 	case AUDIT_ADD:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		if (!(entry = kmalloc(sizeof(*entry), GFP_KERNEL)))
 			return -ENOMEM;
 		if (audit_copy_rule(&entry->rule, data)) {
Index: linux-2.6.10/security/dummy.c
===================================================================
--- linux-2.6.10.orig/security/dummy.c	2005-01-14 23:01:10.000000000 -0600
+++ linux-2.6.10/security/dummy.c	2005-01-15 15:14:35.000000000 -0600
@@ -685,10 +685,7 @@ static int dummy_sem_semop (struct sem_a
 
 static int dummy_netlink_send (struct sock *sk, struct sk_buff *skb)
 {
-	if (current->euid == 0)
-		cap_raise (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN);
-	else
-		NETLINK_CB (skb).eff_cap = 0;
+	NETLINK_CB(skb).eff_cap = current->cap_effective;
 	return 0;
 }
 
Index: linux-2.6.10/security/selinux/hooks.c
===================================================================
--- linux-2.6.10.orig/security/selinux/hooks.c	2005-01-14 23:01:10.000000000 -0600
+++ linux-2.6.10/security/selinux/hooks.c	2005-01-14 23:01:12.000000000 -0600
@@ -3502,12 +3502,20 @@ static inline int selinux_nlmsg_perm(str
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	int err = 0;
+	struct task_security_struct *tsec;
+	struct av_decision avd;
+	int err;
 
-	if (capable(CAP_NET_ADMIN))
-		cap_raise (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN);
-	else
-		NETLINK_CB(skb).eff_cap = 0;
+	err = secondary_ops->netlink_send(sk, skb);
+	if (err)
+		return err;
+	
+	tsec = current->security;
+
+	avd.allowed = 0;
+	(void)avc_has_perm_noaudit(tsec->sid, tsec->sid,
+				SECCLASS_CAPABILITY, ~0, &avd);
+	cap_mask(NETLINK_CB(skb).eff_cap, avd.allowed);
 
 	if (policydb_loaded_version >= POLICYDB_VERSION_NLCLASS)
 		err = selinux_nlmsg_perm(sk, skb);

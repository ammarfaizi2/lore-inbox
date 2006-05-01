Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWEAKb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWEAKb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWEAKaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:30:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7560 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751334AbWEAKaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:30:14 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] More user space subject labels
Message-Id: <E1FaVfR-00053K-Lw@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:30:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Grubb <sgrubb@redhat.com>
Date: Sat Apr 1 18:29:34 2006 -0500

Hi,

The patch below builds upon the patch sent earlier and adds subject label to
all audit events generated via the netlink interface. It also cleans up a few
other minor things.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/linux/audit.h |    2 -
 kernel/audit.c        |  132 ++++++++++++++++++++++++++++++++++++++-----------
 kernel/auditfilter.c  |   44 ++++++++++++++--
 kernel/auditsc.c      |    4 +
 4 files changed, 142 insertions(+), 40 deletions(-)

ce29b682e228c70cdc91a1b2935c5adb2087bab8
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 740f950..d5c4082 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -371,7 +371,7 @@ extern void		    audit_log_d_path(struct
 extern int audit_filter_user(struct netlink_skb_parms *cb, int type);
 extern int audit_filter_type(int type);
 extern int  audit_receive_filter(int type, int pid, int uid, int seq,
-				 void *data, size_t datasz, uid_t loginuid);
+			 void *data, size_t datasz, uid_t loginuid, u32 sid);
 #else
 #define audit_log(c,g,t,f,...) do { ; } while (0)
 #define audit_log_start(c,g,t) ({ NULL; })
diff --git a/kernel/audit.c b/kernel/audit.c
index 7ec9cca..df57b49 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -230,49 +230,103 @@ void audit_log_lost(const char *message)
 	}
 }
 
-static int audit_set_rate_limit(int limit, uid_t loginuid)
+static int audit_set_rate_limit(int limit, uid_t loginuid, u32 sid)
 {
-	int old		 = audit_rate_limit;
-	audit_rate_limit = limit;
-	audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE, 
+	int old	= audit_rate_limit;
+
+	if (sid) {
+		char *ctx = NULL;
+		u32 len;
+		int rc;
+		if ((rc = selinux_ctxid_to_string(sid, &ctx, &len)))
+			return rc;
+		else
+			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+				"audit_rate_limit=%d old=%d by auid=%u subj=%s",
+				limit, old, loginuid, ctx);
+		kfree(ctx);
+	} else
+		audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 			"audit_rate_limit=%d old=%d by auid=%u",
-			audit_rate_limit, old, loginuid);
+			limit, old, loginuid);
+	audit_rate_limit = limit;
 	return old;
 }
 
-static int audit_set_backlog_limit(int limit, uid_t loginuid)
+static int audit_set_backlog_limit(int limit, uid_t loginuid, u32 sid)
 {
-	int old		 = audit_backlog_limit;
-	audit_backlog_limit = limit;
-	audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+	int old	= audit_backlog_limit;
+
+	if (sid) {
+		char *ctx = NULL;
+		u32 len;
+		int rc;
+		if ((rc = selinux_ctxid_to_string(sid, &ctx, &len)))
+			return rc;
+		else
+			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+			    "audit_backlog_limit=%d old=%d by auid=%u subj=%s",
+				limit, old, loginuid, ctx);
+		kfree(ctx);
+	} else
+		audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 			"audit_backlog_limit=%d old=%d by auid=%u",
-			audit_backlog_limit, old, loginuid);
+			limit, old, loginuid);
+	audit_backlog_limit = limit;
 	return old;
 }
 
-static int audit_set_enabled(int state, uid_t loginuid)
+static int audit_set_enabled(int state, uid_t loginuid, u32 sid)
 {
-	int old		 = audit_enabled;
+	int old = audit_enabled;
+
 	if (state != 0 && state != 1)
 		return -EINVAL;
-	audit_enabled = state;
-	audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+
+	if (sid) {
+		char *ctx = NULL;
+		u32 len;
+		int rc;
+		if ((rc = selinux_ctxid_to_string(sid, &ctx, &len)))
+			return rc;
+		else
+			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+				"audit_enabled=%d old=%d by auid=%u subj=%s",
+				state, old, loginuid, ctx);
+		kfree(ctx);
+	} else
+		audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 			"audit_enabled=%d old=%d by auid=%u",
-			audit_enabled, old, loginuid);
+			state, old, loginuid);
+	audit_enabled = state;
 	return old;
 }
 
-static int audit_set_failure(int state, uid_t loginuid)
+static int audit_set_failure(int state, uid_t loginuid, u32 sid)
 {
-	int old		 = audit_failure;
+	int old = audit_failure;
+
 	if (state != AUDIT_FAIL_SILENT
 	    && state != AUDIT_FAIL_PRINTK
 	    && state != AUDIT_FAIL_PANIC)
 		return -EINVAL;
-	audit_failure = state;
-	audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+
+	if (sid) {
+		char *ctx = NULL;
+		u32 len;
+		int rc;
+		if ((rc = selinux_ctxid_to_string(sid, &ctx, &len)))
+			return rc;
+		else
+			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+				"audit_failure=%d old=%d by auid=%u subj=%s",
+				state, old, loginuid, ctx);
+		kfree(ctx);
+	} else
+		audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
 			"audit_failure=%d old=%d by auid=%u",
-			audit_failure, old, loginuid);
+			state, old, loginuid);
+	audit_failure = state;
 	return old;
 }
 
@@ -437,25 +491,43 @@ static int audit_receive_msg(struct sk_b
 			return -EINVAL;
 		status_get   = (struct audit_status *)data;
 		if (status_get->mask & AUDIT_STATUS_ENABLED) {
-			err = audit_set_enabled(status_get->enabled, loginuid);
+			err = audit_set_enabled(status_get->enabled,
+							loginuid, sid);
 			if (err < 0) return err;
 		}
 		if (status_get->mask & AUDIT_STATUS_FAILURE) {
-			err = audit_set_failure(status_get->failure, loginuid);
+			err = audit_set_failure(status_get->failure,
+							 loginuid, sid);
 			if (err < 0) return err;
 		}
 		if (status_get->mask & AUDIT_STATUS_PID) {
 			int old   = audit_pid;
+			if (sid) {
+				char *ctx = NULL;
+				u32 len;
+				int rc;
+				if ((rc = selinux_ctxid_to_string(
+						sid, &ctx, &len)))
+					return rc;
+				else
+					audit_log(NULL, GFP_KERNEL,
+						AUDIT_CONFIG_CHANGE,
+						"audit_pid=%d old=%d by auid=%u subj=%s",
+						status_get->pid, old,
+						loginuid, ctx);
+				kfree(ctx);
+			} else
+				audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+					"audit_pid=%d old=%d by auid=%u",
+					  status_get->pid, old, loginuid);
 			audit_pid = status_get->pid;
-			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
-				"audit_pid=%d old=%d by auid=%u",
-				  audit_pid, old, loginuid);
 		}
 		if (status_get->mask & AUDIT_STATUS_RATE_LIMIT)
-			audit_set_rate_limit(status_get->rate_limit, loginuid);
+			audit_set_rate_limit(status_get->rate_limit,
+							 loginuid, sid);
 		if (status_get->mask & AUDIT_STATUS_BACKLOG_LIMIT)
 			audit_set_backlog_limit(status_get->backlog_limit,
-							loginuid);
+							loginuid, sid);
 		break;
 	case AUDIT_USER:
 	case AUDIT_FIRST_USER_MSG...AUDIT_LAST_USER_MSG:
@@ -477,7 +549,7 @@ static int audit_receive_msg(struct sk_b
 					if (selinux_ctxid_to_string(
 							sid, &ctx, &len)) {
 						audit_log_format(ab, 
-							" subj=%u", sid);
+							" ssid=%u", sid);
 						/* Maybe call audit_panic? */
 					} else
 						audit_log_format(ab, 
@@ -499,7 +571,7 @@ static int audit_receive_msg(struct sk_b
 	case AUDIT_LIST:
 		err = audit_receive_filter(nlh->nlmsg_type, NETLINK_CB(skb).pid,
 					   uid, seq, data, nlmsg_len(nlh),
-					   loginuid);
+					   loginuid, sid);
 		break;
 	case AUDIT_ADD_RULE:
 	case AUDIT_DEL_RULE:
@@ -509,7 +581,7 @@ static int audit_receive_msg(struct sk_b
 	case AUDIT_LIST_RULES:
 		err = audit_receive_filter(nlh->nlmsg_type, NETLINK_CB(skb).pid,
 					   uid, seq, data, nlmsg_len(nlh),
-					   loginuid);
+					   loginuid, sid);
 		break;
 	case AUDIT_SIGNAL_INFO:
 		sig_data.uid = audit_sig_uid;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 85a7862..7c13490 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -586,9 +586,10 @@ static int audit_list_rules(void *_dest)
  * @data: payload data
  * @datasz: size of payload data
  * @loginuid: loginuid of sender
+ * @sid: SE Linux Security ID of sender
  */
 int audit_receive_filter(int type, int pid, int uid, int seq, void *data,
-			 size_t datasz, uid_t loginuid)
+			 size_t datasz, uid_t loginuid, u32 sid)
 {
 	struct task_struct *tsk;
 	int *dest;
@@ -631,9 +632,23 @@ int audit_receive_filter(int type, int p
 
 		err = audit_add_rule(entry,
 				     &audit_filter_list[entry->rule.listnr]);
-		audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
-			"auid=%u add rule to list=%d res=%d\n",
-			loginuid, entry->rule.listnr, !err);
+		if (sid) {
+			char *ctx = NULL;
+			u32 len;
+			if (selinux_ctxid_to_string(sid, &ctx, &len)) {
+				/* Maybe call audit_panic? */
+				audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+				 "auid=%u ssid=%u add rule to list=%d res=%d",
+				 loginuid, sid, entry->rule.listnr, !err);
+			} else
+				audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+				 "auid=%u subj=%s add rule to list=%d res=%d",
+				 loginuid, ctx, entry->rule.listnr, !err);
+			kfree(ctx);
+		} else
+			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+				"auid=%u add rule to list=%d res=%d",
+				loginuid, entry->rule.listnr, !err);
 
 		if (err)
 			audit_free_rule(entry);
@@ -649,9 +664,24 @@ int audit_receive_filter(int type, int p
 
 		err = audit_del_rule(entry,
 				     &audit_filter_list[entry->rule.listnr]);
-		audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
-			"auid=%u remove rule from list=%d res=%d\n",
-			loginuid, entry->rule.listnr, !err);
+
+		if (sid) {
+			char *ctx = NULL;
+			u32 len;
+			if (selinux_ctxid_to_string(sid, &ctx, &len)) {
+				/* Maybe call audit_panic? */
+				audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+					"auid=%u ssid=%u remove rule from list=%d res=%d",
+					 loginuid, sid, entry->rule.listnr, !err);
+			} else
+				audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+					"auid=%u subj=%s remove rule from list=%d res=%d",
+					 loginuid, ctx, entry->rule.listnr, !err);
+			kfree(ctx);
+		} else
+			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+				"auid=%u remove rule from list=%d res=%d",
+				loginuid, entry->rule.listnr, !err);
 
 		audit_free_rule(entry);
 		break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b4f7223..d94e040 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -637,7 +637,7 @@ static void audit_log_exit(struct audit_
 				u32 len;
 				if (selinux_ctxid_to_string(
 						axi->osid, &ctx, &len)) {
-					audit_log_format(ab, " obj=%u",
+					audit_log_format(ab, " osid=%u",
 							axi->osid);
 					call_panic = 1;
 				} else
@@ -712,7 +712,7 @@ static void audit_log_exit(struct audit_
 			u32 len;
 			if (selinux_ctxid_to_string(
 				context->names[i].osid, &ctx, &len)) {
-				audit_log_format(ab, " obj=%u",
+				audit_log_format(ab, " osid=%u",
 						context->names[i].osid);
 				call_panic = 2;
 			} else
-- 
1.3.0.g0080f


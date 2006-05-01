Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWEAK3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWEAK3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWEAK3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:29:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5768 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751327AbWEAK3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:29:34 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] support for context based audit filtering, part 2
Message-Id: <E1FaVen-000523-KA@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:29:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrel Goeddel <dgoeddel@trustedcs.com>
Date: Fri Mar 10 18:14:06 2006 -0600

This patch provides the ability to filter audit messages based on the
elements of the process' SELinux context (user, role, type, mls sensitivity,
and mls clearance).  It uses the new interfaces from selinux to opaquely
store information related to the selinux context and to filter based on that
information.  It also uses the callback mechanism provided by selinux to
refresh the information when a new policy is loaded.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 kernel/audit.c       |    8 ++
 kernel/audit.h       |   10 +-
 kernel/auditfilter.c |  245 +++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/auditsc.c     |   20 ++++
 4 files changed, 256 insertions(+), 27 deletions(-)

3dc7e3153eddfcf7ba8b50628775ba516e5f759f
diff --git a/kernel/audit.c b/kernel/audit.c
index c8ccbd0..9060be7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -55,6 +55,9 @@ #include <net/sock.h>
 #include <net/netlink.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <linux/selinux.h>
+
+#include "audit.h"
 
 /* No auditing will take place until audit_initialized != 0.
  * (Initialization happens after skb_init is called.) */
@@ -564,6 +567,11 @@ static int __init audit_init(void)
 	skb_queue_head_init(&audit_skb_queue);
 	audit_initialized = 1;
 	audit_enabled = audit_default;
+
+	/* Register the callback with selinux.  This callback will be invoked
+	 * when a new policy is loaded. */
+	selinux_audit_set_callback(&selinux_audit_rule_update);
+
 	audit_log(NULL, GFP_KERNEL, AUDIT_KERNEL, "initialized");
 	return 0;
 }
diff --git a/kernel/audit.h b/kernel/audit.h
index bc53920..6f73392 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -54,9 +54,11 @@ enum audit_state {
 
 /* Rule lists */
 struct audit_field {
-	u32			type;
-	u32			val;
-	u32			op;
+	u32				type;
+	u32				val;
+	u32				op;
+	char				*se_str;
+	struct selinux_audit_rule	*se_rule;
 };
 
 struct audit_krule {
@@ -86,3 +88,5 @@ extern void		    audit_send_reply(int pi
 extern void		    audit_log_lost(const char *message);
 extern void		    audit_panic(const char *message);
 extern struct mutex audit_netlink_mutex;
+
+extern int selinux_audit_rule_update(void);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index d3a8539..85a7862 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -23,6 +23,7 @@ #include <linux/kernel.h>
 #include <linux/audit.h>
 #include <linux/kthread.h>
 #include <linux/netlink.h>
+#include <linux/selinux.h>
 #include "audit.h"
 
 /* There are three lists of rules -- one to search at task creation
@@ -42,6 +43,13 @@ #endif
 
 static inline void audit_free_rule(struct audit_entry *e)
 {
+	int i;
+	if (e->rule.fields)
+		for (i = 0; i < e->rule.field_count; i++) {
+			struct audit_field *f = &e->rule.fields[i];
+			kfree(f->se_str);
+			selinux_audit_rule_free(f->se_rule);
+		}
 	kfree(e->rule.fields);
 	kfree(e);
 }
@@ -52,9 +60,29 @@ static inline void audit_free_rule_rcu(s
 	audit_free_rule(e);
 }
 
+/* Initialize an audit filterlist entry. */
+static inline struct audit_entry *audit_init_entry(u32 field_count)
+{
+	struct audit_entry *entry;
+	struct audit_field *fields;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (unlikely(!entry))
+		return NULL;
+
+	fields = kzalloc(sizeof(*fields) * field_count, GFP_KERNEL);
+	if (unlikely(!fields)) {
+		kfree(entry);
+		return NULL;
+	}
+	entry->rule.fields = fields;
+
+	return entry;
+}
+
 /* Unpack a filter field's string representation from user-space
  * buffer. */
-static __attribute__((unused)) char *audit_unpack_string(void **bufp, size_t *remain, size_t len)
+static char *audit_unpack_string(void **bufp, size_t *remain, size_t len)
 {
 	char *str;
 
@@ -84,7 +112,6 @@ static inline struct audit_entry *audit_
 {
 	unsigned listnr;
 	struct audit_entry *entry;
-	struct audit_field *fields;
 	int i, err;
 
 	err = -EINVAL;
@@ -108,23 +135,14 @@ #endif
 		goto exit_err;
 
 	err = -ENOMEM;
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (unlikely(!entry))
-		goto exit_err;
-	fields = kmalloc(sizeof(*fields) * rule->field_count, GFP_KERNEL);
-	if (unlikely(!fields)) {
-		kfree(entry);
+	entry = audit_init_entry(rule->field_count);
+	if (!entry)
 		goto exit_err;
-	}
-
-	memset(&entry->rule, 0, sizeof(struct audit_krule));
-	memset(fields, 0, sizeof(struct audit_field));
 
 	entry->rule.flags = rule->flags & AUDIT_FILTER_PREPEND;
 	entry->rule.listnr = listnr;
 	entry->rule.action = rule->action;
 	entry->rule.field_count = rule->field_count;
-	entry->rule.fields = fields;
 
 	for (i = 0; i < AUDIT_BITMASK_SIZE; i++)
 		entry->rule.mask[i] = rule->mask[i];
@@ -150,15 +168,20 @@ static struct audit_entry *audit_rule_to
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &entry->rule.fields[i];
 
-		if (rule->fields[i] & AUDIT_UNUSED_BITS) {
-			err = -EINVAL;
-			goto exit_free;
-		}
-
 		f->op = rule->fields[i] & (AUDIT_NEGATE|AUDIT_OPERATORS);
 		f->type = rule->fields[i] & ~(AUDIT_NEGATE|AUDIT_OPERATORS);
 		f->val = rule->values[i];
 
+		if (f->type & AUDIT_UNUSED_BITS ||
+		    f->type == AUDIT_SE_USER ||
+		    f->type == AUDIT_SE_ROLE ||
+		    f->type == AUDIT_SE_TYPE ||
+		    f->type == AUDIT_SE_SEN ||
+		    f->type == AUDIT_SE_CLR) {
+			err = -EINVAL;
+			goto exit_free;
+		}
+
 		entry->rule.vers_ops = (f->op & AUDIT_OPERATORS) ? 2 : 1;
 
 		/* Support for legacy operators where
@@ -188,8 +211,9 @@ static struct audit_entry *audit_data_to
 	int err = 0;
 	struct audit_entry *entry;
 	void *bufp;
-	/* size_t remain = datasz - sizeof(struct audit_rule_data); */
+	size_t remain = datasz - sizeof(struct audit_rule_data);
 	int i;
+	char *str;
 
 	entry = audit_to_entry_common((struct audit_rule *)data);
 	if (IS_ERR(entry))
@@ -207,10 +231,35 @@ static struct audit_entry *audit_data_to
 
 		f->op = data->fieldflags[i] & AUDIT_OPERATORS;
 		f->type = data->fields[i];
+		f->val = data->values[i];
+		f->se_str = NULL;
+		f->se_rule = NULL;
 		switch(f->type) {
-		/* call type-specific conversion routines here */
-		default:
-			f->val = data->values[i];
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			str = audit_unpack_string(&bufp, &remain, f->val);
+			if (IS_ERR(str))
+				goto exit_free;
+			entry->rule.buflen += f->val;
+
+			err = selinux_audit_rule_init(f->type, f->op, str,
+						      &f->se_rule);
+			/* Keep currently invalid fields around in case they
+			 * become valid after a policy reload. */
+			if (err == -EINVAL) {
+				printk(KERN_WARNING "audit rule for selinux "
+				       "\'%s\' is invalid\n",  str);
+				err = 0;
+			}
+			if (err) {
+				kfree(str);
+				goto exit_free;
+			} else
+				f->se_str = str;
+			break;
 		}
 	}
 
@@ -286,7 +335,14 @@ static struct audit_rule_data *audit_kru
 		data->fields[i] = f->type;
 		data->fieldflags[i] = f->op;
 		switch(f->type) {
-		/* call type-specific conversion routines here */
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			data->buflen += data->values[i] =
+				audit_pack_string(&bufp, f->se_str);
+			break;
 		default:
 			data->values[i] = f->val;
 		}
@@ -314,7 +370,14 @@ static int audit_compare_rule(struct aud
 			return 1;
 
 		switch(a->fields[i].type) {
-		/* call type-specific comparison routines here */
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			if (strcmp(a->fields[i].se_str, b->fields[i].se_str))
+				return 1;
+			break;
 		default:
 			if (a->fields[i].val != b->fields[i].val)
 				return 1;
@@ -328,6 +391,81 @@ static int audit_compare_rule(struct aud
 	return 0;
 }
 
+/* Duplicate selinux field information.  The se_rule is opaque, so must be
+ * re-initialized. */
+static inline int audit_dupe_selinux_field(struct audit_field *df,
+					   struct audit_field *sf)
+{
+	int ret = 0;
+	char *se_str;
+
+	/* our own copy of se_str */
+	se_str = kstrdup(sf->se_str, GFP_KERNEL);
+	if (unlikely(IS_ERR(se_str)))
+	    return -ENOMEM;
+	df->se_str = se_str;
+
+	/* our own (refreshed) copy of se_rule */
+	ret = selinux_audit_rule_init(df->type, df->op, df->se_str,
+				      &df->se_rule);
+	/* Keep currently invalid fields around in case they
+	 * become valid after a policy reload. */
+	if (ret == -EINVAL) {
+		printk(KERN_WARNING "audit rule for selinux \'%s\' is "
+		       "invalid\n", df->se_str);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/* Duplicate an audit rule.  This will be a deep copy with the exception
+ * of the watch - that pointer is carried over.  The selinux specific fields
+ * will be updated in the copy.  The point is to be able to replace the old
+ * rule with the new rule in the filterlist, then free the old rule. */
+static struct audit_entry *audit_dupe_rule(struct audit_krule *old)
+{
+	u32 fcount = old->field_count;
+	struct audit_entry *entry;
+	struct audit_krule *new;
+	int i, err = 0;
+
+	entry = audit_init_entry(fcount);
+	if (unlikely(!entry))
+		return ERR_PTR(-ENOMEM);
+
+	new = &entry->rule;
+	new->vers_ops = old->vers_ops;
+	new->flags = old->flags;
+	new->listnr = old->listnr;
+	new->action = old->action;
+	for (i = 0; i < AUDIT_BITMASK_SIZE; i++)
+		new->mask[i] = old->mask[i];
+	new->buflen = old->buflen;
+	new->field_count = old->field_count;
+	memcpy(new->fields, old->fields, sizeof(struct audit_field) * fcount);
+
+	/* deep copy this information, updating the se_rule fields, because
+	 * the originals will all be freed when the old rule is freed. */
+	for (i = 0; i < fcount; i++) {
+		switch (new->fields[i].type) {
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			err = audit_dupe_selinux_field(&new->fields[i],
+						       &old->fields[i]);
+		}
+		if (err) {
+			audit_free_rule(entry);
+			return ERR_PTR(err);
+		}
+	}
+
+	return entry;
+}
+
 /* Add rule to given filterlist if not a duplicate.  Protected by
  * audit_netlink_mutex. */
 static inline int audit_add_rule(struct audit_entry *entry,
@@ -628,3 +766,62 @@ unlock_and_return:
 	rcu_read_unlock();
 	return result;
 }
+
+/* Check to see if the rule contains any selinux fields.  Returns 1 if there
+   are selinux fields specified in the rule, 0 otherwise. */
+static inline int audit_rule_has_selinux(struct audit_krule *rule)
+{
+	int i;
+
+	for (i = 0; i < rule->field_count; i++) {
+		struct audit_field *f = &rule->fields[i];
+		switch (f->type) {
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/* This function will re-initialize the se_rule field of all applicable rules.
+ * It will traverse the filter lists serarching for rules that contain selinux
+ * specific filter fields.  When such a rule is found, it is copied, the
+ * selinux field is re-initialized, and the old rule is replaced with the
+ * updated rule. */
+int selinux_audit_rule_update(void)
+{
+	struct audit_entry *entry, *n, *nentry;
+	int i, err = 0;
+
+	/* audit_netlink_mutex synchronizes the writers */
+	mutex_lock(&audit_netlink_mutex);
+
+	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
+		list_for_each_entry_safe(entry, n, &audit_filter_list[i], list) {
+			if (!audit_rule_has_selinux(&entry->rule))
+				continue;
+
+			nentry = audit_dupe_rule(&entry->rule);
+			if (unlikely(IS_ERR(nentry))) {
+				/* save the first error encountered for the
+				 * return value */
+				if (!err)
+					err = PTR_ERR(nentry);
+				audit_panic("error updating selinux filters");
+				list_del_rcu(&entry->list);
+			} else {
+				list_replace_rcu(&entry->list, &nentry->list);
+			}
+			call_rcu(&entry->rcu, audit_free_rule_rcu);
+		}
+	}
+
+	mutex_unlock(&audit_netlink_mutex);
+
+	return err;
+}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8aca4ab..d3d97d2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -58,6 +58,7 @@ #include <asm/unistd.h>
 #include <linux/security.h>
 #include <linux/list.h>
 #include <linux/tty.h>
+#include <linux/selinux.h>
 
 #include "audit.h"
 
@@ -168,6 +169,9 @@ static int audit_filter_rules(struct tas
 			      enum audit_state *state)
 {
 	int i, j;
+	u32 sid;
+
+	selinux_task_ctxid(tsk, &sid);
 
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
@@ -257,6 +261,22 @@ static int audit_filter_rules(struct tas
 			if (ctx)
 				result = audit_comparator(ctx->loginuid, f->op, f->val);
 			break;
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			/* NOTE: this may return negative values indicating
+			   a temporary error.  We simply treat this as a
+			   match for now to avoid losing information that
+			   may be wanted.   An error message will also be
+			   logged upon error */
+			if (f->se_rule)
+				result = selinux_audit_rule_match(sid, f->type,
+				                                  f->op,
+				                                  f->se_rule,
+				                                  ctx);
+			break;
 		case AUDIT_ARG0:
 		case AUDIT_ARG1:
 		case AUDIT_ARG2:
-- 
1.3.0.g0080f


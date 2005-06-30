Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263026AbVF3Tpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbVF3Tpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbVF3Tpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:45:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:61060 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263026AbVF3Tnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:43:35 -0400
Date: Thu, 30 Jun 2005 14:49:27 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
Subject: [patch 3/12] lsm stacking v0.2: introduce security_*_value API
Message-ID: <20050630194927.GC23538@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630194458.GA23439@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define the functions to be used by LSMs to add, retrieve, and remove
elements to the kernel object ->security hlists.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 include/linux/security-stack.h |   51 +++++++++++++++++++++++++++
 include/linux/security.h       |   29 +++++++++++++++
 security/security.c            |   75 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)

Index: linux-2.6.13-rc1/include/linux/security-stack.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc1/include/linux/security-stack.h	2005-06-30 14:11:36.000000000 -0500
@@ -0,0 +1,51 @@
+/*
+ * security-stack.h
+ *
+ * Contains function prototypes or inline definitions for the
+ * function which manipulate kernel object security annotations.
+ *
+ * If stacker is compiled in, then we use the full functions as
+ * defined in security/security.c.  Otherwise we use the #defines
+ * here.
+ */
+
+#ifdef CONFIG_SECURITY_STACKER
+extern struct security_list *security_get_value(struct hlist_head *head,
+			int security_id);
+
+extern struct security_list *security_set_value(struct hlist_head *head,
+			int security_id, struct security_list *obj_node);
+extern struct security_list *security_add_value(struct hlist_head *head,
+			int security_id, struct security_list *obj_node);
+extern struct security_list *security_del_value(struct hlist_head *head,
+			int security_id);
+#else
+static inline struct security_list *
+security_get_value(struct hlist_head *head, int security_id)
+{
+	struct hlist_node *tmp = head->first;
+	return tmp ? hlist_entry(tmp, struct security_list, list) : NULL;
+}
+
+static inline struct security_list *
+security_set_value(struct hlist_head *head, int security_id,
+	struct security_list *obj_node)
+{
+	head->first = &obj_node->list;
+}
+
+static inline struct security_list *
+security_add_value(struct hlist_head *head, int security_id,
+	struct security_list *obj_node)
+{
+	head->first = &obj_node->list;
+}
+
+static inline struct security_list *
+security_del_value(struct hlist_head *head, int security_id)
+{
+	struct hlist_node *tmp = head->first;
+	head->first = NULL;
+	return tmp ? hlist_entry(tmp, struct security_list, list) : NULL;
+}
+#endif
Index: linux-2.6.13-rc1/include/linux/security.h
===================================================================
--- linux-2.6.13-rc1.orig/include/linux/security.h	2005-06-30 14:03:13.000000000 -0500
+++ linux-2.6.13-rc1/include/linux/security.h	2005-06-30 14:11:36.000000000 -0500
@@ -34,6 +34,35 @@
 struct ctl_table;
 
 /*
+ * structure to be embedded at top of each LSM's security
+ * objects.
+ */
+struct security_list {
+	struct hlist_node list;
+	int security_id;
+};
+
+
+/*
+ * These #defines present more convenient interfaces to
+ * LSMs for using the security{g,d,s}et_value functions.
+ */
+#define security_get_value_type(head, id, type) ( { \
+	struct security_list *v = security_get_value(head, id); \
+	v ? hlist_entry(v, type, lsm_list) : NULL; } )
+
+#define security_set_value_type(head, id, value) \
+	security_set_value(head, id, &value->lsm_list);
+
+#define security_add_value_type(head, id, value) \
+	security_add_value(head, id, &value->lsm_list);
+
+#define security_del_value_type(head, id, type) ( { \
+	struct security_list *v; \
+	v = security_del_value(head, id); \
+	v ? hlist_entry(v, type, lsm_list) : NULL; } )
+
+/*
  * These functions are in security/capability.c and are used
  * as the default capabilities functions
  */
Index: linux-2.6.13-rc1/security/security.c
===================================================================
--- linux-2.6.13-rc1.orig/security/security.c	2005-06-30 14:03:54.000000000 -0500
+++ linux-2.6.13-rc1/security/security.c	2005-06-30 14:11:36.000000000 -0500
@@ -20,6 +20,81 @@
 
 #define SECURITY_FRAMEWORK_VERSION	"1.0.0"
 
+#ifdef CONFIG_SECURITY_STACKER
+fastcall struct security_list *
+security_get_value(struct hlist_head *head, int security_id)
+{
+	struct security_list *e, *ret = NULL;
+	struct hlist_node *tmp;
+
+	rcu_read_lock();
+	for (tmp = head->first; tmp;
+			 tmp = rcu_dereference(tmp->next)) {
+		e = hlist_entry(tmp, struct security_list, list);
+		if (e->security_id == security_id) {
+			ret = e;
+			goto out;
+		}
+	}
+
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+fastcall void
+security_set_value(struct hlist_head *head, int security_id,
+	struct security_list *obj_node)
+{
+
+	obj_node->security_id = security_id;
+	hlist_add_head(&obj_node->list, head);
+}
+
+static DEFINE_SPINLOCK(stacker_value_spinlock);
+
+fastcall void
+security_add_value(struct hlist_head *head, int security_id,
+	struct security_list *obj_node)
+{
+
+	spin_lock(&stacker_value_spinlock);
+	obj_node->security_id = security_id;
+	hlist_add_head_rcu(&obj_node->list, head);
+	spin_unlock(&stacker_value_spinlock);
+}
+
+/*
+ * XXX Serge: is it possible to add a security_del_value_locked(),
+ * which waits for a full rcu read cycle before returning an object
+ * to be deleted, so that it would be safe to use along with racing
+ * security_get_value()?
+ */
+
+/* No locking needed: only called during object_destroy */
+fastcall struct security_list *
+security_del_value(struct hlist_head *head, int security_id)
+{
+	struct security_list *e;
+	struct hlist_node *tmp;
+
+	for (tmp = head->first; tmp; tmp = tmp->next) {
+		e = hlist_entry(tmp, struct security_list, list);
+		if (e->security_id == security_id) {
+			hlist_del(&e->list);
+			return e;
+		}
+	}
+
+	return NULL;
+}
+
+EXPORT_SYMBOL_GPL(security_get_value);
+EXPORT_SYMBOL_GPL(security_set_value);
+EXPORT_SYMBOL_GPL(security_add_value);
+EXPORT_SYMBOL_GPL(security_del_value);
+#endif
+
 /* things that live in dummy.c */
 extern struct security_operations dummy_security_ops;
 extern void security_fixup_ops(struct security_operations *ops);

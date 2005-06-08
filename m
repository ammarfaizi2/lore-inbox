Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVFHX5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVFHX5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVFHX4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:56:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:64474 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261408AbVFHXyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:54:10 -0400
Date: Wed, 8 Jun 2005 18:58:39 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>
Subject: [patch 3/11] lsm stacking: introduce security_*_value API
Message-ID: <20050608235839.GC27314@serge.austin.ibm.com>
References: <20050608235505.GA27298@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608235505.GA27298@serge.austin.ibm.com>
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

Index: linux-2.6.12-rc6/include/linux/security-stack.h
===================================================================
--- /dev/null
+++ linux-2.6.12-rc6/include/linux/security-stack.h
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
Index: linux-2.6.12-rc6/include/linux/security.h
===================================================================
--- linux-2.6.12-rc6.orig/include/linux/security.h
+++ linux-2.6.12-rc6/include/linux/security.h
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
Index: linux-2.6.12-rc6/security/security.c
===================================================================
--- linux-2.6.12-rc6.orig/security/security.c
+++ linux-2.6.12-rc6/security/security.c
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

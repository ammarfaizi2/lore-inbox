Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVG0S2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVG0S2C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVG0S0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:26:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:28128 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262355AbVG0SXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:23:42 -0400
Date: Wed, 27 Jul 2005 13:24:05 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Emily Ratliff <emilyr@us.ibm.com>
Subject: [patch 5/15] lsm stacking v0.3: introduce security_*_value API
Message-ID: <20050727182405.GF22483@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050727181921.GB22483@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727181921.GB22483@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define the functions to be used by LSMs to add, retrieve, and remove
elements to the kernel object ->security hlists.

Changelog:

	[July 26] Fixed prototypes which did not specify fastcall.

	[July 26] Added security_unlink_value, for use by modules
		to free data when they are unloaded, and
		security_disown_value, which is used when a module
		has not freed it's object->security data when object
		is being freed.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
 include/linux/security-stack.h |   25 +++++++
 include/linux/security.h       |   32 ++++++++++
 security/security.c            |  130 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)

Index: linux-2.6.13-rc3/include/linux/security-stack.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc3/include/linux/security-stack.h	2005-07-25 14:50:44.000000000 -0500
@@ -0,0 +1,25 @@
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
+extern fastcall struct security_list *security_get_value(
+			struct hlist_head *head,
+			int security_id);
+
+extern fastcall struct security_list *security_set_value(
+			struct hlist_head *head,
+			int security_id, struct security_list *obj_node);
+extern fastcall struct security_list *security_add_value(
+			struct hlist_head *head,
+			int security_id, struct security_list *obj_node);
+extern int security_unlink_value(struct hlist_node *n);
+extern fastcall struct security_list *security_del_value(
+			struct hlist_head *head,
+			int security_id);
Index: linux-2.6.13-rc3/include/linux/security.h
===================================================================
--- linux-2.6.13-rc3.orig/include/linux/security.h	2005-07-25 14:40:42.000000000 -0500
+++ linux-2.6.13-rc3/include/linux/security.h	2005-07-25 14:55:20.000000000 -0500
@@ -35,6 +35,38 @@ struct ctl_table;
 struct module;
 
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
+	struct security_list *v = security_get_value((head), id); \
+	v ? hlist_entry(v, type, lsm_list) : NULL; } )
+
+#define security_set_value_type(head, id, value) \
+	security_set_value((head), id, &(value)->lsm_list);
+
+#define security_add_value_type(head, id, value) \
+	security_add_value((head), id, &(value)->lsm_list);
+
+#define security_del_value_type(head, id, type) ( { \
+	struct security_list *v; \
+	v = security_del_value((head), id); \
+	v ? hlist_entry(v, type, lsm_list) : NULL; } )
+
+/* security_disown_value is really only to be used by stacker */
+extern void security_disown_value(struct hlist_head *);
+
+/*
  * These functions are in security/capability.c and are used
  * as the default capabilities functions
  */
Index: linux-2.6.13-rc3/security/security.c
===================================================================
--- linux-2.6.13-rc3.orig/security/security.c	2005-07-25 14:40:42.000000000 -0500
+++ linux-2.6.13-rc3/security/security.c	2005-07-25 14:50:34.000000000 -0500
@@ -20,6 +20,136 @@
 
 #define SECURITY_FRAMEWORK_VERSION	"1.0.0"
 
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
+/*
+ * Only to be called from security_*_alloc hooks, so there is
+ * no locking as it is naturally serialized.
+ */
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
+/*
+ * Used outside of security_*_alloc hooks, so we need to
+ * lock.  Hopefully this won't be used much, so we use a
+ * spinlock for now.
+ */
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
+ * Unlink a security value from object->security, at a time other
+ * than when the object is being destroyed.  Note that you MUST
+ * wait a full rcu cycle before deleting the object.  If you are
+ * deleting a lot of objects (ie when unloading an LSM), then you
+ * likely will want to build a list of objects to be deleted as
+ * you remove them using this function, wait an rcu cycle, and then
+ * delete all the objects in your list.
+ * NOTE you obviously can't use the .next pointer for the to-be-
+ * deleted list, but you should be able to use the .prev pointer.
+ *
+ * XXX TODO - switch this to take a type, and deref
+ * obj->lsm_list.list here.
+ */
+int security_unlink_value(struct hlist_node *n)
+{
+	int ret = 0;
+	spin_lock(&stacker_value_spinlock);
+	if (n->pprev == LIST_POISON2) {
+		ret = 1;
+		goto out;
+	}
+	hlist_del_rcu(n);
+
+out:
+	spin_unlock(&stacker_value_spinlock);
+	return ret;
+}
+
+/*
+ * When a security module is unloaded, it is first removed from
+ * the list of callable modules
+ * (echo -n lsmname > /security/stacker/unload).  Then at some
+ * later time the module's exit function will be called, which
+ * may try to free memory attached to kernel objects.  The kernel
+ * objects may be deleted during this time.  If that happens,
+ * then stacker will call security_disown_value so that the
+ * in-limbo LSM's data can be safely deleted.  The LSM calls
+ * security_unlink_value() to remove the item from the list.
+ * security_unlink_value() will check whether
+ * lsm_list.pprev == LIST_POISON2.  If not, then it removes the
+ * item from the (valid) list, else it simply returns, as there
+ * is no more list.
+ */
+void security_disown_value(struct hlist_head *h)
+{
+	spin_lock(&stacker_value_spinlock);
+	if (h->first)
+		h->first->pprev = LIST_POISON2;
+	h->first = NULL;
+	spin_unlock(&stacker_value_spinlock);
+}
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
+EXPORT_SYMBOL_GPL(security_unlink_value);
+EXPORT_SYMBOL_GPL(security_disown_value);
+EXPORT_SYMBOL_GPL(security_del_value);
+
 /* things that live in dummy.c */
 extern struct security_operations dummy_security_ops;
 extern void security_fixup_ops(struct security_operations *ops);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVFWGgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVFWGgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVFWGgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:36:48 -0400
Received: from [24.22.56.4] ([24.22.56.4]:23270 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262302AbVFWGS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:57 -0400
Message-Id: <20050623061757.466816000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:08 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Hubertus Franke <frankeh@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Shailabh Nagar <nagar@us.ibm.com>, Vivek Kashyap <vivk@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 16/38] CKRM e18: Rule Based Classification Engine, basic rcfs support
Content-Disposition: inline; filename=09-02-rbce_fs-main
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2 of 5 patches to support Rule Based Classification Engine for CKRM.
This patch provides the functionality needed by the rcfs interface for
ce provided in patch 1. No classification functionality yet.

Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

 Makefile        |    2 
 rbce_internal.h |  161 +++++++++
 rbce_main.c     |  993 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 rbce_token.c    |  241 +++++++++++++
 4 files changed, 1383 insertions(+), 14 deletions(-)

Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/Makefile
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/Makefile	2005-06-20 13:08:42.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/Makefile	2005-06-20 13:08:44.000000000 -0700
@@ -3,4 +3,4 @@
 #
 
 obj-$(CONFIG_CKRM_RBCE)	+= rbce.o
-rbce-objs := rbce_fs.o rbce_main.o
+rbce-objs := rbce_fs.o rbce_main.o rbce_token.o
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 13:08:42.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 13:08:44.000000000 -0700
@@ -41,8 +41,165 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
-extern int rbce_enabled;
+/*
+ * comman data structure used for identification of class and rules
+ * in the RBCE namespace
+ */
+struct named_obj_hdr {
+	struct list_head link;
+	int referenced;
+	char *name;
+};
+
+#define GET_REF(x) ((x)->obj.referenced)
+#define INC_REF(x) (GET_REF(x)++)
+#define DEC_REF(x) (--GET_REF(x))
+
+struct rbce_class {
+	struct named_obj_hdr obj;
+	int classtype;
+	void *classobj;
+};
+
+typedef int __bitwise rbce_rule_op_t;
+enum rbce_rule_op {
+	RBCE_RULE_CMD_PATH = (__force rbce_rule_op_t) 1,
+	RBCE_RULE_CMD = (__force rbce_rule_op_t) 2,
+	RBCE_RULE_ARGS = (__force rbce_rule_op_t) 3,
+	RBCE_RULE_REAL_UID = (__force rbce_rule_op_t) 4,
+	RBCE_RULE_REAL_GID = (__force rbce_rule_op_t) 5,
+	RBCE_RULE_EFFECTIVE_UID = (__force rbce_rule_op_t) 6,
+	RBCE_RULE_EFFECTIVE_GID = (__force rbce_rule_op_t) 7,
+	RBCE_RULE_APP_TAG = (__force rbce_rule_op_t) 8,
+	RBCE_RULE_IPV4 = (__force rbce_rule_op_t) 9,
+	RBCE_RULE_IPV6 = (__force rbce_rule_op_t) 10,
+	RBCE_RULE_DEP_RULE = (__force rbce_rule_op_t) 11,
+	RBCE_RULE_INVALID = (__force rbce_rule_op_t) 12,
+	RBCE_RULE_INVALID2 = (__force rbce_rule_op_t) 13,
+};
+
+typedef int __bitwise rbce_operator_t;
+enum rbce_operator {
+	RBCE_EQUAL = (__force rbce_operator_t) 1,
+	RBCE_NOT = (__force rbce_operator_t) 2,
+	RBCE_LESS_THAN = (__force rbce_operator_t) 3,
+	RBCE_GREATER_THAN = (__force rbce_operator_t) 4,
+};
+
+struct rbce_rule_term {
+	rbce_rule_op_t op;
+	rbce_operator_t operator;
+	union {
+		char *string;	/* path, cmd, arg, tag, ipv4 and ipv6 */
+		long id;	/* uid, gid, euid, egid */
+		struct rbce_rule *deprule;
+	} u;
+};
+
+struct rbce_rule {
+	struct named_obj_hdr obj;
+	struct rbce_class *target_class;
+	int classtype;
+	int num_terms;
+	int *terms;	/* vector of indices into the global term vector */
+	int index;	/* index of this rule into the global term vector */
+	int termflag;	/* which term ids would require a recalculation */
+	int do_opt;	/* do we have to consider this rule during optimize */
+	char *strtab;	/* string table to store the strings of all terms */
+	int order;	/* order of execution of this rule */
+	int state;	/* RBCE_RULE_ENABLED/RBCE_RULE_DISABLED */
+};
+
+/* rules states */
+#define RBCE_RULE_DISABLED 0
+#define RBCE_RULE_ENABLED  1
+
+/*
+ * Data structures and macros used for optimization
+ */
+#define RBCE_TERM_CMD   (0)
+#define RBCE_TERM_UID   (1)
+#define RBCE_TERM_GID   (2)
+#define RBCE_TERM_TAG   (3)
+#define RBCE_TERM_IPV4  (4)
+#define RBCE_TERM_IPV6  (5)
+
+#define NUM_TERM_MASK_VECTOR  (6)
+
+/* Rule flags. 1 bit for each type of rule term */
+#define RBCE_TERMFLAG_CMD   (1 << RBCE_TERM_CMD)
+#define RBCE_TERMFLAG_UID   (1 << RBCE_TERM_UID)
+#define RBCE_TERMFLAG_GID   (1 << RBCE_TERM_GID)
+#define RBCE_TERMFLAG_TAG   (1 << RBCE_TERM_TAG)
+#define RBCE_TERMFLAG_IPV4  (1 << RBCE_TERM_IPV4)
+#define RBCE_TERMFLAG_IPV6  (1 << RBCE_TERM_IPV6)
+#define RBCE_TERMFLAG_ALL      (RBCE_TERMFLAG_CMD | RBCE_TERMFLAG_UID |	\
+				RBCE_TERMFLAG_GID | RBCE_TERMFLAG_TAG |	\
+				RBCE_TERMFLAG_IPV4 | RBCE_TERMFLAG_IPV6)
+
+/* Token operation related data structures, functions etc., */
+typedef int __bitwise rule_token_t;
+enum rule_token {
+	TOKEN_PATH = (__force rule_token_t) 1,
+	TOKEN_CMD = (__force rule_token_t) 2,
+	TOKEN_ARGS = (__force rule_token_t) 3,
+	TOKEN_RUID_EQ = (__force rule_token_t) 4,
+	TOKEN_RUID_LT = (__force rule_token_t) 5,
+	TOKEN_RUID_GT = (__force rule_token_t) 6,
+	TOKEN_RUID_NOT = (__force rule_token_t) 7,
+	TOKEN_RGID_EQ = (__force rule_token_t) 8,
+	TOKEN_RGID_LT = (__force rule_token_t) 9,
+	TOKEN_RGID_GT = (__force rule_token_t) 10,
+	TOKEN_RGID_NOT = (__force rule_token_t) 11,
+	TOKEN_EUID_EQ = (__force rule_token_t) 12,
+	TOKEN_EUID_LT = (__force rule_token_t) 13,
+	TOKEN_EUID_GT = (__force rule_token_t) 14,
+	TOKEN_EUID_NOT = (__force rule_token_t) 15,
+	TOKEN_EGID_EQ = (__force rule_token_t) 16,
+	TOKEN_EGID_LT = (__force rule_token_t) 17,
+	TOKEN_EGID_GT = (__force rule_token_t) 18,
+	TOKEN_EGID_NOT = (__force rule_token_t) 19,
+	TOKEN_TAG = (__force rule_token_t) 20,
+	TOKEN_IPV4 = (__force rule_token_t) 21,
+	TOKEN_IPV6 = (__force rule_token_t) 22,
+	TOKEN_DEP = (__force rule_token_t) 23,
+	TOKEN_DEP_ADD = (__force rule_token_t) 24,
+	TOKEN_DEP_DEL = (__force rule_token_t) 25,
+	TOKEN_ORDER = (__force rule_token_t) 26,
+	TOKEN_CLASS = (__force rule_token_t) 27,
+	TOKEN_STATE = (__force rule_token_t) 28,
+	TOKEN_INVALID = (__force rule_token_t) 29
+};
+
+typedef int __bitwise op_token_t;
+enum op_token {
+	TOKEN_OP_EQUAL = (__force op_token_t) RBCE_EQUAL,
+	TOKEN_OP_NOT = (__force op_token_t) RBCE_NOT,
+	TOKEN_OP_LESS_THAN = (__force op_token_t) RBCE_LESS_THAN,
+	TOKEN_OP_GREATER_THAN = (__force op_token_t) RBCE_GREATER_THAN,
+	TOKEN_OP_DEP = (__force op_token_t) (TOKEN_OP_GREATER_THAN+1),
+	TOKEN_OP_DEP_ADD = (__force op_token_t) (TOKEN_OP_GREATER_THAN+2),
+	TOKEN_OP_DEP_DEL = (__force op_token_t) (TOKEN_OP_GREATER_THAN+3),
+	TOKEN_OP_ORDER = (__force op_token_t) (TOKEN_OP_GREATER_THAN+4),
+	TOKEN_OP_CLASS = (__force op_token_t) (TOKEN_OP_GREATER_THAN+5),
+	TOKEN_OP_STATE = (__force op_token_t) (TOKEN_OP_GREATER_THAN+6),
+};
+
+
+/*
+ * data structure rbce_private_data to hold the app_tag for a task.
+ * Expands later.
+ *
+ */
+struct rbce_private_data {
+	char *app_tag;
+};
+
+#define RBCE_DATA(tsk) ((struct rbce_private_data*)((tsk)->ce_data))
+#define RBCE_DATAP(tsk) ((tsk)->ce_data)
+
 extern struct rbce_eng_callback rbce_rcfs_ecbs;
+extern int rbce_enabled;
 
 extern int rbce_mkdir(struct inode *, struct dentry *, int);
 extern int rbce_rmdir(struct inode *, struct dentry *);
@@ -56,4 +213,6 @@ extern int rbce_delete_rule(const char *
 extern int rbce_set_tasktag(int, char *);
 extern int rbce_rename_rule(const char *, const char *);
 
+extern int rules_parse(char *, struct rbce_rule_term **, int *);
+
 #endif /* _RBCE_INTERNAL_H */
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_main.c	2005-06-20 13:08:42.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c	2005-06-20 13:08:44.000000000 -0700
@@ -30,32 +30,1001 @@ MODULE_LICENSE("GPL");
 
 static char modname[] = RBCE_MOD_NAME;
 
-/* Stub routines for now */
-void rbce_get_rule(const char *a, char *b)
+/* ==================== global variables etc., ==================== */
+
+int termop_2_vecidx[RBCE_RULE_INVALID] = {
+	[RBCE_RULE_CMD_PATH] = RBCE_TERM_CMD,
+	[RBCE_RULE_CMD] = RBCE_TERM_CMD,
+	[RBCE_RULE_ARGS] = RBCE_TERM_CMD,
+	[RBCE_RULE_REAL_UID] = RBCE_TERM_UID,
+	[RBCE_RULE_REAL_GID] = RBCE_TERM_GID,
+	[RBCE_RULE_EFFECTIVE_UID] = RBCE_TERM_UID,
+	[RBCE_RULE_EFFECTIVE_GID] = RBCE_TERM_GID,
+	[RBCE_RULE_APP_TAG] = RBCE_TERM_TAG,
+	[RBCE_RULE_IPV4] = RBCE_TERM_IPV4,
+	[RBCE_RULE_IPV6] = RBCE_TERM_IPV6,
+	[RBCE_RULE_DEP_RULE] = -1
+};
+
+#define TERMOP_2_TERMFLAG(x)	(1 << termop_2_vecidx[x])
+#define TERM_2_TERMFLAG(x)		(1 << x)
+
+#define POLICY_INC_NUMTERMS	(BITS_PER_LONG)	/* No. of terms alloc'd once */
+#define POLICY_ACTION_NEW_VERSION	0x01	/* Force reallocation */
+#define POLICY_ACTION_REDO_ALL		0x02	/* Recompute all rule flags */
+#define POLICY_ACTION_PACK_TERMS	0x04	/* Time to pack the terms */
+
+extern int errno;
+
+int rbce_enabled = 1;
+
+static LIST_HEAD(class_list);
+static struct list_head rules_list[CKRM_MAX_CLASSTYPES];
+static int gl_num_rules;
+static int gl_action, gl_num_terms;
+static int gl_allocated, gl_released;
+static struct rbce_rule_term *gl_terms;
+static int gl_rules_version;
+static rwlock_t rbce_rwlock = RW_LOCK_UNLOCKED;
+	/*
+	 * One lock to protect them all !!!
+	 * Additions, deletions to rules must
+	 * happen with this lock being held in write mode.
+	 * Access(read/write) to any of the data structures must happen
+	 * with this lock held in read mode.
+	 * Since, rule related changes do not happen very often it is ok to
+	 * have single rwlock.
+	 */
+
+/* ======================= Helper Functions ========================= */
+
+static inline struct rbce_rule *find_rule_name(const char *name)
+{
+	struct named_obj_hdr *pos;
+	int i;
+
+	for (i = 0; i < CKRM_MAX_CLASSTYPES; i++)
+		list_for_each_entry(pos, &rules_list[i], link)
+			if (!strcmp(pos->name, name))
+				return ((struct rbce_rule *)pos);
+	return NULL;
+}
+
+struct rbce_class *find_class_name(const char *name)
 {
+	struct named_obj_hdr *pos;
+
+	list_for_each_entry(pos, &class_list, link)
+		if (!strcmp(pos->name, name))
+			return (struct rbce_class *)pos;
+	return NULL;
 }
-int rbce_rule_exists(const char *a)
+
+/* Type of Rule insertion */
+#define INSERT		0	/* new rule */
+#define REINSERT	1	/* existing rule */
+
+/*
+ * Insert the given rule at the specified order
+ * 		order = -1 ==> insert at the tail.
+ *		type == INSERT - insert the rule
+ *		type == REINSERT - remove the rule from its current
+ *				 position and reinsert accoring to order.
+ *
+ * Caller must hold rbce_rwlock in write mode.
+ */
+static int insert_rule(struct rbce_rule *rule, int order, int type)
 {
+#define ORDER_COUNTER_INCR 10
+	static int order_counter;
+	int old_counter;
+	struct list_head *head = &rules_list[rule->classtype];
+	struct list_head *insert = head;
+	struct rbce_rule *tmp;
+
+	if (gl_num_rules == 0)
+		order_counter = 0;
+
+	switch (order) {
+	case -1:
+		rule->order = order_counter;
+		/* FIXME: order_counter overflow/wraparound!! */
+		order_counter += ORDER_COUNTER_INCR;
+		break;
+	default:
+		old_counter = order_counter;
+		if (order_counter < order)
+			order_counter = order;
+		rule->order = order;
+		order_counter += ORDER_COUNTER_INCR;
+		list_for_each_entry(tmp, head, obj.link) {
+			if (rule == tmp)
+				continue;
+			if (rule->order == tmp->order) {
+				order_counter = old_counter;
+				return -EEXIST;
+			}
+			if (rule->order < tmp->order) {
+				insert = &tmp->obj.link;
+				break;
+			}
+		}
+	}
+	if (type == REINSERT)
+		list_del(&rule->obj.link);
+	else {
+		/*  protect the module from removed if a rule exists */
+		try_module_get(THIS_MODULE);
+		gl_num_rules++;
+	}
+	gl_rules_version++;
+	list_add_tail(&rule->obj.link, insert);
 	return 0;
 }
-int rbce_change_rule(const char *a, char *b)
+
+/*
+ * Get a refernece to the class, create one if it doesn't exist
+ *
+ * Caller need to hold rbce_rwlock in write mode.
+ */
+
+struct rbce_class *create_rbce_class(const char *classname,
+					    int classtype, void *classobj)
 {
-	return 1;
+	struct rbce_class *cls;
+
+	if (classtype >= CKRM_MAX_CLASSTYPES) {
+		printk(KERN_ERR
+		       "ckrm_classobj returned %d as classtype which cannot "
+		       " be handled by RBCE\n", classtype);
+		return NULL;
+	}
+
+	cls = kmalloc(sizeof(struct rbce_class), GFP_ATOMIC);
+	if (!cls)
+		return NULL;
+	cls->obj.name = kmalloc(strlen(classname) + 1, GFP_ATOMIC);
+	if (cls->obj.name) {
+		GET_REF(cls) = 1;
+		cls->classobj = classobj;
+		strcpy(cls->obj.name, classname);
+		list_add_tail(&cls->obj.link, &class_list);
+		cls->classtype = classtype;
+	} else {
+		kfree(cls);
+		cls = NULL;
+	}
+	return cls;
 }
-int rbce_delete_rule(const char *a)
+
+static struct rbce_class *get_class(char *classname, int *classtype)
 {
-	return 1;
+	struct rbce_class *cls;
+	void *classobj;
+
+	if (!classname)
+		return NULL;
+	cls = find_class_name(classname);
+	if (cls) {
+		if (cls->classobj) {
+			INC_REF(cls);
+			*classtype = cls->classtype;
+			return cls;
+		}
+		return NULL;
+	}
+	classobj = ckrm_classobj(classname, classtype);
+	if (!classobj)
+		return NULL;
+	return create_rbce_class(classname, *classtype, classobj);
 }
-int rbce_set_tasktag(int i, char *a)
+
+/*
+ * Drop a refernece to the class, create one if it doesn't exist
+ *
+ * Caller need to hold rbce_rwlock in write mode.
+ */
+void put_class(struct rbce_class *cls)
 {
-	return 1;
+	if (cls && (DEC_REF(cls) <= 0)) {
+		list_del(&cls->obj.link);
+		kfree(cls->obj.name);
+		kfree(cls);
+	}
+	return;
 }
-int rbce_rename_rule(const char *a, const char *b)
+
+/*
+ * Allocate an index in the global term vector
+ * On success, returns the index. On failure returns -errno.
+ * Caller must hold the rbce_rwlock in write mode as global data is
+ * written onto.
+ */
+static int alloc_term_index(void)
 {
-	return 1;
+	int size = gl_allocated;
+
+	if (gl_num_terms >= size) {
+		int i;
+		struct rbce_rule_term *oldv, *newv;
+		int newsize = size + POLICY_INC_NUMTERMS;
+
+		oldv = gl_terms;
+		newv =
+		    kmalloc(newsize * sizeof(struct rbce_rule_term),
+			    GFP_ATOMIC);
+		if (!newv)
+			return -ENOMEM;
+		memcpy(newv, oldv, size * sizeof(struct rbce_rule_term));
+		for (i = size; i < newsize; i++)
+			newv[i].op = -1;
+		gl_terms = newv;
+		gl_allocated = newsize;
+		kfree(oldv);
+
+		gl_action |= POLICY_ACTION_NEW_VERSION;
+	}
+	return gl_num_terms++;
+}
+
+/*
+ * Release an index in the global term vector
+ *
+ * Caller must hold the rbce_rwlock in write mode as the global data
+ * is written onto.
+ */
+static void release_term_index(int idx)
+{
+	if ((idx < 0) || (idx > gl_num_terms))
+		return;
+
+	gl_terms[idx].op = -1;
+	gl_released++;
+	if ((gl_released > POLICY_INC_NUMTERMS) &&
+	    (gl_allocated >
+	     (gl_num_terms - gl_released + POLICY_INC_NUMTERMS))) {
+		gl_action |= POLICY_ACTION_PACK_TERMS;
+	}
+	return;
+}
+
+/*
+ * Release the indices, string memory, and terms associated with the given
+ * rule.
+ *
+ * Caller should be holding rbce_rwlock
+ */
+static void __release_rule(struct rbce_rule *rule)
+{
+	int i, *terms = rule->terms;
+
+	/* remove memory and references from other rules */
+	for (i = rule->num_terms; --i >= 0;) {
+		struct rbce_rule_term *term = &gl_terms[terms[i]];
+
+		if (term->op == RBCE_RULE_DEP_RULE)
+			DEC_REF(term->u.deprule);
+		release_term_index(terms[i]);
+	}
+	rule->num_terms = 0;
+	if (rule->strtab) {
+		kfree(rule->strtab);
+		rule->strtab = NULL;
+	}
+	if (rule->terms) {
+		kfree(rule->terms);
+		rule->terms = NULL;
+	}
+	return;
+}
+
+/*
+ * delete the given rule and all memory associated with it.
+ *
+ * Caller is responsible for protecting the global data
+ */
+static inline int __delete_rule(struct rbce_rule *rule)
+{
+	/* make sure we are not referenced by other rules */
+	if (GET_REF(rule))
+		return -EBUSY;
+	__release_rule(rule);
+	put_class(rule->target_class);
+	release_term_index(rule->index);
+	list_del(&rule->obj.link);
+	gl_num_rules--;
+	gl_rules_version++;
+	module_put(THIS_MODULE);
+	kfree(rule->obj.name);
+	kfree(rule);
+	return 0;
+}
+
+/* ======================= Rule related Functions ========================= */
+
+/*
+ * This function takes terms as input and digests the valid rbce terms
+ * and fills the newrule appropriately.
+ *	 Valid terms have op != RBCE_RULE_INVALID
+ * This function returns the number of valid terms found.
+ * In case of error it return -errno
+ */
+static inline int
+digest_terms(struct rbce_rule *newrule,
+	struct rbce_rule_term *terms, int nterms)
+{
+	char *strtab = NULL;
+	struct rbce_rule *deprule;
+	int i, j, real_nterms = 0, strtablen = 0;
+
+	for (i = 0; i < nterms; i++) {
+		if (terms[i].op == RBCE_RULE_INVALID)
+			continue;
+		real_nterms++;
+
+		switch (terms[i].op) {
+		case RBCE_RULE_DEP_RULE:
+			/* check if the depend rule is valid */
+			deprule = find_rule_name(terms[i].u.string);
+			if (!deprule || deprule == newrule) {
+				real_nterms = -EINVAL;
+				goto out;
+			} else {
+				/* make sure _a_ depend rule */
+				/* appears in only one term. */
+				for (j = 0; j < i; j++) {
+					if (terms[j].op ==
+					    RBCE_RULE_DEP_RULE
+					    && terms[j].u.deprule ==
+					    deprule) {
+						real_nterms = -EINVAL;
+						goto out;
+					}
+				}
+				terms[i].u.deprule = deprule;
+			}
+
+			/* +depend is acceptable and -depend is not */
+			if (terms[i].operator != TOKEN_OP_DEP_DEL)
+				terms[i].operator = RBCE_EQUAL;
+			else {
+				real_nterms = -EINVAL;
+				goto out;
+			}
+			break;
+
+		case RBCE_RULE_CMD_PATH:
+		case RBCE_RULE_CMD:
+		case RBCE_RULE_ARGS:
+		case RBCE_RULE_APP_TAG:
+		case RBCE_RULE_IPV4:
+		case RBCE_RULE_IPV6:
+			/* sum up the string length */
+			strtablen += strlen(terms[i].u.string) + 1;
+			break;
+		default:
+			break;
+
+		}
+	}
+	if (strtablen) {
+		strtab = kmalloc(strtablen, GFP_ATOMIC);
+		if (!strtab)
+			real_nterms = -ENOMEM;
+		else {
+			if (newrule->strtab)
+				kfree(newrule->strtab);
+			newrule->strtab = strtab;
+		}
+	}
+out:
+	return real_nterms;
+}
+
+/*
+ * This function takes terms as input and digests the non rbce terms
+ * and fills newrule appropriately.
+ * non rbce teerms are used to get attribute/value that are not part
+ * of the rule terms.
+ *	 non rbce terms have op != RBCE_RULE_INVALID
+ * This function returns 0 on success and -errno in case of error
+ */
+static inline int
+digest_nonterms(struct rbce_rule *newrule,
+	struct rbce_rule_term *terms, int nterms)
+{
+	char *class = NULL;
+	int state = -1, order = -1, rc = 0, i;
+
+	for (i = 0; i < nterms; i++) {
+		if (terms[i].op != RBCE_RULE_INVALID)
+			continue;
+		switch (terms[i].operator) {
+		case TOKEN_OP_ORDER:
+			order = terms[i].u.id;
+			if (order < 0) {
+				rc = -EINVAL;
+				goto out;
+			}
+			break;
+		case TOKEN_OP_STATE:
+			state = terms[i].u.id != 0;
+			break;
+		case TOKEN_OP_CLASS:
+			class = terms[i].u.string;
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* Check if class was specified */
+	if (class != NULL) {
+		int classtype;
+		struct rbce_class *targetcls;
+		if ((targetcls = get_class(class, &classtype)) == NULL) {
+			rc = -EINVAL;
+			goto out;
+		}
+		if (newrule->target_class)
+			put_class(newrule->target_class);
+
+		newrule->target_class = targetcls;
+		newrule->classtype = classtype;
+	}
+	if (!newrule->target_class) {
+		rc = -EINVAL;
+		goto out;
+	}
+	if (state != -1)
+		newrule->state = state;
+	if (order != -1)
+		newrule->order = order;
+out:
+	return rc;
+}
+
+/*
+ * Allocate and fill the term vectors of the newrule from the terms array.
+ * Only handle the realy terms and ignore the nonterms.
+ */
+static inline int
+fill_term_vector(struct rbce_rule *newrule,
+	struct rbce_rule_term *terms, int real_nterms)
+{
+	int i, rc = 0, strtablen = 0, j, ii;
+	struct rbce_rule_term *term;
+
+	newrule->terms = kmalloc(real_nterms * sizeof(int), GFP_ATOMIC);
+	if (!newrule->terms) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0, j = 0; j < real_nterms; i++, j++) {
+		if (terms[i].op == RBCE_RULE_INVALID)
+			continue;
+
+		newrule->terms[j] = alloc_term_index();
+		if (newrule->terms[j] < 0) {
+			for (ii = 0; ii < j; ii++)
+				release_term_index(newrule->terms[ii]);
+			rc = -ENOMEM;
+			goto out;
+		}
+		term = &gl_terms[newrule->terms[j]];
+		term->op = terms[i].op;
+		term->operator = terms[i].operator;
+		switch (terms[i].op) {
+		case RBCE_RULE_CMD_PATH:
+		case RBCE_RULE_CMD:
+		case RBCE_RULE_ARGS:
+		case RBCE_RULE_APP_TAG:
+		case RBCE_RULE_IPV4:
+		case RBCE_RULE_IPV6:
+			term->u.string = &newrule->strtab[strtablen];
+			strcpy(term->u.string, terms[i].u.string);
+			strtablen = strlen(term->u.string) + 1;
+			break;
+
+		case RBCE_RULE_REAL_UID:
+		case RBCE_RULE_REAL_GID:
+		case RBCE_RULE_EFFECTIVE_UID:
+		case RBCE_RULE_EFFECTIVE_GID:
+			term->u.id = terms[i].u.id;
+			break;
+
+		case RBCE_RULE_DEP_RULE:
+			term->u.deprule = terms[i].u.deprule;
+			INC_REF(term->u.deprule);
+			break;
+		default:
+			break;
+		}
+	}
+out:
+	if (rc) {
+		kfree(newrule->terms);
+		newrule->terms = NULL;
+	}
+	return rc;
+
+}
+
+/*
+ * Caller need to hold rbce_rwlock in write mode.
+ */
+static int
+fill_rule(struct rbce_rule *newrule, struct rbce_rule_term *terms, int nterms)
+{
+	int real_nterms, index = -1, rc = 0;
+	struct rbce_rule_term *term = NULL;
+
+	if (!newrule)
+		return -EINVAL;
+	newrule->num_terms = 0;
+	newrule->termflag = 0;
+
+	/* Digest filled terms. */
+	real_nterms = digest_terms(newrule, terms, nterms);
+	if (real_nterms < 0)
+		return real_nterms;
+	rc = digest_nonterms(newrule, terms, nterms);
+	if (rc < 0)
+		goto out;
+
+	if (newrule->index == -1) {
+		index = alloc_term_index();
+		if (index < 0) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		newrule->index = index;
+		term = &gl_terms[newrule->index];
+		term->op = RBCE_RULE_DEP_RULE;
+		term->u.deprule = newrule;
+	}
+
+	rc = fill_term_vector(newrule, terms, real_nterms);
+out:
+	if (rc) {
+		if (newrule->target_class) {
+			put_class(newrule->target_class);
+			newrule->target_class = NULL;
+		}
+		if (index >= 0) {
+			release_term_index(index);
+			newrule->index = -1;
+		}
+		kfree(newrule->terms);
+		newrule->terms = NULL;
+		kfree(newrule->strtab);
+		newrule->strtab = NULL;
+		newrule->num_terms = 0;
+	} else
+		newrule->num_terms = real_nterms;
+	return rc;
+}
+
+static inline int
+rbce_create_rule(struct rbce_rule_term *new_terms,
+	int nterms, const char *rname)
+{
+	struct rbce_rule *rule;
+	int rc = -ENOMEM;
+
+	rule = kmalloc (sizeof(struct rbce_rule), GFP_ATOMIC);
+	if (rule) {
+		rule->obj.name = kmalloc(strlen(rname) + 1, GFP_ATOMIC);
+		if (rule->obj.name) {
+			strcpy(rule->obj.name, rname);
+			GET_REF(rule) = 0;
+			rule->order = -1;
+			rule->index = -1;
+			rule->num_terms = 0;
+			rule->state = RBCE_RULE_ENABLED;
+			rule->target_class = NULL;
+			rule->strtab = NULL;
+			rule->classtype = -1;
+			rule->terms = NULL;
+			rule->do_opt = 1;
+			INIT_LIST_HEAD(&rule->obj.link);
+			rc = fill_rule(rule, new_terms, nterms);
+			if (rc) {
+				kfree(rule->obj.name);
+				kfree(rule);
+			} else if ((rc = insert_rule(rule,
+					rule->order, INSERT)) != 0)
+				__delete_rule(rule);
+		} else
+			kfree(rule);
+	}
+	return rc;
+}
+
+static inline struct rbce_rule_term *
+merge_terms(struct rbce_rule *rule, struct rbce_rule_term *new_terms,
+	int nterms, int new_term_mask, int *merged_nterms)
+{
+	struct rbce_rule_term *terms, *term;
+	struct rbce_rule *deprule;
+	int i, j, k, oterms, tot_terms, strlocal_len;
+	char *strlocal;
+
+	oterms = rule->num_terms;
+	tot_terms = nterms + oterms;
+	*merged_nterms = 0;
+
+	terms = kmalloc(tot_terms * sizeof(struct rbce_rule_term), GFP_ATOMIC);
+
+	if (!terms) {
+		return NULL;
+	}
+
+	/* Assume we are going to copy all strings from the original rule. */
+	strlocal_len = 0;
+	for (i = 0; i < oterms; i++) {
+		term = &gl_terms[rule->terms[i]];
+		switch (term->op) {
+		case RBCE_RULE_CMD_PATH:
+		case RBCE_RULE_CMD:
+		case RBCE_RULE_ARGS:
+		case RBCE_RULE_APP_TAG:
+		case RBCE_RULE_IPV4:
+		case RBCE_RULE_IPV6:
+			strlocal_len += strlen(term->u.string) + 1;
+			break;
+		default:
+			break;
+		}
+	}
+
+	strlocal = kmalloc(strlocal_len, GFP_ATOMIC);
+	if (!strlocal) {
+		kfree(terms);
+		return NULL;
+	}
+
+	strlocal_len = 0;
+	new_term_mask &= ~(1 << RBCE_RULE_DEP_RULE);
+	/* ignore the new deprule terms for the first iteration. */
+	/* taken care of later. */
+	for (i = 0; i < oterms; i++) {
+		term = &gl_terms[rule->terms[i]];	/* old term */
+
+		if ((1 << term->op) & new_term_mask) {
+			/* newrule has this attr/value */
+			for (j = 0; j < nterms; j++)
+				if (term->op == new_terms[j].op) {
+					terms[i].op = new_terms[j].op;
+					terms[i].operator = new_terms[j].
+					    operator;
+					terms[i].u.string =
+					    new_terms[j].u.string;
+					new_terms[j].op = RBCE_RULE_INVALID2;
+					break;
+				}
+		} else {
+			terms[i].op = term->op;
+			terms[i].operator = term->operator;
+			switch (term->op) {
+			case RBCE_RULE_CMD_PATH:
+			case RBCE_RULE_CMD:
+			case RBCE_RULE_ARGS:
+			case RBCE_RULE_APP_TAG:
+			case RBCE_RULE_IPV4:
+			case RBCE_RULE_IPV6:
+				terms[i].u.string = &strlocal[strlocal_len];
+				strcpy(terms[i].u.string, term->u.string);
+				strlocal_len = strlen(terms[i].u.string) + 1;
+				break;
+			default:
+				terms[i].u.string = term->u.string;
+				break;
+			}
+		}
+	}
+
+	i = oterms;		/* for readability */
+
+	for (j = 0; j < nterms; j++) {
+		/* handled in the previous iteration */
+		if (new_terms[j].op == RBCE_RULE_INVALID2)
+			continue;
+		if (new_terms[j].op == RBCE_RULE_DEP_RULE) {
+			if (new_terms[j].operator == TOKEN_OP_DEP) {
+				/*
+				 * "depend=rule" deletes all depends in the
+				 * original rule so, delete all depend rule
+				 * terms in the original rule
+				 */
+				for (k = 0; k < oterms; k++)
+					if (terms[k].op == RBCE_RULE_DEP_RULE)
+						terms[k].op = RBCE_RULE_INVALID;
+				/* must copy the new deprule term */
+			} else {
+				/*
+				 * delete the depend rule term if was defined
+				 * in the original rule for both +depend
+				 * and -depend
+				 */
+				deprule = find_rule_name(new_terms[j].u.string);
+				if (deprule)
+					for (k = 0; k < oterms; k++) {
+						if (terms[k].op ==
+						    RBCE_RULE_DEP_RULE
+						    && terms[k].u.deprule ==
+						    deprule) {
+							terms[k].op =
+							    RBCE_RULE_INVALID;
+							break;
+						}
+					}
+				if (new_terms[j].operator == TOKEN_OP_DEP_DEL)
+					/* No need to copy the new deprule */
+					continue;
+			}
+		}
+		terms[i].op = new_terms[j].op;
+		terms[i].operator = new_terms[j].operator;
+		terms[i].u.string = new_terms[j].u.string;
+		i++;
+		new_terms[j].op = RBCE_RULE_INVALID2;
+	}
+
+	tot_terms = i;
+
+	/* convert old deprule pointers to name pointers. */
+	for (i = 0; i < oterms; i++) {
+		if (terms[i].op != RBCE_RULE_DEP_RULE)
+			continue;
+		terms[i].u.string = terms[i].u.deprule->obj.name;
+	}
+
+	*merged_nterms = tot_terms;
+	return terms;
+}
+
+int rbce_change_rule(const char *rname, char *rdefn)
+{
+	struct rbce_rule *rule;
+	struct rbce_rule_term *new_terms = NULL, *merged_terms;
+	int nterms, new_term_mask = 0, merged_nterms, rc = -ENOMEM;
+
+	if ((nterms = rules_parse(rdefn, &new_terms, &new_term_mask)) <= 0)
+		return !nterms ? -EINVAL : nterms;
+
+	write_lock(&rbce_rwlock);
+	rule = find_rule_name(rname);
+	if (rule == NULL) {
+		rc = rbce_create_rule(new_terms, nterms, rname);
+		kfree(new_terms);
+		write_unlock(&rbce_rwlock);
+		return rc;
+	}
+
+	merged_terms = merge_terms(rule, new_terms, nterms, new_term_mask,
+			&merged_nterms);
+
+	if (merged_terms) {
+		/* release the rule */
+		__release_rule(rule);
+
+		rule->do_opt = 1;
+		rc = fill_rule(rule, merged_terms, merged_nterms);
+		if (rc == 0)
+			rc = insert_rule(rule, rule->order, REINSERT);
+		if (rc != 0)	/* rule creation/insertion failed */
+			__delete_rule(rule);
+	}
+
+	write_unlock(&rbce_rwlock);
+	kfree(merged_terms);
+	kfree(new_terms);
+	return rc;
+}
+
+/*
+ * Delete the specified rule.
+ *
+ */
+int rbce_delete_rule(const char *rname)
+{
+	int rc = 0;
+	struct rbce_rule *rule;
+
+	write_lock(&rbce_rwlock);
+
+	if ((rule = find_rule_name(rname)) != NULL)
+		rc = __delete_rule(rule);
+	write_unlock(&rbce_rwlock);
+	return rc;
+}
+
+/*
+ * copy the rule specified by rname and to the given result string.
+ *
+ */
+void rbce_get_rule(const char *rname, char *result)
+{
+	int i;
+	struct rbce_rule *rule;
+	struct rbce_rule_term *term;
+	char *cp = result, oper, idtype[3], str[5];
+
+	read_lock(&rbce_rwlock);
+
+	rule = find_rule_name(rname);
+	if (rule != NULL) {
+		for (i = 0; i < rule->num_terms; i++) {
+			term = gl_terms + rule->terms[i];
+			switch (term->op) {
+			case RBCE_RULE_REAL_UID:
+				strcpy(idtype, "u");
+				goto handleid;
+			case RBCE_RULE_REAL_GID:
+				strcpy(idtype, "g");
+				goto handleid;
+			case RBCE_RULE_EFFECTIVE_UID:
+				strcpy(idtype, "eu");
+				goto handleid;
+			case RBCE_RULE_EFFECTIVE_GID:
+				strcpy(idtype, "eg");
+			handleid:
+				switch (term->operator) {
+				case RBCE_LESS_THAN:
+					oper = '<';
+					break;
+				case RBCE_GREATER_THAN:
+					oper = '>';
+					break;
+				case RBCE_NOT:
+					oper = '!';
+					break;
+				default:
+					oper = '=';
+					break;
+				}
+				cp +=
+				    sprintf(cp, "%sid%c%ld,", idtype, oper,
+					    term->u.id);
+				break;
+			case RBCE_RULE_CMD_PATH:
+				strcpy(str, "path");
+				goto handle_str;
+			case RBCE_RULE_CMD:
+				strcpy(str, "cmd");
+				goto handle_str;
+			case RBCE_RULE_ARGS:
+				strcpy(str, "args");
+				goto handle_str;
+			case RBCE_RULE_APP_TAG:
+				strcpy(str, "tag");
+				goto handle_str;
+			case RBCE_RULE_IPV4:
+				strcpy(str, "ipv4");
+				goto handle_str;
+			case RBCE_RULE_IPV6:
+				strcpy(str, "ipv6");
+			      handle_str:
+				cp +=
+				    sprintf(cp, "%s=%s,", str, term->u.string);
+				break;
+			case RBCE_RULE_DEP_RULE:
+				cp +=
+				    sprintf(cp, "depend=%s,",
+					    term->u.deprule->obj.name);
+				break;
+			default:
+				break;
+			}
+		}
+
+		cp +=
+		    sprintf(cp, "order=%d,state=%d,", rule->order, rule->state);
+		cp +=
+		    sprintf(cp, "class=%s",
+			    rule->target_class ? rule->target_class->obj.
+			    name : "*****REMOVED*****");
+		*cp = '\0';
+	} else
+		sprintf(result, "***** Rule %s doesn't exist *****", rname);
+
+	read_unlock(&rbce_rwlock);
+	return;
+}
+
+/*
+ * Change the name of the given rule "from_rname" to "to_rname"
+ *
+ */
+int rbce_rename_rule(const char *from_rname, const char *to_rname)
+{
+	struct rbce_rule *rule;
+	int nlen, rc = -EINVAL;
+
+	if (!to_rname || !*to_rname)
+		return rc;
+	write_lock(&rbce_rwlock);
+
+	rule = find_rule_name(from_rname);
+	if (rule != NULL) {
+		if ((nlen = strlen(to_rname)) > strlen(rule->obj.name)) {
+			char *name = kmalloc(nlen + 1, GFP_ATOMIC);
+			if (!name)
+				return -ENOMEM;
+			kfree(rule->obj.name);
+			rule->obj.name = name;
+		}
+		strcpy(rule->obj.name, to_rname);
+		rc = 0;
+	}
+	write_unlock(&rbce_rwlock);
+	return rc;
+}
+
+/*
+ * Return TRUE if the given rule exists, FALSE otherwise
+ *
+ */
+int rbce_rule_exists(const char *rname)
+{
+	struct rbce_rule *rule;
+
+	read_lock(&rbce_rwlock);
+	rule = find_rule_name(rname);
+	read_unlock(&rbce_rwlock);
+	return rule != NULL;
+}
+
+/*====================== Magic file handling =======================*/
+struct rbce_private_data *create_private_data(struct rbce_private_data *a,
+						     int b)
+{
+	return NULL;
+}
+
+int rbce_set_tasktag(int pid, char *tag)
+{
+	char *tp;
+	int rc = 0;
+	struct task_struct *tsk;
+	struct rbce_private_data *pdata;
+	int len;
+
+	if (!tag)
+		return -EINVAL;
+	len = strlen(tag) + 1;
+	tp = kmalloc(len, GFP_ATOMIC);
+	if (!tp)
+		return -ENOMEM;
+	strncpy(tp,tag,len);
+
+	read_lock(&tasklist_lock);
+	if ((tsk = find_task_by_pid(pid)) == NULL) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (!RBCE_DATA(tsk)) {
+		RBCE_DATAP(tsk) = create_private_data(NULL, 0);
+		if (!RBCE_DATA(tsk)) {
+			rc = -ENOMEM;
+			goto out;
+		}
+	}
+	pdata = RBCE_DATA(tsk);
+	if (pdata->app_tag)
+		kfree(pdata->app_tag);
+	pdata->app_tag = tp;
+
+out:
+	read_unlock(&tasklist_lock);
+	if (rc != 0)
+		kfree(tp);
+	return rc;
 }
 
-int rbce_enabled = 1;
 /* ======================= Module definition Functions ====================== */
 
 int init_rbce(void)
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_token.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_token.c	2005-06-20 13:08:44.000000000 -0700
@@ -0,0 +1,241 @@
+/* Tokens for Rule-based Classification Engine (RBCE) and
+ * Consolidated RBCE module code (combined)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ *           (C) Vivek Kashyap, IBM Corp. 2004
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ *
+ */
+
+#include <linux/parser.h>
+#include <linux/ctype.h>
+#include "rbce_internal.h"
+
+int token_to_ruleop[TOKEN_INVALID + 1] = {
+	[TOKEN_PATH] = RBCE_RULE_CMD_PATH,
+	[TOKEN_CMD] = RBCE_RULE_CMD,
+	[TOKEN_ARGS] = RBCE_RULE_ARGS,
+	[TOKEN_RUID_EQ] = RBCE_RULE_REAL_UID,
+	[TOKEN_RUID_LT] = RBCE_RULE_REAL_UID,
+	[TOKEN_RUID_GT] = RBCE_RULE_REAL_UID,
+	[TOKEN_RUID_NOT] = RBCE_RULE_REAL_UID,
+	[TOKEN_RGID_EQ] = RBCE_RULE_REAL_GID,
+	[TOKEN_RGID_LT] = RBCE_RULE_REAL_GID,
+	[TOKEN_RGID_GT] = RBCE_RULE_REAL_GID,
+	[TOKEN_RGID_NOT] = RBCE_RULE_REAL_GID,
+	[TOKEN_EUID_EQ] = RBCE_RULE_EFFECTIVE_UID,
+	[TOKEN_EUID_LT] = RBCE_RULE_EFFECTIVE_UID,
+	[TOKEN_EUID_GT] = RBCE_RULE_EFFECTIVE_UID,
+	[TOKEN_EUID_NOT] = RBCE_RULE_EFFECTIVE_UID,
+	[TOKEN_EGID_EQ] = RBCE_RULE_EFFECTIVE_GID,
+	[TOKEN_EGID_LT] = RBCE_RULE_EFFECTIVE_GID,
+	[TOKEN_EGID_GT] = RBCE_RULE_EFFECTIVE_GID,
+	[TOKEN_EGID_NOT] = RBCE_RULE_EFFECTIVE_GID,
+	[TOKEN_TAG] = RBCE_RULE_APP_TAG,
+	[TOKEN_IPV4] = RBCE_RULE_IPV4,
+	[TOKEN_IPV6] = RBCE_RULE_IPV6,
+	[TOKEN_DEP] = RBCE_RULE_DEP_RULE,
+	[TOKEN_DEP_ADD] = RBCE_RULE_DEP_RULE,
+	[TOKEN_DEP_DEL] = RBCE_RULE_DEP_RULE,
+	[TOKEN_ORDER] = RBCE_RULE_INVALID,
+	[TOKEN_CLASS] = RBCE_RULE_INVALID,
+	[TOKEN_STATE] = RBCE_RULE_INVALID,
+};
+
+enum op_token token_to_operator[TOKEN_INVALID + 1] = {
+	[TOKEN_PATH] = (__force op_token_t) TOKEN_OP_EQUAL,
+	[TOKEN_CMD] = (__force op_token_t) TOKEN_OP_EQUAL,
+	[TOKEN_ARGS] = (__force op_token_t) TOKEN_OP_EQUAL,
+	[TOKEN_RUID_EQ] = (__force op_token_t) TOKEN_OP_EQUAL,
+	[TOKEN_RUID_LT] = (__force op_token_t) TOKEN_OP_LESS_THAN,
+	[TOKEN_RUID_GT] = (__force op_token_t) TOKEN_OP_GREATER_THAN,
+	[TOKEN_RUID_NOT] = (__force op_token_t) TOKEN_OP_NOT,
+	[TOKEN_RGID_EQ] = (__force op_token_t) TOKEN_OP_EQUAL,
+	[TOKEN_RGID_LT] = (__force op_token_t) TOKEN_OP_LESS_THAN,
+	[TOKEN_RGID_GT] = (__force op_token_t) TOKEN_OP_GREATER_THAN,
+	[TOKEN_RGID_NOT] = (__force op_token_t) TOKEN_OP_NOT,
+	[TOKEN_EUID_EQ] = (__force op_token_t) TOKEN_OP_EQUAL,
+	[TOKEN_EUID_LT] = (__force op_token_t) TOKEN_OP_LESS_THAN,
+	[TOKEN_EUID_GT] = (__force op_token_t) TOKEN_OP_GREATER_THAN,
+	[TOKEN_EUID_NOT] = (__force op_token_t) TOKEN_OP_NOT,
+	[TOKEN_EGID_EQ] = (__force op_token_t) TOKEN_OP_EQUAL,
+	[TOKEN_EGID_LT] = (__force op_token_t) TOKEN_OP_LESS_THAN,
+	[TOKEN_EGID_GT] = (__force op_token_t) TOKEN_OP_GREATER_THAN,
+	[TOKEN_EGID_NOT] = (__force op_token_t) TOKEN_OP_NOT,
+	[TOKEN_TAG] = (__force op_token_t) TOKEN_OP_EQUAL,
+	[TOKEN_IPV4] = (__force op_token_t) TOKEN_OP_EQUAL,
+	[TOKEN_IPV6] = (__force op_token_t) TOKEN_OP_EQUAL,
+	[TOKEN_DEP] = (__force op_token_t) TOKEN_OP_DEP,
+	[TOKEN_DEP_ADD] = (__force op_token_t) TOKEN_OP_DEP_ADD,
+	[TOKEN_DEP_DEL] = (__force op_token_t) TOKEN_OP_DEP_DEL,
+	[TOKEN_ORDER] = (__force op_token_t) TOKEN_OP_ORDER,
+	[TOKEN_CLASS] = (__force op_token_t) TOKEN_OP_CLASS,
+	[TOKEN_STATE] = (__force op_token_t) TOKEN_OP_STATE
+};
+
+static match_table_t tokens = {
+	{TOKEN_PATH, "path=%s"},
+	{TOKEN_CMD, "cmd=%s"},
+	{TOKEN_ARGS, "args=%s"},
+	{TOKEN_RUID_EQ, "uid=%d"},
+	{TOKEN_RUID_LT, "uid<%d"},
+	{TOKEN_RUID_GT, "uid>%d"},
+	{TOKEN_RUID_NOT, "uid!%d"},
+	{TOKEN_RGID_EQ, "gid=%d"},
+	{TOKEN_RGID_LT, "gid<%d"},
+	{TOKEN_RGID_GT, "gid>%d"},
+	{TOKEN_RGID_NOT, "gid!d"},
+	{TOKEN_EUID_EQ, "euid=%d"},
+	{TOKEN_EUID_LT, "euid<%d"},
+	{TOKEN_EUID_GT, "euid>%d"},
+	{TOKEN_EUID_NOT, "euid!%d"},
+	{TOKEN_EGID_EQ, "egid=%d"},
+	{TOKEN_EGID_LT, "egid<%d"},
+	{TOKEN_EGID_GT, "egid>%d"},
+	{TOKEN_EGID_NOT, "egid!%d"},
+	{TOKEN_TAG, "tag=%s"},
+	{TOKEN_IPV4, "ipv4=%s"},
+	{TOKEN_IPV6, "ipv6=%s"},
+	{TOKEN_DEP, "depend=%s"},
+	{TOKEN_DEP_ADD, "+depend=%s"},
+	{TOKEN_DEP_DEL, "-depend=%s"},
+	{TOKEN_ORDER, "order=%d"},
+	{TOKEN_CLASS, "class=%s"},
+	{TOKEN_STATE, "state=%d"},
+	{TOKEN_INVALID, NULL}
+};
+
+/*
+ * return -EINVAL in case of failures
+ * returns number of terms in terms on success.
+ * never returns 0.
+ */
+
+int
+rules_parse(char *rule_defn, struct rbce_rule_term **rterms, int *term_mask)
+{
+	char *p, *rp = rule_defn;
+	int option, i = 0, nterms;
+	struct rbce_rule_term *terms;
+
+	*rterms = NULL;
+	*term_mask = 0;
+	if (!rule_defn)
+		return -EINVAL;
+
+	nterms = 0;
+	while (*rp++)
+		if (*rp == '>' || *rp == '<' || *rp == '=' || *rp == '!')
+			nterms++;
+
+	if (!nterms)
+		return -EINVAL;
+
+	terms = kmalloc(nterms * sizeof(struct rbce_rule_term), GFP_KERNEL);
+	if (!terms)
+		return -ENOMEM;
+
+	while ((p = strsep(&rule_defn, ",")) != NULL) {
+
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+
+		while (*p && isspace(*p))
+			p++;
+		if (!*p)
+			continue;
+
+		token = match_token(p, tokens, args);
+
+		terms[i].op = token_to_ruleop[token];
+		terms[i].operator = token_to_operator[token];
+		switch (token) {
+
+		case TOKEN_PATH:
+		case TOKEN_CMD:
+		case TOKEN_ARGS:
+		case TOKEN_TAG:
+		case TOKEN_IPV4:
+		case TOKEN_IPV6:
+			/* all these tokens can be specified only once */
+			if (*term_mask & (1 << terms[i].op)) {
+				nterms = -EINVAL;
+				goto out;
+			}
+		/*FALLTHRU*/
+		case TOKEN_CLASS:
+		case TOKEN_DEP:
+		case TOKEN_DEP_ADD:
+		case TOKEN_DEP_DEL:
+			terms[i].u.string = args->from;
+			break;
+
+		case TOKEN_RUID_EQ:
+		case TOKEN_RUID_LT:
+		case TOKEN_RUID_GT:
+		case TOKEN_RUID_NOT:
+		case TOKEN_RGID_EQ:
+		case TOKEN_RGID_LT:
+		case TOKEN_RGID_GT:
+		case TOKEN_RGID_NOT:
+		case TOKEN_EUID_EQ:
+		case TOKEN_EUID_LT:
+		case TOKEN_EUID_GT:
+		case TOKEN_EUID_NOT:
+		case TOKEN_EGID_EQ:
+		case TOKEN_EGID_LT:
+		case TOKEN_EGID_GT:
+		case TOKEN_EGID_NOT:
+			/* all these tokens can be specified only once */
+			if (*term_mask & (1 << terms[i].op)) {
+				nterms = -EINVAL;
+				goto out;
+			}
+		/*FALLTHRU*/
+		case TOKEN_ORDER:
+		case TOKEN_STATE:
+			if (match_int(args, &option)) {
+				nterms = -EINVAL;
+				goto out;
+			}
+			terms[i].u.id = option;
+			break;
+		default:
+			nterms = -EINVAL;
+			goto out;
+		}
+		/* Check range of term value */
+		switch(token){
+		case TOKEN_STATE:
+			if ((terms[i].u.id != 0) && (terms[i].u.id != 1)){
+				nterms = -EINVAL;
+				goto out;
+			}
+			break;
+		default: /* Non-numerical value */
+			break;
+		}
+		*term_mask |= (1 << terms[i].op);
+		i++;
+	}
+	*rterms = terms;
+
+      out:
+	if (nterms < 0) {
+		kfree(terms);
+		*term_mask = 0;
+	}
+	return nterms;
+}

--

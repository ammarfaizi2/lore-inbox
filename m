Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVFWH6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVFWH6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVFWHuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:50:10 -0400
Received: from [24.22.56.4] ([24.22.56.4]:30438 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262337AbVFWGTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:19:06 -0400
Message-Id: <20050623061757.610921000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:09 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Hubertus Franke <frankeh@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Shailabh Nagar <nagar@us.ibm.com>, Vivek Kashyap <vivk@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 17/38] CKRM e18: Rule Based Classification Engine, bitvector support for classification info
Content-Disposition: inline; filename=09-03-rbce_main-opt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 3 of 5 patches to support Rule Based Classification Engine for CKRM.
This patch provides some optimization by maintaining the classification 
information in the vectors. No classification functionality yet.

Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

 rbce_bitvector.h |  146 +++++++++++++++++++++++++++++++++++++++++++++++
 rbce_internal.h  |   19 +++++-
 rbce_main.c      |  168 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+), 3 deletions(-)

Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_bitvector.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_bitvector.h	2005-06-20 13:08:45.000000000 -0700
@@ -0,0 +1,146 @@
+/*
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *
+ * Bitvector package
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef _RBCE_BITVECTOR_H
+#define _RBCE_BITVECTOR_H
+
+typedef struct {
+	int size;		/* maxsize in longs */
+	unsigned long bits[0];	/* bit vector */
+} bitvector_t;
+
+#define BITS_2_LONGS(sz)  (((sz)+BITS_PER_LONG-1)/BITS_PER_LONG)
+#define BITS_2_BYTES(sz)  (((sz)+7)/8)
+
+#if 0
+#define CHECK_VEC(vec) (vec)	/* check against NULL */
+#else
+#define CHECK_VEC(vec) (1)	/* assume no problem */
+#endif
+
+#define CHECK_VEC_VOID(vec)   do { if (!CHECK_VEC(vec)) return; } while(0)
+#define CHECK_VEC_RC(vec, val) \
+do { if (!CHECK_VEC(vec)) return (val); } while(0)
+
+inline static void bitvector_zero(bitvector_t * bitvec)
+{
+	int sz;
+
+	CHECK_VEC_VOID(bitvec);
+	sz = BITS_2_BYTES(bitvec->size);
+	memset(bitvec->bits, 0, sz);
+	return;
+}
+
+inline static unsigned long bitvector_bytes(unsigned long size)
+{
+	return sizeof(bitvector_t) + BITS_2_BYTES(size);
+}
+
+inline static void bitvector_init(bitvector_t * bitvec, unsigned long size)
+{
+	bitvec->size = size;
+	bitvector_zero(bitvec);
+	return;
+}
+
+inline static bitvector_t *bitvector_alloc(unsigned long size)
+{
+	bitvector_t *vec =
+	    (bitvector_t *) kmalloc(bitvector_bytes(size), GFP_KERNEL);
+	if (vec) {
+		vec->size = size;
+		bitvector_zero(vec);
+	}
+	return vec;
+}
+
+inline static void bitvector_free(bitvector_t * bitvec)
+{
+	CHECK_VEC_VOID(bitvec);
+	kfree(bitvec);
+	return;
+}
+
+#define def_bitvec_op(name,mod1,op,mod2) 			\
+inline static int name(bitvector_t *res, bitvector_t *op1,	\
+		       bitvector_t *op2)			\
+{								\
+	unsigned int i, size; 					\
+								\
+	CHECK_VEC_RC(res, 0); 					\
+	CHECK_VEC_RC(op1, 0); 					\
+	CHECK_VEC_RC(op2, 0); 					\
+	size = res->size; 					\
+	if (((size != (op1)->size) || (size != (op2)->size))) { \
+		return 0;					\
+	}							\
+	size = BITS_2_LONGS(size);				\
+	for (i = 0; i < size; i++) {				\
+		(res)->bits[i] = (mod1 (op1)->bits[i]) op 	\
+					(mod2 (op2)->bits[i]);	\
+	}							\
+	return 1;						\
+}
+
+def_bitvec_op(bitvector_or,, |,);
+def_bitvec_op(bitvector_and,, &,);
+def_bitvec_op(bitvector_xor,, ^,);
+def_bitvec_op(bitvector_or_not,, |, ~);
+def_bitvec_op(bitvector_not_or, ~, |,);
+def_bitvec_op(bitvector_and_not,, &, ~);
+def_bitvec_op(bitvector_not_and, ~, &,);
+
+inline static void bitvector_set(int idx, bitvector_t * vec)
+{
+	set_bit(idx, vec->bits);
+	return;
+}
+
+inline static void bitvector_clear(int idx, bitvector_t * vec)
+{
+	clear_bit(idx, vec->bits);
+	return;
+}
+
+inline static int bitvector_test(int idx, bitvector_t * vec)
+{
+	return test_bit(idx, vec->bits);
+}
+
+#ifdef DEBUG
+inline static void bitvector_print(int flag, bitvector_t * vec)
+{
+	unsigned int i;
+	int sz;
+	extern int rbcedebug;
+
+	if ((rbcedebug & flag) == 0) {
+		return;
+	}
+	if (vec == NULL) {
+		printk("v<0>-NULL\n");
+		return;
+	}
+	printk("v<%d>-", sz = vec->size);
+	for (i = 0; i < sz; i++) {
+		printk("%c", test_bit(i, vec->bits) ? '1' : '0');
+	}
+	return;
+}
+#else
+#define bitvector_print(x, y)
+#endif
+
+#endif				/* _RBCE_BITVECTOR_H */
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 13:08:44.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 13:08:45.000000000 -0700
@@ -51,6 +51,8 @@ struct named_obj_hdr {
 	char *name;
 };
 
+#include "rbce_bitvector.h"
+
 #define GET_REF(x) ((x)->obj.referenced)
 #define INC_REF(x) (GET_REF(x)++)
 #define DEC_REF(x) (--GET_REF(x))
@@ -185,14 +187,25 @@ enum op_token {
 	TOKEN_OP_STATE = (__force op_token_t) (TOKEN_OP_GREATER_THAN+6),
 };
 
-
 /*
- * data structure rbce_private_data to hold the app_tag for a task.
- * Expands later.
+ * data structure rbce_private_data holds the bit vector 'eval' which
+ * specifies if rules and terms of rules are evaluated against the task
+ * and if they were evaluated, bit vector 'true' holds the result of that
+ * evaluation.
+ *
+ * This data structure is maintained in a task, and the bitvectors are
+ * updated only when needed.
+ *
+ * Each rule and each term of a rule has a corresponding bit in the vector.
  *
  */
 struct rbce_private_data {
+  	int evaluate;		/* whether to evaluate rules or not ? */
+  	int rules_version;	/* rules_version at last evaluation */
+	bitvector_t *eval;
+	bitvector_t *true;
 	char *app_tag;
+  	char data[0];		/* bitvectors eval and true */
 };
 
 #define RBCE_DATA(tsk) ((struct rbce_private_data*)((tsk)->ce_data))
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_main.c	2005-06-20 13:08:44.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c	2005-06-20 13:08:45.000000000 -0700
@@ -23,6 +23,7 @@
  */
 
 #include "rbce_internal.h"
+#include "rbce_bitvector.h"
 
 MODULE_DESCRIPTION(RBCE_MOD_DESCR);
 MODULE_AUTHOR("Hubertus Franke, Chandra Seetharaman (IBM)");
@@ -57,14 +58,17 @@ int termop_2_vecidx[RBCE_RULE_INVALID] =
 extern int errno;
 
 int rbce_enabled = 1;
+const int use_persistent_state = 1;
 
 static LIST_HEAD(class_list);
 static struct list_head rules_list[CKRM_MAX_CLASSTYPES];
 static int gl_num_rules;
 static int gl_action, gl_num_terms;
+static int gl_bitmap_version, gl_action, gl_num_terms;
 static int gl_allocated, gl_released;
 static struct rbce_rule_term *gl_terms;
 static int gl_rules_version;
+static bitvector_t *gl_mask_vecs[NUM_TERM_MASK_VECTOR];
 static rwlock_t rbce_rwlock = RW_LOCK_UNLOCKED;
 	/*
 	 * One lock to protect them all !!!
@@ -78,6 +82,8 @@ static rwlock_t rbce_rwlock = RW_LOCK_UN
 
 /* ======================= Helper Functions ========================= */
 
+static void optimize_policy(void);
+
 static inline struct rbce_rule *find_rule_name(const char *name)
 {
 	struct named_obj_hdr *pos;
@@ -159,6 +165,8 @@ static int insert_rule(struct rbce_rule 
 	}
 	gl_rules_version++;
 	list_add_tail(&rule->obj.link, insert);
+	if (rbce_enabled)
+		optimize_policy();
 	return 0;
 }
 
@@ -337,9 +345,150 @@ static inline int __delete_rule(struct r
 	module_put(THIS_MODULE);
 	kfree(rule->obj.name);
 	kfree(rule);
+	if (rbce_enabled && (gl_action & POLICY_ACTION_PACK_TERMS))
+		optimize_policy();
 	return 0;
 }
 
+/*
+ * Optimize the rule evaluation logic
+ *
+ * Caller must hold global_rwlock in write mode.
+ */
+static void optimize_policy(void)
+{
+	int i, ii;
+	struct rbce_rule *rule;
+	struct rbce_rule_term *terms;
+	int num_terms;
+	int bsize;
+	bitvector_t **mask_vecs;
+	int pack_terms = 0;
+	int redoall;
+
+	/*
+	 * Due to dynamic rule addition/deletion of rules the term
+	 * vector can get sparse. As a result the bitvectors grow as we don't
+	 * reuse returned indices. If it becomes sparse enough we pack them
+	 * closer.
+	 */
+
+	pack_terms = (gl_action & POLICY_ACTION_PACK_TERMS);
+
+	if (pack_terms) {
+		int nsz = ALIGN((gl_num_terms - gl_released),
+				POLICY_INC_NUMTERMS);
+		int newidx = 0;
+		struct rbce_rule_term *newterms;
+
+		terms = gl_terms;
+		newterms =
+		    kmalloc(nsz * sizeof(struct rbce_rule_term), GFP_ATOMIC);
+		if (newterms) {
+			for (ii = 0; ii < CKRM_MAX_CLASSTYPES; ii++) {
+				/* FIXME: check only for task class types */
+				list_for_each_entry_reverse(rule,
+							    &rules_list[ii],
+							    obj.link) {
+					rule->index = newidx++;
+					for (i = rule->num_terms; --i >= 0;) {
+						int idx = rule->terms[i];
+						newterms[newidx] = terms[idx];
+						rule->terms[i] = newidx++;
+					}
+				}
+			}
+			kfree(terms);
+			gl_allocated = nsz;
+			gl_released = 0;
+			gl_num_terms = newidx;
+			gl_terms = newterms;
+
+			gl_action &= ~POLICY_ACTION_PACK_TERMS;
+			gl_action |= POLICY_ACTION_NEW_VERSION;
+		}
+	}
+
+	num_terms = gl_num_terms;
+	bsize = gl_allocated / 8 + sizeof(bitvector_t);
+	mask_vecs = gl_mask_vecs;
+	terms = gl_terms;
+
+	if (gl_action & POLICY_ACTION_NEW_VERSION) {
+		/* allocate new mask vectors */
+		char *temp = kmalloc(NUM_TERM_MASK_VECTOR * bsize, GFP_ATOMIC);
+
+		if (!temp) {
+			return;
+		}
+		if (mask_vecs[0]) {/* index 0 has the alloc returned address */
+			kfree(mask_vecs[0]);
+		}
+		for (i = 0; i < NUM_TERM_MASK_VECTOR; i++) {
+			mask_vecs[i] = (bitvector_t *) (temp + i * bsize);
+			bitvector_init(mask_vecs[i], gl_allocated);
+		}
+		gl_action &= ~POLICY_ACTION_NEW_VERSION;
+		gl_action |= POLICY_ACTION_REDO_ALL;
+		gl_bitmap_version++;
+	}
+
+	/* We do two things here at once
+	 * 1) recompute the rulemask for each required rule
+	 *      we guarantee proper dependency order during creation time and
+	 *      by reversely running through this list.
+	 * 2) recompute the mask for each term and rule, if required
+	 */
+
+	redoall = gl_action & POLICY_ACTION_REDO_ALL;
+	gl_action &= ~POLICY_ACTION_REDO_ALL;
+
+	for (ii = 0; ii < CKRM_MAX_CLASSTYPES; ii++) {
+		/* FIXME: check only for task class types */
+		list_for_each_entry_reverse(rule, &rules_list[ii], obj.link) {
+			unsigned long termflag;
+
+			if (!redoall && !rule->do_opt)
+				continue;
+			termflag = 0;
+			for (i = rule->num_terms; --i >= 0;) {
+				int j, idx = rule->terms[i];
+				struct rbce_rule_term *term = &terms[idx];
+				int vecidx = termop_2_vecidx[term->op];
+
+				if (vecidx == -1) {
+					termflag |= term->u.deprule->termflag;
+					/* mark this term belonging to all
+					   contexts of deprule */
+					for (j = 0; j < NUM_TERM_MASK_VECTOR;
+					     j++) {
+						if (term->u.deprule->termflag
+						    & (1 << j)) {
+							bitvector_set(idx,
+								      mask_vecs
+								      [j]);
+						}
+					}
+				} else {
+					termflag |= TERM_2_TERMFLAG(vecidx);
+					/* mark this term belonging to
+					   a particular context */
+					bitvector_set(idx, mask_vecs[vecidx]);
+				}
+			}
+			for (i = 0; i < NUM_TERM_MASK_VECTOR; i++) {
+				if (termflag & (1 << i)) {
+					bitvector_set(rule->index,
+						      mask_vecs[i]);
+				}
+			}
+			rule->termflag = termflag;
+			rule->do_opt = 0;
+		}
+	}
+	return;
+}
+
 /* ======================= Rule related Functions ========================= */
 
 /*
@@ -984,6 +1133,25 @@ struct rbce_private_data *create_private
 	return NULL;
 }
 
+static inline
+void reset_evaluation(struct rbce_private_data *pdata,int termflag)
+{
+	/* reset TAG ruleterm evaluation results to pick up
+ 	 * on next classification event
+ 	 */
+	if (termflag >= NUM_TERM_MASK_VECTOR) {
+		printk(KERN_ERR "rbce:reset_evaluation: trying to access "
+			"past valid address\n");
+		return;
+	}
+ 	if (use_persistent_state && gl_mask_vecs[termflag]) {
+ 		bitvector_and_not( pdata->eval, pdata->eval,
+ 				   gl_mask_vecs[termflag] );
+ 		bitvector_and_not( pdata->true, pdata->true,
+ 				   gl_mask_vecs[termflag] );
+ 	}
+}
+
 int rbce_set_tasktag(int pid, char *tag)
 {
 	char *tp;

--

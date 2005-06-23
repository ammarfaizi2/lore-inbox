Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVFWHfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVFWHfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVFWHbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:31:36 -0400
Received: from [24.22.56.4] ([24.22.56.4]:13798 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262268AbVFWGSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:42 -0400
Message-Id: <20050623061757.826813000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:10 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Hubertus Franke <frankeh@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Shailabh Nagar <nagar@us.ibm.com>, Vivek Kashyap <vivk@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 18/38] CKRM e18: Rule Based Classification Engine, full CE
Content-Disposition: inline; filename=09-04-rbce_opt-core
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 4 of 5 patches to support Rule Based Classification Engine for CKRM.
This patch connects RBCE with CKRM core. Full functionality of RBCE 
achieved with this patch.

Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

 Makefile        |    2 
 rbce_core.c     |  890 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rbce_internal.h |   23 +
 rbce_main.c     |   67 ++--
 4 files changed, 961 insertions(+), 21 deletions(-)

Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/Makefile
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/Makefile	2005-06-20 13:08:44.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/Makefile	2005-06-20 13:08:46.000000000 -0700
@@ -3,4 +3,4 @@
 #
 
 obj-$(CONFIG_CKRM_RBCE)	+= rbce.o
-rbce-objs := rbce_fs.o rbce_main.o rbce_token.o
+rbce-objs := rbce_fs.o rbce_main.o rbce_token.o rbce_core.o
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_core.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_core.c	2005-06-20 13:08:46.000000000 -0700
@@ -0,0 +1,890 @@
+/* Rule-based Classification Engine (RBCE) and
+ * Consolidated RBCE module code (combined)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *           (C) Chandra Seetharaman, IBM Corp. 2003
+ *           (C) Vivek Kashyap, IBM Corp. 2004
+ *
+ * Module for loading of classification policies and providing
+ * a user API for Class-based Kernel Resource Management (CKRM)
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
+ */
+
+#include "rbce_internal.h"
+
+/*
+ * Callback from core when a class is deleted.
+ */
+static void
+rbce_class_deletecb(const char *classname, void *classobj, int classtype)
+{
+	static struct rbce_class *cls;
+	struct named_obj_hdr *pos;
+	struct rbce_rule *rule;
+
+	write_lock(&rbce_rwlock);
+	cls = find_class_name(classname);
+	if (cls) {
+		if (cls->classobj != classobj) {
+			printk(KERN_ERR "rbce: class %s changed identity\n",
+			       classname);
+		}
+		cls->classobj = NULL;
+		list_for_each_entry(pos, &rules_list[cls->classtype], link) {
+			rule = (struct rbce_rule *)pos;
+			if (rule->target_class) {
+				if (!strcmp
+				    (rule->target_class->obj.name, classname)) {
+					put_class(cls);
+					rule->target_class = NULL;
+					rule->classtype = -1;
+				}
+			}
+		}
+		if ((cls = find_class_name(classname)) != NULL) {
+			printk(KERN_ERR
+			       "rbce ERROR: class %s exists in rbce after "
+			       "removal in core\n", classname);
+		}
+	}
+	write_unlock(&rbce_rwlock);
+	return;
+}
+
+/*====================== Classification Functions =======================*/
+
+/*
+ * Match the given full path name with the command expression.
+ * This function treats the folowing 2 charaters as special if seen in
+ * cmd_exp, all other chanracters are compared as is:
+ *		? - compares to any one single character
+ *		* - compares to one or more single characters
+ *
+ * If fullpath is 1, tsk_comm is compared in full. otherwise only the command
+ * name (basename(tsk_comm)) is compared.
+ */
+static inline int
+match_cmd(const char *tsk_comm, const char *cmd_exp, int fullpath)
+{
+	const char *c, *t, *last_ast, *cmd = tsk_comm;
+	char next_c;
+
+	/* get the command name if we don't have to match the fullpath */
+	if (!fullpath && ((c = strrchr(tsk_comm, '/')) != NULL)) {
+		cmd = c + 1;
+	}
+
+	/* now faithfully assume the entire pathname is in cmd */
+
+	/* we now have to effectively implement a regular expression
+	 * for now assume
+	 *    '?'   any single character
+	 *    '*'   one or more '?'
+	 *    rest  must match
+	 */
+
+	c = cmd_exp;
+	t = cmd;
+	if (t == NULL || c == NULL) {
+		return 0;
+	}
+
+	last_ast = NULL;
+	next_c = '\0';
+
+	while (*c && *t) {
+		switch (*c) {
+		case '?':
+			if (*t == '/') {
+				return 0;
+			}
+			c++;
+			t++;
+			continue;
+		case '*':
+			if (*t == '/') {
+				return 0;
+			}
+			/* eat up all '*' in c */
+			while (*(c + 1) == '*')
+				c++;
+			next_c = '\0';
+			last_ast = c;
+			/*t++; 	Add this for matching '*' with "one"
+				or more chars. */
+			while (*t && (*t != *(c + 1)) && *t != '/')
+				t++;
+			if (*t == *(c + 1)) {
+				c++;
+				if (*c != '/') {
+					if (*c == '?') {
+						if (*t == '/') {
+							return 0;
+						}
+						t++;
+						c++;
+					}
+					next_c = *c;
+					if (*c) {
+						if (*t == '/') {
+							return 0;
+						}
+						t++;
+						c++;
+						if (!*c && *t)
+							c = last_ast;
+					}
+				} else {
+					last_ast = NULL;
+				}
+				continue;
+			}
+			return 0;
+		case '/':
+			next_c = '\0';
+		 /*FALLTHRU*/ default:
+			if (*t == *c && next_c != *t) {
+				c++, t++;
+				continue;
+			} else {
+				/* reset to last asterix and
+				   continue from there */
+				if (last_ast) {
+					c = last_ast;
+				} else {
+					return 0;
+				}
+			}
+		}
+	}
+
+	/* check for trailing "*" */
+	while (*c == '*')
+		c++;
+
+	return (!*c && !*t);
+}
+
+static inline void reverse(char *str, int n)
+{
+	char s;
+	int i, j = n - 1;
+
+	for (i = 0; i < j; i++, j--) {
+		s = str[i];
+		str[i] = str[j];
+		str[j] = s;
+	}
+}
+
+static inline int itoa(int n, char *str)
+{
+	int i = 0, sz = 0;
+
+	do {
+		str[i++] = n % 10 + '0';
+		sz++;
+		n = n / 10;
+	} while (n > 0);
+
+	(void)reverse(str, sz);
+	return sz;
+}
+
+static inline int v4toa(__u32 y, char *a)
+{
+	int i;
+	int size = 0;
+
+	for (i = 0; i < 4; i++) {
+		size += itoa(y & 0xff, &a[size]);
+		a[size++] = '.';
+		y >>= 8;
+	}
+	return --size;
+}
+
+static inline int match_ipv4(struct ckrm_net_struct *ns, char **string)
+{
+	char *ptr = *string;
+	int size;
+	char a4[16];
+
+	size = v4toa(ns->ns_daddrv4, a4);
+
+	*string += size;
+	return !strncmp(a4, ptr, size);
+}
+
+static inline int match_port(struct ckrm_net_struct *ns, char *ptr)
+{
+	char a[5];
+	int size = itoa(ns->ns_dport, a);
+
+	return !strncmp(a, ptr, size);
+}
+
+static int __evaluate_rule(struct task_struct *tsk, struct ckrm_net_struct *ns,
+			   struct rbce_rule *rule, bitvector_t * vec_eval,
+			   bitvector_t * vec_true, char **filename);
+/*
+ * evaluate the given task against the given rule with the vec_eval and
+ * vec_true in context. Return 1 if the task satisfies the given rule, 0
+ * otherwise.
+ *
+ * If the bit corresponding to the rule is set in the vec_eval, then the
+ * corresponding bit in vec_true is the result. If it is not set, evaluate
+ * the rule and set the bits in both the vectors accordingly.
+ *
+ * On return, filename will have the pointer to the pathname of the task's
+ * executable, if the rule had any command related terms.
+ *
+ * Caller must hold the rbce_rwlock atleast in read mode.
+ */
+static inline int
+evaluate_rule(struct task_struct *tsk, struct ckrm_net_struct *ns,
+	      struct rbce_rule *rule, bitvector_t * vec_eval,
+	      bitvector_t * vec_true, char **filename)
+{
+	int tidx = rule->index;
+
+	if (!bitvector_test(tidx, vec_eval)) {
+		if (__evaluate_rule
+		    (tsk, ns, rule, vec_eval, vec_true, filename)) {
+			bitvector_set(tidx, vec_true);
+		}
+		bitvector_set(tidx, vec_eval);
+	}
+	return bitvector_test(tidx, vec_true);
+}
+
+/*
+ * evaluate the given task against every term in the given rule with
+ * vec_eval and vec_true in context.
+ *
+ * If the bit corresponding to a rule term is set in the vec_eval, then the
+ * corresponding bit in vec_true is the result for taht particular. If it is
+ * not set, evaluate the rule term and set the bits in both the vectors
+ * accordingly.
+ *
+ * This fucntions returns true only if all terms in the rule evaluate true.
+ *
+ * On return, filename will have the pointer to the pathname of the task's
+ * executable, if the rule had any command related terms.
+ *
+ * Caller must hold the rbce_rwlock atleast in read mode.
+ */
+static int
+__evaluate_rule(struct task_struct *tsk, struct ckrm_net_struct *ns,
+		struct rbce_rule *rule, bitvector_t * vec_eval,
+		bitvector_t * vec_true, char **filename)
+{
+	int i;
+	int no_ip = 1;
+
+	for (i = rule->num_terms; --i >= 0;) {
+		int rc = 1, tidx = rule->terms[i];
+
+		if (!bitvector_test(tidx, vec_eval)) {
+			struct rbce_rule_term *term = &gl_terms[tidx];
+
+			switch (term->op) {
+
+			case RBCE_RULE_CMD_PATH:
+			case RBCE_RULE_CMD:
+#if __NOT_YET__
+				if (!*filename) {	/* get this once */
+					if (((*filename =
+					      kmalloc(NAME_MAX,
+						      GFP_ATOMIC)) == NULL)
+					    ||
+					    (get_exe_path_name
+					     (tsk, *filename, NAME_MAX) < 0)) {
+						rc = 0;
+						break;
+					}
+				}
+				rc = match_cmd(*filename, term->u.string,
+					       (term->op ==
+						RBCE_RULE_CMD_PATH));
+#else
+				rc = match_cmd(tsk->comm, term->u.string,
+					       (term->op ==
+						RBCE_RULE_CMD_PATH));
+#endif
+				break;
+			case RBCE_RULE_REAL_UID:
+				if (term->operator == RBCE_LESS_THAN) {
+					rc = (tsk->uid < term->u.id);
+				} else if (term->operator == RBCE_GREATER_THAN){
+					rc = (tsk->uid > term->u.id);
+				} else if (term->operator == RBCE_NOT) {
+					rc = (tsk->uid != term->u.id);
+				} else {
+					rc = (tsk->uid == term->u.id);
+				}
+				break;
+			case RBCE_RULE_REAL_GID:
+				if (term->operator == RBCE_LESS_THAN) {
+					rc = (tsk->gid < term->u.id);
+				} else if (term->operator == RBCE_GREATER_THAN){
+					rc = (tsk->gid > term->u.id);
+				} else if (term->operator == RBCE_NOT) {
+					rc = (tsk->gid != term->u.id);
+				} else {
+					rc = (tsk->gid == term->u.id);
+				}
+				break;
+			case RBCE_RULE_EFFECTIVE_UID:
+				if (term->operator == RBCE_LESS_THAN) {
+					rc = (tsk->euid < term->u.id);
+				} else if (term->operator == RBCE_GREATER_THAN){
+					rc = (tsk->euid > term->u.id);
+				} else if (term->operator == RBCE_NOT) {
+					rc = (tsk->euid != term->u.id);
+				} else {
+					rc = (tsk->euid == term->u.id);
+				}
+				break;
+			case RBCE_RULE_EFFECTIVE_GID:
+				if (term->operator == RBCE_LESS_THAN) {
+					rc = (tsk->egid < term->u.id);
+				} else if (term->operator == RBCE_GREATER_THAN){
+					rc = (tsk->egid > term->u.id);
+				} else if (term->operator == RBCE_NOT) {
+					rc = (tsk->egid != term->u.id);
+				} else {
+					rc = (tsk->egid == term->u.id);
+				}
+				break;
+			case RBCE_RULE_APP_TAG:
+				rc = (RBCE_DATA(tsk)
+				      && RBCE_DATA(tsk)->
+				      app_tag) ? !strcmp(RBCE_DATA(tsk)->
+							 app_tag,
+							 term->u.string) : 0;
+				break;
+			case RBCE_RULE_DEP_RULE:
+				rc = evaluate_rule(tsk, NULL, term->u.deprule,
+						   vec_eval, vec_true,
+						   filename);
+				break;
+
+			case RBCE_RULE_IPV4:
+				/* TBD: add NOT_EQUAL match. At present */
+				/* rbce recognises EQUAL matches only.  */
+				if (ns && term->operator == RBCE_EQUAL) {
+					int ma = 0;
+					int mp = 0;
+					char *ptr = term->u.string;
+
+					if (term->u.string[0] == '*')
+						ma = 1;
+					else
+						ma = match_ipv4(ns, &ptr);
+
+					if (*ptr != '\\') {
+						rc = 0;
+						break;
+					} else {
+						++ptr;
+						if (*ptr == '*')
+							mp = 1;
+						else
+							mp = match_port(ns,
+									ptr);
+					}
+					rc = mp && ma;
+				} else
+					rc = 0;
+				no_ip = 0;
+				break;
+
+			case RBCE_RULE_IPV6:	/* no support yet */
+				rc = 0;
+				no_ip = 0;
+				break;
+
+			default:
+				rc = 0;
+				printk(KERN_ERR "Error evaluate term op=%d\n",
+				       term->op);
+				break;
+			}
+			if (!rc && no_ip) {
+				bitvector_clear(tidx, vec_true);
+			} else {
+				bitvector_set(tidx, vec_true);
+			}
+			bitvector_set(tidx, vec_eval);
+		} else {
+			rc = bitvector_test(tidx, vec_true);
+		}
+		if (!rc) {
+			return 0;
+		}
+	}
+	return 1;
+}
+
+/*
+ * This is some old debug code which needs to be trimmed.
+ */
+
+#define valid_pdata(pdata) (1)
+#define store_pdata(pdata)
+#define unstore_pdata(pdata)
+
+struct rbce_private_data *create_private_data(struct rbce_private_data
+						     *src, int copy_sample)
+{
+	int vsize = 0, psize, bsize = 0;
+	struct rbce_private_data *pdata;
+
+	if (use_persistent_state) {
+		vsize = gl_allocated;
+		bsize = vsize / 8 + sizeof(bitvector_t);
+		psize = sizeof(struct rbce_private_data) + 2 * bsize;
+	} else {
+		psize = sizeof(struct rbce_private_data);
+	}
+
+	pdata = kmalloc(psize, GFP_ATOMIC);
+	if (pdata != NULL) {
+		if (use_persistent_state) {
+			pdata->bitmap_version = gl_bitmap_version;
+			pdata->eval = (bitvector_t *) & pdata->data[0];
+			pdata->true = (bitvector_t *) & pdata->data[bsize];
+			if (src && (src->bitmap_version == gl_bitmap_version)) {
+				memcpy(pdata->data, src->data, 2 * bsize);
+			} else {
+				bitvector_init(pdata->eval, vsize);
+				bitvector_init(pdata->true, vsize);
+			}
+		}
+		pdata->evaluate = 1;
+		pdata->rules_version = src ? src->rules_version : 0;
+		pdata->app_tag = NULL;
+	}
+	store_pdata(pdata);
+	return pdata;
+}
+
+static inline void free_private_data(struct rbce_private_data *pdata)
+{
+	if (valid_pdata(pdata)) {
+		unstore_pdata(pdata);
+		kfree(pdata);
+	}
+}
+
+void free_all_private_data(void)
+{
+	struct task_struct *proc, *thread;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(proc, thread) {
+		struct rbce_private_data *pdata;
+
+		pdata = RBCE_DATA(thread);
+		RBCE_DATAP(thread) = NULL;
+		free_private_data(pdata);
+	} while_each_thread(proc, thread);
+	read_unlock(&tasklist_lock);
+	return;
+}
+
+/*
+ * reclassify function, which is called by all the callback functions.
+ *
+ * Takes that task to be reclassified and ruleflags that indicates the
+ * attributes that caused this reclassification request.
+ *
+ * On success, returns the core class pointer to which the given task should
+ * belong to.
+ */
+static struct ckrm_core_class *rbce_classify(struct task_struct *tsk,
+					     struct ckrm_net_struct *ns,
+					     unsigned long termflag,
+					     int classtype)
+{
+	int i;
+	struct rbce_rule *rule;
+	bitvector_t *vec_true = NULL, *vec_eval = NULL;
+	struct rbce_class *tgt = NULL;
+	struct ckrm_core_class *cls = NULL;
+	char *filename = NULL;
+
+	if (!valid_pdata(RBCE_DATA(tsk))) {
+		return NULL;
+	}
+	if (classtype >= CKRM_MAX_CLASSTYPES) {
+		/* can't handle more than CKRM_MAX_CLASSTYPES */
+		return NULL;
+	}
+	/* fast path to avoid locking in case CE is not enabled or */
+	/* if no rules are defined or if no evaluation is needed.  */
+	if (!rbce_enabled || !gl_num_rules ||
+	    (RBCE_DATA(tsk) && !RBCE_DATA(tsk)->evaluate)) {
+		return NULL;
+	}
+	/* FIXME: optimize_policy should be called from here if      */
+	/* gl_action is non-zero. Also, it has to be called with the */
+	/* rbce_rwlock held in write mode.                           */
+
+	read_lock(&rbce_rwlock);
+
+	vec_eval = vec_true = NULL;
+	if (use_persistent_state) {
+		struct rbce_private_data *pdata = RBCE_DATA(tsk);
+
+		if (!pdata
+		    || (pdata
+			&& (gl_bitmap_version != pdata->bitmap_version))) {
+			struct rbce_private_data *new_pdata =
+			    create_private_data(pdata, 1);
+
+			if (new_pdata) {
+				if (pdata) {
+					new_pdata->rules_version =
+					    pdata->rules_version;
+					new_pdata->evaluate = pdata->evaluate;
+					new_pdata->app_tag = pdata->app_tag;
+					free_private_data(pdata);
+				}
+				pdata = RBCE_DATAP(tsk) = new_pdata;
+				termflag = RBCE_TERMFLAG_ALL;
+				/* need to evaluate them all */
+			} else {
+				/*
+				 * we shouldn't free the pdata as it has more
+				 * details than the vectors. But, this
+				 * reclassification should go thru
+				 */
+				pdata = NULL;
+			}
+		}
+		if (!pdata) {
+			goto cls_determined;
+		}
+		vec_eval = pdata->eval;
+		vec_true = pdata->true;
+	} else {
+		int bsize = gl_allocated;
+
+		vec_eval = bitvector_alloc(bsize);
+		vec_true = bitvector_alloc(bsize);
+
+		if (vec_eval == NULL || vec_true == NULL) {
+			goto cls_determined;
+		}
+		termflag = RBCE_TERMFLAG_ALL;
+		/* need to evaluate all of them now */
+	}
+
+	/*
+	 * using bit ops invalidate all terms related to this termflag
+	 * context (only in per task vec)
+	 */
+
+	if (termflag == RBCE_TERMFLAG_ALL) {
+		bitvector_zero(vec_eval);
+	} else {
+		for (i = 0; i < NUM_TERM_MASK_VECTOR; i++) {
+			if (test_bit(i, &termflag)) {
+				bitvector_t *maskvec = get_gl_mask_vecs(i);
+
+				bitvector_and_not(vec_eval, vec_eval, maskvec);
+			}
+		}
+	}
+	bitvector_and(vec_true, vec_true, vec_eval);
+
+	/* run through the rules in order and see what needs evaluation */
+	list_for_each_entry(rule, &rules_list[classtype], obj.link) {
+		if (rule->state == RBCE_RULE_ENABLED &&
+		    rule->target_class &&
+		    rule->target_class->classobj &&
+		    evaluate_rule(tsk, ns, rule, vec_eval, vec_true,
+				  &filename)) {
+			tgt = rule->target_class;
+			cls = rule->target_class->classobj;
+			break;
+		}
+	}
+
+      cls_determined:
+	if (!use_persistent_state) {
+		if (vec_eval) {
+			bitvector_free(vec_eval);
+		}
+		if (vec_true) {
+			bitvector_free(vec_true);
+		}
+	}
+	ckrm_core_grab(cls);
+	read_unlock(&rbce_rwlock);
+	if (filename) {
+		kfree(filename);
+	}
+	if (RBCE_DATA(tsk)) {
+		RBCE_DATA(tsk)->rules_version = gl_rules_version;
+	}
+	return cls;
+}
+
+/*****************************************************************************
+ *
+ * Module specific utilization of core RBCE functionality
+ *
+ * Includes support for the various classtypes
+ * New classtypes will require extensions here
+ *
+ *****************************************************************************/
+
+/* helper functions that are required in the extended version */
+
+static inline void rbce_tc_manual(struct task_struct *tsk)
+{
+	read_lock(&rbce_rwlock);
+
+	if (!RBCE_DATA(tsk)) {
+		RBCE_DATAP(tsk) =
+		    (void *)create_private_data(RBCE_DATA(tsk->parent), 0);
+	}
+	if (RBCE_DATA(tsk)) {
+		RBCE_DATA(tsk)->evaluate = 0;
+	}
+	read_unlock(&rbce_rwlock);
+	return;
+}
+
+/*****************************************************************************
+ *    VARIOUS CLASSTYPES
+ *****************************************************************************/
+
+/* to enable type coercion of the function pointers */
+
+/*============================================================================
+ *    TASKCLASS CLASSTYPE
+ *============================================================================*/
+
+int tc_classtype = -1;
+
+/*
+ * fork callback to be registered with core module.
+ */
+static inline void *rbce_tc_forkcb(struct task_struct *tsk)
+{
+	int rule_version_changed = 1;
+	struct ckrm_core_class *cls;
+	read_lock(&rbce_rwlock);
+	/* dup ce_data */
+	RBCE_DATAP(tsk) =
+	    (void *)create_private_data(RBCE_DATA(tsk->parent), 0);
+	read_unlock(&rbce_rwlock);
+
+	if (RBCE_DATA(tsk->parent)) {
+		rule_version_changed =
+		    (RBCE_DATA(tsk->parent)->rules_version != gl_rules_version);
+	}
+	cls = rule_version_changed ?
+	    rbce_classify(tsk, NULL, RBCE_TERMFLAG_ALL, tc_classtype) : NULL;
+
+	/*
+	 * note the fork notification to any user client will be sent through
+	 * the guaranteed fork-reclassification
+	 */
+	return cls;
+}
+
+/*
+ * exit callback to be registered with core module.
+ */
+static void rbce_tc_exitcb(struct task_struct *tsk)
+{
+	struct rbce_private_data *pdata;
+
+	pdata = RBCE_DATA(tsk);
+	RBCE_DATAP(tsk) = NULL;
+	if (pdata) {
+		if (pdata->app_tag) {
+			kfree(pdata->app_tag);
+		}
+		free_private_data(pdata);
+	}
+	return;
+}
+
+static void *rbce_tc_classify(enum ckrm_event event, ...)
+{
+	va_list args;
+	void *cls = NULL;
+	struct task_struct *tsk;
+	struct rbce_private_data *pdata;
+
+	va_start(args, event);
+	tsk = va_arg(args, struct task_struct *);
+	va_end(args);
+
+	/* we only have to deal with events between
+	 * [ CKRM_LATCHABLE_EVENTS .. CKRM_NONLATCHABLE_EVENTS )
+	 */
+	switch (event) {
+
+	case CKRM_EVENT_FORK:
+		cls = rbce_tc_forkcb(tsk);
+		break;
+
+	case CKRM_EVENT_EXIT:
+		rbce_tc_exitcb(tsk);
+		break;
+
+	case CKRM_EVENT_EXEC:
+		cls = rbce_classify(tsk, NULL, RBCE_TERMFLAG_CMD |
+				    RBCE_TERMFLAG_UID | RBCE_TERMFLAG_GID,
+				    tc_classtype);
+		break;
+
+	case CKRM_EVENT_UID:
+		cls = rbce_classify(tsk, NULL, RBCE_TERMFLAG_UID, tc_classtype);
+		break;
+
+	case CKRM_EVENT_GID:
+		cls = rbce_classify(tsk, NULL, RBCE_TERMFLAG_GID, tc_classtype);
+		break;
+
+	case CKRM_EVENT_LOGIN:
+	case CKRM_EVENT_USERADD:
+	case CKRM_EVENT_USERDEL:
+	case CKRM_EVENT_LISTEN_START:
+	case CKRM_EVENT_LISTEN_STOP:
+	case CKRM_EVENT_APPTAG:
+		/* no interest in this events .. */
+		break;
+
+	default:
+		/* catch all */
+		break;
+
+	case CKRM_EVENT_RECLASSIFY:
+		if ((pdata = (RBCE_DATA(tsk)))) {
+			pdata->evaluate = 1;
+		}
+		cls = rbce_classify(tsk, NULL, RBCE_TERMFLAG_ALL, tc_classtype);
+		break;
+
+	}
+
+	return cls;
+}
+
+static void rbce_tc_notify(int event, void *core, struct task_struct *tsk)
+{
+	if (event != CKRM_EVENT_MANUAL)
+		return;
+	rbce_tc_manual(tsk);
+}
+
+static struct ckrm_eng_callback rbce_taskclass_ecbs = {
+	.c_interest = (unsigned long)(-1),	/* set whole bitmap */
+	.classify = (ce_classify_fct) rbce_tc_classify,
+	.class_delete = rbce_class_deletecb,
+	.n_interest = (1 << CKRM_EVENT_MANUAL),
+	.notify = (ce_notify_fct) rbce_tc_notify,
+	.always_callback = 0,
+};
+
+/*============================================================================
+ *    ACCEPTQ CLASSTYPE
+ *============================================================================*/
+
+int sc_classtype = -1;
+
+static void *rbce_sc_classify(enum ckrm_event event, ...)
+{
+	/* no special consideratation */
+	void *result;
+	va_list args;
+	struct task_struct *tsk;
+	struct ckrm_net_struct *ns;
+
+	va_start(args, event);
+	ns = va_arg(args, struct ckrm_net_struct *);
+	tsk = va_arg(args, struct task_struct *);
+	va_end(args);
+
+	result = rbce_classify(tsk, ns, RBCE_TERMFLAG_ALL, sc_classtype);
+
+	return result;
+}
+
+static struct ckrm_eng_callback rbce_acceptQclass_ecbs = {
+	.c_interest = (unsigned long)(-1),
+	.always_callback = 0,	/* enable during debugging only */
+	.classify = (ce_classify_fct) & rbce_sc_classify,
+	.class_delete = rbce_class_deletecb,
+};
+
+/*============================================================================
+ *    Module Initialization ...
+ *============================================================================*/
+
+#define TASKCLASS_NAME  "taskclass"
+#define SOCKCLASS_NAME  "socket_class"
+
+struct ce_regtable_struct {
+	const char *name;
+	struct ckrm_eng_callback *cbs;
+	int *clsvar;
+};
+
+struct ce_regtable_struct ce_regtable[] = {
+	{TASKCLASS_NAME, &rbce_taskclass_ecbs, &tc_classtype},
+	{SOCKCLASS_NAME, &rbce_acceptQclass_ecbs, &sc_classtype},
+	{NULL}
+};
+
+void unregister_classtype_engines(void)
+{
+	int rc;
+	struct ce_regtable_struct *ceptr = ce_regtable;
+
+	while (ceptr->name) {
+		if (*ceptr->clsvar >= 0) {
+			while ((rc = ckrm_unregister_engine(ceptr->name)) == -EAGAIN)
+				;
+			*ceptr->clsvar = -1;
+		}
+		ceptr++;
+	}
+}
+
+int register_classtype_engines(void)
+{
+	int rc;
+	struct ce_regtable_struct *ceptr = ce_regtable;
+
+	while (ceptr->name) {
+		rc = ckrm_register_engine(ceptr->name, ceptr->cbs);
+		if ((rc < 0) && (rc != -ENOENT)) {
+			unregister_classtype_engines();
+			return (rc);
+		}
+		if (rc != -ENOENT)
+			*ceptr->clsvar = rc;
+		ceptr++;
+	}
+	return 0;
+}
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 13:08:45.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 13:08:46.000000000 -0700
@@ -41,6 +41,8 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
+#include "rbce_bitvector.h"
+
 /*
  * comman data structure used for identification of class and rules
  * in the RBCE namespace
@@ -205,14 +207,25 @@ struct rbce_private_data {
 	bitvector_t *eval;
 	bitvector_t *true;
 	char *app_tag;
+	unsigned long bitmap_version;
   	char data[0];		/* bitvectors eval and true */
 };
 
 #define RBCE_DATA(tsk) ((struct rbce_private_data*)((tsk)->ce_data))
 #define RBCE_DATAP(tsk) ((tsk)->ce_data)
 
+/* Other rbce global stuff. */
+
 extern struct rbce_eng_callback rbce_rcfs_ecbs;
 extern int rbce_enabled;
+extern struct list_head rules_list[];
+extern const int use_persistent_state;
+extern int gl_num_rules;
+extern int gl_bitmap_version;
+extern int gl_allocated;
+extern struct rbce_rule_term *gl_terms;
+extern int gl_rules_version;
+extern rwlock_t rbce_rwlock;
 
 extern int rbce_mkdir(struct inode *, struct dentry *, int);
 extern int rbce_rmdir(struct inode *, struct dentry *);
@@ -228,4 +241,14 @@ extern int rbce_rename_rule(const char *
 
 extern int rules_parse(char *, struct rbce_rule_term **, int *);
 
+extern struct rbce_private_data *create_private_data(struct rbce_private_data
+						     *, int);
+extern bitvector_t *get_gl_mask_vecs(int);
+extern struct rbce_class *find_class_name(const char *);
+extern void put_class(struct rbce_class *);
+extern void free_all_private_data(void);
+
+extern void unregister_classtype_engines(void);
+extern int register_classtype_engines(void);
+
 #endif /* _RBCE_INTERNAL_H */
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_main.c	2005-06-20 13:08:45.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c	2005-06-20 13:08:46.000000000 -0700
@@ -23,7 +23,6 @@
  */
 
 #include "rbce_internal.h"
-#include "rbce_bitvector.h"
 
 MODULE_DESCRIPTION(RBCE_MOD_DESCR);
 MODULE_AUTHOR("Hubertus Franke, Chandra Seetharaman (IBM)");
@@ -57,19 +56,20 @@ int termop_2_vecidx[RBCE_RULE_INVALID] =
 
 extern int errno;
 
-int rbce_enabled = 1;
-const int use_persistent_state = 1;
-
 static LIST_HEAD(class_list);
-static struct list_head rules_list[CKRM_MAX_CLASSTYPES];
-static int gl_num_rules;
+struct list_head rules_list[CKRM_MAX_CLASSTYPES];
 static int gl_action, gl_num_terms;
-static int gl_bitmap_version, gl_action, gl_num_terms;
-static int gl_allocated, gl_released;
-static struct rbce_rule_term *gl_terms;
-static int gl_rules_version;
+static int gl_released;
 static bitvector_t *gl_mask_vecs[NUM_TERM_MASK_VECTOR];
-static rwlock_t rbce_rwlock = RW_LOCK_UNLOCKED;
+
+int rbce_enabled = 1;
+const int use_persistent_state = 1;
+int gl_num_rules;
+int gl_bitmap_version;
+int gl_allocated;
+struct rbce_rule_term *gl_terms;
+int gl_rules_version;
+rwlock_t rbce_rwlock = RW_LOCK_UNLOCKED;
 	/*
 	 * One lock to protect them all !!!
 	 * Additions, deletions to rules must
@@ -84,6 +84,12 @@ static rwlock_t rbce_rwlock = RW_LOCK_UN
 
 static void optimize_policy(void);
 
+bitvector_t *
+get_gl_mask_vecs(int index)
+{
+	return gl_mask_vecs[index];
+}
+
 static inline struct rbce_rule *find_rule_name(const char *name)
 {
 	struct named_obj_hdr *pos;
@@ -353,7 +359,7 @@ static inline int __delete_rule(struct r
 /*
  * Optimize the rule evaluation logic
  *
- * Caller must hold global_rwlock in write mode.
+ * Caller must hold rbce_rwlock in write mode.
  */
 static void optimize_policy(void)
 {
@@ -1127,12 +1133,6 @@ int rbce_rule_exists(const char *rname)
 }
 
 /*====================== Magic file handling =======================*/
-struct rbce_private_data *create_private_data(struct rbce_private_data *a,
-						     int b)
-{
-	return NULL;
-}
-
 static inline
 void reset_evaluation(struct rbce_private_data *pdata,int termflag)
 {
@@ -1197,15 +1197,25 @@ out:
 
 int init_rbce(void)
 {
-	int rc, line;
+	int rc, i, line;
 
 	printk(KERN_INFO "Installing \'%s\' module\n", modname);
 
-	rc = rcfs_register_engine(&rbce_rcfs_ecbs);
+	for (i = 0; i < CKRM_MAX_CLASSTYPES; i++) {
+		INIT_LIST_HEAD(&rules_list[i]);
+	}
+
+	rc = register_classtype_engines();
 	line = __LINE__;
 	if (rc)
 		goto out;
 
+	/* register any other class type engine here */
+  	rc = rcfs_register_engine(&rbce_rcfs_ecbs);
+  	line = __LINE__;
+  	if (rc)
+		goto out_unreg_classtype;;
+
 	if (rcfs_mounted) {
 		rc = rbce_create_config();
 		line = __LINE__;
@@ -1214,6 +1224,8 @@ int init_rbce(void)
 	}
 
 	rcfs_unregister_engine(&rbce_rcfs_ecbs);
+out_unreg_classtype:
+ 	unregister_classtype_engines();
 out:
 	printk(KERN_ERR "%s: error installing rc=%d line=%d\n",
 		__FUNCTION__, rc, line);
@@ -1222,12 +1234,27 @@ out:
 
 void exit_rbce(void)
 {
+	int i;
 	printk(KERN_INFO "Removing \'%s\' module\n", modname);
 
+	/* Print warnings if lists are not empty, which is a bug */
+	if (!list_empty(&class_list)) {
+		printk(KERN_WARNING "exit_rbce: Class list is not empty\n");
+	}
+
+	for (i = 0; i < CKRM_MAX_CLASSTYPES; i++) {
+		if (!list_empty(&rules_list[i])) {
+			printk(KERN_WARNING "exit_rbce: Rules list for "
+				"classtype %d is not empty\n", i);
+		}
+	}
+
 	if (rcfs_mounted)
 		rbce_clear_config();
 
 	rcfs_unregister_engine(&rbce_rcfs_ecbs);
+	unregister_classtype_engines();
+	free_all_private_data();
 }
 
 module_init(init_rbce);

--

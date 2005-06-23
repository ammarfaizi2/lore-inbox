Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVFWIIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVFWIIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVFWID3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:03:29 -0400
Received: from [24.22.56.4] ([24.22.56.4]:13030 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262261AbVFWGSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:42 -0400
Message-Id: <20050623061801.058073000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:26 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 34/38] CKRM e18: Fix compile warnings and delete dead code
Content-Disposition: inline; filename=ckrm-fix_compile_warnings_del_dead_code-modified
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compile warnings. Delete dead code.

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

---------------------------------------------------------------------

Index: linux-2.6.12-ckrm1/include/linux/ckrm_ce.h
===================================================================
--- linux-2.6.12-ckrm1.orig/include/linux/ckrm_ce.h	2005-06-20 13:08:29.000000000 -0700
+++ linux-2.6.12-ckrm1/include/linux/ckrm_ce.h	2005-06-20 15:59:12.000000000 -0700
@@ -78,7 +78,7 @@ struct rbce_eng_callback {
 extern int ckrm_register_engine(const char *name, struct ckrm_eng_callback *);
 extern int ckrm_unregister_engine(const char *name);
 
-extern void *ckrm_classobj(char *, int *classtype);
+extern void *ckrm_classobj(const char * classname, int *classtype);
 
 extern int rcfs_register_engine(struct rbce_eng_callback *);
 extern int rcfs_unregister_engine(struct rbce_eng_callback *);
Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm.c	2005-06-20 15:04:54.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm.c	2005-06-20 15:59:12.000000000 -0700
@@ -65,7 +65,7 @@ inline unsigned int ckrm_is_res_regd(str
 /*
  * Return non-zero if the given core class pointer is valid.
  */
-struct ckrm_res_ctlr *ckrm_resctlr_lookup(struct ckrm_classtype *clstype,
+static struct ckrm_res_ctlr *ckrm_resctlr_lookup(struct ckrm_classtype *clstype,
 					  const char *resname)
 {
 	int resid = -1;
@@ -83,10 +83,9 @@ struct ckrm_res_ctlr *ckrm_resctlr_looku
 	return NULL;
 }
 
-EXPORT_SYMBOL_GPL(ckrm_resctlr_lookup);
 
 /* given a classname return the class handle and its classtype*/
-void *ckrm_classobj(char *classname, int *classtype_id)
+void *ckrm_classobj(const char *classname, int *classtype_id)
 {
 	int i;
 
Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm_numtasks.c	2005-06-20 15:04:51.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c	2005-06-20 15:59:12.000000000 -0700
@@ -501,7 +501,7 @@ static int numtasks_set_config(void *my_
 	if (!res)
 		return -EINVAL;
 
-	while ((p = strsep(&cfgstr, ",")) != NULL) {
+	while ((p = strsep((char**)&cfgstr, ",")) != NULL) {
 		substring_t args[MAX_OPT_ARGS];
 		int token;
 		if (!*p)
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_main.c	2005-06-20 15:04:53.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c	2005-06-20 15:59:12.000000000 -0700
@@ -211,7 +211,7 @@ struct rbce_class *create_rbce_class(con
 	return cls;
 }
 
-struct rbce_class *get_class(char *classname, int *classtype)
+struct rbce_class *get_class(const char *classname, int *classtype)
 {
 	struct rbce_class *cls;
 	void *classobj;
Index: linux-2.6.12-ckrm1/include/linux/ckrm_rc.h
===================================================================
--- linux-2.6.12-ckrm1.orig/include/linux/ckrm_rc.h	2005-06-20 13:08:29.000000000 -0700
+++ linux-2.6.12-ckrm1/include/linux/ckrm_rc.h	2005-06-20 16:00:36.000000000 -0700
@@ -227,11 +227,6 @@ extern int ckrm_init_core_class(struct c
 				const char *name);
 extern int ckrm_release_core_class(struct ckrm_core_class *);
 
-/* TODO: can disappear after cls del debugging */
-
-extern struct ckrm_res_ctlr *ckrm_resctlr_lookup(struct ckrm_classtype *type,
-						 const char *resname);
-
 extern void ckrm_lock_hier(struct ckrm_core_class *);
 extern void ckrm_unlock_hier(struct ckrm_core_class *);
 extern struct ckrm_core_class *ckrm_get_next_child(struct ckrm_core_class *,
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 15:04:53.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 15:59:12.000000000 -0700
@@ -247,7 +247,7 @@ extern struct rbce_private_data *create_
 						     *, int);
 extern bitvector_t *get_gl_mask_vecs(int);
 extern struct rbce_class *find_class_name(const char *);
-extern struct rbce_class *get_class(char *classname, int *classtype);
+extern struct rbce_class *get_class(const char *classname, int *classtype);
 extern void put_class(struct rbce_class *);
 extern void free_all_private_data(void);
 

--

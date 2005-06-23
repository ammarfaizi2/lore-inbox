Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVFWH6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVFWH6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVFWHyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:54:31 -0400
Received: from [24.22.56.4] ([24.22.56.4]:8934 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262247AbVFWGSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:40 -0400
Message-Id: <20050623061759.729406000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:19 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 27/38] CKRM e18: make get_class global
Content-Disposition: inline; filename=ckrm-rbce-rmclass
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE:  function names need to be changed - probably add ckrm_

Make get_class() function visible outside its compilation unit. Use
get_class() when find_class_name() might have returned NULL and we'd
like to create a new class instead of deal with NULL.

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

---------------------------------------------------------------------

Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_core.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_core.c	2005-06-20 15:02:49.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_core.c	2005-06-20 15:04:53.000000000 -0700
@@ -29,13 +29,11 @@ static void rbce_class_addcb(const char 
 	struct rbce_class *cls;
 
 	write_lock(&rbce_rwlock);
-	cls = find_class_name((char *)classname);
-	if (cls)
+ 	cls = get_class(classname, &classtype);
+	if (cls) {
 		cls->classobj = clsobj;
-	else
-		cls = create_rbce_class(classname, classtype, clsobj);
-	if (cls)
 		notify_class_action(cls, 1);
+	}
 	write_unlock(&rbce_rwlock);
 	return;
 }
@@ -57,6 +55,9 @@ rbce_class_deletecb(const char *classnam
 			printk(KERN_ERR "rbce: class %s changed identity\n",
 			       classname);
 		}
+#ifdef CRBCE_EXTENSION
+		put_class(cls);
+#endif
 		notify_class_action(cls, 0);
 		cls->classobj = NULL;
 		list_for_each_entry(pos, &rules_list[cls->classtype], link) {
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_main.c	2005-06-20 15:04:48.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c	2005-06-20 15:04:53.000000000 -0700
@@ -211,7 +211,7 @@ struct rbce_class *create_rbce_class(con
 	return cls;
 }
 
-static struct rbce_class *get_class(char *classname, int *classtype)
+struct rbce_class *get_class(char *classname, int *classtype)
 {
 	struct rbce_class *cls;
 	void *classobj;
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 15:02:49.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 15:04:53.000000000 -0700
@@ -247,6 +247,7 @@ extern struct rbce_private_data *create_
 						     *, int);
 extern bitvector_t *get_gl_mask_vecs(int);
 extern struct rbce_class *find_class_name(const char *);
+extern struct rbce_class *get_class(char *classname, int *classtype);
 extern void put_class(struct rbce_class *);
 extern void free_all_private_data(void);
 

--

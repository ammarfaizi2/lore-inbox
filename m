Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVFWGmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVFWGmW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVFWGij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:38:39 -0400
Received: from [24.22.56.4] ([24.22.56.4]:16102 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262288AbVFWGSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:45 -0400
Message-Id: <20050623061758.871467000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:15 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 23/38] CKRM e18: Fix edge cases with empty lists and rule deletion
Content-Disposition: inline; filename=rbce_modcount_incorrect
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix rule re-insertion to be more careful with empty lists.
Fix rule deletion to not delete rules that are still in a list.

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_main.c	2005-06-20 15:04:28.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c	2005-06-20 15:04:48.000000000 -0700
@@ -162,8 +162,8 @@ static int insert_rule(struct rbce_rule 
 			}
 		}
 	}
-	if (type == REINSERT)
-		list_del(&rule->obj.link);
+	if ((type == REINSERT) && !list_empty(&rule->obj.link))
+		list_del_init(&rule->obj.link);
 	else {
 		/*  protect the module from removed if a rule exists */
 		try_module_get(THIS_MODULE);
@@ -340,12 +340,14 @@ static void __release_rule(struct rbce_r
 static inline int __delete_rule(struct rbce_rule *rule)
 {
 	/* make sure we are not referenced by other rules */
+	if (list_empty(&rule->obj.link))
+		return 0;
 	if (GET_REF(rule))
 		return -EBUSY;
 	__release_rule(rule);
 	put_class(rule->target_class);
 	release_term_index(rule->index);
-	list_del(&rule->obj.link);
+	list_del_init(&rule->obj.link);
 	gl_num_rules--;
 	gl_rules_version++;
 	module_put(THIS_MODULE);

--

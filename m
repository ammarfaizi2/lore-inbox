Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVHEF3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVHEF3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 01:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVHEF3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 01:29:49 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11408 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262859AbVHEF3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 01:29:48 -0400
Subject: [PATCH] kernel: use kcalloc instead kmalloc/memset
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Date: Fri, 05 Aug 2005 08:29:07 +0300
Message-Id: <1123219747.20398.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts kernel/ to use kcalloc instead of kmalloc/memset.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 intermodule.c |    3 +--
 params.c      |    4 ++--
 power/pm.c    |    3 +--
 resource.c    |    3 +--
 workqueue.c   |    3 +--
 5 files changed, 6 insertions(+), 10 deletions(-)

Index: 2.6/kernel/resource.c
===================================================================
--- 2.6.orig/kernel/resource.c
+++ 2.6/kernel/resource.c
@@ -430,10 +430,9 @@ EXPORT_SYMBOL(adjust_resource);
  */
 struct resource * __request_region(struct resource *parent, unsigned long start, unsigned long n, const char *name)
 {
-	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
+	struct resource *res = kcalloc(1, sizeof(*res), GFP_KERNEL);
 
 	if (res) {
-		memset(res, 0, sizeof(*res));
 		res->name = name;
 		res->start = start;
 		res->end = start + n - 1;
Index: 2.6/kernel/intermodule.c
===================================================================
--- 2.6.orig/kernel/intermodule.c
+++ 2.6/kernel/intermodule.c
@@ -39,7 +39,7 @@ void inter_module_register(const char *i
 	struct list_head *tmp;
 	struct inter_module_entry *ime, *ime_new;
 
-	if (!(ime_new = kmalloc(sizeof(*ime), GFP_KERNEL))) {
+	if (!(ime_new = kcalloc(1, sizeof(*ime), GFP_KERNEL))) {
 		/* Overloaded kernel, not fatal */
 		printk(KERN_ERR
 			"Aiee, inter_module_register: cannot kmalloc entry for '%s'\n",
@@ -47,7 +47,6 @@ void inter_module_register(const char *i
 		kmalloc_failed = 1;
 		return;
 	}
-	memset(ime_new, 0, sizeof(*ime_new));
 	ime_new->im_name = im_name;
 	ime_new->owner = owner;
 	ime_new->userdata = userdata;
Index: 2.6/kernel/params.c
===================================================================
--- 2.6.orig/kernel/params.c
+++ 2.6/kernel/params.c
@@ -542,8 +542,8 @@ static void __init kernel_param_sysfs_se
 {
 	struct module_kobject *mk;
 
-	mk = kmalloc(sizeof(struct module_kobject), GFP_KERNEL);
-	memset(mk, 0, sizeof(struct module_kobject));
+	mk = kcalloc(1, sizeof(struct module_kobject), GFP_KERNEL);
+	BUG_ON(!mk);
 
 	mk->mod = THIS_MODULE;
 	kobj_set_kset_s(mk, module_subsys);
Index: 2.6/kernel/power/pm.c
===================================================================
--- 2.6.orig/kernel/power/pm.c
+++ 2.6/kernel/power/pm.c
@@ -60,9 +60,8 @@ struct pm_dev *pm_register(pm_dev_t type
 			   unsigned long id,
 			   pm_callback callback)
 {
-	struct pm_dev *dev = kmalloc(sizeof(struct pm_dev), GFP_KERNEL);
+	struct pm_dev *dev = kcalloc(1, sizeof(struct pm_dev), GFP_KERNEL);
 	if (dev) {
-		memset(dev, 0, sizeof(*dev));
 		dev->type = type;
 		dev->id = id;
 		dev->callback = callback;
Index: 2.6/kernel/workqueue.c
===================================================================
--- 2.6.orig/kernel/workqueue.c
+++ 2.6/kernel/workqueue.c
@@ -310,10 +310,9 @@ struct workqueue_struct *__create_workqu
 
 	BUG_ON(strlen(name) > 10);
 
-	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
+	wq = kcalloc(1, sizeof(*wq), GFP_KERNEL);
 	if (!wq)
 		return NULL;
-	memset(wq, 0, sizeof(*wq));
 
 	wq->name = name;
 	/* We don't need the distraction of CPUs appearing and vanishing. */



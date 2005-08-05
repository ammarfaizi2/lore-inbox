Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVHEGw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVHEGw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVHEGw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:52:57 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:15512 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262888AbVHEGwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:52:36 -0400
Date: Fri, 5 Aug 2005 09:52:32 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
In-Reply-To: <20050804233634.1406e92a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0508050946070.27679@sbz-30.cs.Helsinki.FI>
References: <1123219747.20398.1.camel@localhost> <20050804223842.2b3abeee.akpm@osdl.org>
 <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
 <20050804233634.1406e92a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005, Andrew Morton wrote:
> That'll generate just as much code as simply using kcalloc(1, ...).  This
> function should be out-of-line and EXPORT_SYMBOL()ed.  And kcalloc() can
> call it too..

Yes, much better now. Thanks Andrew.

				Pekka

[PATCH] introduce kzalloc

This patch introduces a kzalloc wrapper and converts kernel/ to use it.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/linux/slab.h |    1 +
 kernel/intermodule.c |    3 +--
 kernel/params.c      |    4 ++--
 kernel/power/pm.c    |    3 +--
 kernel/resource.c    |    3 +--
 kernel/workqueue.c   |    3 +--
 mm/slab.c            |   19 +++++++++++++++----
 7 files changed, 22 insertions(+), 14 deletions(-)

Index: 2.6/kernel/resource.c
===================================================================
--- 2.6.orig/kernel/resource.c
+++ 2.6/kernel/resource.c
@@ -430,10 +430,9 @@ EXPORT_SYMBOL(adjust_resource);
  */
 struct resource * __request_region(struct resource *parent, unsigned long start, unsigned long n, const char *name)
 {
-	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
+	struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
 
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
+	if (!(ime_new = kzalloc(sizeof(*ime), GFP_KERNEL))) {
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
+	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
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
+	struct pm_dev *dev = kzalloc(sizeof(struct pm_dev), GFP_KERNEL);
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
+	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
 	if (!wq)
 		return NULL;
-	memset(wq, 0, sizeof(*wq));
 
 	wq->name = name;
 	/* We don't need the distraction of CPUs appearing and vanishing. */
Index: 2.6/include/linux/slab.h
===================================================================
--- 2.6.orig/include/linux/slab.h
+++ 2.6/include/linux/slab.h
@@ -100,6 +100,7 @@ found:
 }
 
 extern void *kcalloc(size_t, size_t, unsigned int __nocast);
+extern void *kzalloc(size_t, unsigned int __nocast);
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -2555,6 +2555,20 @@ void kmem_cache_free(kmem_cache_t *cache
 EXPORT_SYMBOL(kmem_cache_free);
 
 /**
+ * kzalloc - allocate memory. The memory is set to zero.
+ * @size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate.
+ */
+void *kzalloc(size_t size, unsigned int __nocast flags)
+{
+	void *ret = kmalloc(size, flags);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
+}
+EXPORT_SYMBOL(kzalloc);
+
+/**
  * kcalloc - allocate memory for an array. The memory is set to zero.
  * @n: number of elements.
  * @size: element size.
@@ -2567,10 +2581,7 @@ void *kcalloc(size_t n, size_t size, uns
 	if (n != 0 && size > INT_MAX / n)
 		return ret;
 
-	ret = kmalloc(n * size, flags);
-	if (ret)
-		memset(ret, 0, n * size);
-	return ret;
+	return kzalloc(n * size, flags);
 }
 EXPORT_SYMBOL(kcalloc);
 

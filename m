Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVHEGa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVHEGa2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVHEGa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:30:28 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:44437 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262868AbVHEGaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:30:25 -0400
Date: Fri, 5 Aug 2005 09:30:12 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
In-Reply-To: <20050804223842.2b3abeee.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
References: <1123219747.20398.1.camel@localhost> <20050804223842.2b3abeee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > This patch converts kernel/ to use kcalloc instead of kmalloc/memset.

On Thu, 4 Aug 2005, Andrew Morton wrote:
> grr.

I am learning grep. Please don't eat me!

> >  -	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
> >  +	struct resource *res = kcalloc(1, sizeof(*res), GFP_KERNEL);
> 
> Notice how every conversion you did passes in `1' in the first argument?
> 
> And that's going to happen again and again and again.  Each callsite
> needlessly passing that silly third argument, adding more kernel text.
> 
> If we're going to do this, we should add a two-arg helper function first,
> and use that, no?

This was discussed some time ago [1] and here's a patch for you to do 
that.

		Pekka

  1. http://marc.theaimsgroup.com/?l=linux-kernel&m=111279001428661&w=2

[PATCH] use kzalloc instead of kmalloc/memset

This patch introduces a kzalloc wrapper and converts kernel/ to use it.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/linux/slab.h |    5 +++++
 kernel/intermodule.c |    3 +--
 kernel/params.c      |    4 ++--
 kernel/power/pm.c    |    3 +--
 kernel/resource.c    |    3 +--
 kernel/workqueue.c   |    3 +--
 6 files changed, 11 insertions(+), 10 deletions(-)

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
@@ -103,6 +103,11 @@ extern void *kcalloc(size_t, size_t, uns
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
+static inline void *kzalloc(size_t size, unsigned int __nocast flags)
+{
+	return kcalloc(1, size, flags);
+}
+
 #ifdef CONFIG_NUMA
 extern void *kmem_cache_alloc_node(kmem_cache_t *, int flags, int node);
 extern void *kmalloc_node(size_t size, unsigned int __nocast flags, int node);

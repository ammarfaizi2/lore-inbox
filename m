Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVAPRRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVAPRRc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 12:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbVAPRRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 12:17:32 -0500
Received: from news.suse.de ([195.135.220.2]:63947 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262546AbVAPRRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 12:17:20 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: slab.c use of __get_user and sparse
Date: Sat, 15 Jan 2005 10:22:00 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050115213906.GA22486@mars.ravnborg.org> <20050115220151.GA16442@wotan.suse.de>
In-Reply-To: <20050115220151.GA16442@wotan.suse.de>
MIME-Version: 1.0
X-Length: 4140
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4CO6ByB0fJxpr5D"
Message-Id: <200501151022.00543.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_4CO6ByB0fJxpr5D
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 15 January 2005 23:01, Andi Kleen wrote:
> > Based on the comment it is understood that suddenly this pointer points
> > to userspace, because the module got unloaded.
> > I wonder why we can rely on the same address now the module got unloaded
> > - we may risk this virtual address is taken over by someone else?
>
> The address is not user space; you would be lying.
>
> Perhaps it's best to get rid of the hack completely. Turn
> kmem_cache_t->name into an array and copy the name instead of storing the
> pointer, then it wouldn't be needed at all.

Those are just bugs from the time before there was kmem_cache_destroy. I 
checked the 2.6.11-rc1-mm1 tree: every kmem_cache_create in modules seems to 
destroyed properly except in decnet, and decnet module unloading currently is 
disabled. The attached patch fixes the decnet case, puts the slab name in a 
static array, and removes the name accessibilty check.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

--Boundary-00=_4CO6ByB0fJxpr5D
Content-Type: text/plain;
  charset="iso-8859-1";
  name="slab-destroy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="slab-destroy.diff"

From: Andreas Gruenbacher <agruen@suse.de>
Subject: Missing kmem_cache_destroy()s in decnet; remove dead-slab check

Decnet is not destroying two of the slabs it creates. Put slab names into
struct kmem_cache_s, and remove the name accessibility hack.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc1-mm1/net/decnet/dn_table.c
===================================================================
--- linux-2.6.11-rc1-mm1.orig/net/decnet/dn_table.c
+++ linux-2.6.11-rc1-mm1/net/decnet/dn_table.c
@@ -820,6 +820,7 @@ void __exit dn_fib_table_cleanup(void)
 
 	for (i = RT_TABLE_MIN; i <= RT_TABLE_MAX; ++i)
 		dn_fib_del_tree(i);
+	kmem_cache_destroy(dn_hash_kmem);
 
 	return;
 }
Index: linux-2.6.11-rc1-mm1/net/decnet/dn_route.c
===================================================================
--- linux-2.6.11-rc1-mm1.orig/net/decnet/dn_route.c
+++ linux-2.6.11-rc1-mm1/net/decnet/dn_route.c
@@ -1835,6 +1835,7 @@ void __exit dn_route_cleanup(void)
 {
 	del_timer(&dn_route_timer);
 	dn_run_flush(0);
+	kmem_cache_destroy(dn_dst_ops.kmem_cachep);
 
 	proc_net_remove("decnet_cache");
 }
Index: linux-2.6.11-rc1-mm1/mm/slab.c
===================================================================
--- linux-2.6.11-rc1-mm1.orig/mm/slab.c
+++ linux-2.6.11-rc1-mm1/mm/slab.c
@@ -334,7 +334,7 @@ struct kmem_cache_s {
 	void (*dtor)(void *, kmem_cache_t *, unsigned long);
 
 /* 4) cache creation/removal */
-	const char		*name;
+	char			name[32];
 	struct list_head	next;
 
 /* 5) statistics */
@@ -1419,7 +1419,7 @@ next:
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
 	cachep->ctor = ctor;
 	cachep->dtor = dtor;
-	cachep->name = name;
+	strlcpy(cachep->name, name, sizeof(cachep->name));
 
 	/* Don't let CPUs to come and go */
 	lock_cpu_hotplug();
@@ -1465,15 +1465,6 @@ next:
 		set_fs(KERNEL_DS);
 		list_for_each(p, &cache_chain) {
 			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
-			char tmp;
-			/* This happens when the module gets unloaded and doesn't
-			   destroy its slab cache and noone else reuses the vmalloc
-			   area of the module. Print a warning. */
-			if (__get_user(tmp,pc->name)) { 
-				printk("SLAB: cache with size %d has lost its name\n", 
-					pc->objsize); 
-				continue; 
-			} 	
 			if (!strcmp(pc->name,name)) { 
 				printk("kmem_cache_create: duplicate cache %s\n",name); 
 				up(&cache_chain_sem); 

--Boundary-00=_4CO6ByB0fJxpr5D--

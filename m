Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVJ1EyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVJ1EyM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 00:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVJ1EyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 00:54:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965093AbVJ1EyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 00:54:10 -0400
Date: Thu, 27 Oct 2005 21:53:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Davi Arnaut <davi.lkml@gmail.com>
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: kernel BUG at mm/slab.c:1488! (2.6.13.2)
Message-Id: <20051027215312.57303595.akpm@osdl.org>
In-Reply-To: <750c918d0510272032k79211b44vee825864d0f26438@mail.gmail.com>
References: <750c918d0510272032k79211b44vee825864d0f26438@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davi Arnaut <davi.lkml@gmail.com> wrote:
>
>  > It seems that something still tries to load the ext3 module, and I get the
>  > BUG seen below.  If I remove the ext3 module and re-build the initrd,
>  > the error goes away.

Yes, I think the kernel is overreacting here.

Manfred, what sayest thou?

(nb: untested)


From: Andrew Morton <akpm@osdl.org>

slab presently goes BUG if someone tries to register an already-registered
cache.

But this can happen if the user accidentally loads a module which is already
statically linked into the kernel.  Nuking the kernel is rather a harsh
reaction.

Change it into a warning, and just fail the kmem_cache_alloc() attempt.  If
the module is well-behaved, the modprobe will fail and all is well.

Notes:

- Swaps the ranking of cache_chain_sem and lock_cpu_hotplug().  Doesn't seem
  important.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/slab.c |   67 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 34 insertions(+), 33 deletions(-)

diff -puN mm/slab.c~slab-dont-bug-on-duplicated-cache mm/slab.c
--- devel/mm/slab.c~slab-dont-bug-on-duplicated-cache	2005-10-27 21:51:40.000000000 -0700
+++ devel-akpm/mm/slab.c	2005-10-27 21:51:40.000000000 -0700
@@ -1505,6 +1505,7 @@ kmem_cache_create (const char *name, siz
 {
 	size_t left_over, slab_size, ralign;
 	kmem_cache_t *cachep = NULL;
+	struct list_head *p;
 
 	/*
 	 * Sanity checks... these are all serious usage bugs.
@@ -1519,6 +1520,35 @@ kmem_cache_create (const char *name, siz
 			BUG();
 		}
 
+	down(&cache_chain_sem);
+
+	list_for_each(p, &cache_chain) {
+		kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
+		mm_segment_t old_fs = get_fs();
+		char tmp;
+		int res;
+
+		/*
+		 * This happens when the module gets unloaded and doesn't
+		 * destroy its slab cache and no-one else reuses the vmalloc
+		 * area of the module.  Print a warning.
+		 */
+		set_fs(KERNEL_DS);
+		res = __get_user(tmp, pc->name);
+		set_fs(old_fs);
+		if (res) {
+			printk("SLAB: cache with size %d has lost its name\n",
+					pc->objsize);
+			continue;
+		}
+
+		if (!strcmp(pc->name,name)) {
+			printk("kmem_cache_create: duplicate cache %s\n", name);
+			dump_stack();
+			goto oops;
+		}
+	}
+
 #if DEBUG
 	WARN_ON(strchr(name, ' '));	/* It confuses parsers */
 	if ((flags & SLAB_DEBUG_INITIAL) && !ctor) {
@@ -1595,7 +1625,7 @@ kmem_cache_create (const char *name, siz
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
 	if (!cachep)
-		goto opps;
+		goto oops;
 	memset(cachep, 0, sizeof(kmem_cache_t));
 
 #if DEBUG
@@ -1689,7 +1719,7 @@ next:
 		printk("kmem_cache_create: couldn't create cache %s.\n", name);
 		kmem_cache_free(&cache_cache, cachep);
 		cachep = NULL;
-		goto opps;
+		goto oops;
 	}
 	slab_size = ALIGN(cachep->num*sizeof(kmem_bufctl_t)
 				+ sizeof(struct slab), align);
@@ -1784,43 +1814,14 @@ next:
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
 	} 
 
-	/* Need the semaphore to access the chain. */
-	down(&cache_chain_sem);
-	{
-		struct list_head *p;
-		mm_segment_t old_fs;
-
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		list_for_each(p, &cache_chain) {
-			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
-			char tmp;
-			/* This happens when the module gets unloaded and doesn't
-			   destroy its slab cache and noone else reuses the vmalloc
-			   area of the module. Print a warning. */
-			if (__get_user(tmp,pc->name)) { 
-				printk("SLAB: cache with size %d has lost its name\n", 
-					pc->objsize); 
-				continue; 
-			} 	
-			if (!strcmp(pc->name,name)) { 
-				printk("kmem_cache_create: duplicate cache %s\n",name); 
-				up(&cache_chain_sem); 
-				unlock_cpu_hotplug();
-				BUG(); 
-			}	
-		}
-		set_fs(old_fs);
-	}
-
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
-	up(&cache_chain_sem);
 	unlock_cpu_hotplug();
-opps:
+oops:
 	if (!cachep && (flags & SLAB_PANIC))
 		panic("kmem_cache_create(): failed to create slab `%s'\n",
 			name);
+	up(&cache_chain_sem);
 	return cachep;
 }
 EXPORT_SYMBOL(kmem_cache_create);
_


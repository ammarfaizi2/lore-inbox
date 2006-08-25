Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWHYVVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWHYVVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWHYVVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 17:21:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:23483 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751447AbWHYVVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 17:21:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=hbxRxdR0HryIjbTqLVXb0LD+UlQFC762KUTM5dWgY4I4oMDLPmvTpz31hS8XZWC173DFv0q02zBtrwtCf/Kxhv8SXSyd61JW6tTJheQDV7Jw4VS7cWNpH9X67zucQRh27qagksy3R+Tvk9W9ec26e9JeLmHrJiSenX4RcRl2ttc=
Date: Sat, 26 Aug 2006 01:21:10 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Make kmem_cache_destroy() return void
Message-ID: <20060825212110.GB2246@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

un-, de-, -free, -destroy, -exit, etc functions should in general
return void. Also,

There is very little, say, filesystem driver code can do upon failed
kmem_cache_destroy(). If it will be decided to BUG in this case, BUG
should be put in generic code, instead.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/slab.h |    4 ++--
 mm/slab.c            |    5 +----
 mm/slob.c            |    3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -60,7 +60,7 @@ extern void __init kmem_cache_init(void)
 extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsigned long,
 				       void (*)(void *, kmem_cache_t *, unsigned long),
 				       void (*)(void *, kmem_cache_t *, unsigned long));
-extern int kmem_cache_destroy(kmem_cache_t *);
+extern void kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, gfp_t);
 extern void *kmem_cache_zalloc(struct kmem_cache *, gfp_t);
@@ -228,7 +228,7 @@ struct kmem_cache *kmem_cache_create(con
 	unsigned long,
 	void (*)(void *, struct kmem_cache *, unsigned long),
 	void (*)(void *, struct kmem_cache *, unsigned long));
-int kmem_cache_destroy(struct kmem_cache *c);
+void kmem_cache_destroy(struct kmem_cache *c);
 void *kmem_cache_alloc(struct kmem_cache *c, gfp_t flags);
 void *kmem_cache_zalloc(struct kmem_cache *, gfp_t);
 void kmem_cache_free(struct kmem_cache *c, void *b);
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2375,7 +2375,6 @@ EXPORT_SYMBOL(kmem_cache_shrink);
  * @cachep: the cache to destroy
  *
  * Remove a struct kmem_cache object from the slab cache.
- * Returns 0 on success.
  *
  * It is expected this function will be called by a module when it is
  * unloaded.  This will remove the cache completely, and avoid a duplicate
@@ -2387,7 +2386,7 @@ EXPORT_SYMBOL(kmem_cache_shrink);
  * The caller must guarantee that noone will allocate memory from the cache
  * during the kmem_cache_destroy().
  */
-int kmem_cache_destroy(struct kmem_cache *cachep)
+void kmem_cache_destroy(struct kmem_cache *cachep)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2411,7 +2410,6 @@ int kmem_cache_destroy(struct kmem_cache
 		list_add(&cachep->next, &cache_chain);
 		mutex_unlock(&cache_chain_mutex);
 		unlock_cpu_hotplug();
-		return 1;
 	}
 
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU))
@@ -2431,7 +2429,6 @@ int kmem_cache_destroy(struct kmem_cache
 	}
 	kmem_cache_free(&cache_cache, cachep);
 	unlock_cpu_hotplug();
-	return 0;
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -270,10 +270,9 @@ struct kmem_cache *kmem_cache_create(con
 }
 EXPORT_SYMBOL(kmem_cache_create);
 
-int kmem_cache_destroy(struct kmem_cache *c)
+void kmem_cache_destroy(struct kmem_cache *c)
 {
 	slob_free(c, sizeof(struct kmem_cache));
-	return 0;
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 


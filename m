Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312253AbSDXVIL>; Wed, 24 Apr 2002 17:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312255AbSDXVIK>; Wed, 24 Apr 2002 17:08:10 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:46230 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S312253AbSDXVIJ>;
	Wed, 24 Apr 2002 17:08:09 -0400
Subject: [PATCH] (repost) kmem_cache_zalloc
From: Eric Sandeen <sandeen@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 24 Apr 2002 16:07:52 -0500
Message-Id: <1019682472.15455.33.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(reposting)

There was a brief thread on this patch a while ago, please see 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.3/0601.html

In short, XFS is using a kmem_cache_zalloc() function which just
does kmem_cache_alloc + memset.

We'd like to incorporate this into the kernel proper, and several others
chimed in that it would be useful, so here's the patch.  If it's a no-go
with Linus, we can roll this functionality back under fs/xfs to reduce
our changes in the mainline kernel.

Brian Gerst suggested adding a flag to the cache to tell
kmem_cache_zalloc() to zero the object, and this also sounds like a
reasonable way to go, but there was no discussion after that.

Thanks,

-Eric

--- linux-orig/include/linux/slab.h	Mon Mar 18 14:37:14 2002
+++ linux/include/linux/slab.h	Wed Apr  3 14:58:40 2002
@@ -56,6 +56,7 @@
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
+extern void *kmem_cache_zalloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 
 extern void *kmalloc(size_t, int);
--- linux-orig/mm/slab.c	Mon Mar 18 14:37:18 2002
+++ linux/mm/slab.c	Tue Apr  2 12:56:38 2002
@@ -1611,6 +1611,23 @@
 	local_irq_restore(flags);
 }
 
+void *
+kmem_cache_zalloc(kmem_cache_t *cachep, int flags)
+{
+	void    *ptr;
+	ptr = __kmem_cache_alloc(cachep, flags);
+	if (ptr)
+#if DEBUG
+		memset(ptr, 0, cachep->objsize -
+			(cachep->flags & SLAB_RED_ZONE ? 2*BYTES_PER_WORD : 0));
+#else
+		memset(ptr, 0, cachep->objsize);
+#endif
+
+	return ptr;
+}
+
+
 /**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
--- linux-orig/kernel/ksyms.c	Mon Mar 18 14:37:03 2002
+++ linux/kernel/ksyms.c	Tue Apr  2 12:56:38 2002
@@ -102,6 +115,7 @@
 EXPORT_SYMBOL(kmem_cache_destroy);
 EXPORT_SYMBOL(kmem_cache_shrink);
 EXPORT_SYMBOL(kmem_cache_alloc);
+EXPORT_SYMBOL(kmem_cache_zalloc);
 EXPORT_SYMBOL(kmem_cache_free);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
-- 
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.


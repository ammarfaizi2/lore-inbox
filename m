Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264253AbUEIC4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbUEIC4L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 22:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbUEIC4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 22:56:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:45755 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264253AbUEICz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 22:55:59 -0400
Date: Sat, 8 May 2004 19:55:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: dipankar@in.ibm.com, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: dentry bloat.
In-Reply-To: <20040508171027.6e469f70.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
References: <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org>
 <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org>
 <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org>
 <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
 <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com>
 <20040508135512.15f2bfec.akpm@osdl.org> <20040508211920.GD4007@in.ibm.com>
 <20040508171027.6e469f70.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 while we're discussing the other things, how about for now
just having this fairly minimal patch to get rid of the most egregious 
memory mis-use.

This removes the SLAB_HWCACHE_ALIGN and the cache line alignment on
"struct dentry", and to compensate for the fact that the inline name
length will shrink quite a bit it changes DNAME_INLINE_LEN_MIN from 16 to
24.

It also re-orders the first few fields of the dentry, since the "count"  
and "d_lock" should be 32-bit on most 64-bit architectures, so to avoid
having unnecessary unused space, we should just put them together
(everything else there is goign to be comprised of 64-bit entities, I
think).

So this should bring the size of a dentry down to 160 bytes on x86, from
either 192 of 256 bytes (depending on cacheline size). And 24 bytes of
inline name (it can be a bit more on some architectures, due to longword
alignment or similar) should still capture most of the dentries by far.

Let's see what Andrew's more complex patches can do to bring the size of 
"struct dentry" down further.

		Linus

--- 1.71/fs/dcache.c	Mon Apr 26 22:07:34 2004
+++ edited/fs/dcache.c	Sat May  8 17:41:30 2004
@@ -1558,14 +1558,11 @@
 	 * A constructor could be added for stable state like the lists,
 	 * but it is probably not worth it because of the cache nature
 	 * of the dcache. 
-	 * If fragmentation is too bad then the SLAB_HWCACHE_ALIGN
-	 * flag could be removed here, to hint to the allocator that
-	 * it should not try to get multiple page regions.  
 	 */
 	dentry_cache = kmem_cache_create("dentry_cache",
 					 sizeof(struct dentry),
 					 0,
-					 SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					 SLAB_RECLAIM_ACCOUNT,
 					 NULL, NULL);
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
===== include/linux/dcache.h 1.36 vs edited =====
--- 1.36/include/linux/dcache.h	Mon Jan 19 15:38:11 2004
+++ edited/include/linux/dcache.h	Sat May  8 19:39:47 2004
@@ -74,14 +74,14 @@
 	return end_name_hash(hash);
 }
 
-#define DNAME_INLINE_LEN_MIN 16
+#define DNAME_INLINE_LEN_MIN 24
 
 struct dcookie_struct;
  
 struct dentry {
 	atomic_t d_count;
-	unsigned long d_vfs_flags;	/* moved here to be on same cacheline */
 	spinlock_t d_lock;		/* per dentry lock */
+	unsigned long d_vfs_flags;	/* moved here to be on same cacheline */
 	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
 	struct list_head d_lru;		/* LRU list */
 	struct list_head d_child;	/* child of parent list */
@@ -102,7 +102,7 @@
 	struct hlist_node d_hash;	/* lookup hash list */	
 	struct hlist_head * d_bucket;	/* lookup hash bucket */
 	unsigned char d_iname[DNAME_INLINE_LEN_MIN]; /* small names */
-} ____cacheline_aligned;
+};
 
 #define DNAME_INLINE_LEN	(sizeof(struct dentry)-offsetof(struct dentry,d_iname))
  

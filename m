Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbVGOOhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbVGOOhG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbVGOOhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:37:06 -0400
Received: from cantor2.suse.de ([195.135.220.15]:31970 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263309AbVGOOgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:36:31 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE LINUX Products GMBH
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] mb_cache_shrink() frees unexpected caches
Date: Fri, 15 Jul 2005 16:36:27 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <1121346444.4282.8.camel@localhost.localdomain> <200507151249.52294.agruen@suse.de> <1121434894.1261.4.camel@localhost.localdomain>
In-Reply-To: <1121434894.1261.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507151636.27532.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 July 2005 15:41, Akinobu Mita wrote:
> > > --- 2.6-rc/fs/mbcache.c.orig	2005-07-14 20:40:34.000000000 +0900
> > > +++ 2.6-rc/fs/mbcache.c	2005-07-14 20:43:42.000000000 +0900
> > > @@ -329,7 +329,7 @@ mb_cache_shrink(struct mb_cache *cache,
> > >  	list_for_each_safe(l, ltmp, &mb_cache_lru_list) {
> > >  		struct mb_cache_entry *ce =
> > >  			list_entry(l, struct mb_cache_entry, e_lru_list);
> > > -		if (ce->e_bdev == bdev) {
> > > +		if (ce->e_cache == cache && ce->e_bdev == bdev) {
> > >  			list_move_tail(&ce->e_lru_list, &free_list);
> > >  			__mb_cache_entry_unhash(ce);
> > >  		}
> >
> > this patch looks bogus to me. How could the cache contain entries for the
> > same block_device from different file systems? The block_device is
> > sufficient to identify the file system, and hence its cache entries.
>
> Why is mb_cache_shrink() declared as:
>
> void
> mb_cache_shrink(struct mb_cache *cache, struct block_device *bdev);
>
> The variable cache was never used.

The cache parameter could indeed be removed. Not that it would matter much...

Thanks,
Andreas.

------------------------------- 8< -------------------------------
Remove unused mb_cache_shrink parameter

The cache parameter to mb_cache_shrink isn't used. We may as well
remove it.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.13-rc1/fs/ext2/xattr.c
===================================================================
--- linux-2.6.13-rc1.orig/fs/ext2/xattr.c
+++ linux-2.6.13-rc1/fs/ext2/xattr.c
@@ -823,7 +823,7 @@ cleanup:
 void
 ext2_xattr_put_super(struct super_block *sb)
 {
-	mb_cache_shrink(ext2_xattr_cache, sb->s_bdev);
+	mb_cache_shrink(sb->s_bdev);
 }
 
 
Index: linux-2.6.13-rc1/fs/ext3/xattr.c
===================================================================
--- linux-2.6.13-rc1.orig/fs/ext3/xattr.c
+++ linux-2.6.13-rc1/fs/ext3/xattr.c
@@ -1106,7 +1106,7 @@ cleanup:
 void
 ext3_xattr_put_super(struct super_block *sb)
 {
-	mb_cache_shrink(ext3_xattr_cache, sb->s_bdev);
+	mb_cache_shrink(sb->s_bdev);
 }
 
 /*
Index: linux-2.6.13-rc1/fs/mbcache.c
===================================================================
--- linux-2.6.13-rc1.orig/fs/mbcache.c
+++ linux-2.6.13-rc1/fs/mbcache.c
@@ -316,11 +316,10 @@ fail:
  * currently in use cannot be freed, and thus remain in the cache. All others
  * are freed.
  *
- * @cache: which cache to shrink
  * @bdev: which device's cache entries to shrink
  */
 void
-mb_cache_shrink(struct mb_cache *cache, struct block_device *bdev)
+mb_cache_shrink(struct block_device *bdev)
 {
 	LIST_HEAD(free_list);
 	struct list_head *l, *ltmp;
Index: linux-2.6.13-rc1/include/linux/mbcache.h
===================================================================
--- linux-2.6.13-rc1.orig/include/linux/mbcache.h
+++ linux-2.6.13-rc1/include/linux/mbcache.h
@@ -29,7 +29,7 @@ struct mb_cache_op {
 
 struct mb_cache * mb_cache_create(const char *, struct mb_cache_op *, size_t,
 				  int, int);
-void mb_cache_shrink(struct mb_cache *, struct block_device *);
+void mb_cache_shrink(struct block_device *);
 void mb_cache_destroy(struct mb_cache *);
 
 /* Functions on cache entries */

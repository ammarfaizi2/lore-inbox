Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTETAji (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTETAji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:39:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:919 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263369AbTETAjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:39:21 -0400
Subject: [PATCH] dentry/inode accounting for vm_enough_mem()
From: Dave Hansen <haveblue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-EuF7cnwUzJ+waiHirYe5"
Organization: 
Message-Id: <1053391863.12309.2.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 May 2003 17:51:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EuF7cnwUzJ+waiHirYe5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

One of the things on the current must-fix list is:
> - Overcommit accounting gets wrong answers
> 
>   - underestimates reclaimable slab, gives bogus failures when
>     dcache&icache are large.

More comments from Andrew:
> If the cache slab fragmentation is bad it can be hugely wrong.
> A factor of ten has been observed (rarely).  Factors of two happen
> often.
...
> > But, if prune_[di]cache() will only touch those which are being
> >  counted by nr_unused, how can we be more aggressive?
> 
> Well, just by assuming all slab is reclaimable is one way.
> 
> The problem with that is that to read slab accounting we need to do
> get_page_state(), which is too expensive to be called for every mmap()
> on big SMP.

Instead of going through get_page_state(), the following code keeps 
track of entries as their space is allocated in the slab via 
{con,de}structors. It _will_ overestimate the amount of reclaimable 
slab but, previously, using the .nr_unused stat, this number was 
underestimated and caused too many good allocations to fail.  This 
assumes that every dentry/inode allocated in the slab is reclaimable,
which they probably will be if we get deperate enough anyway.

and, as for the counter type being an atomic_t:
> Andrew Morton wrote:
> > Dave Hansen wrote:
> > An atomic_t might be a good idea, but I'm a bit worried that 24 bits
> > might not be enough.  At 160 bytes/dentry, that's 2.5GB of dentries
> > before the counter overflows.  I would imagine that we'll run out of
> > plenty of other things before we get to _that_ many dentries.
> 
> The 24-bit thing is only on sparc32.  I don't think 2G of dentries
> is possible on sparc32 anyway.

The attached patch is against 2.5.69-mm7.
-- 
Dave Hansen
haveblue@us.ibm.com

--=-EuF7cnwUzJ+waiHirYe5
Content-Disposition: attachment; filename="(d,i)cache-vm_enough_fix-2.5.69-0.patch"
Content-Type: text/x-patch; NAME="(d,i)cache-vm_enough_fix-2.5.69-0.patch"; CHARSET=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -rup linux-2.5.69-mm8-clean/fs/dcache.c linux-2.5.69-mm8-dcache-count/fs/dcache.c
--- linux-2.5.69-mm8-clean/fs/dcache.c	Mon May 19 13:25:53 2003
+++ linux-2.5.69-mm8-dcache-count/fs/dcache.c	Mon May 19 13:45:05 2003
@@ -1529,6 +1529,16 @@ out:
 	return ino;
 }
 
+void d_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
+{
+	atomic_inc(&dentry_stat.nr_alloced);
+}
+
+void d_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
+{
+	atomic_dec(&dentry_stat.nr_alloced);
+}
+
 static void __init dcache_init(unsigned long mempages)
 {
 	struct hlist_head *d;
@@ -1548,7 +1558,7 @@ static void __init dcache_init(unsigned 
 					 sizeof(struct dentry),
 					 0,
 					 SLAB_HWCACHE_ALIGN,
-					 NULL, NULL);
+					 d_ctor, d_dtor);
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
 	
diff -rup linux-2.5.69-mm8-clean/fs/inode.c linux-2.5.69-mm8-dcache-count/fs/inode.c
--- linux-2.5.69-mm8-clean/fs/inode.c	Mon May 19 13:25:54 2003
+++ linux-2.5.69-mm8-dcache-count/fs/inode.c	Mon May 19 16:23:14 2003
@@ -197,6 +197,13 @@ static void init_once(void * foo, kmem_c
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(inode);
+
+	atomic_inc(&inodes_stat.nr_alloced);
+}
+
+void inode_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
+{
+	atomic_dec(&inodes_stat.nr_alloced);
 }
 
 /*
diff -rup linux-2.5.69-mm8-clean/include/linux/dcache.h linux-2.5.69-mm8-dcache-count/include/linux/dcache.h
--- linux-2.5.69-mm8-clean/include/linux/dcache.h	Mon May 19 13:21:34 2003
+++ linux-2.5.69-mm8-dcache-count/include/linux/dcache.h	Mon May 19 14:03:23 2003
@@ -37,6 +37,7 @@ struct qstr {
 struct dentry_stat_t {
 	int nr_dentry;
 	int nr_unused;
+	atomic_t nr_alloced;
 	int age_limit;          /* age in seconds */
 	int want_pages;         /* pages requested by system */
 	int dummy[2];
diff -rup linux-2.5.69-mm8-clean/include/linux/fs.h linux-2.5.69-mm8-dcache-count/include/linux/fs.h
--- linux-2.5.69-mm8-clean/include/linux/fs.h	Mon May 19 13:25:54 2003
+++ linux-2.5.69-mm8-dcache-count/include/linux/fs.h	Mon May 19 13:50:33 2003
@@ -58,6 +58,7 @@ extern struct files_stat_struct files_st
 struct inodes_stat_t {
 	int nr_inodes;
 	int nr_unused;
+	atomic_t nr_alloced;
 	int dummy[5];
 };
 extern struct inodes_stat_t inodes_stat;
diff -rup linux-2.5.69-mm8-clean/mm/mmap.c linux-2.5.69-mm8-dcache-count/mm/mmap.c
--- linux-2.5.69-mm8-clean/mm/mmap.c	Mon May 19 13:25:55 2003
+++ linux-2.5.69-mm8-dcache-count/mm/mmap.c	Mon May 19 16:24:33 2003
@@ -82,16 +82,21 @@ int vm_enough_memory(long pages)
 		free += nr_swap_pages;
 
 		/*
-		 * The code below doesn't account for free space in the
-		 * inode and dentry slab cache, slab cache fragmentation,
-		 * inodes and dentries which will become freeable under
-		 * VM load, etc. Lets just hope all these (complex)
-		 * factors balance out...
+		 * The code below will overestimate the amount of 
+		 * reclaimable slab.  Previously, using the .nr_unused
+		 * stat, this number was too low and caused too many
+		 * good allocations to fail.  This assumes that every 
+		 * dentry/inode allocated in the slab is reclaimable,
+		 * which they probably will be if we get deperate
+		 * enough.
+		 * - Dave Hansen <haveblue@us.ibm.com>
 		 */
-		free += (dentry_stat.nr_unused * sizeof(struct dentry)) >>
-			PAGE_SHIFT;
-		free += (inodes_stat.nr_unused * sizeof(struct inode)) >>
-			PAGE_SHIFT;
+		free += (atomic_read(&dentry_stat.nr_alloced) * 
+			 sizeof(struct dentry)) >>
+			 PAGE_SHIFT;
+		free += (atomic_read(&inodes_stat.nr_alloced) * 
+			 sizeof(struct inode)) >>
+			 PAGE_SHIFT;
 
 		/*
 		 * Leave the last 3% for root

--=-EuF7cnwUzJ+waiHirYe5--


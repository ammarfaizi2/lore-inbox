Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757410AbWKWQgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410AbWKWQgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757413AbWKWQgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:36:17 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:59595 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1757410AbWKWQgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:36:16 -0500
Date: Thu, 23 Nov 2006 16:36:13 +0000
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
Message-ID: <20061123163613.GA25818@skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie> <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie> <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie> <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/11/06 16:44), Linus Torvalds didst pronounce:
> 
> 
> On Tue, 21 Nov 2006, Mel Gorman wrote:
> >
> > On Tue, 21 Nov 2006, Christoph Lameter wrote:
> > 
> > > Are GFP_HIGHUSER allocations always movable? It would reduce the size of
> > > the patch if this would be added to GFP_HIGHUSER.
> > > 
> > 
> > No, they aren't. Page tables allocated with HIGHPTE are currently not movable
> > for example. A number of drivers (infiniband for example) also use
> > __GFP_HIGHMEM that are not movable.
> 
> It might make sense to just use another GFP_HIGHxyzzy #define for the 
> non-movable HIGHMEM users. There's probably much fewer of those, and their 
> behaviour obviously is very different from the traditional GFP_HIGHUSER 
> pages (ie page cache and anonymous user mappings).
> 

There are a suprising number of GFP_HIGHUSER users. I've included an
untested patch below to give an idea of what the reworked patch would
look like. What is most suprising about this is that there are driver and
filesystem allocations obeying cpuset limits.  I wonder was that really
the intention or was GFP_HIGHUSER seen as an easy (but mistaken) way of
identifying allocations for page cache and user mappings.

> So you could literally use "GFP_HIGHPTE" for the PTE mappings, and that 
> would in fact even simplify some of the users (ie it would allow moving 
> the #ifdef CONFIG_HIGHPTE check from the code to <linux/gfp.h>). Similarly 
> for any other non-movable things, no?
> 

As it turns out, HighPTE is just one of many cases where pinned allocations
use high memory. However, defining GFP_PTE and making the CONFIG_HIGHPTE
check in <linux/gfp.h> is probably not a bad idea either way.

> So then we'd just make GFP_HIGHUSER implicitly mean "movable". It could be 
> nice if GFP_USER would do the same, but I guess we have too many of those 
> around to verify (although _most_ of those are probably kmalloc, and 
> kmalloc would obviously better strip away the __GFP_MOVABLE bit anyway).
> 

Your hunch here is right. GFP_USER has about 30 callers that are not using
kmalloc(). As part of a cleanup, an audit could be made to identify GFP_USER
allocations that are movable and those that are not. A brief look shows that
most are not movable so the split is doable.

Here is an untested patch that creates a GFP_HIGHUNMOVABLE flag for
unmovable kernel allocations in high memory and leaves GFP_HIGHUSER for
movable allocations.

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/drivers/infiniband/hw/mthca/mthca_eq.c linux-2.6.19-rc5-mm2-001_clustering_flags/drivers/infiniband/hw/mthca/mthca_eq.c
--- linux-2.6.19-rc5-mm2-clean/drivers/infiniband/hw/mthca/mthca_eq.c	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/drivers/infiniband/hw/mthca/mthca_eq.c	2006-11-23 16:26:37.000000000 +0000
@@ -793,7 +793,7 @@ int __devinit mthca_map_eq_icm(struct mt
 	 * memory, or 1 KB total.
 	 */
 	dev->eq_table.icm_virt = icm_virt;
-	dev->eq_table.icm_page = alloc_page(GFP_HIGHUSER);
+	dev->eq_table.icm_page = alloc_page(GFP_HIGHUNMOVABLE);
 	if (!dev->eq_table.icm_page)
 		return -ENOMEM;
 	dev->eq_table.icm_dma  = pci_map_page(dev->pdev, dev->eq_table.icm_page, 0,
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/drivers/infiniband/hw/mthca/mthca_main.c linux-2.6.19-rc5-mm2-001_clustering_flags/drivers/infiniband/hw/mthca/mthca_main.c
--- linux-2.6.19-rc5-mm2-clean/drivers/infiniband/hw/mthca/mthca_main.c	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/drivers/infiniband/hw/mthca/mthca_main.c	2006-11-23 16:26:37.000000000 +0000
@@ -342,7 +342,7 @@ static int __devinit mthca_load_fw(struc
 
 	mdev->fw.arbel.fw_icm =
 		mthca_alloc_icm(mdev, mdev->fw.arbel.fw_pages,
-				GFP_HIGHUSER | __GFP_NOWARN);
+				GFP_HIGHUNMOVABLE | __GFP_NOWARN);
 	if (!mdev->fw.arbel.fw_icm) {
 		mthca_err(mdev, "Couldn't allocate FW area, aborting.\n");
 		return -ENOMEM;
@@ -404,7 +404,7 @@ static int __devinit mthca_init_icm(stru
 		  (unsigned long long) aux_pages << 2);
 
 	mdev->fw.arbel.aux_icm = mthca_alloc_icm(mdev, aux_pages,
-						 GFP_HIGHUSER | __GFP_NOWARN);
+						GFP_HIGHUNMOVABLE | __GFP_NOWARN);
 	if (!mdev->fw.arbel.aux_icm) {
 		mthca_err(mdev, "Couldn't allocate aux memory, aborting.\n");
 		return -ENOMEM;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/drivers/infiniband/hw/mthca/mthca_memfree.c linux-2.6.19-rc5-mm2-001_clustering_flags/drivers/infiniband/hw/mthca/mthca_memfree.c
--- linux-2.6.19-rc5-mm2-clean/drivers/infiniband/hw/mthca/mthca_memfree.c	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/drivers/infiniband/hw/mthca/mthca_memfree.c	2006-11-23 16:26:37.000000000 +0000
@@ -166,8 +166,8 @@ int mthca_table_get(struct mthca_dev *de
 	}
 
 	table->icm[i] = mthca_alloc_icm(dev, MTHCA_TABLE_CHUNK_SIZE >> PAGE_SHIFT,
-					(table->lowmem ? GFP_KERNEL : GFP_HIGHUSER) |
-					__GFP_NOWARN);
+			(table->lowmem ? GFP_KERNEL : GFP_HIGHUNMOVABLE) |
+			__GFP_NOWARN);
 	if (!table->icm[i]) {
 		ret = -ENOMEM;
 		goto out;
@@ -313,8 +313,8 @@ struct mthca_icm_table *mthca_alloc_icm_
 			chunk_size = nobj * obj_size - i * MTHCA_TABLE_CHUNK_SIZE;
 
 		table->icm[i] = mthca_alloc_icm(dev, chunk_size >> PAGE_SHIFT,
-						(use_lowmem ? GFP_KERNEL : GFP_HIGHUSER) |
-						__GFP_NOWARN);
+				(use_lowmem ? GFP_KERNEL : GFP_HIGHUNMOVABLE) |
+				__GFP_NOWARN);
 		if (!table->icm[i])
 			goto err;
 		if (mthca_MAP_ICM(dev, table->icm[i], virt + i * MTHCA_TABLE_CHUNK_SIZE,
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/drivers/kvm/kvm_main.c linux-2.6.19-rc5-mm2-001_clustering_flags/drivers/kvm/kvm_main.c
--- linux-2.6.19-rc5-mm2-clean/drivers/kvm/kvm_main.c	2006-11-23 15:08:51.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/drivers/kvm/kvm_main.c	2006-11-23 16:26:37.000000000 +0000
@@ -1535,7 +1535,7 @@ raced:
 
 		memset(new.phys_mem, 0, npages * sizeof(struct page *));
 		for (i = 0; i < npages; ++i) {
-			new.phys_mem[i] = alloc_page(GFP_HIGHUSER);
+			new.phys_mem[i] = alloc_page(GFP_HIGHUNMOVABLE);
 			if (!new.phys_mem[i])
 				goto out_free;
 		}
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/block_dev.c linux-2.6.19-rc5-mm2-001_clustering_flags/fs/block_dev.c
--- linux-2.6.19-rc5-mm2-clean/fs/block_dev.c	2006-11-23 15:08:57.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/fs/block_dev.c	2006-11-23 16:26:37.000000000 +0000
@@ -380,7 +380,7 @@ struct block_device *bdget(dev_t dev)
 		inode->i_rdev = dev;
 		inode->i_bdev = bdev;
 		inode->i_data.a_ops = &def_blk_aops;
-		mapping_set_gfp_mask(&inode->i_data, GFP_USER);
+		mapping_set_gfp_mask(&inode->i_data, GFP_USER|__GFP_MOVABLE);
 		inode->i_data.backing_dev_info = &default_backing_dev_info;
 		spin_lock(&bdev_lock);
 		list_add(&bdev->bd_list, &all_bdevs);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/buffer.c linux-2.6.19-rc5-mm2-001_clustering_flags/fs/buffer.c
--- linux-2.6.19-rc5-mm2-clean/fs/buffer.c	2006-11-23 15:08:57.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/fs/buffer.c	2006-11-23 16:26:37.000000000 +0000
@@ -1048,7 +1048,8 @@ grow_dev_page(struct block_device *bdev,
 	struct page *page;
 	struct buffer_head *bh;
 
-	page = find_or_create_page(inode->i_mapping, index, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, index,
+				   GFP_NOFS|__GFP_MOVABLE);
 	if (!page)
 		return NULL;
 
@@ -2723,7 +2724,7 @@ int submit_bh(int rw, struct buffer_head
 	 * from here on down, it's all bio -- do the initial mapping,
 	 * submit_bio -> generic_make_request may further map this bio around
 	 */
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_alloc(GFP_NOIO|__GFP_MOVABLE, 1);
 
 	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev = bh->b_bdev;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/ncpfs/mmap.c linux-2.6.19-rc5-mm2-001_clustering_flags/fs/ncpfs/mmap.c
--- linux-2.6.19-rc5-mm2-clean/fs/ncpfs/mmap.c	2006-11-23 15:08:58.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/fs/ncpfs/mmap.c	2006-11-23 16:26:37.000000000 +0000
@@ -38,8 +38,8 @@ static struct page* ncp_file_mmap_nopage
 	int bufsize;
 	int pos;
 
-	page = alloc_page(GFP_HIGHUSER); /* ncpfs has nothing against high pages
-	           as long as recvmsg and memset works on it */
+	page = alloc_page(GFP_HIGHUNMOVABLE); /* ncpfs has nothing against high
+	           pages as long as recvmsg and memset works on it */
 	if (!page)
 		return page;
 	pg_addr = kmap(page);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/nfs/dir.c linux-2.6.19-rc5-mm2-001_clustering_flags/fs/nfs/dir.c
--- linux-2.6.19-rc5-mm2-clean/fs/nfs/dir.c	2006-11-23 15:08:58.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/fs/nfs/dir.c	2006-11-23 16:26:37.000000000 +0000
@@ -471,7 +471,7 @@ int uncached_readdir(nfs_readdir_descrip
 	dfprintk(DIRCACHE, "NFS: uncached_readdir() searching for cookie %Lu\n",
 			(unsigned long long)*desc->dir_cookie);
 
-	page = alloc_page(GFP_HIGHUSER);
+	page = alloc_page(GFP_HIGHUNMOVABLE);
 	if (!page) {
 		status = -ENOMEM;
 		goto out;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/pipe.c linux-2.6.19-rc5-mm2-001_clustering_flags/fs/pipe.c
--- linux-2.6.19-rc5-mm2-clean/fs/pipe.c	2006-11-23 15:08:58.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/fs/pipe.c	2006-11-23 16:26:37.000000000 +0000
@@ -417,7 +417,7 @@ redo1:
 			int error, atomic = 1;
 
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGHUNMOVABLE);
 				if (unlikely(!page)) {
 					ret = ret ? : -ENOMEM;
 					break;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/linux/gfp.h linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/gfp.h
--- linux-2.6.19-rc5-mm2-clean/include/linux/gfp.h	2006-11-23 15:09:01.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/gfp.h	2006-11-23 16:27:49.000000000 +0000
@@ -46,6 +46,7 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
 #define __GFP_THISNODE	((__force gfp_t)0x40000u)/* No fallback, no policies */
+#define __GFP_MOVABLE 	((__force gfp_t)0x80000u) /* Page is movable */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -54,7 +55,8 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE)
+			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE|\
+			__GFP_MOVABLE)
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
@@ -65,7 +67,9 @@ struct vm_area_struct;
 #define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
-			 __GFP_HIGHMEM)
+			 __GFP_HIGHMEM | __GFP_MOVABLE)
+#define GFP_HIGHUNMOVABLE	(__GFP_WAIT | __GFP_IO | __GFP_FS | \
+			 	 __GFP_HARDWALL | __GFP_HIGHMEM)
 
 #ifdef CONFIG_NUMA
 #define GFP_THISNODE	(__GFP_THISNODE | __GFP_NOWARN | __GFP_NORETRY)
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/linux/mempolicy.h linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/mempolicy.h
--- linux-2.6.19-rc5-mm2-clean/include/linux/mempolicy.h	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/mempolicy.h	2006-11-23 16:26:37.000000000 +0000
@@ -258,7 +258,7 @@ static inline void mpol_fix_fork_child_f
 static inline struct zonelist *huge_zonelist(struct vm_area_struct *vma,
 		unsigned long addr)
 {
-	return NODE_DATA(0)->node_zonelists + gfp_zone(GFP_HIGHUSER);
+	return NODE_DATA(0)->node_zonelists + gfp_zone(GFP_HIGHUNMOVABLE);
 }
 
 static inline int do_migrate_pages(struct mm_struct *mm,
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/linux/slab.h linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/slab.h
--- linux-2.6.19-rc5-mm2-clean/include/linux/slab.h	2006-11-23 15:09:02.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/slab.h	2006-11-23 16:26:37.000000000 +0000
@@ -99,7 +99,7 @@ extern void *__kmalloc(size_t, gfp_t);
  * %GFP_ATOMIC - Allocation will not sleep.
  *   For example, use this inside interrupt handlers.
  *
- * %GFP_HIGHUSER - Allocate pages from high memory.
+ * %GFP_HIGHUNMOVABLE - Allocate pages from high memory.
  *
  * %GFP_NOIO - Do not do any I/O at all while trying to get memory.
  *
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/kernel/kexec.c linux-2.6.19-rc5-mm2-001_clustering_flags/kernel/kexec.c
--- linux-2.6.19-rc5-mm2-clean/kernel/kexec.c	2006-11-23 15:09:03.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/kernel/kexec.c	2006-11-23 16:26:37.000000000 +0000
@@ -774,7 +774,7 @@ static int kimage_load_normal_segment(st
 		char *ptr;
 		size_t uchunk, mchunk;
 
-		page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
+		page = kimage_alloc_page(image, GFP_HIGHUNMOVABLE, maddr);
 		if (page == 0) {
 			result  = -ENOMEM;
 			goto out;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/hugetlb.c linux-2.6.19-rc5-mm2-001_clustering_flags/mm/hugetlb.c
--- linux-2.6.19-rc5-mm2-clean/mm/hugetlb.c	2006-11-23 15:09:03.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/mm/hugetlb.c	2006-11-23 16:26:37.000000000 +0000
@@ -73,7 +73,7 @@ static struct page *dequeue_huge_page(st
 
 	for (z = zonelist->zones; *z; z++) {
 		nid = zone_to_nid(*z);
-		if (cpuset_zone_allowed(*z, GFP_HIGHUSER) &&
+		if (cpuset_zone_allowed(*z, GFP_HIGHUNMOVABLE) &&
 		    !list_empty(&hugepage_freelists[nid]))
 			break;
 	}
@@ -103,7 +103,7 @@ static int alloc_fresh_huge_page(void)
 {
 	static int nid = 0;
 	struct page *page;
-	page = alloc_pages_node(nid, GFP_HIGHUSER|__GFP_COMP|__GFP_NOWARN,
+	page = alloc_pages_node(nid, GFP_HIGHUNMOVABLE|__GFP_COMP|__GFP_NOWARN,
 					HUGETLB_PAGE_ORDER);
 	nid = next_node(nid, node_online_map);
 	if (nid == MAX_NUMNODES)
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/mempolicy.c linux-2.6.19-rc5-mm2-001_clustering_flags/mm/mempolicy.c
--- linux-2.6.19-rc5-mm2-clean/mm/mempolicy.c	2006-11-23 15:09:03.000000000 +0000
+++ linux-2.6.19-rc5-mm2-001_clustering_flags/mm/mempolicy.c	2006-11-23 16:26:37.000000000 +0000
@@ -1210,9 +1210,10 @@ struct zonelist *huge_zonelist(struct vm
 		unsigned nid;
 
 		nid = interleave_nid(pol, vma, addr, HPAGE_SHIFT);
-		return NODE_DATA(nid)->node_zonelists + gfp_zone(GFP_HIGHUSER);
+		return NODE_DATA(nid)->node_zonelists +
+						gfp_zone(GFP_HIGHUNMOVABLE);
 	}
-	return zonelist_policy(GFP_HIGHUSER, pol);
+	return zonelist_policy(GFP_HIGHUNMOVABLE, pol);
 }
 #endif
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbUDMRsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbUDMRsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:48:52 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:50706 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263625AbUDMRrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:47:43 -0400
Date: Tue, 13 Apr 2004 18:45:28 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: kenneth.w.chen@intel.com, raybry@sgi.com, mbligh@aracnet.com,
       anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: HUGETLB commitment tracking patch
Message-ID: <202530000.1081878328@[192.168.100.2]>
X-Mailer: Mulberry/3.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the completed hugetlb commitment tracking patch.  Rediffed
and tested against 2.6.5-mc4.

Andrew, please consider for -mm.

-apw

--- (070-hugetlb_tracking_R9)
Handle hugetlb commitment tracking.  Track commitments against the
fixed hugetlb page pool created by shm and mmap activity.   Ensure
that we never commit more pages than available even when the pages
are not allocated immediatly, for example when created via shmget().
By separating commitment from allocation it provide the necessary
framework to allow allocation on first reference under demang page
instantiation and for NUMA placement.

---
 arch/i386/mm/hugetlbpage.c    |    7 -
 arch/ia64/mm/hugetlbpage.c    |    7 -
 arch/ppc64/mm/hugetlbpage.c   |    7 -
 arch/sh/mm/hugetlbpage.c      |    7 -
 arch/sparc64/mm/hugetlbpage.c |    7 -
 fs/hugetlbfs/inode.c          |  254 ++++++++++++++++++++++++++++++++++++++++--
 fs/proc/proc_misc.c           |    1
 include/linux/hugetlb.h       |    7 -
 8 files changed, 249 insertions(+), 48 deletions(-)

diff -upN reference/arch/i386/mm/hugetlbpage.c current/arch/i386/mm/hugetlbpage.c
--- reference/arch/i386/mm/hugetlbpage.c	2004-04-13 12:09:54.000000000 +0100
+++ current/arch/i386/mm/hugetlbpage.c	2004-04-13 12:12:23.000000000 +0100
@@ -263,21 +263,14 @@ int hugetlb_prefault(struct address_spac
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 		page = find_get_page(mapping, idx);
 		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
 			page = alloc_huge_page();
 			if (!page) {
-				hugetlb_put_quota(mapping);
 				ret = -ENOMEM;
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
 			unlock_page(page);
 			if (ret) {
-				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;
 			}
diff -upN reference/arch/ia64/mm/hugetlbpage.c current/arch/ia64/mm/hugetlbpage.c
--- reference/arch/ia64/mm/hugetlbpage.c	2004-04-13 12:09:55.000000000 +0100
+++ current/arch/ia64/mm/hugetlbpage.c	2004-04-13 12:12:23.000000000 +0100
@@ -283,21 +283,14 @@ int hugetlb_prefault(struct address_spac
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 		page = find_get_page(mapping, idx);
 		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
 			page = alloc_huge_page();
 			if (!page) {
-				hugetlb_put_quota(mapping);
 				ret = -ENOMEM;
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
 			unlock_page(page);
 			if (ret) {
-				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;
 			}
diff -upN reference/arch/ppc64/mm/hugetlbpage.c current/arch/ppc64/mm/hugetlbpage.c
--- reference/arch/ppc64/mm/hugetlbpage.c	2004-04-13 12:09:58.000000000 +0100
+++ current/arch/ppc64/mm/hugetlbpage.c	2004-04-13 12:12:23.000000000 +0100
@@ -438,21 +438,14 @@ int hugetlb_prefault(struct address_spac
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 		page = find_get_page(mapping, idx);
 		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
 			page = alloc_huge_page();
 			if (!page) {
-				hugetlb_put_quota(mapping);
 				ret = -ENOMEM;
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
 			unlock_page(page);
 			if (ret) {
-				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;
 			}
diff -upN reference/arch/sh/mm/hugetlbpage.c current/arch/sh/mm/hugetlbpage.c
--- reference/arch/sh/mm/hugetlbpage.c	2004-04-13 12:09:58.000000000 +0100
+++ current/arch/sh/mm/hugetlbpage.c	2004-04-13 12:12:23.000000000 +0100
@@ -242,21 +242,14 @@ int hugetlb_prefault(struct address_spac
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 		page = find_get_page(mapping, idx);
 		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
 			page = alloc_huge_page();
 			if (!page) {
-				hugetlb_put_quota(mapping);
 				ret = -ENOMEM;
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
 			unlock_page(page);
 			if (ret) {
-				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;
 			}
diff -upN reference/arch/sparc64/mm/hugetlbpage.c current/arch/sparc64/mm/hugetlbpage.c
--- reference/arch/sparc64/mm/hugetlbpage.c	2004-04-13 12:09:59.000000000 +0100
+++ current/arch/sparc64/mm/hugetlbpage.c	2004-04-13 12:12:23.000000000 +0100
@@ -239,21 +239,14 @@ int hugetlb_prefault(struct address_spac
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 		page = find_get_page(mapping, idx);
 		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
 			page = alloc_huge_page();
 			if (!page) {
-				hugetlb_put_quota(mapping);
 				ret = -ENOMEM;
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
 			unlock_page(page);
 			if (ret) {
-				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;
 			}
diff -upN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c	2004-04-13 12:10:15.000000000 +0100
+++ current/fs/hugetlbfs/inode.c	2004-04-13 12:12:23.000000000 +0100
@@ -32,6 +32,212 @@
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6

+/* Convert loff_t and PAGE_SIZE counts to hugetlb page counts. */
+#define VMACCT(x) ((x) >> (HPAGE_SHIFT))
+#define VMACCTPG(x) ((x) >> (HPAGE_SHIFT - PAGE_SHIFT))
+
+atomic_t hugetlbzone_resv = ATOMIC_INIT(0);
+
+int hugetlb_acct_memory(long delta)
+{
+	atomic_add(delta, &hugetlbzone_resv);
+	if (delta > 0 && atomic_read(&hugetlbzone_resv) >
+			VMACCTPG(hugetlb_total_pages())) {
+		atomic_add(-delta, &hugetlbzone_resv);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+struct file_region {
+	struct list_head link;
+	int from;
+	int to;
+};
+
+static int region_add(struct list_head *head, int f, int t)
+{
+	struct file_region *rg;
+	struct file_region *nrg;
+	struct file_region *trg;
+
+	/* Locate the region we are either in or before. */
+	list_for_each_entry(rg, head, link)
+		if (f <= rg->to)
+			break;
+
+	/* Add a new region if the existing region starts above our end. */
+	if (!rg || t < rg->from) {
+		printk(KERN_WARNING "region_add: existing region missing\n");
+		return -EINVAL;
+	}
+
+	/* Round our left edge to the current segment if it encloses us. */
+	if (f > rg->from)
+		f = rg->from;
+
+	/* Check for and consume any regions we now overlap with. */
+	nrg = rg;
+	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
+		if (&rg->link == head)
+			break;
+		if (rg->from > t)
+			break;
+
+		/* If this area reaches higher then extend our area to
+		 * include it completely.  If this is not the first area
+		 * which we intend to reuse, free it. */
+		if (rg->to > t)
+			t = rg->to;
+		if (rg != nrg) {
+			list_del(&rg->link);
+			kfree(rg);
+		}
+	}
+	nrg->from = f;
+	nrg->to = t;
+	return 0;
+}
+
+static int region_chg(struct list_head *head, int f, int t)
+{
+	struct file_region *rg;
+	struct file_region *nrg;
+	loff_t chg = 0;
+
+	/* Locate the region we are before or in. */
+	list_for_each_entry(rg, head, link)
+		if (f <= rg->to)
+			break;
+
+	/* If we are below the current region then a new region is required.
+	 * Subtle, allocate a new region at the position but make it zero
+	 * size such that we can guarentee to record the reservation. */
+	if (&rg->link == head || t < rg->from) {
+		nrg = kmalloc(sizeof(*nrg), GFP_KERNEL);
+		if (nrg == 0)
+			return -ENOMEM;
+		nrg->from = f;
+		nrg->to   = f;
+		INIT_LIST_HEAD(&nrg->link);
+		list_add(&nrg->link, rg->link.prev);
+
+		return t - f;
+	}
+
+	/* Round our left edge to the current segment if it encloses us. */
+	if (f > rg->from)
+		f = rg->from;
+	chg = t - f;
+
+	/* Check for and consume any regions we now overlap with. */
+	list_for_each_entry(rg, rg->link.prev, link) {
+		if (&rg->link == head)
+			break;
+		if (rg->from > t)
+			return chg;
+
+		/* We overlap with this area, if it extends futher than
+		 * us then we must extend ourselves.  Account for its
+		 * existing reservation. */
+		if (rg->to > t) {
+			chg += rg->to - t;
+			t = rg->to;
+		}
+		chg -= rg->to - rg->from;
+	}
+	return chg;
+}
+
+static int region_truncate(struct list_head *head, int end)
+{
+	struct file_region *rg;
+	struct file_region *trg;
+	int chg = 0;
+
+	/* Locate the region we are either in or before. */
+	list_for_each_entry(rg, head, link)
+		if (end <= rg->to)
+			break;
+	if (&rg->link == head)
+		return 0;
+
+	/* If we are in the middle of a region then adjust it. */
+	if (end > rg->from) {
+		chg = rg->to - end;
+		rg->to = end;
+		rg = list_entry(rg->link.next, typeof(*rg), link);
+	}
+
+	/* Drop any remaining regions. */
+	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
+		if (&rg->link == head)
+			break;
+		chg += rg->to - rg->from;
+		list_del(&rg->link);
+		kfree(rg);
+	}
+	return chg;
+}
+
+#if 0
+static int region_dump(struct list_head *head)
+{
+	struct file_region *rg;
+
+	list_for_each_entry(rg, head, link)
+		printk(KERN_WARNING "rg<%p> f<%lld> t<%lld>\n",
+				rg, rg->from, rg->to);
+	return 0;
+}
+#endif
+
+/* Calculate the commitment change that this mapping implies
+ * and check it against both the commitment and quota limits. */
+static int hugetlb_acct_prepare(struct inode *inode, int from, int to)
+{
+	int chg;
+	int ret;
+
+	chg = region_chg(&inode->i_mapping->private_list, from, to);
+	if (chg < 0)
+		return chg;
+	ret = hugetlb_acct_memory(chg);
+	if (ret < 0)
+		return ret;
+	ret = hugetlb_get_quota(inode->i_mapping, chg);
+	if (ret < 0)
+		goto undo_commit;
+	return chg;
+
+undo_commit:
+	hugetlb_acct_memory(-chg);
+	return ret;
+}
+static int hugetlb_acct_commit(struct inode *inode, int from, int to)
+{
+	return region_add(&inode->i_mapping->private_list, from, to);
+}
+static void hugetlb_acct_undo(struct inode *inode, int chg)
+{
+	hugetlb_put_quota(inode->i_mapping, chg);
+	hugetlb_acct_memory(-chg);
+}
+static void hugetlb_acct_release(struct inode *inode, int to)
+{
+	int chg;
+
+	chg = region_truncate(&inode->i_mapping->private_list, to);
+	hugetlb_acct_memory(-chg);
+	hugetlb_put_quota(inode->i_mapping, chg);
+}
+
+int hugetlbfs_report_meminfo(char *buf)
+{
+	long htlb = atomic_read(&hugetlbzone_resv);
+	return sprintf(buf, "HugePages_Reserved: %5lu\n", htlb);
+}
+
 static struct super_operations hugetlbfs_ops;
 static struct address_space_operations hugetlbfs_aops;
 struct file_operations hugetlbfs_file_operations;
@@ -49,6 +255,7 @@ static int hugetlbfs_file_mmap(struct fi
 	struct address_space *mapping = inode->i_mapping;
 	loff_t len, vma_len;
 	int ret;
+	int chg;

 	if (vma->vm_start & ~HPAGE_MASK)
 		return -EINVAL;
@@ -62,13 +269,29 @@ static int hugetlbfs_file_mmap(struct fi
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);

 	down(&inode->i_sem);
+
+	/* Calculate the commitment implied by this mapping. */
+	chg = hugetlb_acct_prepare(inode, VMACCTPG(vma->vm_pgoff),
+			VMACCTPG(vma->vm_pgoff + (vma_len >> PAGE_SHIFT)));
+	if (chg < 0) {
+		ret = chg;
+		goto unlock_out;
+	}
+
 	file_accessed(file);
 	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops = &hugetlb_vm_ops;
 	ret = hugetlb_prefault(mapping, vma);
 	len = vma_len +	((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	if (ret == 0 && inode->i_size < len)
-		inode->i_size = len;
+	if (ret == 0) {
+	       if (inode->i_size < len)
+			inode->i_size = len;
+		hugetlb_acct_commit(inode, VMACCTPG(vma->vm_pgoff),
+			VMACCTPG(vma->vm_pgoff + (vma_len >> PAGE_SHIFT)));
+	} else
+		hugetlb_acct_undo(inode, chg);
+
+unlock_out:
 	up(&inode->i_sem);

 	return ret;
@@ -181,7 +404,6 @@ void truncate_hugepages(struct address_s
 			++next;
 			truncate_huge_page(page);
 			unlock_page(page);
-			hugetlb_put_quota(mapping);
 		}
 		huge_pagevec_release(&pvec);
 	}
@@ -200,6 +422,7 @@ static void hugetlbfs_delete_inode(struc

 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_release(inode, 0);

 	security_inode_delete(inode);

@@ -241,6 +464,7 @@ out_truncate:
 	spin_unlock(&inode_lock);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_release(inode, 0);

 	if (sbinfo->free_inodes >= 0) {
 		spin_lock(&sbinfo->stat_lock);
@@ -326,6 +550,7 @@ static int hugetlb_vmtruncate(struct ino
 		hugetlb_vmtruncate_list(&mapping->i_mmap_shared, pgoff);
 	up(&mapping->i_shared_sem);
 	truncate_hugepages(mapping, offset);
+	hugetlb_acct_release(inode, VMACCT(offset));
 	return 0;
 }

@@ -382,6 +607,7 @@ static struct inode *hugetlbfs_get_inode
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
 		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
+		INIT_LIST_HEAD(&inode->i_mapping->private_list);
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		switch (mode & S_IFMT) {
 		default:
@@ -641,15 +867,15 @@ out_free:
 	return -ENOMEM;
 }

-int hugetlb_get_quota(struct address_space *mapping)
+int hugetlb_get_quota(struct address_space *mapping, int blocks)
 {
 	int ret = 0;
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(mapping->host->i_sb);

 	if (sbinfo->free_blocks > -1) {
 		spin_lock(&sbinfo->stat_lock);
-		if (sbinfo->free_blocks > 0)
-			sbinfo->free_blocks--;
+		if (sbinfo->free_blocks >= blocks)
+			sbinfo->free_blocks -= blocks;
 		else
 			ret = -ENOMEM;
 		spin_unlock(&sbinfo->stat_lock);
@@ -658,13 +884,13 @@ int hugetlb_get_quota(struct address_spa
 	return ret;
 }

-void hugetlb_put_quota(struct address_space *mapping)
+void hugetlb_put_quota(struct address_space *mapping, int blocks)
 {
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(mapping->host->i_sb);

 	if (sbinfo->free_blocks > -1) {
 		spin_lock(&sbinfo->stat_lock);
-		sbinfo->free_blocks++;
+		sbinfo->free_blocks += blocks;
 		spin_unlock(&sbinfo->stat_lock);
 	}
 }
@@ -710,9 +936,6 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!capable(CAP_IPC_LOCK))
 		return ERR_PTR(-EPERM);

-	if (!is_hugepage_mem_enough(size))
-		return ERR_PTR(-ENOMEM);
-
 	root = hugetlbfs_vfsmount->mnt_root;
 	snprintf(buf, 16, "%lu", hugetlbfs_counter());
 	quick_string.name = buf;
@@ -741,6 +964,15 @@ struct file *hugetlb_zero_setup(size_t s
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &hugetlbfs_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
+
+	/* Account for the memory usage for this segment at create time.
+	 * This maintains the commit on shmget() semantics of normal
+	 * shared memory segments. */
+	error = hugetlb_acct_prepare(inode, 0, VMACCT(size));
+	if (error < 0)
+		goto out_file;
+	error = hugetlb_acct_commit(inode, 0, VMACCT(size));
+
 	return file;

 out_file:
diff -upN reference/fs/proc/proc_misc.c current/fs/proc/proc_misc.c
--- reference/fs/proc/proc_misc.c	2004-04-06 14:17:09.000000000 +0100
+++ current/fs/proc/proc_misc.c	2004-04-13 12:12:23.000000000 +0100
@@ -231,6 +231,7 @@ static int meminfo_read_proc(char *page,
 		vmi.largest_chunk
 		);

+		len += hugetlbfs_report_meminfo(page + len);
 		len += hugetlb_report_meminfo(page + len);

 	return proc_calc_metrics(page, start, off, count, eof, len);
diff -upN reference/include/linux/hugetlb.h current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h	2004-04-13 12:10:21.000000000 +0100
+++ current/include/linux/hugetlb.h	2004-04-13 12:12:23.000000000 +0100
@@ -116,8 +116,8 @@ static inline struct hugetlbfs_sb_info *
 extern struct file_operations hugetlbfs_file_operations;
 extern struct vm_operations_struct hugetlb_vm_ops;
 struct file *hugetlb_zero_setup(size_t);
-int hugetlb_get_quota(struct address_space *mapping);
-void hugetlb_put_quota(struct address_space *mapping);
+int hugetlb_get_quota(struct address_space *mapping, int blocks);
+void hugetlb_put_quota(struct address_space *mapping, int blocks);

 static inline int is_file_hugepages(struct file *file)
 {
@@ -128,11 +128,14 @@ static inline void set_file_hugepages(st
 {
 	file->f_op = &hugetlbfs_file_operations;
 }
+int hugetlbfs_report_meminfo(char *);
+
 #else /* !CONFIG_HUGETLBFS */

 #define is_file_hugepages(file)		0
 #define set_file_hugepages(file)	BUG()
 #define hugetlb_zero_setup(size)	ERR_PTR(-ENOSYS)
+#define hugetlbfs_report_meminfo(buf)	0

 #endif /* !CONFIG_HUGETLBFS */



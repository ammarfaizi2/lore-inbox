Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269899AbUJVFLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269899AbUJVFLb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 01:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270382AbUJVFEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 01:04:44 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63635 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267549AbUJVE6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 00:58:32 -0400
Date: Thu, 21 Oct 2004 21:58:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V1 [3/4]: Overcommit handling
In-Reply-To: <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* overcommit handling

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/fs/hugetlbfs/inode.c
===================================================================
--- linux-2.6.9.orig/fs/hugetlbfs/inode.c	2004-10-21 14:50:14.000000000 -0700
+++ linux-2.6.9/fs/hugetlbfs/inode.c	2004-10-21 20:02:23.000000000 -0700
@@ -32,6 +32,206 @@
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6

+/* Convert loff_t and PAGE_SIZE counts to hugetlb page counts. */
+#define VMACCT(x) ((x) >> (HPAGE_SHIFT))
+#define VMACCTPG(x) ((x) >> (HPAGE_SHIFT - PAGE_SHIFT))
+
+static long hugetlbzone_resv;
+static spinlock_t hugetlbfs_lock = SPIN_LOCK_UNLOCKED;
+
+int hugetlb_acct_memory(long delta)
+{
+	int ret = 0;
+
+	spin_lock(&hugetlbfs_lock);
+	if (delta > 0 && (hugetlbzone_resv + delta) >
+			VMACCTPG(hugetlb_total_pages()))
+		ret = -ENOMEM;
+	else
+		hugetlbzone_resv += delta;
+	spin_unlock(&hugetlbfs_lock);
+	return ret;
+}
+
+struct file_region {
+	struct list_head link;
+	long from;
+	long to;
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
+	/* Add a new region if the existing region starts above our end.
+	 * We should already have a space to record. */
+	if (&rg->link == head || t < rg->from)
+		BUG();
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
+static int hugetlb_acct_commit(struct inode *inode, int from, int to)
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
+	ret = region_add(&inode->i_mapping->private_list, from, to);
+	return ret;
+
+undo_commit:
+	hugetlb_acct_memory(-chg);
+	return ret;
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
+	return sprintf(buf, "HugePages_Reserved: %5lu\n", hugetlbzone_resv);
+}
+
 static struct super_operations hugetlbfs_ops;
 static struct address_space_operations hugetlbfs_aops;
 struct file_operations hugetlbfs_file_operations;
@@ -48,7 +248,6 @@
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct address_space *mapping = inode->i_mapping;
 	loff_t len, vma_len;
 	int ret;

@@ -79,7 +278,10 @@
 	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
 		goto out;

-	if (inode->i_size < len)
+	ret = hugetlb_acct_commit(inode, VMACCTPG(vma->vm_pgoff),
+		VMACCTPG(vma->vm_pgoff + (vma_len >> PAGE_SHIFT)));
+
+	if (ret >= 0 && inode->i_size < len)
 		inode->i_size = len;
 out:
 	up(&inode->i_sem);
@@ -194,7 +396,6 @@
 			++next;
 			truncate_huge_page(page);
 			unlock_page(page);
-			hugetlb_put_quota(mapping);
 		}
 		huge_pagevec_release(&pvec);
 	}
@@ -213,6 +414,7 @@

 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_release(inode, 0);

 	security_inode_delete(inode);

@@ -254,6 +456,7 @@
 	spin_unlock(&inode_lock);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_release(inode, 0);

 	if (sbinfo->free_inodes >= 0) {
 		spin_lock(&sbinfo->stat_lock);
@@ -324,6 +527,7 @@
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
 	spin_unlock(&mapping->i_mmap_lock);
 	truncate_hugepages(mapping, offset);
+	hugetlb_acct_release(inode, VMACCT(offset));
 	return 0;
 }

@@ -378,6 +582,7 @@
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
 		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
+		INIT_LIST_HEAD(&inode->i_mapping->private_list);
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		info = HUGETLBFS_I(inode);
 		mpol_shared_policy_init(&info->policy);
@@ -669,15 +874,15 @@
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
@@ -686,13 +891,13 @@
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
@@ -745,9 +950,6 @@
 	if (!can_do_hugetlb_shm())
 		return ERR_PTR(-EPERM);

-	if (!is_hugepage_mem_enough(size))
-		return ERR_PTR(-ENOMEM);
-
 	if (!user_shm_lock(size, current->user))
 		return ERR_PTR(-ENOMEM);

@@ -779,6 +981,14 @@
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &hugetlbfs_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
+
+	/* Account for the memory usage for this segment at create time.
+	 * This maintains the commit on shmget() semantics of normal
+	 * shared memory segments. */
+	error = hugetlb_acct_commit(inode, 0, VMACCT(size));
+	if (error < 0)
+		goto out_file;
+
 	return file;

 out_file:
Index: linux-2.6.9/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.9.orig/fs/proc/proc_misc.c	2004-10-21 12:01:24.000000000 -0700
+++ linux-2.6.9/fs/proc/proc_misc.c	2004-10-21 20:01:09.000000000 -0700
@@ -235,6 +235,7 @@
 		vmi.largest_chunk
 		);

+		len += hugetlbfs_report_meminfo(page + len);
 		len += hugetlb_report_meminfo(page + len);

 	return proc_calc_metrics(page, start, off, count, eof, len);
Index: linux-2.6.9/include/linux/hugetlb.h
===================================================================
--- linux-2.6.9.orig/include/linux/hugetlb.h	2004-10-21 14:50:14.000000000 -0700
+++ linux-2.6.9/include/linux/hugetlb.h	2004-10-21 20:01:09.000000000 -0700
@@ -122,8 +122,8 @@
 extern struct file_operations hugetlbfs_file_operations;
 extern struct vm_operations_struct hugetlb_vm_ops;
 struct file *hugetlb_zero_setup(size_t);
-int hugetlb_get_quota(struct address_space *mapping);
-void hugetlb_put_quota(struct address_space *mapping);
+int hugetlb_get_quota(struct address_space *mapping, int blocks);
+void hugetlb_put_quota(struct address_space *mapping, int blocks);

 static inline int is_file_hugepages(struct file *file)
 {
@@ -134,11 +134,14 @@
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



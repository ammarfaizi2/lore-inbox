Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267671AbUHENvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267671AbUHENvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267695AbUHENtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:49:42 -0400
Received: from fmr03.intel.com ([143.183.121.5]:28804 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S267683AbUHENmx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:42:53 -0400
Message-Id: <200408051342.i75DgGY26555@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: RE: Hugetlb demanding paging for -mm tree
Date: Thu, 5 Aug 2004 06:42:15 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcR68Tzp5BXc7FdKQkOKAyxN9GM3OQAAIj0A
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <20040805133637.GG14358@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote on Thursday, August 05, 2004 6:37 AM
> On Thu, Aug 05, 2004 at 06:29:02AM -0700, Chen, Kenneth W wrote:
> > Dusted it off from 3 month ago.  This time re-diffed against 2.6.8-rc3-mm1.
> > One big change compare to previous release is this patch should work for
> > ALL arch that supports hugetlb page.  I have tested it on ia64 and x86.
> > For x86, tested with no highmem config, 4G highmem config and PAE config.
> > I have not tested it on sh, sparc64 and ppc64, but I have no reason to
> > believe that this feature won't work on these arches.
> > Patches are broken into two pieces.  But they should be applied together
> > to have correct functionality for hugetlb demand paging.
> > 00.demandpaging.patch - core hugetlb demand paging
> > 01.overcommit.patch   - hugetlbfs strict overcommit accounting.
> > Testing and comments are welcome.  Thanks.
>
> Could you resend as plaintext?

and ...

---------------------
01.overcommit.patch
---------------------

diff -Nurp linux-2.6.7/fs/hugetlbfs/inode.c linux-2.6.7.hugetlb/fs/hugetlbfs/inode.c
--- linux-2.6.7/fs/hugetlbfs/inode.c	2004-08-05 06:12:51.000000000 -0700
+++ linux-2.6.7.hugetlb/fs/hugetlbfs/inode.c	2004-08-05 06:16:08.000000000 -0700
@@ -32,6 +32,203 @@
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
+	long htlb = atomic_read(&hugetlbzone_resv);
+	return sprintf(buf, "HugePages_Reserved: %5lu\n", htlb);
+}
+
 static struct super_operations hugetlbfs_ops;
 static struct address_space_operations hugetlbfs_aops;
 struct file_operations hugetlbfs_file_operations;
@@ -48,7 +245,6 @@ int sysctl_hugetlb_shm_group;
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct address_space *mapping = inode->i_mapping;
 	loff_t len, vma_len;
 	int ret;

@@ -79,7 +275,10 @@ static int hugetlbfs_file_mmap(struct fi
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
@@ -194,7 +393,6 @@ void truncate_hugepages(struct address_s
 			++next;
 			truncate_huge_page(page);
 			unlock_page(page);
-			hugetlb_put_quota(mapping);
 		}
 		huge_pagevec_release(&pvec);
 	}
@@ -214,6 +412,7 @@ static void hugetlbfs_delete_inode(struc

 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_release(inode, 0);

 	security_inode_delete(inode);

@@ -256,6 +455,7 @@ out_truncate:
 	spin_unlock(&inode_lock);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_release(inode, 0);

 	if (sbinfo->free_inodes >= 0) {
 		spin_lock(&sbinfo->stat_lock);
@@ -326,6 +526,7 @@ static int hugetlb_vmtruncate(struct ino
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
 	spin_unlock(&mapping->i_mmap_lock);
 	truncate_hugepages(mapping, offset);
+	hugetlb_acct_release(inode, VMACCT(offset));
 	return 0;
 }

@@ -380,6 +581,7 @@ static struct inode *hugetlbfs_get_inode
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
 		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
+		INIT_LIST_HEAD(&inode->i_mapping->private_list);
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		info = HUGETLBFS_I(inode);
 		mpol_shared_policy_init(&info->policy);
@@ -670,15 +872,15 @@ out_free:
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
@@ -687,13 +889,13 @@ int hugetlb_get_quota(struct address_spa
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
@@ -746,9 +948,6 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!can_do_hugetlb_shm())
 		return ERR_PTR(-EPERM);

-	if (!is_hugepage_mem_enough(size))
-		return ERR_PTR(-ENOMEM);
-
 	if (!user_shm_lock(size, current->user))
 		return ERR_PTR(-ENOMEM);

@@ -780,6 +979,14 @@ struct file *hugetlb_zero_setup(size_t s
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
diff -Nurp linux-2.6.7/fs/proc/proc_misc.c linux-2.6.7.hugetlb/fs/proc/proc_misc.c
--- linux-2.6.7/fs/proc/proc_misc.c	2004-08-05 06:12:33.000000000 -0700
+++ linux-2.6.7.hugetlb/fs/proc/proc_misc.c	2004-08-05 06:13:42.000000000 -0700
@@ -227,6 +227,7 @@ static int meminfo_read_proc(char *page,
 		vmi.largest_chunk
 		);

+		len += hugetlbfs_report_meminfo(page + len);
 		len += hugetlb_report_meminfo(page + len);

 	return proc_calc_metrics(page, start, off, count, eof, len);
diff -Nurp linux-2.6.7/include/linux/hugetlb.h linux-2.6.7.hugetlb/include/linux/hugetlb.h
--- linux-2.6.7/include/linux/hugetlb.h	2004-08-05 06:12:53.000000000 -0700
+++ linux-2.6.7.hugetlb/include/linux/hugetlb.h	2004-08-05 06:13:42.000000000 -0700
@@ -122,8 +122,8 @@ static inline struct hugetlbfs_sb_info *
 extern struct file_operations hugetlbfs_file_operations;
 extern struct vm_operations_struct hugetlb_vm_ops;
 struct file *hugetlb_zero_setup(size_t);
-int hugetlb_get_quota(struct address_space *mapping);
-void hugetlb_put_quota(struct address_space *mapping);
+int hugetlb_get_quota(struct address_space *mapping, int blocks);
+void hugetlb_put_quota(struct address_space *mapping, int blocks);

 static inline int is_file_hugepages(struct file *file)
 {
@@ -134,11 +134,14 @@ static inline void set_file_hugepages(st
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




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbUDFQN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbUDFQN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:13:26 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:36618 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263893AbUDFQMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:12:36 -0400
Date: Tue, 06 Apr 2004 17:14:01 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Ray Bryant'" <raybry@sgi.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, anton@samba.org, sds@epoch.ncsc.mil,
       ak@suse.de, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: RE: [Lse-tech] RE: [PATCH] HUGETLB memory commitment
Message-ID: <25241785.1081271641@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <200404052318.i35NIHF29964@unix-os.sc.intel.com>
References: <200404052318.i35NIHF29964@unix-os.sc.intel.com>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 05 April 2004 16:18 -0700 "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

>>>>> Ray Bryant wrote on Monday, April 05, 2004 11:22 AM
>> > Chen, Kenneth W wrote:
>> > I actually started coding yesterday.  It doesn't look too bad (I think).
>> > I will post it once I finished it up later today or tomorrow.
>> 
>> Hmmm...so did I.  Oh well.  We can pull the good ideas from both. :-)

Bugger, so am I.  Someone will have to merge :)

> +	/* we have enough hugetlb page, go ahead reserve them */
> +	switch(action) {
> +		case BACK_MERGE:
> +			curr->end = block_end;
> +			break;
> +		case FRONT_MERGE:
> +			curr->start = block_start;
> +			break;
> +		case THREE_WAY_MERGE:
> +			curr->end = next->end;
> +			list_del(p->next);
> +			kfree(next);
> +			break;

I don't know if I have read this right, but if I have then you only support
overlapping with two existing extents?  What if there are extents from 0-4,
6-8 and 10-12 when you map 0-16?  Will that not corrupt the list?

Anyhow, below is a work in progress, ie it compiles and boots and passes
the tests I've applied (not tested error handling well yet).  The regions
accumulation code has been extensively tested in a user level test harness,
so I am fairly sure it works.  I have split the request and commit phases
for the region handling to allow simpler backout on other failure such as
quota (which remains to be fixed).

There is definatly debug and extra unused code in there ... Comments etc
appreciated.

-apw

[070-hugetlb_tracking_R6]

---
 fs/hugetlbfs/inode.c    |  277 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/proc/proc_misc.c     |    1 
 include/linux/hugetlb.h |    5 
 3 files changed, 278 insertions(+), 5 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c	2004-03-25 02:43:00.000000000 +0000
+++ current/fs/hugetlbfs/inode.c	2004-04-06 17:48:17.000000000 +0100
@@ -32,6 +32,234 @@
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6
 
+#define HUGETLBFS_NOACCT (~0UL)
+
+atomic_t hugetlb_committed_space = ATOMIC_INIT(0);
+
+int hugetlb_acct_memory(long delta)
+{
+	atomic_add(delta, &hugetlb_committed_space);
+	if (delta > 0 && atomic_read(&hugetlb_committed_space) >
+			hugetlb_total_pages()) {
+		atomic_add(-delta, &hugetlb_committed_space);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+#if 0
+int hugetlb_charge_page(struct vm_area_struct *vma)
+{
+	int ret;
+
+	/* if this file is marked for commit on demand then see if we can
+	 * commmit a page, if so account for it against this file. */
+	if (vma->vm_file->f_dentry->d_inode->i_blocks != ~0) {
+		ret = hugetlb_acct_memory(HPAGE_SIZE / PAGE_SIZE);
+		if (ret)
+			return ret;
+		vma->vm_file->f_dentry->d_inode->i_blocks++;
+	}
+	return 0;
+}
+int hugetlb_uncharge_page(struct vm_area_struct *vma)
+{
+	/* if this file is marked for commit on demand return a page. */
+	if (vma->vm_file->f_dentry->d_inode->i_blocks != ~0) {
+		hugetlb_acct_memory(-(HPAGE_SIZE / PAGE_SIZE));
+		vma->vm_file->f_dentry->d_inode->i_blocks--;
+	}
+	return 0;
+}
+#endif
+
+struct file_region {
+	struct list_head link;
+	loff_t from;
+	loff_t to;
+};
+
+int region_add(struct list_head *head, loff_t f, loff_t t)
+{
+	struct file_region *rg;
+	struct file_region *nrg;
+	struct file_region *trg;
+
+	printk(KERN_WARNING "region_add: head<%p> f<%lld> t<%lld>\n",
+			head, f, t);
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
+		printk(KERN_WARNING "region: consume %p %lld %lld\n",
+			rg, rg->from, rg->to);
+		
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
+int region_chg(struct list_head *head, loff_t f, loff_t t)
+{
+	struct file_region *rg;
+	struct file_region *nrg;
+	loff_t chg = 0;
+
+	printk(KERN_WARNING "region_chg: head<%p> f<%lld> t<%lld>\n",
+			head, f, t);
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
+		printk(KERN_WARNING "region: new %p %lld %lld\n",
+				nrg, nrg->from, nrg->to); 
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
+int region_truncate(struct list_head *head, loff_t end)
+{
+	struct file_region *rg;
+	struct file_region *trg;
+	int chg = 0;
+
+	printk(KERN_WARNING "region_truncate: head<%p> end<%lld>\n",
+			head, end);
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
+
+int region_dump(struct list_head *head)
+{
+	struct file_region *rg;
+
+	list_for_each_entry(rg, head, link)
+		printk(KERN_WARNING "rg<%p> f<%lld> t<%lld>\n",
+				rg, rg->from, rg->to);
+	return 0;
+}
+
+int hugetlb_acct_prepare(struct inode *inode, int from, int to)
+{
+	int chg;
+
+	/* Calculate the commitment change implied by this mapping. */
+	chg = region_chg(&inode->i_mapping->private_list, from, to);
+	if (chg < 0)
+		return chg;
+	printk(KERN_WARNING "hugetlbfs_file_mmap: len<%d>\n", chg);
+	chg = hugetlb_acct_memory(chg);
+	if (chg < 0)
+		return chg;
+
+	return chg;
+}
+int hugetlb_acct_commit(struct inode *inode, int from, int to)
+{
+	return region_add(&inode->i_mapping->private_list, from, to);
+}
+int hugetlb_acct_undo(struct inode *inode, int chg)
+{
+	return hugetlb_acct_memory(-chg);
+}
+int hugetlbfs_report_meminfo(char *buf)
+{
+#define K(x) ((x) << (PAGE_SHIFT - 10))
+	long htlb = atomic_read(&hugetlb_committed_space);
+	return sprintf(buf, "HugeCommitted_AS: %5lu kB\n", K(htlb));
+#undef K
+}
+
 static struct super_operations hugetlbfs_ops;
 static struct address_space_operations hugetlbfs_aops;
 struct file_operations hugetlbfs_file_operations;
@@ -49,6 +277,7 @@ static int hugetlbfs_file_mmap(struct fi
 	struct address_space *mapping = inode->i_mapping;
 	loff_t len, vma_len;
 	int ret;
+	int chg;
 
 	if (vma->vm_start & ~HPAGE_MASK)
 		return -EINVAL;
@@ -62,13 +291,33 @@ static int hugetlbfs_file_mmap(struct fi
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 
 	down(&inode->i_sem);
+
+	/* Calculate the commitment implied by this mapping. */
+	chg = hugetlb_acct_prepare(inode, vma->vm_pgoff,
+			vma->vm_pgoff + (vma_len >> PAGE_SHIFT));
+	if (chg < 0) {
+		ret = chg;
+		goto unlock_out;
+	}
+	printk(KERN_WARNING "hugetlbfs_file_mmap: len<%d>\n", chg);
+
+	/* FIXME, check the quota here, before we commit the change. */
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
+		/* Record the commitment. */
+		hugetlb_acct_commit(inode, vma->vm_pgoff,
+			vma->vm_pgoff + (vma_len >> PAGE_SHIFT));
+	} else
+		hugetlb_acct_undo(inode, chg);
+
+unlock_out:
 	up(&inode->i_sem);
 
 	return ret;
@@ -191,6 +440,7 @@ void truncate_hugepages(struct address_s
 static void hugetlbfs_delete_inode(struct inode *inode)
 {
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(inode->i_sb);
+	int chg;
 
 	hlist_del_init(&inode->i_hash);
 	list_del_init(&inode->i_list);
@@ -200,6 +450,8 @@ static void hugetlbfs_delete_inode(struc
 
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	chg = region_truncate(&inode->i_mapping->private_list, 0);
+	hugetlb_acct_memory(-chg);
 
 	security_inode_delete(inode);
 
@@ -217,6 +469,7 @@ static void hugetlbfs_forget_inode(struc
 {
 	struct super_block *super_block = inode->i_sb;
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(super_block);
+	int chg;
 
 	if (hlist_unhashed(&inode->i_hash))
 		goto out_truncate;
@@ -241,6 +494,8 @@ out_truncate:
 	spin_unlock(&inode_lock);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	chg = region_truncate(&inode->i_mapping->private_list, 0);
+	hugetlb_acct_memory(-chg);
 
 	if (sbinfo->free_inodes >= 0) {
 		spin_lock(&sbinfo->stat_lock);
@@ -311,6 +566,7 @@ static int hugetlb_vmtruncate(struct ino
 {
 	unsigned long pgoff;
 	struct address_space *mapping = inode->i_mapping;
+	int chg;
 
 	if (offset > inode->i_size)
 		return -EINVAL;
@@ -326,6 +582,8 @@ static int hugetlb_vmtruncate(struct ino
 		hugetlb_vmtruncate_list(&mapping->i_mmap_shared, pgoff);
 	up(&mapping->i_shared_sem);
 	truncate_hugepages(mapping, offset);
+	chg = region_truncate(&mapping->private_list, offset);
+	hugetlb_acct_memory(-chg);
 	return 0;
 }
 
@@ -350,6 +608,10 @@ static int hugetlbfs_setattr(struct dent
 			error = hugetlb_vmtruncate(inode, attr->ia_size);
 		if (error)
 			goto out;
+		/* We rely on the fact that the sizes are hugepage aligned,
+		 * and that hugetlb_vmtruncate prevents extend. */
+		hugetlb_acct_memory((attr->ia_size - i_size_read(inode)) /
+			PAGE_SIZE);
 		attr->ia_valid &= ~ATTR_SIZE;
 	}
 	error = inode_setattr(inode, attr);
@@ -382,6 +644,7 @@ static struct inode *hugetlbfs_get_inode
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
 		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
+		INIT_LIST_HEAD(&inode->i_mapping->private_list);
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		switch (mode & S_IFMT) {
 		default:
@@ -710,9 +973,6 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!capable(CAP_IPC_LOCK))
 		return ERR_PTR(-EPERM);
 
-	if (!is_hugepage_mem_enough(size))
-		return ERR_PTR(-ENOMEM);
-
 	root = hugetlbfs_vfsmount->mnt_root;
 	snprintf(buf, 16, "%lu", hugetlbfs_counter());
 	quick_string.name = buf;
@@ -736,11 +996,18 @@ struct file *hugetlb_zero_setup(size_t s
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;
+	inode->i_blocks = HUGETLBFS_NOACCT;
 	file->f_vfsmnt = mntget(hugetlbfs_vfsmount);
 	file->f_dentry = dentry;
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &hugetlbfs_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
+
+	error = hugetlb_acct_prepare(inode, 0, size / PAGE_SIZE);
+	if (error < 0)
+		goto out_file;
+	hugetlb_acct_commit(inode, 0, size / PAGE_SIZE);
+
 	return file;
 
 out_file:
diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/proc/proc_misc.c current/fs/proc/proc_misc.c
--- reference/fs/proc/proc_misc.c	2004-04-02 00:37:04.000000000 +0100
+++ current/fs/proc/proc_misc.c	2004-04-01 22:51:19.000000000 +0100
@@ -232,6 +232,7 @@ static int meminfo_read_proc(char *page,
 		);
 
 		len += hugetlb_report_meminfo(page + len);
+		len += hugetlbfs_report_meminfo(page + len);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/hugetlb.h current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h	2004-04-02 00:38:24.000000000 +0100
+++ current/include/linux/hugetlb.h	2004-04-01 22:51:19.000000000 +0100
@@ -115,11 +115,16 @@ static inline void set_file_hugepages(st
 {
 	file->f_op = &hugetlbfs_file_operations;
 }
+int hugetlbfs_report_meminfo(char *);
+int hugetlb_charge_page(struct vm_area_struct *vma);
+int hugetlb_uncharge_page(struct vm_area_struct *vma);
+
 #else /* !CONFIG_HUGETLBFS */
 
 #define is_file_hugepages(file)		0
 #define set_file_hugepages(file)	BUG()
 #define hugetlb_zero_setup(size)	ERR_PTR(-ENOSYS)
+#define hugetlbfs_report_meminfo(buf)	0
 
 #endif /* !CONFIG_HUGETLBFS */
 


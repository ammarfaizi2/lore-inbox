Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUDAVcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbUDAVbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:31:17 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:43524 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263185AbUDAVRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:17:43 -0500
Date: Thu, 01 Apr 2004 22:15:43 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ray Bryant <raybry@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <184253487.1080857742@[192.168.0.89]>
In-Reply-To: <200403310851.i2V8pkF28306@unix-os.sc.intel.com>
References: <200403310851.i2V8pkF28306@unix-os.sc.intel.com>
X-Mailer: Mulberry/3.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 31 March 2004 00:51 -0800 "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> Under common case, worked perfectly!  But there are always corner cases.
>
> I can think of two ugliness:
> 1. very sparse hugetlb file.  I can mmap one hugetlb page, at offset
>    512 GB.  This would account 512GB + 1 hugetlb page as committed_AS.
>    But I only asked for one page mapping.  One can say it's a feature,
>    but I think it's a bug.
>
> 2. There is no error checking (to undo the committed_AS accounting) after
>    hugetlb_prefault(). hugetlb_prefault doesn't always succeed in allocat-
>    ing all the pages user asked for due to disk quota limit.  It can have
>    partial allocation which would put the committed_AS in a wedged state.

O.k. Here is the latest version of the hugetlb commitment tracking patch
(hugetlb_tracking_R4).  This now understands the difference between shm
allocated and mmap allocated and handles them differently.  This should
fix 1.  We now handle the commitments correctly under quota failures.

Please review.

-apw

---
 arch/i386/mm/hugetlbpage.c |   30 +++++++++++++------
 file                       |    1
 fs/hugetlbfs/inode.c       |   69 +++++++++++++++++++++++++++++++++++++++++++--
 fs/proc/proc_misc.c        |    1
 include/linux/hugetlb.h    |    5 +++
 5 files changed, 93 insertions(+), 13 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/i386/mm/hugetlbpage.c current/arch/i386/mm/hugetlbpage.c
--- reference/arch/i386/mm/hugetlbpage.c	2004-04-01 13:37:14.000000000 +0100
+++ current/arch/i386/mm/hugetlbpage.c	2004-04-01 21:54:54.000000000 +0100
@@ -72,6 +72,7 @@ static struct page *alloc_hugetlb_page(v
 		spin_unlock(&htlbpage_lock);
 		return NULL;
 	}
+printk(KERN_WARNING "alloc_hugetlb_page: alloced %08lx\n", (unsigned long) page);
 	htlbpagemem--;
 	spin_unlock(&htlbpage_lock);
 	set_page_count(page, 1);
@@ -282,6 +283,7 @@ static void free_huge_page(struct page *

 	INIT_LIST_HEAD(&page->list);

+printk(KERN_WARNING "free_huge_page: returned %08lx\n", (unsigned long) page);
 	spin_lock(&htlbpage_lock);
 	enqueue_huge_page(page);
 	htlbpagemem++;
@@ -334,6 +336,7 @@ int hugetlb_prefault(struct address_spac
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
 	int ret = 0;
+	struct page *page;

 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
 	BUG_ON(vma->vm_end & ~HPAGE_MASK);
@@ -342,7 +345,6 @@ int hugetlb_prefault(struct address_spac
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
 		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;

 		if (!pte) {
 			ret = -ENOMEM;
@@ -355,30 +357,38 @@ int hugetlb_prefault(struct address_spac
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 		page = find_get_page(mapping, idx);
 		if (!page) {
-			/* charge the fs quota first */
+			/* charge against commitment */
+			ret = hugetlb_charge_page(vma);
+			if (ret)
+				goto out;
+			/* charge the fs quota */
 			if (hugetlb_get_quota(mapping)) {
 				ret = -ENOMEM;
-				goto out;
+				goto undo_charge;
 			}
 			page = alloc_hugetlb_page();
 			if (!page) {
-				hugetlb_put_quota(mapping);
 				ret = -ENOMEM;
-				goto out;
+				goto undo_quota;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
 			unlock_page(page);
-			if (ret) {
-				hugetlb_put_quota(mapping);
-				free_huge_page(page);
-				goto out;
-			}
+			if (ret)
+				goto undo_page;
 		}
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
 	}
 out:
 	spin_unlock(&mm->page_table_lock);
 	return ret;
+
+undo_page:
+	free_huge_page(page);
+undo_quota:
+	hugetlb_put_quota(mapping);
+undo_charge:
+	hugetlb_uncharge_page(vma);
+	goto out;
 }

 static void update_and_free_page(struct page *page)
diff -X /home/apw/lib/vdiff.excl -rupN reference/file current/file
--- reference/file	1970-01-01 01:00:00.000000000 +0100
+++ current/file	2004-04-01 13:37:14.000000000 +0100
@@ -0,0 +1 @@
+this is more text
diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c	2004-03-25 02:43:00.000000000 +0000
+++ current/fs/hugetlbfs/inode.c	2004-04-01 22:41:07.000000000 +0100
@@ -32,6 +32,53 @@
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6

+#define HUGETLBFS_NOACCT (~0UL)
+
+atomic_t hugetlb_committed_space = ATOMIC_INIT(0);
+
+int hugetlb_acct_memory(long delta)
+{
+printk(KERN_WARNING "hugetlb_acct_memory: delta<%ld>\n", delta);
+	atomic_add(delta, &hugetlb_committed_space);
+	if (delta > 0 && atomic_read(&hugetlb_committed_space) >
+			hugetlb_total_pages()) {
+		atomic_add(-delta, &hugetlb_committed_space);
+		return -ENOMEM;
+	}
+	return 0;
+}
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
+
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
@@ -62,11 +109,11 @@ static int hugetlbfs_file_mmap(struct fi
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);

 	down(&inode->i_sem);
+	len = vma_len +	((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 	file_accessed(file);
 	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops = &hugetlb_vm_ops;
 	ret = hugetlb_prefault(mapping, vma);
-	len = vma_len +	((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 	if (ret == 0 && inode->i_size < len)
 		inode->i_size = len;
 	up(&inode->i_sem);
@@ -200,6 +247,11 @@ static void hugetlbfs_delete_inode(struc

 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	if (inode->i_blocks != HUGETLBFS_NOACCT)
+		hugetlb_acct_memory(-(inode->i_blocks *
+					(HPAGE_SIZE / PAGE_SIZE)));
+	else
+		hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));

 	security_inode_delete(inode);

@@ -241,6 +293,11 @@ out_truncate:
 	spin_unlock(&inode_lock);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	if (inode->i_blocks != HUGETLBFS_NOACCT)
+		hugetlb_acct_memory(-(inode->i_blocks *
+					(HPAGE_SIZE / PAGE_SIZE)));
+	else
+		hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));

 	if (sbinfo->free_inodes >= 0) {
 		spin_lock(&sbinfo->stat_lock);
@@ -350,6 +407,10 @@ static int hugetlbfs_setattr(struct dent
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
@@ -710,8 +771,9 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!capable(CAP_IPC_LOCK))
 		return ERR_PTR(-EPERM);

-	if (!is_hugepage_mem_enough(size))
-		return ERR_PTR(-ENOMEM);
+	error = hugetlb_acct_memory(size / PAGE_SIZE);
+	if (error)
+		return ERR_PTR(error);

 	root = hugetlbfs_vfsmount->mnt_root;
 	snprintf(buf, 16, "%lu", hugetlbfs_counter());
@@ -736,6 +798,7 @@ struct file *hugetlb_zero_setup(size_t s
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;
+	inode->i_blocks = HUGETLBFS_NOACCT;
 	file->f_vfsmnt = mntget(hugetlbfs_vfsmount);
 	file->f_dentry = dentry;
 	file->f_mapping = inode->i_mapping;
diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/proc/proc_misc.c current/fs/proc/proc_misc.c
--- reference/fs/proc/proc_misc.c	2004-03-29 12:10:18.000000000 +0100
+++ current/fs/proc/proc_misc.c	2004-04-01 13:37:14.000000000 +0100
@@ -232,6 +232,7 @@ static int meminfo_read_proc(char *page,
 		);

 		len += hugetlb_report_meminfo(page + len);
+		len += hugetlbfs_report_meminfo(page + len);

 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/hugetlb.h current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h	2004-03-29 12:10:22.000000000 +0100
+++ current/include/linux/hugetlb.h	2004-04-01 21:56:56.000000000 +0100
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





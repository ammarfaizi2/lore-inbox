Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbUDAW7S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263291AbUDAW7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:59:18 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:10244 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262911AbUDAW6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:58:37 -0500
Date: Thu, 01 Apr 2004 23:50:59 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ray Bryant <raybry@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <189970944.1080863459@[192.168.0.89]>
In-Reply-To: <184253487.1080857742@[192.168.0.89]>
References: <200403310851.i2V8pkF28306@unix-os.sc.intel.com> <184253487.1080857742@[192.168.0.89]>
X-Mailer: Mulberry/3.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 01 April 2004 22:15 +0100 Andy Whitcroft <apw@shadowen.org> wrote:

> O.k. Here is the latest version of the hugetlb commitment tracking patch
> (hugetlb_tracking_R4).  This now understands the difference between shm
> allocated and mmap allocated and handles them differently.  This should
> fix 1.  We now handle the commitments correctly under quota failures.

Ok.  Here is R5, including all of the architectures hooked to the new
interface.  Plus the spurious debug is gone.

-apw

---
 arch/i386/mm/hugetlbpage.c    |   28 +++++++++++------
 arch/ia64/mm/hugetlbpage.c    |   28 +++++++++++------
 arch/ppc64/mm/hugetlbpage.c   |   28 +++++++++++------
 arch/sh/mm/hugetlbpage.c      |   28 +++++++++++------
 arch/sparc64/mm/hugetlbpage.c |   28 +++++++++++------
 fs/hugetlbfs/inode.c          |   66 ++++++++++++++++++++++++++++++++++++++++--
 fs/proc/proc_misc.c           |    1
 include/linux/hugetlb.h       |    5 +++
 8 files changed, 160 insertions(+), 52 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/i386/mm/hugetlbpage.c current/arch/i386/mm/hugetlbpage.c
--- reference/arch/i386/mm/hugetlbpage.c	2004-04-02 00:38:24.000000000 +0100
+++ current/arch/i386/mm/hugetlbpage.c	2004-04-01 22:58:48.000000000 +0100
@@ -334,6 +334,7 @@ int hugetlb_prefault(struct address_spac
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
 	int ret = 0;
+	struct page *page;

 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
 	BUG_ON(vma->vm_end & ~HPAGE_MASK);
@@ -342,7 +343,6 @@ int hugetlb_prefault(struct address_spac
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
 		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;

 		if (!pte) {
 			ret = -ENOMEM;
@@ -355,30 +355,38 @@ int hugetlb_prefault(struct address_spac
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
diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/ia64/mm/hugetlbpage.c current/arch/ia64/mm/hugetlbpage.c
--- reference/arch/ia64/mm/hugetlbpage.c	2004-04-02 00:38:24.000000000 +0100
+++ current/arch/ia64/mm/hugetlbpage.c	2004-04-02 00:39:22.000000000 +0100
@@ -352,6 +352,7 @@ int hugetlb_prefault(struct address_spac
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
 	int ret = 0;
+	struct page *page;

 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
 	BUG_ON(vma->vm_end & ~HPAGE_MASK);
@@ -360,7 +361,6 @@ int hugetlb_prefault(struct address_spac
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
 		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;

 		if (!pte) {
 			ret = -ENOMEM;
@@ -373,30 +373,38 @@ int hugetlb_prefault(struct address_spac
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

 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/ppc64/mm/hugetlbpage.c current/arch/ppc64/mm/hugetlbpage.c
--- reference/arch/ppc64/mm/hugetlbpage.c	2004-04-02 00:38:24.000000000 +0100
+++ current/arch/ppc64/mm/hugetlbpage.c	2004-04-02 00:45:10.000000000 +0100
@@ -482,6 +482,7 @@ int hugetlb_prefault(struct address_spac
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
 	int ret = 0;
+	struct page *page;

 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON((vma->vm_start % HPAGE_SIZE) != 0);
@@ -491,7 +492,6 @@ int hugetlb_prefault(struct address_spac
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
 		hugepte_t *pte = hugepte_alloc(mm, addr);
-		struct page *page;

 		BUG_ON(!in_hugepage_area(mm->context, addr));

@@ -506,30 +506,38 @@ int hugetlb_prefault(struct address_spac
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 		page = find_get_page(mapping, idx);
 		if (!page) {
-			/* charge the fs quota first */
+ 			/* charge against commitment */
+ 			ret = hugetlb_charge_page(vma);
+ 			if (ret)
+ 				goto out;
+ 			/* charge the fs quota */
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
 		setup_huge_pte(mm, page, pte, vma->vm_flags & VM_WRITE);
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

 /* Because we have an exclusive hugepage region which lies within the
diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/sh/mm/hugetlbpage.c current/arch/sh/mm/hugetlbpage.c
--- reference/arch/sh/mm/hugetlbpage.c	2004-04-02 00:36:59.000000000 +0100
+++ current/arch/sh/mm/hugetlbpage.c	2004-04-02 00:39:45.000000000 +0100
@@ -313,6 +313,7 @@ int hugetlb_prefault(struct address_spac
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
 	int ret = 0;
+	struct page *page;

 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
 	BUG_ON(vma->vm_end & ~HPAGE_MASK);
@@ -321,7 +322,6 @@ int hugetlb_prefault(struct address_spac
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
 		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;

 		if (!pte) {
 			ret = -ENOMEM;
@@ -334,30 +334,38 @@ int hugetlb_prefault(struct address_spac
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
diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/sparc64/mm/hugetlbpage.c current/arch/sparc64/mm/hugetlbpage.c
--- reference/arch/sparc64/mm/hugetlbpage.c	2004-04-02 00:38:24.000000000 +0100
+++ current/arch/sparc64/mm/hugetlbpage.c	2004-04-02 00:39:56.000000000 +0100
@@ -309,6 +309,7 @@ int hugetlb_prefault(struct address_spac
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
 	int ret = 0;
+	struct page *page;

 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
 	BUG_ON(vma->vm_end & ~HPAGE_MASK);
@@ -317,7 +318,6 @@ int hugetlb_prefault(struct address_spac
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
 		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;

 		if (!pte) {
 			ret = -ENOMEM;
@@ -330,30 +330,38 @@ int hugetlb_prefault(struct address_spac
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
diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c	2004-03-25 02:43:00.000000000 +0000
+++ current/fs/hugetlbfs/inode.c	2004-04-01 23:07:02.000000000 +0100
@@ -32,6 +32,52 @@
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
@@ -200,6 +246,11 @@ static void hugetlbfs_delete_inode(struc

 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	if (inode->i_blocks != HUGETLBFS_NOACCT)
+		hugetlb_acct_memory(-(inode->i_blocks *
+					(HPAGE_SIZE / PAGE_SIZE)));
+	else
+		hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));

 	security_inode_delete(inode);

@@ -241,6 +292,11 @@ out_truncate:
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
@@ -350,6 +406,10 @@ static int hugetlbfs_setattr(struct dent
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
@@ -710,8 +770,9 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!capable(CAP_IPC_LOCK))
 		return ERR_PTR(-EPERM);

-	if (!is_hugepage_mem_enough(size))
-		return ERR_PTR(-ENOMEM);
+	error = hugetlb_acct_memory(size / PAGE_SIZE);
+	if (error)
+		return ERR_PTR(error);

 	root = hugetlbfs_vfsmount->mnt_root;
 	snprintf(buf, 16, "%lu", hugetlbfs_counter());
@@ -736,6 +797,7 @@ struct file *hugetlb_zero_setup(size_t s
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;
+	inode->i_blocks = HUGETLBFS_NOACCT;
 	file->f_vfsmnt = mntget(hugetlbfs_vfsmount);
 	file->f_dentry = dentry;
 	file->f_mapping = inode->i_mapping;
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



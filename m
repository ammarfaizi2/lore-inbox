Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266307AbSKLIZ5>; Tue, 12 Nov 2002 03:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbSKLIZS>; Tue, 12 Nov 2002 03:25:18 -0500
Received: from holomorphy.com ([66.224.33.161]:42425 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266310AbSKLIYf>;
	Tue, 12 Nov 2002 03:24:35 -0500
To: linux-kernel@vger.kernel.org
Subject: [11/11] hugetlb: add reference counting to hugetlb_keys
Message-Id: <E18BWPm-0005KQ-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap up the release path by adding proper refcounting of keys.

 arch/i386/kernel/sys_i386.c |    3 +++
 arch/i386/mm/hugetlbpage.c  |   30 +++++++++++++++---------------
 include/linux/hugetlb.h     |    2 ++
 3 files changed, 20 insertions(+), 15 deletions(-)


diff -urpN htlb-2.5.47-10/arch/i386/kernel/sys_i386.c htlb-2.5.47-11/arch/i386/kernel/sys_i386.c
--- htlb-2.5.47-10/arch/i386/kernel/sys_i386.c	2002-11-10 19:28:31.000000000 -0800
+++ htlb-2.5.47-11/arch/i386/kernel/sys_i386.c	2002-11-11 23:26:55.000000000 -0800
@@ -294,14 +294,17 @@ asmlinkage int sys_free_hugepages(unsign
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	struct hugetlb_key *key;
 	int retval;
 
 	vma = find_vma(current->mm, addr);
 	if (!vma || !(vma->vm_flags & VM_HUGETLB) || vma->vm_start != addr)
 		return -EINVAL;
 	down_write(&mm->mmap_sem);
+	key = (struct hugetlb_key *)vma->vm_private_data;
 	retval = do_munmap(vma->vm_mm, addr, vma->vm_end - addr);
 	up_write(&mm->mmap_sem);
+	hugetlb_release_key(key);
 	return retval;
 }
 #else
diff -urpN htlb-2.5.47-10/arch/i386/mm/hugetlbpage.c htlb-2.5.47-11/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-10/arch/i386/mm/hugetlbpage.c	2002-11-11 23:10:20.000000000 -0800
+++ htlb-2.5.47-11/arch/i386/mm/hugetlbpage.c	2002-11-11 23:27:18.000000000 -0800
@@ -31,6 +31,7 @@ static spinlock_t htlbpage_lock = SPIN_L
 
 struct hugetlb_key {
 	struct radix_tree_root tree;
+	atomic_t count;
 	int key;
 	int busy;
 	uid_t uid;
@@ -99,6 +100,7 @@ struct hugetlb_key *alloc_key(int key, u
 					hugetlb_key->gid = current->fsgid;
 					hugetlb_key->mode = prot;
 					hugetlb_key->size = len;
+					atomic_set(&hugetlb_key->count, 1);
 					*new = 1;
 				}
 			}
@@ -114,10 +116,13 @@ struct hugetlb_key *alloc_key(int key, u
 	return hugetlb_key;
 }
 
-static void release_key(struct hugetlb_key *key)
+void hugetlb_release_key(struct hugetlb_key *key)
 {
 	unsigned long index;
-	spin_lock(&htlbpage_lock);
+
+	if (!atomic_dec_and_lock(&key->count, &htlbpage_lock))
+		return;	
+
 	for (index = 0; index < key->size; ++index) {
 		struct page *page = radix_tree_lookup(&key->tree, index);
 		if (!page)
@@ -428,21 +433,20 @@ static int alloc_shared_hugetlb_pages(in
 
 	hugetlb_key = alloc_key(key, len, prot, flag, &newalloc);
 	if (IS_ERR(hugetlb_key)) {
-		retval = PTR_ERR(hugetlb_key);
 		spin_unlock(&htlbpage_lock);
-		goto out_err;
+		return PTR_ERR(hugetlb_key);
 	} else
 		spin_unlock(&htlbpage_lock);
 
 	addr = do_mmap_pgoff(NULL, addr, len, (unsigned long) prot,
 			MAP_NORESERVE|MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0);
 	if (IS_ERR((void *) addr))
-		goto freeinode;
+		goto out_release;
 
 	vma = find_vma(mm, addr);
 	if (!vma) {
 		retval = -EINVAL;
-		goto freeinode;
+		goto out_release;
 	}
 
 	retval = prefault_key(hugetlb_key, vma);
@@ -451,7 +455,7 @@ static int alloc_shared_hugetlb_pages(in
 
 	vma->vm_flags |= (VM_HUGETLB | VM_RESERVED);
 	vma->vm_ops = &hugetlb_vm_ops;
-	spin_unlock(&mm->page_table_lock);
+	vma->vm_private_data = hugetlb_key;
 	spin_lock(&htlbpage_lock);
 	clear_key_busy(hugetlb_key);
 	spin_unlock(&htlbpage_lock);
@@ -464,15 +468,11 @@ out:
 		zap_hugepage_range(vma, vma->vm_start, vma->vm_end - vma->vm_start);
 		vma->vm_end = raddr;
 	}
-	spin_unlock(&mm->page_table_lock);
+	spin_lock(&mm->page_table_lock);
 	do_munmap(mm, vma->vm_start, len);
-	if (newalloc)
-		goto freeinode;
-	return retval;
-out_err: spin_unlock(&htlbpage_lock);
-freeinode:
-	if (newalloc)
-		release_key(hugetlb_key);
+	spin_unlock(&mm->page_table_lock);
+out_release:
+	hugetlb_release_key(hugetlb_key);
 	return retval;
 }
 
diff -urpN htlb-2.5.47-10/include/linux/hugetlb.h htlb-2.5.47-11/include/linux/hugetlb.h
--- htlb-2.5.47-10/include/linux/hugetlb.h	2002-11-10 19:28:14.000000000 -0800
+++ htlb-2.5.47-11/include/linux/hugetlb.h	2002-11-11 23:29:45.000000000 -0800
@@ -4,6 +4,7 @@
 #ifdef CONFIG_HUGETLB_PAGE
 
 struct ctl_table;
+struct hugetlb_key;
 
 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
 {
@@ -17,6 +18,7 @@ void zap_hugepage_range(struct vm_area_s
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
 void huge_page_release(struct page *);
+void hugetlb_release_key(struct hugetlb_key *);
 int hugetlb_report_meminfo(char *);
 
 extern int htlbpage_max;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSKUWAy>; Thu, 21 Nov 2002 17:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbSKUWAx>; Thu, 21 Nov 2002 17:00:53 -0500
Received: from fmr03.intel.com ([143.183.121.5]:37342 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S264857AbSKUWAt>; Thu, 21 Nov 2002 17:00:49 -0500
Message-ID: <3DDD58C1.9020503@unix-os.sc.intel.com>
Date: Thu, 21 Nov 2002 14:05:53 -0800
From: Rohit Seth <rseth@unix-os.sc.intel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@digeo.com,
       torvalds@transmeta.com, rohit.seth@intel.com
Subject: hugetlb page patch for 2.5.48-bug fixes
Content-Type: multipart/mixed;
 boundary="------------080100060507020703050208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080100060507020703050208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus, Andrew,

Attached is the hugetlbpage patch for 2.5.48 containing following main 
changes:

1) Bug fixes (mainly in the unsuccessful attempts of hugepages).
2) Removal of Radix Tree field in key structure (as it is not needed).
3) Include the IPC_LOCK for permission to use hugepages.
4) Increment the key_counts during forks.

thanks,
rohit



--------------080100060507020703050208
Content-Type: text/plain;
 name="patch2548.1121"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2548.1121"

--- linux-2.5.48/include/linux/hugetlb.h	Sun Nov 17 20:29:45 2002
+++ linux-2.5.48.work//include/linux/hugetlb.h	Thu Nov 21 11:49:57 2002
@@ -4,7 +4,17 @@
 #ifdef CONFIG_HUGETLB_PAGE
 
 struct ctl_table;
-struct hugetlb_key;
+struct hugetlb_key {
+	struct page *root;
+	loff_t size;
+	atomic_t count;
+	spinlock_t lock;
+	int key;
+	int busy;
+	uid_t uid;
+	gid_t gid;
+	umode_t mode;
+};
 
 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
 {
--- linux-2.5.48/arch/i386/mm/hugetlbpage.c	Sun Nov 17 20:29:55 2002
+++ linux-2.5.48.work/arch/i386/mm/hugetlbpage.c	Thu Nov 21 12:12:18 2002
@@ -19,6 +19,8 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
+#include <linux/sysctl.h>
+
 static long    htlbpagemem;
 int     htlbpage_max;
 static long    htlbzone_pages;
@@ -29,18 +31,6 @@
 
 #define MAX_ID 	32
 
-struct hugetlb_key {
-	struct radix_tree_root tree;
-	atomic_t count;
-	spinlock_t lock;
-	int key;
-	int busy;
-	uid_t uid;
-	gid_t gid;
-	umode_t mode;
-	loff_t size;
-};
-
 static struct hugetlb_key htlbpagek[MAX_ID];
 
 static void mark_key_busy(struct hugetlb_key *hugetlb_key)
@@ -81,7 +71,7 @@
 		spin_lock(&htlbpage_lock);
 		hugetlb_key = find_key(key);
 		if (!hugetlb_key) {
-			if (!capable(CAP_SYS_ADMIN) || !in_group_p(0))
+			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_IPC_LOCK) && !in_group_p(0))
 				hugetlb_key = ERR_PTR(-EPERM);
 			else if (!(flag & IPC_CREAT))
 				hugetlb_key = ERR_PTR(-ENOENT);
@@ -96,7 +86,7 @@
 					hugetlb_key = &htlbpagek[i];
 					mark_key_busy(hugetlb_key);
 					hugetlb_key->key = key;
-					INIT_RADIX_TREE(&hugetlb_key->tree, GFP_ATOMIC);
+					hugetlb_key->root = NULL;
 					hugetlb_key->uid = current->fsuid;
 					hugetlb_key->gid = current->fsgid;
 					hugetlb_key->mode = prot;
@@ -107,7 +97,6 @@
 			hugetlb_key = ERR_PTR(-EAGAIN);
 			spin_unlock(&htlbpage_lock);
 		} else if (check_size_prot(hugetlb_key, len, prot, flag) < 0) {
-			hugetlb_key->key = 0;
 			hugetlb_key = ERR_PTR(-EINVAL);
 		} 
 	} while (hugetlb_key == ERR_PTR(-EAGAIN));
@@ -120,7 +109,10 @@
 {
 	unsigned long index;
 	unsigned long max_idx;
+	struct page *page, *prev;
 
+	if (key == NULL)
+		return;
 	if (!atomic_dec_and_test(&key->count)) {
 		spin_lock(&htlbpage_lock);
 		clear_key_busy(key);
@@ -129,16 +121,19 @@
 	}
 
 	max_idx = (key->size >> HPAGE_SHIFT);
+	page = key->root;
 	for (index = 0; index < max_idx; ++index) {
-		struct page *page = radix_tree_lookup(&key->tree, index);
 		if (!page)
 			continue;
-		huge_page_release(page);
+		prev = page;
+		page = (struct page *)page->private;
+		prev->private = 0UL;
+		huge_page_release(prev);
 	}
 	spin_lock(&htlbpage_lock);
 	key->key = 0;
 	clear_key_busy(key);
-	INIT_RADIX_TREE(&key->tree, GFP_ATOMIC);
+	key->root = NULL;
 	spin_unlock(&htlbpage_lock);
 }
 
@@ -247,7 +242,7 @@
 		vma->vm_end = end;
 	}
 	spin_unlock(&mm->page_table_lock);
-      out_error1:
+out_error1:
 	return -1;
 }
 
@@ -259,7 +254,10 @@
 	struct page *ptepage;
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;
+	struct hugetlb_key *key = vma->vm_private_data;
 
+	if ( key )
+		atomic_inc(&key->count);
 	while (addr < end) {
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
@@ -352,6 +350,8 @@
 	spin_unlock(&htlbpage_lock);
 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
+		if (pte_none(*pte))
+			continue;
 		page = pte_page(*pte);
 		huge_page_release(page);
 		pte_clear(pte);
@@ -381,25 +381,10 @@
 	return 0;
 }
 
-struct page *key_find_page(struct hugetlb_key *key, unsigned long index)
-{
-	struct page *page = radix_tree_lookup(&key->tree, index);
-	if (page)
-		get_page(page);
-	return page;
-}
-
-int key_add_page(struct page *page, struct hugetlb_key *key, unsigned long index)
-{
-	int error = radix_tree_insert(&key->tree, index, page);
-	if (!error)
-		get_page(page);
-	return error;
-}
-
-static int prefault_key(struct hugetlb_key *key, struct vm_area_struct *vma)
+static int prefault_key(struct hugetlb_key *key, struct vm_area_struct *vma, unsigned long *temp)
 {
 	struct mm_struct *mm = current->mm;
+	struct page *page, *prev;
 	unsigned long addr;
 	int ret = 0;
 
@@ -408,21 +393,18 @@
 
 	spin_lock(&mm->page_table_lock);
 	spin_lock(&key->lock);
+	prev = page = key->root;
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
 		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
 
 		if (!pte) {
+			spin_unlock(&key->lock);
 			ret = -ENOMEM;
 			goto out;
 		}
 		if (!pte_none(*pte))
 			continue;
 
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = key_find_page(key, idx);
 		if (!page) {
 			page = alloc_hugetlb_page();
 			if (!page) {
@@ -430,13 +412,20 @@
 				ret = -ENOMEM;
 				goto out;
 			}
-			key_add_page(page, key, idx);
+			if (key->root == NULL)
+				key->root = page;
+			else
+				prev->private = (unsigned long)page;
 		}
+		get_page(page);
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		prev = page;
+		page = (struct page *)page->private;
 	}
 	spin_unlock(&key->lock);
 out:
 	spin_unlock(&mm->page_table_lock);
+	*temp = addr;
 	return ret;
 }
 
@@ -446,6 +435,7 @@
 	struct vm_area_struct *vma;
 	struct hugetlb_key *hugetlb_key;
 	int retval = -ENOMEM;
+	unsigned long temp;
 
 	hugetlb_key = alloc_key(key, len, prot, flag );
 	spin_unlock(&htlbpage_lock);
@@ -455,17 +445,18 @@
 	addr = do_mmap_pgoff(NULL, addr, len, (unsigned long) prot,
 			MAP_NORESERVE|MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0);
 	if (IS_ERR((void *) addr))
-		goto out_release;
+		goto out;
 
 	vma = find_vma(mm, addr);
 	if (!vma) {
 		retval = -EINVAL;
-		goto out_release;
+		goto out;
 	}
 
-	retval = prefault_key(hugetlb_key, vma);
+	retval = prefault_key(hugetlb_key, vma, &temp);
+	addr = temp;
 	if (retval)
-		goto out;
+		goto out_release;
 
 	vma->vm_flags |= (VM_HUGETLB | VM_RESERVED);
 	vma->vm_ops = &hugetlb_vm_ops;
@@ -474,7 +465,7 @@
 	clear_key_busy(hugetlb_key);
 	spin_unlock(&htlbpage_lock);
 	return retval;
-out:
+out_release:
 	if (addr > vma->vm_start) {
 		unsigned long raddr;
 		raddr = vma->vm_end;
@@ -482,10 +473,8 @@
 		zap_hugepage_range(vma, vma->vm_start, vma->vm_end - vma->vm_start);
 		vma->vm_end = raddr;
 	}
-	spin_lock(&mm->page_table_lock);
 	do_munmap(mm, vma->vm_start, len);
-	spin_unlock(&mm->page_table_lock);
-out_release:
+out:
 	hugetlb_release_key(hugetlb_key);
 	return retval;
 }
@@ -533,10 +522,8 @@
 
 static int alloc_private_hugetlb_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
 {
-	if (!capable(CAP_SYS_ADMIN)) {
-		if (!in_group_p(0))
-			return -EPERM;
-	}
+	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_IPC_LOCK) && !in_group_p(0))
+		return -EPERM;
 	addr = do_mmap_pgoff(NULL, addr, len, prot,
 			MAP_NORESERVE|MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, 0);
 	if (IS_ERR((void *) addr))
--- linux-2.5.48/arch/i386/kernel/sys_i386.c	Sun Nov 17 20:29:56 2002
+++ linux-2.5.48.work/arch/i386/kernel/sys_i386.c	Thu Nov 21 12:01:08 2002
@@ -294,17 +294,17 @@
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct hugetlb_key *key;
 	int retval;
 
-	vma = find_vma(current->mm, addr);
-	if (!vma || !(vma->vm_flags & VM_HUGETLB) || vma->vm_start != addr)
-		return -EINVAL;
 	down_write(&mm->mmap_sem);
-	key = (struct hugetlb_key *)vma->vm_private_data;
+	vma = find_vma(current->mm, addr);
+	if (!vma || !(vma->vm_flags & VM_HUGETLB) || vma->vm_start != addr) {
+		retval =  -EINVAL;
+		goto out;
+	}
 	retval = do_munmap(vma->vm_mm, addr, vma->vm_end - addr);
+out:
 	up_write(&mm->mmap_sem);
-	hugetlb_release_key(key);
 	return retval;
 }
 #else

--------------080100060507020703050208--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbSKMDao>; Tue, 12 Nov 2002 22:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbSKMDao>; Tue, 12 Nov 2002 22:30:44 -0500
Received: from fmr03.intel.com ([143.183.121.5]:44238 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S266735AbSKMDam>; Tue, 12 Nov 2002 22:30:42 -0500
Message-ID: <3DD1C88E.3080802@unix-os.sc.intel.com>
Date: Tue, 12 Nov 2002 19:35:42 -0800
From: Rohit Seth <rseth@unix-os.sc.intel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hugetlb patch for 2.5.47 + ALL_PATCHES_FROM_BILL
Content-Type: multipart/mixed;
 boundary="------------080805000002050105000107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080805000002050105000107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attahched is the patch for 2.5.47+12_patches_from_William_Irwin.  These 
are essentially the bug fixes and bit of clean up.

thanks,
rohit


--------------080805000002050105000107
Content-Type: text/plain;
 name="patch.2.5.47"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.2.5.47"

--- linux-2.5.47/arch/i386/mm/hugetlbpage.c	Tue Nov 12 18:30:44 2002
+++ linux-2.5.47work/arch/i386/mm/hugetlbpage.c	Tue Nov 12 18:27:53 2002
@@ -73,7 +73,7 @@
 /*
  * Call without htlbpage_lock, returns with htlbpage_lock held.
  */
-struct hugetlb_key *alloc_key(int key, unsigned long len, int prot, int flag, int *new)
+struct hugetlb_key *alloc_key(int key, unsigned long len, int prot, int flag)
 {
 	struct hugetlb_key *hugetlb_key;
 
@@ -101,8 +101,6 @@
 					hugetlb_key->gid = current->fsgid;
 					hugetlb_key->mode = prot;
 					hugetlb_key->size = len;
-					atomic_set(&hugetlb_key->count, 1);
-					*new = 1;
 				}
 			}
 		} else if (key_busy(hugetlb_key)) {
@@ -111,26 +109,35 @@
 		} else if (check_size_prot(hugetlb_key, len, prot, flag) < 0) {
 			hugetlb_key->key = 0;
 			hugetlb_key = ERR_PTR(-EINVAL);
-		} else
-			*new = 0;
+		} 
 	} while (hugetlb_key == ERR_PTR(-EAGAIN));
+	if (!IS_ERR(hugetlb_key))
+		atomic_inc(&hugetlb_key->count);
 	return hugetlb_key;
 }
 
 void hugetlb_release_key(struct hugetlb_key *key)
 {
 	unsigned long index;
+	unsigned long max_idx;
 
-	if (!atomic_dec_and_lock(&key->count, &htlbpage_lock))
+	if (!atomic_dec_and_test(&key->count)) {
+		spin_lock(&htlbpage_lock);
+		clear_key_busy(key);
+		spin_unlock(&htlbpage_lock);
 		return;	
+	}
 
-	for (index = 0; index < key->size; ++index) {
+	max_idx = (key->size >> HPAGE_SHIFT);
+	for (index = 0; index < max_idx; ++index) {
 		struct page *page = radix_tree_lookup(&key->tree, index);
 		if (!page)
 			continue;
 		huge_page_release(page);
 	}
+	spin_lock(&htlbpage_lock);
 	key->key = 0;
+	clear_key_busy(key);
 	INIT_RADIX_TREE(&key->tree, GFP_ATOMIC);
 	spin_unlock(&htlbpage_lock);
 }
@@ -334,16 +341,23 @@
 	unsigned long address;
 	pte_t *pte;
 	struct page *page;
+	struct hugetlb_key *key = vma->vm_private_data;
 
 	BUG_ON(start & (HPAGE_SIZE - 1));
 	BUG_ON(end & (HPAGE_SIZE - 1));
 
+	spin_lock(&htlbpage_lock);
+	if (key ) 
+		mark_key_busy(key);
+	spin_unlock(&htlbpage_lock);
 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
 		page = pte_page(*pte);
 		huge_page_release(page);
 		pte_clear(pte);
 	}
+	if (key)
+		hugetlb_release_key(key);
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
@@ -417,7 +431,6 @@
 				goto out;
 			}
 			key_add_page(page, key, idx);
-			unlock_page(page);
 		}
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
 	}
@@ -433,14 +446,11 @@
 	struct vm_area_struct *vma;
 	struct hugetlb_key *hugetlb_key;
 	int retval = -ENOMEM;
-	int newalloc = 0;
 
-	hugetlb_key = alloc_key(key, len, prot, flag, &newalloc);
-	if (IS_ERR(hugetlb_key)) {
-		spin_unlock(&htlbpage_lock);
+	hugetlb_key = alloc_key(key, len, prot, flag );
+	spin_unlock(&htlbpage_lock);
+	if (IS_ERR(hugetlb_key)) 
 		return PTR_ERR(hugetlb_key);
-	} else
-		spin_unlock(&htlbpage_lock);
 
 	addr = do_mmap_pgoff(NULL, addr, len, (unsigned long) prot,
 			MAP_NORESERVE|MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0);

--------------080805000002050105000107--


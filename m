Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266359AbSKLJ1d>; Tue, 12 Nov 2002 04:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbSKLJ1d>; Tue, 12 Nov 2002 04:27:33 -0500
Received: from holomorphy.com ([66.224.33.161]:11706 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266359AbSKLJ1b>;
	Tue, 12 Nov 2002 04:27:31 -0500
Date: Tue, 12 Nov 2002 01:31:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [12/11] hugetlb: fix lack of radix tree locking
Message-ID: <20021112093150.GQ23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20021112091640.GZ22031@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112091640.GZ22031@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 01:16:40AM -0800, William Lee Irwin III wrote:
> +	for (i = 0; i < MAX_ID; ++i) {
> +		atomic_init(&htlbpagek[i].count);
> +		spinlock_init(&htlbpagek[i].lock);
> +	}

erm, wtf?


This adds a spinlock to each individual key, initializes it and the
atomic counter, and uses it when manipulating the radix tree.

 hugetlbpage.c |    8 ++++++++
 1 files changed, 8 insertions(+)


diff -urpN htlb-2.5.47-11/arch/i386/mm/hugetlbpage.c htlb-2.5.47-12/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-11/arch/i386/mm/hugetlbpage.c	2002-11-11 23:27:18.000000000 -0800
+++ htlb-2.5.47-12/arch/i386/mm/hugetlbpage.c	2002-11-12 00:52:31.000000000 -0800
@@ -32,6 +32,7 @@ static spinlock_t htlbpage_lock = SPIN_L
 struct hugetlb_key {
 	struct radix_tree_root tree;
 	atomic_t count;
+	spinlock_t lock;
 	int key;
 	int busy;
 	uid_t uid;
@@ -392,6 +393,7 @@ static int prefault_key(struct hugetlb_k
 	BUG_ON(vma->vm_end & ~HPAGE_MASK);
 
 	spin_lock(&mm->page_table_lock);
+	spin_lock(&key->lock);
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
 		pte_t *pte = huge_pte_alloc(mm, addr);
@@ -410,6 +412,7 @@ static int prefault_key(struct hugetlb_k
 		if (!page) {
 			page = alloc_hugetlb_page();
 			if (!page) {
+				spin_unlock(&key->lock);
 				ret = -ENOMEM;
 				goto out;
 			}
@@ -418,6 +421,7 @@ static int prefault_key(struct hugetlb_k
 		}
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
 	}
+	spin_unlock(&key->lock);
 out:
 	spin_unlock(&mm->page_table_lock);
 	return ret;
@@ -625,6 +629,10 @@ static int __init hugetlb_init(void)
 	}
 	htlbpage_max = htlbpagemem = htlbzone_pages = i;
 	printk("Total HugeTLB memory allocated, %ld\n", htlbpagemem);
+	for (i = 0; i < MAX_ID; ++i) {
+		atomic_set(&htlbpagek[i].count, 0);
+		spin_lock_init(&htlbpagek[i].lock);
+	}
 	return 0;
 }
 module_init(hugetlb_init);

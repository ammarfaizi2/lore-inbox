Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129303AbRBBTI0>; Fri, 2 Feb 2001 14:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129304AbRBBTIQ>; Fri, 2 Feb 2001 14:08:16 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:37243
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129303AbRBBTH6>; Fri, 2 Feb 2001 14:07:58 -0500
Date: Fri, 2 Feb 2001 20:07:49 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Guard mm->rss with page_table_lock (2.4.1)
Message-ID: <20010202200749.B870@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch tries to fix the potential rss accounting race where we
change mm->rss without holding page_table_lock.

My reasoning for the correctness of the patch below is as follows.
First I cover the lock pairs added by the patch (top to bottom) 
and then the places it does not touch.


Added spinlocks:

memory.c::zap_page_range: The spin_unlock is moved to later in
  the function but not past any exit paths.
memory.c::do_swap_page: Is called exclusively from handle_pte_fault
  which drops page_table_lock before calling do_swap_page.
memory.c:: do_anonymous_page: Is called exclusively from do_no_page
  which again is called exclusively from handle_pte_fault which
  drops the page_table_lock before calling do_no_page.
memory.c:: do_no_page: See above.

mmap.c:: exit_mmap: The unlock is moved to later in the function 
  but not across any branches or exit paths.



Places where rss is modified not touched by the patch:

vmscan.c::try_to_swap_out: called from swap_out_pmd <- 
   swap_out_pgd <- swap_out_vma <- swap_out_mm which grabs 
   the lock.

swapfile.c::unuse_pte: called from unuse_pmd <- unuse_pgd <- 
   unuse_vma <- unuse_process which grabs the lock.
          ::do_wp_page: lock already held.


It applies against ac12 and 2.4.1. It has been running on my
workstation for the last four days doing various normal workloads
without problems in addition to the tests from Quintelas memtest
suite. It should be noted that this patch has _not_ been tested on
a SMP machine (since I do not own one). Feedback on that would be
nice.

Comments welcomed. And thanks goes to Rik van Riel for pointing 
out the obvious and then explaining it when I paid it no heed.




diff -uar linux-2.4.1-clean/mm/memory.c linux/mm/memory.c
--- linux-2.4.1-clean/mm/memory.c	Thu Feb  1 20:46:03 2001
+++ linux/mm/memory.c	Fri Feb  2 19:38:03 2001
@@ -377,7 +377,6 @@
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&mm->page_table_lock);
 	/*
 	 * Update rss for the mm_struct (not necessarily current->mm)
 	 * Notice that rss is an unsigned long.
@@ -386,6 +385,7 @@
 		mm->rss -= freed;
 	else
 		mm->rss = 0;
+	spin_unlock(&mm->page_table_lock);
 }
 
 
@@ -1038,7 +1038,9 @@
 		flush_icache_page(vma, page);
 	}
 
+	spin_lock(&mm->page_table_lock);
 	mm->rss++;
+	spin_unlock(&mm->page_table_lock);
 
 	pte = mk_pte(page, vma->vm_page_prot);
 
@@ -1072,7 +1074,9 @@
 			return -1;
 		clear_user_highpage(page, addr);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+		spin_lock(&mm->page_table_lock);
 		mm->rss++;
+		spin_unlock(&mm->page_table_lock);
 		flush_page_to_ram(page);
 	}
 	set_pte(page_table, entry);
@@ -1111,7 +1115,9 @@
 		return 0;
 	if (new_page == NOPAGE_OOM)
 		return -1;
+	spin_lock(&mm->page_table_lock);
 	++mm->rss;
+	spin_unlock(&mm->page_table_lock);
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
 	 * due to the bad i386 page protection. But it's valid
diff -uar linux-2.4.1-clean/mm/mmap.c linux/mm/mmap.c
--- linux-2.4.1-clean/mm/mmap.c	Thu Feb  1 20:46:03 2001
+++ linux/mm/mmap.c	Fri Feb  2 19:38:03 2001
@@ -879,8 +879,8 @@
 	spin_lock(&mm->page_table_lock);
 	mpnt = mm->mmap;
 	mm->mmap = mm->mmap_avl = mm->mmap_cache = NULL;
-	spin_unlock(&mm->page_table_lock);
 	mm->rss = 0;
+	spin_unlock(&mm->page_table_lock);
 	mm->total_vm = 0;
 	mm->locked_vm = 0;
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

I've never had major knee surgery on any other part of my body.
-Winston Bennett, University of Kentucky basketball forward
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

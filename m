Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132643AbQLHVAB>; Fri, 8 Dec 2000 16:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132790AbQLHU7v>; Fri, 8 Dec 2000 15:59:51 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:53869
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132643AbQLHU7n>; Fri, 8 Dec 2000 15:59:43 -0500
Date: Fri, 8 Dec 2000 21:29:10 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm->rss is modified without page_table_lock held
Message-ID: <20001208212910.E599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch moves the page_table_lock in mm/* to cover the
modification of mm->rss in 240-test12-pre7. It was inspired by a 
similar patch from davej(?) which covered too much, AFAIR. The item 
is on Tytso's ToDo list.

Please comment.


diff -Naur linux-240-t12-pre7-clean/mm/memory.c linux/mm/memory.c
--- linux-240-t12-pre7-clean/mm/memory.c	Fri Dec  8 00:45:04 2000
+++ linux/mm/memory.c	Fri Dec  8 00:48:26 2000
@@ -371,7 +371,6 @@
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&mm->page_table_lock);
 	/*
 	 * Update rss for the mm_struct (not necessarily current->mm)
 	 * Notice that rss is an unsigned long.
@@ -380,6 +379,7 @@
 		mm->rss -= freed;
 	else
 		mm->rss = 0;
+	spin_unlock(&mm->page_table_lock);
 }
 
 
@@ -1076,7 +1076,9 @@
 		flush_icache_page(vma, page);
 	}
 
+	spin_lock(&mm->page_table_lock);
 	mm->rss++;
+	spin_unlock(&mm->page_table_lock);
 
 	pte = mk_pte(page, vma->vm_page_prot);
 
@@ -1110,7 +1112,9 @@
 			return -1;
 		clear_user_highpage(page, addr);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+		spin_lock(&mm->page_table_lock);
 		mm->rss++;
+		spin_unlock(&mm->page_table_lock);
 		flush_page_to_ram(page);
 	}
 	set_pte(page_table, entry);
@@ -1149,7 +1153,9 @@
 		return 0;
 	if (new_page == NOPAGE_OOM)
 		return -1;
+	spin_lock(&mm->page_table_lock);
 	++mm->rss;
+	spin_unlock(&mm->page_table_lock);
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
 	 * due to the bad i386 page protection. But it's valid
diff -Naur linux-240-t12-pre7-clean/mm/mmap.c linux/mm/mmap.c
--- linux-240-t12-pre7-clean/mm/mmap.c	Wed Nov 22 22:41:45 2000
+++ linux/mm/mmap.c	Fri Dec  8 00:48:26 2000
@@ -889,8 +889,8 @@
 	spin_lock(&mm->page_table_lock);
 	mpnt = mm->mmap;
 	mm->mmap = mm->mmap_avl = mm->mmap_cache = NULL;
-	spin_unlock(&mm->page_table_lock);
 	mm->rss = 0;
+	spin_unlock(&mm->page_table_lock);
 	mm->total_vm = 0;
 	mm->locked_vm = 0;
 	while (mpnt) {
diff -Naur linux-240-t12-pre7-clean/mm/swapfile.c linux/mm/swapfile.c
--- linux-240-t12-pre7-clean/mm/swapfile.c	Sat Nov  4 23:27:17 2000
+++ linux/mm/swapfile.c	Fri Dec  8 00:48:26 2000
@@ -231,7 +231,9 @@
 	set_pte(dir, pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 	get_page(page);
+	spin_lock(&vma->vm_mm->page_table_lock);
 	++vma->vm_mm->rss;
+	spin_unlock(&vma->vm_mm->page_table_lock);
 }
 
 static inline void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
diff -Naur linux-240-t12-pre7-clean/mm/vmscan.c linux/mm/vmscan.c
--- linux-240-t12-pre7-clean/mm/vmscan.c	Fri Dec  8 00:45:04 2000
+++ linux/mm/vmscan.c	Fri Dec  8 00:48:26 2000
@@ -98,7 +98,9 @@
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
 		UnlockPage(page);
+		spin_lock(&mm->page_table_lock);
 		mm->rss--;
+		spin_unlock(&mm->page_table_lock);
 		flush_tlb_page(vma, address);
 		deactivate_page(page);
 		page_cache_release(page);

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

You know how dumb the average guy is?  Well, by  definition, half
of them are even dumber than that.
            -- J.R. "Bob" Dobbs 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129605AbQK0U0d>; Mon, 27 Nov 2000 15:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129857AbQK0U0X>; Mon, 27 Nov 2000 15:26:23 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:16486
        "HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
        id <S129582AbQK0U0E>; Mon, 27 Nov 2000 15:26:04 -0500
Date: Mon, 27 Nov 2000 20:48:00 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: mm->rss modified without the page_table_lock held (revisited)
Message-ID: <20001127204800.C606@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

(The following (with minor differences in the text) was sent to linux-kernel
Thursday. I have received no response and the item is still on Teds list
of todo (www version anyway) so I'll risk a limb to the Quake monster :)
by sending this to you.)

Some time ago there was a thread about subject and a patch was posted
(by davej?). It was rejected because of the vmlist_modify_{un}lock
mess (AFAIR) and nothing has been done since. The patch below tries
to remake the attempt to move mm->rss inside the page_table_lock in mm/*. 

I noticed that mm->rss is also modified in fs/{exec.c,binfmt_aout.c,
binfmt_elf.c} without the lock being held. Am I missing something or
are these buggy too? I have no idea of what assumptions can be made
in these code paths so I have not tried to produce patches for them.

Patch against 240-test11. Please comment.


diff -uar linux-240-t11/mm/memory.c linux/mm/memory.c
--- linux-240-t11/mm/memory.c	Wed Nov 22 22:41:45 2000
+++ linux/mm/memory.c	Thu Nov 23 21:45:58 2000
@@ -369,7 +369,6 @@
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&mm->page_table_lock);
 	/*
 	 * Update rss for the mm_struct (not necessarily current->mm)
 	 * Notice that rss is an unsigned long.
@@ -378,6 +377,7 @@
 		mm->rss -= freed;
 	else
 		mm->rss = 0;
+	spin_unlock(&mm->page_table_lock);
 }
 
 
@@ -1074,7 +1074,9 @@
 		flush_icache_page(vma, page);
 	}
 
+	spin_lock(&mm->page_table_lock);
 	mm->rss++;
+	spin_unlock(&mm->page_table_lock);
 
 	pte = mk_pte(page, vma->vm_page_prot);
 
@@ -1113,7 +1115,9 @@
 			return -1;
 		clear_user_highpage(page, addr);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+		spin_lock(&mm->page_table_lock);
 		mm->rss++;
+		spin_unlock(&mm->page_table_lock);
 		flush_page_to_ram(page);
 	}
 	set_pte(page_table, entry);
@@ -1152,7 +1156,9 @@
 		return 0;
 	if (new_page == NOPAGE_OOM)
 		return -1;
+	spin_lock(&mm->page_table_lock);
 	++mm->rss;
+	spin_unlock(&mm->page_table_lock);
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
 	 * due to the bad i386 page protection. But it's valid
diff -uar linux-240-t11/mm/mmap.c linux/mm/mmap.c
--- linux-240-t11/mm/mmap.c	Wed Nov 22 22:41:45 2000
+++ linux/mm/mmap.c	Thu Nov 23 21:45:58 2000
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
diff -uar linux-240-t11/mm/swapfile.c linux/mm/swapfile.c
--- linux-240-t11/mm/swapfile.c	Sat Nov  4 23:27:17 2000
+++ linux/mm/swapfile.c	Thu Nov 23 21:45:58 2000
@@ -231,7 +231,9 @@
 	set_pte(dir, pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 	get_page(page);
+	spin_lock(&vma->vm_mm->page_table_lock);
 	++vma->vm_mm->rss;
+	spin_unlock(&vma->vm_mm->page_table_lock);
 }
 
 static inline void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
diff -uar linux-240-t11/mm/vmscan.c linux/mm/vmscan.c
--- linux-240-t11/mm/vmscan.c	Wed Nov 22 22:41:45 2000
+++ linux/mm/vmscan.c	Thu Nov 23 21:45:58 2000
@@ -95,7 +95,9 @@
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

Gates' Law: Every 18 months, the speed of software halves
  -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129299AbRA2VYP>; Mon, 29 Jan 2001 16:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRA2VYG>; Mon, 29 Jan 2001 16:24:06 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:3952
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129299AbRA2VXt>; Mon, 29 Jan 2001 16:23:49 -0500
Date: Mon, 29 Jan 2001 22:23:37 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] guard mm->rss with page_table_lock (241p11)
Message-ID: <20010129222337.F603@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch tries to fix the potential rss accounting race where we
fiddle with mm->rss without holding the page_table_lock.

In addition to the places this patch touches there are some places
in fs/ where mm->rss is touched. But I am not sure of the finer
points of this code, so perhaps somebody else could have a look?
The files are binfmt_aout.c, binfmt_elf.c, and exec.c.

It applies against ac12 and 241p11.


Please comment. Or else I will continue to sumbit it :)



diff -aur linux-2.4.1-pre11-clean/mm/memory.c linux/mm/memory.c
--- linux-2.4.1-pre11-clean/mm/memory.c	Sun Jan 28 20:53:13 2001
+++ linux/mm/memory.c	Sun Jan 28 22:43:04 2001
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
diff -aur linux-2.4.1-pre11-clean/mm/mmap.c linux/mm/mmap.c
--- linux-2.4.1-pre11-clean/mm/mmap.c	Sat Dec 30 18:35:19 2000
+++ linux/mm/mmap.c	Sun Jan 28 22:43:04 2001
@@ -879,8 +879,8 @@
 	spin_lock(&mm->page_table_lock);
 	mpnt = mm->mmap;
 	mm->mmap = mm->mmap_avl = mm->mmap_cache = NULL;
-	spin_unlock(&mm->page_table_lock);
 	mm->rss = 0;
+	spin_unlock(&mm->page_table_lock);
 	mm->total_vm = 0;
 	mm->locked_vm = 0;
 	while (mpnt) {
diff -aur linux-2.4.1-pre11-clean/mm/swapfile.c linux/mm/swapfile.c
--- linux-2.4.1-pre11-clean/mm/swapfile.c	Fri Dec 29 23:07:24 2000
+++ linux/mm/swapfile.c	Sun Jan 28 22:43:04 2001
@@ -231,7 +231,9 @@
 	set_pte(dir, pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 	get_page(page);
+	spin_lock(&vma->vm_mm->page_table_lock);
 	++vma->vm_mm->rss;
+	spin_unlock(&vma->vm_mm->page_table_lock);
 }
 
 static inline void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
diff -aur linux-2.4.1-pre11-clean/mm/vmscan.c linux/mm/vmscan.c
--- linux-2.4.1-pre11-clean/mm/vmscan.c	Sun Jan 28 20:53:13 2001
+++ linux/mm/vmscan.c	Mon Jan 29 22:09:18 2001
@@ -72,7 +72,9 @@
 		swap_duplicate(entry);
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
+		spin_lock(&mm->page_table_lock);
 		mm->rss--;
+		spin_unlock(&mm->page_table_lock);
 		if (!page->age)
 			deactivate_page(page);
 		UnlockPage(page);

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

I've never had major knee surgery on any other part of my body.
-Winston Bennett, University of Kentucky basketball forward
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbQKDWpH>; Sat, 4 Nov 2000 17:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbQKDWo6>; Sat, 4 Nov 2000 17:44:58 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:36663
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129131AbQKDWor>; Sat, 4 Nov 2000 17:44:47 -0500
Date: Sun, 5 Nov 2000 00:37:08 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: "David S. Miller" <davem@redhat.com>
Cc: tytso@MIT.EDU, davej@suse.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: BUG FIX?: mm->rss is modified in some places without holding the  page_table_lock
Message-ID: <20001105003708.C762@jaquet.dk>
In-Reply-To: <200011031456.JAA21492@tsx-prime.MIT.EDU> <200011031451.GAA10924@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200011031451.GAA10924@pizda.ninka.net>; from davem@redhat.com on Fri, Nov 03, 2000 at 06:51:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 06:51:05AM -0800, David S. Miller wrote:
>    Are you saying that the original bug report may not actually be a
>    problem?  Is ms->rss actually protected in _all_ of the right
>    places, but people got confused because of the syntactic sugar?
> 
> I don't know if all of them are ok, most are.
> 

Would this do? This is a subset of Davej's patch. I also noted that
fs/{exec.c,binfmt_aout.c,binfmt_elf.c} modifies rss without holding
the lock. I think exec.c needs it, but am at a loss whether the 
binfmt_* does too. The second patch below adds the lock to fs/exec.c.

Comments?

diff -ura linux-240-t10-clean/mm/memory.c linux/mm/memory.c
--- linux-240-t10-clean/mm/memory.c	Sat Nov  4 23:27:17 2000
+++ linux/mm/memory.c	Sun Nov  5 00:13:59 2000
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
diff -ura linux-240-t10-clean/mm/mmap.c linux/mm/mmap.c
--- linux-240-t10-clean/mm/mmap.c	Sat Nov  4 23:27:17 2000
+++ linux/mm/mmap.c	Sat Nov  4 23:53:49 2000
@@ -843,8 +843,8 @@
 	spin_lock(&mm->page_table_lock);
 	mpnt = mm->mmap;
 	mm->mmap = mm->mmap_avl = mm->mmap_cache = NULL;
-	spin_unlock(&mm->page_table_lock);
 	mm->rss = 0;
+	spin_unlock(&mm->page_table_lock);
 	mm->total_vm = 0;
 	mm->locked_vm = 0;
 	while (mpnt) {
diff -ura linux-240-t10-clean/mm/swapfile.c linux/mm/swapfile.c
--- linux-240-t10-clean/mm/swapfile.c	Sat Nov  4 23:27:17 2000
+++ linux/mm/swapfile.c	Sun Nov  5 00:19:15 2000
@@ -231,7 +231,9 @@
 	set_pte(dir, pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 	get_page(page);
+	spin_lock(&vma->vm_mm->page_table_lock);
 	++vma->vm_mm->rss;
+	spin_unlock(&vma->vm_mm->page_table_lock);
 }
 
 static inline void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
diff -ura linux-240-t10-clean/mm/vmscan.c linux/mm/vmscan.c
--- linux-240-t10-clean/mm/vmscan.c	Sat Nov  4 23:27:17 2000
+++ linux/mm/vmscan.c	Sun Nov  5 00:19:48 2000
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



Second patch:

--- linux-240-t10-clean/fs/exec.c	Sat Nov  4 23:27:14 2000
+++ linux/fs/exec.c	Sat Nov  4 23:55:37 2000
@@ -324,7 +324,9 @@
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
+			spin_lock(mm->page_table_lock);
 			current->mm->rss++;
+			spin_unlock(mm->page_table_lock);
 			put_dirty_page(current,page,stack_base);
 		}
 		stack_base += PAGE_SIZE;

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Duct tape is like the force; it has a light side and a dark side, and
it holds the universe together.
  -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

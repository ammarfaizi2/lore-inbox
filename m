Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130070AbRAHUYZ>; Mon, 8 Jan 2001 15:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130007AbRAHUYP>; Mon, 8 Jan 2001 15:24:15 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:2119
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129387AbRAHUYE>; Mon, 8 Jan 2001 15:24:04 -0500
Date: Mon, 8 Jan 2001 21:23:47 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: afei@jhu.edu, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: MM/VM todo list
Message-ID: <20010108212347.B850@jaquet.dk>
In-Reply-To: <Pine.GSO.4.05.10101081230560.23656-100000@aa.eps.jhu.edu> <Pine.LNX.4.21.0101081535330.21675-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0101081535330.21675-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Jan 08, 2001 at 03:36:23PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 03:36:23PM -0200, Rik van Riel wrote:
> I have not taken^Whad the time to check the kernel tree
> and see if the RSS counting has indeed been made safe
> everywhere.

I have posted the one below a couple of times without it making
it in. If you like ot please fold it into your mm patchset. It
is against 2.4.0.

In addition to the places this patch touches there are some places
in fs/ where mm->rss is touched. But I am not sure of the finer
points of this code, so perhaps somebody else could have a look?
The files are binfmt_aout.c, binfmt_elf.c, and exec.c.


diff -aur linux-2.4.0-clean/mm/memory.c linux/mm/memory.c
--- linux-2.4.0-clean/mm/memory.c	Mon Jan  1 19:37:41 2001
+++ linux/mm/memory.c	Mon Jan  8 21:09:08 2001
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
 
 
@@ -1034,7 +1034,9 @@
 		flush_icache_page(vma, page);
 	}
 
+	spin_lock(&mm->page_table_lock);
 	mm->rss++;
+	spin_unlock(&mm->page_table_lock);
 
 	pte = mk_pte(page, vma->vm_page_prot);
 
@@ -1068,7 +1070,9 @@
 			return -1;
 		clear_user_highpage(page, addr);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+		spin_lock(&mm->page_table_lock);
 		mm->rss++;
+		spin_unlock(&mm->page_table_lock);
 		flush_page_to_ram(page);
 	}
 	set_pte(page_table, entry);
@@ -1107,7 +1111,9 @@
 		return 0;
 	if (new_page == NOPAGE_OOM)
 		return -1;
+	spin_lock(&mm->page_table_lock);
 	++mm->rss;
+	spin_unlock(&mm->page_table_lock);
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
 	 * due to the bad i386 page protection. But it's valid
diff -aur linux-2.4.0-clean/mm/mmap.c linux/mm/mmap.c
--- linux-2.4.0-clean/mm/mmap.c	Sat Dec 30 18:35:19 2000
+++ linux/mm/mmap.c	Mon Jan  8 21:09:08 2001
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
diff -aur linux-2.4.0-clean/mm/swapfile.c linux/mm/swapfile.c
--- linux-2.4.0-clean/mm/swapfile.c	Fri Dec 29 23:07:24 2000
+++ linux/mm/swapfile.c	Mon Jan  8 21:09:08 2001
@@ -231,7 +231,9 @@
 	set_pte(dir, pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 	get_page(page);
+	spin_lock(&vma->vm_mm->page_table_lock);
 	++vma->vm_mm->rss;
+	spin_unlock(&vma->vm_mm->page_table_lock);
 }
 
 static inline void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
diff -aur linux-2.4.0-clean/mm/vmscan.c linux/mm/vmscan.c
--- linux-2.4.0-clean/mm/vmscan.c	Thu Jan  4 05:45:26 2001
+++ linux/mm/vmscan.c	Mon Jan  8 21:09:08 2001
@@ -100,7 +100,9 @@
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
 		UnlockPage(page);
+		spin_lock(&mm->page_table_lock);
 		mm->rss--;
+		spin_unlock(&mm->page_table_lock);
 		deactivate_page(page);
 		page_cache_release(page);
 out_failed:

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Television is called a medium because it is neither rare nor well-done. 
  -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

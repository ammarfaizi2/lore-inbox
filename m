Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbRBMDUL>; Mon, 12 Feb 2001 22:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129198AbRBMDUB>; Mon, 12 Feb 2001 22:20:01 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:37240 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S129054AbRBMDTp>; Mon, 12 Feb 2001 22:19:45 -0500
Message-ID: <3A88A6ED.6B51BCA9@mvista.com>
Date: Mon, 12 Feb 2001 19:15:57 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rasmus Andersen <rasmus@jaquet.dk>
CC: Rik van Riel <riel@conectiva.com.br>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] guard mm->rss with page_table_lock (241p11)
In-Reply-To: <20010129222337.F603@jaquet.dk> <Pine.LNX.4.21.0101291929120.1321-100000@duckman.distro.conectiva> <20010129224311.H603@jaquet.dk>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me if I am off base here, but wouldn't an atomic operation be
better here.  There are atomic inc/dec and add/sub macros for this.  It
just seems that that is all that is needed here (from inspection of the
patch).

George


Rasmus Andersen wrote:
> 
> On Mon, Jan 29, 2001 at 07:30:01PM -0200, Rik van Riel wrote:
> > On Mon, 29 Jan 2001, Rasmus Andersen wrote:
> >
> > > Please comment. Or else I will continue to sumbit it :)
> >
> > The following will hang the kernel on SMP, since you're
> > already holding the spinlock here. Try compiling with
> > CONFIG_SMP and see what happens...
> 
> You are right. Sloppy research by me :(
> 
> New patch below with the vmscan part removed.
> 
> diff -aur linux-2.4.1-pre11-clean/mm/memory.c linux/mm/memory.c
> --- linux-2.4.1-pre11-clean/mm/memory.c Sun Jan 28 20:53:13 2001
> +++ linux/mm/memory.c   Sun Jan 28 22:43:04 2001
> @@ -377,7 +377,6 @@
>                 address = (address + PGDIR_SIZE) & PGDIR_MASK;
>                 dir++;
>         } while (address && (address < end));
> -       spin_unlock(&mm->page_table_lock);
>         /*
>          * Update rss for the mm_struct (not necessarily current->mm)
>          * Notice that rss is an unsigned long.
> @@ -386,6 +385,7 @@
>                 mm->rss -= freed;
>         else
>                 mm->rss = 0;
> +       spin_unlock(&mm->page_table_lock);
>  }
> 
> 
> @@ -1038,7 +1038,9 @@
>                 flush_icache_page(vma, page);
>         }
> 
> +       spin_lock(&mm->page_table_lock);
>         mm->rss++;
> +       spin_unlock(&mm->page_table_lock);
> 
>         pte = mk_pte(page, vma->vm_page_prot);
> 
> @@ -1072,7 +1074,9 @@
>                         return -1;
>                 clear_user_highpage(page, addr);
>                 entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
> +               spin_lock(&mm->page_table_lock);
>                 mm->rss++;
> +               spin_unlock(&mm->page_table_lock);
>                 flush_page_to_ram(page);
>         }
>         set_pte(page_table, entry);
> @@ -1111,7 +1115,9 @@
>                 return 0;
>         if (new_page == NOPAGE_OOM)
>                 return -1;
> +       spin_lock(&mm->page_table_lock);
>         ++mm->rss;
> +       spin_unlock(&mm->page_table_lock);
>         /*
>          * This silly early PAGE_DIRTY setting removes a race
>          * due to the bad i386 page protection. But it's valid
> diff -aur linux-2.4.1-pre11-clean/mm/mmap.c linux/mm/mmap.c
> --- linux-2.4.1-pre11-clean/mm/mmap.c   Sat Dec 30 18:35:19 2000
> +++ linux/mm/mmap.c     Sun Jan 28 22:43:04 2001
> @@ -879,8 +879,8 @@
>         spin_lock(&mm->page_table_lock);
>         mpnt = mm->mmap;
>         mm->mmap = mm->mmap_avl = mm->mmap_cache = NULL;
> -       spin_unlock(&mm->page_table_lock);
>         mm->rss = 0;
> +       spin_unlock(&mm->page_table_lock);
>         mm->total_vm = 0;
>         mm->locked_vm = 0;
>         while (mpnt) {
> diff -aur linux-2.4.1-pre11-clean/mm/swapfile.c linux/mm/swapfile.c
> --- linux-2.4.1-pre11-clean/mm/swapfile.c       Fri Dec 29 23:07:24 2000
> +++ linux/mm/swapfile.c Sun Jan 28 22:43:04 2001
> @@ -231,7 +231,9 @@
>         set_pte(dir, pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
>         swap_free(entry);
>         get_page(page);
> +       spin_lock(&vma->vm_mm->page_table_lock);
>         ++vma->vm_mm->rss;
> +       spin_unlock(&vma->vm_mm->page_table_lock);
>  }
> 
>  static inline void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
> 
> --
>         Rasmus(rasmus@jaquet.dk)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/

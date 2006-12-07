Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163543AbWLGWgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163543AbWLGWgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163546AbWLGWgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:36:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48638 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163543AbWLGWga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:36:30 -0500
Date: Thu, 7 Dec 2006 14:36:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Singleton <dsingleton@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: new procfs memory analysis feature
Message-Id: <20061207143611.7a2925e2.akpm@osdl.org>
In-Reply-To: <45789124.1070207@mvista.com>
References: <45789124.1070207@mvista.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 14:09:40 -0800
David Singleton <dsingleton@mvista.com> wrote:

> 
> Andrew,
> 
>     this implements a feature for memory analysis tools to go along with 
> smaps.
> It shows reference counts for individual pages instead of aggregate 
> totals for a given VMA.
> It helps memory analysis tools determine how well pages are being 
> shared, or not,
> in a shared libraries, etc.
> 
>    The per page information is presented in /proc/<pid>/pagemaps.
> 

I think the concept is not a bad one, frankly - this requirement arises
frequently.  What bugs me is that it only displays the mapcount and
dirtiness.  Perhaps there are other things which people want to know.  I'm
not sure what they would be though.

I wonder if it would be insane to display the info via a filesystem:

	cat /mnt/pagemaps/$(pidof crond)/pgd0/pmd1/pte45

Probably it would.

> Index: linux-2.6.18/Documentation/filesystems/proc.txt

Against 2.6.18?  I didn't know you could still buy copies of that ;)

This patch's changelog should include sample output.

Your email client wordwraps patches, and it replaces tabs with spaces.

> ...
>
> +static void pagemaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> +                               unsigned long addr, unsigned long end,
> +                               struct seq_file *m)
> +{
> +       pte_t *pte, ptent;
> +       spinlock_t *ptl;
> +       struct page *page;
> +       int mapcount = 0;
> +
> +       pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +       do {
> +               ptent = *pte;
> +               if (pte_present(ptent)) {
> +                       page = vm_normal_page(vma, addr, ptent);
> +                       if (page) {
> +                               if (pte_dirty(ptent))
> +                                       mapcount = -page_mapcount(page);
> +                               else
> +                                       mapcount = page_mapcount(page);
> +                       } else {
> +                               mapcount = 1;
> +                       }
> +               }
> +               seq_printf(m, " %d", mapcount);
> +
> +       } while (pte++, addr += PAGE_SIZE, addr != end);

Well that's cute.  As long as both seq_file and pte-pages are of size
PAGE_SIZE, and as long as pte's are more than three bytes, this will not
overflow the seq_file output buffer.

hm.  Unless the pages are all dirty and the mapcounts are all 10000.  I
think it will overflow then?

> +
> +static inline void pagemaps_pmd_range(struct vm_area_struct *vma, pud_t 
> *pud,
> +                               unsigned long addr, unsigned long end,
> +                               struct seq_file *m)
> +{
> +       pmd_t *pmd;
> +       unsigned long next;
> +
> +       pmd = pmd_offset(pud, addr);
> +       do {
> +               next = pmd_addr_end(addr, end);
> +               if (pmd_none_or_clear_bad(pmd))
> +                       continue;
> +               pagemaps_pte_range(vma, pmd, addr, next, m);
> +       } while (pmd++, addr = next, addr != end);
> +}
> +
> +static inline void pagemaps_pud_range(struct vm_area_struct *vma, pgd_t 
> *pgd,
> +                               unsigned long addr, unsigned long end,
> +                               struct seq_file *m)
> +{
> +       pud_t *pud;
> +       unsigned long next;
> +
> +       pud = pud_offset(pgd, addr);
> +       do {
> +               next = pud_addr_end(addr, end);
> +               if (pud_none_or_clear_bad(pud))
> +                       continue;
> +               pagemaps_pmd_range(vma, pud, addr, next, m);
> +       } while (pud++, addr = next, addr != end);
> +}
> +
> +static inline void pagemaps_pgd_range(struct vm_area_struct *vma,
> +                               unsigned long addr, unsigned long end,
> +                               struct seq_file *m)
> +{
> +       pgd_t *pgd;
> +       unsigned long next;
> +
> +       pgd = pgd_offset(vma->vm_mm, addr);
> +       do {
> +               next = pgd_addr_end(addr, end);
> +               if (pgd_none_or_clear_bad(pgd))
> +                       continue;
> +               pagemaps_pud_range(vma, pgd, addr, next, m);
> +       } while (pgd++, addr = next, addr != end);
> +}

I think that's our eighth open-coded pagetable walker.  Apparently they are
all slightly different.  Perhaps we shouild do something about that one
day.



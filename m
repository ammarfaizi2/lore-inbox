Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVAQV1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVAQV1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbVAQV1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:27:54 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:37813 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262881AbVAQV1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:27:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Py+atd8jGSpID+VHQyeRJWsf8WWSxifJJTTHjKOvbe4asra4s0Gt4RKZ7vErh+35TNd5eGqlj9xm+oNVYARRkPa93bUM3gEUMX/SviwUAu/S7zugy50niz69n90KiJlI6GqE+/frT0wbKoHJWPNDCHqbXYKGbv/FIiJ4wpu9aY8=
Message-ID: <3f250c710501171327632eaa3e@mail.gmail.com>
Date: Mon, 17 Jan 2005 17:27:41 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] A new entry for /proc
Cc: Andrew Morton <akpm@osdl.org>, Mauricio Lin <mauricio.lin@indt.org.br>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       Edjard.Mota@indt.org.br
In-Reply-To: <20050117173023.GA22202@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c7105010613115554b9d9@mail.gmail.com>
	 <20050106202339.4f9ba479.akpm@osdl.org>
	 <3f250c7105011414466f22fc37@mail.gmail.com>
	 <20050114154209.6b712e55.akpm@osdl.org>
	 <3f250c71050117100332774211@mail.gmail.com>
	 <3f250c71050117110241dfc46c@mail.gmail.com>
	 <20050117173023.GA22202@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tosatti,


On Mon, 17 Jan 2005 15:30:23 -0200, Marcelo Tosatti
<marcelo.tosatti@cyclades.com> wrote:
> 
> Hi Mauricio,
> 
> On Mon, Jan 17, 2005 at 03:02:14PM -0400, Mauricio Lin wrote:
> > Hi Andrew,
> >
> > I figured out the error. This patch works for others editors as well.
> 
> <snip>
> 
> > diff -uprN linux-2.6.10/fs/proc/task_mmu.c linux-2.6.10-smaps/fs/proc/task_mmu.c
> > --- linux-2.6.10/fs/proc/task_mmu.c   2004-12-24 17:34:01.000000000 -0400
> > +++ linux-2.6.10-smaps/fs/proc/task_mmu.c     2005-01-17 14:55:17.000000000 -0400
> > @@ -81,6 +81,76 @@ static int show_map(struct seq_file *m,
> >       return 0;
> >  }
> >
> > +static void resident_mem_size(struct mm_struct *mm,
> > +                           unsigned long start_address,
> > +                           unsigned long end_address,
> > +                           unsigned long *size)
> > +{
> > +     pgd_t *pgd;
> > +     pmd_t *pmd;
> > +     pte_t *ptep, pte;
> > +     unsigned long each_page;
> > +
> > +     for (each_page = start_address; each_page < end_address;
> > +          each_page += PAGE_SIZE) {
> > +             pgd = pgd_offset(mm, each_page);
> > +             if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
> > +                     continue;
> > +
> > +             pmd = pmd_offset(pgd, each_page);
> > +
> > +             if (pmd_none(*pmd))
> > +                     continue;
> > +
> > +             if (unlikely(pmd_bad(*pmd)))
> > +                     continue;
> > +
> > +             if (pmd_present(*pmd)) {
> > +                     ptep = pte_offset_map(pmd, each_page);
> > +                     if (!ptep)
> > +                             continue;
> > +                     pte = *ptep;
> > +                     pte_unmap(ptep);
> > +                     if (pte_present(pte))
> > +                             *size += PAGE_SIZE;
> > +             }
> > +     }
> > +}
> 
> You want to update your patch to handle the new 4level pagetables which introduces
> a new indirection table: the PUD.
> 
> Check 2.6.11-rc1 - mm/rmap.c.
OK, I will check the new pagetable included in 2.6.11-rc1 and change
the navigation algorithm of page table entries.

Thanks.

BR,

Mauricio Lin.

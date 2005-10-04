Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVJDVa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVJDVa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVJDVa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:30:57 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:29575 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964986AbVJDVa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:30:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] [RFC][PATCH][Fix] swsusp: Yet another attempt to fix Bug #4959
Date: Tue, 4 Oct 2005 23:31:54 +0200
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200510011813.54755.rjw@sisk.pl> <200510041909.00714.ak@suse.de>
In-Reply-To: <200510041909.00714.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510042331.54902.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks a lot for the comments.

On Tuesday, 4 of October 2005 19:09, Andi Kleen wrote:
> 
> On Saturday 01 October 2005 18:13, Rafael J. Wysocki wrote:
> 
> > Your comments, criticisms and (preferably) suggestions will be appreciated.
> 
> First always write a full description of the problem and the rationale
> of the change and a overview what it changes. Also please add Signed-off-by 
> lines.

I forgot to add the Signed-off-by line, sorry.

I will add the full problem description etc. to the next iteration of the patch.

> 
> > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > +extern unsigned long resume_table_start, resume_table_end;
> 
> These should be all in some include. Adding externs in C files is near
> always wrong because it avoids cross file type checking.

I will do that.
 
> Also the convention is to add _pfn to variables that are in PFNs,
> otherwise it's full addresses.

I will do that too.

> > 10:40:03.000000000 +0200 +++
> > linux-2.6.14-rc3/arch/x86_64/mm/init.c	2005-10-01 14:31:34.000000000 +0200
> > @@ -260,6 +260,9 @@
> >  	pmds = (end + PMD_SIZE - 1) >> PMD_SHIFT;
> >  	tables = round_up(puds * sizeof(pud_t), PAGE_SIZE) +
> >  		 round_up(pmds * sizeof(pmd_t), PAGE_SIZE);
> > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > +	tables += tables;
> > +#endif
> 
> This needs a comment. Also I would still prefer if it was allocated
> only when suspend is actually attempted.

I will add a comment here.

The problem with allocating the resume page tables is that I have to make sure
they won't be overwritten by swsusp during resume.  There are three possible
solutions to it:
(1) to use static arrays of predefined size marked as __nosavedata,
(2) to allocate the page tables as early as in the init code so that they always
end up at the same physical addresses and (later on) mark them as nosave
for swsusp,
(3) to place the page tables in the areas of memory that won't be modified
by swsusp.

The downsides of (1) are that by using it I'd artificially limit the allowed
size of the suspend image and I'd waste some page frames on systems with
relatively small RAM.  Also I'd have to modify phys_pud_init() to use it for
populating these page tables.

The downside of (3) is that I do not know which pages will be overwritten by
swsusp until the image is loaded into memory, because the addresses that
will be affected by swsusp are stored within the image.  Thus in that case I
can only allocate the resume page tables right before copying the image
pages to their original locations.  This requires the use of GFP_ATOMIC
allocations that may fail, and the suitable pages have to be cherry picked
from the pages returned by the kernel (some of them will be overwritten
by swsusp).  The failure of a memory allocation at that time, although not
very probable, would lead to a resume failure and the loss of the system's
state from before suspend, so this is not an ideal solution.  Moreover,
in that case I'd have to modify phys_pud_init() to use it for populating the
resume page tables.

The only downside of (2) is that it keeps some 4KB page frames permanently
unavailable to the system.  However, for a typical systems the number of
them is limited (it's (1 page per every started 1GB of RAM) + 2, or 3 pages
for a system with no more than 1GB of RAM).  On the other hand, in that
case I can use the original phys_pud_init() to populate the resume page
tables and the required code changes are quite limited in scope.  Therefore
I've chosen this one.

> >  	table_start = find_e820_area(0x8000, __pa_symbol(&_text), tables);
> >  	if (table_start == -1UL)
> > @@ -272,6 +275,7 @@
> >  /* Setup the direct mapping of the physical memory at PAGE_OFFSET.
> >     This runs before bootmem is initialized and gets pages directly from
> > the physical memory. To access them they are temporarily mapped. */
> > +#ifndef CONFIG_SOFTWARE_SUSPEND
> >  void __init init_memory_mapping(unsigned long start, unsigned long end)
> >  {
> >  	unsigned long next;
> > @@ -307,6 +311,69 @@
> >  	       table_start<<PAGE_SHIFT,
> >  	       table_end<<PAGE_SHIFT);
> >  }
> > +#else
> > +
> > +extern pgd_t resume_level4_pgt[];
> 
> These should be in some include again.

OK

> I don't like it that you duplicated the function fully. Is that really 
> needed?

Not really, but otherwise I'll have to use a bunch of #ifdefs in the function
body.  I'll do that in the next iteration of the patch.

Thanks again,
Rafael

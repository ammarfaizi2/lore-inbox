Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315249AbSD3AoT>; Mon, 29 Apr 2002 20:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315250AbSD3AoS>; Mon, 29 Apr 2002 20:44:18 -0400
Received: from [195.223.140.120] ([195.223.140.120]:57441 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315249AbSD3AoR>; Mon, 29 Apr 2002 20:44:17 -0400
Date: Tue, 30 Apr 2002 02:43:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020430024354.C26174@dualathlon.random>
In-Reply-To: <20020427004641.L19278@dualathlon.random> <Pine.LNX.4.21.0204292349330.23113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 12:00:50AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sat, 27 Apr 2002, Andrea Arcangeli wrote:
> 
> > correct. This should fix it:
> > 
> > --- 2.4.19pre7aa2/include/asm-alpha/mmzone.h.~1~	Fri Apr 26 10:28:28 2002
> > +++ 2.4.19pre7aa2/include/asm-alpha/mmzone.h	Sat Apr 27 00:30:02 2002
> > @@ -106,8 +106,8 @@
> >  #define kern_addr_valid(kaddr)	test_bit(LOCAL_MAP_NR(kaddr), \
> >  					 NODE_DATA(KVADDR_TO_NID(kaddr))->valid_addr_bitmap)
> >  
> > -#define virt_to_page(kaddr)	(ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr))
> > -#define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)
> > +#define virt_to_page(kaddr)	(KVADDR_TO_NID((unsigned long) kaddr) < MAX_NUMNODES ? ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr) : 0)
> > +#define VALID_PAGE(page)	((page) != NULL)
> >  
> >  #ifdef CONFIG_NUMA
> >  #ifdef CONFIG_NUMA_SCHED
> 
> I'd prefer if VALID_PAGE would go away completely, that test was almost
> always to late. What about the patch below, it even reduces the code size

it is _always_ too late indeed, I definitely agree with your proposal to
change the common code API, yours is a much saner API. But that's a
common code change call, my object was to fix the arch part without
changing the common code, and after all my patch will work exactly the
same as yours, it's just that you put the page != NULL check explicit
and I still use VALID_PAGE instead. You can skip the overflow-check when
we know the vaddr or the pte to match with a valid ram page, so it's a
bit faster than my fix with discontigmem enabled. I'm not sure if for
2.4 it worth to change that given that my two liner arch-contained patch
will also work flawlessy. I've just quite a lots of stuff pending in 2.4
that makes some huge difference to users, so I tend to prefer to left
the stuff that doesn't make difference to users for 2.5 only (it's a
cleanup plus a minor discontigmem optimization after all). So I
recommend you to push it to Linus after fixing the below bugs.

> --- include/asm-i386/page.h	24 Feb 2002 23:11:41 -0000	1.1.1.3
> +++ include/asm-i386/page.h	29 Apr 2002 21:09:09 -0000
> @@ -132,7 +132,10 @@ static __inline__ int get_order(unsigned
>  #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
>  #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
>  #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
> -#define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
> +#define virt_to_valid_page(kaddr) ({ \
> +	unsigned long __paddr = __pa(kaddr); \
> +	__paddr < max_mapnr ? mem_map + (__paddr >> PAGE_SHIFT) : NULL; \
> +})
>  
>  #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
>  				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> Index: include/asm-i386/pgtable-2level.h
> ===================================================================
> RCS file: /usr/src/cvsroot/linux-2.5/include/asm-i386/pgtable-2level.h,v
> retrieving revision 1.1.1.1
> diff -u -p -r1.1.1.1 pgtable-2level.h
> --- include/asm-i386/pgtable-2level.h	26 Nov 2001 19:29:55 -0000	1.1.1.1
> +++ include/asm-i386/pgtable-2level.h	29 Apr 2002 21:13:29 -0000
> @@ -57,6 +57,7 @@ static inline pmd_t * pmd_offset(pgd_t *
>  #define ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte_low, 0))
>  #define pte_same(a, b)		((a).pte_low == (b).pte_low)
>  #define pte_page(x)		(mem_map+((unsigned long)(((x).pte_low >> PAGE_SHIFT))))
> +#define pte_valid_page(x)	(pte_val(x) < max_mapnr ? pte_page(x) : NULL)
>  #define pte_none(x)		(!(x).pte_low)
>  #define __mk_pte(page_nr,pgprot) __pte(((page_nr) << PAGE_SHIFT) | pgprot_val(pgprot))
>  
> Index: include/asm-i386/pgtable-3level.h
> ===================================================================
> RCS file: /usr/src/cvsroot/linux-2.5/include/asm-i386/pgtable-3level.h,v
> retrieving revision 1.1.1.1
> diff -u -p -r1.1.1.1 pgtable-3level.h
> --- include/asm-i386/pgtable-3level.h	26 Nov 2001 19:29:55 -0000	1.1.1.1
> +++ include/asm-i386/pgtable-3level.h	29 Apr 2002 21:13:08 -0000
> @@ -87,6 +87,7 @@ static inline int pte_same(pte_t a, pte_
>  }
>  
>  #define pte_page(x)	(mem_map+(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT))))
> +#define pte_valid_page(x) (pte_val(x) < max_mapnr ? pte_page(x) : NULL)
>  #define pte_none(x)	(!(x).pte_low && !(x).pte_high)
>  

map_mapnr is a pfn, not a physaddr, you're off of 2^PAGE_SHIFT, fix is
trivial of course.

Andrea

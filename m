Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUDAJln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUDAJlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:41:36 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:5260 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262356AbUDAJlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:41:05 -0500
Message-ID: <406BD67E.8AF22D69@nospam.org>
Date: Thu, 01 Apr 2004 10:44:46 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@BULL.NET
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Migrate pages from a ccNUMA node to another
References: <4063F581.ACC5C511@nospam.org>
			 <1080321646.31638.105.camel@nighthawk>  <40695C68.4A5F551E@nospam.org> <1080662328.10037.48.camel@nighthawk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Thank you for your remarks.

Sure, I'll do my best to comply with the coding style of the community.

Dave Hansen wrote:
> Before anything else, please take a long look at
> Documentation/CodingStyle.  Pay particular attention to the column
> width, indenting, and function sections.

Shell I really stick to the width of 80 characters ?
I have got 89, yet several other files already are much wider.

By the indenting issues, do you mean (not) breaking lines like these below ?

			if ((pte_val(*pte) & _PFN_MASK) !=
							(*p & _PFN_MASK))

(I do have TABs = 8 spaces.)

Cutting the functions into smaller pieces - I'll try to do my best.

> One of the best things about your code is that it uses a lot of
> architecture-independent functions and data structures.  The page table
> walks in your patch, for instance, would work on any Linux
> architecture.  However, all of this code is in the ia64 arc.  Why?  Will
> other NUMA architectures not need this page migration functionality?

I made an effort to write it as architecture independent as possible
(I guess only the SAVE_ITC - STORE_DELAY macro pair is to be re-written.)
As I have not even seen any other NUMA machine - I would not post a code that
no one ever tried on the other architectures.

> Also, although it's great
> while you're developing a patch, it's best to try and refrain from
> documenting things in comments things that are already a non-tricky part
> of the way that things already work:
> //
> // "pte_page->mapping" points at the victim process'es "mm_struct"
> //
> These comments really just take up space and reduce readability.

This one was for myself :-)

It is difficult to find the golden mean. E.g. if I have not inserted
a comment here:

	mm = current->mm;
	//
	// Actually, there is no need to grab "mm" because it is ours, wont go
	// away in the mean time. As we do not want to ask questions when
	// releasing it...
	// It is safe just to increment the counter: it is ours.
	//
	atomic_inc(&mm->mm_users);

I think people could have asked why on the Earth I incremented "current->mm->mm_users".
Or another example:

	//
	// "get_task_mm()" includes "task_lock()" that "nests both inside and outside of
	// read_lock(&tasklist_lock)" - as a note in "sched.h" states.
	//

As there is no "locking guide", at least I make a note why I think I'm safe.

(I think the main goals are efficiency and quality: how much effort it takes to
add a new functionality, to correct a bug or simply to understand the code;
how much chance we've got not to crash the system.
In the old golden ages, there were some few gurus who knew the code by hart.
It was efficient for them not to waste time on "useless stuff". Now as the
Linux community becomes larger and larger, the meaning what the efficiency is
has changed. I think the efficiency should mean how easily people can understand,
add, change, correct things. How can I be efficient if need to resolve puzzles ?
No problem with solving puzzles, it's an intellectual challenge. But how can I know
if some "stuff" is there intentionally or by chance ? Or I just misunderstood the
puzzle ? The quality requirement is against solving puzzles.

Most of my comments are "synchronization points" for those who want to understand
my code and "statements" for those who want to double check if I've missed a point.

Another OS that "must not be named" includes thousands of ASSERT()-s and assert()-s
(see also the JFS of Linux) and the lower case assert()-s are kept even for
non debug mode. Should not include Linux lost of similar "statements" ?)

> I find the comments inside of function and macro calls a bit hard to
> read:
> STORE_DELAY(/* in */ unlock_time, /* out */ new_page_unlock);

I think there is a conceptual problem here, e.g.:

	a = 1; b = 2;
	Foo(a); Foo_2(&b);
	c = a + b;		// Is still a == 1 and b == 2 ?

I just read through the code: o.k. we call a "functionality" Foo(a) - assuming
it is a speaking name - I can see more or less what it does; but is "a" sill equal
to 1 at the 3rd line ?
Don't know. If Foo() is a function, then "a" has not been changed, if Foo() is a
macro - who knows ? As far as "b" and Foo_2() are concerned, "&" is
a more than warning that "b" gets modified.
I have to warn the reader "by hand" that an argument gets modified.
It is more "space efficient" as I wrote than writing as:

	/* Warning: "new_page_unlock" is going to be changed */
	STORE_DELAY(unlock_time, new_page_unlock);

> I think every VM hacker has a couple of these functions stashed around
> in various patches for debugging, but they're not really something that
> belongs in the kernel.  In general, you should try to remove debugging
> code before posting a patch.

If you want to print out a VMA, where is the debug service ?
I agree this is not best place in my code. As the print out routines should
be kept coherent with the definitions of the respective structures, they
should be some static functions in the .h files.
I'll remove them but we still need some official stuff.

I stopped my source navigator after it has dug up the 1000th "...DEBUG..." :-)

> +       case _SIZEOF_STATISTICS_:
> +               rc =  *(long long *) &_statistics_sizes;
> +               break;
> 
> I'm sure the statistics are very important, but they're a bit
> intrusive.  Can you separate that code out into a file by itself?  Are
> they even something that a user would want when they're running
> normally, or is it another debugging feature?

As our "AI" is very much experimental, I really do not know how much
this information is useful. Neither the HW assisted nor the application
driven version knows how many pages are movable, how many of them cannot
be handled at all by my migration mechanism (e.g. you have a SysV SHM).
Other error information or knowing how much it costs can be a feed back
for the "AI". Probably it is useful wen we tune the profile for an
application. We need more experience.

> +migrate_virt_addr_range(
> ...
> +       u.ll = syscall(__NR_page_migrate, _VA_RANGE_MIGRATE_,
> +                      address, length, node, pid);
> ...
> +}
> Making syscalls from inside of the kernel is strongly discouraged.  I'm
> not sure what you're trying to do there.  You might want to look at some
> existing code like sys_mmap() vs do_mmap().

The wrapper functions like this are after an "#if !defined(__KERNEL__)"

As "types.h" also contains "#ifdef __KERNEL__"...

> +#define        __VA(pgdi, pmdi, ptei)  (((pgdi) >> (PAGE_SHIFT - 6)) << 61 |           \
> +                               ((pgdi) & ((PTRS_PER_PGD >> 3) - 1)) << PGDIR_SHIFT |   \
> +                               (pmdi) << PMD_SHIFT | (ptei) << PAGE_SHIFT)
> 
> There are magic numbers galore in this macro.  Would this work?

Well, I just copied what the offitial "pgd_index()" macro and its fellows do:

pgd_index (unsigned long address)
{
	unsigned long region = address >> 61;
	unsigned long l1index = (address >> PGDIR_SHIFT) & ((PTRS_PER_PGD >> 3) - 1);

	return (region << (PAGE_SHIFT - 6)) | l1index;
}

Me too, I'd like to see more symbolic constants...
But I don't want to be more catholic than the Pope :-)

> #define __VA(pgdi, pmdi, ptei)  ((pgdi)*PGDIR_SIZE + \
>                                  (pmdi)*PMD_SIZE +   \
>                                  (ptei)*PAGE_SIZE)
> If ia64 doesn't have the _SIZE macros, you can just copy them from
> include/asm-i386/pgtable*.h

Unfortunately, it is not so simple like that.
We've got 5 user regions out of 8 regions of size of 0x2000000000000
(don't know how is this called). Only the first 16 Tbytes of each region
are mapped bye the PGD-PMD-PTE structure. Then we've got a large hole
that cannot be taken into account by your macro. I.e. we count as

0x000fffffffffffff, 0x2000000000000, ... 0x200fffffffffffff, 0x4000000000000

Apart from using some nice macros with speaking names instead of "<< 61",
I cannot see any simpler way for the conversion (as far as IA64 is concerned).

> -- 2.6.4.ref/mm/rmap.c Tue Mar 16 10:18:17 2004
> +++ 2.6.4.mig4/mm/rmap.c        Thu Mar 25 09:00:13 2004
> ...
> -struct pte_chain {
> -       unsigned long next_and_idx;
> -       pte_addr_t ptes[NRPTE];
> -} ____cacheline_aligned;-- 2.6.4.ref/include/asm-ia64/rmap-locking.h
> 
> Exposing the VM internals like that probably isn't going to be
> acceptable.  Why was this necessary?

Previously, I was more ambitious, and wanted to handle the not direct
mapped pages, too. I'll put back where it was.

For the rest: it's YES.

> There don't appear to be any security checks in your syscall.  Should
> all users be allowed to migrate memory around at will from any pid?

Well, who makes migrate someone else, cannot read / write the victim's data,
nor can break it. For more security, I can add a something like whoever can
kill an application, s/he can migrate it, too.

> By not modifying a single line in the existing VM path, your patch
> simply duplicates functionality from that existing code, which I'm not
> sure is any better.  

> I think there's a lot of commonality with what the swap code, NUMA page
> migration, and memory removal have to do.  However, none of them share
> any code today.  I think all of the implementations could benefit from
> making them a bit more generic. 

I can agree on not doubling code. I can give a try to the code written by
Hirokazu Takahashi and see if it is sufficiently efficient for me.

Thanks,

Zoltán

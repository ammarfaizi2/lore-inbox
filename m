Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312556AbSCZRJK>; Tue, 26 Mar 2002 12:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSCZRJB>; Tue, 26 Mar 2002 12:09:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7472 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312556AbSCZRIq>; Tue, 26 Mar 2002 12:08:46 -0500
Date: Tue, 26 Mar 2002 18:08:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, gerrit@us.ibm.com
Subject: Re: Backport of Ingo/Arjan highpte to 2.4.18 (+O1 scheduler)
Message-ID: <20020326180841.C13052@dualathlon.random>
In-Reply-To: <242250000.1016752254@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 03:10:54PM -0800, Martin J. Bligh wrote:
> diff -urN linux-2.4.18-prepte/mm/mremap.c linux-2.4.18-highpte/mm/mremap.c
> --- linux-2.4.18-prepte/mm/mremap.c	Thu Sep 20 20:31:26 2001
> +++ linux-2.4.18-highpte/mm/mremap.c	Thu Mar 21 17:37:24 2002
> @@ -15,7 +15,7 @@
>  
>  extern int vm_enough_memory(long pages);
>  
> -static inline pte_t *get_one_pte(struct mm_struct *mm, unsigned long addr)
> +static inline pte_t *get_one_pte_map2(struct mm_struct *mm, unsigned long addr)
>  {
>  	pgd_t * pgd;
>  	pmd_t * pmd;
> @@ -39,21 +39,23 @@
>  		goto end;
>  	}
>  
> -	pte = pte_offset(pmd, addr);
> -	if (pte_none(*pte))
> +	pte = pte_offset_map2(pmd, addr);
> +	if (pte_none(*pte)) {
> +		pte_unmap2(pte);
>  		pte = NULL;
> +	}
>  end:
>  	return pte;
>  }
>  
> -static inline pte_t *alloc_one_pte(struct mm_struct *mm, unsigned long addr)
> +static inline pte_t *alloc_one_pte_map(struct mm_struct *mm, unsigned long addr)
>  {
>  	pmd_t * pmd;
>  	pte_t * pte = NULL;
>  
>  	pmd = pmd_alloc(mm, pgd_offset(mm, addr), addr);
>  	if (pmd)
> -		pte = pte_alloc(mm, pmd, addr);
> +		pte = pte_alloc_map(mm, pmd, addr);
>  	return pte;
>  }
>  
> @@ -77,12 +79,16 @@
>  static int move_one_page(struct mm_struct *mm, unsigned long old_addr, unsigned long new_addr)
>  {
>  	int error = 0;
> -	pte_t * src;
> +	pte_t *src, *dst;
>  
>  	spin_lock(&mm->page_table_lock);
> -	src = get_one_pte(mm, old_addr);
> -	if (src)
> -		error = copy_one_pte(mm, src, alloc_one_pte(mm, new_addr));
> +	src = get_one_pte_map2(mm, old_addr);
> +	if (src) {
> +		dst = alloc_one_pte_map(mm, new_addr);
> +		error = copy_one_pte(mm, src, dst);
> +		pte_unmap2(src);
> +		pte_unmap(dst);
> +	}
>  	spin_unlock(&mm->page_table_lock);
>  	return error;
>  }

while removing the persistent kmaps in pte-highmem from the fast paths,
I had a look how you solved this mremap thing without the persistent
kmaps. First, your backport is clearly broken because it will oops in
copy_one_pte if the alloc_one_pte_map fails.

2.5.7 gets such bit right (checking for dst == null within
copy_one_pte), but it's broken too and it will be unstable with
high-pte enabled. Either it's a coincidence or Ingo copied the changes
from my pte-highmem but he apparently forgot that his pte_offset_map
isn't persistent. The code works fine in pte-highmem, and it will break
on 2.5.7 due the atomic kmaps. The reason is that it's doing a
pte_alloc within a pte_offset_map_nested, so the pte_offset_map_nested
can be corrupted if pte_alloc sleeps while allocating the memory for the
pagetable.

Now, I'm not nearly backporting Ingo's code to 2.4, in particular the
drop of the quicklist without an affine allocator is a performance
optimization removal that doesn't make sense in 2.4, and as well the
whole pte_offset_kernel thing is flawed in general IMHO (in particular
in 2.5 where all drivers are using proper api to get physical pages of
vmalloc space). mremap isn't an extremely fast path like the anon page
faults/execve etc.., so in pte-highmem I'm going to left the persistent
kmap in get_one_pte, to left the code simple and to avoid an overwork
with preallocation of memory or ugly #ifdefs around.  That's one of the
purposes of the persistent kmaps of course, to keep the code clean and
efficient (think UP here).  And in 2.5, once we'll switch all the
pte_offset_map to use the KM_USER_PAGETABLE0 entry in the user-fixmap
area, those mremap mappings will be automatically persistent and the
current 2.5 bug will go away automatically that way. Then also all the
memory.c changes that I will have to backport to make your workload
scale (sensless in particular with a 64bit point of view) in Ingo's
patch can be backed out from 2.5 (with the exclusion of the pte_unmap*
of course :).

BTW, another place where I'm not going to write ugly code in 2.4 is
/proc/, while it could be atomic in mainline, I've a scheduling point
there to provide lower latency, and I don't want to clobber it with
stuff like:

	if (current->need_resched) {
		pte_kunmap(pte);
		schedule();
		pte = pte_offset(...)
	}

just to make `ps` faster.

The persistent kmaps scales less on a 16-way NUMA-Q (not even a problem
for normal servers), so I'm just replacing the absolutely required fast
paths to make the kernel compile faster, but in all the slow paths where
I'd need to write ugly code, I'm definitely keeping the persistent
kmaps.

With the user-fixmap that you proposed some day ago, this whole thing
will be solved cleanly in 2.5. 2.4 pte-highmem will remain an hybrid.

Then there's also the naming issues of the pte_offset calls, for now I'm
keeping them called:

	pte_offset_atomic/pte_kunmap (atomic)
	pte_offset/pte_kunmap (persistent)
	pte_offset_atomic2/pte_kunmap_atomic2 (atomic 2nd entry)

the original names in pte-highmem, because of this hybrid thing and to
remeber it works differently than the atomic-and-persistent user-fixmap
that we'll soon have in 2.5 with pte_offset_map.

(I could have pte_kunmap to take care of pte_offset_atomic2 too, but
doing explicit is faster and it happens only in a few places anyways, if
you prefer to have a pte_kunmap able to unmap pte_offset_atomic2 too let
me know)

I'm not considering to drop pte-highmem from 2.4 and to only support the
user-fixmaps in 2.5 because it is a showstopper bugfix for lots of
important users that definitely cannot wait 2.6. I'm also not
considering backporting the user-fixmaps because that would be a quite
invasive change messing also with the alignment of the user stack (I
know it could stay into kernel space, but right after the user stack it
will be more optimized and cleaner/simpler, so I prefer to put the few
virtual pages there).

Andrea

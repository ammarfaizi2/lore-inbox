Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVBZRWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVBZRWA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 12:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVBZRWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 12:22:00 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:46306 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261239AbVBZRVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 12:21:13 -0500
Date: Sat, 26 Feb 2005 17:20:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Chris Wright <chrisw@osdl.org>
cc: Darren Hart <dvhltc@us.ibm.com>, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow vma merging with mlock et. al.
In-Reply-To: <20050225220543.GC15867@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0502261626330.20871@goblin.wat.veritas.com>
References: <421E74B5.3040701@us.ibm.com> 
    <20050225171122.GE28536@shell0.pdx.osdl.net> 
    <20050225220543.GC15867@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2005, Chris Wright wrote:
> 
> Actually I think it winds up being fine since we don't do merging with
> mlock.  But why not?  Patch below remedies that.

I shared Darren's assumption, that mlock merging had been found too
expensive.  But Andrea says it's just that nobody asked for it, so
now you've done the work, let's give it a try in -mm.  We can always
back it out if somebody perceives a regression.

Do madvise and mempolicy too?  I've no strong feelings about them.

> Successive mlock/munlock calls can leave fragmented vmas because they can
> be split but not merged.  Give mlock et. al. full vma merging support.

Phew, you followed mprotect, saving me from having to think too deeply
about the correctness of this (I'm assuming mprotect is perfect ;))
Some remarks then on the three places where you departed from mprotect.

> ===== mm/mlock.c 1.19 vs edited =====
> --- 1.19/mm/mlock.c	2005-02-11 11:07:35 -08:00
> +++ edited/mm/mlock.c	2005-02-24 23:53:10 -08:00
> @@ -7,18 +7,32 @@
>  
>  #include <linux/mman.h>
>  #include <linux/mm.h>
> +#include <linux/mempolicy.h>
>  #include <linux/syscalls.h>
>  
>  
> -static int mlock_fixup(struct vm_area_struct * vma, 
> +static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  	unsigned long start, unsigned long end, unsigned int newflags)
>  {
>  	struct mm_struct * mm = vma->vm_mm;
> +	pgoff_t pgoff;
>  	int pages;
>  	int ret = 0;
>  
> -	if (newflags == vma->vm_flags)
> +	if (newflags == vma->vm_flags) {
> +		*prev = vma;
>  		goto out;
> +	}
> +
> +	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> +	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
> +			  vma->vm_file, pgoff, vma_policy(vma));
> +	if (*prev) {
> +		vma = *prev;
> +		goto success;
> +	}
> +
> +	*prev = vma;

You've raised that line higher (so do_mlockall's "Ignore errors" works):
that's an improvement because it saves special casing errors, I'd like
you to make the same adjustment to mprotect_fixup, even though it's not
required there (and delete "Unless it returns an error, " from comment).
Let's keep the two in step.

>  	if (start != vma->vm_start) {
>  		ret = split_vma(mm, vma, start, 1);
> @@ -32,6 +46,7 @@ static int mlock_fixup(struct vm_area_st
>  			goto out;
>  	}
>  
> +success:
>  	/*
>  	 * vm_flags is protected by the mmap_sem held in write mode.
>  	 * It's okay if try_to_unmap_one unmaps a page just after we
> @@ -59,7 +74,7 @@ out:
>  static int do_mlock(unsigned long start, size_t len, int on)
>  {
>  	unsigned long nstart, end, tmp;
> -	struct vm_area_struct * vma, * next;
> +	struct vm_area_struct * vma, * prev;
>  	int error;
>  
>  	len = PAGE_ALIGN(len);
> @@ -68,7 +83,7 @@ static int do_mlock(unsigned long start,
>  		return -EINVAL;
>  	if (end == start)
>  		return 0;
> -	vma = find_vma(current->mm, start);
> +	vma = find_vma_prev(current->mm, start, &prev);
>  	if (!vma || vma->vm_start > start)
>  		return -ENOMEM;

But here sys_mprotect also says:

	if (start > vma->vm_start)
		prev = vma;

Perhaps you've worked your way through vma_merge and convinced yourself
this is never necessary, that's quite possible; but I'd still be happier
if you were to add it into your do_mlock: it limits the cases vma_merge
has to worry about.  Or if you feel strongly about it, explain why I'm
just being silly, and delete it from mprotect too.

> @@ -81,18 +96,19 @@ static int do_mlock(unsigned long start,
>  		if (!on)
>  			newflags &= ~VM_LOCKED;
>  
> -		if (vma->vm_end >= end) {
> -			error = mlock_fixup(vma, nstart, end, newflags);
> -			break;
> -		}
> -
>  		tmp = vma->vm_end;
> -		next = vma->vm_next;
> -		error = mlock_fixup(vma, nstart, tmp, newflags);
> +		if (tmp > end)
> +			tmp = end;
> +		error = mlock_fixup(vma, &prev, nstart, tmp, newflags);
>  		if (error)
>  			break;
>  		nstart = tmp;
> -		vma = next;
> +		if (nstart < prev->vm_end)
> +			nstart = prev->vm_end;
> +		if (nstart >= end)
> +			break;
> +
> +		vma = prev->vm_next;
>  		if (!vma || vma->vm_start != nstart) {
>  			error = -ENOMEM;
>  			break;
> @@ -141,7 +157,7 @@ asmlinkage long sys_munlock(unsigned lon
>  
>  static int do_mlockall(int flags)
>  {
> -	struct vm_area_struct * vma;
> +	struct vm_area_struct * vma, * prev;
>  	unsigned int def_flags = 0;
>  
>  	if (flags & MCL_FUTURE)
> @@ -150,7 +166,7 @@ static int do_mlockall(int flags)
>  	if (flags == MCL_FUTURE)
>  		goto out;
>  
> -	for (vma = current->mm->mmap; vma ; vma = vma->vm_next) {
> +	for (prev = vma = current->mm->mmap; vma ; vma = vma->vm_next) {

Here prev should be initialized to NULL, rather than the first vma.
Again, you've probably worked out that it's safe as you've written it,
but vma_merge does expect prev NULL at the beginning.

>  		unsigned int newflags;
>  
>  		newflags = vma->vm_flags | VM_LOCKED;
> @@ -158,7 +174,8 @@ static int do_mlockall(int flags)
>  			newflags &= ~VM_LOCKED;
>  
>  		/* Ignore errors */
> -		mlock_fixup(vma, vma->vm_start, vma->vm_end, newflags);
> +		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
> +		vma = prev;

Scrap that "vma = prev;" line, just say "vma = prev->vm_next" in the loop?

>  	}
>  out:
>  	return 0;

Hugh

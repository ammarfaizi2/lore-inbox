Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbTIDBnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTIDBmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:42:42 -0400
Received: from dp.samba.org ([66.70.73.150]:25777 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264493AbTIDBm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:42:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix 
In-reply-to: Your message of "Wed, 03 Sep 2003 08:36:28 +0100."
             <20030903073628.GA19920@mail.jlokier.co.uk> 
Date: Thu, 04 Sep 2003 11:35:27 +1000
Message-Id: <20030904014229.404F12C0CB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030903073628.GA19920@mail.jlokier.co.uk> you write:
> Hi Rusty,
> 
> You will be please to know I have written a complete patch :)

Hi Jamie,

	Very pleased!  Remember, Open Source is all about having other
people do your work for you 8)

> > Assume that we do:
> > 1) Look up vma.
> > 2) If vma->vm_flags & VM_SHARED, index by page->mapping & page->index.
> > 3) Otherwise, index by vma->vm_mm & uaddr.
> 
> Like that, but 2) uses vma->vm_file->f_dentry->d_inode.
> 
> That way, there is no need to walk the page table at all unless it's a
> non-linear mapping (which my patch does handle).

OK.

> > 2) If VM_SHARED, and page->mapping is NULL, what to do?  AFAICT, this
> >    can happen in the case of anonymous shared mappings, say mmap
> >    /dev/zero MAP_SHARED and fork()? Treating it as !VM_SHARED (and
> >    hence matching in mm & uaddr) won't work, since the mm's will be
> >    different (and with mremap, the uaddrs may be different).
> 
> No, that doesn't happen.  An anoymous shared mapping calls
> shmem_zero_setup(), which creates an anonymous tmpfs file to back the
> mapping.  It then looks the same as IPC shm or any other tmpfs file.
> 
> So it works :)

Ah, I didn't look down that far in do_mmap_pgoff.  Right: that makes
things much simpler.

> > 3) Since we need the offset in the file anyway for the VM_SHARED, it
> >    makes more sense to use get_user_pages() to get the vma and page in
> >    one call, rather than find_extend_vma().
> 
> You need the offset, but you don't need the page.  For a linear
> mapping, the offset is a very simple calculation - no page table lock
> and no page table walk.  As a silly bonus it doesn't touch the page.
> 
> For non-linear mappings, I try follow_page() and then
> get_user_pages(), as usual, to get page->index.  Technically you don't
> need to swap the page in, but there's no point using complicated code
> for that unimportant case.
> 
> I added a flag VM_NONLINEAR to distinguish them.

OK, I would have done it the naive way, but Ingo would probably have
just written what you did (he did the follow_page optimization) 8)

The rest is just nitpicking...

> +	/* Page keys and offset within the page. */
> +	unsigned long keys[2];
>  	int offset;

I prefer a union here.  It's a little more verbose, but I think it's
clearer:

struct anon_key
{
	struct mm_struct *mm;
	unsigned long uaddr;
};

struct filebacked_key
{
	struct inode *inode;
	unsigned long page_index;
};

union hash_key
{
	struct anon_key anon;
	struct filebacked_key filebacked;
	unsigned long keys[2];
};

> +#ifdef FIXADDR_USER_START
> +		if (addr >= FIXADDR_USER_START && addr < FIXADDR_USER_END) {
> +			keys[0] = 1; /* Different from any pointer value. */
> +			keys[1] = addr - FIXADDR_USER_START;
> +			return 0;
> +		}
> +#endif

I think this is a bit extreme: this would allow futexes in the
VSYSCALL region, right?  I admire your thoroughness, but perhaps this
should wait until someone comes up with a reason to do it?

The rest looks ok, I'll do a differential once the rest settles down...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

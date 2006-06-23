Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752144AbWFWWgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbWFWWgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbWFWWgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:36:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752144AbWFWWgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:36:21 -0400
Date: Fri, 23 Jun 2006 15:35:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
In-Reply-To: <1151100017.30819.50.camel@lappy>
Message-ID: <Pine.LNX.4.64.0606231514170.6483@g5.osdl.org>
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com> 
 <1151019590.15744.144.camel@lappy>  <Pine.LNX.4.64.0606231933060.7524@blonde.wat.veritas.com>
 <1151100017.30819.50.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Jun 2006, Peter Zijlstra wrote:

> > > +	if ((pgprot_val(vma->vm_page_prot) == pgprot_val(vm_page_prot) &&
> > > +	     ((vm_flags & (VM_WRITE|VM_SHARED|VM_PFNMAP|VM_INSERTPAGE)) ==
> > > +			  (VM_WRITE|VM_SHARED)) &&
> > > +	     vma->vm_file && vma->vm_file->f_mapping &&
> > > +	     mapping_cap_account_dirty(vma->vm_file->f_mapping)) ||
> > > +	    (vma->vm_ops && vma->vm_ops->page_mkwrite))
> > > +		vma->vm_page_prot =
> > > +			protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];
> > > +
> > 
> > I'm dazzled by the beauty of it!
> 
> It's a real beauty isn't it :-)

Since Hugh pointed that out..

It really would be nice to just encapsulate that as an inline function of 
its own, and move the comment at the top of it to be at the top of the 
inline function.

Just make it something like

	/*
	 * Some shared mappigns will want the pages marked read-only
	 * to track write events. If so, we'll downgrade vm_page_prot
	 * to the private version (using protection_map[] without the
	 * VM_SHARED bit).
	 */
	static inline int vma_wants_writenotify(struct vm_area_struct *vma)
	{
		unsigned int vm_flags = vma->vm_flags;

		/* If it was private or non-writable, the write bit is already clear */
		if ((vm_flags & (VM_SHARED | VM_WRITE)) != ((VM_SHARED | VM_WRITE))
			return 0;

		/* The open routine did something to the protections already? */
		if (pgprot_val(vma->vm_page_prot) !=
		   pgprot_val(protection_map[vm_flags & (VM_SHARED|VM_READ|VM_WRITE|VM_EXEC)]))
			return 0;

		/* The backer wishes to know when pages are first written to? */
		if (vma->vm_ops && vma->vm_ops->page_mkwrite)
			return 1;

		/* Specialty mapping? */
		if (vm_flags & (VM_PFNMAP|VM_INSERTPAGE))
			return 0;

		/* Can the mapping track the dirty pages? */
		return vma->vm_file && vma->vm_file->f_mapping &&
			mapping_cap_account_dirty(vma->vm_file->f_mapping);
	}

(And no, I didn't make sure to test that it gives the same answer as your 
version, it's just a more readable version of what I think your version 
tests ;)

And then just use it with

	if (vma_wants_writenotify(vma))
		vma->vm_page_prot = protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];

which would appear to be more readable.

Yeah, the compiler may do worse. Or it may not. It usually pays to try to 
write code more readably, sometimes the compiler ends up understanding it 
better too ;)

		Linus

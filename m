Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbSJNPff>; Mon, 14 Oct 2002 11:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbSJNPff>; Mon, 14 Oct 2002 11:35:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55982 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261807AbSJNPfe>;
	Mon, 14 Oct 2002 11:35:34 -0400
Date: Mon, 14 Oct 2002 17:52:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support,
 2.5.42-F8
In-Reply-To: <20021014152048.GC4488@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0210141739510.8792-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Oct 2002, William Lee Irwin III wrote:

> > well, i dont agree with vectorizing everything, unless it's some really
> > lightweight thing and/or the operation is somehow naturally vectorized.  
> > (block and network IO, etc.)
> 
> I would say it makes sense for its intended purpose, as large volumes of
> pages are expected to be remapped this way.

volume alone does not necessiate a vectored API - everything depends on
whether the volume comes in chunks, ie. is predictable. For things like a
LRU DB-cache the order of new cache entries are largely unpredictable.  
Even if predictable then they are mostly continuous in the file space, ie.
properly vectorized by the API already. There might be cases where there
are bulk mappings, but the common case i'm quite sure isnt. Just like we
dont have bulk mmap() support either. But, if it really turns out to be a
problem then a bulk API can be added later on, which would just build upon
the existing syscall.

> The VM_RANDOM flag was a safety net I believed to be beneficial, in part
> because userspace would be limited in how it can utilize the remapping
> facility without guarantees that mappings are not implicitly established
> in ways it does not expect.

if this is really an issue then we could force vma->vm_page_prot to
PROT_NONE within remap_file_pages(), so at least all subsequent faults
will be PROT_NONE and the user would have to explicitly re-mprotect() the
vma again to change this.

> > how would you do this actually, without other restrictions?
> 
> It would be easy to keep the VM_RANDOM flag for truly random vma's, and
> check for file offsets matching in the prefault path for others.

there is no 'VM_RANDOM' flag right now - because *any* shared mapping can
be used with remap_file_pages(). I think forcing the default protection to
PROT_NONE should solve the problem - this is the most logical thing to do
in the MAP_LOCKED case as well.

> A nonblocking filemap_populate() may partially populate a virtual
> address range and the user may later fault in pages not file offset
> contiguous in the prefaulted region as opposed to discovering them as
> not present. For the MAP_LOCKED | PROT_NONE scenario this would apply
> only with a nonblocking prefault on a MAP_LOCKED vma, where the caller
> would find stale mappings where the prefault operation failed, and even
> if the nonblocking path invalidated the pte's one would still return to
> faulting in of the wrong pages. This is a safety question limiting the
> usefulness of nonblocking prefaults on scatter gather vma's to
> userspace.

this too is handled by changing the default protection to PROT_NONE. A
user would have to deliberately change the protection to get rid of this
safety net - at which point no harm will be done, the user will get what
he asked for.

	Ingo


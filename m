Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271963AbRIDM62>; Tue, 4 Sep 2001 08:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271965AbRIDM6S>; Tue, 4 Sep 2001 08:58:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:52520 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271963AbRIDM6K>; Tue, 4 Sep 2001 08:58:10 -0400
Date: Tue, 4 Sep 2001 14:58:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Richard Henderson <rth@twiddle.net>, David Mosberger <davidm@hpl.hp.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
Message-ID: <20010904145843.I699@athlon.random>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com> <20010903131436.A16069@twiddle.net> <15251.59286.154267.431231@napali.hpl.hp.com> <20010903134125.B16069@twiddle.net> <15252.13330.652765.959658@cargo.ozlabs.ibm.com> <20010904043151.H699@athlon.random> <15252.21426.787059.469270@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15252.21426.787059.469270@cargo.ozlabs.ibm.com>; from paulus@samba.org on Tue, Sep 04, 2001 at 02:08:18PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 02:08:18PM +1000, Paul Mackerras wrote:
> flush_icache_page is not a good function to use because it is called
> in do_swap_page and in do_no_page in mm/memory.c and in those cases
> the page might already be i-cache clean and so we don't want to do any
> flush.  In those cases, if the page does actually get read in from
> disk then we do want to do the flush, if it was in the page cache or
> swap cache and has been flushed before then we don't want to do the
> flush.  (Actually doesn't that mean that on alpha you are throwing
> away the whole icache for the process every time it faults in an
> executable page?)

Actually alpha is wasting lots of asn at evey swapin or pagein! See what
the specification (implementation independent) says:

	Virtual instruction caches are not required to notice modifications of
	the virtual I-stream (they need not be coherent with the rest of
	memory). Software that creates or modifies the instruction stream must
	execute a CALL_PAL IMB before trying to exe-cute the new instructions.
	In this context, to "modify the virtual I-stream" means either:   any
									  ^^^
	Store to the same physical address that is subsequently fetched as an
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	instruction by some corresponding (virtual address, ASN) pair, or   any
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ (ptrace case thus we need imb or bumping the asn there)
	change to the virtual-to-physical address mapping so that different
	values are fetched. For example, if two different virtual addresses, VA1
	and VA2, map to the same page frame, a store to VA1 modifies the virtual
	I-stream fetched by VA2. However, the following sequence does not modify
				 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	the virtual I-stream (this might happen in soft page faults). 1. Change
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	the mapping of an I-stream page from valid to invalid. 2. Copy the
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	corresponding page frame to a new page frame. 3. Change the original
							 ^^^^^^^^^^^^^^^^^^^
	mapping to be valid and point to the new page frame.
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

As far I can tell during pageins/swapins we really don't need to flush
the icache (we literally always mark the pagetable invalid + flush the
tlb before any swapin or pagein so I think it fully applies to our
case). Infact 2.2 never do any asn change or imb during the
swapins/pageins and we never had a problem.

On alpha we need to flush the icache only when we mess with the memory
contents under the icache, not when we pageout pagein this memory.

I believe the point here is that swapins and pageins of .text segments
aren't going to want to change the contents of the icache anyways.

Actually one could argue that if we map an executable segment and then
the vm unmaps the page, then somebody else changes the page in the disk
and pagecache writing to it, then we fault on the page again with the
l1 dcache, in this case I guess the cpu could still exectue the old
istream and not notice that it's changed but who cares about this weird
case anyways? If anybody does self modifying code this way he should
serialize in userspace.

So in short I'd prefer to undefine the flush_icache_page on alpha and to
have it used in the common code only from the paging activity. I'd
really like if you could arrange this modification in a new release of
your anti-cache-flushes patch.

> flush_icache_page is also not a good choice because it is overkill to
> flush a whole page when you have just written one word, to put in a
> breakpoint or something.

Ok I see why you changed it than (just to flush one word and not the
whole page), but we cannot just flush one word of icache on alpha (I was
biased and this is why I didn't seen the point of the change ;), either
we flush the whole icache or we flush only the address space of the
ptraced mm by bumping its asn, so yes, we'd like a kind of
flush_icache_range_mm (or _vma or whatever that pass the mm somehow). If
you could add this modification to your patch as well that would be
fine!

> I would be happy with an interface that took a struct page *, and
> preferably an offset and length within the page.  That would be a new
> interface though.  Note that the caller of access_process_vm can't

yes, as mentioned above a new flush_icache_range_mm/vma/user would be
enough, the other flush_icache_range should be used only for the kernel
side.

Andrea

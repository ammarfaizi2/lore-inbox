Return-Path: <linux-kernel-owner+w=401wt.eu-S933228AbWLaVMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933228AbWLaVMT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 16:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933229AbWLaVMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 16:12:19 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40588
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933228AbWLaVMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 16:12:18 -0500
Date: Sun, 31 Dec 2006 13:12:16 -0800 (PST)
Message-Id: <20061231.131216.105428418.davem@davemloft.net>
To: torvalds@osdl.org
Cc: miklos@szeredi.hu, rmk+lkml@arm.linux.org.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0612311249240.4473@woody.osdl.org>
References: <E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu>
	<20061231.124017.85689231.davem@davemloft.net>
	<Pine.LNX.4.64.0612311249240.4473@woody.osdl.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Sun, 31 Dec 2006 12:58:45 -0800 (PST)

> So there really is two different cases here:
> 
>  - flush the cache as seen by A PARTICULAR virtual mapping.
> 
>    This is ptrace, but it's other things like "unmap page from this VM" 
>    too.
> 
>  - flush the cache for all possible virtual mappings - simply because we 
>    don't even know who has it mapped dirty. 
> 
>    And the thing is, the more I think about it, the more I end up 
>    wondering:
> 
>    I'm not even sure how valid this is. Whatever path needs to do this is 
>    likely doing something wrong anyway. If there are multiple possible 
>    sources of cache conflicts, the thing is a disaster and the end result 
>    depends on our ordering anyway, so I'd argue that it is just about as 
>    correct to flush as it is to NOT flush.
> 
> So I have this nagging suspicion that "flush_dcache_page()" is always a 
> bug when it is about "virtual caches". It should NEVER flush any virtual 
> caches, since that whole operations is by necessity something where you 
> should be talking about _which_ virtual cache you should flush.

It's the aliasing between the _1_ valid user mapping and the kernel's
virtual mapping, that's the problem and that's very valid and that's
why we have flush_dcache_page() to begin with.

> So "flush_dcache_page()" is - I think - more validtly thought about as 
> just DMA coherency (in a system where DMA does not participate in 
> _physical_ cache coherency). Not about virtual caches at all.

And I guess that's what you're trying to say here.

I'm beginning to think that Ralf Baechle had the best idea here,
where he recently made it such that platforms could override
kmap() and friends even on non-HIGHMEM configurations.

In theory it's the perfect interface to handle this problem,
you flush exactly where the physical page is made visible to
the kernel for a cpu load/store.  All the locations where that
happens are perfectly annotated already with kmap() calls.

So then there are two ways to touch user mapped pages:

1) Inside of a kmap()/kunmap() region.

2) Via copy_user_page()/clear_user_page()

The only core requirement is that the interfaces know the
virtual address the thing is mapped at, and after Ralf's
changes both #1 and #2 do have this information.

Using kmap() even takes care of the PIO "dma" cases where
the CPU reads/writes to the buffer for the data transfer.

Furthermore, an implementation of #1 and #2 can avoid
cache flushing altogether.  Just like for HIGHMEM you
have a kmap() TLB mapping area that sets up a mapping at
the correct alias, and returns that pointer from kmap().
Since the alias is good, no cache flush is needed to access
the page in kernel space.

In fact I think this is what Ralf's implementation on MIPS is doing.
And, this is the scheme we use on sparc64 for {copy,clear}_user_page().

Now, going in the opposite direction (kernel page made visible to
userspace for the first time, so you have to kick out the kernel side
mapping from the cache) can be handled either at set_pte_at() time
(this is what sparc64 does) or in update_mmu_cache().

This leaves only one (arguably broken) case of, as you mention, the
user using MAP_SHARED at a set of several incompatible aliases.  As
far as I can see, the only sane thing to do in that situation seems to
be to mark the thing non-virtually-cacheable in the user mapping PTEs
if the cpu architecture allows that.

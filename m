Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315604AbSECIhl>; Fri, 3 May 2002 04:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315605AbSECIhk>; Fri, 3 May 2002 04:37:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8000 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315604AbSECIhf>; Fri, 3 May 2002 04:37:35 -0400
Date: Fri, 3 May 2002 10:38:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503103813.K11414@dualathlon.random>
In-Reply-To: <20020503080433.R11414@dualathlon.random> <4023859403.1020382422@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 11:33:43PM -0700, Martin J. Bligh wrote:
> into kernel address space for ever. That's a fundamental scalability
> problem for a 32 bit machine, and I think we need to fix it. If we
> map only the pages the process is using into the user-kernel address
> space area, rather than the global KVA, we get rid of some of these
> problems. Not that that plan doesn't have its own problems, but ... ;-)

:) As said every workaround has a significant drawback at this point.
Starting flooding the tlb with invlpg and pagetable walking every time
we need to do a set_bit or clear_bit test_bit or an unlock_page is both
overkill at runtime and overcomplex on the software side too to manage
those kernel pools in user memory.

just assume we do that and that you're ok to pay for the hit in general
purpose usage, then the next year how will you plan to workaround the
limitation of 64G of physical ram, are you going to multiplex another
64G of ram via a pci register so you can handle 128G of ram on x86 just
not simultaneously? (but that's ok in theory, the cpu won't notice
you're swapping the ram under it, and you cannot keep mapped in virtual
mem more than 4G anyways simultaneously, so it doesn't matter if some
ram isn't visible on the phsical side either)

I mean, in theory there's no limit, but in practice there's a limit, 64G
is just over the limit for general purpose x86 IMHO, it's at a point
where every workaround for something has a significant performance (or
memory drawback), still very fine for custom apps that needs that much
ram but 32G is the pratical limit of general purpose x86 IMHO.

Ah, and of course you could also use 2M pagetables by default to make it
more usable but still you would run in some huge ram wastage in certain
usages with small files, huge pageins and reads swapout and swapins,
plus it wouldn't be guaranteed to be transparent to the userspace
binaries (for istance mmap offset fields would break backwards
compatibility on the required alignment, that's probably the last
problem though). Despite its also significant drawbacks and the
complexity of the change, probably the 4M pagetables would be the saner
approch to manage more efficiently 64G with only a 800M kernel window.

> Bear in mind that we've sucessfully used 64Gb of ram in a 32 bit 
> virtual addr space a long time ago with Dynix/PTX.

You can use 64G "sucessfully" just now too with 2.4.19pre8 too, as said
in the earlier email there are many applications that doesn't care if
there's only a few meg of zone_normal and for them 2.4.19pre8 is just
fine (actually -aa is much better for the bounce buffers and other vm
fixes in that area). If all the load is in userspace current 2.4 is just
optimal and you'll take advantage of all the ram without problems (let's
assume it's not a numa machine, with numa you'd be better with the fixes
I included in my tree).  But if you need the kernel to do some amount of
work, like vfs caching, blkdev cache, lots of bh on pagecache, lots of
vma, lots of kiobufs, skb etc..  then you'd probably be faster if you
boot with mem=32G or at least you should take actions like recompiling
the kernel as CONFIG_2G that would then break SGA large 1.7G etc...

> > So at the end you'll be left with
> > only say 5/10M per node of zone_normal that will be filled immediatly as
> > soon as you start reading some directory from disk. a few hundred mbyte
> > of vfs cache is the minimum for those machines, this doesn't even take
> > into account bh headers for the pagecache, physical address space
> > pagecache for the buffercache, kiobufs, vma, etc... 
> 
> Bufferheads are another huge problem right now. For a P4 machine, they
> round off to 128 bytes per data structure. I was just looking at a 16Gb
> machine that had completely wedged itself by filling ZONE_NORMAL with 

Go ahead, use -aa or the vm-33 update, I fixed that problem a few days
after hearing about it the first time (with the due credit to Rik in a
comment for showing me such problem btw, I never noticed it before).

> unfreeable overhead - 440Mb of bufferheads alone. Globally mapping the
> bufferheads is probably another thing that'll have to go.
> 
> > It's just that 1G of
> > virtual address space reserved for kernel is too low to handle
> > efficiently 64G of physical ram, this is a fact and you can't 
> > workaround it. 
> 
> Death to global mappings! ;-)
> 
> I'd agree that a 64 bit vaddr space makes much more sense, but we're

This is my whole point yes :)

> stuck with the chips we've got for a little while yet. AMD were a few
> years too late for the bleeding edge Intel arch people amongst us.

Andrea

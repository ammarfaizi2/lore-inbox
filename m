Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWJHWiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWJHWiQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWJHWiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:38:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:26039 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751491AbWJHWiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:38:15 -0400
Subject: User switchable HW mappings & cie
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-mm@kvack.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Arnd Bergmann <arnd@arndb.de>,
       Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 08:37:45 +1000
Message-Id: <1160347065.5926.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'd like to kick a discussion about some issues I've been having along
with some proposed solutions related to mapping of bits of hardware in
smarter ways than simply doing a io_remap_pfn_range() and the problems,
generally caused by get_user_pages().

There are at least two main examples where this is useful, and both
trigger various issues mostly related to get_user_pages(). So let's
start with the examples: cell's SPUs and graphics memory management.

 - SPUs

We have two types of mappings that concern us here for userland: the
local store memory of the SPEs, which is a 256Kb chunk of memory on each
SPU, and a bunch of register space called "problem state mapping" for
each SPU.

Since SPUs can be context-switched by the kernel, we need some strict
control of access to those mappings. What we currently do is that we use
a nopage() handler for them. The local store memory is backed up in main
memory when a virtual SPU context is not scheduled in a physical SPE and
access to the registers is blocked.

This is all possible because we currently create struct page's for those
things using sparsemem. However, this is far from optimal: the SPUs MMIO
areas are far away from memory and fairly small, thus we end up with a
fairly weird sparsemem map and some overhead that wouldn't be necessary
if we could get away with the struct pages (see my other options below).

The way the context switching works is that when an SPU virtual context
(the spu equivalent of a task) gets context switched in/out, we use
unmap_mapping_range() to destroy any current mapping in the page tables.
In the case of the local store, further no_page() will then bring in
pages from either the backing store or the real SPU local store
depending on the new state of the SPU, and in the case of registers,
further no_page() will block if the SPU is not scheduled in (which leads
to other issues, I'll explain below too).

However, get_user_pages() gets in the way in a couple of areas. Mainly
because it "caches" the struct page obtained via follow_page(). In
general, anything doing so (or calling follow_page()) is potentially a
problem since it will keep a "stale" struct page if a context switch of
the SPU happens.

Among others, that means that it's currently possible to trick PTRACE
into reading the local store of an SPU that has been switched to a
different task. Pretty nasty. There is even more nastyness to expect
from drivers that try to DMA from user space using get_user_pages().

The only option here is to forbid get_user_pages() completely, possibly
by setting VM_IO on the VMA. Unfortunately, that means no ptrace access,
thus no way to inspect SPU local store or registers from gdb, which is
pretty annoying.

Also no_pfn() is of no help here. It wuld maybe allow to avoid using
sparsemem and struct pages, but it won't help with the later problem (we
can't allow get_user_pages() to work on such a VMA) and in addition,
do_no_pfn() doesn't implement the truncate logic that do_no_page() does,
which means that it is not protected against racing
unmap_mapping_range() calls, and thus isn't suitable for our context
switching mecanism.

 - Graphics memory

It's becoming increasingly necessary for DRI drivers to have some proper
memory management of "objects" (pixmaps, textures, ...) that are to be
use with the graphics chip. Such objects typically want to migrate
between video memory, system memory (backup), AGP (if any) etc...
depending on pressure on the video memory, number of clients, etc...

The Tungstengrpahics folks (Thomas is on CC) have been working on some
better memory management to properly handle those things in the DRM. One
of the things we want to do here is similar to what the SPUs do with
local store: have a single VMA associated with an object, and have the
PTEs transparently changed to map either video memory, system memory,
AGP memory, etc... (the different in cache attributes can be ignored at
this stage, we can discuss it separately if interested).

I've been suggesting a similar approach as we use for SPUs. That is what
would make the most sense from a user standpoint: user code access their
"objects" via a single virtual pointer and the DRM takes care of
migrating it when necessary (for example migrating it to video RAM when
it needs to be used by the engine and "swap" it back to main memory when
not).

However, we hit the same problems as SPUfs here. The main one is that we
can't use sparsemem. SPU is platofrm specific enough that we can require
arch/powerpc to be configured for sparsemem for cell, but we can't
generally require that for the DRM to work. And anyway, for the same
reasons as SPUs, we don't want struct page anyway.

That leaves us with do_no_pfn() which isn't protected against concurrent
unmap_mapping_range() and thus isn't directly suitable at least not
without changes. And it's also not suitable because it won't handle the
case where we are trying to return memory (we really want proper
accounting for that and thus hit the proper do_no_page() code path).

In addition, we have the same problem of get_user_pages() can't be made
to work, thus no access_process_vm(), thus no ptrace access which can be
fairly annoying.

 - Possible ideas and other issues

Now here are some possible ideas that we've been discussing here or
there and in some case that Thomas tested.

First, a way to not have to use struct page's and still get the benefit
of a working unmap_mapping_range(). The trick here is to use that
NOPAGE_REFAULT thingy that we've just merged in (even if it was for a
different reasons), possibly along with a new helper that we'll call
install_io_pte() or something like that.

The base idea is that we would have the no_page() function of SPU's or
the DRM either return a struct page when the object is backed to main
memory, or install the PTE directly (using the helper to hide some of
the low level TLB flushing logic etc...) and then return NOPAGE_REFAULT
when hitting the hardware. The helper basically is a one-page version of
io_remap_pfn_range() with the added "feature" of not doing anything if
the PTE has been set by somebody else (handle the race case) instead of
BUG'ing as the current io_remap_pfn_range() does.

This would work provided that both SPUfs and the DRM have their own
per-object mutex to protect racing calls to unmap_mapping_range() vs.
install_io_pte(), which is trivial. The truncate logic would take care
of the race if we return a struct page instead (memory backing store).

That doesn't help with get_user_pages() of course. This is a different
issue.

At this point, the above is really I think the best solution, even if it
might smell a bit hairy. It can be implemented with the current upstream
code with just the addition of that install_io_pte() helper i described
(or by making io_remap_pfn_range() not BUG when a PTE is already present
but just skip it instead).

There is one thing I haven't even tried to think about yet but that
might be useful, is for that backing store memory to be swappable
(anonymous memory basically). This seems to me like a can of worms so
I'm ignoring it on purpose at the moment...

Now, regarding get_user_pages(), there are two main users of it I can
think of access_process_vm (ptrace) and drivers that want to DMA
directly in/out of user memory (v4l ?).

I think the later is a lost cause. We just can't use that interface to
allow DMA in/out a user mapping that can change unless there is
synchronisation with whatever agent can change that mapping. That means
for example that if v4l wants to be able to DMA into such DRM managed
objects, then v4l will need to use some DRM interfaces to lock such
objects into place while DMA'ing, etc... so the later is basically a
non-issue: get_user_pages() for such mappings will not work. I don't
think having SPUfs or the DRM block/unblock context switching based on
inspecting page count or such thing is realistic (and racy anyway).

The former is more annoying. There are plenty of reasons why one would
want to use gdb to inspect such things. In fact, it's a general issues
with get_user_pages() vs. IO mappings that one can't, afaik, use GDB to
poke at mapped registers.

I don't know how realistic that is to provide a solution for this. The
only one that comes to mind at this point would be to have
access_process_vm() try to switch the mm to the target mm to do the
accesses (and copy to a temporary kernel buffer). Sounds a bit hairy to
me but I haven't thought enough about it yet to convince myself wether
it can be made to work or not.

I think at this point, I've said it all. There are other little nits
here or there where get_user_pages() also gets in the way (like my usage
of NOPAGE_REFAULT to handle signals, too bad get_user_pages() isn't
supposed to return -EINTR, but then, that's true of __get_user & friends
as well if I ever want to really handle signals in no_page(), but I
think we can keep those for a separate discussion.

Now I await comments and suggestions :)

Cheers,
Ben.



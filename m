Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318063AbSG2Avu>; Sun, 28 Jul 2002 20:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSG2Avu>; Sun, 28 Jul 2002 20:51:50 -0400
Received: from [195.223.140.120] ([195.223.140.120]:16166 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318063AbSG2Avt>; Sun, 28 Jul 2002 20:51:49 -0400
Date: Mon, 29 Jul 2002 02:56:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@zip.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729005612.GM1201@dualathlon.random>
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729004325.GS25038@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729004325.GS25038@holomorphy.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 05:43:25PM -0700, William Lee Irwin III wrote:
> Linus Torvalds wrote:
> >> Dream on. It's good, and it's not getting removed. The "struct page" is
> >> size-critical, and also correctness-critical (see above on gcc issues).
> 
> 32-bit is a sad, broken, and depressing reality we're going to be
> saddled with on mainstream systems for ages. It's stinking up the
> kernel like a dead woodchuck under the porch as it is, and the 64GB
> abominations on their way out the ass-end of hardware vendor pipelines
> are truly vomitous.
> 
> 
> On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
> > Plan B is to remove page->index.
> > - Replace ->mapping with a pointer to the page's radix tree
> >   slot.   Use address masking to go from page.radix_tree_slot
> >   to the radix tree node.
> > - Store the base index in the radix tree node, use math to
> >   derive page->index.  Gives 64-bit index without increasing
> >   the size of struct page. 4 bytes saved.  
> > - Implement radix_tree_gang_lookup() as previously described.  Use
> >   this in truncate_inode_pages, invalidate_inode_pages[2], readahead
> >   and writeback.
> > - The only thing we now need page.list for is tracking dirty pages.
> >   Implement a 64-bit dirtiness bitmap in radix_tree_node, propagate
> >   that up the radix tree so we can efficiently traverse dirty pages
> >   in a mapping.  This also allows writeback to always write in ascending
> >   index order.  Remove page->list.  8 bytes saved.
> > - Few pages use ->private for much.  Hash for it.  4(ish) bytes
> >   saved.
> > - Remove ->virtual, do page_address() via a hash.  4(ish) bytes saved.
> > - Remove the rmap chain (I just broke ptep_to_address() anyway).  4 bytes
> >   saved.  struct page is now 20 bytes.
> > There look.  In five minutes I shrunk 24 bytes from the page
> > structure.  Who said programming was hard?
> 
> This is so aggressive I'm obligated to pursue it. The pte_chain will
> die shortly if I get my way as it is.

if you look at DaveM first full rmap implementation it never had a
pte-chain. He used the same rmap logic we always hand in linux since the
first 2.1 kernel I looked at, to handle correctly truncate against
MAP_SHARED. Unfortunately that's not very efficient and requires some
metadata allocation for anonymous pages (that's the address space
pointer, anon pages regularly doesn't have a dedicated address space),
and overhead that we never had w/o full rmap (and for inode backed
mappings we just have this info in the inode, just the shared_lock
locking isn't trivial). Hope you can came up with a better algorithm
(nevertheless also the current rmap implementation adds significant
measurable overhead in the fast paths), Rik told me a few days ago he
also wanted to drop the pte_chain, but I assume you're just in sync with him.

Andrea

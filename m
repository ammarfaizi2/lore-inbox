Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSG2AkU>; Sun, 28 Jul 2002 20:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSG2AkU>; Sun, 28 Jul 2002 20:40:20 -0400
Received: from holomorphy.com ([66.224.33.161]:14506 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317446AbSG2AkU>;
	Sun, 28 Jul 2002 20:40:20 -0400
Date: Sun, 28 Jul 2002 17:43:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729004325.GS25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D448808.CF8D18BA@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>> Dream on. It's good, and it's not getting removed. The "struct page" is
>> size-critical, and also correctness-critical (see above on gcc issues).

32-bit is a sad, broken, and depressing reality we're going to be
saddled with on mainstream systems for ages. It's stinking up the
kernel like a dead woodchuck under the porch as it is, and the 64GB
abominations on their way out the ass-end of hardware vendor pipelines
are truly vomitous.


On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
> Plan B is to remove page->index.
> - Replace ->mapping with a pointer to the page's radix tree
>   slot.   Use address masking to go from page.radix_tree_slot
>   to the radix tree node.
> - Store the base index in the radix tree node, use math to
>   derive page->index.  Gives 64-bit index without increasing
>   the size of struct page. 4 bytes saved.  
> - Implement radix_tree_gang_lookup() as previously described.  Use
>   this in truncate_inode_pages, invalidate_inode_pages[2], readahead
>   and writeback.
> - The only thing we now need page.list for is tracking dirty pages.
>   Implement a 64-bit dirtiness bitmap in radix_tree_node, propagate
>   that up the radix tree so we can efficiently traverse dirty pages
>   in a mapping.  This also allows writeback to always write in ascending
>   index order.  Remove page->list.  8 bytes saved.
> - Few pages use ->private for much.  Hash for it.  4(ish) bytes
>   saved.
> - Remove ->virtual, do page_address() via a hash.  4(ish) bytes saved.
> - Remove the rmap chain (I just broke ptep_to_address() anyway).  4 bytes
>   saved.  struct page is now 20 bytes.
> There look.  In five minutes I shrunk 24 bytes from the page
> structure.  Who said programming was hard?

This is so aggressive I'm obligated to pursue it. The pte_chain will
die shortly if I get my way as it is.


Cheers,
Bill

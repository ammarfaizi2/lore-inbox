Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318026AbSG1X6z>; Sun, 28 Jul 2002 19:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSG1X6y>; Sun, 28 Jul 2002 19:58:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318026AbSG1X6y>;
	Sun, 28 Jul 2002 19:58:54 -0400
Message-ID: <3D448808.CF8D18BA@zip.com.au>
Date: Sun, 28 Jul 2002 17:10:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of   
 PAGE_{CACHE_,}{MASK,ALIGN}
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> Dream on. It's good, and it's not getting removed. The "struct page" is
> size-critical, and also correctness-critical (see above on gcc issues).
> 

Plan B is to remove page->index.

- Replace ->mapping with a pointer to the page's radix tree
  slot.   Use address masking to go from page.radix_tree_slot
  to the radix tree node.

- Store the base index in the radix tree node, use math to
  derive page->index.  Gives 64-bit index without increasing
  the size of struct page. 4 bytes saved.  

- Implement radix_tree_gang_lookup() as previously described.  Use
  this in truncate_inode_pages, invalidate_inode_pages[2], readahead
  and writeback.

- The only thing we now need page.list for is tracking dirty pages.
  Implement a 64-bit dirtiness bitmap in radix_tree_node, propagate
  that up the radix tree so we can efficiently traverse dirty pages
  in a mapping.  This also allows writeback to always write in ascending
  index order.  Remove page->list.  8 bytes saved.

- Few pages use ->private for much.  Hash for it.  4(ish) bytes
  saved.

- Remove ->virtual, do page_address() via a hash.  4(ish) bytes saved.

- Remove the rmap chain (I just broke ptep_to_address() anyway).  4 bytes
  saved.  struct page is now 20 bytes.

There look.  In five minutes I shrunk 24 bytes from the page
structure.  Who said programming was hard?

-

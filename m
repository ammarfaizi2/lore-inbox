Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277368AbRJEMxt>; Fri, 5 Oct 2001 08:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277369AbRJEMxl>; Fri, 5 Oct 2001 08:53:41 -0400
Received: from [204.177.156.37] ([204.177.156.37]:57335 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S277368AbRJEMx2>; Fri, 5 Oct 2001 08:53:28 -0400
Date: Fri, 5 Oct 2001 13:55:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Bernd Harries <mlbha@gmx.de>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <26148.1001936004@www42.gmx.net>
Message-ID: <Pine.LNX.4.21.0110051327180.997-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001, Bernd Harries wrote:
> 
> I wonder why only I see problems so far. Maybe it's because I also mmap()
> that RAM to user space?

Probably.

munmap() will handle each order-0-page of your order-9
allocation separately.  __get_free_pages gave you count 1 on the
first of those order-0-pages, leaving count 0 on the rest.  I don't
know whether you're following the mmap-makes-all-pages-present
model (using remap_page_range), or the fault-page-by-page model
(supplying your own nopage function).  But either way it sounds like
you bump each page count by 1 when you map it in, and then when it's
unmapped the count goes down to 0 on all the later order-0-pages,
so they get freed before you're done with them.

Either you should force page count 1 on each of the order-0-pages
before you mmap them in (and raise count to 2); or you should set
the Reserved bit on each them, and clear it before freeing (see use
of mem_map_reserve and mem_map_unreserve in various drivers/sound
sources using remap_page_range; there's also a couple of examples
of the nopage method down there too).

Hugh


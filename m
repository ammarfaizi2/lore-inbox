Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313805AbSDJUnm>; Wed, 10 Apr 2002 16:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313816AbSDJUnl>; Wed, 10 Apr 2002 16:43:41 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:53263 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313805AbSDJUnl>; Wed, 10 Apr 2002 16:43:41 -0400
Message-ID: <3CB49578.34C34438@zip.com.au>
Date: Wed, 10 Apr 2002 12:41:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Jackson <jerj@coplanar.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au> <004b01c1e0c6$01d690f0$7e0aa8c0@bridge>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:
> 
> This sounds like a wonderful piece of work.
> I'm also inspired by the rmap stuff coming down
> the pipe.   I wonder if there would be any interference
> between the two, or could they leverage each other?
> 

well the theory is that rmap doesn't need to know. It just
calls writepage when it sees dirty pages. That's a minimal
approach.  But I'd like the VM to aggressively use the
"write out lots of pages in the same call" APIs, rather
than the current "send lots of individual pages" approach.

For a number of reasons:

- For delalloc filesystems, and for sparse mappings
  against "syncalloc" filesystems, disk allocation is
  performed at ->writepage time.  It's important that
  the writes be clustered effectively.  Otherwise
  the file gets fragmented on-disk.

- There's a reasonable chance that the pages on the
  LRU lists get themselves out-of-order as the aging
  process proceeds.  So calling ->writepage in lru_list
  order has the potential to result in fragmented write
  patterns, and inefficient I/O.

- If the VM is trying to free pages from, say, ZONE_NORMAL
  then it will only perform writeout against pages from
  ZONE_NORMAL and ZONE_DMA.  But there may be writable pages
  from ZONE_HIGHMEM sprinkled amongst those pages within the
  file. It would be really bad if we miss out on opportunistically
  slotting those other pages into the same disk request.

- The current VM writeback is an enormous code path.  For each
  tiny little page, we send it off into writepage, pass it
  to the filesystem, give it a disk mapping, give it a buffer_head,
  submit the buffer_head, attach a tiny BIO to the buffer_head,
  submit the BIO, merge that onto a request structure which
  contains contiguous BIOs, feed that list-of-single-page-BIOs
  to the device driver.

  That's rather painful.   So the intent is to batch this work
  up.  Instead, the VM says "write up to four megs from this
  page's mapping, including this page".

  That request passes through the filesystem and we wrap 64k
  or larger BIOs around the pagecache data and put those into
  the request queue.  For some filesystems the buffer_heads
  are ignored altogether.  For others, the buffer_head
  can be used at "build the big BIO" time to work out how to
  segment the BIOs across sub-page boundaries.

  The "including this page" requirement of the vm_writeback
  method is there because the VM may be trying to free pages
  from a specific zone, so it would be not useful if the
  filesystem went and submitted I/O for a ton of pages which
  are all from the wrong zone.  This is a bit of an ugly
  back-compatible placeholder to keep the VM happy before
  we move on to that part of it.

-

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270382AbSISIOv>; Thu, 19 Sep 2002 04:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270509AbSISIOv>; Thu, 19 Sep 2002 04:14:51 -0400
Received: from packet.digeo.com ([12.110.80.53]:36748 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S270382AbSISIOu>;
	Thu, 19 Sep 2002 04:14:50 -0400
Message-ID: <3D89889C.F5868818@digeo.com>
Date: Thu, 19 Sep 2002 01:19:40 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.35-mm1
References: <3D858515.ED128C76@digeo.com> <E17rw5X-0000vG-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 08:19:46.0490 (UTC) FILETIME=[508C81A0:01C25FB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Monday 16 September 2002 09:15, Andrew Morton wrote:
> > A 4x performance regression in heavy dbench testing has been fixed. The
> > VM was accidentally being fair to the dbench instances in page reclaim.
> > It's better to be unfair so just a few instances can get ahead and submit
> > more contiguous IO.  It's a silly thing, but it's what I meant to do anyway.
> 
> Curious... did the performance hit show anywhere other than dbench?

Other benchmarky tests would have suffered, but I did not check.

I have logic in there which is designed to throttle heavy writers
within the page allocator, as well as within balance_dirty_pages.
basically:

	generic_file_write()
	{
		current->backing_dev_info = mapping->backing_dev_info;
		alloc_page()
		current->backing_dev_info = 0;
	}

	shrink_list()
	{
		if (PageDirty(page)) {
			if (page->mapping->backing_dev_info == current->backing_dev_info)
				blocking_write(page->mapping);
			else
				nonblocking_write(page->mapping);
		}
	}


What this says is "if this task is prepared to block against this
page's queue, then write the dirty data, even if that would block".

This means that all the dbench instances will write each other's
dirty data as it comes off the tail of the LRU.  Which provides
some additional throttling, and means that we don't just refile
the page.

But the logic was not correctly implemented.  The dbench instances
were performing non-blocking writes.  This meant that all 64 instances
were cheerfully running all the time, submitting IO all over the disk.
The /proc/meminfo:Writeback figure never even hit a megabyte.  That
number tells us how much memory is currently in the request queue.
Clearly, it was very fragmented.

By forcing the dbench instance to block on the queue, particular instances
were able to submit decent amounts of IO.  The `Writeback' figure went
back to around 4 megabytes, because the individual requests were
larger - more merging.

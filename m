Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269341AbUIBXug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269341AbUIBXug (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269307AbUIBXuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:50:15 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:60817 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269373AbUIBXtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:49:21 -0400
Date: Fri, 03 Sep 2004 08:54:31 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] buddy allocator without bitmap(3) [1/3]
In-reply-to: <4136D318.9060102@jp.fujitsu.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>
Message-id: <4137B2B7.8080109@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <4136D318.9060102@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> New function: calculate_aligned_end()
> 
> calculate_aligned_end() removes some pages from system for removing invalid
> mem_map access from __free_pages_bulk() main loop.(This is in 4th patch)
> 
This is an illustration of the effects of calculate_aligned_end().

Examples for MAX_ORDER=4 is here.
In this case, an alignment of memmap is (1 << (4-1))=8

[unaligned end address case]

Consider contiguous mem_map from index 0 to index 19.
mem_map[16-19] is unaligned.

pfn     0           4           8          12            16 17 18 19
         -------------------------------------------------------------
order 0 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  -- out of range --
         -------------------------------------------------------------
order 1 |     |     |     |     |     |     |     |     |     |     |
         -------------------------------------------------------------
order 2 |           |           |           |           |           |
         ------------------------------------------------------------
order 3 |                       |                       |
         -------------------------------------------------
         <----------------------> <---------------------> <---------??? ---->
In this case, invalid mem_map access will occur during

(1) coalescing page 16 with page 20 in order=2. <- this means memory access to page 20.

calculate_aligned_end() removes page 19.

  pfn     0           4           8          12            16 17 18 19
         -------------------------------------------------------------
order 0 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | X|   -- out of range --
         -------------------------------------------------------------
order 1 |     |     |     |     |     |     |     |     |     |
         -------------------------------------------------------
order 2 |           |           |           |           |
         -------------------------------------------------
order 3 |                       |                       |
         -------------------------------------------------
         <----------------------> <--------------------->

         page 19 is removed.
         -> page 18 and page 19 cannot be coalesced.
         -> page 16 - page 19 cannot be coalesced.
         -> accessing invalid page 20 will not occur.


[unaligned start address case]
Consider a mem_map begins from index 2.

pfn     0     2     4           8          12           16
               -------------------------------------------------------------------
order 0       |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
               -------------------------------------------------------------------
order 1       |     |     |     |     |     |     |     |     |     |     |     |
               --------------------------------------------------------------------
order 2             |           |           |           |           |           |
                     -------------------------------------------------------------
order 3                         |                       |                       |
                                 -------------------------------------------------

In this case, invalid mem_map access will occur during
	(1) coalescing page 2 and page 0 in order=1
	(2) coalescing page 4 and page 0 in order=2

calculate_aligned_end() removes page 2 and 4.

pfn     0     2     4           8          12           16
               -------------------------------------------------------------------
order 0       |x |  |x |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
               -------------------------------------------------------------------
order 1                   |     |     |     |     |     |     |     |     |     |
                           --------------------------------------------------------
order 2                         |           |           |           |           |
                                 -------------------------------------------------
order 3                         |                       |                       |
                                 -------------------------------------------------

	page 2 is removed.
	-> page 2 and page 3 cannot be coalesced in order=0
	-> accessing invalid page 0 in order=1 will not occur.
	
	page 4 is removed.
	-> page 4 and page 5 cannot be coalesced in order=0.
	-> page 4 and page 6 cannot be coalesced in order=1.
	-> accessing invalid page 0 in order=2 will not occur.

Thanks.
--Kame
-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


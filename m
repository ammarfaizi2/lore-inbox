Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSIESsq>; Thu, 5 Sep 2002 14:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318014AbSIESsq>; Thu, 5 Sep 2002 14:48:46 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:41737 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318031AbSIESsq>; Thu, 5 Sep 2002 14:48:46 -0400
Message-ID: <3D77A7A3.FBA1C598@zip.com.au>
Date: Thu, 05 Sep 2002 11:51:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Race in shrink_cache
References: <E17mooe-00064m-00@starship> <E17mr4K-000660-00@starship> <3D770D77.BF85645E@zip.com.au> <E17n1ZQ-00069v-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ..
> On the other hand, if what you want is a private list that page_cache_release
> doesn't act on automatically, all you have to do is set the lru state to zero,
> leave the page count incremented and move to the private list.  You then take
> explicit responsibility for freeing the page or moving it back onto a
> mainstream lru list.

That's the one.  Page reclaim speculatively removes a chunk (typically 32) of
pages from the LRU, works on them, and puts back any unfreeable ones later
on.  And the rest of the VM was taught to play correctly with pages that
can be off the LRU.  This was to avoid hanging onto the LRU lock while
running page reclaim.

And when those 32 pages are speculatively removed, their refcounts are
incremented.  Maybe that isn't necessary - I'd need to think about
that.  If it isn't, then the double-free thing is fixed.  If it is
necessary then then lru-adds-a-ref approach is nice, because shrink_cache
doesn't need to page_cache_get each page while holding the LRU lock,
as you say.

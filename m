Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318144AbSIETOy>; Thu, 5 Sep 2002 15:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSIETOy>; Thu, 5 Sep 2002 15:14:54 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:6413 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318144AbSIETOx>; Thu, 5 Sep 2002 15:14:53 -0400
Message-ID: <3D77ADC3.938C09F8@zip.com.au>
Date: Thu, 05 Sep 2002 12:17:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Lever <cel@citi.umich.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77A22A.DC3F4D1@zip.com.au> <Pine.BSO.4.33.0209051439540.12826-100000@citi.umich.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever wrote:
> 
> On Thu, 5 Sep 2002, Andrew Morton wrote:
> 
> > That all assumes SMP/preempt.  If you're seeing these problems on
> > uniproc/non-preempt then something fishy may be happening.
> 
> sorry, forgot to mention:  the system is UP, non-preemptible, high mem.
> 
> invalidate_inode_pages isn't freeing these pages because the page count is
> two.  perhaps the page count semantics of one of the page cache helper
> functions has changed slightly.  i'm still diagnosing.

OK, thanks.  I can't immediately think of anything which would have
altered the refcounting in there except for page reclaim.  

What you could do is to check whether the `page_count(page) != 1'
pages are on the LRU.  If they have !PageLRU(page) then the extra
ref was taken by shrink_cache().  But that would be pretty rare,
especially on UP.

You may have more success using the stronger invalidate_inode_pages2().

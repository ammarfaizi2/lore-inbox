Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319153AbSILWqr>; Thu, 12 Sep 2002 18:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319156AbSILWqr>; Thu, 12 Sep 2002 18:46:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:4298 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319153AbSILWqp>;
	Thu, 12 Sep 2002 18:46:45 -0400
Message-ID: <3D811A6C.C73FEC37@digeo.com>
Date: Thu, 12 Sep 2002 15:51:24 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       Daniel Phillips <phillips@arcor.de>, trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D811363.70ABB50C@digeo.com> <Pine.LNX.4.44L.0209121926310.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 22:51:27.0134 (UTC) FILETIME=[ED4533E0:01C25AAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 12 Sep 2002, Andrew Morton wrote:
> 
> > Well the lazy invalidation would be OK - defer that to the next
> > userspace access,
> 
> I think I have an idea on how to do that, here's some pseudocode:
> 
> invalidate_page(struct page * page) {
>         SetPageInvalidated(page);
>         rmap_lock(page);
>         for_each_pte(pte, page) {
>                 make pte PROT_NONE;
>                 flush TLBs for this virtual address;
>         }
>         rmap_unlock(page);
> }
> 
> And in the page fault path:
> 
> if (pte_protection(pte) == PROT_NONE && PageInvalidated(pte_page_pte)) {
>         clear_pte(ptep);
>         page_cache_release(page);
>         mm->rss--;
> }
> 

That's the bottom-up approach.  The top-down (vmtruncate) approach
would also work, if the locking is suitable.

Look, idunnoigiveup.  Like scsi and USB, NFS is a black hole
where akpms fear to tread.  I think I'll sulk until someone
explains why this work has to be performed in the context of
a process which cannot do it.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318285AbSIKCQl>; Tue, 10 Sep 2002 22:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSIKCQl>; Tue, 10 Sep 2002 22:16:41 -0400
Received: from dsl-213-023-020-046.arcor-ip.net ([213.23.20.46]:61150 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318285AbSIKCQi>;
	Tue, 10 Sep 2002 22:16:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Wed, 11 Sep 2002 04:14:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Chuck Lever <cel@citi.umich.edu>, Rik van Riel <riel@conectiva.com.br>,
       trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu> <E17ovlW-0007Jd-00@starship> <3D7EA125.5959085D@digeo.com>
In-Reply-To: <3D7EA125.5959085D@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ox13-0007Ki-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 03:49, Andrew Morton wrote:
> Daniel Phillips wrote:
> > So we just quietly drop any dirty memory mapped to a file if the user doesn't
> > run msync?  Is that correct behaviour?  It sure sounds wrong.
> 
> If the page is truncated then yes.  (indirectly: the pte dirty
> state gets flushed into PG_dirty which is then invalidated).
> 
> Otherwise, no.  The pte dirtiness is propagated into PG_dirty when
> the pte is detached from the page.  See try_to_unmap_one() - it is
> quite straightforward.

Yep, that's what I meant the first time round.  Had me worried for a moment
there...

The specific path I was refering to is:

  sys_munmap->
     unmap_region->
         unmap_page_range->
            zap_pmd_range->
               zap_pte_range->

                      if (pte_dirty(pte))
                               set_page_dirty(page);

Which is the definitive way of getting the data onto disk.  It's weird that
msync has to be different from fsync, or that fsync does not imply msync,
but that's the posix folks for ya, I'm sure they threw a dart blindfolded
at a list of reasons and came up with one.

-- 
Daniel

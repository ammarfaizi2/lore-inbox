Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318269AbSIKB3p>; Tue, 10 Sep 2002 21:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318270AbSIKB3p>; Tue, 10 Sep 2002 21:29:45 -0400
Received: from packet.digeo.com ([12.110.80.53]:61830 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318269AbSIKB3o>;
	Tue, 10 Sep 2002 21:29:44 -0400
Message-ID: <3D7EA125.5959085D@digeo.com>
Date: Tue, 10 Sep 2002 18:49:25 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Chuck Lever <cel@citi.umich.edu>, Rik van Riel <riel@conectiva.com.br>,
       trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu> <E17ovLv-0007JB-00@starship> <3D7E909A.512C23C1@digeo.com> <E17ovlW-0007Jd-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2002 01:34:25.0619 (UTC) FILETIME=[5CE01A30:01C25933]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Wednesday 11 September 2002 02:38, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > >
> > > > ...
> > > We do get
> > > around to walking the ptes at file close I believe.  Is that not driven by
> > > zap_page_range, which moves any orphaned pte dirty bits down into the struct
> > > page?
> >
> > Nope, close will just leave all the pages pte-dirty or PageDirty in
> > memory.  truncate will nuke all the ptes and then the pagecache.
> >
> > But the normal way in which pte-dirty pages find their way to the
> > backing file is:
> >
> > - page reclaim runs try_to_unmap or
> >
> > - user runs msync().  (Which will only clean that mm's ptes!)
> >
> > These will run set_page_dirty(), making the page visible to
> > one of the many things which run writeback.
> 
> So we just quietly drop any dirty memory mapped to a file if the user doesn't
> run msync?  Is that correct behaviour?  It sure sounds wrong.
> 

If the page is truncated then yes.  (indirectly: the pte dirty
state gets flushed into PG_dirty which is then invalidated).

Otherwise, no.  The pte dirtiness is propagated into PG_dirty when
the pte is detached from the page.  See try_to_unmap_one() - it is
quite straightforward.

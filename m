Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319532AbSIGWu1>; Sat, 7 Sep 2002 18:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319534AbSIGWu0>; Sat, 7 Sep 2002 18:50:26 -0400
Received: from packet.digeo.com ([12.110.80.53]:49808 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319532AbSIGWu0>;
	Sat, 7 Sep 2002 18:50:26 -0400
Message-ID: <3D7A8718.E626D3C7@digeo.com>
Date: Sat, 07 Sep 2002 16:09:12 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Daniel Phillips <phillips@arcor.de>, trond.myklebust@fys.uio.no,
       Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <E17natE-0006OB-00@starship> <Pine.LNX.4.44L.0209071547250.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Sep 2002 22:55:00.0289 (UTC) FILETIME=[98415310:01C256C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sat, 7 Sep 2002, Daniel Phillips wrote:
> > On Friday 06 September 2002 00:19, Andrew Morton wrote:
> > > I'm not sure what semantics we really want for this.  If we were to
> > > "invalidate" a mapped page then it would become anonymous, which
> > > makes some sense.
> >
> > There's no need to leave the page mapped, you can easily walk the rmap list
> > and remove the references.
> 
> A pagefaulting task can have claimed a reference to the page
> and only be waiting on the lock we're currently holding.

Yup.  In which case it comes away with an anonymous page.

I'm very unkeen about using the inaccurate invalidate_inode_pages
for anything which matters, really.   And the consistency of pagecache
data matters.

NFS should be using something stronger.  And that's basically
vmtruncate() without the i_size manipulation.  Hold i_sem,
vmtruncate_list() for assured pagetable takedown, proper page
locking to take the pages out of pagecache, etc.

Sure, we could replace the page_count() heuristic with a
page->pte.direct heuristic.  Which would work just as well.  Or
better.  Or worse.  Who knows?


Guys, can we sort out the NFS locking so that it is possible to
take the correct locks to get the 100% behaviour?

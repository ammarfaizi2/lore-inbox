Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318966AbSIIWYu>; Mon, 9 Sep 2002 18:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSIIWXS>; Mon, 9 Sep 2002 18:23:18 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:9666 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318945AbSIIWWP>;
	Mon, 9 Sep 2002 18:22:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Tue, 10 Sep 2002 00:19:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, trond.myklebust@fys.uio.no,
       Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E17natE-0006OB-00@starship> <E17oWKH-0006uw-00@starship> <3D7D1AB4.B465ABE8@digeo.com>
In-Reply-To: <3D7D1AB4.B465ABE8@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oWsf-0006vQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 00:03, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > > I'm very unkeen about using the inaccurate invalidate_inode_pages
> > > for anything which matters, really.   And the consistency of pagecache
> > > data matters.
> > >
> > > NFS should be using something stronger.  And that's basically
> > > vmtruncate() without the i_size manipulation.
> > 
> > Yes, that looks good.  Semantics are basically "and don't come back
> > until every damm page is gone" which is enforced by the requirement
> > that we hold the mapping->page_lock though one entire scan of the
> > truncated region.  (Yes, I remember sweating this one out a year
> > or two ago so it doesn't eat 100% CPU on regular occasions.)
> > 
> > So, specifically, we want:
> > 
> > void invalidate_inode_pages(struct inode *inode)
> > {
> >         truncate_inode_pages(mapping, 0);
> > }
> > 
> > Is it any harder than that?
> 
> Pretty much - need to leave i_size where it was.

This doesn't touch i_size.

> But there are
> apparently reasons why NFS cannot sleepingly lock pages in this particular
> context.

If only we knew what those were.  It's hard to keep the word 'bogosity'
from popping into my head.

-- 
Daniel

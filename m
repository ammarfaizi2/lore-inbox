Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317184AbSEXPVp>; Fri, 24 May 2002 11:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317185AbSEXPVo>; Fri, 24 May 2002 11:21:44 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32292 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317184AbSEXPVm>; Fri, 24 May 2002 11:21:42 -0400
Date: Fri, 24 May 2002 17:20:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, kuznet@ms2.inr.ac.ru,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: inode highmem imbalance fix [Re: Bug with shared memory.]
Message-ID: <20020524152037.GK21164@dualathlon.random>
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au> <20020520043040.GA21806@dualathlon.random> <20020524073341.GJ21164@dualathlon.random> <3CEDF413.34B1B649@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 01:04:35AM -0700, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Mon, May 20, 2002 at 06:30:40AM +0200, Andrea Arcangeli wrote:
> > > As next thing I'll go ahead on the inode/highmem imbalance repored by
> > > Alexey in the weekend.  Then the only pending thing before next -aa is
> > 
> > Here it is, you should apply it together with vm-35 that you need too
> > for the bh/highmem balance (or on top of 2.4.19pre8aa3).
> 
> Looks OK to me.  But I wonder if it should be inside some config
> option - I don't think machines with saner memory architectures
> would want this?

This assumes that this hurts lowmem machines, hopefully it's not the
case. The vm bangs on the icache only when there's some remote sign of
pagecache shortage and if the whole icache is totally pinned by clean
pagecache, and there's some sign of pagecache shortage it is probably ok
to do an invalidate to release it. We were doing it in 2.2 too of course
(in a different simpler manner with truncate_inode_pages because there
was no problem in 2.2 in being destructive against the pgaecache, the
dirty cache was always on the buffercache side in 2.2).

> 
> > ...
> > +                                        * in practice. Also keep in mind if somebody
> > +                                        * keeps overwriting data in a flood we'd
> > +                                        * never manage to drop the inode anyways,
> > +                                        * and we really shouldn't do that because
> > +                                        * it's an heavily used one.
> > +                                        */
> 
> Can anyone actually write to an inode which is on the unused
> list?

no you can't (if it's in the unused list, not even a single dentry is
teking it pinned, that means nobody can have it open, it's not even
cached in unused dentries), but the inode can have async dirty buffers
or dirty pages (if also the inode is marked dirty, not only the pages,
unless it's ramfs), so it may be cosntantly not freeable if bdflush
cannot keep up with the writer.  Doesn't look a pratical problem, in
such case the inode is very hot and it doesn't worth to shrink it.

> 
> > +                                       wakeup_bdflush();
> > +                               else if (inode->i_data.nrpages)
> > +                                       /*
> > +                                        * If we're here it means the only reason
> > +                                        * we cannot drop the inode is that its
> > +                                        * due its pagecache so go ahead and trim it
> > +                                        * hard. If it doesn't go away it means
> > +                                        * they're dirty or dirty/pinned pages ala
> > +                                        * ramfs.
> > +                                        *
> > +                                        * invalidate_inode_pages() is a non
> > +                                        * blocking operation but we introduce
> > +                                        * a dependency order between the
> > +                                        * inode_lock and the pagemap_lru_lock,
> > +                                        * the inode_lock must always be taken
> > +                                        * first from now on.
> > +                                        */
> > +                                       invalidate_inode_pages(inode);
> 
> It seems that a call to try_to_free_buffers() has snuck into
> invalidate_inode_pages().  That means that clean ext3 pages
> which are on the checkpoint list won't be released.  Could you
> please change that to try_to_release_page()?

Indeed. thanks!

Andrea

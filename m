Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbUKYJxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUKYJxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 04:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbUKYJxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 04:53:10 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:17366 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263027AbUKYJxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 04:53:02 -0500
To: bulb@ucw.cz
CC: avi@argo.co.il, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <20041125074741.GC29278@vagabond> (message from Jan Hudec on Thu,
	25 Nov 2004 08:47:41 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <20041125062649.GB29278@vagabond> <E1CXE4k-0000Ow-00@dorka.pomaz.szeredi.hu> <20041125074741.GC29278@vagabond>
Message-Id: <E1CXFir-0000TI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 25 Nov 2004 10:15:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Why not?  I can set bdi->memory_backed to 1 just like ramfs, implement
> > my own writeback thread, and voila, no deadlock.
> 
> Yes, you can. Just you have to take care never to occupy too much
> memory.

Yes, this is the hard part IMO, because it should be done in a way
that when FUSE wants a new writable page and it's over the limit, it
should block until it goes under the limit.  Not trivial at all.

> > Of course I believe, that it's probably easier to tweak the page cache
> > to teach it that fuse pages _can_ be written back, but not reliably
> > like a disk filesystem.  And there's the small problem of limiting the
> > number of writable pages allocated to FUSE.
> 
> It's not that easy. How do you tell when the page is no longer likely to
> get cleaned?

Tell the page cache it's never going to get cleaned, but call the
writepage() anyway.  It's sort of splitting the bdi->memory_backed
flag into two: dont_count_as_dirty and dont_writeback.  Ramfs, etc
would set both, FUSE would set only dont_count_as_dirty.  See what I'm
thinking of?

> The file backing would be easier, but to be really easy, the interface
> would be a bit different (and actualy simpler, since it would need no
> data channel, just a control one).

That's not a problem.

> The trick is, that the coda file-granularity interface is not that hard
> to extend to page-granularity. Several filesystems allow "files with
> holes". So the fuse process could just touch a file and truncate it to
> desired length on open. Then kernel would tell it which pages it wants
> and the process would acknowledge when they are actualy filled. For
> write, kernel would just notify the process of dirty ranges and what --
> and when -- the process does with that is not kernel's business.

Yes, this would be a nice interface.  How would you solve the problem
of freeing the space which is no longer needed?

Imagine that you have a 4G virtual file on a FUSE filesystem, and some
process is reading that file sequentially.  But there's only 10MByte
of free space on the local disk.  With the above method you'd never be
able to read the whole file.  Do you see the problem?

Miklos


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273131AbRIRSTz>; Tue, 18 Sep 2001 14:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273132AbRIRSTp>; Tue, 18 Sep 2001 14:19:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28414 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273131AbRIRST2>;
	Tue, 18 Sep 2001 14:19:28 -0400
Date: Tue, 18 Sep 2001 14:19:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <Pine.LNX.4.33.0109180935180.2077-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0109181354470.27125-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Linus Torvalds wrote:

> 
> On Tue, 18 Sep 2001, Alexander Viro wrote:
> >
> > Umm...  Linus, had you actually read through the fs/block_device.c part
> > of that?  It's not just ugly as hell, it's (AFAICS) not hard to oops
> > if you have several inodes sharing major:minor.  ->bd_inode and its
> > treatment are bogus.  Please, read it through and consider reverting -
> > in its current state code is an ugly mess.
> 
> Funny that you mention it, because I actually have a cunning plan, and
> you're an unwitting part of it.

/me swears

Yes, we can make it work that way (see downthread).  Yes, combined with
lazy allocation (and pipefs-like scheme) it can turn into nice, _working_
code.

But right now we have
	a) broken patch applied to the tree
	b) somewhat tested patch that may (after being modified so that it
would _apply_ to -pre11) fix the breakage.  Once it's tested enough to
be consider as a candidate for inclusion, that is.

IMNSHO it's somewhat less than ideal situation.  I've already talked to
with Andrea and once he gets back to life (no, 'e's just sleepin') we'll
try to do something usable.  Life would be much simpler if aforementioned
cunning plan included sending mail to participants (me and Andrea) before
putting the patch into the tree, though.  Oh, well...

> Or actually, I hope you're a "witting" part of it, because it's going to
> be your code.
> 
> Take your "struct block_device" code, add a "struct address_space" to it,
> and whenever a block device inode is opened, make the inode->i_mapping
> point to &bdev->b_data, and voila..
> 
> You already get all the reference counting right, and it's the only
> sensible place to do it anyway, wouldn't you agree?
> 
> I thought you'd be thrilled. It seems to match your lazy allocation patch
> very well..

It can be modified so that combination with lazy-bdev and pipefs-like tree
would work.  And yes, most of the ugliness would just go away.

The problem being, I'd rather do it in a different order -
	1) finish testing of lazy-bdev
	2) apply well-tested patch
	3) test modified bedv-in-pagecache patch
	4) apply it, once it got public testing.

As it is, we'll do combined patch, diff it against -pre11 and submit
for inclusion - new hole in the main tree needs fixing...


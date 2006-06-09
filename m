Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWFISWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWFISWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWFISWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:22:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751472AbWFISWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:22:30 -0400
Date: Fri, 9 Jun 2006 11:22:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <20060609181020.GB5964@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <20060609181020.GB5964@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Andreas Dilger wrote:
> missing from one filesystem or another.
> 
> > Just as an example: ext3 _sucks_ in many ways. It has huge inodes that
> > take up way too much space in memory. It has absolutely disgusting code to
> > handle directory reading and writing (buffer heads! In 2006!).
> 
> My point exactly!  The ext2 directory code was moved from buffer heads to
> page cache by Al after ext3 was forked and the code was never fixed in ext3.

The code was never fixed in ext3, because ext3 is a pig in that area.

You misunderstand how this worked.

The reason ext2 got fixed was that ext2 was _simple_. It got fixed 
_despite_ the fact that it's not all that widely used any more, and not 
considered a really important filesystem. It got fixed because it wasn't 
too bad. It doesn't have all the crud that makes it a much more involved 
thing to do for ext3.

So if the ext2/3 split hadn't happened, _neither_ of them would be fixed.

See?

My point is, maintaining two different pieces is SIMPLER.

Even if that simplicity sometimes ends up meaning "not maintaining the 
other one".

So being out of sync is not a problem. It's a _feature_. 

> On Jun 09, 2006  09:54 -0700, Linus Torvalds wrote:
> > Btw, I'm not kidding you on this one.
> > 
> > THE NUMBER ONE MEMORY USAGE ON A LOT OF LOADS IS EXT3 INODES IN MEMORY!
> 
> Do you think that would be any different with a new filesystem?

It would be bigger, if you made ext3 do 48-bit block numbers.

See? ext3 would become strictly _worse_ for the majority of users, who 
wouldn't get any advantage. That's my point.

> So, the ext3 inode could grow another ~50 bytes without changing the
> slab allocation size ;-), and in fact other filesystem aren't noticably
> different.

Yes, I already pointed out that the biggest part of it was actually the 
vfs_inode thing.

And btw, growing more than 50 bytes is exactly what it would do. Go look.

> This is then the biggest problem of all filesystems.

Yeah, under many loads it is. We do really badly with lots of metadata in 
memory. Why do you think people have historically complained about things 
like the updatedb flushing their disk cache?

If you look at disk access patterns, one of _the_ biggest problems is not 
in readign individual files. It's in inode atime updates and the other 
"stupid crap" stuff.

> On a 32-bit system the vfs_inode is more than half of the size of the ext3
> inode, it is worse on 64-bit systems.

..which I pointed out, and doesn't change my point one _whit_. 

The fact that the block numbers aren't the _only_ problem doesn't suddenly 
mean they are problem-free, does it?

			Linus

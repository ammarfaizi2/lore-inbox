Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312515AbSC3TqP>; Sat, 30 Mar 2002 14:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312509AbSC3TqF>; Sat, 30 Mar 2002 14:46:05 -0500
Received: from www.wen-online.de ([212.223.88.39]:27410 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S312505AbSC3Tpt>;
	Sat, 30 Mar 2002 14:45:49 -0500
Date: Sat, 30 Mar 2002 20:47:37 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: vfs_unlink() >=2.5.5-pre1 question
In-Reply-To: <Pine.GSO.4.21.0203301321090.2590-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10203302034380.296-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2002, Alexander Viro wrote:

> On Sat, 30 Mar 2002, Mike Galbraith wrote:
> 
> > On Sat, 30 Mar 2002, Mike Galbraith wrote:
> > 
> > > Hi,
> > > 
> > > d_delete() doesn't appear to ever create negative dentries when
> > > called via vfs_unlink() due to the extra reference on the dentry.
> > > In fact, a printk() in the d_delete() spot never ever triggers...
> > 
> > Well shoot.  I guess I've chased this about as far as I can, and
> > hope this thread wasn't a total waste.  I found a better way to
> > get my rm -r to work as before fwiw.  Rewinding the directory on
> > seek failure (yeah, could do in three lines, but not the point)
> > works, but is kinda b0rken.  I think the only interesting thing
> > in the below is the FIXME :)) but I'll post it anyway.
> 
> Your patch is broken.  FWIW, there are several real issues:

I'm not in the least suprised.  (Actually, I'm rather pleased with
that assesment;)

> 	a) d_delete() being called too early in vfs_unlink().  Not a big
> deal, it's easy to move outside of dget()/dput().  However, you _can't_

Ok, at least here I was onto something.

> expect unlink() to make dentry negative.  It's always possible that it
> will be left positive and unhashed - that's what we have to do if file
> we are unlinking is opened.

This one I'll have to fiddle with (thanks!).  I was just looking at
the behavior delta, missing any real understanding of the 'why'.

> 	b) rm -rf expecting offsets in directory to stay stable after
> unlink().  B0rken, complain to GNU folks.  Sorry, I'm not touching that
> code - GNU fileutils source is too yucky.

That was my starting point. (I kinda agree, but it's better than anything
_I_ could write from scratch, so..)

> 	c) dcache_readdir() behaviour.  There was an old patch that makes
> it slightly more forgiving; I'll dig it out.

I'd love to see it

	-Mike


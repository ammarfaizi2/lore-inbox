Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313515AbSC3S2k>; Sat, 30 Mar 2002 13:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313524AbSC3S2a>; Sat, 30 Mar 2002 13:28:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32741 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313515AbSC3S2O>;
	Sat, 30 Mar 2002 13:28:14 -0500
Date: Sat, 30 Mar 2002 13:28:13 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Galbraith <mikeg@wen-online.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: vfs_unlink() >=2.5.5-pre1 question
In-Reply-To: <Pine.LNX.4.10.10203301734490.649-100000@mikeg.wen-online.de>
Message-ID: <Pine.GSO.4.21.0203301321090.2590-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Mar 2002, Mike Galbraith wrote:

> On Sat, 30 Mar 2002, Mike Galbraith wrote:
> 
> > Hi,
> > 
> > d_delete() doesn't appear to ever create negative dentries when
> > called via vfs_unlink() due to the extra reference on the dentry.
> > In fact, a printk() in the d_delete() spot never ever triggers...
> 
> Well shoot.  I guess I've chased this about as far as I can, and
> hope this thread wasn't a total waste.  I found a better way to
> get my rm -r to work as before fwiw.  Rewinding the directory on
> seek failure (yeah, could do in three lines, but not the point)
> works, but is kinda b0rken.  I think the only interesting thing
> in the below is the FIXME :)) but I'll post it anyway.

Your patch is broken.  FWIW, there are several real issues:
	a) d_delete() being called too early in vfs_unlink().  Not a big
deal, it's easy to move outside of dget()/dput().  However, you _can't_
expect unlink() to make dentry negative.  It's always possible that it
will be left positive and unhashed - that's what we have to do if file
we are unlinking is opened.
	b) rm -rf expecting offsets in directory to stay stable after
unlink().  B0rken, complain to GNU folks.  Sorry, I'm not touching that
code - GNU fileutils source is too yucky.
	c) dcache_readdir() behaviour.  There was an old patch that makes
it slightly more forgiving; I'll dig it out.


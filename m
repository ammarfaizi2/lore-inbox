Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262675AbSJGXmI>; Mon, 7 Oct 2002 19:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262637AbSJGXmI>; Mon, 7 Oct 2002 19:42:08 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:15117 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262675AbSJGXmF>; Mon, 7 Oct 2002 19:42:05 -0400
Date: Mon, 7 Oct 2002 16:47:41 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not3.0 - (NUMA))
Message-ID: <20021007234740.GA6537@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1034021669.26502.19.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.33.0210071331220.10749-100000@penguin.transmeta.com> <3DA1F9AD.1F3BF949@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA1F9AD.1F3BF949@digeo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 02:16:29PM -0700, Andrew Morton wrote:
> Linus Torvalds wrote:
> > 
> > On 7 Oct 2002, Alan Cox wrote:
> > >
> > > Factoring the uid/gid/pid in actually may help in other ways. If we are
> > > doing it by pid or by uid we will reduce the interleave of multiple
> > > files thing you sometimes get
> > 
> > 'pid' would probably work better than what we have now, even though I bet
> > it would get confused by a large number of installers (ie "make install"
> > in just about any project will use multiple different processes to copy
> > over separate subdirectories. In the X11R6 tree it uses individual "cp"
> > processes for each file!)
> > 
> > The session ID would avoid some of that, but they both have a fundamental
> > problem: neither pid nor session ID is actually saved in any directory
> > structure, so it's quite hard to use that as a heuristic for whether a new
> > file should go into the same directory group as the directory it is
> > created in.
> > 
> > That's why "uid" would work better.
> 
> Sound good to me.  At leat this puts a veneer of respectability over
> decapitating find_group_other(), which is really what we all want
> to do anyway ;)
> 
> > The uid has a different issue, though,
> > namely the fact that when user directories are created, they are basically
> > always created as uid 0 first, and then a "chown" - which means that the
> > user heuristic wouldn't actually trigger at the right time. So the
> > heuristic couldn't be just "newfile->uid == directory->uid", it would have
> > to be something better.
> 
> Last time, Al suggested that we always use the find_group_other() approach
> if the directory is being made at the top-level of the filesystem.  So
> if /home is a mountpoint, the user directories get spread out.
> 
> I think this, and the UID comparison will be good enough.

How about UID == 0?  Other than install and restore tree
creation (top levels) is done by root but tree population
tends to be done by non-root.  That would cause /home/* or
/project/* etc to be in seperate groups but the contents of
each would (mostly) have locality. 

Let's see, that would be..

-       if (S_ISDIR(mode))
+       if (S_ISDIR(mode) && !current->fsuid)
                group = find_group_dir(sb, dir->u.ext2_i.i_block_group);
        else
                group = find_group_other(sb, dir->u.ext2_i.i_block_group);



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

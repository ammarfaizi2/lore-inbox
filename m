Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263308AbSJGVK7>; Mon, 7 Oct 2002 17:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263309AbSJGVK7>; Mon, 7 Oct 2002 17:10:59 -0400
Received: from packet.digeo.com ([12.110.80.53]:9401 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263308AbSJGVK5>;
	Mon, 7 Oct 2002 17:10:57 -0400
Message-ID: <3DA1F9AD.1F3BF949@digeo.com>
Date: Mon, 07 Oct 2002 14:16:29 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not3.0 -  
 (NUMA))
References: <1034021669.26502.19.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.33.0210071331220.10749-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2002 21:16:29.0837 (UTC) FILETIME=[CDBE6BD0:01C26E46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On 7 Oct 2002, Alan Cox wrote:
> >
> > Factoring the uid/gid/pid in actually may help in other ways. If we are
> > doing it by pid or by uid we will reduce the interleave of multiple
> > files thing you sometimes get
> 
> 'pid' would probably work better than what we have now, even though I bet
> it would get confused by a large number of installers (ie "make install"
> in just about any project will use multiple different processes to copy
> over separate subdirectories. In the X11R6 tree it uses individual "cp"
> processes for each file!)
> 
> The session ID would avoid some of that, but they both have a fundamental
> problem: neither pid nor session ID is actually saved in any directory
> structure, so it's quite hard to use that as a heuristic for whether a new
> file should go into the same directory group as the directory it is
> created in.
> 
> That's why "uid" would work better.

Sound good to me.  At leat this puts a veneer of respectability over
decapitating find_group_other(), which is really what we all want
to do anyway ;)

> The uid has a different issue, though,
> namely the fact that when user directories are created, they are basically
> always created as uid 0 first, and then a "chown" - which means that the
> user heuristic wouldn't actually trigger at the right time. So the
> heuristic couldn't be just "newfile->uid == directory->uid", it would have
> to be something better.

Last time, Al suggested that we always use the find_group_other() approach
if the directory is being made at the top-level of the filesystem.  So
if /home is a mountpoint, the user directories get spread out.

I think this, and the UID comparison will be good enough.

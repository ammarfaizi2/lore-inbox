Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263150AbSJGUjl>; Mon, 7 Oct 2002 16:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbSJGUjg>; Mon, 7 Oct 2002 16:39:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59403 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263147AbSJGUjd>; Mon, 7 Oct 2002 16:39:33 -0400
Date: Mon, 7 Oct 2002 13:44:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@digeo.com>, Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 -  (NUMA))
In-Reply-To: <1034021669.26502.19.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0210071331220.10749-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Oct 2002, Alan Cox wrote:
> 
> Factoring the uid/gid/pid in actually may help in other ways. If we are
> doing it by pid or by uid we will reduce the interleave of multiple
> files thing you sometimes get

'pid' would probably work better than what we have now, even though I bet
it would get confused by a large number of installers (ie "make install"
in just about any project will use multiple different processes to copy
over separate subdirectories. In the X11R6 tree it uses individual "cp"
processes for each file!)

The session ID would avoid some of that, but they both have a fundamental
problem: neither pid nor session ID is actually saved in any directory
structure, so it's quite hard to use that as a heuristic for whether a new
file should go into the same directory group as the directory it is
created in.

That's why "uid" would work better. The uid has a different issue, though,
namely the fact that when user directories are created, they are basically
always created as uid 0 first, and then a "chown" - which means that the
user heuristic wouldn't actually trigger at the right time. So the
heuristic couldn't be just "newfile->uid == directory->uid", it would have
to be something better.

I think last time we had the discussion, time-based things were also felt 
were good heuristics in many cases..

It could also be good to have an additional static hint on whether
directories should be spread out or not. Administrators could set the
"spread out" bit on the /, /home and /var/spool/(news|mail) directories,
for example, causing those to spread out their subdirectories. but not
causing normal user activity to do so.

Yeah, yeah, I know there are papers on this. I don't care. I think 
something has to be done, and last time the discussion petered out at 
about this point.

			Linus


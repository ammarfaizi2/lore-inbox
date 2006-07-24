Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWGXRzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWGXRzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWGXRzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:55:25 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42189 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932250AbWGXRzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:55:23 -0400
Message-Id: <200607241755.k6OHtJuo006253@laptop13.inf.utfsm.cl>
To: "Joshua Hudson" <joshudson@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links 
In-Reply-To: Message from "Joshua Hudson" <joshudson@gmail.com> 
   of "Mon, 24 Jul 2006 09:21:04 MST." <bda6d13a0607240921x78049eefraae775e4c6c0ba5c@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 24 Jul 2006 13:55:19 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 24 Jul 2006 13:55:19 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson <joshudson@gmail.com> wrote:
> On 7/24/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > On Mon, 24 Jul 2006 10:45:45 +0400, Nikita Danilov said:
> > > Joshua Hudson writes:
> > >  > In my filesystem, any attempt to create a loop of hard links
> > >  > is detected and cancelled.
> > >
> > > Can you elaborate a bit on this exciting mechanism? Obviously an ability
> > > to efficiently detect loops would be a break-through in a
> > > reference-counted garbage collection, somehow missed for last 40

> > It's actually pretty trivial to do if it's a toy filesystem and all the
> > relevant inodes are in-memory already.  The hard-to-solve part is getting
> > around the (apparent) need to walk across essentially the entire tree
> > structure making sure that you aren't creating a loop.  This can get
> > rather performance piggy - even /home on my laptop has some 400K
> > inodes on it, and a 'find /home -type d' takes 28 seconds.  That's a *long*
> > time to lock and freeze a filesystem.

> Actually, I walk from the source inode down to try to find the
> target inode. If not found, this is not attempting to create a loop.
> Should be obvious that the average case is much less than the
> whole tree.

You have to consider the worst case... and /that/ one is very bad. 

> > Where it gets *really* messy is that it isn't just mkdir that's the
> > problem - once you let there be more than one path from the fs root to
> > a given directory, it gets *really* hard to make sure that any given
> > 'mv' command isn't going to to screw things up (is 'mv a/b/c/d
> > ../../w/z/b' safe? How do you know, without examining a *lot* of stuff
> > under a/ and ../../w/?

> mv /a/b/c/d ../../w/z/b is implemented as this in the filesystem:
> ln /a/b/c/d ../../w/z/b && rm /a/b/c/d
> 
> So what it's going to do is try to find z under /a/b/c/d.

What if the ln(1) creates a loop, that the rm(1) then breaks? I.e., move a
directory nearer to the root?

Also note that with your idea '..' becomes ambiguous, as w might have
/lots/ of parents here.

> Oh, and Nakita's right about the NFS server stuff. Actually, I think
> the current filesystem I use for this is totally incompatible with
> NFS (cannot call d_splice_alias on directory dnodes) so that
> doesn't concern me.

Anything that isn't even NFS-capable is almost useless, IMVHO. Unless you
come up with a successor to NFS in tandem, that is.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513


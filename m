Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSGHDDy>; Sun, 7 Jul 2002 23:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSGHDDx>; Sun, 7 Jul 2002 23:03:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52896 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316755AbSGHDDx>;
	Sun, 7 Jul 2002 23:03:53 -0400
Date: Sun, 7 Jul 2002 23:06:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Matthew Wilcox <willy@debian.org>, Oliver Neukum <oliver@neukum.name>,
       Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
In-Reply-To: <3D28FE72.1080603@us.ibm.com>
Message-ID: <Pine.GSO.4.21.0207072258350.24900-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jul 2002, Dave Hansen wrote:

> > as does unix domain fd passing.  so we need protection between different
> > processes.  there's some pretty good reasons to want to use a semaphore
> > to protect the struct file (see fasync code.. bleugh).
> 
> But, this at least means that we don't need to protect 
> file->private_data during the open itself, right?

Correct.  Moreover, most of the struct file instances that have ->private_data
tend to set it during ->open() and never change it afterwards.
 
> > however, our semaphores currently suck.  they attempt to acquire the sem
> > immediately and if they fail go straight to sleep.  schimmel (i think..)
> > suggests spinning for a certain number of iterations before sleeping.
> > the great thing is, it's all out of line slowpath code so the additional
> > size shouldn't matter.  obviously this is SMP-only, and it does require
> > someone to do it who can measure the difference (and figure out how may
> > iterations to spin for before sleeping).

The thing being, if you are already contended you are playing "I'll release
CPU now" vs. "I'll spin in hope that contender will go away right now".

IOW, it's a win only if you get contention often and for short intervals.
Which is a very good indication that something is rotten with your locking
scheme.  Like, say it, having lost the control over the amount of locks
as the result of brainde^Woverenthusiastic belief that fine-grained ==
good.  With everything that follows from that...


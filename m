Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289098AbSA3Kv2>; Wed, 30 Jan 2002 05:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289099AbSA3KvT>; Wed, 30 Jan 2002 05:51:19 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:61327 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289098AbSA3KvD>;
	Wed, 30 Jan 2002 05:51:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Wed, 30 Jan 2002 11:55:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200201300907.g0U97icL001965@tigger.cs.uni-dortmund.de>
In-Reply-To: <200201300907.g0U97icL001965@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VsPE-0000DZ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 10:07 am, Horst von Brand wrote:
> Daniel Phillips <phillips@bonn-fries.net> said:
> > On January 29, 2002 12:54 pm, Helge Hafting wrote:
> > > Momchil Velikov wrote:
> 
> [...]
> 
> > > > Umm, all the ptes af the parent ought to be made COW, no ?
> 
> > > Sure. But quite a few of them may be COW already, if the parent 
> > > itself is a result of some earlier fork.
> 
> > Right, or if the parent has already forked at least one child.
> 
> But most of this will be lost on exec(2).

Even if we doing nothing more than the algorithm on the table, I doubt you'll 
see a measurable overhead on fork+exec.  Certainly it will be as good or 
better than what we have currently.

If that's not good enough, I'm considering keeping a bit on the page table 
indicating whether are particular page table is currently in the 'all CoWable 
ptes set RO' state, and if so, don't do it again.  I think that with this 
small optimization, the value of further improvements will be small indeed.

That said, Linus's suggestion of using the x86's ability to have the 
writeprotect bits in a page directory override the protections at the page 
level is a good one, and reduces the cost of detecting the fork+exec case to 
a very small number of faults - none if we are clever.  But this is entirely 
secondary to the main goal of sharing page tables at all, which is a rather 
fundamental shift in the way the Linux VM works.  (Though it seems the patch 
will be small.)

> Also, it is my impression that
> the tree of _running_ processes isn't usually very deep (Say init --> X -->
> [Random processes] --> [compilations &c], this would make 5 or 6 deep, no
> more.

Worst case is just as important as typical case here, since there will always 
be x% of users out there whose normal workload consists entirely of worst 
case.

> Should take a pstree(1) listing on a busy machine and work out some
> statistics... here (a personal worstation) the tree is very fat at the
> first level below init(8), and just 5 deep when running pstree(1)).

Here's my tree - on a non-very-busy laptop.  Why is my X tree so much deeper? 
I suppose if I was running java this would look considerably more interesting.

init-+-apache---8*[apache]
     |-apmd
     |-bash---bash---xinit-+-XFree86
     |                     `-xfwm-+-xfce---gnome-terminal-+-bash---pstree
     |                            |                       `-gnome-pty-helpe
     |                            `-xfgnome
     |-cardmgr
     |-cupsd---http
     |-5*[getty]
     |-gpm
     |-kapm-idled
     |-kdeinit---kdeinit
     |-5*[kdeinit]
     |-kdesud
     |-keventd
     |-kmail
     |-mozilla-bin---mozilla-bin---3*[mozilla-bin]
     |-portmap
     |-sshd
     `-xchat

> Sure, all processes will all end up sharing glibc, and the graphical stuff 
> will share the X &c libraries, so this would end up being a win this way.

Nobody has suggested that the sharing algorithm as described isn't a win, 
IMHO, we are quibbling over the last few percent of the win.  It's getting 
high time to end the suspense by benchmarking the code.

Caveat: the page table sharing as described does not do a lot for shared 
mmaps, such as glibc.  (Unless those are inherited through a fork of course, 
then it helps a lot.)  Let me reiterate my goal with this patch: *Fix The 
Fork Problem With Rmap* so that we can quit spending months fiddling with 
virtual scanning, trying to get it to work properly (it never will).

I see the value in the various suggestions I've received, but what I don't 
see is the value in delaying, or getting stuck adding new features.  Let's 
concentrate on making the simple thing I've described work *now* and add 
features to it later.

I'm gratified that nobody has yet pointed out any fundamental flaws that 
would keep it from working.  I wasn't at all sure of that when I set out on 
this path a month ago.

-- 
Daniel

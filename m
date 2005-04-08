Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVDHWwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVDHWwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVDHWwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:52:51 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:5804 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261173AbVDHWwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:52:47 -0400
Date: Sat, 9 Apr 2005 00:52:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0504072318010.15339@scrub.home>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <1112858331.6924.17.camel@localhost.localdomain>
 <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Apr 2005, Linus Torvalds wrote:

> I really disliked that in BitKeeper too originally. I argued with Larry
> about it, but Larry (correctly, I believe) argued that efficient and
> reliable distribution really requires the concept of "history is
> immutable". It makes replication much easier when you know that the known
> subset _never_ shrinks or changes - you only add on top of it.

The problem is you pay a price for this. There must be a reason developers 
were adding another GB of memory just to run BK.
Preserving the complete merge history does indeed make repeated merges 
simpler, but it builds up complex meta data, which has to be managed 
forever. I doubt that this is really an advantage in the long term. I 
expect that we were better off serializing changesets in the main 
repository. For example bk does something like this:

	A1 -> A2 -> A3 -> BM
	  \-> B1 -> B2 --^

and instead of creating the merge changeset, one could merge them like 
this:

	A1 -> A2 -> A3 -> B1 -> B2

This results in a simpler repository, which is more scalable and which 
is easier for users to work with (e.g. binary bug search).
The disadvantage would be it will cause more minor conflicts, when changes 
are pulled back into the original tree, but which should be easily 
resolvable most of the time.
I'm not saying with this that the bk model is bad, but I think it's a 
problem if it's the only model applied to everything.

> The thing is, cherry-picking very much implies that the people "up" the 
> foodchain end up editing the work of the people "below" them. The whole 
> reason you want cherry-picking is that you want to fix up somebody elses 
> mistakes, ie something you disagree with.
> 
> That sounds like an obviously good thing, right? Yes it does.
> 
> The problem is, it actually results in the wrong dynamics and psychology 
> in the system. First off, it makes the implicit assumption that there is 
> an "up" and "down" in the food-chain, and I think that's wrong.

These dynamics do exists and our tools should be able to represent them.
For example when people post patches, they get reviewed and often need 
more changes and bk doesn't really help them to redo the patches.
Bk helped you to offload the cherry-picking process to other people, so 
that you only had to do cherry-collecting very efficiently.
Another prime example of cherry-picking is Andrews mm tree, he picks a 
number of patches which are ready for merging and forwards them to you.
Our current basic development model (at least until a few days ago) looks 
something like this:

	linux-mm -> linux-bk -> linux-stable

Ideally most changes would get into the tree via linux-mm and depending 
on depending various conditions (e.g. urgency, review state) it would get 
into the stable tree. In practice linux-mm is more an aggregation of 
patches which need testing and since most bk users were developing 
against linux-bk, it got a lot less testing and a lot of problems are 
only caught at the next stage. Changes from the stable tree would even 
flow in the opposite direction.
Bk supports certain aspects of the kernel development process very well, 
but due its closed nature it was practically impossible to really 
integrate it fully into this process (at least for anyone outside BM). 
In the short term we probably are in for a tough ride and we take whatever 
works best for you, but in the long term we need to think about how SCM 
fits into our kernel development model, which includes development, 
review, testing and releasing of kernel changes. This is more than just 
pulling and merging kernel trees. I'm aiming at a tool that can also 
support Andrews work, so that he can also better offload some of this 
work (and take a break sometimes :) ). Unfortunately every existing tool I 
know of is lacking in its own way, so we still have some way to go...

bye, Roman

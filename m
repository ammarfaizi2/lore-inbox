Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318960AbSHQB2k>; Fri, 16 Aug 2002 21:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318991AbSHQB2k>; Fri, 16 Aug 2002 21:28:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18700 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318960AbSHQB2i>; Fri, 16 Aug 2002 21:28:38 -0400
Date: Fri, 16 Aug 2002 18:35:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Larry McVoy <lm@bitmover.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IDE?
In-Reply-To: <Pine.GSO.4.21.0208162057550.14493-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Alexander Viro wrote:
> 
> Sigh...  What we need with IDE is
> 	a) translator/bogon filter between hardware folks and the rest of
> us.  If Jens or Alan are willing to do that for a while - wonderful.

Agreed.

> 	b) review of code structure in existing code.  Doing that.

Hey, my secret plan is to make sure those IDE people are kept in check, by 
having AL flame them to smithereens if they do something stupid..

> 	c) careful massage (as opposed to grand rewrite) of said structure
> into something sane.  With series of small provable equivalent transformations.
> And whoever does that is in serious risk of burnout - current spaghetty in
> there is a fscking mess.  I'll try to help with that - I know how to do such
> work, but I don't promise to get it all the way to sanity.

Good luck, but I think those init rules etc are really horribly subtle.

I really would suggest an alternate (but not necessarily very different) 
approach. 

The approach I'd advocate is to

 - move the major number registration out of the IDE code, and changing 
   all device numbers into indexes + a queue. This can be done without 
   actually changing any of the _IO_ the drivers do, and should be doable
   with a transformation that doesn't change behaviur _at_all_.

   This, btw, is an area that a certain Al is fairly intimate with anyway ;)

 - once the IDE drivers don't even know about major and minor numbers 
   (right now it has 10 major numbers assigned to it, I think) and doesn't 
   register a block device with "register_blkdev()" at all, but instead 
   registers the controllers it finds one by one through some indirect 
   agent, we can now try phase 2.

 - phase 2: IDE-TNG. Leave the current IDE code unchanged, and plan to 
   obsolete it. It's the "stable IDE", and by virtue of being stable, 
   nobody will mind work on new drivers that (by definition) cannot screw 
   up unless you use them.

   IDE-TNG would:
    - be controller-specific (ie one driver for one controller family)
    - be able to say "screw it" for old or broken setups (which are left 
      fot the old IDE code)
    - in particular, it would only bother with PCI (or better) 
      controllers, and with UDMA-only setups.

The point of IDE-TNG would be to only support the major controllers this 
way, but let those major controllers have a driver that is meant for 
_them_ and doesn't have to worry about historical baggage. 

And then in five years, in Linux-3.2, we might finally just drop support 
for the old IDE code with PIO etc. Inevitably some people will still use 
it (the same way some people still use Linux-2.0 with hd.c), but it won't 
have been in the way for making a cleaner driver in the meantime.

And yes, by now this all is obviously 2.7.x material.

			Linus


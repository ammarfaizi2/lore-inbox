Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268254AbUIKSNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268254AbUIKSNi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268263AbUIKSNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:13:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:5520 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268254AbUIKSNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:13:33 -0400
Date: Sat, 11 Sep 2004 11:13:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
In-Reply-To: <9e473391040911105448c3f089@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0409111058320.2341@ppc970.osdl.org>
References: <9e47339104090919015b5b5a4d@mail.gmail.com> 
 <9e4733910409100937126dc0e7@mail.gmail.com>  <1094832031.17883.1.camel@localhost.localdomain>
  <9e47339104091010221f03ec06@mail.gmail.com>  <1094835846.17932.11.camel@localhost.localdomain>
  <9e47339104091011402e8341d0@mail.gmail.com>  <Pine.LNX.4.58.0409102254250.13921@skynet>
  <20040911132727.A1783@infradead.org>  <9e47339104091109111c46db54@mail.gmail.com>
  <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org> <9e473391040911105448c3f089@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Sep 2004, Jon Smirl wrote:

> On Sat, 11 Sep 2004 10:02:57 -0700 (PDT), Linus Torvalds
> <torvalds@osdl.org> wrote:
> > Jon, you want to get to that "Final step is to integrate the chip specific
> > code from DRM and fbdev". Alan doesn't even want to get there. I think
> > Alan just wants some simple infrastructure to let everybody play together.
> 
> This is the core problem. I want to get to a point where there is a
> single, integrated piece of code controlling the complex functions of
> the 3D hardware.

I think you can get there without having to merge the two.

How about just accepting the fact that there might be other people 
accessing your hardware, and then trying to make it _rare_?

> I want to get away from the model of "I just got control of the chip,
> who knows what the state of it is, I better reset everything". I also
> want to get away from "now I want to use this register, i need to
> inspect every over driver and piece of user space code to make sure
> they don't stomp it". Or "I didn't even know your code existed, sorry
> about stomping that critical register and causing 100 bug reports". Or
> "why don't we just split the VRAM in half so we don't have to share
> memory management".  Or suspend code that restores 2D mode and ignores
> 3D.

Well, what _I_ want to get away from is a "I'm the only game in town" 
mentality. 

I want people to be able to play with other things, without having one 
driver that has to know about it all. I also want to avoid flag-days, ie 
I'd like to be able to have a gradual transition.

And I don't think your model really has the option for a gradual 
transition, and other people doing their thing. 

So I'd much rather see the "hey, somebody else might have stolen my 
hardware, and now I need to re-initialize" as the _basic_ model. That just 
allows others to do their own thing, and play well together. More 
importantly, it allows the existing status quo, which means that if we 
take that as the basic approach, we _never_ have to make a complete flag 
day when we switch over to "_this_ driver does everything". See?

HOWEVER, I do realize that that is horribly inefficient as a common thing
to happen, which is why I have the cunning plan (always steal good ideas 
from others and call them "your" cunning plans) to have the locking that 
allows for caching over locks. That means that _if_ you get to the point 
where your driver does everything, you'll never really have to worry about 
performance, because you'll never see the bad cases.

Or maybe you'll only see the bad cases when the kernel oopses, and decides 
that it _has_ to write to the screen and screw your model. See what I'm 
saying? Having a model that allows for that is a _good_ thing.

And you can do it. Basically, if you build on top of the "silly driver"  
locks, your DRM layer would have _one_ cookie (per hw device, of course)
that it ever uses, and it would point to your basic device descriptor. 
You'd then do the X cookies within that decide descriptor, ie they'd never 
change the "silly driver" cookie, and thus you'd never see a "conflict". 
You'd take care of the existing DRM locking methods yourself, you wouldn't 
try to shoe-horn them into the silly driver locks.

So what I'm saying is that you _can_ get to your ideal world, without 
taking the option away from others to decide that they prefer having two 
(or three, or fifteen) drivers all accessing the same hardware. For 
example, the single-driver approach might be good for some hadrware. It 
might not be so good for others (think vendor drivers etc).

> A good example of this is switching the GPU between 2D and 3D mode on
> every process swap.
> 
> In general the current X design only has a single 3D client. With a
> composited display and pbuffer background drawing we are going to have
> one 3D client for every top level window.

But if you make your DRM thing be the "master" of these different 3D
client contexts, then you _can_ handle that without ever having to lose
your "hardware lock". See what I'm saying? You do two-level locking:

 - the "hardware level" is the silly driver one. It's the one that allows 
   multiple kinds of subsystems to play together, be it DRM of fbcon. When 
   you get a "release event" for this one, you basically have to serialize
   _everything_, because this level of release means that you literally
   don't know what happened (with the exception of mode switching, I 
   really think that one has to be a totally separate class of events).

 - you have your _own_ "DRM level" context lock, which is the one the 3D 
   clients from X actually interface to. That one also has to reset _some_ 
   client state, of course, when you switch between clients, but now it's
   only state that _you_ know about.

You can have your cake and eat it too. I don't think these things are 
incompatible.

		Linus

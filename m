Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUILAWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUILAWC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 20:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268378AbUILAWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 20:22:02 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:64080 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268379AbUILAV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 20:21:56 -0400
Message-ID: <9e4733910409111721534b2e6d@mail.gmail.com>
Date: Sat, 11 Sep 2004 20:21:52 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409111058320.2341@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
	 <9e473391040911105448c3f089@mail.gmail.com>
	 <Pine.LNX.4.58.0409111058320.2341@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 11:13:17 -0700 (PDT), Linus Torvalds
<torvalds@osdl.org> wrote:
> So I'd much rather see the "hey, somebody else might have stolen my
> hardware, and now I need to re-initialize" as the _basic_ model. That just
> allows others to do their own thing, and play well together. More
> importantly, it allows the existing status quo, which means that if we
> take that as the basic approach, we _never_ have to make a complete flag
> day when we switch over to "_this_ driver does everything". See?

We already have a mechanism for this: suspend/resume. The downside to
this approach is that after I get a resume I have to rebuild the
hardware state. It takes a while to rebuild half a gig of graphics
state but this model will provide the required isolation.

> HOWEVER, I do realize that that is horribly inefficient as a common thing
> to happen, which is why I have the cunning plan (always steal good ideas
> from others and call them "your" cunning plans) to have the locking that
> allows for caching over locks. That means that _if_ you get to the point
> where your driver does everything, you'll never really have to worry about
> performance, because you'll never see the bad cases.

suspend/resume will address this too. On VT switch DRM would receive a
suspend command and fbdev a resume, then vice versa on the way back.
We will have to build a scheme for assigning a driver to each VT. A
general mechanism would extend this beyond the video drivers.

This is implementing device driver multitasking something I didn't
want to do. I never said it wouldn't work, I just didn't want to do
it. I thought the complexity/performance trade offs weren't worth it.

> 
> Or maybe you'll only see the bad cases when the kernel oopses, and decides
> that it _has_ to write to the screen and screw your model. See what I'm
> saying? Having a model that allows for that is a _good_ thing.
> 
> And you can do it. Basically, if you build on top of the "silly driver"
> locks, your DRM layer would have _one_ cookie (per hw device, of course)
> that it ever uses, and it would point to your basic device descriptor.
> You'd then do the X cookies within that decide descriptor, ie they'd never
> change the "silly driver" cookie, and thus you'd never see a "conflict".
> You'd take care of the existing DRM locking methods yourself, you wouldn't
> try to shoe-horn them into the silly driver locks.
> 
> So what I'm saying is that you _can_ get to your ideal world, without
> taking the option away from others to decide that they prefer having two
> (or three, or fifteen) drivers all accessing the same hardware. For
> example, the single-driver approach might be good for some hadrware. It
> might not be so good for others (think vendor drivers etc).

Why do we have fifteen video drivers for the radeon and only one for
each SCSI card? Could it be that the SCSI drivers are well designed
and do everything needed, thus removing the incentive for most people
to write new ones? If we had a good, standardized library for
accessing accelerated drawing functions people might stop rewriting
the video drivers. I'd rather spend my effort trying to build a good
library rather than building sandboxes to keep fifteen partial
libraries from interfering.

> > A good example of this is switching the GPU between 2D and 3D mode on
> > every process swap.
> >
> > In general the current X design only has a single 3D client. With a
> > composited display and pbuffer background drawing we are going to have
> > one 3D client for every top level window.
> 
> But if you make your DRM thing be the "master" of these different 3D
> client contexts, then you _can_ handle that without ever having to lose
> your "hardware lock". See what I'm saying? You do two-level locking:
> 
>  - the "hardware level" is the silly driver one. It's the one that allows
>    multiple kinds of subsystems to play together, be it DRM of fbcon. When
>    you get a "release event" for this one, you basically have to serialize
>    _everything_, because this level of release means that you literally
>    don't know what happened (with the exception of mode switching, I
>    really think that one has to be a totally separate class of events).

You almost said resume - "release event" was real close.

>  - you have your _own_ "DRM level" context lock, which is the one the 3D
>    clients from X actually interface to. That one also has to reset _some_
>    client state, of course, when you switch between clients, but now it's
>    only state that _you_ know about.
> 
> You can have your cake and eat it too. I don't think these things are
> incompatible.

Build the sandboxes and then let everyone play.

> 
>                 Linus
> 



-- 
Jon Smirl
jonsmirl@gmail.com

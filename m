Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUIJSlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUIJSlB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 14:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbUIJSlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 14:41:01 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:13810 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267751AbUIJSkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 14:40:12 -0400
Message-ID: <9e47339104091011402e8341d0@mail.gmail.com>
Date: Fri, 10 Sep 2004 14:40:10 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: radeon-pre-2
Cc: =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1094835846.17932.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 18:04:19 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2004-09-10 at 18:22, Jon Smirl wrote:
> > My "personal plan" has been posted for comment to all relevant email
> > lists -- xorg, fbdev, dri, and lkml. All feedback that was received
> > was addressed and incorporated. Various aspects of the plan were
> 
> Addressed and eliminated would be closer. The BSD folks don't want GPL
> frame buffer code in there kernel, nobody needs a single nasty splat
> where DRI and fbdev got hammered into one block of code by someone with
> a glue gun.

This has been discussed and we see the need to keep BSD's version of
DRM isolated from the Linux one.  There are several different schemes
that can be used to achieve this but there is agreement that GPL code
from Linux should not be mixed into the BSD code base.

For example DRM can link into the existing fbdev cfb* modules without
changing them. These modules are needed to implement OOPs display from
X. Another example is the radeon GPL I2C DDC driver. This will start
off as an isolated Linux feature. If a BSD coder wants to reimplement
this existing code GPL with a BSD license it can be added to the BSD
driver.

> 
> > Plan as orginally posted to lkml:
> > http://lkml.org/lkml/2004/8/2/111
> 
> None of which is about nailing all the code together. You just don't
> need to do that kind of stuff, and it'll make it much harder to
> maintain.
> 
> Now, think about what happens if you register a pci handler for
> everything which is "Video" class (or VIDEO/VGA). Your one mini module
> now claims every video object in the kernel with a couple of exceptions
> you can hand list.
> 
> vga_class.c now owns all the video devices. It can keep a global list
> and a sorted by vga router list as well as letting frame buffer drivers
> and other code add heads of a device lists.
> 
> Add register/unregister functions in the same format to allow DRI and FB
> (and any future layers) to find cards and you don't need to glue stuff
> together at all. You can load dri, you can load fb drivers, you can load
> both. You also require minimal kernel changes to the drivers.

You are focusing on the resource claiming problem. That is an easy
problem to solve, it's also not the one that is causing the hard
problems.

Hard problems:
1) Video cards have more than one head, fbdev can only set the mode on
one of them.
2) Video cards with more than one display buffer need memory
management, fbdev has none. OpenGL needs complex memory management.
3) Simultaneous users on two heads, fbdev cannot put the chip into 2D
mode while the other head is being used in 3D mode. Both heads have to
stay in 3D mode.
4) Conflicting use and programming of the 3D mode acceleration
registers between accelerated fbdev drivers and DRM
5) Support for multiple video cards - not addressed in fbdev.
6) Device driver multi-tasking. The concept that one device driver
should be suspended and another one allowed to take over the hardware
on a key stroke command. This completely violates normal OS rules of
one driver per device. If video can do it, I want to do it for the
disk and net subsystems too.
7) Building a bunch of cooperative interfaces between two groups of
developers that ignore each other.

I have to stick by a very basic rule of operating systems - one device
driver per device. The driver can have modules but these modules have
to make coordinated use of the hardware. Building a base layer for
fbdev and DRM that coordinates resource reservations does nothing to
address the above issues if everyone continues to do what they please
in the modules.

If you look at the recent changes to DRM you will notice that I am
building a base layer that will continue to work during the transition
period.  Code for accessing video ROMs is finished and should be in mm
soon. I'm in the middle of writing a VGA device driver that properly
does bridge chip routing. When it's finished we'll be able to reset
secondary cards. Once the reset program is finished the next step is
to alter DRM so that it can support take_over_console().

-- 
Jon Smirl
jonsmirl@gmail.com

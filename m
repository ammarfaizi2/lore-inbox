Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbREORoW>; Tue, 15 May 2001 13:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261179AbREORoM>; Tue, 15 May 2001 13:44:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:15120 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261165AbREORn6>; Tue, 15 May 2001 13:43:58 -0400
Date: Tue, 15 May 2001 10:43:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Simmons <jsimmons@transvirtual.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105151023290.22038-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.21.0105151031320.2112-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, James Simmons wrote:
> > 
> > Static devices like /dev/fbN are no different. They were just plugged in
> > before the OS booted.
> 
> Actually their are hotplug video cards. High end servers have hot swapable 
> graphcis cards. Would you want to take down a very important server
> because the graphics card went dead. You pull it out and you plug a new
> one in. Also their are PCMCIA video cards. I have seen them for the hand
> held ipaqs. It is only a matter of time before all devices are hot
> swappable. 

True, but not really necessarily important.

The thing is, even if the device happens to be soldered down, inside a
computer that is locked in a safe, the question boils down to a fairly
simple one: "how do we approach devices?".

Do we approach devices as something static, or do we approach them as more
dynamic entities? Do we consider soldered-down devices to be fundamentally
different from the ones that can be hot-plugged?

And my opinion is that the "hot-plugged" approach works for devices even
if they are soldered down - the "plugging" event just always happens
before the OS is booted, and people just don't unplug it. So we might as
well consider devices to always be hot-pluggable, whether that is actually
physically true or not. Because that will always work, and that way we
don't create any artificial distinctions (and they often really _are_
artifical: historically soldered-down devices tend to eventually move in a
more hot-pluggable direction, as you point out).

Now, if we just fundamentally try to think about any device as being
hot-pluggable, you realize that things like "which PCI slot is this device
in" are completely _worthless_ as device identification, because they
fundamentally take the wrong approach, and they don't fit the generic
approach at all.

But this is also why I don't think static device numbers make any
sense. It's silly to have the same disk show up as different devices just
because it is connected to a different kind of controller. And it is
_really_ silly to statically pre-allocate device numbers based on the
"location" of a device. 

We should strive for a setup where device plugin causes that device to
show up in /dev, and everywhere else it is needed. And the logical
extension of such a setup is to consider built-in devices to be plugged in
at bootup.

This is true to the point that I would not actually think that it is a bad
idea to call /sbin/hotplug when we enumerate the motherboard devices. In
fact, if you look at the current network drivers, this is exactly what
will happen: when we auto-detect the motherboard devices, we _will_
actually call /sbin/hotplug to tell that we've "inserted" a network
device.

It's just that we haven't really mounted the root filesystem yet, so
user-land never actually "sees" this fact. But I think it's the right
approach to take, and realizing that even static devices are just a
sub-case of the problem of dynamic allocation means that you tend to
automatically also see that static device number allocation is just
broken.

[ The biggest silliness is this "let's try to make the disks appear in the
  same order that the BIOS probes them". Now THAT is really stupid, and it
  goes on a lot more than I'd ever like to see. ]

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVBVDNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVBVDNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 22:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVBVDNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 22:13:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:27093 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262196AbVBVDN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 22:13:29 -0500
Subject: POSTing of video cards (WAS: Solo Xgl..)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910502211717116a4df3@mail.gmail.com>
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <4218BAF0.3010603@tungstengraphics.com>
	 <21d7e997050220150030ea5a68@mail.gmail.com>
	 <9e4733910502201542afb35f7@mail.gmail.com> <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 14:12:48 +1100
Message-Id: <1109041968.5412.63.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ben, since I'm not getting any help on LKML maybe you can answer this.
> Secondary cards needs reset. After looking at a bunch of fbdev drivers
> their code assumes the card has been reset when their probe() function
> runs. So this means that we have to run the VBIOS reset before probe
> is called.

I'm putting back LKML on CC since I intended to reply to your post there
once I got a bit of time.

No, we can't really do that _before_ probe is called. It's the
responsibility of the driver to do what it needs at probe time or later.
Some drivers need that reset (and not that many in fact), some don't.

We may provide a "helper" to use from the probe() for that purpose, to
make things easier.

Wether the reset code is kernel based or userland based, I would avoid
have it run synchronously anyway. If a driver detects that it's card
hasn't been properly initialized by the firmware (and the driver should
be able to detect that), I suggest it's probe routine calls the
appropriate helper, providing it with ways to get to the ROM (in some
case, the same helper will be needed for resume from sleep, and the ROM
may not be the PCI BAR one, but the memory shadow, though that will not
always work afaik).

Look at the firmware download helper, that's very similar. I want an
asynchronous interface though (that is you get a callback when the reset
is complete or timed out) rather than synchronous since it's wrong to
synchronously rely on userland beeing available (power management,
pre-root mount, etc...)

> So where can I hook up the call to run the VBIOS up in the kernel? You
> can't trigger it on module load since the module may support multiple
> identical adapters. One adapter may already have the module loaded and
> then a second shows up via hotplug. In this case the module won't get
> loaded again and the second card doesn't get reset.
>
> If using a user space reset program what do you do if the user space
> program is missing or does not complete running? Somehow you have to
> stop the probe function from being called.

That's ok. We deal with that in the firmware loader code already. Just
timeout or check for errors from call_usermodehelper. You basically run
the user program and wait for it to write a "reply" via sysfs. In fact,
the existing firmware loading facility could be re-used.
 
> Another case, you have a card and load the module for it, this causes
> reset. Now unload the module and load it again. This probably should
> not reset the card a second time. You also have to make sure you don't
> reset the primary card.

It's up to each driver to detect wether it's card need to be POSTed or
not. Anything else would mean infinite breakage.

> One solution is to track in pci_dev if the card has been reset. This
> preserves the state across module load/unload. I'm then tempted to put
> an in-kernel emu86 (I have a 40K one) into the pci driver. PCI would
> use this to reset the card before calling probe(). If the VBIOS/emu86
> has an error it simply wouldn't call the probe function. Doing this
> in-kernel makes everything synchronous but GregKH would probably have
> some choice words about the emulator in the PCI driver.

No, again, it's up to the driver to decide wether it needs to POST or
not (I prefer that to "reset"). I have no preference for the emulator to
be in-kernel or userland. I suppose it's easier in userland, just
re-using the existing infrastructure for firmware loading.

> I am leaning toward putting this into the PCI driver. At boot the PCI
> driver would reset any cards it finds. The PCI driver also implements
> hotplug so now I have a place to do reset before calling probe in this
> case. Doing it in-kernel fixes the synchronization problem. Right now
> there is no way to suspend calling the probe function while we wait
> for a hotplug event to finish.
> 
> I have all of the pieces needed to build this. I just can't figure out
> where to hook it into the kernel. Worst case is that I have to go
> modify 75 framebuffer drivers to explicitly support reset.

No. You don't. A lot of them simply don't care. Just adapt radeonfb, and
maybe the others ATIs and rivafb, period. If somebody want to adapt to
your facility, it's up to that person to adapt the framebuffer of their
dream. You provide infrastructure that _adds_ a functionality not
previously present. You don't need to implement it in all drivers
yourself, just do it in a few that matter, and let people who want the
feature catch up as long as "old" drivers don't _lose_ functionality. 

Also, a lot of those FB's are embedded things, or ppc/pmac things,
etc... and they simply don't fit into your scheme anyway (and mostly
don't have the problem in the first place).

Cheers,
Ben.



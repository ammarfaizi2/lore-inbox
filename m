Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268769AbUIMQRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268769AbUIMQRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUIMQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:13:18 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5306 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266357AbUIMQIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:08:40 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <9e47339104091308063c394704@mail.gmail.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095074778.14374.41.camel@localhost.localdomain>
	 <9e47339104091308063c394704@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095087860.14582.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Sep 2004 16:04:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-13 at 16:06, Jon Smirl wrote:
> It also needs something to sort out both drivers using pci_drvdata()
> to get to their private data. For example in the hotplug routines you
> only get passed a pdev and you want to use that to locate your private
> data.

The hotplug routines for vga objects in the code I posted get passed
vga_dev objects. You can put what you like in those. I guessed at 
"memory manager" "dri" and "framebuffer0" being the ones to create for
now but we can invent anything thats more appropriate.

> It also needs to track pci_enable_device() so that if one driver
> unloads it won't turn the device off for the other driver.

The ->remove function is passed the number of remaining clients for
exactly this reason. We could move the resource grabbing up the tree.
IRQ handling is rather harder. Quiescing and handing back the IRQ on
lock loss is ugggggggggly so I want to think about it - it works but its
not nice.

Should pci_enable and friends be done by the vga class driver- it can do
this and it would have to do it if it did the hotplug ?

> VGA routing needs to be supported. I attached the code I was writing
> for that. I was in the middle of writing it so it doesn't compile.
> This code should be integrated into the VGA driver.

Agreed. 

> It needs to integrate into VGAcon. VGAcon should require the vga
> device before loading. The resource reservation code in VGAcon needs
> to be moved to the VGA driver. If you use a command to switch the
> active VGA device, VGAcon needs to reset itself for the new device.

I saw vgacon as being a client of the vga class driver like the various
fb drivers would be.

> VGA driver needs to generate hotplug events for the VGA device that
> indicate if they are primary or secondary. If they are secondary there
> needs to be a user space reset program that uses the new ROM hooks to
> reset the card.

The VGA driver at the moment doesn't really know about legacy vga space.
That was something I wanted to touch last of all because it is foul. It
can do this and as you say its the perfect person to issue the hotplug
notifications. It also needs to do it for vesafb so if it is handed an
ISA hole it can work out the right PCI device.

> It should support more than two drivers, I forgot to check, does it already?

As many as you want. Just change the array size or the number
registered. One neat trick we can support is adding extra devices when
necessary - thus if the boot code in user space boots a card and decides
its multihead we'd want to add extra heads.

> fbdev takes a snapshot of the video registers when it loads. When you
> unload it it writes those registers back. That doesn't work if you
> load from an xterm and rmmod it from the command line. It snapshots
> the card in graphics mode and then restores it in an environment
> expecting text mode.

Big lock issue. You get told if someone else ate your environment. Being
more polite about that would help performance a ton. You know who had
the lock before and who has it now - so we can be intelligent about
->release cleanup I hope. (eg FB0 finds FB1 had it last it might do a
minimal restore)

> Something needs to be done for DMA processing. What if I get an
> interrupt that the DMA queue has been completed but we've switched to
> a driver that doesn't understand DMA? I guess the only safe thing to
> do is make sure all DMA queue are finished before releasing control.

The ->remove path takes the lock (so calls ->release) and then drops it
with no callback needed so providing the hand over code is robust this
will come for free.

Alan


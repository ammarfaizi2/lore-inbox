Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTJYWHU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 18:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbTJYWHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 18:07:20 -0400
Received: from griffin-can-au.getin2net.com ([203.43.225.34]:29188 "EHLO
	griffin-can-au.getin2net.com") by vger.kernel.org with ESMTP
	id S263062AbTJYWHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 18:07:18 -0400
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver
	conversion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>,
       Eric Anholt <eta@lclark.edu>, Kronos <kronos@kronoz.cjb.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1067119628.3570.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 26 Oct 2003 00:07:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Face it, a good graphics driver needs more than just "set up the ROM". It
> needs DMA access, and the ability to use interrupts. It needs a real
> driver.
> 
> It basically needs something like what the DRI modules tend to do.
> 
> I'd be really happy to have real graphics drivers in the kernel, but quite
> frankly, so far the abstractions I've seen have sucked dead donkeys
> through a straw. "fbcon" does way too much (it's not a driver, it's more a
> text delivery system and a mode switcher). And DRI is too complex and
> fluid to be a good low-level driver.

Well... While I tend to agree, note that in 2.6 fbcon and the fbdev
itself _do_ have been separated. The fbdevs are moving toward that
low level driver thing.

> Quite frankly, I'd much rather see a low-level graphics driver that does
> _two_ things, and those things only:
> 
>  - basic hardware enumeration and setup (and no, "basic setup" does not
>    mean "mode switching": it literally means things like doing the 
>    pci_enable_device() stuff.
> 
>  - serialization and arbitrary command queuing from a _trusted_ party (ie
>    it could take command lists from the X server, but not from untrusted
>    clients). This part basically boils down to "DMA and interrupts". This 
>    is the part that allows others to wait for command completion, "enough 
>    space in the ring buffers" etc. But it does _not_ know or care what the 
>    commands are.

IMHO, that low level driver should be ... the fbdev. The main reason for
that is the necessary locking & synchronisation between the command flow
and mode switching, palette control and cursor control (which aren't
things doable via the normal command path on moth cases).

> Then, fbcon and DRI and X could all three use these basics - and they'd be
> _so_ basic that the hardware layer could be really stable (unlike the DRI
> code that tends to have to upgrade for each new type of command that DRI
> adds - since it has to take care of untrusted clients. So DRI would
> basically use the low-level driver as a separate module, the way it
> already uses AGP).

I agree that fbcon itself should (and is now in 2.6) be a separate
module. The interface is still scary, the locking is almost absent,
which is a real problem even with current mode switching beeing racy
with printk & blanking, but at least we have something that works and
can evolve in the right direction.

Look how the fbdev interface was simplified in the 2.4 -> 2.6
transition, it's really a lot saner now, and I hope it will continue
to improve.

> But I'm _not_ interested in some interfaces to let user mode just bypass 
> the kernel. Because they will not solve any of the other problems that 
> clearly _do_ need solving, and if the X server continues to believe that 
> it can just access the hardware directly, it will never play well together 
> with projects like fbcon/dri.

Fully agreed. My point is that this low-level driver and the fbdev should
be one thing.

Ben.


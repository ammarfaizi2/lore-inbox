Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVG3Wny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVG3Wny (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 18:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbVG3Wny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 18:43:54 -0400
Received: from isilmar.linta.de ([213.239.214.66]:54443 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261516AbVG3Wnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 18:43:53 -0400
Date: Sun, 31 Jul 2005 00:43:52 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Heads up for distro folks: PCMCIA hotplug differences (Re: -rc4: arm broken?)
Message-ID: <20050730224352.GA19916@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050730130406.GA4285@elf.ucw.cz> <1122741937.7650.27.camel@localhost.localdomain> <20050730201508.B26592@flint.arm.linux.org.uk> <20050730223628.M26592@flint.arm.linux.org.uk> <20050730214152.GE9418@elf.ucw.cz> <20050730225511.O26592@flint.arm.linux.org.uk> <20050730223030.GH9418@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730223030.GH9418@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 31, 2005 at 12:30:30AM +0200, Pavel Machek wrote:
> > > > Let me qualify that, because it's not 100% fine due to the changes in
> > > > PCMCIA land.
> > > > 
> > > > Since PCMCIA cards are detected and drivers bound at boot time, we no
> > > > longer get hotplug events to setup networking for PCMCIA network cards
> > > > already inserted.  Consequently, if you are relying on /sbin/hotplug to
> > > > setup your PCMCIA network card at boot time, triggered by the cardmgr
> > > > startup binding the driver, it won't happen.
> > > 
> > > Does that mean that if CF is inserted during bootup, it will simply
> > > appear as /dev/hda after bootup, without need to run cardmgr?
> > 
> > Yes, which is almost a plus side.  Whether you can use it to boot
> 
> That's certainly a plus side, because I should be able to use pcmcia
> cards without setting much userland.

Let me clarify this a bit, and point all interested parties to
http://kernel.org/pub/linux/utils/kernel/pcmcia/howto.html

PCMCIA can work without userspace on 2.6.13 if you compile all necessary
things into the kernel and:

a) the socket is smart enough.This is the case for
	- all sockets which statically map resources 
	  (hd64465, Au1x00, SA1100, SA1111, PXA2xx, M32R_PCC, M32R_CFC, 
	   VRC4171, VRC4173)
	- yenta-socket, pd6729 or i82092 if it 
		1) resides behind a PCI-PCI bridge [oh, I need to update
			the howto regarding this point...] or
		2) resides behind some other bridge limiting the resource
			space (PPC, PPC64)

and

b) a Manufactor/Device or Product ID match is known for the device. Matching
for "Function ID" (quite common for CF cards, unfortunately) is fuzzy and
therefore can only be enabled if we are sure no (other) driver matches. And
that's currently done by waiting for userspace telling the kernel that it
already modprobed all available modules. In the long term, we should try to
get rid of all "Function ID" matches, and use the more specific Manufactor,
Device and Product ID matches. So patches adding more IDs are welcome.

Thanks,
	Dominik

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWGVWGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWGVWGh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 18:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWGVWGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 18:06:37 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:1554 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750764AbWGVWGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 18:06:36 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Trying to get swsusp working on DTK FortisPro TOP-5A notebook
Date: Sun, 23 Jul 2006 00:06:31 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <444E4F4C.1030509@rainbow-software.org> <20060421084323.GA2376@ucw.cz> <20060427074025.GA11322@suse.cz>
In-Reply-To: <20060427074025.GA11322@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 3797
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200607230006.31704.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 09:40, Vojtech Pavlik wrote:
> On Fri, Apr 21, 2006 at 08:43:24AM +0000, Pavel Machek wrote:
> > On Tue 25-04-06 18:33:16, Ondrej Zary wrote:
> > > Hello,
> > > I'm trying to get swsusp working on my DTK FortisPro
> > > TOP-5A notebook. I compiled 2.6.16 kernel with drivers
> > > compiled in (ES1869 sound, TI CardBus, Xircom PCMCIA
> > > ethernet, Orinoco wifi and maybe something more). There
> > > is no ACPI as BIOS does not support it. The problem is
> > > that when I do "echo disk >/sys/power/state", it refuses
> > > to suspend:
> > >
> > > Stopping tasks: =============================|
> > > Shrinking memory... done (8698 pages freed)
> > > pnp: Device 00:19 disabled.
> > > pnp: Failed to disable device 00:16.
> > > Could not suspend device 00:16: error -5
> > > pnp: Device 00:19 activated.
> > > PCI: Found IRQ 11 for device 0000:00:01.2
> > > PCI: Found IRQ 9 for device 0000:00:0e.0
> > > PCI: Found IRQ 11 for device 0000:00:0e.1
> > > eth0: autonegotiation failed; using 10mbs
> > > eth0: MII selected
> > > eth0: media 10BaseT, silicon revision 4
> > > Some devices failed to suspend
> > > Restarting tasks... done
> > >
> > >
> > > Device 00:19 is gameport of the sound card (it seems to
> > > suspend fine), however device 00:16 does not. It seems to
> > > be the synaptics touchpad:
> >
> > rmmod touchpad driver before suspend; if it helps, fix psmouse.
>
> This is a problem in ACPI PnP layer - the device doesn't have a disable
> method (it simply doesn't support disabling in hardware). Not being able
> to disable it probably should be ignored when suspending.

Finally, I debugged it today. The problem is in PNP BIOS. pnp_bus_suspend() 
calls pnp_stop_dev() for the device if the device can be disabled according 
to pnp_can_disable(). The problem is that pnpbios_disable_resources() 
returns -EPERM if the device is not dynamic (!pnpbios_is_dynamic()) but 
insert_device() happily sets PNP_DISABLE capability/flag even if the device 
is not dynamic. So we try to disable non-dynamic devices which will fail. 
This patch prevents insert_device() from setting PNP_DISABLE if the device is 
not dynamic and fixes suspend on my system.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.17.5-orig/drivers/pnp/pnpbios/core.c	2006-07-15 
04:38:43.000000000 +0200
+++ linux-2.6.17.5/drivers/pnp/pnpbios/core.c	2006-07-22 18:44:36.000000000 
+0200
@@ -346,7 +346,7 @@
 	dev->flags = node->flags;
 	if (!(dev->flags & PNPBIOS_NO_CONFIG))
 		dev->capabilities |= PNP_CONFIGURABLE;
-	if (!(dev->flags & PNPBIOS_NO_DISABLE))
+	if (!(dev->flags & PNPBIOS_NO_DISABLE) && pnpbios_is_dynamic(dev))
 		dev->capabilities |= PNP_DISABLE;
 	dev->capabilities |= PNP_READ;
 	if (pnpbios_is_dynamic(dev))

-- 
Ondrej Zary

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUGSTTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUGSTTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 15:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUGSTTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 15:19:16 -0400
Received: from nef.ens.fr ([129.199.96.32]:11788 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S265314AbUGSTTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 15:19:09 -0400
Date: Mon, 19 Jul 2004 21:19:06 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsuspend not working
Message-ID: <20040719191906.GA7053@lps.ens.fr>
References: <20040715121042.GB9873@lps.ens.fr> <20040715121825.GC22260@elf.ucw.cz> <20040715132348.GA9939@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040715132348.GA9939@lps.ens.fr>
User-Agent: Mutt/1.4.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Mon, 19 Jul 2004 21:19:08 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 03:23:48PM +0200, Éric Brunet wrote:
> Next I tried to suspend with the standard Fedora kernel
> (2.6.6-1.435.2.3). I booted normally, did a telinit 1, umounted
> everything except /proc and /, removed all modules except jbd and ext3
> and did echo 4 > /proc/acpi/sleep and nothing happened. Half a second
> later, sh was waiting for more input. The screen didn't blink, no line
> was output, nothing in the logs.

Ok, it is not surprising that the fedora kernel does not suspend to disk;
suspend to disk is not compiled in. What a weird decision from them.

Anyway, I recompiled a vanilla 2.6.8-rc1 with a usable configuration (usb
as modules, network, agpgart, drm, etc.) and could suspend and resume
from X11 after a standard boot sequence.

However, usb devices are in big troubles. I had at the time a wireless
usb mouse and an usb memory key plugged in. Mouse goes through the uhci
host controller and key through ehci. In short, they don't work after
resume. The weird thing is that /proc/bus/usb/devices is different after
resume: the identification strings are missing:

	diff -rU 1 usb-before/devices usb-after/devices
	--- usb-before/devices  2004-07-19 19:15:09.000000000 +0200
	+++ usb-after/devices   2004-07-19 19:15:09.000000000 +0200
	@@ -15,5 +15,2 @@
	 P:  Vendor=0d7d ProdID=1320 Rev= 0.50
	-S:  Manufacturer=ASUS
	-S:  Product=Ai Flash-4
	-S:  SerialNumber=07420B100083
	 C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=200mA
	@@ -48,4 +45,2 @@
	 P:  Vendor=1733 ProdID=0101 Rev= 0.01
	-S:  Manufacturer=Cellink Co., LTD.
	-S:  Product=Wireless RF Mouse
	 C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA

If I rmmod ehci_hcd and modprobe it back, I can have the memory key
working again (except that if it was mounted before, troubles ahead. I
had a kernel oops that way.) If I rmmod uhci_hcd and modprobe it back,
the mouse becomes alive again.

If, instead of unloading/reloading the modules, I unplug and replug the
radio emiter of the mouse, I get it back working. If I unplug the memory
key, the device REMAINS as managed by the ehci controller. If I plug it
back again, the memory key appears A SECOND TIME in the list of usb
device, but as an uhci device, this time.

I guess I could rmmod the usb modules before suspending and modprobe back
them after resuming, but that means I need to remember that if a memory
key, a camera or a zip drive is plugged in and mounted, I will probably
crash the kernel. Hmm.

Another device is not working after resume: it is an old realtek 8029
100 Mb LAN pci card. If I try to ping something on the LAN, I get a
« Destination Host Unreachable » and nothing more. The interrupt count of
the card is increasing, however. Unloading and reloading ne2k_pci fixes
that.

Note that when I suspend, I get in the log
20:13:46: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
20:13:47: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
20:13:51: eth0: link down
20:13:51: ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 10 (level, low) -> IRQ 10
20:13:51: Fixing swap signatures... ok
20:13:51: Restarting tasks... done

and at resume time:
20:15:52: eth1: mismatched read page pointers 4c vs 68.

eth1 is the misbehaving LAN card, and its interrupt is 10.

When I unload/reload the ne2k_pci module, I get at reload time:
20:21:11: ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
20:21:11: http://www.scyld.com/network/ne2k-pci.html
20:21:11: ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 10 (level, low) -> IRQ 10
20:21:11: eth1: RealTek RTL-8029 found at 0xc800, IRQ 10, 00:40:05:E2:2A:CF.

Notice the ACPI: PCI interrupt line. I have something similar when I
reload the ehci module
20:20:31: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11

I am not sure what all of this means. I could try to fiddle the kernel
configuration, but is it worth it ? For instance, would you recommend
using APIC or try different pci=... command line options to change the
way interrupts are initialized ?

Data on my computer on <http://tudia.nerim.net/bug-reports/>.

Oh, by the way, the merging of pmdisk and swsuspend is great news !

Regards,

	Éric Brunet

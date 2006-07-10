Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWGJHl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWGJHl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWGJHl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:41:28 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:23753 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1750773AbWGJHl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:41:27 -0400
Message-ID: <44B203F4.1030903@s5r6.in-berlin.de>
Date: Mon, 10 Jul 2006 09:38:28 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christian Kujau <evil@g-house.de>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: ohci1394: aborting transmission
References: <Pine.LNX.4.64.0607100527200.10447@sheep.housecafe.de>
In-Reply-To: <Pine.LNX.4.64.0607100527200.10447@sheep.housecafe.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau wrote:
> I've noticed a *very* long delay upon booting current -mm kernels. 
> Here's a snippet from netconsole with 2.6.17-mm6:
> 
> ------------snip--------------------
>   [   50.651945] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
>   [   50.655774] NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-7182  Wed Apr 19 13:55:00 PDT 2006
>   [   50.763074] ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 23 (level, high) -> IRQ 23
>   [   51.078391] intel8x0_measure_ac97_clock: measured 50730 usecs
>   [   51.082255] intel8x0: clocking to 46828
>   [   51.651890] ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
>   [  229.450216] input: USB HIDBP Keyboard 046a:0001 as /class/input/input0
>   [  229.458201] usbcore: registered new driver usbkbd
>   [  229.462264] drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
>   [  229.473883] input: Logitech USB-PS/2 Optical Mouse as /class/input/input1
>   [  229.479629] usbcore: registered new driver usbmouse
> ------------snap--------------------
> 
> So, we're waiting 3 minutes from 'ohci1394: aborting transmission' until 
> 'input: USB HIDBP' kicks in and boot continues as usual. Unfortunately 
> I'm not sure since when this unusual delay is present as I don't
> monitor the box' startups closely. With 2.6.18-rc1 it's:

[...also delayed but without "AT dma reset ctx=0, aborting
transmission", and it gets to "ieee1394: Host added"...]

> While I'm trying to find out the first kernelversion with these 
> symptoms: any ideas on this one?

No idea here. I don't have an idea what could cause a delay with a
timeout of 3 minutes in the 1394 drivers.

Perhaps you should add a printk at the beginning of input's init
function. The delay could happen during the startup of the input layer
instead of the 1394 drivers.

> I can see the "[PATCH 2.6.17-rc5-mm2 00/18] ieee1394: misc updates" 
> patchset, maybe I'll start with this one....

In order to avoid patch mismerges, you could grab the broken-out patches
from
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
and start bisecting within the set of 1394 patches. Among them, the
patches to sbp2, dv1394, and raw1394 are unrelated to the problem. Note
that "origin.patch" touches drivers/ieee1394/ too.

You could also test Linux 2.6.17.x with patchkit v121 from
http://me.in-berlin.de/~s5r6/linux1394/updates/ applied. As far as
drivers/ieee1394/ is concerned, this is the same as the 1394 drivers in
2.6.17-mm6, and I believe 2.6.18-rc1-mm1 too.

If 2.6.17.x + latest 1394 has the delay, try original 2.6.17.x too
unless you didn't already.

If 2.6.17.x + latest 1394 does not have the delay, then the 1394 updates
are _perhaps_ not to blame.

The VIA VT6306 OHCI controller which you have according to your lspci
output is known to work; yours doesn't even have the small quirk
mentioned in http://www.linux1394.org/view_device.php?id=713 .
-- 
Stefan Richter
-=====-=-==- -=== -=-=-
http://arcgraph.de/sr/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVCYAuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVCYAuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVCYAtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:49:42 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:51798 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261314AbVCYAVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:21:20 -0500
Message-ID: <4243597C.7090800@tls.msk.ru>
Date: Fri, 25 Mar 2005 03:21:16 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-parport@lists.infradead.org
Subject: Re: [PATCH] Netmos parallel/serial/combo support
References: <1111533253.22819.2.camel@eeyore>  <424325A7.2010101@tls.msk.ru> <1111702349.25455.15.camel@eeyore>
In-Reply-To: <1111702349.25455.15.camel@eeyore>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
[]
>>I've a 9835 card with two serial and no parallel ports:
>>
>>0000:01:00.0 0700: 9710:9835 (rev 01) (prog-if 02)
>>         Subsystem: 1000:0002
[]
>>But after reloading parport_pc, it does not see the built-in
>>port anymore; more, after unloading 8250_pci and 8250,
>>parport_pc finds one parallel port -- on this netmos
>>card only (there's no parallel port on this card):
>>
>>PCI parallel port detected: 9710:9835, I/O at 0x9800(0x9400)
>>parport0: PC-style at 0x9800 (0x9400) [PCSPP,TRISTATE]
> 
> Hmmm...  Do you have an init script or something that pokes
> 9835 into /sys/bus/pci/drivers/parport_pc/new_id?  If not,
> I don't see how parport_pc could claim your 9835, since it's
> not compiled into parport_pc_pci_tbl.  It looks like you
> should be able to turn off the new_id functionality by
> disabling CONFIG_HOTPLUG.

Well, I do see how parport_pc is claiming the device.
This is the chunk from your patch I applied manually,
or, rather, didn't apply at all because the change was
about re-ordering stuff only.

It did not apply because the two IDs - 9735 and 9835 -
are still present in 2.6.11 kernel.  Your mention about
parport_pc_pci_tbl[] made me realize that I applied the
patch incorrectly.  So I finally found the two devices
aren't present in Linus rc1 tree, and removed them here
too (so that parport_pc.c reordering of your patch now
applies too).

With that change, parport_pc does not claim the device
anymore, which is the right behaviour, -- ie, for 9835
card, looks like everything works just fine now.  So
please treat this my report as a success story about
netmos cards support... and thank you for your work!..


The problem with built-in port and parport_pc reloading
still exists (or seems to be), even after applying the
rest of parport_pc changes which are in Linus rc1. But..
after modifying all those files several times, I can't
be sure it wasn't my fault again.  I will try to repatch
and recompile it all tomorrow.  Here's how it looks
like now:

# modprobe parport_pc
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
# rmmod parport_pc
pnp: Device 00:07 disabled.
# modprobe parport_pc
pnp: Device 00:07 activated.
parport: PnPBIOS parport detected.
pnp: Device 00:07 disabled.
... and so on - no parport0 anymore.

/mjt

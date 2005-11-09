Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbVKIK2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbVKIK2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 05:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbVKIK2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 05:28:07 -0500
Received: from soohrt.org ([85.131.246.150]:53683 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S1030458AbVKIK2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 05:28:06 -0500
Date: Wed, 9 Nov 2005 11:27:59 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Highpoint IDE types
Message-ID: <20051109102759.GA19222@soohrt.org>
References: <1131471483.25192.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1131471483.25192.76.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox wrote:
> Ok thanks to Sergei I can now post what I think is the complete table of
> HPT chip versions:
> 
>         Chip                    PCI ID          Rev
>  *      HPT374                  8 (HPT374)      *     
>
> The base clocks for the devices are as follows (note this means most of
> the drivers/ide/pci detection code for frequency is wrong). Also for PLL
> mode the 3x2N PLL stabilization code is subtly different.
> 
> 371N/372N/302N		77
> 302/371/372A		66
> 372			55
> 370/374			48
> 
> The DPLLs are
> 	48, 50, 66, 75Mhz
> 
> 75 is only available on the later chips and used with PATA/SATA bridge
> chips for UDMA7.

I've got the following HPT374 controllers on my mainboard and the
default freq value never worked for me (OOPS during boot).

0000:00:0e.0 0104: 1103:0008 (rev 07)
        Subsystem: 1103:0001
        Flags: bus master, 66MHz, medium devsel, latency 120, IRQ 10
        I/O ports at b000 [size=8]
        I/O ports at b400 [size=4]
        I/O ports at b800 [size=8]
        I/O ports at bc00 [size=4]
        I/O ports at c000 [size=256]
        Expansion ROM at 30020000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2

0000:00:0e.1 0104: 1103:0008 (rev 07)
        Subsystem: 1103:0001
        Flags: bus master, 66MHz, medium devsel, latency 120, IRQ 10
        I/O ports at c400 [size=8]
        I/O ports at c800 [size=4]
        I/O ports at cc00 [size=8]
        I/O ports at d000 [size=4]
        I/O ports at d400 [size=256]
        Capabilities: [60] Power Management version 2

[   34.230429] HPT374: IDE controller at PCI slot 0000:00:0e.0
[   34.230461] PCI: Enabling device 0000:00:0e.0 (0005 -> 0007)
[   34.230491] PCI: Found IRQ 10 for device 0000:00:0e.0
[   34.230525] PCI: Sharing IRQ 10 with 0000:00:0e.1
[   34.230555] HPT374: chipset revision 7
[   34.230584] HPT374: 100% native mode on irq 10
[   34.230613] HPT37X: using 33MHz PCI clock
[   34.230723]     ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:DMA, hdf:DMA
[   34.230779] HPT37X: using 33MHz PCI clock
[   34.230887]     ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:pio, hdh:pio
[   34.230949] PCI: Found IRQ 10 for device 0000:00:0e.1
[   34.230980] PCI: Sharing IRQ 10 with 0000:00:0e.0
[   34.231023] HPT37X: using 33MHz PCI clock
[   34.231131]     ide4: BM-DMA at 0xd400-0xd407, BIOS settings: hdi:DMA, hdj:DMA
[   34.231188] HPT37X: using 33MHz PCI clock
[   34.231296]     ide5: BM-DMA at 0xd408-0xd40f, BIOS settings: hdk:DMA, hdl:DMA


I have to use this patch. I'm not sure if it does the right thing,
but at least it works without OOPS and without data corruption.

--- linux/drivers/ide/pci/hpt366.c~     2005-07-24 01:51:31.000000000 +0200
+++ linux/drivers/ide/pci/hpt366.c      2005-07-26 14:22:42.000000000 +0200
@@ -1188,7 +1188,7 @@
        }
        else
        {
-               if(freq < 0x9C)
+               if(freq < 0xA4)
                        pll = F_LOW_PCI_33;
                else if(freq < 0xb0)
                        pll = F_LOW_PCI_40;

Here's a history of freq values:
/var/log/kern.log.1.gz:Oct 18 05:04:12 pikelot kernel: freq: 9c
/var/log/kern.log.1.gz:Oct 18 05:04:12 pikelot kernel: freq: 97
/var/log/kern.log.1.gz:Oct 18 09:59:54 pikelot kernel: freq: 9f
/var/log/kern.log.1.gz:Oct 18 09:59:54 pikelot kernel: freq: 9e
/var/log/kern.log.1.gz:Oct 20 10:29:40 pikelot kernel: freq: 92
/var/log/kern.log.1.gz:Oct 20 10:29:40 pikelot kernel: freq: 9e
/var/log/kern.log.3.gz:Oct  6 10:27:52 pikelot kernel: freq: 99
/var/log/kern.log.3.gz:Oct  6 10:27:52 pikelot kernel: freq: a1
/var/log/kern.log.3.gz:Oct  8 15:17:59 pikelot kernel: freq: 9c
/var/log/kern.log.3.gz:Oct  8 15:17:59 pikelot kernel: freq: a2
/var/log/kern.log.3.gz:Oct  8 16:08:26 pikelot kernel: freq: 9b
/var/log/kern.log.3.gz:Oct  8 16:08:26 pikelot kernel: freq: 9e
/var/log/kern.log.3.gz:Oct  9 06:02:15 pikelot kernel: freq: 9d
/var/log/kern.log.3.gz:Oct  9 06:02:15 pikelot kernel: freq: 98

The machine is not and never has been overclocked.

Best Regards,
 Karsten Desler

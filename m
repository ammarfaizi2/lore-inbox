Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbTHTXjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTHTXjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:39:53 -0400
Received: from palrel10.hp.com ([156.153.255.245]:42407 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262260AbTHTXju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:39:50 -0400
Date: Wed, 20 Aug 2003 16:39:48 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>, Massimo Piccioni <dafastidio@libero.it>
Subject: Bug: 2.6.0-test3 + AD1816A -> PnP failure
Message-ID: <20030820233948.GA15813@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	This is my first time using Alsa and PnP, and I can't get the
driver to recognise the hardware.

	The hardware :
--------------------------------------------------
# cat /sys/bus/pnp/devices/00:16/id
ADS7180
# cat /sys/bus/pnp/devices/00:16/name

# cat /sys/bus/pnp/devices/00:16/resources
state = active
io 0x220-0x22f
io 0x388-0x38b
io 0x530-0x53f
irq 5
dma 1
dma 0
# cat /sys/bus/pnp/devices/00:16/options 
port 0x220-0x2e0, align 0x1f, size 0x10, 16-bit address decoding
port 0x388-0x3a0, align 0x7, size 0x4, 16-bit address decoding
port 0x500-0x560, align 0xf, size 0x10, 16-bit address decoding
irq 5,7,2/9,10,11,15 High-Edge
dma 0,1,3 8-bit compatible
dma 0,1,3 8-bit compatible
--------------------------------------------------

	The kernel (2.6.0-test3) :
----------------------------
CONFIG_ISA=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_SND=m
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_AD1816A=m
----------------------------

	The error message :
-----------------------------------------
# modprobe snd-ad1816a
FATAL: Error inserting snd_ad1816a (/lib/modules/2.6.0-test3/kernel/sound/isa/ad1816a/snd-ad1816a.ko): No such device
no AD1816A based soundcards found.
# insmod /lib/modules/2.6.0-test3/kernel/sound/isa/ad1816a/snd-ad1816a.ko port=0x130 mpu_port=0x330 fm_port=0x388 irq=5 mpu_irq=11 dma1=1 dma2=0
Error inserting '/lib/modules/2.6.0-test3/kernel/sound/isa/ad1816a/snd-ad1816a.ko': -1 No such device
-----------------------------------------

	Note that I tried the obvious and added the "ADS7180" ID
explicitely in the driver source (by dupping the "ADS7181" line), but
that didn't make any difference (same errors) :
------------------------------------------
	/* Analog Devices AD1816A - added by Jean Tourrilhes <jt@hpl.hp.com> */
	{ .id = "ADS7180", .devs = { { .id = "ADS7180" }, { .id = "ADS7181" } } },
------------------------------------------

	Device is explicitely enabled in the BIOS and I double checked
that there was no I/O and irq conflicts. From my little understanding
of PnP, if the ID is in the list, it should bind the driver. But how
do I know ;-)

	Just for completness, messages log at boot :
------------------------------------------------
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7110
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xada2, dseg 0x400
PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.11
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
pnp: Device 00:0e activated.
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: Device 00:0f activated.
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
------------------------------------------------
	PC is dual PIII with 440BX chipset.

	Have fun...

	Jean

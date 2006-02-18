Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWBRHfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWBRHfo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 02:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWBRHfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 02:35:44 -0500
Received: from marsha.pcisys.net ([216.229.32.146]:61894 "EHLO
	marsha.pcisys.net") by vger.kernel.org with ESMTP id S1750968AbWBRHfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 02:35:43 -0500
Date: Sat, 18 Feb 2006 00:36:22 -0700
From: Brian Hall <brihall@pcisys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Help: DGE-560T not recognized by Linux
Message-Id: <20060218003622.30a2b501.brihall@pcisys.net>
In-Reply-To: <20060217222428.3cf33f25.akpm@osdl.org>
References: <20060217222720.a08a2bc1.brihall@pcisys.net>
	<20060217222428.3cf33f25.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.0beta8 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006 22:24:28 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Brian Hall <brihall@pcisys.net> wrote:
> >
> > I have just built a new system, based on an Asrock 939Dual-Sata
> >  motherboard. It only has 100MB built-in networking (uli526x), so I
> >  purchased a D-Link DGE-560T PCI-e gigabit NIC ($81 at Newegg)
> > thinking it was supported by Linux. Looking at the card, it appears
> > to be a Marvell chip, but neither the sk98lin or skge drivers
> > worked. I tried other GBe drivers as well, they didn't recognize it
> > either.
> > 
> >  Is there a place where I can just add this card's ID and use one
> > of the sk* drivers? I paged through the source but didn't see an
> > obvious place to add a card ID, but it must be in there somewhere.
> > 
> >  I'm not subscribed to linux-kernel, please CC: me on replies,
> > thanks.
> > 
> >  Here's the info from the card:
> >  big M on the chip (Marvell I assume)
> >  88E8052-NNC
> >  GMAA17011A1
> >  0442 A2P
> > 
> >  and on the back of the card:
> > 
> >  00005A708649 0592
> >  DLink
> >  531CL00467 DGE-560T 70-13-001-001
> > 
> >  from lspci:
> > 
> >  02:00.0 0200: 1186:4b00 (rev 11)
> >  	Subsystem: 1186:4b00
> 
> See drivers/net/sk98lin/skge.c:skge_pci_tbl[]:
> 
> /* DLink card does not have valid VPD so this driver gags
>  *	{ PCI_VENDOR_ID_DLINK, 0x4c00, PCI_ANY_ID, PCI_ANY_ID, 0,
> 0, 0 }, */
> 
> That's your card, except yours is 0x4b00.
> 
> You can try it, but it might gag...

Didn't work at all, no effect.

> Also see drivers/net/skge.c:skge_id_table[]:
> 
> 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,
> PCI_DEVICE_ID_DLINK_DGE510T), },
> 
> That's the same device as in sk98lin/skge.c.  Try adding a line
> 
> 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b00), },

Using sk98lin this "almost" worked- brought the line up, got a
gigabit connection light on my switch, but trying to assign an IP to
the interface results in a kernel panic. Not good...

I see that the sky2 driver in 2.6.16rc4 lists my card, but for some
reason it fails to access the card, maybe because I have an ULi chipset?

Feb 17 23:18:46 syrinx sky2 0000:02:00.0: can't access PCI config space
Feb 17 23:18:46 syrinx ACPI: PCI interrupt for device 0000:02:00.0
disabled 
Feb 17 23:18:46 syrinx sky2: probe of 0000:02:00.0 failed with
error -22 
Feb 17 23:23:03 syrinx ACPI: PCI Interrupt 0000:02:00.0[A] ->
GSI 30 (level, low) -> IRQ 24
Feb 17 23:23:03 syrinx PCI: Setting latency timer of device
0000:02:00.0 to 64 
Feb 17 23:23:03 syrinx sky2 0000:02:00.0: can't
access PCI config space 
Feb 17 23:23:03 syrinx ACPI: PCI interrupt for
device 0000:02:00.0 disabled 
Feb 17 23:23:03 syrinx sky2: probe of
0000:02:00.0 failed with error -22

Here's the PCI options I have enabled in 2.6.16-rc4:
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_MSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_NET_PCI=y

# lspci
00:00.0 Host bridge: ALi Corporation M1695 K8 Northbridge [PCI Express and HyperTransport]
00:01.0 PCI bridge: ALi Corporation Unknown device 524b
00:02.0 PCI bridge: ALi Corporation Unknown device 524c
00:04.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single Chip]
00:05.0 PCI bridge: ALi Corporation AGP8X Controller
00:06.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge
00:07.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev 70)
00:07.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:11.0 Ethernet controller: ALi Corporation M5263 Ethernet Controller (rev 40)
00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
00:12.1 IDE interface: ALi Corporation ULi 5289 SATA (rev 10)
00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
02:00.0 Ethernet controller: D-Link System Inc Unknown device 4b00 (rev 11)
03:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
03:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
04:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
04:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)

--
Brian Hall
Linux Consultant
http://pcisys.net/~brihall

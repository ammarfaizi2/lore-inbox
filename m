Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKWShX>; Thu, 23 Nov 2000 13:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129097AbQKWShN>; Thu, 23 Nov 2000 13:37:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38920 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129091AbQKWSg7>; Thu, 23 Nov 2000 13:36:59 -0500
Date: Thu, 23 Nov 2000 10:06:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tobias Ringstrom <tori@tellus.mine.nu>
cc: David Hinds <dhinds@zen.stanford.edu>, Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Cardbus bridge problems
In-Reply-To: <Pine.LNX.4.21.0011221432110.31073-500000@svea.tellus>
Message-ID: <Pine.LNX.4.10.10011230939270.859-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Tobias: thanks for an excellent report, btw ]

On Wed, 22 Nov 2000, Tobias Ringstrom wrote:
> On Wed, 22 Nov 2000, Tobias Ringstrom wrote:
> 
> > Not that I like it, but I need to boot Win98, and then warm boot into
> > Linux, or the Cardbus is not working.  This is using Linux-2.4.0-test11 on
> > a Mitac 7233 laptop.
> > 
> > Using lspci, I can see that the secondary and subordinate busses of the
> > Cardbus bridges are unconfigured/incorrect. I have attached dmesg and
> > lspci -vvvxxx output from the two cases (ok=Win98+warm-boot and
> > fail=cold-boot). I have enabled all PCI debug things I could find. Bw, it
> > would be really nice to have ONE place to enable the PCI debug info.

You have a really sick system, the following is absolute garbage:

00:08.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
        Subsystem: Mitac: Unknown device 7233
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=00, subordinate=00, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001800-000018ff
        I/O window 1: 00001c00-00001cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

That bus setup is horribly wrong, and says that the CardBus bridge no bus
numbers, which is obviously not correct. It somehow got through the bridge
scanning without being fixed up..

Now, the reason for why it seems to be so unhappy is apparently

	Scanning behind PCI bridge 00:08.0, config 000040, pass 1
	Scanning behind PCI bridge 00:08.1, config 000040, pass 1

Note the "config 000040". It basically seems to imply that the cardbus
bridge has been set up as bus 0x40, ie 64. With no secondary bus behind
it. Which looks completely and utterly bogus.

I bet the thing works for you if you change the magic constant 0xffffff in
pci_scan_bridge() to the new magic constant 0xffff00. Basically, we don't
much care what it reports for the primary bus number: but we _do_ care
that a PCI bridge should have a secondary bus number.

Martin, What say you? I think 0xffff00 makes more sense here anyway. And I
bet(*) it will also fix the problem Tobias is seeing.

Tobias? Does changing that if-statement that make your bus happier?

Oh, btw, Martin: I suspect the "cardbus bridge already set up" case in
pci_scan_bridge() should also have the logic

	unsigned int cmax = child->subordinate;
	if (cmax > max) max = cmax;

in addition to setting up the resources. Comments? As it stands now, it
looks like a pre-configured cardbus bridge doesn't count towards "max" at
all..

		Linus

(*) But I won't be betting huge amounts of money on it. There may be other
things that aren't initialized correctly.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

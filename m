Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131092AbRAHJBi>; Mon, 8 Jan 2001 04:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131545AbRAHJBS>; Mon, 8 Jan 2001 04:01:18 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:21976 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S131092AbRAHJBJ>; Mon, 8 Jan 2001 04:01:09 -0500
Date: Mon, 8 Jan 2001 09:08:03 +0000
From: Philip Armstrong <phil@kantaka.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christian.Engstler@gmx.net, evaner@bigfoot.com, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: Related VIA PCI crazyness?
Message-ID: <20010108090803.A452@kantaka.co.uk>
In-Reply-To: <20010107122800.A636@kantaka.co.uk> <200101072352.PAA28348@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101072352.PAA28348@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 07, 2001 at 03:52:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 03:52:41PM -0800, Linus Torvalds wrote:
> In article <20010107122800.A636@kantaka.co.uk>,
> Philip Armstrong  <phil@kantaka.co.uk> wrote:
> >In supplement to Evan Thompson's emails with the subject "Additional
> >info. for PCI VIA IDE crazyness. Please read." I've noticed the
> >following message with recent 2.4.0 test + release kernels:
> >
> >IRQ routing conflict in pirq table! Try 'pci=autoirq'
> 
> But the machine still works fine, ie the SCSI driver and the network
> driver still seem happy?

Just plugged the laptop back in. Yup. Everything seems happy; SCSI,
network etc,etc all doing their thing.

> If so, it sounds like maybe the VIA pirq router functions are buggy (it
> looks like the sense of pirq 01 and pirq 03 are reversed).
[snip]
> looks like Christian, too, has a working machine, and that the only bad
> result of this all is an annoying printk message.  Can you confirm that
> things actually work for you too, and you'd just like to get rid of the
> unnerving message?

So long as there's no underlying problem then I don't particularly
care! Though removing the Try 'pci=autoirq' bit (which doesn't do
anything any more as far as I can see) might be sensible...

> If the VIA logic for getting/setting the irq is wrong, it should only be
> a problem if there are devices that _haven't_ been routed by the BIOS. 
> Usually these devices are limited to things like USB, ACPI and CardBus
> controllers, and getting the irq routing wrong in that case can be
> deadly (infinite irq streams on the wrong irq line). 

I've turned USB off in the BIOS setup altogether. However, in the
recent past I've used a USB webcam which appeared to work (this was in
2.4.0test4 days or thereabouts.)

> The case where you get an annoying message are the cases where Linux
> knows something is wrong, but decides to take the safe approach - it
> seems to be working for you, as far as I can tell, but that message
> _does_ mean that we may have problems on other machines with the VIA
> chipset. 
> 
> I _think_ the VIA routing functions were done by Jeff Garzik, Cc'd.
> 
> Looking at the VIA irq routing, it looks a bit strange. We have pirqa in
> the high nybble of config sparce port 55h, then we have pirqb and c in
> 56h (low and high nybbles respectively), and then we have pirqd in the
> high nybble of 57h.
> 
> The reason this is strange is that it's not consecutive nybbles.  I'd
> have expected pirqd to show up in the _low_ nybble of 57h.  But as the
> pirq routing fields are pure software convention, it's hard to know
> whether this is already taken into account in the pirq routing table or
> what the magic is. 
> 
> Could anybody with a VIA chip who has the energy please do something for
> me:
>  - enable DEBUG in arch/i386/kernel/pci-i386.h
done
>  - do a "/sbin/lspci -xxvvv" on the interrupt routing chip (it's the
>    "ISA bridge" chip - the VIA numbers are 82c586, 82c596, the PCI
>    numbers for them are 1106:0586 and 1106:0596, I think)

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 41)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort - <MAbort- >SERR- <PERR-
        Latency: 0
00: 06 11 86 05 8f 00 00 02 41 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

>  - do a cat /proc/pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 3).
      Master Capable.  Latency=16.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 65).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0xe000 [0xe00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.  
      I/O at 0xe400 [0xe41f].
  Bus  0, device   7, function  3:
    Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
  Bus  0, device   8, function  0:
    SCSI storage controller: Advanced System Products, Inc ABP940-U / ABP960-U (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=4.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xef100000 [0xef1000ff].
  Bus  0, device  10, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xef101000 [0xef1010ff].
  Bus  0, device  11, function  0:
    Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder (rev 1).
      IRQ 9.
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xef000000 [0xef0fffff].
  Bus  0, device  12, function  0:
    Multimedia video controller: 3Dfx Interactive, Inc. Voodoo 2 (rev 2).
      Prefetchable 32 bit memory at 0xee000000 [0xeeffffff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II] AGP (rev 0).
      IRQ 11.
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xec000000 [0xecffffff].
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe8003fff].
      Non-prefetchable 32 bit memory at 0xe9000000 [0xe97fffff].


> With that, I and Jeff can probably match up the interrupt routing table
> entries with the devices, and check what the routing information in the
> config space of the actual router chip is, to verify what the pirq
> translation really should be.

Hope the above is of some use.

cheers,

Phil

-- 
http://www.kantaka.co.uk/ .oOo. public key: http://www.kantaka.co.uk/gpg.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

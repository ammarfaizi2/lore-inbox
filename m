Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271931AbRIMRuf>; Thu, 13 Sep 2001 13:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271941AbRIMRu0>; Thu, 13 Sep 2001 13:50:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2115 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271931AbRIMRuG>; Thu, 13 Sep 2001 13:50:06 -0400
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stomping on Athlon bug
In-Reply-To: <17613305632.20010913121304@port.imtp.ilyichevsk.odessa.ua>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Sep 2001 09:11:26 -0600
In-Reply-To: <17613305632.20010913121304@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <m1zo7zt9b5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VDA <VDA@port.imtp.ilyichevsk.odessa.ua> writes:

> Hi. Below is a modified printout of lspci -vvvxxx

> made on VIA KT133A based mainboard with BIOS version 3R flashed in
> (this system is exhibiting Athlon bug) and on the same system
> with BIOS version YH (which do not trigger bug).
> Each chipset config register which is changed between these two BIOSes
> is underlined with carets "^" with programming details immediately below.


> Each register is then commented with:
> *** 3R BIOS: settings made by 3R BIOS
> *** YH BIOS: settings made by YH BIOS
> *** TODO: is this relevant and what to do
> 
> Anyone interested in trying to pin down the bug might
> try to reprogram this chipset along the lines:
>     ...
>     struct pci_dev *dev;
>     dev = pci_find_device(PCI_VENDOR_ID_VIA, 0x0305, NULL);
>     if(dev) {
>         printk("Trying to stomp on Athlon bug...\n");
>         u8 v;
>         pci_read_config_byte(dev, 0x52, &v);
>         /* set 52.7: Disconnect Enable When STPGNT Detected */
>         v |= 0x80;
>         pci_write_config_byte(dev, 0x52, v);
>         ...
>     }
>     ...

> I'm not sure where exactly this piece of code should go.
> Anyway, compile K7 optimized kernel with this fix
> and give it a try.

At this point I don't have a board to reproduce this on but I'm
see if any of my experience from writing linuxBIOS for the AMD760
chipset can help.

The S2K Timing and BIU Controls are my current favorite canidates,
as they control the bus between the cpu and the northbridge.

Device 0 Offset D - Latency Timer. 
 -- This can cause changes to how pci bursts are handled.
    It's not on the CPU<->memory path so it is an unlikely canidate.

Device 0 Offset 13-19 - Graphics Aperture Base.
  -- A plug and play base register should be nearly harmless

Device 0 Offset 52 - S2K Timing Controll III
  -- This is talking about disconnecting the cpu from northbridge
     to increase power savings.  I have heard various errata
     with disconnects happening (AMD760 specific I think).
     So 3R has by not allowing disconnects has the more conservative
     value.  Besides this is not something that should occur during
     memcpy.

Device 0 Offset 54 - BIU Control
  -- This is my favorite canidate.  YH is more conservative than 3R
     here.  And when the CPU->northbridge bus is not setup just
     write I have seen all kinds of interesting issues.

Device 0 Offset 55 - 
> YH 50: .. .. .. .. .. 00 04 04 00 00 01 02 03 04 04 04
> 3R 50: .. .. .. .. .. 89 04 04 00 00 01 02 03 04 04 04
>                       ^^
> Device 0 Offset 55 - Debug (RW)
> 7-0 Reserved (do not program). default = 0
> *** 3R BIOS: non-zero!?
> *** YH BIOS: zero.
> *** TODO: try to set to 0.

The kx133.pdf that I have documents bit 0 as S2K Compensation During
CPU Halt.
Which makes this a register a major canidate.  I wonder if something
set wrong pci register by accident?

Device 0 Offset 69 - DRAM Clock Select
YH is more conservative here.  Wow the memory timings changed
between BIOS revs.  And interesting variation is that kx133
documentation does not have bit 5 settable.

Device 0 Offset 70 - PCI Buffer Control
I'd check this one on the reports of PCI DMA corrupting
IDE traffic.  For memcpy causing problems  it doesn't looke
like a canidate.

Device 0 Offset AC - AGP Control
This looks unlikely to cause any problems.  Plus it's AGP

Device 0 Offset B2 - AGP Pad Drive / Delay Control
Ditto.

Device 0 Offset B7 - S2K Compensation Result 3
If this doesn't vary slightly from boot to boot that a read-only
value changes is worrying.

> YH f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 00 00 00
> 3R f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 80 00 00
>                                               ^^
> Device 0 Offset FD - Back-DoorControl 2 (00h) ........... RW
> 7-5 Reserved. always reads 0
> 4-0 Max # of AGP Requests. default = 0
>     00000 1 Request
>     00001 2 Requests
>     00010 3 Requests
>     ..... ........
>     11111 32 Requests
>     (see also RxA7 and RxFC[1])
> *** 3R BIOS: 80
> *** YH BIOS: 00
> *** TODO: probably doesn't matter
>     Curious how "always zero" bit 7 happen to become 1
      Quite.

Eric


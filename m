Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312363AbSCZP6H>; Tue, 26 Mar 2002 10:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312364AbSCZP56>; Tue, 26 Mar 2002 10:57:58 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:6110 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S312363AbSCZP5m>; Tue, 26 Mar 2002 10:57:42 -0500
Date: Tue, 26 Mar 2002 15:57:36 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: Kai-Boris Schad <kschad@correo.e-technik.uni-ulm.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load
 togeter with heavy network load
In-Reply-To: <200203261127.MAA05078@correo.e-technik.uni-ulm.de>
Message-ID: <Pine.LNX.4.44.0203261536140.3906-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I saw similar issues with a KT133A-RAID board.  The latest BIOS from 
ABit appear to have helped fix this problem here, as does the VIA fix 
to register 0x55.

Before this, I was seeing hard freezes when using software raid-5 too.  
I still see a very occasional glitch where the machine appears to get 
stuck doing a repeated bus-master transfer. The last occurance was a
hard loop with the sound card repeating the same ~ 0.5 seconds over 
and over, but the machine was entirely frozen, with no sysrq / network 
activity.

My lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
00:0f.0 Multimedia audio controller: Trident Microsystems 4DWave DX (rev 02)
00:11.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 12)
00:13.0 Unknown mass storage controller: HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Controller (rev 04)
01:00.0 VGA compatible controller: nVidia Corporation NV11 DDR (rev b2)

and also from the startup dmesg, the message about the memory write 
queue, which is known to cause corruption and freezes if it's not 
done:

Disabling VIA memory write queue: [55] 89->09

I'm using 2.4.19-pre3 with AlanC's pre4 patch ontop of that with good 
success.  You might try one of the very latest kernels as the via fix
was pretty recent.

I would say that my experience with this via chipset has put me off 
their product for future purchases.

The read performance of my raid-5 partition is only around 50MB/sec,
when the individual drives all produce 40MB/sec, and this does seem
very strongly dependent on the PCI options in the BIOS.

It is still well below the 60-80MB/sec I was hoping to see. (Based
approximately on total theoretical pci bandwidth * 66% for my 3 disk
raid-5 setup, with each disk on an individual chain.)  Note I did 
isolate the raid-5 from causing problems by monitoring the overall 
transfer rates running parallel read tests against each disk, as well 
as an overall read test against the md device.  Virtually no 
throughput difference.

Note there is a windows-only patch available on viaarena.com that
claims to really improve PCI burst transfer bandwidth, but my attempts
to contact the author for details of what that patch actually does
have so far gone unanswered.

PrePatch:   http://www.tecchannel.de/hardware/817/5.html
Via Patch:  http://www.viaarena.com/?PageID=66#raid
Post Patch: http://www.tecchannel.de/hardware/817/11.html

Cheers,

Mark

On Tue, 26 Mar 2002, Kai-Boris Schad wrote:

> Hi !
> 
> I have problems with PC mainboard using the Via VT8367 [KT266] chipset.  
> lspci shows the configuration:
> lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
> 00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
> 00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 
> 01)00:0f.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
> (rev 01)00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
> 00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 27)
> 
> The CPU is a 1400MHz Athlon. 
> We use this system for a software Raid 5. If we produce heavy load on the 
> disks and network the system hangs. There is no log of errors at all. We 
> tried to change the network card form a 3com to a rtl83xx. The system remains 
> a litle longer stable but crashes then too. We also tried to have the 
> harddisks on seperate ide channels but this didn't solve the crashs. 
> It seems to be something with the dma, because if we disable the dma of the 
> harddisks the system is stable. Does anybody also recognise this problem ?
> Is there any solution for this effect ?
> 
> Thanks a lot 
> 
> Kai
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+


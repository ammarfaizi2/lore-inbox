Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVHLRVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVHLRVO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVHLRVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:21:14 -0400
Received: from dsl3-63-249-67-204.cruzio.com ([63.249.67.204]:34988 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S1750729AbVHLRVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:21:13 -0400
Date: Fri, 12 Aug 2005 10:21:08 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200508121721.j7CHL84P026703@cichlid.com>
To: video4linux-list@redhat.com
Subject: Re: bttv oopses, is this a valid v4l test?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I find that if I just cat /dev/video to a file it grows about
>> 5MB/sec. Is this 'good enough' to test the bttv/bt878 pci/dma
>> oopses? I want to test in single user mode to minimize damage
>> to my filesystem.

>	bttv, on overlay mode does something that is not very often used by
>other types of cards (but supported by PCI specs):
>	It transfers data FROM TV board TO Video memory, WITHOUT using the
>machine's internal memory. This is called PCI to PCI data transfer (or
>better: PCI to AGP in your mb).

Hi Mauro

I have overlay mode disabled. Also, I don't view the video directly, its a
security camera setup so it just creates avi files from the cameras, constantly
in the background. So it's the PCI to memory to disk that I have trouble
with...

>	Your problems may be caused by:
>	1) Some latency delay below the minimum limit;

I have the latency set to max (64) on the bttv argument (from the logs it looks
like it defaulted to 32). I am going to look at the BIOS settings now to see if
something looks promising to tweak. Any hints?

I also have a kernel command line "pci=noacpi noapic acpi=ht" just to be
conservative. Do you know if any of those could be a problem? It does make for
many shared interrupts, see below.

>	2) Some tweak at the MB to increase speed;

I overclocked in my youth but am too old for it now :-)

>	3) some problem on PCI chipsets at both sides or at mainboard;

Could be. I'll run some disk tests in the background during normal use. That
will test the disk controllers (and there are many of those, 4 ata drives disk
on mb, 2 sata on mb, 16 drives on pci using three controllers (2 promise and 1
3-ware)

One the thing about a "cat /dev/video > /dev/null" test is that it eliminates all
the disk pci controllers as a problem source. Or I could change my test to write to
a ramfs.

>	4) bad contact;

I'll try reseating them.

>	5) Some proprietary driver (like Nvidia ones);

No, I am happy with the supplied X11 nvidia driver so I am running untainted.

>if you just cat /dev/video > some place, you are transfering from TV
>card to memory then transfering from memory to disk. It is not the same
>and should work w/o troubles.

Sadly it does not. The cat test never failed but recording from the cameras
seems to cause trouble, the system is pretty rock solid if I don't touch the
capture card (which is an el-cheapo GranTec with one bt878 and 4 inputs).

>For you to check, you need to avoid these, and run bttv at overlay mode.
>Maybe you can use a live-cd and don't mount HD. Turn off all
>motherboards tweaks and use a vanilla kernel without any proprietary
>driver.

Using vanilla 13rc6 now.

Thanks for the response!
Andrew

cc lkml

--------------------------------------------------------------------------

I get these several times a minute when things are running:

Aug 11 06:16:39 cichlid kernel: bttv0: OCERR @ 37254000,bits: HSYNC OFLOW OCERR*

and less of these:

Aug 11 06:16:36 cichlid kernel: bttv0: OCERR @ 37254000,bits: HSYNC OFLOW FDSR OCERR*
Aug 11 06:18:48 cichlid kernel: bttv0: OCERR @ 37254000,bits: HSYNC OFLOW FBUS FDSR OCERR*
Aug 11 06:22:06 cichlid kernel: bttv0: OCERR @ 37254000,bits: VSYNC* HSYNC OFLOW FBUS FDSR OCERR*

--------------------------------------------------------------------------

           CPU0       
  0:    9577663          XT-PIC  timer
  1:      22385          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     898581          XT-PIC  ide4, ide5, Intel ICH5, ICE1712
  8:     730989          XT-PIC  rtc
  9:      34717          XT-PIC  ide2, ide3, uhci_hcd:usb3
 10:    3337177          XT-PIC  3w-xxxx, bttv0, bt878, ehci_hcd:usb1
 11:    8403411          XT-PIC  libata, ohci1394, uhci_hcd:usb2, uhci_hcd:usb4, uhci_hcd:usb5
 12:      66278          XT-PIC  i8042
 14:     120258          XT-PIC  ide0
 15:       3048          XT-PIC  ide1
NMI:          0 
ERR:          1

--------------------------------------------------------------------------

00:00.0 Host bridge: Intel Corp. 82875P/E7210 Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) SATA Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5500] (rev a1)
02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link)
02:04.0 Unknown mass storage controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
02:05.0 Unknown mass storage controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
02:06.0 RAID bus controller: 3ware Inc 3ware Inc 3ware 7xxx/8xxx-series PATA/SATA-RAID (rev 01)
02:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
02:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
02:09.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 [Envy24] PCI Multi-Channel I/O Controller (rev 02)

--------------------------------------------------------------------------

Aug 12 07:49:34 cichlid kernel: bttv0: Bt878 (rev 17) at 0000:02:07.0, irq: 10, latency: 32, mmio: 0xec000000
Aug 12 07:49:34 cichlid kernel: bttv0: using: GrandTec Multi Capture Card (Bt878) [card=77,insmod option]
Aug 12 07:49:34 cichlid kernel: bttv0: setting pci timer to 64
Aug 12 07:49:34 cichlid kernel: bttv0: using tuner=-1
Aug 12 07:49:34 cichlid kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found
Aug 12 07:49:36 cichlid kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Aug 12 07:49:37 cichlid kernel: bttv0: i2c: checking for TDA9887 @ 0x86... not found
Aug 12 07:49:37 cichlid kernel: bttv: Overlay support disabled.
Aug 12 07:49:37 cichlid kernel: bttv0: registered device video0
Aug 12 07:49:37 cichlid kernel: bttv0: registered device vbi0
Aug 12 07:49:37 cichlid kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Aug 12 07:49:37 cichlid kernel: bt878: AUDIO driver version 0.0.0 loaded


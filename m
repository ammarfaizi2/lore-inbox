Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267403AbTAMQVQ>; Mon, 13 Jan 2003 11:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbTAMQVQ>; Mon, 13 Jan 2003 11:21:16 -0500
Received: from [195.141.26.14] ([195.141.26.14]:55046 "EHLO mars.planet.ch")
	by vger.kernel.org with ESMTP id <S267403AbTAMQVN>;
	Mon, 13 Jan 2003 11:21:13 -0500
Message-ID: <3E22E978.3090503@pstaehli.ch>
Date: Mon, 13 Jan 2003 17:29:44 +0100
From: Patrik Staehli <lkml@pstaehli.ch>
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: usb-ohci mouse lockups on National Geode system
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We are experiencing usb mouse freezing with different 2.4.x kernels 
(tested: 2.4.1, 2.4.17 and 2.4.20). In 2.4.20 it's actually much more 
frequent than in the older ones.
The freezing lockups only happen when the ide disk is active and the 
mouse is being moved during that time.
If 2 usb mice are plugged in and I only use one, then only this one 
freezes and the other still works (until it freezes as well). Detaching 
and reattaching the mouse or switching from X to the console and back to 
X resolves the problem.
Looking at /proc/interrupts tells me that there are no more interrupts 
coming from the ohci-controller for the frozen mouse.
Further investigations (making procfs outputs from usb-ohci) have 
uncovered that the 'Skip' flag for the frozen usb mouse is set even 
though there are still transfer descriptors pending.

System information:
National Semiconductors GX1/CS5530 based industry PC board.
300 MHz CPU clock.
128 MByte SD-RAM
80 GByte Harddrive on IDE0 master.
Samsung CD-RW drive on IDE1 master.
Kernels 2.4.1, 2.4.17 and 2.4.20 compiled with gcc 2.95.3
binutils 2.10.91
USB mice of several manufacturers (Logitech and others)


 > lspci
00:00.0 Host bridge: Cyrix Corporation PCI Master
00:0e.0 PCI bridge: Texas Instruments: Unknown device ac23 (rev 01)
00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
00:0f.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
00:12.0 ISA bridge: Cyrix Corporation 5530 Legacy [Kahlua] (rev 30)
00:12.1 Bridge: Cyrix Corporation 5530 SMI [Kahlua]
00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua]
00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua]
00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua]
00:13.0 USB Controller: Compaq Computer Corporation USB Open Host 
Controller (rev 06)
01:02.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
(rev 02)
01:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)

 > cat /proc/interrupts
            CPU0
   0:      82698          XT-PIC  timer
   1:          6          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:      22219          XT-PIC  drec0
   8:          2          XT-PIC  rtc
   9:      39976          XT-PIC  eth0, bttv
  11:        654          XT-PIC  usb-ohci
  12:        778          XT-PIC  PS/2 Mouse
  14:       8044          XT-PIC  ide0
  15:          4          XT-PIC  ide1
NMI:          0
ERR:          0

 > cat /proc/bus/usb/devices
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 93/900 us (10%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=c7b8d000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c00c Rev= 6.20
S:  Manufacturer=Logitech
S:  Product=USB Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl= 10ms

 > hdparm -d /dev/hda
/dev/hda:
  using_dma    =  1 (on)

My guess would be that an SOF (start of frame) interrupt (1/ms) gets 
lost and thus the 'skip' bit of the usb mouse is not reset.

I already posted this problem to the USB users mailing list 4 weeks ago 
but no one seemed interested in it.

I would be very happy if someone could give me a hint on how I could 
solve this problem...
If you need additional information I'll be happy to provide it.

cheers
/Patrik


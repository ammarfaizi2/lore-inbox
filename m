Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292855AbSD1KNM>; Sun, 28 Apr 2002 06:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292857AbSD1KNL>; Sun, 28 Apr 2002 06:13:11 -0400
Received: from slarti.muc.de ([193.149.48.10]:58887 "HELO slarti.muc.de")
	by vger.kernel.org with SMTP id <S292855AbSD1KNK> convert rfc822-to-8bit;
	Sun, 28 Apr 2002 06:13:10 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Stephan Maciej <stephan@maciej.muc.de>
To: linux-kernel@vger.kernel.org
Subject: Sony Vaio Laptop problems
Date: Fri, 26 Apr 2002 17:28:39 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204261728.39745.stephan@maciej.muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel developers,

I do have two problems with running Linux on my Sony Vaio PCG-FX501 Laptop.

1.) When I do a reboot, the bootup logo (a nice animation from Sony :-) 
displays, and the HD light turns on and stays on forever. Approximately 30 
seconds later, the logo goes away, and I do see the Phoenix BIOS' startup 
screen, saying

ERROR
0211: Keyboard Error

I do have the option to use <F2> to enter Setup, but due to some strange 0211 
keyboard error it just won't work. The only proper way for restarting my 
machine is to power it off and turn it on again.

What can I do?

2.) The laptop seems to put itself to sleep when I don't do anything for a 
longer period of time. The display becomes black (the backlight is still on, 
though) and I can't do anything except powering off and on again to make the 
machine work again. No messages about anything interesting are in my syslog 
files after this has happened. The problem persists both with ACPI and APM.

The only thing that fixes this problem is loading or installing the sonypi 
driver into the kernel. It doesn't function as expected, but it solves at 
least *this* problem. (As documented in the driver, sonypi should be able to 
set/get the backlight intensity of the display, but that doesn't work. There 
are even more features that it has but that are non-operational on my 
system.)

This is all okay, especially as I can now leave my laptop alone for even more 
than 10 minutes or so without having the need to turn it off and on again 
afterwards. OTOH, with sonypi my via82cxxx_audio driver won't work. 

When compiled into kernel, I see the follwing message:

Via 686a audio driver 1.9.1
PCI: Assigned IRQ 5 for device 00:07.5
PCI: Unable to reserve I/O region #1:100@1000 for device 00:07.5
Trying to free nonexistent resource <00001000-000010ff>
Trying to free nonexistent resource <00001c54-00001c57>
Trying to free nonexistent resource <00001c50-00001c53>

PCI dev 00:07.5 is the AC97 sound controller (lspci output):

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 50)

In my /proc/ioports, I do see that the two devices have intersecting I/O 
ranges:

1000-10ff : VIA Technologies, Inc. AC97 Audio Controller
  1080-109f : Sony Programable I/O Device

I dunno much about kernel or PCI internals but I guess that this is the 
problem for the "Unable to reserve I/O region message - tell me if I am 
wrong. I also have found a pci_request_region() call inside the 
via82cxxx_audio driver but I don't know how to modify that call so it does 
only request the I/O regions that do not mix with sonypi's range - and of 
course, I don't know if this would be good, but as the two devices co-exist 
nicely and my sound is working as long as sonypi is neither modprobed nor 
compiled in, I suspect it to work as soon as I can pci_request_region() only 
those I/O portions that are still free. So if someone could tell me how to do 
this (just in case no one states "Will break your kernel forever" or "Won't 
even work after that") I'd try it on my machine. I could even try to create a 
patch from it (it would be my first patch to an already existing piece of 
software... :-) and post it here - I am very interested in doing some work to 
make Linux better for tomorrow.

So, just for completeness, here's my system configuration:

Mobile AMD Duron Processor, 1GHz
256MB RAM
IDE hard disk and CD/DVD ROM

sonypi driver startup message:

sonypi: Sony Programmable I/O Controller Driver v1.10.
sonypi: detected type2 model, camera = off, compat = off
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63

lscpi output:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 50)
00:07.6 Communication controller: VIA Technologies, Inc. AC97 Modem Controller 
(rev 30)
00:0a.0 CardBus bridge: Texas Instruments PCI1420
00:0a.1 CardBus bridge: Texas Instruments PCI1420
00:0e.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 
2x (rev 64)

Complete /proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-10ff : VIA Technologies, Inc. AC97 Audio Controller
  1080-109f : Sony Programable I/O Device
1400-14ff : VIA Technologies, Inc. AC97 Modem Controller
1800-18ff : Realtek Semiconductor Co., Ltd. RTL-8139
  1800-18ff : 8139too
1c00-1c1f : VIA Technologies, Inc. UHCI USB
1c20-1c3f : VIA Technologies, Inc. UHCI USB (#2)
1c40-1c4f : VIA Technologies, Inc. Bus Master IDE
  1c40-1c47 : ide0
  1c48-1c4f : ide1
1c50-1c53 : VIA Technologies, Inc. AC97 Audio Controller
1c54-1c57 : VIA Technologies, Inc. AC97 Audio Controller
6800-687f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
8100-810f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Rage Mobility P/M AGP 2x

/proc/iomem:

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0feeffff : System RAM
  00100000-002db2b7 : Kernel code
  002db2b8-0037ef57 : Kernel data
0fef0000-0fefefff : ACPI Tables
0feff000-0fefffff : ACPI Non-volatile Storage
0ff00000-0fffffff : System RAM
10000000-10000fff : Texas Instruments PCI1420
10001000-10001fff : Texas Instruments PCI1420 (#2)
e8000000-e8003fff : PCI device 104c:8020 (Texas Instruments)
e8004000-e80047ff : PCI device 104c:8020 (Texas Instruments)
e8004800-e80048ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e8004800-e80048ff : 8139too
e8100000-e9ffffff : PCI Bus #01
  e8100000-e8100fff : ATI Technologies Inc Rage Mobility P/M AGP 2x
  e9000000-e9ffffff : ATI Technologies Inc Rage Mobility P/M AGP 2x
    e9000000-e97effff : vesafb
f0000000-f7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
fffe0000-ffffffff : reserved

Please ask if you need any further information. Thank you for your work and 
for your work on Linux, it's great!

Stephan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282778AbRL2Ogm>; Sat, 29 Dec 2001 09:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282823AbRL2Ogd>; Sat, 29 Dec 2001 09:36:33 -0500
Received: from hermes.cicese.mx ([158.97.1.34]:43697 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id <S282778AbRL2OgZ>;
	Sat, 29 Dec 2001 09:36:25 -0500
Date: Sat, 29 Dec 2001 06:36:19 -0800
Message-Id: <200112291436.GAA20655@quantum.cicese.mx>
To: linux-kernel@vger.kernel.org
From: Serguei Miridonov <mirsev@cicese.mx>
Subject: Athlon instabilities and VIA. "PCI latency" patch for Linux (for KT266A chipset only)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry if this is a duplicate post. I've sent this message two times
before but it does not appear in the list, so...

Well, this is a known problem, and here is a possible solution...
At least, it works for me... Not completely, though. May be some more
clever hacker can suggest something better...

It seems that VIA motherboard chipsets have some flaws which may lead
to the system instabilities, filesystem corruptions and crashes.
Recently I've acquired new Soyo Dragon Plus motherboard with KT266A
chipset, Athlon XP 1800+ CPU and 512MB DDR RAM. While testing the
system I've found that it becomes unstable and even freezes under heavy
PCI load. Initially these problems were detected in Windows-98 and then
in Linux.

This is a brief report about the problem and possible solution...

Hardware
========

Motherboard:    SOYO SY-K7V Dragon Plus! with C-Media CMI8738 audio.
                http://www.soyo.com.tw/product/k7v-dragon-plus.htm
BIOS:           K7VXA-2BA1 11/13/2001-VT8366-8233-6A6LVS29C-00
CPU:            Athlon XP 1800+
RAM:            2x256MB DDR 2100 SDRAM CL2.5 (512MB total)

The system is not overclocked and RAM timing settings are
very conservative.

AGP slot: empty.

PCI slots:

    1. Creative DXR3 MPEG2 decoder card
    2. Pinnacle System DC10plus MJPEG video capture/playback card.
    3. Empty.
    4. Cougar Video Edition VGA adapter (nVidia TNT2 M64 with 32MB RAM).
    5. Empty.

Note that this system has a PCI graphics card instead of AGP one.

Problems
========

1. Windows98 (clean install, Soyo/VIA 4 in 1 drivers installed)

    a. DirectX based games using TNT2 3D acceleration crash completely.
       The system must be restarted by RESET button.
       
    b. Playing MP3 files while doing some other work sometimes crashes
       the system too.

2. Linux (kernel 2.4.16, K7 enabled, VIA chipset support compiled in)

    a. Playing back movies by mplayer (http://www.MPlayerHQ.hu/homepage/)
       on TV using DXR3 card crashes the system.
       
    b. Playing back video using DC10plus card and Linux driver
       (http://www.cicese.mx/~mirsev/Linux/DC10plus/) crashes the system.
    
    c. Building the kernel with 'make -j6 bzImage' sometimes corrupts 
       the filesystem.

Temporary solution
==================

Windows:

Using "PCI latency" patch (George E. Breese) from 
http://www.networking.tzo.com/net/software/, Windows98 problems have
been solved so far.

Linux:

Since source code for "PCI latency" patch is closed, I started to look
for similar solution for Linux. Unfortunately, I could find nothing...
PCI and Athlon quirks in the kernel source did not provide acceptable
solution for KT266A chipset.

To write my own code, I tested KT266A chip configuration before and
after applying George's "PCI latency" patch in Windows98 using WPCREDIT
program from H.Oda! (http://www.h-oda.com/). Finally I wrote a very
dirty hack which fixes some issues in Linux too. Now I can playback
video using both DXR3 and DC10plus card but in some conditions the
system still freezes. It happens when video is played back by DC10plus
in xawtv window. This makes me to think that problem is caused by
multiple PCI bus master transfers.

This temporary solution is provided as Linux kernel module which
changes KT266A chip configuration when loaded by 'insmod vialat.o'
command and restores it back when is unloaded with 'rmmod vialat'. I
have put 'insmod vialat.o' command to my /etc/rc.d/rc.sysinit script to
make configuration changes before mounting filesystems in 'rw' mode.

WARNING: This software is provided 'as is' without any warranty. Use it
on your own risk. If you agree and accept any possible damage resulted
from using this software, download the source code from
http://www.cicese.mx/~mirsev/Linux/VIA/vialatency.tar.gz

The source code vialat.c is free and can be distributed or included in
any other program under terms of GNU General Public License, version 2.
You can also modify the code to try it for other VIA chipset. Please,
let me know if it helps.

The distribution also includes KT266A registers descriptions from H.Oda!
and configuration dumps. These files are _not_ covered by GNU License.

To install the module, uncompress the distribution file and go to
'vialatency' directory. Type 'make' to build the module (you must have
your kernel source installed and configured properly). Then type
'insmod vialat.o' and check if your former hardware problems are
solved.

Additional information: http://www.tecchannel.de/hardware/817/index.html

Copyright (c) 2001 Serguei Miridonov <mirsev@cicese.mx>



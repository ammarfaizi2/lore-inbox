Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVAWBuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVAWBuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 20:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVAWBuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 20:50:21 -0500
Received: from mail.dif.dk ([193.138.115.101]:46791 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261178AbVAWBuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 20:50:02 -0500
Date: Sun, 23 Jan 2005 02:40:23 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: Odd little line-break problem (on fb console) during boot with recent
 kernels.
Message-ID: <Pine.LNX.4.61.0501230222560.2748@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using a vesafb framebuffer console, and recently I've noticed an odd 
little issue. During boot recent kernels (at least 2.6.11-rc1-bk4 and 
later - I don't have earlier kernels to test atm) will break the line

vesafb: framebuffer at 0xf0000000, mapped to 0xe0880000, using 937k, total 65536k

into two lines like this

vesafb: framebuffer at 0xf0000000, mapped to 0xe0880000, using 937k, total 6553
6k

the last two chars "6k" are put on a line by themselves. This is odd since 
there are both shorter and longer lines printed to the screen during boot, 
so it's not a "wrap at right edge of screen" thing. It's also odd since 
the code that prints this text is 

from drivers/video/vesafb.c :
        printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, "
               "using %dk, total %dk\n",

That simple printk should result in a nice single line of output.


If I take a look at the boot messages with dmesg after boot, then the 
message is printed as a single line as expected.

I see nothing in the source for printk, vprintk or vscnprintf that would 
cause the line to be split. 
No other messages during boot seem to get split in odd places, this is the 
only one.

So I'm wondering, what is causing this odd behaviour?


Some info that might be relevant:
-----

My graphics card is a ASUS V8200 Deluxe (nvidia geforce3) :
01:05.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3] (rev a3) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc. AGP-V8200 DDR
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 4
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Region 2: Memory at ef800000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at ef7f0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


My lilo version is 22.5.9.

The video mode I use is 1024x768x64k (vga=791 in lilo.conf - just for 
kicks I tried booting with vga=771, but that doesn't change anything).

My distribution is Slackware Linux 10.0 (upgraded to -current as of today).

Output from scripts/ver_linux is :
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dragon 2.6.11-rc2 #1 Sat Jan 22 23:04:44 CET 2005 i686 unknown 
unknown GNU/Linux

Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.35
jfsutils               1.1.6
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.6.13
pcmcia-cs              3.2.8
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.7
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Linux C++ Library      6.0.2
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   050
Modules Loaded         snd_pcm_oss snd_mixer_oss via_rhine snd_emu10k1 
snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc 
snd_util_mem snd_hwdep evdev agpgart


If you would like me to test older kernel versions to determine when tis 
began to happen, then just let me know. If there's any other piece of info 
you need, ask and I'll provide it.


-- 
Jesper Juhl



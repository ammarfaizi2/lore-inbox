Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272821AbTHKSFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273184AbTHKSC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:02:57 -0400
Received: from moscou.magic.fr ([62.210.158.41]:42737 "EHLO moscou.magic.fr")
	by vger.kernel.org with ESMTP id S272983AbTHKR7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:59:40 -0400
Subject: Re: 2.6.0-test2 does not boot with matroxfb
From: Jocelyn Mayer <l_indien@magic.fr>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: davej@codemonkey.org.uk
In-Reply-To: <1060429216.29152.61.camel@jma1.dev.netgem.com>
References: <1060429216.29152.61.camel@jma1.dev.netgem.com>
Content-Type: text/plain; charset=iso-8859-9
Organization: 
Message-Id: <1060624865.29139.137.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Aug 2003 20:01:06 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-09 at 13:40, Jocelyn Mayer wrote:
> > On  8 Aug 03 at 17:45, Juergen Rose wrote:
> > ý I tried on my PC with a Matrox-G450 several kernel and boot options.
> > ý Every time when the console should work with matrox framebuffer,
> > linux
> > ý was crashed. With 2.6.0-test2 and 2.6.0-test2-bk7 I had the
> > following
> > ý warning performing ''make modules_install''
> > ý WARNING:
> > ý
> > /lib/modules/2.6.0-test2[-bk7]/kernel/drivers/video/matrox/matroxfb_crtc2.ko
> > ý needs unknown symbol matroxfb_enable_irq This WARNING disapears for
> > 
> > I'm not able to get through Linus's mail filters for past three weeks.
> 
> I can boot a Athlon based PC with a Matrox-G450. It runs well.
> The frame buffer is broken, and so is X and overlay buffer,
> but it doesn't crash at all.
> I also booted another kernel on the VGA console.
> The console is OK, X and overlay buffer are still broken,
> but the machine euns well.
> I have two 2.6.0-test2, one with the matroxfb,
> the other one just with the VGA console.
> 
I played with my PC this week-end.
First I recompiled XFree up to version 4.3.0. It fixed nothing.
I found out that the agpgart/dri drivers failed to init:

Clock  Driver v1.11 Linux agpgart interface v0.100 (c) Dave Jones
[drm:drm_init] *ERROR*  Cannot  initialize  the  agpgart  module.
Uninitialised  timer!   This is just a warning.  Your computer is
OK function=0x00000000, data=0x0 Call Trace:
 [<c0121a80>] check_timer_failed+0x40/0x50
 [<c0121da5>] del_timer+0x15/0x80
 [<c020e318>] mga_takedown+0x68/0x340
 [<c0211d4d>] mga_stub_unregister+0x2d/0x39
 [<c03d8ca7>] drm_init+0xd7/0x260
 [<c03ca6dd>] do_initcalls+0x3d/0x90
 [<c03ca749>] do_basic_setup+0x19/0x20
 [<c010508f>] init+0x2f/0x180
 [<c0105060>] init+0x0/0x180
 [<c0106f9d>] kernel_thread_helper+0x5/0x18
from dmesg

So, I reccompiled my kernels without agpgart.
Then, I noticed that X was ran in 32 bits mode
but that xwininfo said it was in 8 bits mode.
I relaunched X in 16 bits modes and it runs fine, now,
including overlay video.
This is quite strange, because it used to run OK on 2.4 kernels
and I got no idea of the source of the problem.
I now run a VGA console kernel without agpgart with a 16bps X.

So, there seems to be two issues:
- broken matrox fb: I lose the synchro when switching from X to fb.
  fbset configuration is lost when switching consoles.
- X problems maybe related to agpgart bad initialisation for
  some modes.

Please tell me if I should do more tests to find out where the problems
come from.

Regards.

Here's my /proc/pci output, if this can help to find out issues for
agpgart sutffs:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devic AMD-760 [IGD4-1P] Sy (rev 19).
      Master Capable.  Latency=32.  
      Prefetchable 32 bit memory at 0xc0000000 [0xcfffffff].
      Prefetchable 32 bit memory at 0xd6002000 [0xd6002fff].
      I/O at 0xc000 [0xc003].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devic AMD-760 [IGD4-1P] AG (rev 0).
      Master Capable.  Latency=32.  Min Gnt=14.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, In VT82C686 [Apollo Sup (rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, In VT82C586/B/686A/B PI (rev 6).
      Master Capable.  Latency=32.  
      I/O at 0xc400 [0xc40f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, In USB (rev 26).
      IRQ 12.
      Master Capable.  Latency=32.  
      I/O at 0xc800 [0xc81f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, In USB (#2) (rev 26).
      IRQ 12.
      Master Capable.  Latency=32.  
      I/O at 0xcc00 [0xcc1f].
  Bus  0, device   7, function  4:
    SMBus: VIA Technologies, In VT82C686 [Apollo Sup (rev 64).
      IRQ 9.
  Bus  0, device   8, function  0:
    Ethernet controller: VIA Technologies, In VT86C100A [Rhine] (rev 6).
      IRQ 12.
      Master Capable.  Latency=32.  
      I/O at 0xd000 [0xd07f].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd600007f].
  Bus  0, device   9, function  0:
    Ethernet controller: Realtek Semiconducto RTL-8139/8139C/8139C (rev
16).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xd400 [0xd4ff].
      Non-prefetchable 32 bit memory at 0xd6001000 [0xd60010ff].
  Bus  0, device  11, function  0:
    Multimedia video controller: Brooktree Corporatio Bt878 Video
Capture (rev 17).
      IRQ 12.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xd6003000 [0xd6003fff].
  Bus  0, device  11, function  1:
    Multimedia controller: Brooktree Corporatio Bt878 Audio Capture (rev
17).
      IRQ 12.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xd6004000 [0xd6004fff].
  Bus  0, device  13, function  0:
    FireWire (IEEE 1394): VIA Technologies, In IEEE 1394 Host Contr (rev
70).
      IRQ 11.
      Master Capable.  Latency=32.  Max Lat=32.
      Non-prefetchable 32 bit memory at 0xd6005000 [0xd60057ff].
      I/O at 0xd800 [0xd87f].
  Bus  0, device  15, function  0:
    SCSI storage controller: Tekram Technology Co TRM-S1040 (rev 1).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0xdc00 [0xdcff].
      Non-prefetchable 32 bit memory at 0xd6006000 [0xd6006fff].
  Bus  0, device  17, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 7).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xe000 [0xe01f].
  Bus  0, device  17, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game P (rev 7).
      Master Capable.  Latency=32.  
      I/O at 0xe400 [0xe407].
  Bus  1, device   5, function  0:
    VGA compatible controller: Matrox Graphics, Inc MGA G400 AGP (rev
130).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xd0000000 [0xd1ffffff].
      Non-prefetchable 32 bit memory at 0xd2000000 [0xd2003fff].
      Non-prefetchable 32 bit memory at 0xd3000000 [0xd37fffff].



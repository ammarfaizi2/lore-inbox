Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268841AbTCCWuZ>; Mon, 3 Mar 2003 17:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268842AbTCCWuZ>; Mon, 3 Mar 2003 17:50:25 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:26524 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S268841AbTCCWuX>; Mon, 3 Mar 2003 17:50:23 -0500
Date: Mon, 3 Mar 2003 18:00:50 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
Subject: Errors in i810 DRM driver, 2.4.21-pre5-ac1
Message-ID: <Pine.LNX.4.50.0303031730410.20127-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

When I boot 2.4.21-pre5-ac1 on a system with an i810 card and i810 DRM
supported in the kernel, following lines are printed continuously to the
kernel log:

PCI: Found IRQ 12 for device 00:01.0
[drm:i810_wait_ring] *ERROR* space: 65520 wanted 65528
[drm:i810_wait_ring] *ERROR* lockup
mtrr: base(0xd0000000) is not aligned on a size(0x180000) boundary

The same messages were observed with 2.4.21-pre4-ac7.  I haven't tried
other -ac kernels on that machine.

The system feels significantly slower.  I have X and gdm running, the
messages are printed on the serial console.  The workaround is to stop X
by "init 3" - the messages stop and the system becomes more responsive.

The system is Red Hat 8.0, kernel 2.4.21-pre5-ac1, XFree86-4.2.0-72,
gdm-2.4.0.7-13 (two later are native from Red Hat).  No modules are
loaded.

# /sbin/lspci
00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory
Controller Hub] (rev 03)
00:01.0 VGA compatible controller: Intel Corp. 82810E DC-133 CGC [Chipset
Graphics Controller] (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
01:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
01:00.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
01:01.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
01:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)

There is an interesting message when compiling i810_dma.c (most likely
irrelevant, but I'll report it anyway):

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include
-DKBUILD_BASENAME=i810_dma  -c -o i810_dma.o i810_dma.c
In file included from drmP.h:75,
                 from i810_dma.c:35:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to
read up on list_entry

This patch fixes the loop, but it's really just a random fix without
understanding anything:

===========================
--- linux.orig/drivers/char/drm/i810_dma.c
+++ linux/drivers/char/drm/i810_dma.c
@@ -309,7 +309,7 @@ static int i810_wait_ring(drm_device_t *
 	end = jiffies + (HZ*3);
    	while (ring->space < n) {
 	   	ring->head = I810_READ(LP_RING + RING_HEAD) & HEAD_ADDR;
-	   	ring->space = ring->head - (ring->tail+8);
+	   	ring->space = ring->head - ring->tail;
 		if (ring->space < 0) ring->space += ring->Size;

 		if (ring->head != last_head)
===========================

Still, the following messages are printed 4 times on startup:

mtrr: base(0xd0000000) is not aligned on a size(0x180000) boundary
PCI: Found IRQ 12 for device 00:01.0

-- 
Regards,
Pavel Roskin

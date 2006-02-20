Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWBTAva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWBTAva (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWBTAva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:51:30 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:30255 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751164AbWBTAva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:51:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=KmLgAFBrPaapcFePnW9r1RB04tyVG610jK3LU8Xkh5lRr1Y0YVcvbtAezkaZSHtDIcI6oiuvl9YD3+dCr7AGJh4grx3vTPzUi4w6glO8I797SHTjnd+o+ctSU0xGay4Jz66NSvTfO0a6UXsBcfpv1G6yN3B4OP83zscaKscaZ+w=
Message-ID: <43F91283.4050307@gmail.com>
Date: Mon, 20 Feb 2006 08:51:15 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
CC: bjk@luxsci.net
Subject: Bugzilla: PCI resource address mismatch
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Kibbey reported that vesafb has stopped working for him for kernels newer than
2.6.12. His display is completely blanked. After a long debugging session, we noted
that the address of resource 0 of his VGA controller as reported by lspci does not
match what is reported by the BIOS.

More details:

In the working kernel (2.6.12.x), vesafb correctly ioremap's the framebuffer memory
located at 0xff000000.  lspci reports the same thing:

PCI: Using IRQ router SIS [1039/0008] at 0000:00:01.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:02.0
...
vesafb: framebuffer at 0xff000000, mapped to 0xc4080000, using 1875k, total 8192k
vesafb: mode is 800x600x16, linelength=1600, pages=7
vesafb: protected mode interface info at c7bd:0000
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 530/620
PCI/AGP VGA Display Adapter (rev a2) (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS] SiS530,620 GUI Accelerator+3D
	Flags: bus master, 66MHz, medium devsel, latency 32
	Memory at ff000000 (32-bit, prefetchable) [size=8M]
	Memory at e7ef0000 (32-bit, non-prefetchable) [size=64K]
	I/O ports at cc00 [size=128]
	Capabilities: <available only to root>

In the non-working kernel, his dmesg has this:

PCI: Using IRQ router SIS [1039/0008] at 0000:00:01.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:02.0
PCI: Cannot allocate resource region 0 of device 0000:01:00.0
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
...
vesafb: framebuffer at 0xff000000, mapped to 0xc4080000, using 1875k, total
8192k
vesafb: mode is 800x600x16, linelength=1600, pages=7
vesafb: protected mode interface info at c7bd:0000
vesafb: pmi: set display start = c00c7c25, set palette = c00c7c99
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1200
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device

Note the message "Cannot allocate resource region 0 of device 0000:01:00.0"
This is the framebuffer memory of his VGA controller.

His lspci reports:

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
530/620 PCI/AGP VGA Display Adapter (rev a2) (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS] SiS530,620 GUI Accelerator+3D
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min)
	Region 0: Memory at 10000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at e7ef0000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at cc00 [size=128]
	Capabilities: <available only to root>

In the non-working kernel, the addresses do not match:

"vesafb: framebuffer at 0xff000000"

 vs

"Region 0: Memory at 10000000 (32-bit, prefetchable) [size=8M]"

He also tried hard-coding the address to 0x10000000 in vesafb.c, but he still
is not getting any display.

Any ideas?

Tony

PS: Please see http://bugzilla.kernel.org/show_bug.cgi?id=5769 for more details.


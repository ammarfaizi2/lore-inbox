Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268866AbRHBJYq>; Thu, 2 Aug 2001 05:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268864AbRHBJYg>; Thu, 2 Aug 2001 05:24:36 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:5504 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S268862AbRHBJY2>; Thu, 2 Aug 2001 05:24:28 -0400
Message-ID: <3B691B85.368D1BD0@randomlogic.com>
Date: Thu, 02 Aug 2001 02:21:09 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>
Subject: Dual Athlon, AGP, and PCI
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the latest on my endeavors to get everything working full speed
on my Tyan K7 Thunder system. First, a little background on the
applicable hardware and software:

Dual Athlon 1.4GHz CPUs (*NOT* MP chips)
AMD-760 MP chipset, latest revision (as per AMD Rev. documents D/L last
week)
	- AMD-762 Northbridge Rev. 11
	- AMD-766 Southbridge Rev. 01
Mainboard Adaptec 7899P Dual Channel SCSI 160
256MB ECC Reg. DDR
Asus V8200 Deluxe Geforce 3
IBM ATA100 30GB drive
IBM Ultra 160 36GB drive

I've been dealing with both 2.4.7 and 2.4.2 kernels, but I have mainly
been using 2.4.2 because I started with that before I realized 2.4.7 was
available. I also have the NVidia driver, version 1.0-1251.

I'm focusing mainly on AGP right now (I spent some good $$ on this
GeForce 3 card and I want it running full speed :) so this is where I've
made the most progress. I've modified Jeff's agpgart code to recognize
the AMD-762 chip so the module loads without having to use "insmod
agpgart agp_try_unsupported=1". By default the 762 comes up with 4x
enabled, SBA and FW off and there are no setting in the system BIOS for
AGP other than Aperture Memory size (which I set to 64MB). Re-compiling
the NVidia driver after compiling the SMP kernel enables the Asus card
to operate such:

[root@keroon /root]# cat /proc/nv/card0
----- Driver Info ----- 
NVRM Version: 1.0-1251
------ Card Info ------
Model:        NVIDIA card
IRQ:          17
------ AGP Info -------
AGP status:   Enabled
AGP Driver:   AGPGART
Bridge:       Generic AMD
SBA:          Supported [disabled]
FW:           Supported [disabled]
Rates:        4x 2x 1x  [4x]
Registers:    0x0f000217:0x00000104
[root@keroon /root]# 

So, AGP 4x is enabled and things work OK, but the system still locks
occasionally while playing Quake 3.

The NVidia driver, as advertised, will use its own AGP driver, Jeff's
agpgart driver, or fall back to PCI mode. According to NVidia, you can
enable the different modes by setting NVagp in XF86Config-4 to a number.
I set it to use agpgart. Here's the rub.

Using the same software I used to generate the Kernel source
documentation on my web server, I took a look at the NVidia driver. I
found a lot of useful DEBUG code and I found some conditional code that
allows the NVidia driver to use agpgart. Neither code section was being
compiled either by the Makefile or the RPM .spec file. So, I modified
the Makefile for NVdriver (-DDEBUG and -DAGPGART), compiled and
installed NVdriver, and restarted X. Black screen and Ctrl+Alt+Del.

Examining /var/log/messages I found the following:

1. Enabling the agpgart support code results in the following errors:

Aug  2 00:53:44 keroon kernel: NVRM: AGPGART: AMD Irongate chipset
Aug  2 00:53:44 keroon kernel: NVRM: AGPGART: unable to set MTRR
write-combining
Aug  2 00:53:44 keroon kernel: NVRM: AGPGART: aperture: 64M @ 0xf4000000
Aug  2 00:53:44 keroon kernel: NVRM: AGPGART: aperture mapped from
0xf4000000 to 0xd59d9000
Aug  2 00:53:44 keroon kernel: NVRM: AGPGART: mode 4x
Aug  2 00:53:44 keroon kernel: NV0: ioctl(50, 0xbffffa38)
Aug  2 00:53:44 keroon kernel: NV0: ioctl(39, 0xbffff9f0)
Aug  2 00:53:44 keroon kernel: NVRM: AGPGART: allocated 16 pages
Aug  2 00:53:44 keroon kernel: NV0: mmap([0x48604000-0x48614000]
off=0x80000000
Aug  2 00:53:44 keroon kernel: NVctl: ioctl(36, 0xbffff9f8)
Aug  2 00:53:44 keroon kernel: NV0: ioctl(38, 0xbffff9ec)
Aug  2 00:53:44 keroon kernel: NV0: mmap([0x48614000-0x48624000]
off=0x800000
Aug  2 00:53:44 keroon kernel: NVctl: ioctl(43, 0xbffffa14)
Aug  2 00:53:44 keroon kernel: NVctl: ioctl(36, 0xbffffa24)
Aug  2 00:53:44 keroon kernel: NV0: could not find map for vm 0x40604000
Aug  2 00:53:44 keroon kernel: NV: vtop: 0x40604000 to p 0xf8000000
Aug  2 00:53:44 keroon kernel: NV0: ioctl(39, 0xbffffa1c)
Aug  2 00:53:44 keroon kernel: NV0: mmap([0x4002c000-0x4002d000]
off=0x40000000
Aug  2 00:53:44 keroon kernel: NVctl: ioctl(36, 0xbffffa24)
Aug  2 00:53:44 keroon kernel: NV0: could not find map for vm 0x4002c000



Note that early on in the kernel boot process, mtrr reports:

. . .
CPU1<T0:2654864,T1:884944,D:4,S:884958,C:2654875>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
. . .

and later:

mtrr: type mismatch for f8000000,4000000 old: write-back new:
write-combining



2. NVidia's own AGP support code uses the kernel PCI functions. Because
the kernel PCI code does not recognize the AMD-762 or AMD-766 chip IDs,
a probe for an AGP device fails and generic support is assumed. AGP
still works because NVDriver reads the capabilities registers which
report AGP 4x is supported and enabled, but the extra features (FW and
SBA) can not be enabled.



As for IDE, I can make it work in PIO Mode 4, Ultra DMA Mode 2 (66MHz),
32-bit transfers, and enable write caching (pushing it to 25MB/sec)
using hdparm, but again the IDE (AMD-766) is not recognised and the IDE
driver defaults to generic IDE ot boot (16-bit, no DMA, no cache,
2.5MB/sec).

The SCSI controllers work like a champ as do the onboard NICs (3c980
TX).

PGA


-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com

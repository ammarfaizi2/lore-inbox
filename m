Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTFKV4Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTFKV4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:56:16 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264498AbTFKV4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:56:05 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- IDE Problem?
From: Andy Pfiffer <andyp@osdl.org>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1052513725.15923.45.camel@andyp.pdx.osdl.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1055369326.1158.252.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 15:08:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 13:55, Andy Pfiffer wrote:
> On Fri, 2003-05-09 at 13:04, Christophe Saout wrote:
> > Am Fre, 2003-05-09 um 21.04 schrieb Andy Pfiffer:
> > 
> > > [...]
> > >  I had an unrelated
> > > delay in posting this due to some strange behavior of late with LILO and
> > > my ext3-mounted /boot partition (/sbin/lilo would say that it updated,
> > > but a subsequent reboot would not include my new kernel)
> > 
> > So I'm not the only one having this problem... I think I first saw this
> > with 2.5.68 but I'm not sure.
> 
> Well, that makes two of us for sure.
> 
> > 
> > My boot partition is a small ext3 partition on a lvm2 volume accessed
> > over device-mapper (I've written a lilo patch for that, but the patch is
> > working and) but I don't think that has something to do with the
> > problem.
> > 
> > When syncing, unmounting and waiting some time after running lilo, the
> > changes sometimes seem correctly written to disk, I don't know when
> > exactly.
> 
> My /boot is an ext3 partition on an IDE disk.  My symptoms and your
> symptoms match -- wait awhile, and it works okay.  If you don't wait
> "long enough" the changes made in /etc/lilo.conf are not reflected in
> the after running /sbin/lilo and rebooting normally.
> 
> I have been unable to reproduce this on a uniproc system with SCSI
> disks.
> 
> 2.5.67 seems to work in this regard as expected.
> 
> > Could it be that the location of /boot/map is not written to the
> > partition sector of /dev/hda? Or not flushed correctly or something?
> > 
> > After reboot the old kernel came up again (though it was moved to
> > vmlinuz.old).
> 
> I don't know -- I haven't isolated it yet.
> 
> Anyone else?

I have taken another look at this, and can confirm the following:

1. 2.5.67 works as expected.
2. 2.5.68, 2.5.69, and 2.5.70 do not.
3. ext2 vs. ext3 for /boot: no effect (ie, .68, .69, .70 demonstrate the
problem independent of the filesystem used for /boot).

Relative to a 2.5.68 pure BK tree, the deltas from 2.5.67 to 2.5.68 are:
1.971.76.10	/* 2.5.67 */
1.1124		/* 2.5.68 */

The patch exported by BK between these 2 revs is 297K lines ( a sizeable
haystack ).  Any ideas about where I should dig for my needle first
would be welcomed...


Gory details about my hardware & software follow...

% lilo -v
LILO version 22.1, Copyright (C) 1992-1998 Werner Almesberger
Development beyond version 21 Copyright (C) 1999-2001 John Coffman
Released 31-Oct-2001 and compiled at 20:50:13 on Mar 25 2002.
MAX_IMAGES = 27


CPUs:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Xeon(TM) CPU 1.70GHz
stepping	: 2
cpu MHz		: 1685.926
cache size	: 256 KB
physical id	: 0
siblings	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3317.76

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 0
model name	: Intel(R) Xeon(TM) CPU 1700MHz
stepping	: 10
cpu MHz		: 1685.926
cache size	: 256 KB
physical id	: 0
siblings	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3366.91


Two IDE hard drives (I haven't cracked the case to identify the
manufacturer):

/dev/hda:
 HDIO_GETGEO_BIG failed: Inappropriate ioctl for device

 Model=CI530L04VARE700-                        , FwRev=REO44AA5,
SerialNo=        S PXXTYH2351
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=78156288
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4
ATA-5

/dev/hdb:
 HDIO_GETGEO_BIG failed: Inappropriate ioctl for device

 Model=CI530L02VARE700-                        , FwRev=REO24AA5,
SerialNo=        S PVVTFT0B17
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=39876480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4
ATA-5

The PCI hardware on this system:
00:00.0 Host bridge: Intel Corp. 82850 860 (Wombat) Chipset Host Bridge
(MCH) (rev 04)
	Subsystem: IBM: Unknown device 2531
	Flags: bus master, fast devsel, latency 0
	Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82850/82860 850/860 (Tehama/Wombat)
Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: f6000000-f8ffffff
	Prefetchable memory behind bridge: f4000000-f5ffffff

00:02.0 PCI bridge: Intel Corp. 82860 860 (Wombat) Chipset PCI Bridge
(rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
	Memory behind bridge: fb000000-fb0fffff

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 04) (prog-if
00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: f9000000-faffffff

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04) (prog-if 80
[Master])
	Subsystem: IBM: Unknown device 2442
	Flags: bus master, medium devsel, latency 0
	I/O ports at f000 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 04)
(prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 2442
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at d000 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
	Subsystem: IBM: Unknown device 2442
	Flags: medium devsel, IRQ 17
	I/O ports at 5000 [size=16]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio
(rev 04)
	Subsystem: IBM: Unknown device 0224
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at d800 [size=256]
	I/O ports at dc00 [size=64]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 85) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G450 Dual Head
	Flags: bus master, medium devsel, latency 64, IRQ 22
	Memory at f4000000 (32-bit, prefetchable) [size=32M]
	Memory at f6000000 (32-bit, non-prefetchable) [size=16K]
	Memory at f7000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0

02:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge (rev 03)
(prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=32
	Memory behind bridge: fb000000-fb0fffff

03:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable
Interrupt Controller (rev 01) (prog-if 20 [IO(X)-APIC])
	Subsystem: Intel Corp. 82806AA PCI64 Hub Advanced Programmable
Interrupt Controller
	Flags: bus master, fast devsel, latency 0
	Memory at fb000000 (32-bit, non-prefetchable) [size=4K]

04:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 0c)
	Subsystem: IBM: Unknown device 0207
	Flags: bus master, medium devsel, latency 32, IRQ 16
	Memory at fa020000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at c000 [size=64]
	Memory at fa000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2






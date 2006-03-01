Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWCAXXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWCAXXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWCAXXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:23:54 -0500
Received: from mail.goelsen.net ([195.202.170.130]:49570 "EHLO
	power2u.goelsen.net") by vger.kernel.org with ESMTP
	id S1751118AbWCAXXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:23:53 -0500
From: Michael Monnerie <m.monnerie@zmi.at>
Organization: it-management http://zmi.at
To: linux-kernel@vger.kernel.org
Subject: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Thu, 2 Mar 2006 00:23:21 +0100
User-Agent: KMail/1.9.1
Cc: suse-linux-e@suse.com, ak@suse.de
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4886431.WYnIUi4orC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603020023.21916@zmi.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4886431.WYnIUi4orC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello, I use SUSE 10.0 with all updates and actual kernel 2.6.13-15.8 as=20
provided from SUSE (just self compiled to optimize for Athlon64, SMP,=20
and HZ=3D100), with an Asus A8N-E motherboard, and an Athlon64x2 CPU.=20
This host is used with VMware GSX server running 6 Linux client and one=20
Windows client host. There's a SW-RAID1 using 2 SATA HDs.

When we wanted to install a new client, and inserted a DVD into the PC,=20
it behaved like on drugs, showing the following output=20
in /var/log/warn:

=46eb 28 15:19:30 baum kernel: rtc: lost some interrupts at 256Hz.
=46eb 28 15:19:47 baum kernel: rtc: lost some interrupts at 256Hz.
=46eb 28 15:20:26 baum kernel: rtc: lost some interrupts at 256Hz.
=46eb 28 15:20:45 baum kernel: PCI-DMA: Out of IOMMU space for 225280=20
bytes at device 0000:00:08.0
=46eb 28 15:20:45 baum kernel: end_request: I/O error, dev sda, sector=20
12248446
=46eb 28 15:20:45 baum kernel:    Operation continuing on 1 devices
=46eb 28 15:20:45 baum kernel: PCI-DMA: Out of IOMMU space for 221184=20
bytes at device 0000:00:08.0
=46eb 28 15:20:45 baum kernel: end_request: I/O error, dev sdb, sector=20
12248454
=46eb 28 15:20:45 baum kernel: printk: 118 messages suppressed.
=46eb 28 15:20:45 baum kernel: Buffer I/O error on device md0, logical=20
block 1004928
=46eb 28 15:20:45 baum kernel: lost page write due to I/O error on md0
=46eb 28 15:20:45 baum kernel: Buffer I/O error on device md0, logical=20
block 1004929
=46eb 28 15:20:45 baum kernel: lost page write due to I/O error on md0

After that, the SW RAID stopped it's work, some VMware clients crashed=20
and so on. Not a good situation.

I found this in dmesg:
CPU 0: aperture @ b6c6000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture

The problem is, it's an ASUS A8N-E, and doesn't have AGP but PCI-Express=20
=2D and therefore no more BIOS setting for the AGP aperture size.

The kernel set that IOMMU to 64MB, but it still seems to small. There's=20
a kernel boot option "iommu=3D...", but using "iommu=3Doff" lead to a=20
frozen system during boot, and "iommu=3D128M" didn't boot at all.

I found a message from Andi Kleen of SUSE suggesting using=20
"iommu=3Dmemaper=3D3", and that helped - at least until now. I just wanted=
=20
to say thank you for that, and document this fact here for others=20
possibly running into the same problem.

Output from the kernel source script "sh scripts/ver_linux":

Linux baum 2.6.13-15.8-ZMI #1 SMP Tue Feb 28 16:07:49 CET 2006 x86_64=20
x86_64 x86_64 GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.91.0.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.2-pre8
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.6.36
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      6.0.6
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   068
Modules Loaded         vmnet vmmon joydev af_packet iptable_filter=20
ip_tables button battery ac ipv6 ide_cd cdrom sundance mii shpchp=20
pci_hotplug generic ehci_hcd i2c_nforce2 ohci_hcd usbcore i2c_core=20
dm_mod reiserfs raid1 fan thermal processor sg sata_nv libata amd74xx=20
sd_mod scsi_mod ide_disk ide_core
=2D-=20
// Michael Monnerie, Ing.BSc  ---   it-management Michael Monnerie
// http://zmi.at           Tel: 0660/4156531          Linux 2.6.11
// PGP Key:   "lynx -source http://zmi.at/zmi2.asc | gpg --import"
// Fingerprint: EB93 ED8A 1DCD BB6C F952  F7F4 3911 B933 7054 5879
// Keyserver: www.keyserver.net                 Key-ID: 0x70545879

--nextPart4886431.WYnIUi4orC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEBizpORG5M3BUWHkRAnrlAKCXIleFSKrO8Gkm86io+Siy+CEM0gCghy0H
OgpDwBgMMFTm5D+k9SOe0lk=
=fRIa
-----END PGP SIGNATURE-----

--nextPart4886431.WYnIUi4orC--

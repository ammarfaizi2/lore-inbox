Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132000AbRC2Fav>; Thu, 29 Mar 2001 00:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132579AbRC2Fal>; Thu, 29 Mar 2001 00:30:41 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:26757 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S132000AbRC2Fad>; Thu, 29 Mar 2001 00:30:33 -0500
Date: Wed, 28 Mar 2001 21:29:46 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.3-p8 pci_fixup_vt8363 + ASUS A7V "Optimal" = IDE disk corruption
Message-ID: <Pine.LNX.4.30.0103281942010.12066-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm running kernel 2.4.3-pre8 on an ASUS A7V (BIOS 1007) motherboard and
recently noticed that it sometimes corrupts my hard disk, an IBM 75GXP on
the onboard PDC20265 IDE controller.  The corruption is detectable with a
simple 'dd if=/dev/urandom of=test bs=16384 count=32768; cp test test2 ;
diff test test2'.

I traced the problem to a combination of choosing "Optimal" for the System
Permorfance Setting in the BIOS and the the new pci_fixup_vt8363 added to
arch/i386/kernel/pci-pc.c in kernel 2.4.3-pre3.  So I did a bunch of tests
using no pci_fixup function, the pci_fixup_vt8363 function, and the
following subset of pci_fixup_vt8363:

        pci_read_config_byte(d, 0x54, &tmp);
        if(tmp & (1<<2)) {
                printk("PCI: Bus master Pipeline request disabled\n");
                pci_write_config_byte(d, 0x54, tmp & ~(1<<2));
        }
        pci_read_config_byte(d, 0x70, &tmp);
        if(tmp & (1<<2)) {
                printk("PCI: Disabled Master Read Caching\n");
                pci_write_config_byte(d, 0x70, tmp & ~(1<<2));
        }

The results for me:
				Normal		Optimal
				------		-------
no pci_fixup			no corruption	no corruption
pci_fixup_vt8363 subset		corruption	corruption
pci_fixup_vt8363		no corruption	corruption

At this point my skills and perseverance gave out, but if someone would
like me to do a few more specific tests, I could.

Below is the output of 'lspci -xxx -s 0:0' on this hardware, with no
pci_fixup, for both the Normal and Optimal BIOS settings, in the form of a
unified diff.  Hopefully this will shed some light on what the BIOS is
doing, as we don't see to have pci_fixup_vt8363 quite right yet.

Cheers,
Wayne


[root@pizza /mnt]# diff -u --unified=20 normal optimal
--- normal      Wed Mar 28 20:37:57 2001
+++ optimal     Wed Mar 28 20:35:32 2001
@@ -1,18 +1,18 @@
 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
 00: 06 11 05 03 06 00 10 22 02 00 00 06 00 00 00 00
 10: 08 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
 30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 50: 17 a4 6b b4 07 89 20 20 80 80 10 10 10 10 20 20
-60: 33 ff 55 a0 d4 d4 d4 00 40 78 86 2f 08 23 00 00
-70: d8 c0 cc 0d 0e a1 d2 00 01 b4 09 02 00 00 00 03
+60: 33 ff 55 a0 d4 d4 d4 00 44 5c 86 2f 08 23 00 00
+70: de c0 cc 0d 0e a1 d2 00 01 b4 19 02 00 00 00 03
 80: 0f 40 00 00 c0 00 00 00 03 00 25 1f 00 00 00 00
 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 a0: 02 c0 20 00 17 02 00 1f 00 00 00 00 6e 02 14 00
 b0: 62 ec 80 e5 32 33 28 00 00 00 00 00 00 00 00 00
 c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 0e 22 00 00 00 00 00 91 06


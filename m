Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129768AbQJaBuL>; Mon, 30 Oct 2000 20:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129984AbQJaBuH>; Mon, 30 Oct 2000 20:50:07 -0500
Received: from cr934547-a.flfrd1.on.wave.home.com ([24.112.247.163]:36256 "EHLO
	mokona.furryterror.org") by vger.kernel.org with ESMTP
	id <S129768AbQJaBtz>; Mon, 30 Oct 2000 20:49:55 -0500
From: uixjjji1@umail.furryterror.org (Zygo Blaxell)
Subject: 2.2.17, Promise FastTrak66/PDC20262, ugly patches to enable second interface
Date: 30 Oct 2000 20:48:27 -0500
Organization: A poorly-installed InterNetNews site
Message-ID: <8tl8db$lft$1@sana.furryterror.org>
NNTP-Posting-Host: 10.244.97.1
X-Header-Mangling: Original "From:" was <zblaxell@sana.furryterror.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started with this:

Software:

	Linux 2.2.17
	Unified IDE 6.30 (ide.2.2.17.all.20000904.patch.bz2)
	Linux raid 0.90 (raid-2.2.17-A0)

Hardware:

	Dual PIII-550
	2 x PIIX4 IDE interfaces on motherboard
	2 x Promise FastTrak 66 (PDC20262) in PCI slots

.config and dmesg available on request.

I could not get the second IDE interface on two Promise FastTrak66
(PDC20262, (C) 1998, BIOS revision 1.30) controllers to work until I
applied the following patch:

--- drivers/block/ide-pci.c     Mon Oct 23 17:45:39 2000
+++ /tmp/kludged        Mon Oct 30 18:31:47 2000
@@ -562,8 +562,6 @@
        for (port = 0; port <= 1; ++port) {
                unsigned long base = 0, ctl = 0;
                ide_pci_enablebit_t *e = &(d->enablebits[port]);
-               if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) || (tmp & e->mask) != e->val))
-                       continue;       /* port not enabled */
                if (IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT366) && (port) && (class_rev < 0x03))
                        return;
                if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE || (dev->class & (port ? 4 : 1)) != 0) {

This made the second IDE interface on both Promise cards work.  

Am I missing something?  

The patch disregards the enabled flag on the Promise card's second
IDE interface.  Any idea why is that interface is not marked enabled?
More importantly, why is it not enabled on my cards, but apparently
enabled on all of the PDC20262 cards previously mentioned in lkml?

The second IDE on these cards certainly seems to be enabled, because
it's operating in UDMA66 mode through a raid5 sync, lots of md5summing,
and a bonnie or two:

              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
raid5x5  1536  7465 98.3 29956 35.1 16710 40.1  8575 96.5 50594 35.6 251.4  2.6

-- 
Zygo Blaxell (Laptop) <zblaxell@feedme.hungrycats.org>
GPG = D13D 6651 F446 9787 600B AD1E CCF3 6F93 2823 44AD
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

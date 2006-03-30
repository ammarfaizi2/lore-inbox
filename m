Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWC3Kz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWC3Kz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWC3Kz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:55:28 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:11245 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932170AbWC3Kz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:55:27 -0500
Date: Thu, 30 Mar 2006 12:55:23 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Cc: bjorn.helgaas@hp.com
Subject: [2.6.16-gitX] PNP: No PS/2 controller found. Probing ports
 directly.
Message-Id: <20060330125523.2b713a96.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC-ing the author Bjorn since I don't know who'll clean this up.

My acpidump is at http://bugzilla.kernel.org/show_bug.cgi?id=5767
And the lspci at http://bugzilla.kernel.org/show_bug.cgi?id=6072

This notebook has no direct PS2 jack, only USB outlets. Internal keyboard
and touchpad work, as well as wireless USB keyboard and different mice,
but the logs changed:

--- dmesg-070c6999831dc4cfd9b07c74c2fea1964d7adfec      2006-03-30 11:55:58.000000000 +0200
+++ dmesg-982c609448b9d724e1c3a0d5aeee388c064479f0      2006-03-30 11:42:33.000000000 +0200
[...]
@@ -120,7 +119,9 @@
 io scheduler deadline registered
 io scheduler cfq registered (default)
 Real Time Clock Driver v1.12ac
-PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
+pnp: Device 00:08 does not supported disabling.
+pnp: Device 00:07 does not supported disabling.
+PNP: No PS/2 controller found. Probing ports directly.
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 parport: PnPBIOS parport detected.

Due to the commit:

982c609448b9d724e1c3a0d5aeee388c064479f0 is first bad commit
diff-tree 982c609448b9d724e1c3a0d5aeee388c064479f0 (from 070c6999831dc4cfd9b07c74c2fea1964d7adfec)
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Mon Mar 27 01:17:08 2006 -0800

    [PATCH] pnp: PNP: adjust pnp_register_driver signature

    Remove the assumption that pnp_register_driver() returns the number of devices
    claimed.  Returning the count is unreliable because devices may be hot-plugged
    in the future.

    This changes the convention to "zero for success, or a negative error value,"
    which matches pci_register_driver(), acpi_bus_register_driver(), and
    platform_driver_register().

    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Cc: Adam Belay <ambx1@neo.rr.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Full bisect from 2.6.16-git18

git-bisect start
# bad: [5d4fe2c1ce83c3e967ccc1ba3d580c1a5603a866] ixp2000: fix gcc4 breakage
git-bisect bad 5d4fe2c1ce83c3e967ccc1ba3d580c1a5603a866
# good: [414ad0ded83f088608f7c0e774df8cccbba4e229] Linux 2.6.16
git-bisect good 414ad0ded83f088608f7c0e774df8cccbba4e229
# good: [fa4fa40a990f8f4eff65476bef32007c154bbac0] Merge branch 'upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6
git-bisect good fa4fa40a990f8f4eff65476bef32007c154bbac0
# good: [c912c2db2f5c2467ba34e4e655008a14532a3900] x86_64: free_bootmem_node needs __pa in allocate_aperture
git-bisect good c912c2db2f5c2467ba34e4e655008a14532a3900
# good: [104b8deaa5c0144cccfc7d914413ff80c7176af1] unify pfn_to_page: sh pfn_to_page
git-bisect good 104b8deaa5c0144cccfc7d914413ff80c7176af1
# bad: [d4965b3e2ff94d0c7b7e6e7e9794b54950a2f4b9] Merge master.kernel.org:/home/rmk/linux-2.6-serial
git-bisect bad d4965b3e2ff94d0c7b7e6e7e9794b54950a2f4b9
# bad: [f67055780caac6a99f43834795c43acf99eba6a6] md: Checkpoint and allow restart of raid5 reshape
git-bisect bad f67055780caac6a99f43834795c43acf99eba6a6
# bad: [6736a6587b991477aae927c37176e8cab8689f9e] PNP: adjust pnp_register_card_driver() signature: dt019x
git-bisect bad 6736a6587b991477aae927c37176e8cab8689f9e
# good: [c58411e95d7f5062dedd1a3064af4d359da1e633] RTC Subsystem: library functions
git-bisect good c58411e95d7f5062dedd1a3064af4d359da1e633
# good: [fd507e2ff3a5adaccbefa05f4bc9f58f44e930db] RTC subsystem: EP93XX driver
git-bisect good fd507e2ff3a5adaccbefa05f4bc9f58f44e930db
# good: [803d0abb3dcfc93701c8a8dc7f2968a47271214c] pnp: IRDA: adjust pnp_register_driver signature
git-bisect good 803d0abb3dcfc93701c8a8dc7f2968a47271214c
# bad: [51427ec0f222cb73b21f3849416a95d751bdd742] PNP: adjust pnp_register_card_driver() signature: als100
git-bisect bad 51427ec0f222cb73b21f3849416a95d751bdd742
# bad: [982c609448b9d724e1c3a0d5aeee388c064479f0] pnp: PNP: adjust pnp_register_driver signature
git-bisect bad 982c609448b9d724e1c3a0d5aeee388c064479f0
# good: [070c6999831dc4cfd9b07c74c2fea1964d7adfec] pnp: cs4232: adjust pnp_register_driver signature
git-bisect good 070c6999831dc4cfd9b07c74c2fea1964d7adfec

Mvh
Mats Johannesson
--

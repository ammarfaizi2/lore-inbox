Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317265AbSFRBAm>; Mon, 17 Jun 2002 21:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSFRBAN>; Mon, 17 Jun 2002 21:00:13 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:52681 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317265AbSFRA7o>;
	Mon, 17 Jun 2002 20:59:44 -0400
Date: Tue, 18 Jun 2002 02:55:58 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206180055.CAA11524@harpo.it.uu.se>
To: kai@tp1.ruhr-uni-bochum.de, torvalds@transmeta.com
Subject: [PATCH][2.5.22] fix x86 initrd breakage
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus & Kai,

Summary: 2.5.17 broke initrd on x86. Fix below.

arch/i386/boot/Makefile sets RAMDISK := -DRAMDISK=512, so
bootsect.S puts 512 in the ram_size word.
At boot, arch/i386/kernel/setup.c reads ram_size (RAMDISK_FLAGS)
and extracts the low 11 bits (== 512) into rd_image_start.
init/do_mounts.c tries to find a gzip or FS image in /dev/ram
starting at block rd_image_start (512). It fails because
the image normally starts at block 0, and prints:

"RAMDISK: Couldn't find valid RAM disk image starting at 512."

Why: Kai's patch in 2.5.17 to move x86-specific options from
Makefile to arch/i386/boot/Makefile unfortunately lost the fact
that the orginal "#export RAMDISK = -DRAMDISK=512" statement
was commented out. (I suspect a typo.) RAMDISK is obsolete since
1.3.something, and uncommenting it has "interesting" effects
since the ram_size field has a very different meaning now.

The patch below reverts the statement to its pre-2.5.17 state.
Perhaps it should be removed altogether?

Cc: to Andi Kleen since it seems x86_64 also is affected by
this bug.

/Mikael

--- linux-2.5.22/arch/i386/boot/Makefile.~1~	Tue Jun 11 14:18:07 2002
+++ linux-2.5.22/arch/i386/boot/Makefile	Tue Jun 18 00:43:12 2002
@@ -23,7 +23,7 @@
 
 # If you want the RAM disk device, define this to be the size in blocks.
 
-RAMDISK := -DRAMDISK=512
+#RAMDISK := -DRAMDISK=512
 
 # ---------------------------------------------------------------------------
 

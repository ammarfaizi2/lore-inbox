Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132557AbRD1PDB>; Sat, 28 Apr 2001 11:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132605AbRD1PCv>; Sat, 28 Apr 2001 11:02:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:27357 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S132557AbRD1PCm>;
	Sat, 28 Apr 2001 11:02:42 -0400
Date: Sat, 28 Apr 2001 17:02:21 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200104281502.RAA26232.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        mailhot@enst.fr, markus@schlup.net
Subject: Dane-Elec PhotoMate Combo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a Dane-Elec PhotoMate Combo SmartMedia/CompactFlash reader
manufactured by SCM Microsystems. It is a USB device with ID 04e6:0005.

The http://www.qbik.ch/usb/devices/ list of supported devices
calls this thing unsupported, and mailhot@enst.fr writes:
"I want this to work ! I'll help testing."

I think the status can be changed to fully supported, at least
it works fine in my first tests.

Changes required:
(i) in sd.c there is a peculiar code fragment that assumes
that a removable disk is write protected in case the status is unknown;
reversing this default allows writing to the flash card.

                if (the_result) {
-                       printk("%s: test WP failed, assume Write Protected\n", nbuff);
-                       rscsi_disks[i].write_prot = 1;
+                       printk("%s: test WP failed, assume Write Enabled\n", nbuff);
                } else {
                        rscsi_disks[i].write_prot = ((buffer[2] & 0x80) != 0);

(ii) this card needs usb/storage/dpcm.c which is compiled when
CONFIG_USB_STORAGE_DPCM is set, but this variable is missing
from usb/Config.in. Add it.

(iii) add to unusual_devs.h:

diff -u --recursive --new-file ../linux-2.4.3/linux/drivers/usb/storage/unusual_devs.h ./l\
inux/drivers/usb/storage/unusual_devs.h
--- ../linux-2.4.3/linux/drivers/usb/storage/unusual_devs.h     Sun Apr  1 20:44:19 2001
+++ ./linux/drivers/usb/storage/unusual_devs.h  Sat Apr 28 14:39:20 2001
@@ -79,6 +79,12 @@
                "CameraMate (DPCM_USB)",
                US_SC_SCSI, US_PR_DPCM_USB, NULL,
                US_FL_START_STOP ),
+
+UNUSUAL_DEV(  0x04e6, 0x0005, 0x0100, 0x0208,
+               "SCM Microsystems Inc",
+               "eUSB SmartMedia / CompactFlash Adapter",
+               US_SC_SCSI, US_PR_DPCM_USB, NULL,
+               US_FL_START_STOP ),
 #endif


Maybe the device is slow, and I got read errors with a Compact Flash
card in the reader at boot time. A "blockdev --rereadpt /dev/sdX" worked.

Andries


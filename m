Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290679AbSBLBEb>; Mon, 11 Feb 2002 20:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290675AbSBLBEO>; Mon, 11 Feb 2002 20:04:14 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31874 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S290665AbSBLBC6>;
	Mon, 11 Feb 2002 20:02:58 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 12 Feb 2002 01:02:54 GMT
Message-Id: <UTC200202120102.BAA1073277.aeb@cwi.nl>
To: alan@lxorguk.ukuu.org.uk, andre@suse.com, linux-kernel@vger.kernel.org
Subject: [PATCH] unclip large disks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of CONFIG_IDEDISK_STROKE is to make the setmax
utility superfluous. However, I find that unclipping large
disks fails because idedisk_read_native_max_address_ext()
is called before probe_lba_addressing(), which means that
drive->addressing is not yet set, and the high order part
of the disk size is not read.
Thus, probe_lba_addressing() should be moved up in ide-disk.c,
for example

@@ -1323,6 +1318,8 @@
        if (id == NULL)
                return;

+       (void) probe_lba_addressing(drive, 1);
+
        /*
         * CompactFlash cards and their brethern look just like hard drives
         * to us, but they are removable and don't have a doorlock mechanism.
@@ -1414,7 +1411,6 @@
        drive->no_io_32bit = id->dword_io ? 1 : 0;
        if (drive->id->cfs_enable_2 & 0x3000)
                write_cache(drive, (id->cfs_enable_2 & 0x3000));
-       (void) probe_lba_addressing(drive, 1);
 }

 static int idedisk_cleanup (ide_drive_t *drive)

[your line numbers may differ]

Andries

[this was for some variant on linux-2.4.18-pre7-ac3,
but no doubt a similar patch applies to all kernels
with IDE patch]

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWGaMfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWGaMfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 08:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWGaMfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 08:35:53 -0400
Received: from mx1.suse.de ([195.135.220.2]:7559 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751097AbWGaMfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 08:35:52 -0400
Date: Mon, 31 Jul 2006 14:35:46 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ignore partition table on disks with AIX label
Message-ID: <20060731123546.GA1750@suse.de>
References: <20060517081314.GA20415@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060517081314.GA20415@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The on-disk data structures from AIX are not known, also the filesystem
layout is not known. There is a msdos partition signature at the end of
the first block, and the kernel recognizes 3 small (and overlapping) partitions.
But they are not usable. Maybe the firmware uses it to find the bootloader
for AIX, but AIX boots also if the first block is cleared.

This is the content of the partition table:
 # dd if=/dev/sdb count=$(( 4 * 16 )) bs=1 skip=$(( 0x1be )) | xxd
0000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000010: 80ff ffff 41ff ffff 1b11 0000 381b 0000  ....A.......8...
0000020: 00ff ffff 41ff ffff 0211 0000 1900 0000  ....A...........
0000030: 80ff ffff 41ff ffff 1b11 0000 381b 0000  ....A.......8...


Handle the whole disk as empty disk.
This fixes also YaST who compares the output from parted (and formerly fdisk)
with /proc/partitions. fdisk recognizes the AIX label since a long time,
SuSE has a patch for parted to handle the disk label as unknown.

dmesg will look like this:
 sda: [AIX]  unknown partition table

Tested on an IBM B50 with AIX V4.3.3.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 fs/partitions/msdos.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

Index: linux-2.6.18-rc3/fs/partitions/msdos.c
===================================================================
--- linux-2.6.18-rc3.orig/fs/partitions/msdos.c
+++ linux-2.6.18-rc3/fs/partitions/msdos.c
@@ -58,6 +58,31 @@ msdos_magic_present(unsigned char *p)
 	return (p[0] == MSDOS_LABEL_MAGIC1 && p[1] == MSDOS_LABEL_MAGIC2);
 }
 
+/* Value is EBCDIC 'IBMA' */
+#define AIX_LABEL_MAGIC1	0xC9
+#define AIX_LABEL_MAGIC2	0xC2
+#define AIX_LABEL_MAGIC3	0xD4
+#define AIX_LABEL_MAGIC4	0xC1
+static int aix_magic_present(unsigned char *p, struct block_device *bdev)
+{
+	Sector sect;
+	unsigned char *d;
+	int ret = 0;
+
+	if (p[0] != AIX_LABEL_MAGIC1 &&
+		p[1] != AIX_LABEL_MAGIC2 &&
+		p[2] != AIX_LABEL_MAGIC3 &&
+		p[3] != AIX_LABEL_MAGIC4)
+		return 0;
+	d = read_dev_sector(bdev, 7, &sect);
+	if (d) {
+		if (d[0] == '_' && d[1] == 'L' && d[2] == 'V' && d[3] == 'M')
+			ret = 1;
+		put_dev_sector(sect);
+	};
+	return ret;
+}
+
 /*
  * Create devices for each logical partition in an extended partition.
  * The logical partitions form a linked list, with each entry being
@@ -393,6 +418,12 @@ int msdos_partition(struct parsed_partit
 		return 0;
 	}
 
+	if (aix_magic_present(data, bdev)) {
+		put_dev_sector(sect);
+		printk( " [AIX]");
+		return 0;
+	}
+
 	/*
 	 * Now that the 55aa signature is present, this is probably
 	 * either the boot sector of a FAT filesystem or a DOS-type

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWEQINS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWEQINS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 04:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWEQINS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 04:13:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41857 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932472AbWEQINQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 04:13:16 -0400
Date: Wed, 17 May 2006 10:13:14 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ignore partition table on disks with AIX label
Message-ID: <20060517081314.GA20415@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Handle the whole disk as empty disk.
This fixes also YaST who compares the output from parted (and formerly fdisk)
with /proc/partitions. fdisk recognizes the AIX label since a long time,
SuSE has a patch for parted to handle the disk label as unknown.

dmesg will look like this:
 sda: [AIX]  unknown partition table


Signed-off-by: Olaf Hering <olh@suse.de>

---
 fs/partitions/msdos.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: linux-2.6.16/fs/partitions/msdos.c
===================================================================
--- linux-2.6.16.orig/fs/partitions/msdos.c
+++ linux-2.6.16/fs/partitions/msdos.c
@@ -59,6 +59,19 @@ msdos_magic_present(unsigned char *p)
 	return (p[0] == MSDOS_LABEL_MAGIC1 && p[1] == MSDOS_LABEL_MAGIC2);
 }
 
+/* Value is EBCIDIC 'IBMA' */
+#define AIX_LABEL_MAGIC1	0xC9
+#define AIX_LABEL_MAGIC2	0xC2
+#define AIX_LABEL_MAGIC3	0xD4
+#define AIX_LABEL_MAGIC4	0xC1
+static int aix_magic_present(unsigned char *p)
+{
+	return (p[0] == AIX_LABEL_MAGIC1 &&
+		p[1] == AIX_LABEL_MAGIC2 &&
+		p[2] == AIX_LABEL_MAGIC3 &&
+		p[3] == AIX_LABEL_MAGIC4);
+}
+
 /*
  * Create devices for each logical partition in an extended partition.
  * The logical partitions form a linked list, with each entry being
@@ -394,6 +407,12 @@ int msdos_partition(struct parsed_partit
 		return 0;
 	}
 
+	if (aix_magic_present(data)) {
+		put_dev_sector(sect);
+		printk( " [AIX]");
+		return 0;
+	}
+
 	/*
 	 * Now that the 55aa signature is present, this is probably
 	 * either the boot sector of a FAT filesystem or a DOS-type

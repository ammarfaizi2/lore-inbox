Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTFWXJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265579AbTFWXHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:07:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27400 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265575AbTFWXGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:06:08 -0400
Date: Tue, 24 Jun 2003 00:20:08 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.uk.linux.org>
Subject: [PATCH] Fix cockups (wot I made) in fs/partitions/acorn.c
Message-ID: <20030624002008.K28325@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Al Viro <viro@ftp.uk.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that my test config didn't actually have this enabled (it does
now.)  I'll push it Linus-wards tomorrow unless someone screams.

diff -urN orig/fs/partitions/acorn.c linux/fs/partitions/acorn.c
--- orig/fs/partitions/acorn.c	Mon Jun 23 11:51:28 2003
+++ linux/fs/partitions/acorn.c	Mon Jun 23 12:28:58 2003
@@ -517,7 +517,7 @@
 	const unsigned char *data;
 	unsigned char buffer[256];
 	struct eesox_part *p;
-	u32 start = 0;
+	sector_t start = 0;
 	int i, slot = 1;
 
 	data = read_dev_sector(bdev, 7, &sect);
@@ -533,22 +533,22 @@
 	put_dev_sector(sect);
 
 	for (i = 0, p = (struct eesox_part *)buffer; i < 8; i++, p++) {
-		u32 next;
+		sector_t next;
 
 		if (memcmp(p->magic, "Eesox", 6))
 			break;
 
-		next = le32_to_cpu(p->start) + first_sector;
+		next = le32_to_cpu(p->start);
 		if (i)
 			put_partition(state, slot++, start, next - start);
 		start = next;
 	}
 
 	if (i != 0) {
-		unsigned long size;
+		sector_t size;
 
-		size = hd->part[minor(to_kdev_t(bdev->bd_dev))].nr_sects;
-		add_gd_partition(hd, minor++, start, size - start);
+		size = get_capacity(bdev->bd_disk);
+		put_partition(state, slot++, start, size - start);
 		printk("\n");
 	}
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270345AbTHLNyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270346AbTHLNyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:54:47 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:14307 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S270345AbTHLNyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:54:46 -0400
Date: Tue, 12 Aug 2003 15:54:38 +0200
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6-mm] Fix 64-bit kdev_t /sys/<dev>/<partition>/dev format: %04x -> %u:%u
Message-ID: <20030812135438.GA4157@chtephan.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The 64-bit kdev_t patch forgot to change part_dev_read in
fs/partitions/check.c to return the device in the new %u:%u format in
sysfs.

cat /sys/block/hda/hda5/dev should return 3:5 instead of 0305

This small patch adds this:

diff -Nur linux.orig/fs/partitions/check.c linux/fs/partitions/check.c
--- linux.orig/fs/partitions/check.c	2003-08-12 15:27:55.000000000 +0200
+++ linux/fs/partitions/check.c	2003-08-12 15:46:15.855390848 +0200
@@ -223,9 +223,8 @@
 static ssize_t part_dev_read(struct hd_struct * p, char *page)
 {
 	struct gendisk *disk = container_of(p->kobj.parent,struct gendisk,kobj);
-	int part = p->partno;
-	dev_t base = MKDEV(disk->major, disk->first_minor); 
-	return sprintf(page, "%04x\n", (unsigned)(base + part));
+	dev_t dev = MKDEV(disk->major, disk->first_minor + p->partno); 
+	return print_dev_t(page, dev);
 }
 static ssize_t part_start_read(struct hd_struct * p, char *page)
 {

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

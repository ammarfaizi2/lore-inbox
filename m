Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTECViG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTECViG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:38:06 -0400
Received: from smtp02.web.de ([217.72.192.151]:30725 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263435AbTECViE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:38:04 -0400
Date: Sun, 4 May 2003 00:04:25 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH 2.5] [TRIVIAL] Get rid of magic numbers in
 drivers/block/genhd.c
Message-Id: <20030504000425.726daf8b.l.s.r@web.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

a few days ago you cleaned up disk_name() in fs/partitions/check.c. It
is now guaranteed to write no more than BDEVNAME_SIZE into the provided
buffer.

There are two buffers in drivers/block/genhd.c, that are used solely for
calling disk_name(), and have a size of 64. The patch below replaces
these magic numbers with BDEVNAME_SIZE.

Additionally it corrects the comment at the top of disk_name(): The md
driver does not call that function, the genhd driver does.

René



diff -ur l-x/drivers/block/genhd.c l-y/drivers/block/genhd.c
--- l-x/drivers/block/genhd.c	2003-05-03 21:37:47.000000000 +0200
+++ l-y/drivers/block/genhd.c	2003-05-03 23:58:35.000000000 +0200
@@ -350,7 +350,7 @@
 {
 	struct gendisk *sgp = v;
 	int n;
-	char buf[64];
+	char buf[BDEVNAME_SIZE];
 
 	if (&sgp->kobj.entry == block_subsys.kset.list.next)
 		seq_puts(part, "major minor  #blocks  name\n\n");
@@ -583,7 +583,7 @@
 static int diskstats_show(struct seq_file *s, void *v)
 {
 	struct gendisk *gp = v;
-	char buf[64];
+	char buf[BDEVNAME_SIZE];
 	int n = 0;
 
 	/*
diff -ur l-x/fs/partitions/check.c l-y/fs/partitions/check.c
--- l-x/fs/partitions/check.c	2003-05-03 21:37:59.000000000 +0200
+++ l-y/fs/partitions/check.c	2003-05-03 23:58:58.000000000 +0200
@@ -88,7 +88,7 @@
 };
  
 /*
- * disk_name() is used by partition check code and the md driver.
+ * disk_name() is used by partition check code and the genhd driver.
  * It formats the devicename of the indicated disk into
  * the supplied buffer (of size at least 32), and returns
  * a pointer to that same buffer (for convenience).

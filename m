Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbUGBS3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbUGBS3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUGBS3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:29:16 -0400
Received: from hera.cwi.nl ([192.16.191.8]:31427 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264880AbUGBS3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:29:10 -0400
Date: Fri, 2 Jul 2004 20:28:54 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200407021828.i62ISse29171.aeb@smtp.cwi.nl>
To: akpm@osdl.org, hirofumi@mail.parknet.co.jp, torvalds@osdl.org
Subject: [PATCH] fat/inode.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two years ago, OGAWA Hirofumi removed some ugly code and
added a few simple tests to the FAT filesystem code,
intended to avoid recognizing non-FAT as FAT (for people who
fail to specify rootfstype=, forcing the kernel to guess).

That worked fairly well, until this year.
I have now seen a thread in Czech and a report from Holland
that involved the "FAT: bogus sectors-per-track value"
error message.

The patch below removes this test again. The advantage is that
some real-life FAT filesystems can be mounted again.
The disadvantage that more non-FAT fss will be accepted as FAT.

Ferry van Steen <freaky@bananateam.nl> reports
"the patch Andries Brouwer gave me seems to work".

Signed-off-by: Andries Brouwer <aeb@cwi.nl>

diff -uprN -X /linux/dontdiff a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	2004-06-24 17:11:20
+++ b/fs/fat/inode.c	2004-07-02 19:25:21
@@ -830,18 +830,12 @@ int fat_fill_super(struct super_block *s
 		brelse(bh);
 		goto out_invalid;
 	}
-	if (!b->secs_track) {
-		if (!silent)
-			printk(KERN_ERR "FAT: bogus sectors-per-track value\n");
-		brelse(bh);
-		goto out_invalid;
-	}
-	if (!b->heads) {
-		if (!silent)
-			printk(KERN_ERR "FAT: bogus number-of-heads value\n");
-		brelse(bh);
-		goto out_invalid;
-	}
+
+	/*
+	 * Earlier we checked here that b->secs_track and b->head are nonzero,
+	 * but it turns out valid FAT filesystems can have zero there.
+	 */
+
 	media = b->media;
 	if (!FAT_VALID_MEDIA(media)) {
 		if (!silent)

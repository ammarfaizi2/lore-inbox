Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbULGLTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbULGLTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 06:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbULGLTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 06:19:25 -0500
Received: from hera.cwi.nl ([192.16.191.8]:3527 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261785AbULGLTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 06:19:07 -0500
Date: Tue, 7 Dec 2004 12:18:54 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] restore BLKRRPART semantics
Message-ID: <20041207111853.GA8915@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.8 the code for the BLKRRPART ioctl was changed
to return EIO when no partitions were found, such as
on an empty disk. This breaks some partitioning programs
and is also confusing: "Input/Output error" while in fact
nothing was wrong with this brand new all blank disk.

This restores old behaviour.

Andries

diff -uprN -X /linux/dontdiff a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	2004-12-04 16:18:22.000000000 +0100
+++ b/fs/partitions/check.c	2004-12-07 12:26:28.000000000 +0100
@@ -378,7 +378,7 @@ int rescan_partitions(struct gendisk *di
 	if (disk->fops->revalidate_disk)
 		disk->fops->revalidate_disk(disk);
 	if (!get_capacity(disk) || !(state = check_partition(disk, bdev)))
-		return -EIO;
+		return 0;
 	for (p = 1; p < state->limit; p++) {
 		sector_t size = state->parts[p].size;
 		sector_t from = state->parts[p].from;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVBZVf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVBZVf1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 16:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVBZVfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 16:35:22 -0500
Received: from hera.cwi.nl ([192.16.191.8]:5798 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261279AbVBZVfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 16:35:11 -0500
Date: Sat, 26 Feb 2005 22:35:00 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: bon@elektron.ikp.physik.tu-darmstadt.de, linux-kernel@vger.kernel.org
Subject: [PATCH] partitions/msdos.c
Message-ID: <20050226213459.GA21137@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A well-known kernel bug is that it guesses at the partition type
and the partitions on any disk it encounters. This is bad because
needless I/O is done, slowing down the boot, sometimes quite a lot,
especially when I/O errors occur. And it is bad because sometimes
we guess wrong.

In other words, we need the user space command `partition',
where "partition -t dos /dev/sda" reads a DOS-type partition
table. (And "partition /dev/sda" tries all known heuristics
to decide what type of partitioning might be present.)
The two variants are: (i) partition tells the kernel
to do the partition table reading, and (ii) partition uses partx
to read the partition table and tells the kernel one-by-one
about the partitions found this way.

Since this is a fundamental change, a long transition period
is needed, and that period could start with a kernel boot parameter
telling the kernel not to do partition table parsing on a particular
disk, or a particular type of disks, or all disks.

This could have been the intro to a patch doing that, but is not.
(It is just an RFC.)

The tiny patch below prompted the above - it was suggested by Uwe Bonnes
who encountered USB devices without partition table where our present
heuristics did not suffice to stop partition table parsing.
It causes the kernel to ignore partitions of type 0. A band-aid.

I think nobody uses such partitions seriously, but nevertheless this
should probably live in -mm for a while to see if anybody complains.

Andries

diff -uprN -X /linux/dontdiff a/fs/partitions/msdos.c b/fs/partitions/msdos.c
--- a/fs/partitions/msdos.c	2004-12-29 03:39:55.000000000 +0100
+++ b/fs/partitions/msdos.c	2005-02-26 22:21:06.000000000 +0100
@@ -430,6 +430,8 @@ int msdos_partition(struct parsed_partit
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
 		u32 start = START_SECT(p)*sector_size;
 		u32 size = NR_SECTS(p)*sector_size;
+		if (SYS_IND(p) == 0)
+			continue;
 		if (!size)
 			continue;
 		if (is_extended_partition(p)) {

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVBZWef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVBZWef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 17:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVBZWef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 17:34:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:51136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261285AbVBZWec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 17:34:32 -0500
Date: Sat, 26 Feb 2005 14:35:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0502261433431.25732@ppc970.osdl.org>
References: <20050226213459.GA21137@apps.cwi.nl>
 <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
 <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Feb 2005, Linus Torvalds wrote:
> 
> Would it not make more sense to just sanity-check the size itself, and
> throw it out if the partition size (plus start) is bigger than the disk
> size?

Something like this (TOTALLY UNTESTED AS USUAL!)?

What does fdisk and other tools do on that disk? Just out of interest..

		Linus

---
===== fs/partitions/msdos.c 1.26 vs edited =====
--- 1.26/fs/partitions/msdos.c	2004-11-09 12:43:17 -08:00
+++ edited/fs/partitions/msdos.c	2005-02-26 14:33:33 -08:00
@@ -381,6 +381,7 @@
 int msdos_partition(struct parsed_partitions *state, struct block_device *bdev)
 {
 	int sector_size = bdev_hardsect_size(bdev) / 512;
+	sector_t nr_sectors;
 	Sector sect;
 	unsigned char *data;
 	struct partition *p;
@@ -426,11 +427,12 @@
 	 * On the second pass look inside *BSD, Unixware and Solaris partitions.
 	 */
 
+	nr_sectors = get_capacity(bdev->bd_disk);
 	state->next = 5;
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
 		u32 start = START_SECT(p)*sector_size;
 		u32 size = NR_SECTS(p)*sector_size;
-		if (!size)
+		if (!size || size > nr_sectors)
 			continue;
 		if (is_extended_partition(p)) {
 			/* prevent someone doing mkfs or mkswap on an

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVEWXpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVEWXpD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVEWX1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:27:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:48773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261246AbVEWXYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:24:53 -0400
Date: Mon, 23 May 2005 16:24:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com,
       dsd@gentoo.org
Subject: [patch 07/16] ide-disk: Fix LBA8 DMA
Message-ID: <20050523232414.GS27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <dsd@gentoo.org>

This is from Gentoo's 2.6.11 patchset. A problem was introduced in 2.6.10
where some users could not enable DMA on their disks (particularly ALi15x3
users). This was a small mistake with the no_lba48_dma flag.

I can't find the exact commit but this is definately included in 2.6.12-rc4.

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/ide/ide-disk.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.11.10.orig/drivers/ide/ide-disk.c	2005-05-16 10:50:31.000000000 -0700
+++ linux-2.6.11.10/drivers/ide/ide-disk.c	2005-05-20 09:36:31.933319224 -0700
@@ -133,6 +133,8 @@
 	if (hwif->no_lba48_dma && lba48 && dma) {
 		if (block + rq->nr_sectors > 1ULL << 28)
 			dma = 0;
+               else
+                       lba48 = 0;
 	}
 
 	if (!dma) {
@@ -146,7 +148,7 @@
 	/* FIXME: SELECT_MASK(drive, 0) ? */
 
 	if (drive->select.b.lba) {
-		if (drive->addressing == 1) {
+               if (lba48) {
 			task_ioreg_t tasklets[10];
 
 			pr_debug("%s: LBA=0x%012llx\n", drive->name, block);

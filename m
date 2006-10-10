Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWJJRSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWJJRSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWJJRRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:17:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:31627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964819AbWJJRRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:17:23 -0400
Date: Tue, 10 Oct 2006 10:15:48 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, drzeus@drzeus.cx,
       Daniel Drake <dsd@gentoo.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 17/19] MMC: Always use a sector size of 512 bytes
Message-ID: <20061010171548.GR6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="mmc-always-use-a-sector-size-of-512-bytes.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Pierre Ossman <drzeus@drzeus.cx>

Both MMC and SD specifications specify (although a bit unclearly in the MMC
case) that a sector size of 512 bytes must always be supported by the card.

Cards can report larger "native" size than this, and cards >= 2 GB even
must do so. Most other readers use 512 bytes even for these cards. We should
do the same to be compatible.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
Cc: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/mmc_block.c |   49 +++---------------------------------------------
 1 file changed, 4 insertions(+), 45 deletions(-)

--- linux-2.6.17.13.orig/drivers/mmc/mmc_block.c
+++ linux-2.6.17.13/drivers/mmc/mmc_block.c
@@ -325,52 +325,11 @@ static struct mmc_blk_data *mmc_blk_allo
 	md->read_only = mmc_blk_readonly(card);
 
 	/*
-	 * Figure out a workable block size.  MMC cards have:
-	 *  - two block sizes, one for read and one for write.
-	 *  - may support partial reads and/or writes
-	 *    (allows block sizes smaller than specified)
+	 * Both SD and MMC specifications state (although a bit
+	 * unclearly in the MMC case) that a block size of 512
+	 * bytes must always be supported by the card.
 	 */
-	md->block_bits = card->csd.read_blkbits;
-	if (card->csd.write_blkbits != card->csd.read_blkbits) {
-		if (card->csd.write_blkbits < card->csd.read_blkbits &&
-		    card->csd.read_partial) {
-			/*
-			 * write block size is smaller than read block
-			 * size, but we support partial reads, so choose
-			 * the smaller write block size.
-			 */
-			md->block_bits = card->csd.write_blkbits;
-		} else if (card->csd.write_blkbits > card->csd.read_blkbits &&
-			   card->csd.write_partial) {
-			/*
-			 * read block size is smaller than write block
-			 * size, but we support partial writes.  Use read
-			 * block size.
-			 */
-		} else {
-			/*
-			 * We don't support this configuration for writes.
-			 */
-			printk(KERN_ERR "%s: unable to select block size for "
-				"writing (rb%u wb%u rp%u wp%u)\n",
-				mmc_card_id(card),
-				1 << card->csd.read_blkbits,
-				1 << card->csd.write_blkbits,
-				card->csd.read_partial,
-				card->csd.write_partial);
-			md->read_only = 1;
-		}
-	}
-
-	/*
-	 * Refuse to allow block sizes smaller than 512 bytes.
-	 */
-	if (md->block_bits < 9) {
-		printk(KERN_ERR "%s: unable to support block size %u\n",
-			mmc_card_id(card), 1 << md->block_bits);
-		ret = -EINVAL;
-		goto err_kfree;
-	}
+	md->block_bits = 9;
 
 	md->disk = alloc_disk(1 << MMC_SHIFT);
 	if (md->disk == NULL) {

--

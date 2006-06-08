Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWFHXBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWFHXBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWFHXBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:01:47 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:32141 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S965051AbWFHXBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:01:46 -0400
Message-ID: <4488AC57.7050201@drzeus.cx>
Date: Fri, 09 Jun 2006 01:01:43 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hera.drzeus.cx-1413-1149807705-0001-2"
CC: Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
References: <447AFE7A.3070401@drzeus.cx> <20060603141548.GA31182@flint.arm.linux.org.uk> <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com> <4481FB80.40709@drzeus.cx> <4484B5AE.8060404@drzeus.cx> <44869794.9080906@drzeus.cx> <20060607165837.GE13165@flint.arm.linux.org.uk> <448738CD.8030907@drzeus.cx>
In-Reply-To: <448738CD.8030907@drzeus.cx>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-1413-1149807705-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Suggested patch included.

--=_hera.drzeus.cx-1413-1149807705-0001-2
Content-Type: text/x-patch; name="mmc-512-sector.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-512-sector.patch"

[MMC] Always use a sector size of 512 bytes

Both MMC and SD specifications specify (although a bit unclearly in the MMC
case) that a sector size of 512 bytes must always be supported by the card.

Cards can report larger "native" size than this, and cards >= 2 GB even
must do so. Most other readers use 512 bytes even for these cards. We should
do the same to be compatible.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc_block.c |   49 ++++-------------------------------------------
 1 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index 587458b..96049e2 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
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

--=_hera.drzeus.cx-1413-1149807705-0001-2--

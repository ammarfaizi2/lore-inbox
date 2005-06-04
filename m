Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVFDT6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFDT6L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 15:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVFDT6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 15:58:10 -0400
Received: from [85.8.12.41] ([85.8.12.41]:34482 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261240AbVFDTyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 15:54:55 -0400
Message-ID: <42A2070D.9060608@drzeus.cx>
Date: Sat, 04 Jun 2005 21:54:53 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-25623-1117914894-0001-2"
To: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] Support for read-only MMC cards
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-25623-1117914894-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

If the card does not support the write commands then only allow
read-only access.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

--=_hermes.drzeus.cx-25623-1117914894-0001-2
Content-Type: text/x-patch; name="mmc-ro_ccc.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-ro_ccc.patch"

--- linux-2.6.11/drivers/mmc/mmc_block.c.orig	2005-06-04 21:44:20.000000000 +0200
+++ linux-2.6.11/drivers/mmc/mmc_block.c	2005-06-04 21:48:46.000000000 +0200
@@ -95,6 +95,10 @@ static int mmc_blk_open(struct inode *in
 		if (md->usage == 2)
 			check_disk_change(inode->i_bdev);
 		ret = 0;
+
+		if ((filp->f_mode & FMODE_WRITE) &&
+			!(md->queue.card->csd.cmdclass & CCC_BLOCK_WRITE))
+			ret = -EROFS;
 	}
 
 	return ret;
@@ -403,9 +407,12 @@ static int mmc_blk_probe(struct mmc_card
 	if (err)
 		goto out;
 
-	printk(KERN_INFO "%s: %s %s %dKiB\n",
+	printk(KERN_INFO "%s: %s %s %dKiB",
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
 		(card->csd.capacity << card->csd.read_blkbits) / 1024);
+	if (!(card->csd.cmdclass & CCC_BLOCK_WRITE))
+		printk(" (ro)");
+	printk("\n");
 
 	mmc_set_drvdata(card, md);
 	add_disk(md->disk);

--=_hermes.drzeus.cx-25623-1117914894-0001-2--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbVJ2WkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbVJ2WkL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbVJ2WkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:40:11 -0400
Received: from [85.8.13.51] ([85.8.13.51]:23443 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932718AbVJ2WkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:40:10 -0400
Message-ID: <4363FA3E.3000701@drzeus.cx>
Date: Sun, 30 Oct 2005 00:39:58 +0200
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-30492-1130625599-0001-2"
To: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use command class to determine read-only status.
References: <20051028073605.4108.41408.stgit@poseidon.drzeus.cx> <20051028201455.GI4464@flint.arm.linux.org.uk>
In-Reply-To: <20051028201455.GI4464@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-30492-1130625599-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Russell King wrote:
> On Fri, Oct 28, 2005 at 09:36:05AM +0200, Pierre Ossman wrote:
>> If a card doesn't support the "write block" command class then
>> any attempts to open the device should reflect this by denying
>> write access.
> 
> I'd rather we kept printk messages as one printk if at all possible.
> How about encapsulating both of these conditions into an inline
> function:
> 

Ok with me. New patch included.

--=_hermes.drzeus.cx-30492-1130625599-0001-2
Content-Type: text/x-patch; name="mmc-readonly-ccc.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-readonly-ccc.patch"

[MMC] Use command class to determine read-only status.

If a card doesn't support the "write block" command class then
any attempts to open the device should reflect this by denying
write access.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc_block.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -85,6 +85,12 @@ static void mmc_blk_put(struct mmc_blk_d
 	up(&open_lock);
 }
 
+static inline int mmc_blk_readonly(struct mmc_card *card)
+{
+	return mmc_card_readonly(card) ||
+	       !(card->csd.cmdclass & CCC_BLOCK_WRITE);
+}
+
 static int mmc_blk_open(struct inode *inode, struct file *filp)
 {
 	struct mmc_blk_data *md;
@@ -97,7 +103,7 @@ static int mmc_blk_open(struct inode *in
 		ret = 0;
 
 		if ((filp->f_mode & FMODE_WRITE) &&
-			mmc_card_readonly(md->queue.card))
+			mmc_blk_readonly(md->queue.card))
 			ret = -EROFS;
 	}
 
@@ -410,7 +416,7 @@ static int mmc_blk_probe(struct mmc_card
 	printk(KERN_INFO "%s: %s %s %dKiB %s\n",
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
 		(card->csd.capacity << card->csd.read_blkbits) / 1024,
-		mmc_card_readonly(card)?"(ro)":"");
+		mmc_blk_readonly(card)?"(ro)":"");
 
 	mmc_set_drvdata(card, md);
 	add_disk(md->disk);

--=_hermes.drzeus.cx-30492-1130625599-0001-2--

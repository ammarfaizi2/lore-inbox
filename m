Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269111AbUJKPcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269111AbUJKPcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269113AbUJKP31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:29:27 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:53954 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269060AbUJKP1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:27:34 -0400
Message-ID: <416AA670.6040109@drzeus.cx>
Date: Mon, 11 Oct 2004 17:27:44 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-25271-1097508483-0001-2"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: MMC performance
References: <416A68E5.6080608@drzeus.cx>	 <20041011131919.B19175@flint.arm.linux.org.uk> <1097500722.31259.17.camel@localhost.localdomain>
In-Reply-To: <1097500722.31259.17.camel@localhost.localdomain>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-25271-1097508483-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

>Only on retries. You can try and blast the lot out the first time then
>on retries you write sector by sector.
>
>  
>
Something like this? Gives more than double throughput here.


--=_hades.drzeus.cx-25271-1097508483-0001-2
Content-Type: text/x-patch; name="mmc-bulk.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-bulk.patch"

Index: linux-wbsd/drivers/mmc/mmc_block.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc_block.c	(revision 71)
+++ linux-wbsd/drivers/mmc/mmc_block.c	(working copy)
@@ -166,9 +166,20 @@
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 	int ret;
+	int failsafe;
 
 	if (mmc_card_claim_host(card))
 		goto cmd_err;
+	
+	/*
+	 * We first try transfering multiple blocks. If this fails
+	 * we fall back to single block transfers.
+	 *
+	 * This gives us good performance when all is well and the
+	 * possibility to determine which sector fails when all
+	 * is not well.
+	 */
+	failsafe = 0;
 
 	do {
 		struct mmc_blk_request brq;
@@ -188,15 +199,24 @@
 		brq.stop.opcode = MMC_STOP_TRANSMISSION;
 		brq.stop.arg = 0;
 		brq.stop.flags = MMC_RSP_R1B;
+		
+		/*
+		 * A multi-block transfer failed. Falling back to single
+		 * blocks.
+		 */
+		if (failsafe)
+			brq.data.blocks = 1;
+		
+		ret = 1;
 
 		if (rq_data_dir(req) == READ) {
 			brq.cmd.opcode = brq.data.blocks > 1 ? MMC_READ_MULTIPLE_BLOCK : MMC_READ_SINGLE_BLOCK;
 			brq.data.flags |= MMC_DATA_READ;
 		} else {
-			brq.cmd.opcode = MMC_WRITE_BLOCK;
+			brq.cmd.opcode = brq.data.blocks > 1 ? MMC_WRITE_MULTIPLE_BLOCK :
+				MMC_WRITE_BLOCK;
 			brq.cmd.flags = MMC_RSP_R1B;
 			brq.data.flags |= MMC_DATA_WRITE;
-			brq.data.blocks = 1;
 		}
 		brq.mrq.stop = brq.data.blocks > 1 ? &brq.stop : NULL;
 
@@ -204,19 +224,34 @@
 		if (brq.cmd.error) {
 			printk(KERN_ERR "%s: error %d sending read/write command\n",
 			       req->rq_disk->disk_name, brq.cmd.error);
-			goto cmd_err;
+			if (failsafe)
+				goto cmd_err;
+			else {
+				failsafe = 1;
+				continue;
+			}
 		}
 
 		if (brq.data.error) {
 			printk(KERN_ERR "%s: error %d transferring data\n",
 			       req->rq_disk->disk_name, brq.data.error);
-			goto cmd_err;
+			if (failsafe)
+				goto cmd_err;
+			else {
+				failsafe = 1;
+				continue;
+			}
 		}
 
 		if (brq.stop.error) {
 			printk(KERN_ERR "%s: error %d sending stop command\n",
 			       req->rq_disk->disk_name, brq.stop.error);
-			goto cmd_err;
+			if (failsafe)
+				goto cmd_err;
+			else {
+				failsafe = 1;
+				continue;
+			}
 		}
 
 		do {
@@ -229,7 +264,12 @@
 			if (err) {
 				printk(KERN_ERR "%s: error %d requesting status\n",
 				       req->rq_disk->disk_name, err);
-				goto cmd_err;
+				if (failsafe)
+					goto cmd_err;
+				else {
+					failsafe = 1;
+					continue;
+				}
 			}
 		} while (!(cmd.resp[0] & R1_READY_FOR_DATA));
 
@@ -255,6 +295,11 @@
 			end_that_request_last(req);
 		}
 		spin_unlock_irq(&md->lock);
+		
+		/*
+		 * Go back to bulk mode if in failsafe mode.
+		 */
+		failsafe = 0;
 	} while (ret);
 
 	mmc_card_release_host(card);

--=_hades.drzeus.cx-25271-1097508483-0001-2--

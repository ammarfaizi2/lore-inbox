Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVCPOiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVCPOiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVCPOiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:38:06 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:6334 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261234AbVCPOf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:35:59 -0500
Message-ID: <4238444B.2020600@drzeus.cx>
Date: Wed, 16 Mar 2005 15:35:55 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-7166-1110983844-0001-2"
To: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH][MMC] Bulk transfers (round 2)
References: <423841EE.9050202@drzeus.cx>
In-Reply-To: <423841EE.9050202@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-7166-1110983844-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

it might help if I include the actual patch...

--=_hades.drzeus.cx-7166-1110983844-0001-2
Content-Type: text/x-patch; name="mmc-bulk.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-bulk.patch"

Index: linux-wbsd/drivers/mmc/mmc_block.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc_block.c	(revision 77)
+++ linux-wbsd/drivers/mmc/mmc_block.c	(working copy)
@@ -166,9 +166,25 @@
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 	int ret;
+	
+#ifdef CONFIG_MMC_BULKTRANSFER
+	int failsafe;
+#endif
 
 	if (mmc_card_claim_host(card))
 		goto cmd_err;
+	
+#ifdef CONFIG_MMC_BULKTRANSFER
+	/*
+	 * We first try transfering multiple blocks. If this fails
+	 * we fall back to single block transfers.
+	 *
+	 * This gives us good performance when all is well and the
+	 * possibility to determine which sector fails when all
+	 * is not well.
+	 */
+	failsafe = 0;
+#endif
 
 	do {
 		struct mmc_blk_request brq;
@@ -189,14 +205,32 @@
 		brq.stop.arg = 0;
 		brq.stop.flags = MMC_RSP_R1B;
 
+#ifdef CONFIG_MMC_BULKTRANSFER		
+		/*
+		 * A multi-block transfer failed. Falling back to single
+		 * blocks.
+		 */
+		if (failsafe)
+			brq.data.blocks = 1;
+		
+#else
+		/*
+		 * Writes are done one sector at a time.
+		 */
+		if (rq_data_dir(req) != READ)
+			brq.data.blocks = 1;
+#endif
+		
+		ret = 1;
+
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
 
@@ -204,19 +238,19 @@
 		if (brq.cmd.error) {
 			printk(KERN_ERR "%s: error %d sending read/write command\n",
 			       req->rq_disk->disk_name, brq.cmd.error);
-			goto cmd_err;
+			goto cmd_fail;
 		}
 
 		if (brq.data.error) {
 			printk(KERN_ERR "%s: error %d transferring data\n",
 			       req->rq_disk->disk_name, brq.data.error);
-			goto cmd_err;
+			goto cmd_fail;
 		}
 
 		if (brq.stop.error) {
 			printk(KERN_ERR "%s: error %d sending stop command\n",
 			       req->rq_disk->disk_name, brq.stop.error);
-			goto cmd_err;
+			goto cmd_fail;
 		}
 
 		do {
@@ -229,7 +263,7 @@
 			if (err) {
 				printk(KERN_ERR "%s: error %d requesting status\n",
 				       req->rq_disk->disk_name, err);
-				goto cmd_err;
+				goto cmd_fail;
 			}
 		} while (!(cmd.resp[0] & R1_READY_FOR_DATA));
 
@@ -255,6 +289,27 @@
 			end_that_request_last(req);
 		}
 		spin_unlock_irq(&md->lock);
+		
+#ifdef CONFIG_MMC_BULKTRANSFER
+		/*
+		 * Go back to bulk mode if in failsafe mode.
+		 */
+		failsafe = 0;
+#endif
+
+		continue;
+
+ cmd_fail:
+
+#ifdef CONFIG_MMC_BULKTRANSFER
+		if (failsafe)
+	 		goto cmd_err;
+	 	else
+	 		failsafe = 1;
+#else
+ 		goto cmd_err;
+#endif
+
 	} while (ret);
 
 	mmc_card_release_host(card);
Index: linux-wbsd/drivers/mmc/Kconfig
===================================================================
--- linux-wbsd/drivers/mmc/Kconfig	(revision 96)
+++ linux-wbsd/drivers/mmc/Kconfig	(working copy)
@@ -41,6 +41,15 @@
 	  mount the filesystem. Almost everyone wishing MMC support
 	  should say Y or M here.
 
+config MMC_BULKTRANSFER
+	bool "Multi-block writes (EXPERIMENTAL)"
+	depends on MMC_BLOCK != n && EXPERIMENTAL
+	default n
+	help
+	  By default all writes are done one sector at a time. Enable
+	  this option to transfer as large blocks as the host supports.
+	  The transfer speed is in most cases doubled.
+
 config MMC_ARMMMCI
 	tristate "ARM AMBA Multimedia Card Interface support"
 	depends on ARM_AMBA && MMC

--=_hades.drzeus.cx-7166-1110983844-0001-2--

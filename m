Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVCFBre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVCFBre (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 20:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVCFBre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 20:47:34 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:39588 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261277AbVCFBrX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 20:47:23 -0500
Message-ID: <422A6127.70906@drzeus.cx>
Date: Sun, 06 Mar 2005 02:47:19 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-27710-1110073726-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC][3/6] Secure Digital (SD) support : ro
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk> <422A5E1C.2050107@drzeus.cx>
In-Reply-To: <422A5E1C.2050107@drzeus.cx>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-27710-1110073726-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Read-only support.

This patch adds a new callback for the drivers to facilitate reading the 
SD card read-only switch. If the callback is not provided then a warning 
will be printed and it will default to write-enable.

The read-only switch is a host enforced read-only so the MMC block layer 
has been changed to not allow rw mounts of ro cards. It also prints a 
'(ro)' for read-only cards.


--=_hades.drzeus.cx-27710-1110073726-0001-2
Content-Type: text/x-patch; name="mmc-sd-ro.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-sd-ro.patch"

Index: linux-sd/include/linux/mmc/card.h
===================================================================
--- linux-sd/include/linux/mmc/card.h	(revision 137)
+++ linux-sd/include/linux/mmc/card.h	(working copy)
@@ -48,6 +48,7 @@
 #define MMC_STATE_DEAD		(1<<1)		/* device no longer in stack */
 #define MMC_STATE_BAD		(1<<2)		/* unrecognised device */
 #define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
+#define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	struct mmc_cid		cid;		/* card identification */
@@ -58,11 +59,13 @@
 #define mmc_card_dead(c)	((c)->state & MMC_STATE_DEAD)
 #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
 #define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
+#define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
 #define mmc_card_set_bad(c)	((c)->state |= MMC_STATE_BAD)
 #define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
+#define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		((c)->dev.bus_id)
Index: linux-sd/include/linux/mmc/host.h
===================================================================
--- linux-sd/include/linux/mmc/host.h	(revision 137)
+++ linux-sd/include/linux/mmc/host.h	(working copy)
@@ -56,6 +56,7 @@
 struct mmc_host_ops {
 	void	(*request)(struct mmc_host *host, struct mmc_request *req);
 	void	(*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
+	int	(*get_ro)(struct mmc_host *host);
 };
 
 struct mmc_card;
Index: linux-sd/drivers/mmc/mmc_block.c
===================================================================
--- linux-sd/drivers/mmc/mmc_block.c	(revision 135)
+++ linux-sd/drivers/mmc/mmc_block.c	(working copy)
@@ -95,6 +95,10 @@
 		if (md->usage == 2)
 			check_disk_change(inode->i_bdev);
 		ret = 0;
+		
+		if ((filp->f_mode & FMODE_WRITE) &&
+			mmc_card_readonly(md->queue.card))
+			ret = -EROFS;
 	}
 
 	return ret;
@@ -400,9 +404,10 @@
 	if (err)
 		goto out;
 
-	printk(KERN_INFO "%s: %s %s %dKiB\n",
+	printk(KERN_INFO "%s: %s %s %dKiB %s\n",
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
-		(card->csd.capacity << card->csd.read_blkbits) / 1024);
+		(card->csd.capacity << card->csd.read_blkbits) / 1024,
+		mmc_card_readonly(card)?"(ro)":"");
 
 	mmc_set_drvdata(card, md);
 	add_disk(md->disk);
Index: linux-sd/drivers/mmc/mmc.c
===================================================================
--- linux-sd/drivers/mmc/mmc.c	(revision 137)
+++ linux-sd/drivers/mmc/mmc.c	(working copy)
@@ -726,8 +726,20 @@
 			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
 			if (err != MMC_ERR_NONE)
 				mmc_card_set_dead(card);
-			else
+			else {			
 				card->rca = cmd.resp[0] >> 16;
+				
+				if (!host->ops->get_ro) {
+					printk(KERN_WARNING "%s: host does not "
+						"support reading read-only "
+						"switch. assuming write-enable.\n",
+						host->host_name);
+				}
+				else {
+					if (host->ops->get_ro(host))
+						mmc_card_set_readonly(card);
+				}
+			}
 		}
 		else {
 			cmd.opcode = MMC_SET_RELATIVE_ADDR;

--=_hades.drzeus.cx-27710-1110073726-0001-2--

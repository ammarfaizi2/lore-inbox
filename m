Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTIIUif (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTIIUif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:38:35 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:24278 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S264437AbTIIUhi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:37:38 -0400
Message-ID: <3F5E3649.40209@terra.com.br>
Date: Tue, 09 Sep 2003 17:21:29 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk API update (and bug fix) to CDU535 cdrom driver
References: <3F5DDEA8.6040901@terra.com.br> <20030909143341.GA18257@suse.de> <3F5DEA0D.6030701@terra.com.br> <20030909153536.GH18257@suse.de> <3F5E12EC.6040502@terra.com.br> <20030909195549.GR4755@suse.de>
In-Reply-To: <20030909195549.GR4755@suse.de>
Content-Type: multipart/mixed;
 boundary="------------080601090508080306050102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080601090508080306050102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

Jens Axboe wrote:
> That needed changes too, as per my last mail. Please send one complete
> patch with all the fixes in, thanks.

	Sure thing, patch attached:

	- cli-sti removal
	- blk API update
	- set_current_state
	- Remove 'panic' line.

	Please don't forget to remove BROKEN_ON_SMP from 
drivers/cdrom/Kconfig on then cdu535 dependecies (I sent you a patch 
for that as well).

	Thanks for your help Jens,

Felipe

--------------080601090508080306050102
Content-Type: text/plain;
 name="cdu535.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdu535.patch"

--- linux-2.6.0-test5/drivers/cdrom/sonycd535.c	Tue Sep  9 17:01:08 2003
+++ linux-2.6.0-test5-fwd/drivers/cdrom/sonycd535.c	Tue Sep  9 14:41:30 2003
@@ -36,6 +36,10 @@
  *	            module_init & module_exit.
  *                  Torben Mathiasen <tmm@image.dk>
  *
+ * September 2003 - Fix SMP support by removing cli/sti calls.
+ *                  Using spinlocks with a wait_queue instead.
+ *                  Felipe Damasio <felipewd@terra.com.br>
+ *
  * Things to do:
  *  - handle errors and status better, put everything into a single word
  *  - use interrupts (code mostly there, but a big hole still missing)
@@ -340,10 +344,14 @@
 	if (sony535_irq_used <= 0) {	/* poll */
 		yield();
 	} else {	/* Interrupt driven */
-		cli();
+		DEFINE_WAIT(wait);
+		
+		spin_lock_irq(&sonycd535_lock);
 		enable_interrupts();
-		interruptible_sleep_on(&cdu535_irq_wait);
-		sti();
+		prepare_to_wait(&cdu535_irq_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&sonycd535_lock);
+		schedule();
+		finish_wait(&cdu535_irq_wait, &wait);
 	}
 }
 
@@ -804,14 +812,14 @@
 
 		block = req->sector;
 		nsect = req->nr_sectors;
-		if (!(req->flags & REQ_CMD))
-			continue;	/* FIXME */
+		if (!blk_fs_request(req)) {
+			end_request(req, 0);
+			continue;
+		}
 		if (rq_data_dir(req) == WRITE) {
 			end_request(req, 0);
 			continue;
 		}
-		if (rq_data_dir(req) != READ)
-			panic("Unknown SONY CD cmd");
 		/*
 		 * If the block address is invalid or the request goes beyond
 		 * the end of the media, return an error.
@@ -888,8 +896,10 @@
 					}
 					if (readStatus == BAD_STATUS) {
 						/* Sleep for a while, then retry */
-						current->state = TASK_INTERRUPTIBLE;
+						set_current_state(TASK_INTERRUPTIBLE);
+						spin_unlock_irq(&sonycd535_lock);
 						schedule_timeout(RETRY_FOR_BAD_STATUS*HZ/10);
+						spin_lock_irq(&sonycd535_lock);
 					}
 #if DEBUG > 0
 					printk(CDU535_MESSAGE_NAME
@@ -1473,7 +1483,7 @@
 	/* look for the CD-ROM, follows the procedure in the DOS driver */
 	inb(select_unit_reg);
 	/* wait for 40 18 Hz ticks (reverse-engineered from DOS driver) */
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout((HZ+17)*40/18);
 	inb(result_reg);
 

--------------080601090508080306050102--


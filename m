Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTIISN6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbTIISN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:13:58 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:18885 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S264276AbTIISNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:13:50 -0400
Message-ID: <3F5E12EC.6040502@terra.com.br>
Date: Tue, 09 Sep 2003 14:50:36 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] blk API update (and bug fix) to CDU535 cdrom driver
References: <3F5DDEA8.6040901@terra.com.br> <20030909143341.GA18257@suse.de> <3F5DEA0D.6030701@terra.com.br> <20030909153536.GH18257@suse.de>
In-Reply-To: <20030909153536.GH18257@suse.de>
Content-Type: multipart/mixed;
 boundary="------------010902010609050908010005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010902010609050908010005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Jens,

Jens Axboe wrote:
> held! Ugh, and the request function do_cdu535_request calls
> schedule_timeout with the queue lock held (that is held when that
> function is entered), that is very buggy as well. Should also use
> set_current_state() right above that call, not open code it (that also
> misses a memory barrier). Same function also has problems with request
> handling. You should kill:
> 
> 	if (!(req->flags & REQ_CMD))
> 		continue;       /* FIXME */
> 
> that is very broken, make that:
> 
> 	if (!blk_fs_request(req)) {
> 		end_request(req, 0);
> 		continue;
> 	}
> 
> and kill these two lines:
> 
> 	if (rq_data_dir(req) != READ)
> 		panic("Unknown SONY CD cmd");
> 
> they are screwy too.
> 
> Care to fix the things I outlined above?

	This patch I think fixes all these, doesn't it?

	It applies on top of my latest cli-sti-removal patch that I sent you.

	The only place I'm not sure is on releasing the queue lock before 
calling schedule_timeout.

	Please apply if it looks good to you.

	Thanks for all your help!

Felipe

--------------010902010609050908010005
Content-Type: text/plain;
 name="cdu535.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdu535.patch"

--- linux-2.6.0-test5/drivers/cdrom/sonycd535.c	Tue Sep  9 14:42:52 2003
+++ linux-2.6.0-test5-fwd/drivers/cdrom/sonycd535.c	Tue Sep  9 14:41:30 2003
@@ -812,14 +812,14 @@
 
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
@@ -896,8 +896,10 @@
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
@@ -1481,7 +1483,7 @@
 	/* look for the CD-ROM, follows the procedure in the DOS driver */
 	inb(select_unit_reg);
 	/* wait for 40 18 Hz ticks (reverse-engineered from DOS driver) */
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout((HZ+17)*40/18);
 	inb(result_reg);
 

--------------010902010609050908010005--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264589AbTE1H1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTE1H1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:27:51 -0400
Received: from fyserv1.fy.chalmers.se ([129.16.110.66]:37822 "EHLO
	fyserv1.fy.chalmers.se") by vger.kernel.org with ESMTP
	id S264589AbTE1H1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:27:49 -0400
Message-ID: <3ED4681A.738DA3C6@fy.chalmers.se>
Date: Wed, 28 May 2003 09:41:14 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de
Subject: 2.5.69-70 ide-cd to guarantee fault-free CD/DVD burning experience?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux is setting new landmarks all the time. Linux 2.5 is taking CD/DVD
burning to whole new level by *guaranteeing* fault-free burning
experience. No more hassle with overburns, underruns, poorly supported
media, positioning errors, power calibration failures, you name it...
It just works [by keeping the user-land totally unaware of errors
conditions raised by the logical unit]. Welcome to the future:-)

Well, I'm probably pushing this joke too far:-) In such case accept the
apologies along with this patch which makes it possible to access the
sense data returned by IDE CD/DVD units from user-land with SG_IO ioctl.
As for the last part, req->data?req->data:req->buffer. I'm not sure if
it's "the right thing(tm)" to do, but an error condition (dereferencing
of NULL pointer to be specific) is raised otherwise, whenever call to
bio_map_user in drivers/block/scsi_ioctl.c fails. The patch is
applicable at least to 2.5.69 and 2.5.70.

As for 69-ac. SG_IO doesn't work there at all (kernel logs "confused,
missing data" and then "N residual after xfer"). As far as I can tell
drivers/block/scsi_ioctl.c needs a "face lift," but that's AC's(?)
concern.

As for scsi_ioctl.c in more general sense. It apparently doesn't comply
with SG HOWTO, in particular it mis-interprets time-out values.
Background information and patch is available at
http://fy.chalmers.se/~appro/linux/DVD+RW/scsi_ioctl-2.5.69.patch.
There're couple of other issues, usage of 'bytes' variable in access_ok
and DMA being off when bio_map_user fails, that needs some further
discussion in my opinion. As for discussion. Please note that I'm not
on the linux-kernel list so that keep me on Cc:.

Cheers. A.
8<--------8<--------8<--------8<--------8<--------8<--------8<--------
--- ./drivers/ide/ide-cd.c.orig	Mon May  5 01:53:14 2003
+++ ./drivers/ide/ide-cd.c	Mon May 26 17:06:09 2003
@@ -667,7 +667,8 @@
 		void *sense = &info->sense_data;
 		
 		if (failed && failed->sense)
-			sense = failed->sense;
+			sense = failed->sense,
+			failed->sense_len=rq->sense_len;
 
 		cdrom_analyze_sense_data(drive, failed, sense);
 	}
@@ -723,7 +724,7 @@
 		 * scsi status byte
 		 */
 		if ((rq->flags & REQ_BLOCK_PC) && !rq->errors)
-			rq->errors = CHECK_CONDITION;
+			rq->errors = CHECK_CONDITION<<1;
 
 		/* Check for tray open. */
 		if (sense_key == NOT_READY) {
@@ -1471,8 +1472,13 @@
 		/* Keep count of how much data we've moved. */
 		rq->data += thislen;
 		rq->data_len -= thislen;
+#if 0
 		if (rq->cmd[0] == GPCMD_REQUEST_SENSE)
 			rq->sense_len++;
+#else
+		if (rq->flags & REQ_SENSE)
+			rq->sense_len+=thislen;
+#endif
 	} else {
 confused:
 		printk ("%s: cdrom_pc_intr: The drive "
@@ -1609,7 +1615,7 @@
 
 static void post_transform_command(struct request *req)
 {
-	char *ibuf = req->buffer;
+	char *ibuf = req->data?req->data:req->buffer;
 	u8 *c = req->cmd;
 
 	if (!blk_pc_request(req))

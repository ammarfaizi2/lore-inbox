Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263559AbTHWB0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 21:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTHWB0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 21:26:24 -0400
Received: from codepoet.org ([166.70.99.138]:641 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S263559AbTHWB0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 21:26:08 -0400
Date: Fri, 22 Aug 2003 19:26:09 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix cdrom error handling in 2.4
Message-ID: <20030823012609.GB6076@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In both 2.4 and in 2.6, error handling for bad cdrom media is
wrong.  And it is my fault I'm afraid, since I botched an earlier
fix for the problem by putting the fix in the wrong spot.

My kids have a "Jumpstart Toddlers" cd they have long since
completely killed, which makes a great test disc.  Without this
fix, the best time projection I can get for completing a dd type
sector copy is about 2 years...  Most of that is spent thrashing
about in kernel space trying to re-read sectors we already know
are not correctable....  After the fix, I was able to rip a copy
the CD (or rather muddle through it getting lots of EIO errors)
in about 15 minutes.

Attached is the fix for 2.4.x, which just moves the MEDIUM_ERROR
handler a bit earlier.  I have also included a minor error path
cleanup from the 2.6.x driver,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- linux/drivers/ide/ide-cd.c.orig	2003-08-22 18:48:07.000000000 -0600
+++ linux/drivers/ide/ide-cd.c	2003-08-22 18:49:07.000000000 -0600
@@ -765,6 +765,8 @@
 		if ((stat & ERR_STAT) != 0)
 			cdrom_queue_request_sense(drive, wait, pc->sense, pc);
 	} else if (blk_fs_request(rq)) {
+		int do_end_request = 0;
+
 		/* Handle errors from READ and WRITE requests. */
 
 		if (sense_key == NOT_READY) {
@@ -773,7 +775,7 @@
 
 			/* Fail the request. */
 			printk ("%s: tray open\n", drive->name);
-			cdrom_end_request(drive, 0);
+			do_end_request = 1;
 		} else if (sense_key == UNIT_ATTENTION) {
 			/* Media change. */
 			cdrom_saw_media_change (drive);
@@ -782,28 +784,31 @@
 			   But be sure to give up if we've retried
 			   too many times. */
 			if (++rq->errors > ERROR_MAX)
-				cdrom_end_request(drive, 0);
+				do_end_request = 1;
 		} else if (sense_key == ILLEGAL_REQUEST ||
 			   sense_key == DATA_PROTECT) {
 			/* No point in retrying after an illegal
 			   request or data protect error.*/
 			ide_dump_status (drive, "command error", stat);
-			cdrom_end_request(drive, 0);
+			do_end_request = 1;
+		} else if (sense_key == MEDIUM_ERROR) {
+			/* No point in re-trying a zillion times on a bad 
+			 * sector...  If we got here the error is not correctable */
+			ide_dump_status (drive, "media error (bad sector)", stat);
+			do_end_request = 1;
 		} else if ((err & ~ABRT_ERR) != 0) {
 			/* Go to the default handler
 			   for other errors. */
 			*startstop = DRIVER(drive)->error(drive, "cdrom_decode_status", stat);
 			return 1;
-		} else if (sense_key == MEDIUM_ERROR) {
-			/* No point in re-trying a zillion times on a bad 
-			 * sector...  If we got here the error is not correctable */
-			ide_dump_status (drive, "media error (bad sector)", stat);
-			cdrom_end_request(drive, 0);
 		} else if ((++rq->errors > ERROR_MAX)) {
 			/* We've racked up too many retries.  Abort. */
-			cdrom_end_request(drive, 0);
+			do_end_request = 1;
 		}
 
+		if (do_end_request)
+			cdrom_end_request(drive, 0);
+
 		/* If we got a CHECK_CONDITION status,
 		   queue a request sense command. */
 		if ((stat & ERR_STAT) != 0)

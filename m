Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTHWBV5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 21:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTHWBV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 21:21:56 -0400
Received: from codepoet.org ([166.70.99.138]:64640 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262665AbTHWBVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 21:21:41 -0400
Date: Fri, 22 Aug 2003 19:21:42 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix cdrom error handling in 2.6
Message-ID: <20030823012142.GA6076@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
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

Attached is the fix for 2.6.x,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- linux-2.6.0-test3/drivers/ide/ide-cd.c.orig	2003-08-22 19:04:36.000000000 -0600
+++ linux-2.6.0-test3/drivers/ide/ide-cd.c	2003-08-22 19:04:49.000000000 -0600
@@ -794,16 +794,16 @@
 			   request or data protect error.*/
 			ide_dump_status (drive, "command error", stat);
 			do_end_request = 1;
-		} else if ((err & ~ABRT_ERR) != 0) {
-			/* Go to the default handler
-			   for other errors. */
-			DRIVER(drive)->error(drive, "cdrom_decode_status",stat);
-			return 1;
 		} else if (sense_key == MEDIUM_ERROR) {
 			/* No point in re-trying a zillion times on a bad 
 			 * sector...  If we got here the error is not correctable */
 			ide_dump_status (drive, "media error (bad sector)", stat);
 			do_end_request = 1;
+		} else if ((err & ~ABRT_ERR) != 0) {
+			/* Go to the default handler
+			   for other errors. */
+			DRIVER(drive)->error(drive, "cdrom_decode_status",stat);
+			return 1;
 		} else if ((++rq->errors > ERROR_MAX)) {
 			/* We've racked up too many retries.  Abort. */
 			do_end_request = 1;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUL3UfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUL3UfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 15:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbUL3UfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 15:35:17 -0500
Received: from mail.aknet.ru ([217.67.122.194]:31755 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261712AbUL3UfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 15:35:05 -0500
Message-ID: <41D46677.3020301@aknet.ru>
Date: Thu, 30 Dec 2004 23:35:03 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Alexander Kern <alex.kern@gmx.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: bug: cd-rom autoclose no longer works (fix attempt)
References: <200412301853.48677.alex.kern@gmx.de> <41D4483C.9030005@aknet.ru> <200412302053.00850.alex.kern@gmx.de>
In-Reply-To: <200412302053.00850.alex.kern@gmx.de>
Content-Type: multipart/mixed;
 boundary="------------090500000100070808090503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090500000100070808090503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Alexander Kern wrote:
> Can agree with you, but a modern cdrom should be able to konwn, is it open or 
> not. This patch change basic behaviour for all cdroms.
But I think those modern cdroms will
return 1 or 2 but not 0, in which case
my patch should not affect them. This
is of course something I can't say for
sure, just assuming.

> Old behaviour has another problems, and revert to 2.4.20 code base is a bad 
> solution.
Very probably. My patch was only "what
I did to get it to work again" kind of
thing.

> The patch must be minimal...
>	if (sense.sense_key == NOT_READY) {
OK, but the cdrom.c change is still needed
either. So attached is the new one. Does it
get us any closer to having this fixed?

> P.S. S Novym Godom!
OK, thanks, and to you too:)


--------------090500000100070808090503
Content-Type: text/x-patch;
 name="cd_clo1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cd_clo1.diff"

--- linux/drivers/cdrom/cdrom.c	2004-12-28 14:49:56.000000000 +0300
+++ linux/drivers/cdrom/cdrom.c	2004-12-28 14:55:09.228038640 +0300
@@ -1076,6 +1076,8 @@
 			}
 			cdinfo(CD_OPEN, "the tray is now closed.\n"); 
 		}
+		/* the door should be closed now, check for the disc */
+		ret = cdo->drive_status(cdi, CDSL_CURRENT);
 		if (ret!=CDS_DISC_OK) {
 			ret = -ENOMEDIUM;
 			goto clean_up_and_return;
--- linux/drivers/ide/ide-cd.c	2004-12-28 09:15:40.000000000 +0300
+++ linux/drivers/ide/ide-cd.c	2004-12-28 14:46:44.119826760 +0300
@@ -2744,9 +2744,9 @@
 	 */
 	if (sense.sense_key == NOT_READY) {
 		if (sense.asc == 0x3a) {
-			if (sense.ascq == 0 || sense.ascq == 1)
+			if (sense.ascq == 1)
 				return CDS_NO_DISC;
-			else if (sense.ascq == 2)
+			else if (sense.ascq == 0 || sense.ascq == 2)
 				return CDS_TRAY_OPEN;
 		}
 	}

--------------090500000100070808090503--

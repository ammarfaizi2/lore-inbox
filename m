Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVI0Nj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVI0Nj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVI0Nj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:39:27 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:8130 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S964935AbVI0Nj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:39:26 -0400
Date: Tue, 27 Sep 2005 22:38:01 +0900 (JST)
Message-Id: <20050927.223801.130240000.anemo@mba.ocn.ne.jp>
To: stern@rowland.harvard.edu
Cc: jim.ramsay@gmail.com, mdharm-kernel@one-eyed-alien.net,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [Linux-usb-users] Possible bug in usb storage (2.6.11 kernel)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.44L0.0509081637410.4545-100000@iolanthe.rowland.org>
References: <4789af9e05090813287f05e12a@mail.gmail.com>
	<Pine.LNX.4.44L0.0509081637410.4545-100000@iolanthe.rowland.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 8 Sep 2005 16:40:16 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> said:

stern> I've long thought that usb-storage should allocate its own
stern> transfer buffer for sense data.  In the past people have said,
stern> "No, don't bother, it's not really needed."  Here's a good
stern> reason for doing it.

stern> Expect a patch before long.

Did you already create the patch?  If not, how about this (against 2.6.13) ?


Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff -u linux-2.6.13/drivers/usb/storage/transport.c linux/drivers/usb/storage/transport.c
--- linux-2.6.13/drivers/usb/storage/transport.c	2005-08-29 08:41:01.000000000 +0900
+++ linux/drivers/usb/storage/transport.c	2005-09-27 18:03:32.000000000 +0900
@@ -638,7 +638,8 @@
 
 		/* use the new buffer we have */
 		old_request_buffer = srb->request_buffer;
-		srb->request_buffer = srb->sense_buffer;
+		srb->request_buffer =
+			kmalloc(max(dma_get_cache_alignment(), 18), GFP_NOIO);
 
 		/* set the buffer length for transfer */
 		old_request_bufflen = srb->request_bufflen;
@@ -655,7 +656,13 @@
 		/* issue the auto-sense command */
 		old_resid = srb->resid;
 		srb->resid = 0;
-		temp_result = us->transport(us->srb, us);
+		if (srb->request_buffer) {
+			temp_result = us->transport(us->srb, us);
+			memcpy(srb->sense_buffer, srb->request_buffer, 18);
+			kfree(srb->request_buffer);
+		} else {
+			temp_result = USB_STOR_TRANSPORT_FAILED;
+		}
 
 		/* let's clean up right away */
 		srb->resid = old_resid;


---
Atsushi Nemoto

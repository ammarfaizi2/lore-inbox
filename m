Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVBYATx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVBYATx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVBYAPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:15:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:57504 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262590AbVBYAMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:12:08 -0500
Date: Thu, 24 Feb 2005 16:11:50 -0800
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] USB: fix bug in acm's open function
Message-ID: <20050225001150.GA27481@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch for 2.6.11-rc5 that a lot of cdc-acm driver users are
clammering for.


There's a bug introduced in a cleanup which will lead
to a race making reopenings fail. This fix is by Alexander Lykanov.

Signed-off-by: Oliver Neukum <oliver@neukum.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	2005-02-19 10:02:21 +01:00
+++ b/drivers/usb/class/cdc-acm.c	2005-02-19 10:02:21 +01:00
@@ -278,15 +278,14 @@
 
 
 
-	if (acm->used) {
+	if (acm->used++) {
 		goto done;
         }
 
 	acm->ctrlurb->dev = acm->dev;
 	if (usb_submit_urb(acm->ctrlurb, GFP_KERNEL)) {
 		dbg("usb_submit_urb(ctrl irq) failed");
-		rv = -EIO;
-		goto err_out;
+		goto bail_out;
 	}
 
 	acm->readurb->dev = acm->dev;
@@ -303,7 +302,6 @@
 	tty->low_latency = 1;
 
 done:
-	acm->used++;
 err_out:
 	up(&open_sem);
 	return rv;
@@ -312,6 +310,8 @@
 	usb_kill_urb(acm->readurb);
 bail_out_and_unlink:
 	usb_kill_urb(acm->ctrlurb);
+bail_out:
+	acm->used--;
 	up(&open_sem);
 	return -EIO;
 }



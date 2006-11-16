Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162062AbWKPR5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162062AbWKPR5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 12:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162067AbWKPR5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 12:57:24 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:262 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1162063AbWKPR5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 12:57:23 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Greg KH <greg@kroah.com>
Subject: [PATCH] usb: microtek possible memleak fix
Date: Thu, 16 Nov 2006 18:57:28 +0100
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161857.31030.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This should fix possible memory leak in mts_usb_probe() on error path.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/usb/image/microtek.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- linux-2.6.19-rc5-mm2-a/drivers/usb/image/microtek.c	2006-11-08 03:24:20.000000000 +0100
+++ linux-2.6.19-rc5-mm2-b/drivers/usb/image/microtek.c	2006-11-16 18:47:41.000000000 +0100
@@ -788,15 +788,15 @@ static int mts_usb_probe(struct usb_inte
 
 	new_desc = kzalloc(sizeof(struct mts_desc), GFP_KERNEL);
 	if (!new_desc)
-		goto out;
+		goto err_0;
 
 	new_desc->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!new_desc->urb)
-		goto out_kfree;
+		goto err_1;
 
 	new_desc->context.scsi_status = kmalloc(1, GFP_KERNEL);
 	if (!new_desc->context.scsi_status)
-		goto out_kfree2;
+		goto err_2;
 
 	new_desc->usb_dev = dev;
 	new_desc->usb_intf = intf;
@@ -822,25 +822,27 @@ static int mts_usb_probe(struct usb_inte
 	new_desc->host = scsi_host_alloc(&mts_scsi_host_template,
 			sizeof(new_desc));
 	if (!new_desc->host)
-		goto out_free_urb;
+		goto err_3;
 
 	new_desc->host->hostdata[0] = (unsigned long)new_desc;
 	if (scsi_add_host(new_desc->host, NULL)) {
 		err_retval = -EIO;
-		goto out_free_urb;
+		goto err_4;
 	}
 	scsi_scan_host(new_desc->host);
 
 	usb_set_intfdata(intf, new_desc);
 	return 0;
 
- out_kfree2:
+err_4:
+	scsi_host_put(new_desc->host);
+err_3:
 	kfree(new_desc->context.scsi_status);
- out_free_urb:
+err_2:
 	usb_free_urb(new_desc->urb);
- out_kfree:
+err_1:
 	kfree(new_desc);
- out:
+err_0:
 	return err_retval;
 }
 


-- 
Regards,

	Mariusz Kozlowski

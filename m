Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbVLMIZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbVLMIZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVLMIZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:18052 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932562AbVLMIZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:06 -0500
Date: Tue, 13 Dec 2005 00:22:25 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org, oliver@neukum.org
Subject: [patch 05/26] USB: Adapt microtek driver to new scsi features
Message-ID: <20051213082225.GF5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-adapt-microtek-driver-to-new-scsi-features.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Oliver Neukum <oliver@neukum.org>

[PATCH] USB: Adapt microtek driver to new scsi features

the scsi layer now uses very short sg lists. This breaks the microtek
driver. Here is a patch fixes this and some other issues.

Signed-off-by: Oliver Neukum <oliver@neukum.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 drivers/usb/image/microtek.c |   31 +++++++++++++++++++++++++------
 drivers/usb/image/microtek.h |    2 +-
 2 files changed, 26 insertions(+), 7 deletions(-)

--- linux-2.6.14.3.orig/drivers/usb/image/microtek.c
+++ linux-2.6.14.3/drivers/usb/image/microtek.c
@@ -327,6 +327,18 @@ static inline void mts_urb_abort(struct 
 	usb_kill_urb( desc->urb );
 }
 
+static int mts_slave_alloc (struct scsi_device *s)
+{
+	s->inquiry_len = 0x24;
+	return 0;
+}
+
+static int mts_slave_configure (struct scsi_device *s)
+{
+	blk_queue_dma_alignment(s->request_queue, (512 - 1));
+	return 0;
+}
+
 static int mts_scsi_abort (Scsi_Cmnd *srb)
 {
 	struct mts_desc* desc = (struct mts_desc*)(srb->device->host->hostdata[0]);
@@ -411,7 +423,7 @@ static void mts_transfer_done( struct ur
 	MTS_INT_INIT();
 
 	context->srb->result &= MTS_SCSI_ERR_MASK;
-	context->srb->result |= (unsigned)context->status<<1;
+	context->srb->result |= (unsigned)(*context->scsi_status)<<1;
 
 	mts_transfer_cleanup(transfer);
 
@@ -427,7 +439,7 @@ static void mts_get_status( struct urb *
 	mts_int_submit_urb(transfer,
 			   usb_rcvbulkpipe(context->instance->usb_dev,
 					   context->instance->ep_response),
-			   &context->status,
+			   context->scsi_status,
 			   1,
 			   mts_transfer_done );
 }
@@ -481,7 +493,7 @@ static void mts_command_done( struct urb
 					   context->data_pipe,
 					   context->data,
 					   context->data_length,
-					   context->srb->use_sg ? mts_do_sg : mts_data_done);
+					   context->srb->use_sg > 1 ? mts_do_sg : mts_data_done);
 		} else {
 			mts_get_status(transfer);
 		}
@@ -627,7 +639,6 @@ int mts_scsi_queuecommand( Scsi_Cmnd *sr
 			callback(srb);
 
 	}
-
 out:
 	return err;
 }
@@ -645,6 +656,9 @@ static Scsi_Host_Template mts_scsi_host_
 	.cmd_per_lun =		1,
 	.use_clustering =	1,
 	.emulated =		1,
+	.slave_alloc =		mts_slave_alloc,
+	.slave_configure =	mts_slave_configure,
+	.max_sectors=		256, /* 128 K */
 };
 
 struct vendor_product
@@ -782,6 +796,10 @@ static int mts_usb_probe(struct usb_inte
 	if (!new_desc->urb)
 		goto out_kfree;
 
+	new_desc->context.scsi_status = kmalloc(1, GFP_KERNEL);
+	if (!new_desc->context.scsi_status)
+		goto out_kfree2;
+
 	new_desc->usb_dev = dev;
 	new_desc->usb_intf = intf;
 	init_MUTEX(&new_desc->lock);
@@ -818,6 +836,8 @@ static int mts_usb_probe(struct usb_inte
 	usb_set_intfdata(intf, new_desc);
 	return 0;
 
+ out_kfree2:
+	kfree(new_desc->context.scsi_status);
  out_free_urb:
 	usb_free_urb(new_desc->urb);
  out_kfree:
@@ -837,6 +857,7 @@ static void mts_usb_disconnect (struct u
 
 	scsi_host_put(desc->host);
 	usb_free_urb(desc->urb);
+	kfree(desc->context.scsi_status);
 	kfree(desc);
 }
 
@@ -857,5 +878,3 @@ module_exit(microtek_drv_exit);
 MODULE_AUTHOR( DRIVER_AUTHOR );
 MODULE_DESCRIPTION( DRIVER_DESC );
 MODULE_LICENSE("GPL");
-
-
--- linux-2.6.14.3.orig/drivers/usb/image/microtek.h
+++ linux-2.6.14.3/drivers/usb/image/microtek.h
@@ -22,7 +22,7 @@ struct mts_transfer_context
 	int data_pipe;
 	int fragment;
 
-	u8 status; /* status returned from ep_response after command completion */
+	u8 *scsi_status; /* status returned from ep_response after command completion */
 };
 
 

--

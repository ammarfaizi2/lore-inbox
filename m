Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752089AbWCBXdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbWCBXdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbWCBXdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:33:22 -0500
Received: from mx1.suse.de ([195.135.220.2]:30153 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752091AbWCBXdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:33:21 -0500
Date: Fri, 3 Mar 2006 00:33:15 +0100
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Bachem <info@colognechip.com>
Subject: [PATCH] fix compatiblity issue with big endian systems
Message-ID: <20060302233315.GC17717@pingi.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Martin Bachem <info@colognechip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix some compatiblity issues with big endian systems

Signed-off-by: Martin Bachem <info@colognechip.com>
Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/hisax/hfc_usb.c |   34 ++++++++++++++--------------------
 1 files changed, 14 insertions(+), 20 deletions(-)

ad3cb7a142abfc0de4f4428f9458ff7c26529878
diff --git a/drivers/isdn/hisax/hfc_usb.c b/drivers/isdn/hisax/hfc_usb.c
index ca5b4a3..67e5a8d 100644
--- a/drivers/isdn/hisax/hfc_usb.c
+++ b/drivers/isdn/hisax/hfc_usb.c
@@ -1,7 +1,7 @@
 /*
  * hfc_usb.c
  *
- * $Id: hfc_usb.c,v 4.36 2005/04/08 09:55:13 martinb1 Exp $
+ * $Id: hfc_usb.c,v 2.3.2.13 2006/02/17 17:17:22 mbachem Exp $
  *
  * modular HiSax ISDN driver for Colognechip HFC-S USB chip
  *
@@ -45,7 +45,7 @@
 #include "hfc_usb.h"
 
 static const char *hfcusb_revision =
-    "$Revision: 4.36 $ $Date: 2005/04/08 09:55:13 $ ";
+    "$Revision: 2.3.2.13 $ $Date: 2006/02/17 17:17:22 $ ";
 
 /* Hisax debug support
 * use "modprobe debug=x" where x is bitfield of USB_DBG & ISDN_DBG
@@ -219,7 +219,7 @@ symbolic(struct hfcusb_symbolic_list lis
 	for (i = 0; list[i].name != NULL; i++)
 		if (list[i].num == num)
 			return (list[i].name);
-	return "<unkown ERROR>";
+	return "<unknown ERROR>";
 }
 
 
@@ -235,9 +235,9 @@ ctrl_start_transfer(hfcusb_data * hfc)
 		hfc->ctrl_urb->transfer_buffer = NULL;
 		hfc->ctrl_urb->transfer_buffer_length = 0;
 		hfc->ctrl_write.wIndex =
-		    hfc->ctrl_buff[hfc->ctrl_out_idx].hfc_reg;
+		    cpu_to_le16(hfc->ctrl_buff[hfc->ctrl_out_idx].hfc_reg);
 		hfc->ctrl_write.wValue =
-		    hfc->ctrl_buff[hfc->ctrl_out_idx].reg_val;
+		    cpu_to_le16(hfc->ctrl_buff[hfc->ctrl_out_idx].reg_val);
 
 		usb_submit_urb(hfc->ctrl_urb, GFP_ATOMIC);	/* start transfer */
 	}
@@ -1282,7 +1282,7 @@ usb_init(hfcusb_data * hfc)
 	/* init the background machinery for control requests */
 	hfc->ctrl_read.bRequestType = 0xc0;
 	hfc->ctrl_read.bRequest = 1;
-	hfc->ctrl_read.wLength = 1;
+	hfc->ctrl_read.wLength = cpu_to_le16(1);
 	hfc->ctrl_write.bRequestType = 0x40;
 	hfc->ctrl_write.bRequest = 0;
 	hfc->ctrl_write.wLength = 0;
@@ -1373,14 +1373,13 @@ hfc_usb_probe(struct usb_interface *intf
 
 	vend_idx = 0xffff;
 	for (i = 0; hfcusb_idtab[i].idVendor; i++) {
-		if (dev->descriptor.idVendor == hfcusb_idtab[i].idVendor
-		    && dev->descriptor.idProduct ==
-		    hfcusb_idtab[i].idProduct) {
+		if ((le16_to_cpu(dev->descriptor.idVendor) == hfcusb_idtab[i].idVendor)
+		    && (le16_to_cpu(dev->descriptor.idProduct) == hfcusb_idtab[i].idProduct)) {
 			vend_idx = i;
 			continue;
 		}
 	}
-
+	
 #ifdef CONFIG_HISAX_DEBUG
 	DBG(USB_DBG,
 	    "HFC-USB: probing interface(%d) actalt(%d) minor(%d)\n", ifnum,
@@ -1516,8 +1515,7 @@ hfc_usb_probe(struct usb_interface *intf
 							    usb_transfer_mode
 							    = USB_INT;
 							packet_size =
-							    ep->desc.
-							    wMaxPacketSize;
+							    le16_to_cpu(ep->desc.wMaxPacketSize);
 							break;
 						case USB_ENDPOINT_XFER_BULK:
 							if (ep_addr & 0x80)
@@ -1545,8 +1543,7 @@ hfc_usb_probe(struct usb_interface *intf
 							    usb_transfer_mode
 							    = USB_BULK;
 							packet_size =
-							    ep->desc.
-							    wMaxPacketSize;
+							    le16_to_cpu(ep->desc.wMaxPacketSize);
 							break;
 						case USB_ENDPOINT_XFER_ISOC:
 							if (ep_addr & 0x80)
@@ -1574,8 +1571,7 @@ hfc_usb_probe(struct usb_interface *intf
 							    usb_transfer_mode
 							    = USB_ISOC;
 							iso_packet_size =
-							    ep->desc.
-							    wMaxPacketSize;
+							    le16_to_cpu(ep->desc.wMaxPacketSize);
 							break;
 						default:
 							context->
@@ -1588,10 +1584,8 @@ hfc_usb_probe(struct usb_interface *intf
 						    fifonum = cidx;
 						context->fifos[cidx].hfc =
 						    context;
-						context->fifos[cidx].
-						    usb_packet_maxlen =
-						    ep->desc.
-						    wMaxPacketSize;
+						context->fifos[cidx].usb_packet_maxlen =
+						    le16_to_cpu(ep->desc.wMaxPacketSize);
 						context->fifos[cidx].
 						    intervall =
 						    ep->desc.bInterval;
-- 
1.1.1

-- 
Karsten Keil
SuSE Labs
ISDN development

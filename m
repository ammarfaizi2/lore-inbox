Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHUWB>; Thu, 8 Feb 2001 15:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBHUVv>; Thu, 8 Feb 2001 15:21:51 -0500
Received: from mail15.jump.net ([206.196.91.15]:62183 "EHLO mail15.jump.net")
	by vger.kernel.org with ESMTP id <S129031AbRBHUVu>;
	Thu, 8 Feb 2001 15:21:50 -0500
Message-ID: <3A82FFE9.809E3AC@sgi.com>
Date: Thu, 08 Feb 2001 14:22:01 -0600
From: Eric Sandeen <sandeen@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-XFS i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [NEW][PATCH] updates for KLSI
In-Reply-To: <3A80ED7C.F3A92D5@sgi.com> <20010207005126.A32480@wirex.com>
Content-Type: multipart/mixed;
 boundary="------------E91D8345F2FB09CBC3E05266"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E91D8345F2FB09CBC3E05266
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Greg KH wrote:

> Silently changing descriptor ids while connected is just asking for
> trouble :)

Ok, fair enough - here's a patch against 2.4.1-ac6 which causes the
device to disconnect/reconnect after firmware load (and a couple other
minor kernel logging & formatting cleanups, plus one more device ID).

-Eric
--------------E91D8345F2FB09CBC3E05266
Content-Type: text/plain; charset=us-ascii;
 name="KLSI-2.4.1-ac6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="KLSI-2.4.1-ac6.patch"

--- linux/drivers/usb/kaweth.c.ac6	Thu Feb  8 10:47:40 2001
+++ linux/drivers/usb/kaweth.c	Thu Feb  8 11:08:16 2001
@@ -131,6 +131,7 @@
 	{ USB_DEVICE(0x066b, 0x2202) }, /* Linksys USB10T */ 
 	{ USB_DEVICE(0x1645, 0x0005) }, /* Entrega E45 */ 
 	{ USB_DEVICE(0x2001, 0x4000) }, /* D-link DSB-650C */
+	{ USB_DEVICE(0x07b8, 0x4000) }, /* D-Link DU-E10 */
 	{} /* Null terminator */
 };
 
@@ -647,9 +648,10 @@
 	if (net->flags & IFF_PROMISC) {
 		packet_filter_bitmap |= KAWETH_PACKET_FILTER_PROMISCUOUS;
 	} 
-	else if ((net->mc_count) ||  (net->flags & IFF_ALLMULTI)) {
+	else if ((net->mc_count) || (net->flags & IFF_ALLMULTI)) {
 		packet_filter_bitmap |= KAWETH_PACKET_FILTER_ALL_MULTICAST;
 	}
+
 	kaweth->packet_filter_bitmap = packet_filter_bitmap;
 	netif_wake_queue(net);
 }
@@ -721,11 +723,7 @@
 	const eth_addr_t bcast_addr = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 	int result = 0;
 
-	result = usb_get_device_descriptor(dev);
-	if (result < 0)
-		kaweth_err("Error re-loading device descriptor");
-	
-	kaweth_dbg("Kawasaki Device Probe (Device number:%d): 0x%4.4x:0x%4.4x revision 0x%4.4x",
+	kaweth_dbg("Kawasaki Device Probe (Device number:%d): 0x%4.4x:0x%4.4x:0x%4.4x",
 		 dev->devnum, 
 		 (int)dev->descriptor.idVendor, 
 		 (int)dev->descriptor.idProduct,
@@ -754,52 +752,65 @@
 	kaweth_reset(kaweth);
 
 	/*
-	 * If we got bcdDevice 0x0202, firmware is already present,
-	 * don't try to download again.
+	 * If high byte of bcdDevice is nonzero, firmware is already
+	 * downloaded. Don't try to do it again, or we'll hang the device.
 	 */
 
-	if ((int)dev->descriptor.bcdDevice != 0x0202) {
-
-		if((result = kaweth_download_firmware(kaweth, 
+	if (dev->descriptor.bcdDevice >> 8) {
+		kaweth_info("Firmware present in device.");
+	} else {
+		/* Download the firmware */
+		kaweth_info("Downloading firmware...");
+		if ((result = kaweth_download_firmware(kaweth, 
 						      kaweth_new_code, 
 						      len_kaweth_new_code, 
 						      100, 
-						      2)) < 0){
-			kaweth_err("Error downloading firmware (%d), no net device created", result);
+						      2)) < 0) {
+			kaweth_err("Error downloading firmware (%d)", result);
 			kfree(kaweth);
 			return NULL;
 		}
 
-		if((result = kaweth_download_firmware(kaweth, 
+		if ((result = kaweth_download_firmware(kaweth, 
 						      kaweth_new_code_fix, 
 						      len_kaweth_new_code_fix, 
 						      100, 
 						      3)) < 0) {
-			kaweth_err("Error downloading firmware fix (%d), no net device created", result);
+			kaweth_err("Error downloading firmware fix (%d)", result);
 			kfree(kaweth);
 			return NULL;
 		}
 
-		if((result = kaweth_trigger_firmware(kaweth, 100)) < 0){
-			kaweth_err("Error triggering firmware (%d), no net device created\n", result);
+		if ((result = kaweth_download_firmware(kaweth,
+						      kaweth_trigger_code,
+						      len_kaweth_trigger_code,
+						      126,
+						      2)) < 0) {
+			kaweth_err("Error downloading trigger code (%d)", result);
 			kfree(kaweth);
 			return NULL;
 		}
 
-		udelay(1000);
+		if ((result = kaweth_download_firmware(kaweth,
+						      kaweth_trigger_code_fix,
+						      len_kaweth_trigger_code_fix,
+						      126,
+						      3)) < 0) {
+			kaweth_err("Error downloading trigger code fix (%d)", result);
+			kfree(kaweth);
+			return NULL;
+		}
 
-		kaweth_dbg("Resetting device (jiffies: %lx)", jiffies);
 
-		if(kaweth_reset(kaweth)) {
-			kaweth_err("Error resetting device\n");
+		if ((result = kaweth_trigger_firmware(kaweth, 126)) < 0) {
+			kaweth_err("Error triggering firmware (%d)", result);
 			kfree(kaweth);
 			return NULL;
 		}
 
-		kaweth_dbg("Reset device (jiffies: %lx)", jiffies);
-
-	} else {
-		kaweth_dbg("Firmware already present");
+		/* Device will now disappear for a moment...  */
+		kaweth_info("Firmware loaded.  I'll be back...");
+		return NULL;
 	}
 
 	result = kaweth_read_configuration(kaweth);

--------------E91D8345F2FB09CBC3E05266--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVCAAkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVCAAkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVCAAj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:39:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24331 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261157AbVCAAiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:38:00 -0500
Date: Tue, 1 Mar 2005 01:37:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mdharm-usb@one-eyed-alien.net
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/storage/: cleanups
Message-ID: <20050301003758.GB4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- scsiglue.c: remove the unused usb_stor_sense_notready

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/storage/scsiglue.c      |    9 ---------
 drivers/usb/storage/scsiglue.h      |    1 -
 drivers/usb/storage/shuttle_usbat.c |   13 ++++++++-----
 drivers/usb/storage/shuttle_usbat.h |    4 ----
 drivers/usb/storage/transport.c     |    5 +++--
 drivers/usb/storage/transport.h     |    5 -----
 drivers/usb/storage/usb.c           |    4 ++--
 drivers/usb/storage/usb.h           |    3 ---
 8 files changed, 13 insertions(+), 31 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/usb/storage/scsiglue.h.old	2005-02-28 23:17:23.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/storage/scsiglue.h	2005-02-28 23:18:41.000000000 +0100
@@ -48,7 +48,6 @@
 
 extern void usb_stor_report_device_reset(struct us_data *us);
 
-extern unsigned char usb_stor_sense_notready[18];
 extern unsigned char usb_stor_sense_invalidCDB[18];
 extern struct scsi_host_template usb_stor_host_template;
 
--- linux-2.6.11-rc4-mm1-full/drivers/usb/storage/scsiglue.c.old	2005-02-28 23:18:51.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/storage/scsiglue.c	2005-02-28 23:19:00.000000000 +0100
@@ -477,15 +477,6 @@
 	.module =			THIS_MODULE
 };
 
-/* For a device that is "Not Ready" */
-unsigned char usb_stor_sense_notready[18] = {
-	[0]	= 0x70,			    /* current error */
-	[2]	= 0x02,			    /* not ready */
-	[7]	= 0x0a,			    /* additional length */
-	[12]	= 0x04,			    /* not ready */
-	[13]	= 0x03			    /* manual intervention */
-};
-
 /* To Report "Illegal Request: Invalid Field in CDB */
 unsigned char usb_stor_sense_invalidCDB[18] = {
 	[0]	= 0x70,			    /* current error */
--- linux-2.6.11-rc4-mm1-full/drivers/usb/storage/shuttle_usbat.h.old	2005-02-28 23:20:36.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/storage/shuttle_usbat.h	2005-02-28 23:20:55.000000000 +0100
@@ -105,10 +105,6 @@
 #define USBAT_FEAT_ET1	0x02
 #define USBAT_FEAT_ET2	0x01
 
-/* Transport functions */
-int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us);
-int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us);
-
 extern int usbat_transport(struct scsi_cmnd *srb, struct us_data *us);
 extern int init_usbat(struct us_data *us);
 
--- linux-2.6.11-rc4-mm1-full/drivers/usb/storage/shuttle_usbat.c.old	2005-02-28 23:19:48.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/storage/shuttle_usbat.c	2005-02-28 23:22:52.000000000 +0100
@@ -61,7 +61,10 @@
 #define LSB_of(s) ((s)&0xFF)
 #define MSB_of(s) ((s)>>8)
 
-int transferred = 0;
+static int transferred = 0;
+
+static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us);
+static int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us);
 
 /*
  * Convenience function to produce an ATAPI read/write sectors command
@@ -872,8 +875,8 @@
 /*
  * Set the transport function based on the device type
  */
-int usbat_set_transport(struct us_data *us,
-			struct usbat_info *info)
+static int usbat_set_transport(struct us_data *us,
+			       struct usbat_info *info)
 {
 	int rc;
 
@@ -1417,7 +1420,7 @@
 /*
  * Transport for the HP 8200e
  */
-int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us)
+static int usbat_hp8200e_transport(struct scsi_cmnd *srb, struct us_data *us)
 {
 	int result;
 	unsigned char *status = us->iobuf;
@@ -1560,7 +1563,7 @@
 /*
  * Transport for USBAT02-based CompactFlash and similar storage devices
  */
-int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
+static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
 {
 	int rc;
 	struct usbat_info *info = (struct usbat_info *) (us->extra);
--- linux-2.6.11-rc4-mm1-full/drivers/usb/storage/transport.h.old	2005-02-28 23:23:10.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/storage/transport.h	2005-02-28 23:23:56.000000000 +0100
@@ -169,13 +169,8 @@
 extern int usb_stor_ctrl_transfer(struct us_data *us, unsigned int pipe,
 		u8 request, u8 requesttype, u16 value, u16 index,
 		void *data, u16 size);
-extern int usb_stor_intr_transfer(struct us_data *us, void *buf,
-		unsigned int length);
 extern int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
 		void *buf, unsigned int length, unsigned int *act_len);
-extern int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
-		struct scatterlist *sg, int num_sg, unsigned int length,
-		unsigned int *act_len);
 extern int usb_stor_bulk_transfer_sg(struct us_data *us, unsigned int pipe,
 		void *buf, unsigned int length, int use_sg, int *residual);
 
--- linux-2.6.11-rc4-mm1-full/drivers/usb/storage/transport.c.old	2005-02-28 23:23:25.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/storage/transport.c	2005-02-28 23:24:26.000000000 +0100
@@ -383,7 +383,8 @@
  * This routine always uses us->recv_intr_pipe as the pipe and
  * us->ep_bInterval as the interrupt interval.
  */
-int usb_stor_intr_transfer(struct us_data *us, void *buf, unsigned int length)
+static int usb_stor_intr_transfer(struct us_data *us, void *buf,
+				  unsigned int length)
 {
 	int result;
 	unsigned int pipe = us->recv_intr_pipe;
@@ -436,7 +437,7 @@
  * This function does basically the same thing as usb_stor_bulk_transfer_buf()
  * above, but it uses the usbcore scatter-gather library.
  */
-int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
+static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
 		struct scatterlist *sg, int num_sg, unsigned int length,
 		unsigned int *act_len)
 {
--- linux-2.6.11-rc4-mm1-full/drivers/usb/storage/usb.h.old	2005-02-28 23:26:08.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/storage/usb.h	2005-02-28 23:26:12.000000000 +0100
@@ -167,9 +167,6 @@
 	extra_data_destructor	extra_destructor;/* extra data destructor   */
 };
 
-/* The structure which defines our driver */
-extern struct usb_driver usb_storage_driver;
-
 /* Function to fill an inquiry response. See usb.c for details */
 extern void fill_inquiry_response(struct us_data *us,
 	unsigned char *data, unsigned int data_len);
--- linux-2.6.11-rc4-mm1-full/drivers/usb/storage/usb.c.old	2005-02-28 23:25:13.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/storage/usb.c	2005-02-28 23:25:58.000000000 +0100
@@ -225,7 +225,7 @@
 	{ NULL }
 };
 
-struct usb_driver usb_storage_driver = {
+static struct usb_driver usb_storage_driver = {
 	.owner =	THIS_MODULE,
 	.name =		"usb-storage",
 	.probe =	storage_probe,
@@ -811,7 +811,7 @@
 }
 
 /* Release all our dynamic resources */
-void usb_stor_release_resources(struct us_data *us)
+static void usb_stor_release_resources(struct us_data *us)
 {
 	US_DEBUGP("-- %s\n", __FUNCTION__);
 


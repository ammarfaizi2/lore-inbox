Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWAFC2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWAFC2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWAFC2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:28:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14343 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932605AbWAFC2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:28:52 -0500
Date: Fri, 6 Jan 2006 03:28:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mmcclell@bigfoot.com
Cc: linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/media/ov511.c: remove hooks for the decomp module
Message-ID: <20060106022852.GW12313@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- the decomp module is not intended for inclusion into the kernel
- people using the decomp module from upstream will usually simply use
  the complete upstream 2.xx driver

Therefore, there seems to be no good reason spending some bytes of 
kernel memory for hooks for this module.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/media/ov511.c |  196 --------------------------------------
 1 file changed, 2 insertions(+), 194 deletions(-)

--- linux-2.6.15-mm1-full/drivers/usb/media/ov511.c.old	2006-01-06 02:36:25.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/usb/media/ov511.c	2006-01-06 03:00:59.000000000 +0100
@@ -204,22 +204,10 @@
 
 static struct usb_driver ov511_driver;
 
-static struct ov51x_decomp_ops *ov511_decomp_ops;
-static struct ov51x_decomp_ops *ov511_mmx_decomp_ops;
-static struct ov51x_decomp_ops *ov518_decomp_ops;
-static struct ov51x_decomp_ops *ov518_mmx_decomp_ops;
-
 /* Number of times to retry a failed I2C transaction. Increase this if you
  * are getting "Failed to read sensor ID..." */
 static const int i2c_detect_tries = 5;
 
-/* MMX support is present in kernel and CPU. Checked upon decomp module load. */
-#if defined(__i386__) || defined(__x86_64__)
-#define ov51x_mmx_available (cpu_has_mmx)
-#else
-#define ov51x_mmx_available (0)
-#endif
-
 static struct usb_device_id device_table [] = {
 	{ USB_DEVICE(VEND_OMNIVISION, PROD_OV511) },
 	{ USB_DEVICE(VEND_OMNIVISION, PROD_OV511PLUS) },
@@ -3012,93 +3000,18 @@
  *
  **********************************************************************/
 
-/* Chooses a decompression module, locks it, and sets ov->decomp_ops
- * accordingly. Returns -ENXIO if decompressor is not available, otherwise
- * returns 0 if no other error.
- */
 static int
 request_decompressor(struct usb_ov511 *ov)
 {
-	if (!ov)
-		return -ENODEV;
-
-	if (ov->decomp_ops) {
-		err("ERROR: Decompressor already requested!");
-		return -EINVAL;
-	}
-
-	lock_kernel();
-
-	/* Try to get MMX, and fall back on no-MMX if necessary */
-	if (ov->bclass == BCL_OV511) {
-		if (ov511_mmx_decomp_ops) {
-			PDEBUG(3, "Using OV511 MMX decompressor");
-			ov->decomp_ops = ov511_mmx_decomp_ops;
-		} else if (ov511_decomp_ops) {
-			PDEBUG(3, "Using OV511 decompressor");
-			ov->decomp_ops = ov511_decomp_ops;
-		} else {
-			err("No decompressor available");
-		}
-	} else if (ov->bclass == BCL_OV518) {
-		if (ov518_mmx_decomp_ops) {
-			PDEBUG(3, "Using OV518 MMX decompressor");
-			ov->decomp_ops = ov518_mmx_decomp_ops;
-		} else if (ov518_decomp_ops) {
-			PDEBUG(3, "Using OV518 decompressor");
-			ov->decomp_ops = ov518_decomp_ops;
-		} else {
-			err("No decompressor available");
-		}
+	if (ov->bclass == BCL_OV511 || ov->bclass == BCL_OV518) {
+		err("No decompressor available");
 	} else {
 		err("Unknown bridge");
 	}
 
-	if (!ov->decomp_ops)
-		goto nosys;
-
-	if (!ov->decomp_ops->owner) {
-		ov->decomp_ops = NULL;
-		goto nosys;
-	}
-	
-	if (!try_module_get(ov->decomp_ops->owner))
-		goto nosys;
-
-	unlock_kernel();
-	return 0;
-
- nosys:
-	unlock_kernel();
 	return -ENOSYS;
 }
 
-/* Unlocks decompression module and nulls ov->decomp_ops. Safe to call even
- * if ov->decomp_ops is NULL.
- */
-static void
-release_decompressor(struct usb_ov511 *ov)
-{
-	int released = 0;	/* Did we actually do anything? */
-
-	if (!ov)
-		return;
-
-	lock_kernel();
-
-	if (ov->decomp_ops) {
-		module_put(ov->decomp_ops->owner);
-		released = 1;
-	}
-
-	ov->decomp_ops = NULL;
-
-	unlock_kernel();
-
-	if (released)
-		PDEBUG(3, "Decompressor released");
-}
-
 static void
 decompress(struct usb_ov511 *ov, struct ov511_frame *frame,
 	   unsigned char *pIn0, unsigned char *pOut0)
@@ -3107,31 +3020,6 @@
 		if (request_decompressor(ov))
 			return;
 
-	PDEBUG(4, "Decompressing %d bytes", frame->bytes_recvd);
-
-	if (frame->format == VIDEO_PALETTE_GREY
-	    && ov->decomp_ops->decomp_400) {
-		int ret = ov->decomp_ops->decomp_400(
-			pIn0,
-			pOut0,
-			frame->compbuf,
-			frame->rawwidth,
-			frame->rawheight,
-			frame->bytes_recvd);
-		PDEBUG(4, "DEBUG: decomp_400 returned %d", ret);
-	} else if (frame->format != VIDEO_PALETTE_GREY
-		   && ov->decomp_ops->decomp_420) {
-		int ret = ov->decomp_ops->decomp_420(
-			pIn0,
-			pOut0,
-			frame->compbuf,
-			frame->rawwidth,
-			frame->rawheight,
-			frame->bytes_recvd);
-		PDEBUG(4, "DEBUG: decomp_420 returned %d", ret);
-	} else {
-		err("Decompressor does not support this format");
-	}
 }
 
 /**********************************************************************
@@ -4087,8 +3974,6 @@
 	ov->user--;
 	ov51x_stop_isoc(ov);
 
-	release_decompressor(ov);
-
 	if (ov->led_policy == LED_AUTO)
 		ov51x_led_control(ov, 0);
 
@@ -6021,82 +5906,6 @@
  *
  ***************************************************************************/
 
-/* Returns 0 for success */
-int
-ov511_register_decomp_module(int ver, struct ov51x_decomp_ops *ops, int ov518,
-			     int mmx)
-{
-	if (ver != DECOMP_INTERFACE_VER) {
-		err("Decompression module has incompatible");
-		err("interface version %d", ver);
-		err("Interface version %d is required", DECOMP_INTERFACE_VER);
-		return -EINVAL;
-	}
-
-	if (!ops)
-		return -EFAULT;
-
-	if (mmx && !ov51x_mmx_available) {
-		err("MMX not available on this system or kernel");
-		return -EINVAL;
-	}
-
-	lock_kernel();
-
-	if (ov518) {
-		if (mmx) {
-			if (ov518_mmx_decomp_ops)
-				goto err_in_use;
-			else
-				ov518_mmx_decomp_ops = ops;
-		} else {
-			if (ov518_decomp_ops)
-				goto err_in_use;
-			else
-				ov518_decomp_ops = ops;
-		}
-	} else {
-		if (mmx) {
-			if (ov511_mmx_decomp_ops)
-				goto err_in_use;
-			else
-				ov511_mmx_decomp_ops = ops;
-		} else {
-			if (ov511_decomp_ops)
-				goto err_in_use;
-			else
-				ov511_decomp_ops = ops;
-		}
-	}
-
-	unlock_kernel();
-	return 0;
-
-err_in_use:
-	unlock_kernel();
-	return -EBUSY;
-}
-
-void
-ov511_deregister_decomp_module(int ov518, int mmx)
-{
-	lock_kernel();
-
-	if (ov518) {
-		if (mmx)
-			ov518_mmx_decomp_ops = NULL;
-		else
-			ov518_decomp_ops = NULL;
-	} else {
-		if (mmx)
-			ov511_mmx_decomp_ops = NULL;
-		else
-			ov511_decomp_ops = NULL;
-	}
-
-	unlock_kernel();
-}
-
 static int __init
 usb_ov511_init(void)
 {
@@ -6123,5 +5932,3 @@
 module_init(usb_ov511_init);
 module_exit(usb_ov511_exit);
 
-EXPORT_SYMBOL(ov511_register_decomp_module);
-EXPORT_SYMBOL(ov511_deregister_decomp_module);


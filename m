Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUFGMTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUFGMTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUFGMSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:18:53 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7553 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264550AbUFGL4g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:36 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093542982@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093531704@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 21/39] input: Microtouch USB driver update
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.11.28, 2004-04-30 18:14:24+02:00, tejohnson@yahoo.com
  input: Microtouch USB driver update
     Changed reset from standard USB dev reset to vendor reset
     Changed data sent to host from compensated to raw coordinates
     Eliminated vendor/product module params
     Performed multiple successfull tests with an EXII-5010UC


 Documentation/usb/mtouchusb.txt |   91 +++++++++++++++-------------------
 drivers/usb/input/mtouchusb.c   |  107 +++++++++++++---------------------------
 2 files changed, 77 insertions(+), 121 deletions(-)

===================================================================

diff -Nru a/Documentation/usb/mtouchusb.txt b/Documentation/usb/mtouchusb.txt
--- a/Documentation/usb/mtouchusb.txt	2004-06-07 13:11:57 +02:00
+++ b/Documentation/usb/mtouchusb.txt	2004-06-07 13:11:57 +02:00
@@ -1,26 +1,38 @@
 CHANGES
 
-- Created based off of scanner & INSTALL from the original touchscreen
+- 0.3 - Created based off of scanner & INSTALL from the original touchscreen
   driver on freshmeat (http://freshmeat.net/projects/3mtouchscreendriver)
 - Amended for linux-2.4.18, then 2.4.19
 
-- Complete rewrite using Linux Input in 2.6.3
+- 0.5 - Complete rewrite using Linux Input in 2.6.3
    Unfortunately no calibration support at this time
 
+- 1.4 - Multiple changes to support the EXII 5000UC and house cleaning
+   Changed reset from standard USB dev reset to vendor reset
+   Changed data sent to host from compensated to raw coordinates
+   Eliminated vendor/product module params
+   Performed multiple successfull tests with an EXII-5010UC
 
-DRIVER NOTES:
+SUPPORTED HARDWARE:
+
+        All controllers have the Vendor: 0x0596 & Product: 0x0001
 
-Installation is simple, you only need to add Linux Input, Linux USB, and the 
-driver to the kernel.  The driver can also be optionally built as a module.
 
-If you have another MicroTouch device that you wish to experiment with
-or try using this driver with, but the Vendor and Product ID's are not 
-coded in, don't despair.  If the driver was compiled as a module, you can 
-pass options to the driver.  Simply try:
+        Controller Description          Part Number
+        ------------------------------------------------------
 
-  /sbin/modprobe mtouchusb vendor=0x#### product=0x****
+        USB Capacitive - Pearl Case     14-205  (Discontinued)
+        USB Capacitive - Black Case     14-124  (Discontinued)
+        USB Capacitive - No Case        14-206  (Discontinued)
+
+        USB Capacitive - Pearl Case     EXII-5010UC
+        USB Capacitive - Black Case     EXII-5030UC
+        USB Capacitive - No Case        EXII-5050UC
+
+DRIVER NOTES:
 
-If it works, send me the iVendor & iProduct (or a patch) and I will add...
+Installation is simple, you only need to add Linux Input, Linux USB, and the 
+driver to the kernel.  The driver can also be optionally built as a module.
 
 This driver appears to be one of possible 2 Linux USB Input Touchscreen
 drivers.  Although 3M produces a binary only driver available for
@@ -28,53 +40,28 @@
 touchscreen for embedded apps using QTEmbedded, DirectFB, etc. So I feel the
 logical choice is to use Linux Imput.
 
-A little info about the MicroTouch USB controller (14-206):
-
-Y is inverted, and the device has a total possible resolution of 0 - 65535.
-
-Y is inverted by the driver by:
+Currently there is no way to calibrate the device via this driver.  Even if
+the device could be calibrated, the driver pulls to raw coordinate data from
+the controller.  This means calibration must be performed within the
+userspace.
+
+The controller screen resolution is now 0 to 16384 for both X and Y reporting
+the raw touch data.  This is the same for the old and new capacitive USB
+controllers.
+
+Perhaps at some point an abstract function will be placed into evdev so 
+generic functions like calibrations, resets, and vendor information can be 
+requested from the userspace (And the drivers would handle the vendor specific
+tasks).
 
-        input.absmin[ABS_Y] =  MTOUCHUSB_MAX_YC;
-        input.absmax[ABS_Y] =  MTOUCHUSB_MIN_YC;
-
-absmin & absmax are also used to scale the data, sine it is rather high 
-resolution.
-
-    ---------------touch screen area-----------------
-    I                        MicroTouch (xmax,ymax) @I
-    I                      X                         I
-    I   ########visible monitor area##############   I
-    I   #@ (xmin,ymin)                           #   I
-    I   #                                        #   I
-    I   #                                        #   I
-    I   #                                        #   I
-    I   #                                        #   I
-    I   #                                        #   I
-    I Y #                                        #   I
-    I   #                                        #   I
-    I   #                                        #   I
-    I   #                                        #   I
-    I   #                                        #   I
-    I   #                                        #   I
-    I   #                           (xmax,ymax) @#   I
-    I   ##########################################   I
-    I                                                I
-    I@ MicroTouch (xmin,ymin)                        I
-    -------------------------------------------------
-
-Currently there is no way to calibrate the device via this driver.  Perhaps 
-at some point an abstract function will be placed into evdev so generic 
-functions like calibrations, resets, and vendor information can be requested 
-(And the drivers would handle the vendor specific tasks).
-
-ADDITIONAL INFORMATION/UPDATES:
+ADDITIONAL INFORMATION/UPDATES/X CONFIGURATION EXAMPLE:
 
 http://groomlakelabs.com/grandamp/code/microtouch/
 
 TODO:
 
 Implement a control urb again to handle requests to and from the device
-such as calibration, etc.
+such as calibration, etc once/if it becomes available.
 
 DISCLAMER:
 
@@ -83,3 +70,7 @@
 
 http://www.3m.com/3MTouchSystems/downloads/
 
+THANKS:
+
+A huge thank you to 3M Touch Systems for the EXII-5010UC controllers for
+testing!
diff -Nru a/drivers/usb/input/mtouchusb.c b/drivers/usb/input/mtouchusb.c
--- a/drivers/usb/input/mtouchusb.c	2004-06-07 13:11:57 +02:00
+++ b/drivers/usb/input/mtouchusb.c	2004-06-07 13:11:57 +02:00
@@ -28,6 +28,12 @@
  *    Complete rewrite using Linux Input in 2.6.3
  *    Unfortunately no calibration support at this time
  *
+ *  1.4 04/25/2004 (TEJ) tejohnson@yahoo.com
+ *    Changed reset from standard USB dev reset to vendor reset
+ *    Changed data sent to host from compensated to raw coordinates
+ *    Eliminated vendor/product module params
+ *    Performed multiple successfull tests with an EXII-5010UC
+ *
  *****************************************************************************/
 
 #include <linux/config.h>
@@ -45,25 +51,28 @@
 #include <linux/init.h>
 #include <linux/usb.h>
 
-#define MTOUCHUSB_MIN_XC                0xc8
-#define MTOUCHUSB_MAX_XC                0xff78
+#define MTOUCHUSB_MIN_XC                0x0
+#define MTOUCHUSB_MAX_XC                0x4000
 #define MTOUCHUSB_XC_FUZZ               0x0
 #define MTOUCHUSB_XC_FLAT               0x0
 #define MTOUCHUSB_MIN_YC                0x0
-#define MTOUCHUSB_MAX_YC                0xff78
+#define MTOUCHUSB_MAX_YC                0x4000
 #define MTOUCHUSB_YC_FUZZ               0x0
 #define MTOUCHUSB_YC_FLAT               0x0
-#define MTOUCHUSB_ASYC_REPORT           1
-#define MTOUCHUSB_REPORT_SIZE_DATA      11
+
+#define MTOUCHUSB_ASYNC_REPORT          1
+#define MTOUCHUSB_RESET                 7
+#define MTOUCHUSB_REPORT_DATA_SIZE      11
 #define MTOUCHUSB_REQ_CTRLLR_ID         10
 
-#define MTOUCHUSB_GET_XC(data)          (data[4]<<8 | data[3])
-#define MTOUCHUSB_GET_YC(data)          (data[6]<<8 | data[5])
+#define MTOUCHUSB_GET_XC(data)          (data[8]<<8 | data[7])
+#define MTOUCHUSB_GET_YC(data)          (data[10]<<8 | data[9])
 #define MTOUCHUSB_GET_TOUCHED(data)     ((data[2] & 0x40) ? 1:0)
 
-#define DRIVER_VERSION "v0.1"
+#define DRIVER_VERSION "v1.4"
 #define DRIVER_AUTHOR "Todd E. Johnson, tejohnson@yahoo.com"
-#define DRIVER_DESC "Microtouch USB HID Touchscreen Driver"
+#define DRIVER_DESC "3M USB Touchscreen Driver"
+#define DRIVER_LICENSE "GPL"
 
 struct mtouch_usb {
         unsigned char *data;
@@ -76,11 +85,9 @@
         char phys[64];
 };
 
-static __s32 vendor=-1, product=-1;
-
 static struct usb_device_id mtouchusb_devices [] = {
-        { USB_DEVICE(0x0596, 0x0001) }, /* 3M (Formerly MicroTouch) 14-206 */
-        { }                             /* Terminating entry */
+        { USB_DEVICE(0x0596, 0x0001) },
+        { }
 };
 
 static void mtouchusb_irq(struct urb *urb, struct pt_regs *regs)
@@ -153,7 +160,7 @@
 {
         dbg("%s - called", __FUNCTION__);
 
-        mtouch->data = usb_buffer_alloc(udev, MTOUCHUSB_REPORT_SIZE_DATA,
+        mtouch->data = usb_buffer_alloc(udev, MTOUCHUSB_REPORT_DATA_SIZE,
                                         SLAB_ATOMIC, &mtouch->data_dma);
 
         if (!mtouch->data)
@@ -167,7 +174,7 @@
         dbg("%s - called", __FUNCTION__);
 
         if (mtouch->data)
-                usb_buffer_free(udev, MTOUCHUSB_REPORT_SIZE_DATA,
+                usb_buffer_free(udev, MTOUCHUSB_REPORT_DATA_SIZE,
                                 mtouch->data, mtouch->data_dma);
 }
 
@@ -180,41 +187,8 @@
         char path[64];
         char *buf;
         int nRet;
-        int ix;
-        char valid_device = 0;
 
         dbg("%s - called", __FUNCTION__);
-        if (vendor != -1 && product != -1) {
-                info("%s - User specified USB Touch -- Vend:Prod - %x:%x",
-                     __FUNCTION__, vendor, product);
-        }
-
-        for (ix = 0; ix < sizeof (mtouchusb_devices) /
-             sizeof (struct usb_device_id); ix++) {
-                if ((udev->descriptor.idVendor ==
-                     mtouchusb_devices [ix].idVendor) &&
-                     (udev->descriptor.idProduct ==
-                     mtouchusb_devices [ix].idProduct)) {
-                        valid_device = 1;
-                        break;
-                }
-        }
-
-        if (udev->descriptor.idVendor == vendor &&
-            udev->descriptor.idProduct == product) {  /* User specified */
-                valid_device = 1;
-        }
-
-        if (!valid_device) {
-                err("%s - No valid device!", __FUNCTION__);
-                return -EIO;
-        }
-
-        if (udev->descriptor.bNumConfigurations != 1) {
-                err("%s -  Only one device configuration is supported.",
-                    __FUNCTION__);
-                return -EIO;
-        }
 
         dbg("%s - setting interface", __FUNCTION__);
         interface = intf->cur_altsetting;
@@ -222,11 +196,6 @@
         dbg("%s - setting endpoint", __FUNCTION__);
         endpoint = &interface->endpoint[0].desc;
 
-        if (interface->desc.bNumEndpoints != 1) {
-                err("%s - Only one endpoint is supported.", __FUNCTION__);
-                return -EIO;
-        }
-
         if (!(mtouch = kmalloc (sizeof (struct mtouch_usb), GFP_KERNEL))) {
                 err("%s - Out of memory.", __FUNCTION__);
                 return -ENOMEM;
@@ -266,8 +235,8 @@
         mtouch->input.absmax[ABS_X] =  MTOUCHUSB_MAX_XC;
         mtouch->input.absfuzz[ABS_X] = MTOUCHUSB_XC_FUZZ;
         mtouch->input.absflat[ABS_X] = MTOUCHUSB_XC_FLAT;
-        mtouch->input.absmin[ABS_Y] =  MTOUCHUSB_MAX_YC;
-        mtouch->input.absmax[ABS_Y] =  MTOUCHUSB_MIN_YC;
+        mtouch->input.absmin[ABS_Y] =  MTOUCHUSB_MIN_YC;
+        mtouch->input.absmax[ABS_Y] =  MTOUCHUSB_MAX_YC;
         mtouch->input.absfuzz[ABS_Y] = MTOUCHUSB_YC_FUZZ;
         mtouch->input.absflat[ABS_Y] = MTOUCHUSB_YC_FLAT;
 
@@ -290,15 +259,15 @@
         kfree(buf);
 
         nRet = usb_control_msg(mtouch->udev,
-                               usb_rcvctrlpipe(udev, 0x80),
-                               USB_REQ_GET_CONFIGURATION,
-                               USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
+                               usb_rcvctrlpipe(udev, 0),
+                               MTOUCHUSB_RESET,
+                               USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+                               1,
                                0,
-                               0x81,
                                NULL,
                                0,
                                HZ * USB_CTRL_SET_TIMEOUT);
-        dbg("%s - usb_control_msg - USB_REQ_GET_CONFIGURATION - bytes|err: %d",
+        dbg("%s - usb_control_msg - MTOUCHUSB_RESET - bytes|err: %d",
             __FUNCTION__, nRet);
 
         dbg("%s - usb_alloc_urb: mtouch->irq", __FUNCTION__);
@@ -315,7 +284,7 @@
                          mtouch->udev,
                          usb_rcvintpipe(mtouch->udev, 0x81),
                          mtouch->data,
-                         MTOUCHUSB_REPORT_SIZE_DATA,
+                         MTOUCHUSB_REPORT_DATA_SIZE,
                          mtouchusb_irq,
                          mtouch,
                          endpoint->bInterval);
@@ -324,15 +293,15 @@
         input_register_device(&mtouch->input);
 
         nRet = usb_control_msg(mtouch->udev,
-                               usb_rcvctrlpipe(udev, 0x80),
-                               MTOUCHUSB_ASYC_REPORT,
+                               usb_rcvctrlpipe(udev, 0),
+                               MTOUCHUSB_ASYNC_REPORT,
                                USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-                               MTOUCHUSB_ASYC_REPORT,
-                               MTOUCHUSB_ASYC_REPORT,
+                               1,
+                               1,
                                NULL,
                                0,
                                HZ * USB_CTRL_SET_TIMEOUT);
-        dbg("%s - usb_control_msg - MTOUCHUSB_ASYC_REPORT - bytes|err: %d",
+        dbg("%s - usb_control_msg - MTOUCHUSB_ASYNC_REPORT - bytes|err: %d",
             __FUNCTION__, nRet);
 
         printk(KERN_INFO "input: %s on %s\n", mtouch->name, path);
@@ -383,9 +352,3 @@
 MODULE_AUTHOR( DRIVER_AUTHOR );
 MODULE_DESCRIPTION( DRIVER_DESC );
 MODULE_LICENSE("GPL");
-MODULE_PARM(vendor, "i");
-MODULE_PARM_DESC(vendor, "User specified USB idVendor");
-MODULE_PARM(product, "i");
-MODULE_PARM_DESC(product, "User specified USB idProduct");
-
-


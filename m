Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVKQSF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVKQSF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbVKQSES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:04:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:11938 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932486AbVKQSEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:06 -0500
Date: Thu, 17 Nov 2005 09:48:09 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 20/22] USB: move CONFIG_USB_DEBUG checks into the Makefile
Message-ID: <20051117174809.GV11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-makefile-debug.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This lets us remove a lot of code in the drivers that were all checking
the same thing.  It also found some bugs in a few of the drivers, which
has been fixed up.


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/atm/Makefile           |    4 ++++
 drivers/usb/atm/usbatm.h           |    5 -----
 drivers/usb/core/Makefile          |    4 ++++
 drivers/usb/core/buffer.c          |    8 --------
 drivers/usb/core/config.c          |    5 -----
 drivers/usb/core/file.c            |    6 ------
 drivers/usb/core/hcd-pci.c         |    7 -------
 drivers/usb/core/hcd.c             |    5 -----
 drivers/usb/core/hub.c             |    5 -----
 drivers/usb/core/message.c         |    7 -------
 drivers/usb/core/notify.c          |    6 ------
 drivers/usb/core/sysfs.c           |    7 -------
 drivers/usb/core/urb.c             |    6 ------
 drivers/usb/core/usb.c             |    7 -------
 drivers/usb/input/Makefile         |    4 ++++
 drivers/usb/input/itmtouch.c       |    7 -------
 drivers/usb/input/keyspan_remote.c |    5 +++--
 drivers/usb/input/mtouchusb.c      |    7 -------
 drivers/usb/input/pid.c            |    2 --
 drivers/usb/input/touchkitusb.c    |    4 ----
 drivers/usb/misc/Makefile          |    6 +++++-
 drivers/usb/misc/auerswald.c       |    1 -
 drivers/usb/misc/phidgetservo.c    |    3 ---
 drivers/usb/misc/rio500.c          |    2 +-
 drivers/usb/misc/usbled.c          |    3 ---
 drivers/usb/misc/usbtest.c         |    3 ---
 drivers/usb/misc/uss720.c          |    2 --
 drivers/usb/net/Makefile           |    4 ++++
 drivers/usb/net/asix.c             |    3 ---
 drivers/usb/net/cdc_ether.c        |    3 ---
 drivers/usb/net/cdc_subset.c       |    3 ---
 drivers/usb/net/gl620a.c           |    3 ---
 drivers/usb/net/net1080.c          |    3 ---
 drivers/usb/net/pegasus.c          |    2 --
 drivers/usb/net/plusb.c            |    3 ---
 drivers/usb/net/rndis_host.c       |    3 ---
 drivers/usb/net/usbnet.c           |    3 ---
 drivers/usb/net/zaurus.c           |    3 ---
 38 files changed, 25 insertions(+), 139 deletions(-)

--- usb-2.6.orig/drivers/usb/core/Makefile
+++ usb-2.6/drivers/usb/core/Makefile
@@ -14,3 +14,7 @@ ifeq ($(CONFIG_USB_DEVICEFS),y)
 endif
 
 obj-$(CONFIG_USB)	+= usbcore.o
+
+ifeq ($(CONFIG_USB_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
--- usb-2.6.orig/drivers/usb/core/buffer.c
+++ usb-2.6/drivers/usb/core/buffer.c
@@ -15,14 +15,6 @@
 #include <asm/scatterlist.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
-
-
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/usb.h>
 #include "hcd.h"
 
--- usb-2.6.orig/drivers/usb/core/config.c
+++ usb-2.6/drivers/usb/core/config.c
@@ -1,9 +1,4 @@
 #include <linux/config.h>
-
-#ifdef CONFIG_USB_DEBUG
-#define DEBUG
-#endif
-
 #include <linux/usb.h>
 #include <linux/module.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/core/file.c
+++ usb-2.6/drivers/usb/core/file.c
@@ -19,12 +19,6 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
-
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
 #include <linux/usb.h>
 
 #include "usb.h"
--- usb-2.6.orig/drivers/usb/core/hcd-pci.c
+++ usb-2.6/drivers/usb/core/hcd-pci.c
@@ -17,13 +17,6 @@
  */
 
 #include <linux/config.h>
-
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
--- usb-2.6.orig/drivers/usb/core/hcd.c
+++ usb-2.6/drivers/usb/core/hcd.c
@@ -23,11 +23,6 @@
  */
 
 #include <linux/config.h>
-
-#ifdef CONFIG_USB_DEBUG
-#define DEBUG
-#endif
-
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
--- usb-2.6.orig/drivers/usb/core/hub.c
+++ usb-2.6/drivers/usb/core/hub.c
@@ -9,11 +9,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/module.h>
--- usb-2.6.orig/drivers/usb/core/message.c
+++ usb-2.6/drivers/usb/core/message.c
@@ -3,13 +3,6 @@
  */
 
 #include <linux/config.h>
-
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/pci.h>	/* for scatterlist macros */
 #include <linux/usb.h>
 #include <linux/module.h>
--- usb-2.6.orig/drivers/usb/core/notify.c
+++ usb-2.6/drivers/usb/core/notify.c
@@ -12,13 +12,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/notifier.h>
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
 #include <linux/usb.h>
-
 #include "usb.h"
 
 
--- usb-2.6.orig/drivers/usb/core/sysfs.c
+++ usb-2.6/drivers/usb/core/sysfs.c
@@ -12,14 +12,7 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
 #include <linux/usb.h>
-
 #include "usb.h"
 
 /* endpoint stuff */
--- usb-2.6.orig/drivers/usb/core/urb.c
+++ usb-2.6/drivers/usb/core/urb.c
@@ -4,12 +4,6 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
 #include <linux/usb.h>
 #include "hcd.h"
 
--- usb-2.6.orig/drivers/usb/core/usb.c
+++ usb-2.6/drivers/usb/core/usb.c
@@ -22,13 +22,6 @@
  */
 
 #include <linux/config.h>
-
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/bitops.h>
--- usb-2.6.orig/drivers/usb/net/Makefile
+++ usb-2.6/drivers/usb/net/Makefile
@@ -16,3 +16,7 @@ obj-$(CONFIG_USB_NET_CDC_SUBSET)	+= cdc_
 obj-$(CONFIG_USB_NET_ZAURUS)	+= zaurus.o
 obj-$(CONFIG_USB_USBNET)	+= usbnet.o
 obj-$(CONFIG_USB_ZD1201)	+= zd1201.o
+
+ifeq ($(CONFIG_USB_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
--- usb-2.6.orig/drivers/usb/net/asix.c
+++ usb-2.6/drivers/usb/net/asix.c
@@ -23,9 +23,6 @@
 // #define	VERBOSE			// more; success messages
 
 #include <linux/config.h>
-#ifdef	CONFIG_USB_DEBUG
-#   define DEBUG
-#endif
 #include <linux/module.h>
 #include <linux/kmod.h>
 #include <linux/sched.h>
--- usb-2.6.orig/drivers/usb/net/cdc_ether.c
+++ usb-2.6/drivers/usb/net/cdc_ether.c
@@ -21,9 +21,6 @@
 // #define	VERBOSE			// more; success messages
 
 #include <linux/config.h>
-#ifdef	CONFIG_USB_DEBUG
-#   define DEBUG
-#endif
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/net/cdc_subset.c
+++ usb-2.6/drivers/usb/net/cdc_subset.c
@@ -18,9 +18,6 @@
  */
 
 #include <linux/config.h>
-#ifdef	CONFIG_USB_DEBUG
-#   define DEBUG
-#endif
 #include <linux/module.h>
 #include <linux/kmod.h>
 #include <linux/sched.h>
--- usb-2.6.orig/drivers/usb/net/gl620a.c
+++ usb-2.6/drivers/usb/net/gl620a.c
@@ -22,9 +22,6 @@
 // #define	VERBOSE			// more; success messages
 
 #include <linux/config.h>
-#ifdef	CONFIG_USB_DEBUG
-#   define DEBUG
-#endif
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/net/net1080.c
+++ usb-2.6/drivers/usb/net/net1080.c
@@ -21,9 +21,6 @@
 // #define	VERBOSE			// more; success messages
 
 #include <linux/config.h>
-#ifdef	CONFIG_USB_DEBUG
-#   define DEBUG
-#endif
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/net/pegasus.c
+++ usb-2.6/drivers/usb/net/pegasus.c
@@ -28,8 +28,6 @@
  * 			is out of the interrupt routine.
  */
 
-#undef	DEBUG
-
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/net/plusb.c
+++ usb-2.6/drivers/usb/net/plusb.c
@@ -21,9 +21,6 @@
 // #define	VERBOSE			// more; success messages
 
 #include <linux/config.h>
-#ifdef	CONFIG_USB_DEBUG
-#   define DEBUG
-#endif
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/net/rndis_host.c
+++ usb-2.6/drivers/usb/net/rndis_host.c
@@ -21,9 +21,6 @@
 // #define	VERBOSE			// more; success messages
 
 #include <linux/config.h>
-#ifdef	CONFIG_USB_DEBUG
-#   define DEBUG
-#endif
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/net/usbnet.c
+++ usb-2.6/drivers/usb/net/usbnet.c
@@ -34,9 +34,6 @@
 // #define	VERBOSE			// more; success messages
 
 #include <linux/config.h>
-#ifdef	CONFIG_USB_DEBUG
-#   define DEBUG
-#endif
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/net/zaurus.c
+++ usb-2.6/drivers/usb/net/zaurus.c
@@ -21,9 +21,6 @@
 // #define	VERBOSE			// more; success messages
 
 #include <linux/config.h>
-#ifdef	CONFIG_USB_DEBUG
-#   define DEBUG
-#endif
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/input/Makefile
+++ usb-2.6/drivers/usb/input/Makefile
@@ -42,3 +42,7 @@ obj-$(CONFIG_USB_ACECAD)	+= acecad.o
 obj-$(CONFIG_USB_YEALINK)	+= yealink.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
 obj-$(CONFIG_USB_APPLETOUCH)	+= appletouch.o
+
+ifeq ($(CONFIG_USB_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
--- usb-2.6.orig/drivers/usb/input/itmtouch.c
+++ usb-2.6/drivers/usb/input/itmtouch.c
@@ -40,13 +40,6 @@
  *****************************************************************************/
 
 #include <linux/config.h>
-
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/input.h>
--- usb-2.6.orig/drivers/usb/input/mtouchusb.c
+++ usb-2.6/drivers/usb/input/mtouchusb.c
@@ -40,13 +40,6 @@
  *****************************************************************************/
 
 #include <linux/config.h>
-
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG
-#else
-	#undef DEBUG
-#endif
-
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/input.h>
--- usb-2.6.orig/drivers/usb/input/touchkitusb.c
+++ usb-2.6/drivers/usb/input/touchkitusb.c
@@ -30,10 +30,6 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/init.h>
-
-#if !defined(DEBUG) && defined(CONFIG_USB_DEBUG)
-#define DEBUG
-#endif
 #include <linux/usb.h>
 #include <linux/usb_input.h>
 
--- usb-2.6.orig/drivers/usb/input/pid.c
+++ usb-2.6/drivers/usb/input/pid.c
@@ -37,8 +37,6 @@
 #include "hid.h"
 #include "pid.h"
 
-#define DEBUG
-
 #define CHECK_OWNERSHIP(i, hid_pid)	\
 	((i) < FF_EFFECTS_MAX && i >= 0 && \
 	test_bit(FF_PID_FLAGS_USED, &hid_pid->effects[(i)].flags) && \
--- usb-2.6.orig/drivers/usb/input/keyspan_remote.c
+++ usb-2.6/drivers/usb/input/keyspan_remote.c
@@ -160,7 +160,8 @@ static int keyspan_load_tester(struct us
 	 * though so it's not too big a deal
 	 */
 	if (dev->data.pos >= dev->data.len) {
-		dev_dbg(&dev->udev, "%s - Error ran out of data. pos: %d, len: %d\n",
+		dev_dbg(&dev->udev->dev,
+			"%s - Error ran out of data. pos: %d, len: %d\n",
 			__FUNCTION__, dev->data.pos, dev->data.len);
 		return -1;
 	}
@@ -306,7 +307,7 @@ static void keyspan_check_data(struct us
 			err("Bad message recieved, no stop bit found.\n");
 		}
 
-		dev_dbg(&remote->udev,
+		dev_dbg(&remote->udev->dev,
 			"%s found valid message: system: %d, button: %d, toggle: %d\n",
 			__FUNCTION__, message.system, message.button, message.toggle);
 
--- usb-2.6.orig/drivers/usb/misc/Makefile
+++ usb-2.6/drivers/usb/misc/Makefile
@@ -18,4 +18,8 @@ obj-$(CONFIG_USB_RIO500)	+= rio500.o
 obj-$(CONFIG_USB_TEST)		+= usbtest.o
 obj-$(CONFIG_USB_USS720)	+= uss720.o
 
-obj-$(CONFIG_USB_SISUSBVGA)	+= sisusbvga/
\ No newline at end of file
+obj-$(CONFIG_USB_SISUSBVGA)	+= sisusbvga/
+
+ifeq ($(CONFIG_USB_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
--- usb-2.6.orig/drivers/usb/misc/phidgetservo.c
+++ usb-2.6/drivers/usb/misc/phidgetservo.c
@@ -26,9 +26,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_USB_DEBUG
-#define DEBUG	1
-#endif
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/misc/usbled.c
+++ usb-2.6/drivers/usb/misc/usbled.c
@@ -10,9 +10,6 @@
  */
 
 #include <linux/config.h>
-#ifdef CONFIG_USB_DEBUG
-	#define DEBUG	1
-#endif
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/misc/usbtest.c
+++ usb-2.6/drivers/usb/misc/usbtest.c
@@ -1,7 +1,4 @@
 #include <linux/config.h>
-#if !defined (DEBUG) && defined (CONFIG_USB_DEBUG)
-#   define DEBUG
-#endif
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
--- usb-2.6.orig/drivers/usb/misc/auerswald.c
+++ usb-2.6/drivers/usb/misc/auerswald.c
@@ -30,7 +30,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/wait.h>
-#undef DEBUG   		/* include debug macros until it's done	*/
 #include <linux/usb.h>
 
 /*-------------------------------------------------------------------*/
--- usb-2.6.orig/drivers/usb/misc/rio500.c
+++ usb-2.6/drivers/usb/misc/rio500.c
@@ -393,7 +393,7 @@ read_rio(struct file *file, char __user 
 				      ibuf, this_read, &partial,
 				      8000);
 
-		dbg(KERN_DEBUG "read stats: result:%d this_read:%u partial:%u",
+		dbg("read stats: result:%d this_read:%u partial:%u",
 		       result, this_read, partial);
 
 		if (partial) {
--- usb-2.6.orig/drivers/usb/misc/uss720.c
+++ usb-2.6/drivers/usb/misc/uss720.c
@@ -41,8 +41,6 @@
 
 /*****************************************************************************/
 
-#define DEBUG
-
 #include <linux/module.h>
 #include <linux/socket.h>
 #include <linux/parport.h>
--- usb-2.6.orig/drivers/usb/atm/Makefile
+++ usb-2.6/drivers/usb/atm/Makefile
@@ -6,3 +6,7 @@ obj-$(CONFIG_USB_CXACRU)	+= cxacru.o
 obj-$(CONFIG_USB_SPEEDTOUCH)	+= speedtch.o
 obj-$(CONFIG_USB_ATM)		+= usbatm.o
 obj-$(CONFIG_USB_XUSBATM)	+= xusbatm.o
+
+ifeq ($(CONFIG_USB_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
--- usb-2.6.orig/drivers/usb/atm/usbatm.h
+++ usb-2.6/drivers/usb/atm/usbatm.h
@@ -27,14 +27,9 @@
 #include <linux/config.h>
 
 /*
-#define DEBUG
 #define VERBOSE_DEBUG
 */
 
-#if !defined (DEBUG) && defined (CONFIG_USB_DEBUG)
-#	define DEBUG
-#endif
-
 #include <asm/semaphore.h>
 #include <linux/atm.h>
 #include <linux/atmdev.h>

--

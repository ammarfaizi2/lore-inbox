Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVCAAwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVCAAwJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVCAAru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:47:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29963 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261178AbVCAAn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:43:56 -0500
Date: Tue, 1 Mar 2005 01:43:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] USB: possible cleanups
Message-ID: <20050301004352.GD4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I'm getting flamed to death:
This patch contains possible cleanups. If parts of this patch conflict
with pending changes these parts of my patch have to be dropped.

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - core/usb.c: usb_buffer_map
  - core/usb.c: usb_buffer_unmap
- remove the following unneeded EXPORT_SYMBOL's:
  - core/hcd.c: usb_bus_init
  - core/hcd.c: usb_alloc_bus
  - core/hcd.c: usb_register_bus
  - core/hcd.c: usb_deregister_bus
  - core/hcd.c: usb_hcd_irq
  - core/usb.c: usb_buffer_map
  - core/usb.c: usb_buffer_unmap
  - core/buffer.c: hcd_buffer_create
  - core/buffer.c: hcd_buffer_destroy

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/core/buffer.c           |    2 --
 drivers/usb/core/config.c           |    2 +-
 drivers/usb/core/hcd.c              |    7 +------
 drivers/usb/core/hcd.h              |    1 -
 drivers/usb/core/hub.c              |    3 ++-
 drivers/usb/core/message.c          |   10 ++++++----
 drivers/usb/core/usb.c              |   14 +++++++++-----
 drivers/usb/core/usb.h              |    5 -----
 drivers/usb/input/aiptek.c          |    2 +-
 drivers/usb/media/ibmcam.c          |    3 ++-
 drivers/usb/misc/sisusbvga/sisusb.c |    8 ++++----
 drivers/usb/net/catc.c              |    3 ++-
 drivers/usb/net/kawethfw.h          |    8 ++++----
 include/linux/usb.h                 |    4 ++--
 14 files changed, 34 insertions(+), 38 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/usb/core/config.c.old	2005-02-28 23:48:53.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/core/config.c	2005-02-28 23:49:04.000000000 +0100
@@ -221,7 +221,7 @@
 	return buffer - buffer0 + i;
 }
 
-int usb_parse_configuration(struct device *ddev, int cfgidx,
+static int usb_parse_configuration(struct device *ddev, int cfgidx,
     struct usb_host_config *config, unsigned char *buffer, int size)
 {
 	unsigned char *buffer0 = buffer;
--- linux-2.6.11-rc4-mm1-full/drivers/usb/core/hcd.h.old	2005-02-28 23:52:39.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/core/hcd.h	2005-02-28 23:52:44.000000000 +0100
@@ -208,7 +208,6 @@
 };
 
 extern void usb_hcd_giveback_urb (struct usb_hcd *hcd, struct urb *urb, struct pt_regs *regs);
-extern void usb_bus_init (struct usb_bus *bus);
 
 extern struct usb_hcd *usb_create_hcd (const struct hc_driver *driver,
 		struct device *dev, char *bus_name);
--- linux-2.6.11-rc4-mm1-full/drivers/usb/core/hcd.c.old	2005-02-28 23:51:56.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/core/hcd.c	2005-03-01 00:27:36.000000000 +0100
@@ -701,7 +701,7 @@
  * This code is used to initialize a usb_bus structure, memory for which is
  * separately managed.
  */
-void usb_bus_init (struct usb_bus *bus)
+static void usb_bus_init (struct usb_bus *bus)
 {
 	memset (&bus->devmap, 0, sizeof(struct usb_devmap));
 
@@ -719,7 +719,6 @@
 	class_device_initialize(&bus->class_dev);
 	bus->class_dev.class = &usb_host_class;
 }
-EXPORT_SYMBOL (usb_bus_init);
 
 /**
  * usb_alloc_bus - creates a new USB host controller structure
@@ -745,7 +744,6 @@
 	bus->op = op;
 	return bus;
 }
-EXPORT_SYMBOL (usb_alloc_bus);
 
 /*-------------------------------------------------------------------------*/
 
@@ -792,7 +790,6 @@
 	dev_info (bus->controller, "new USB bus registered, assigned bus number %d\n", bus->busnum);
 	return 0;
 }
-EXPORT_SYMBOL (usb_register_bus);
 
 /**
  * usb_deregister_bus - deregisters the USB host controller
@@ -822,7 +819,6 @@
 
 	class_device_del(&bus->class_dev);
 }
-EXPORT_SYMBOL (usb_deregister_bus);
 
 /**
  * usb_register_root_hub - called by HCD to register its root hub 
@@ -1557,7 +1553,6 @@
 		usb_hc_died (hcd);
 	return IRQ_HANDLED;
 }
-EXPORT_SYMBOL (usb_hcd_irq);
 
 /*-------------------------------------------------------------------------*/
 
--- linux-2.6.11-rc4-mm1-full/drivers/usb/core/hub.c.old	2005-02-28 23:55:36.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/core/hub.c	2005-02-28 23:56:41.000000000 +0100
@@ -1525,7 +1525,8 @@
  * Linux (2.6) currently has NO mechanisms to initiate that:  no khubd
  * timer, no SRP, no requests through sysfs.
  */
-int __usb_suspend_device (struct usb_device *udev, int port1, pm_message_t state)
+static int __usb_suspend_device (struct usb_device *udev, int port1,
+				 pm_message_t state)
 {
 	int	status;
 
--- linux-2.6.11-rc4-mm1-full/drivers/usb/core/usb.h.old	2005-02-28 23:57:04.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/core/usb.h	2005-03-01 00:03:31.000000000 +0100
@@ -4,8 +4,6 @@
 extern void usb_remove_sysfs_dev_files (struct usb_device *dev);
 extern void usb_create_sysfs_intf_files (struct usb_interface *intf);
 extern void usb_remove_sysfs_intf_files (struct usb_interface *intf);
-extern int usb_probe_interface (struct device *dev);
-extern int usb_unbind_interface (struct device *dev);
 
 extern void usb_disable_endpoint (struct usb_device *dev, unsigned int epaddr);
 extern void usb_disable_interface (struct usb_device *dev,
@@ -13,9 +11,6 @@
 extern void usb_release_interface_cache(struct kref *ref);
 extern void usb_disable_device (struct usb_device *dev, int skip_ep0);
 
-extern void usb_enable_interface (struct usb_device *dev,
-		struct usb_interface *intf);
-
 extern int usb_get_device_descriptor(struct usb_device *dev,
 		unsigned int size);
 extern int usb_set_configuration(struct usb_device *dev, int configuration);
--- linux-2.6.11-rc4-mm1-full/drivers/usb/core/message.c.old	2005-02-28 23:57:32.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/core/message.c	2005-02-28 23:58:25.000000000 +0100
@@ -90,8 +90,10 @@
 
 /*-------------------------------------------------------------------*/
 // returns status (negative) or length (positive)
-int usb_internal_control_msg(struct usb_device *usb_dev, unsigned int pipe, 
-			    struct usb_ctrlrequest *cmd,  void *data, int len, int timeout)
+static int usb_internal_control_msg(struct usb_device *usb_dev,
+				    unsigned int pipe, 
+				    struct usb_ctrlrequest *cmd,
+				    void *data, int len, int timeout)
 {
 	struct urb *urb;
 	int retv;
@@ -1039,8 +1041,8 @@
  *
  * Enables all the endpoints for the interface's current altsetting.
  */
-void usb_enable_interface(struct usb_device *dev,
-		struct usb_interface *intf)
+static void usb_enable_interface(struct usb_device *dev,
+				 struct usb_interface *intf)
 {
 	struct usb_host_interface *alt = intf->cur_altsetting;
 	int i;
--- linux-2.6.11-rc4-mm1-full/include/linux/usb.h.old	2005-02-28 23:59:37.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/linux/usb.h	2005-03-01 00:38:40.000000000 +0100
@@ -942,11 +942,11 @@
 void usb_buffer_free (struct usb_device *dev, size_t size,
 	void *addr, dma_addr_t dma);
 
-struct urb *usb_buffer_map (struct urb *urb);
 #if 0
+struct urb *usb_buffer_map (struct urb *urb);
 void usb_buffer_dmasync (struct urb *urb);
-#endif
 void usb_buffer_unmap (struct urb *urb);
+#endif
 
 struct scatterlist;
 int usb_buffer_map_sg (struct usb_device *dev, unsigned pipe,
--- linux-2.6.11-rc4-mm1-full/drivers/usb/core/usb.c.old	2005-02-28 23:58:40.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/core/usb.c	2005-03-01 00:37:27.000000000 +0100
@@ -60,7 +60,7 @@
 
 const char *usbcore_name = "usbcore";
 
-int nousb;		/* Disable USB when built into kernel image */
+static int nousb;	/* Disable USB when built into kernel image */
 			/* Not honored on modular build */
 
 static DECLARE_RWSEM(usb_all_devices_rwsem);
@@ -86,7 +86,7 @@
 static int usb_generic_driver_data;
 
 /* called from driver core with usb_bus_type.subsys writelock */
-int usb_probe_interface(struct device *dev)
+static int usb_probe_interface(struct device *dev)
 {
 	struct usb_interface * intf = to_usb_interface(dev);
 	struct usb_driver * driver = to_usb_driver(dev->driver);
@@ -114,7 +114,7 @@
 }
 
 /* called from driver core with usb_bus_type.subsys writelock */
-int usb_unbind_interface(struct device *dev)
+static int usb_unbind_interface(struct device *dev)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_driver *driver = to_usb_driver(intf->dev.driver);
@@ -1145,6 +1145,7 @@
  *
  * Reverse the effect of this call with usb_buffer_unmap().
  */
+#if 0
 struct urb *usb_buffer_map (struct urb *urb)
 {
 	struct usb_bus		*bus;
@@ -1174,6 +1175,7 @@
 				| URB_NO_SETUP_DMA_MAP);
 	return urb;
 }
+#endif  /*  0  */
 
 /* XXX DISABLED, no users currently.  If you wish to re-enable this
  * XXX please determine whether the sync is to transfer ownership of
@@ -1218,6 +1220,7 @@
  *
  * Reverses the effect of usb_buffer_map().
  */
+#if 0
 void usb_buffer_unmap (struct urb *urb)
 {
 	struct usb_bus		*bus;
@@ -1244,6 +1247,7 @@
 	urb->transfer_flags &= ~(URB_NO_TRANSFER_DMA_MAP
 				| URB_NO_SETUP_DMA_MAP);
 }
+#endif  /*  0  */
 
 /**
  * usb_buffer_map_sg - create scatterlist DMA mapping(s) for an endpoint
@@ -1524,11 +1528,11 @@
 EXPORT_SYMBOL (usb_buffer_alloc);
 EXPORT_SYMBOL (usb_buffer_free);
 
-EXPORT_SYMBOL (usb_buffer_map);
 #if 0
+EXPORT_SYMBOL (usb_buffer_map);
 EXPORT_SYMBOL (usb_buffer_dmasync);
-#endif
 EXPORT_SYMBOL (usb_buffer_unmap);
+#endif
 
 EXPORT_SYMBOL (usb_buffer_map_sg);
 #if 0
--- linux-2.6.11-rc4-mm1-full/drivers/usb/input/aiptek.c.old	2005-03-01 00:04:24.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/input/aiptek.c	2005-03-01 00:04:35.000000000 +0100
@@ -796,7 +796,7 @@
  * manufacturing revisions. In any event, we consider these 
  * IDs to not be model-specific nor unique.
  */
-struct usb_device_id aiptek_ids[] = {
+static const struct usb_device_id aiptek_ids[] = {
 	{USB_DEVICE(USB_VENDOR_ID_AIPTEK, 0x01)},
 	{USB_DEVICE(USB_VENDOR_ID_AIPTEK, 0x10)},
 	{USB_DEVICE(USB_VENDOR_ID_AIPTEK, 0x20)},
--- linux-2.6.11-rc4-mm1-full/drivers/usb/media/ibmcam.c.old	2005-03-01 00:04:53.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/media/ibmcam.c	2005-03-01 00:05:09.000000000 +0100
@@ -1036,7 +1036,8 @@
  * History:
  * 1/21/00  Created.
  */
-void ibmcam_ProcessIsocData(struct uvd *uvd, struct usbvideo_frame *frame)
+static void ibmcam_ProcessIsocData(struct uvd *uvd,
+				   struct usbvideo_frame *frame)
 {
 	enum ParseState newstate;
 	long copylen = 0;
--- linux-2.6.11-rc4-mm1-full/drivers/usb/misc/sisusbvga/sisusb.c.old	2005-03-01 00:06:08.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/misc/sisusbvga/sisusb.c	2005-03-01 00:07:14.000000000 +0100
@@ -2271,7 +2271,7 @@
 
 /* fops */
 
-int
+static int
 sisusb_open(struct inode *inode, struct file *file)
 {
 	struct sisusb_usb_data *sisusb;
@@ -2361,7 +2361,7 @@
 	kfree(sisusb);
 }
 
-int
+static int
 sisusb_release(struct inode *inode, struct file *file)
 {
 	struct sisusb_usb_data *sisusb;
@@ -2399,7 +2399,7 @@
 	return 0;
 }
 
-ssize_t
+static ssize_t
 sisusb_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
 	struct sisusb_usb_data *sisusb;
@@ -2540,7 +2540,7 @@
 	return errno ? errno : bytes_read;
 }
 
-ssize_t
+static ssize_t
 sisusb_write(struct file *file, const char __user *buffer, size_t count,
 								loff_t *ppos)
 {
--- linux-2.6.11-rc4-mm1-full/drivers/usb/net/catc.c.old	2005-03-01 00:08:30.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/net/catc.c	2005-03-01 00:08:56.000000000 +0100
@@ -664,7 +664,8 @@
 	}
 }
 
-void catc_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+static void catc_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
 {
 	struct catc *catc = netdev_priv(dev);
 	strncpy(info->driver, driver_name, ETHTOOL_BUSINFO_LEN);
--- linux-2.6.11-rc4-mm1-full/drivers/usb/net/kawethfw.h.old	2005-03-01 00:09:26.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/net/kawethfw.h	2005-03-01 00:10:01.000000000 +0100
@@ -551,7 +551,7 @@
 };
 
 
-const int len_kaweth_trigger_code = sizeof(kaweth_trigger_code);
-const int len_kaweth_trigger_code_fix = sizeof(kaweth_trigger_code_fix);
-const int len_kaweth_new_code = sizeof(kaweth_new_code);
-const int len_kaweth_new_code_fix = sizeof(kaweth_new_code_fix);
+static const int len_kaweth_trigger_code = sizeof(kaweth_trigger_code);
+static const int len_kaweth_trigger_code_fix = sizeof(kaweth_trigger_code_fix);
+static const int len_kaweth_new_code = sizeof(kaweth_new_code);
+static const int len_kaweth_new_code_fix = sizeof(kaweth_new_code_fix);
--- linux-2.6.11-rc4-mm1-full/drivers/usb/core/buffer.c.old	2005-03-01 00:28:23.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/core/buffer.c	2005-03-01 00:28:42.000000000 +0100
@@ -76,7 +76,6 @@
 	}
 	return 0;
 }
-EXPORT_SYMBOL (hcd_buffer_create);
 
 
 /**
@@ -98,7 +97,6 @@
 		}
 	}
 }
-EXPORT_SYMBOL (hcd_buffer_destroy);
 
 
 /* sometimes alloc/free could use kmalloc with SLAB_DMA, for


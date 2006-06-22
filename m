Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWFVSae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWFVSae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWFVSae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:30:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51134 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030328AbWFVSa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:30:29 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [PATCH 2/14] [PATCH] w1: Replace dscore and ds_w1_bridge with ds2490 driver.
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:06 -0700
Message-Id: <11510008413045-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008381000-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/Documentation/w1/masters/ds2490 b/Documentation/w1/masters/ds2490
new file mode 100644
index 0000000..44a4918
--- /dev/null
+++ b/Documentation/w1/masters/ds2490
@@ -0,0 +1,18 @@
+Kernel driver ds2490
+====================
+
+Supported chips:
+  * Maxim DS2490 based
+
+Author: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+
+
+Description
+-----------
+
+The Maixm/Dallas Semiconductor DS2490 is a chip
+which allows to build USB <-> W1 bridges.
+
+DS9490(R) is a USB <-> W1 bus master device
+which has 0x81 family ID integrated chip and DS2490
+low-level operational chip.
diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index c6bad4d..2fb4255 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -15,24 +15,15 @@ config W1_MASTER_MATROX
 	  This support is also available as a module.  If so, the module
 	  will be called matrox_w1.ko.
 
-config W1_MASTER_DS9490
-	tristate "DS9490R transport layer driver"
-	depends on W1 && USB
-	help
-	  Say Y here if you want to have a driver for DS9490R UWB <-> W1 bridge.
-
-	  This support is also available as a module.  If so, the module
-	  will be called ds9490r.ko.
-
-config W1_MASTER_DS9490_BRIDGE
-	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
-	depends on W1_MASTER_DS9490
-	help
-	  Say Y here if you want to communicate with your 1-wire devices
-	  using DS9490R USB bridge.
-
-	  This support is also available as a module.  If so, the module
-	  will be called ds_w1_bridge.ko.
+config W1_MASTER_DS2490
+	tristate "DS2490 USB <-> W1 transport layer for 1-wire"
+  	depends on W1 && USB
+  	help
+	  Say Y here if you want to have a driver for DS2490 based USB <-> W1 bridges,
+	  for example DS9490*.
+
+  	  This support is also available as a module.  If so, the module
+	  will be called ds2490.ko.
 
 config W1_MASTER_DS2482
 	tristate "Maxim DS2482 I2C to 1-Wire bridge"
diff --git a/drivers/w1/masters/Makefile b/drivers/w1/masters/Makefile
index 1f3c8b9..4cee256 100644
--- a/drivers/w1/masters/Makefile
+++ b/drivers/w1/masters/Makefile
@@ -3,11 +3,6 @@ # Makefile for 1-wire bus master drivers
 #
 
 obj-$(CONFIG_W1_MASTER_MATROX)		+= matrox_w1.o
-
-obj-$(CONFIG_W1_MASTER_DS9490)		+= ds9490r.o
-ds9490r-objs    := dscore.o
-
-obj-$(CONFIG_W1_MASTER_DS9490_BRIDGE)	+= ds_w1_bridge.o
-
+obj-$(CONFIG_W1_MASTER_DS2490)		+= ds2490.o
 obj-$(CONFIG_W1_MASTER_DS2482)		+= ds2482.o
 
diff --git a/drivers/w1/masters/dscore.c b/drivers/w1/masters/ds2490.c
similarity index 67%
rename from drivers/w1/masters/dscore.c
rename to drivers/w1/masters/ds2490.c
index 2cf7776..6376778 100644
--- a/drivers/w1/masters/dscore.c
+++ b/drivers/w1/masters/ds2490.c
@@ -24,7 +24,136 @@ #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/usb.h>
 
-#include "dscore.h"
+#include "../w1_int.h"
+#include "../w1.h"
+
+/* COMMAND TYPE CODES */
+#define CONTROL_CMD			0x00
+#define COMM_CMD			0x01
+#define MODE_CMD			0x02
+
+/* CONTROL COMMAND CODES */
+#define CTL_RESET_DEVICE		0x0000
+#define CTL_START_EXE			0x0001
+#define CTL_RESUME_EXE			0x0002
+#define CTL_HALT_EXE_IDLE		0x0003
+#define CTL_HALT_EXE_DONE		0x0004
+#define CTL_FLUSH_COMM_CMDS		0x0007
+#define CTL_FLUSH_RCV_BUFFER		0x0008
+#define CTL_FLUSH_XMT_BUFFER		0x0009
+#define CTL_GET_COMM_CMDS		0x000A
+
+/* MODE COMMAND CODES */
+#define MOD_PULSE_EN			0x0000
+#define MOD_SPEED_CHANGE_EN		0x0001
+#define MOD_1WIRE_SPEED			0x0002
+#define MOD_STRONG_PU_DURATION		0x0003
+#define MOD_PULLDOWN_SLEWRATE		0x0004
+#define MOD_PROG_PULSE_DURATION		0x0005
+#define MOD_WRITE1_LOWTIME		0x0006
+#define MOD_DSOW0_TREC			0x0007
+
+/* COMMUNICATION COMMAND CODES */
+#define COMM_ERROR_ESCAPE		0x0601
+#define COMM_SET_DURATION		0x0012
+#define COMM_BIT_IO			0x0020
+#define COMM_PULSE			0x0030
+#define COMM_1_WIRE_RESET		0x0042
+#define COMM_BYTE_IO			0x0052
+#define COMM_MATCH_ACCESS		0x0064
+#define COMM_BLOCK_IO			0x0074
+#define COMM_READ_STRAIGHT		0x0080
+#define COMM_DO_RELEASE			0x6092
+#define COMM_SET_PATH			0x00A2
+#define COMM_WRITE_SRAM_PAGE		0x00B2
+#define COMM_WRITE_EPROM		0x00C4
+#define COMM_READ_CRC_PROT_PAGE		0x00D4
+#define COMM_READ_REDIRECT_PAGE_CRC	0x21E4
+#define COMM_SEARCH_ACCESS		0x00F4
+
+/* Communication command bits */
+#define COMM_TYPE			0x0008
+#define COMM_SE				0x0008
+#define COMM_D				0x0008
+#define COMM_Z				0x0008
+#define COMM_CH				0x0008
+#define COMM_SM				0x0008
+#define COMM_R				0x0008
+#define COMM_IM				0x0001
+
+#define COMM_PS				0x4000
+#define COMM_PST			0x4000
+#define COMM_CIB			0x4000
+#define COMM_RTS			0x4000
+#define COMM_DT				0x2000
+#define COMM_SPU			0x1000
+#define COMM_F				0x0800
+#define COMM_NTP			0x0400
+#define COMM_ICP			0x0200
+#define COMM_RST			0x0100
+
+#define PULSE_PROG			0x01
+#define PULSE_SPUE			0x02
+
+#define BRANCH_MAIN			0xCC
+#define BRANCH_AUX			0x33
+
+/*
+ * Duration of the strong pull-up pulse in milliseconds.
+ */
+#define PULLUP_PULSE_DURATION		750
+
+/* Status flags */
+#define ST_SPUA				0x01  /* Strong Pull-up is active */
+#define ST_PRGA				0x02  /* 12V programming pulse is being generated */
+#define ST_12VP				0x04  /* external 12V programming voltage is present */
+#define ST_PMOD				0x08  /* DS2490 powered from USB and external sources */
+#define ST_HALT				0x10  /* DS2490 is currently halted */
+#define ST_IDLE				0x20  /* DS2490 is currently idle */
+#define ST_EPOF				0x80
+
+#define SPEED_NORMAL			0x00
+#define SPEED_FLEXIBLE			0x01
+#define SPEED_OVERDRIVE			0x02
+
+#define NUM_EP				4
+#define EP_CONTROL			0
+#define EP_STATUS			1
+#define EP_DATA_OUT			2
+#define EP_DATA_IN			3
+
+struct ds_device
+{
+	struct list_head	ds_entry;
+
+	struct usb_device	*udev;
+	struct usb_interface	*intf;
+
+	int			ep[NUM_EP];
+
+	struct w1_bus_master	master;
+};
+
+struct ds_status
+{
+	u8			enable;
+	u8			speed;
+	u8			pullup_dur;
+	u8			ppuls_dur;
+	u8			pulldown_slew;
+	u8			write1_time;
+	u8			write0_time;
+	u8			reserved0;
+	u8			status;
+	u8			command0;
+	u8			command1;
+	u8			command_buffer_status;
+	u8			data_out_buffer_status;
+	u8			data_in_buffer_status;
+	u8			reserved1;
+	u8			reserved2;
+
+};
 
 static struct usb_device_id ds_id_table [] = {
 	{ USB_DEVICE(0x04fa, 0x2490) },
@@ -35,21 +164,12 @@ MODULE_DEVICE_TABLE(usb, ds_id_table);
 static int ds_probe(struct usb_interface *, const struct usb_device_id *);
 static void ds_disconnect(struct usb_interface *);
 
-int ds_touch_bit(struct ds_device *, u8, u8 *);
-int ds_read_byte(struct ds_device *, u8 *);
-int ds_read_bit(struct ds_device *, u8 *);
-int ds_write_byte(struct ds_device *, u8);
-int ds_write_bit(struct ds_device *, u8);
-static int ds_start_pulse(struct ds_device *, int);
-int ds_reset(struct ds_device *, struct ds_status *);
-struct ds_device * ds_get_device(void);
-void ds_put_device(struct ds_device *);
-
 static inline void ds_dump_status(unsigned char *, unsigned char *, int);
 static int ds_send_control(struct ds_device *, u16, u16);
-static int ds_send_control_mode(struct ds_device *, u16, u16);
 static int ds_send_control_cmd(struct ds_device *, u16, u16);
 
+static LIST_HEAD(ds_devices);
+static DECLARE_MUTEX(ds_mutex);
 
 static struct usb_driver ds_driver = {
 	.name =		"DS9490R",
@@ -58,20 +178,6 @@ static struct usb_driver ds_driver = {
 	.id_table =	ds_id_table,
 };
 
-static struct ds_device *ds_dev;
-
-struct ds_device * ds_get_device(void)
-{
-	if (ds_dev)
-		atomic_inc(&ds_dev->refcnt);
-	return ds_dev;
-}
-
-void ds_put_device(struct ds_device *dev)
-{
-	atomic_dec(&dev->refcnt);
-}
-
 static int ds_send_control_cmd(struct ds_device *dev, u16 value, u16 index)
 {
 	int err;
@@ -86,7 +192,7 @@ static int ds_send_control_cmd(struct ds
 
 	return err;
 }
-
+#if 0
 static int ds_send_control_mode(struct ds_device *dev, u16 value, u16 index)
 {
 	int err;
@@ -101,7 +207,7 @@ static int ds_send_control_mode(struct d
 
 	return err;
 }
-
+#endif
 static int ds_send_control(struct ds_device *dev, u16 value, u16 index)
 {
 	int err;
@@ -324,7 +430,7 @@ #endif
 		return 0;
 }
 
-int ds_reset(struct ds_device *dev, struct ds_status *st)
+static int ds_reset(struct ds_device *dev, struct ds_status *st)
 {
 	int err;
 
@@ -345,7 +451,7 @@ #endif
 }
 
 #if 0
-int ds_set_speed(struct ds_device *dev, int speed)
+static int ds_set_speed(struct ds_device *dev, int speed)
 {
 	int err;
 
@@ -395,7 +501,7 @@ #endif
 	return err;
 }
 
-int ds_touch_bit(struct ds_device *dev, u8 bit, u8 *tbit)
+static int ds_touch_bit(struct ds_device *dev, u8 bit, u8 *tbit)
 {
 	int err, count;
 	struct ds_status st;
@@ -427,7 +533,7 @@ int ds_touch_bit(struct ds_device *dev, 
 	return 0;
 }
 
-int ds_write_bit(struct ds_device *dev, u8 bit)
+static int ds_write_bit(struct ds_device *dev, u8 bit)
 {
 	int err;
 	struct ds_status st;
@@ -441,7 +547,7 @@ int ds_write_bit(struct ds_device *dev, 
 	return 0;
 }
 
-int ds_write_byte(struct ds_device *dev, u8 byte)
+static int ds_write_byte(struct ds_device *dev, u8 byte)
 {
 	int err;
 	struct ds_status st;
@@ -464,26 +570,7 @@ int ds_write_byte(struct ds_device *dev,
 	return !(byte == rbyte);
 }
 
-int ds_read_bit(struct ds_device *dev, u8 *bit)
-{
-	int err;
-
-	err = ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_SPUE);
-	if (err)
-		return err;
-
-	err = ds_send_control(dev, COMM_BIT_IO | COMM_IM | COMM_SPU | COMM_D, 0);
-	if (err)
-		return err;
-
-	err = ds_recv_data(dev, bit, sizeof(*bit));
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-int ds_read_byte(struct ds_device *dev, u8 *byte)
+static int ds_read_byte(struct ds_device *dev, u8 *byte)
 {
 	int err;
 	struct ds_status st;
@@ -501,7 +588,7 @@ int ds_read_byte(struct ds_device *dev, 
 	return 0;
 }
 
-int ds_read_block(struct ds_device *dev, u8 *buf, int len)
+static int ds_read_block(struct ds_device *dev, u8 *buf, int len)
 {
 	struct ds_status st;
 	int err;
@@ -527,7 +614,7 @@ int ds_read_block(struct ds_device *dev,
 	return err;
 }
 
-int ds_write_block(struct ds_device *dev, u8 *buf, int len)
+static int ds_write_block(struct ds_device *dev, u8 *buf, int len)
 {
 	int err;
 	struct ds_status st;
@@ -555,7 +642,7 @@ int ds_write_block(struct ds_device *dev
 
 #if 0
 
-int ds_search(struct ds_device *dev, u64 init, u64 *buf, u8 id_number, int conditional_search)
+static int ds_search(struct ds_device *dev, u64 init, u64 *buf, u8 id_number, int conditional_search)
 {
 	int err;
 	u16 value, index;
@@ -584,7 +671,7 @@ int ds_search(struct ds_device *dev, u64
 	return err/8;
 }
 
-int ds_match_access(struct ds_device *dev, u64 init)
+static int ds_match_access(struct ds_device *dev, u64 init)
 {
 	int err;
 	struct ds_status st;
@@ -604,7 +691,7 @@ int ds_match_access(struct ds_device *de
 	return 0;
 }
 
-int ds_set_path(struct ds_device *dev, u64 init)
+static int ds_set_path(struct ds_device *dev, u64 init)
 {
 	int err;
 	struct ds_status st;
@@ -630,45 +717,156 @@ int ds_set_path(struct ds_device *dev, u
 
 #endif  /*  0  */
 
+static u8 ds9490r_touch_bit(void *data, u8 bit)
+{
+	u8 ret;
+	struct ds_device *dev = data;
+
+	if (ds_touch_bit(dev, bit, &ret))
+		return 0;
+
+	return ret;
+}
+
+static void ds9490r_write_bit(void *data, u8 bit)
+{
+	struct ds_device *dev = data;
+
+	ds_write_bit(dev, bit);
+}
+
+static void ds9490r_write_byte(void *data, u8 byte)
+{
+	struct ds_device *dev = data;
+
+	ds_write_byte(dev, byte);
+}
+
+static u8 ds9490r_read_bit(void *data)
+{
+	struct ds_device *dev = data;
+	int err;
+	u8 bit = 0;
+
+	err = ds_touch_bit(dev, 1, &bit);
+	if (err)
+		return 0;
+
+	return bit & 1;
+}
+
+static u8 ds9490r_read_byte(void *data)
+{
+	struct ds_device *dev = data;
+	int err;
+	u8 byte = 0;
+
+	err = ds_read_byte(dev, &byte);
+	if (err)
+		return 0;
+
+	return byte;
+}
+
+static void ds9490r_write_block(void *data, const u8 *buf, int len)
+{
+	struct ds_device *dev = data;
+
+	ds_write_block(dev, (u8 *)buf, len);
+}
+
+static u8 ds9490r_read_block(void *data, u8 *buf, int len)
+{
+	struct ds_device *dev = data;
+	int err;
+
+	err = ds_read_block(dev, buf, len);
+	if (err < 0)
+		return 0;
+
+	return len;
+}
+
+static u8 ds9490r_reset(void *data)
+{
+	struct ds_device *dev = data;
+	struct ds_status st;
+	int err;
+
+	memset(&st, 0, sizeof(st));
+
+	err = ds_reset(dev, &st);
+	if (err)
+		return 1;
+
+	return 0;
+}
+
+static int ds_w1_init(struct ds_device *dev)
+{
+	memset(&dev->master, 0, sizeof(struct w1_bus_master));
+
+	dev->master.data	= dev;
+	dev->master.touch_bit	= &ds9490r_touch_bit;
+	dev->master.read_bit	= &ds9490r_read_bit;
+	dev->master.write_bit	= &ds9490r_write_bit;
+	dev->master.read_byte	= &ds9490r_read_byte;
+	dev->master.write_byte	= &ds9490r_write_byte;
+	dev->master.read_block	= &ds9490r_read_block;
+	dev->master.write_block	= &ds9490r_write_block;
+	dev->master.reset_bus	= &ds9490r_reset;
+
+	return w1_add_master_device(&dev->master);
+}
+
+static void ds_w1_fini(struct ds_device *dev)
+{
+	w1_remove_master_device(&dev->master);
+}
+
 static int ds_probe(struct usb_interface *intf,
 		    const struct usb_device_id *udev_id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_host_interface *iface_desc;
+	struct ds_device *dev;
 	int i, err;
 
-	ds_dev = kmalloc(sizeof(struct ds_device), GFP_KERNEL);
-	if (!ds_dev) {
+	dev = kmalloc(sizeof(struct ds_device), GFP_KERNEL);
+	if (!dev) {
 		printk(KERN_INFO "Failed to allocate new DS9490R structure.\n");
 		return -ENOMEM;
 	}
+	dev->udev = usb_get_dev(udev);
+	if (!dev->udev) {
+		err = -ENOMEM;
+		goto err_out_free;
+	}
+	memset(dev->ep, 0, sizeof(dev->ep));
 
-	ds_dev->udev = usb_get_dev(udev);
-	usb_set_intfdata(intf, ds_dev);
+	usb_set_intfdata(intf, dev);
 
-	err = usb_set_interface(ds_dev->udev, intf->altsetting[0].desc.bInterfaceNumber, 3);
+	err = usb_set_interface(dev->udev, intf->altsetting[0].desc.bInterfaceNumber, 3);
 	if (err) {
 		printk(KERN_ERR "Failed to set alternative setting 3 for %d interface: err=%d.\n",
 				intf->altsetting[0].desc.bInterfaceNumber, err);
-		return err;
+		goto err_out_clear;
 	}
 
-	err = usb_reset_configuration(ds_dev->udev);
+	err = usb_reset_configuration(dev->udev);
 	if (err) {
 		printk(KERN_ERR "Failed to reset configuration: err=%d.\n", err);
-		return err;
+		goto err_out_clear;
 	}
 
 	iface_desc = &intf->altsetting[0];
 	if (iface_desc->desc.bNumEndpoints != NUM_EP-1) {
 		printk(KERN_INFO "Num endpoints=%d. It is not DS9490R.\n", iface_desc->desc.bNumEndpoints);
-		return -ENODEV;
+		err = -EINVAL;
+		goto err_out_clear;
 	}
 
-	atomic_set(&ds_dev->refcnt, 0);
-	memset(ds_dev->ep, 0, sizeof(ds_dev->ep));
-
 	/*
 	 * This loop doesn'd show control 0 endpoint,
 	 * so we will fill only 1-3 endpoints entry.
@@ -676,54 +874,31 @@ static int ds_probe(struct usb_interface
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 
-		ds_dev->ep[i+1] = endpoint->bEndpointAddress;
-
+		dev->ep[i+1] = endpoint->bEndpointAddress;
+#if 0
 		printk("%d: addr=%x, size=%d, dir=%s, type=%x\n",
 			i, endpoint->bEndpointAddress, le16_to_cpu(endpoint->wMaxPacketSize),
 			(endpoint->bEndpointAddress & USB_DIR_IN)?"IN":"OUT",
 			endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK);
+#endif
 	}
 
-#if 0
-	{
-		int err, i;
-		u64 buf[3];
-		u64 init=0xb30000002078ee81ull;
-		struct ds_status st;
-
-		ds_reset(ds_dev, &st);
-		err = ds_search(ds_dev, init, buf, 3, 0);
-		if (err < 0)
-			return err;
-		for (i=0; i<err; ++i)
-			printk("%d: %llx\n", i, buf[i]);
-
-		printk("Resetting...\n");
-		ds_reset(ds_dev, &st);
-		printk("Setting path for %llx.\n", init);
-		err = ds_set_path(ds_dev, init);
-		if (err)
-			return err;
-		printk("Calling MATCH_ACCESS.\n");
-		err = ds_match_access(ds_dev, init);
-		if (err)
-			return err;
-
-		printk("Searching the bus...\n");
-		err = ds_search(ds_dev, init, buf, 3, 0);
-
-		printk("ds_search() returned %d\n", err);
-
-		if (err < 0)
-			return err;
-		for (i=0; i<err; ++i)
-			printk("%d: %llx\n", i, buf[i]);
+	err = ds_w1_init(dev);
+	if (err)
+		goto err_out_clear;
 
-		return 0;
-	}
-#endif
+	down(&ds_mutex);
+	list_add_tail(&dev->ds_entry, &ds_devices);
+	up(&ds_mutex);
 
 	return 0;
+
+err_out_clear:
+	usb_set_intfdata(intf, NULL);
+	usb_put_dev(dev->udev);
+err_out_free:
+	kfree(dev);
+	return err;
 }
 
 static void ds_disconnect(struct usb_interface *intf)
@@ -731,19 +906,19 @@ static void ds_disconnect(struct usb_int
 	struct ds_device *dev;
 
 	dev = usb_get_intfdata(intf);
-	usb_set_intfdata(intf, NULL);
+	if (!dev)
+		return;
 
-	while (atomic_read(&dev->refcnt)) {
-		printk(KERN_INFO "Waiting for DS to become free: refcnt=%d.\n",
-				atomic_read(&dev->refcnt));
+	down(&ds_mutex);
+	list_del(&dev->ds_entry);
+	up(&ds_mutex);
 
-		if (msleep_interruptible(1000))
-			flush_signals(current);
-	}
+	ds_w1_fini(dev);
+
+	usb_set_intfdata(intf, NULL);
 
 	usb_put_dev(dev->udev);
 	kfree(dev);
-	ds_dev = NULL;
 }
 
 static int ds_init(void)
@@ -769,27 +944,4 @@ module_exit(ds_fini);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
-
-EXPORT_SYMBOL(ds_touch_bit);
-EXPORT_SYMBOL(ds_read_byte);
-EXPORT_SYMBOL(ds_read_bit);
-EXPORT_SYMBOL(ds_read_block);
-EXPORT_SYMBOL(ds_write_byte);
-EXPORT_SYMBOL(ds_write_bit);
-EXPORT_SYMBOL(ds_write_block);
-EXPORT_SYMBOL(ds_reset);
-EXPORT_SYMBOL(ds_get_device);
-EXPORT_SYMBOL(ds_put_device);
-
-/*
- * This functions can be used for EEPROM programming,
- * when driver will be included into mainline this will
- * require uncommenting.
- */
-#if 0
-EXPORT_SYMBOL(ds_start_pulse);
-EXPORT_SYMBOL(ds_set_speed);
-EXPORT_SYMBOL(ds_detect);
-EXPORT_SYMBOL(ds_stop_pulse);
-EXPORT_SYMBOL(ds_search);
-#endif
+MODULE_DESCRIPTION("DS2490 USB <-> W1 bus master driver (DS9490*)");
diff --git a/drivers/w1/masters/ds_w1_bridge.c b/drivers/w1/masters/ds_w1_bridge.c
deleted file mode 100644
index 5d30783..0000000
--- a/drivers/w1/masters/ds_w1_bridge.c
+++ /dev/null
@@ -1,174 +0,0 @@
-/*
- *	ds_w1_bridge.c
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-
-#include "../w1.h"
-#include "../w1_int.h"
-#include "dscore.h"
-
-static struct ds_device *ds_dev;
-static struct w1_bus_master *ds_bus_master;
-
-static u8 ds9490r_touch_bit(void *data, u8 bit)
-{
-	u8 ret;
-	struct ds_device *dev = data;
-
-	if (ds_touch_bit(dev, bit, &ret))
-		return 0;
-
-	return ret;
-}
-
-static void ds9490r_write_bit(void *data, u8 bit)
-{
-	struct ds_device *dev = data;
-
-	ds_write_bit(dev, bit);
-}
-
-static void ds9490r_write_byte(void *data, u8 byte)
-{
-	struct ds_device *dev = data;
-
-	ds_write_byte(dev, byte);
-}
-
-static u8 ds9490r_read_bit(void *data)
-{
-	struct ds_device *dev = data;
-	int err;
-	u8 bit = 0;
-
-	err = ds_touch_bit(dev, 1, &bit);
-	if (err)
-		return 0;
-	//err = ds_read_bit(dev, &bit);
-	//if (err)
-	//	return 0;
-
-	return bit & 1;
-}
-
-static u8 ds9490r_read_byte(void *data)
-{
-	struct ds_device *dev = data;
-	int err;
-	u8 byte = 0;
-
-	err = ds_read_byte(dev, &byte);
-	if (err)
-		return 0;
-
-	return byte;
-}
-
-static void ds9490r_write_block(void *data, const u8 *buf, int len)
-{
-	struct ds_device *dev = data;
-
-	ds_write_block(dev, (u8 *)buf, len);
-}
-
-static u8 ds9490r_read_block(void *data, u8 *buf, int len)
-{
-	struct ds_device *dev = data;
-	int err;
-
-	err = ds_read_block(dev, buf, len);
-	if (err < 0)
-		return 0;
-
-	return len;
-}
-
-static u8 ds9490r_reset(void *data)
-{
-	struct ds_device *dev = data;
-	struct ds_status st;
-	int err;
-
-	memset(&st, 0, sizeof(st));
-
-	err = ds_reset(dev, &st);
-	if (err)
-		return 1;
-
-	return 0;
-}
-
-static int __devinit ds_w1_init(void)
-{
-	int err;
-
-	ds_bus_master = kmalloc(sizeof(*ds_bus_master), GFP_KERNEL);
-	if (!ds_bus_master) {
-		printk(KERN_ERR "Failed to allocate DS9490R USB<->W1 bus_master structure.\n");
-		return -ENOMEM;
-	}
-
-	ds_dev = ds_get_device();
-	if (!ds_dev) {
-		printk(KERN_ERR "DS9490R is not registered.\n");
-		err =  -ENODEV;
-		goto err_out_free_bus_master;
-	}
-
-	memset(ds_bus_master, 0, sizeof(*ds_bus_master));
-
-	ds_bus_master->data		= ds_dev;
-	ds_bus_master->touch_bit	= &ds9490r_touch_bit;
-	ds_bus_master->read_bit		= &ds9490r_read_bit;
-	ds_bus_master->write_bit	= &ds9490r_write_bit;
-	ds_bus_master->read_byte	= &ds9490r_read_byte;
-	ds_bus_master->write_byte	= &ds9490r_write_byte;
-	ds_bus_master->read_block	= &ds9490r_read_block;
-	ds_bus_master->write_block	= &ds9490r_write_block;
-	ds_bus_master->reset_bus	= &ds9490r_reset;
-
-	err = w1_add_master_device(ds_bus_master);
-	if (err)
-		goto err_out_put_device;
-
-	return 0;
-
-err_out_put_device:
-	ds_put_device(ds_dev);
-err_out_free_bus_master:
-	kfree(ds_bus_master);
-
-	return err;
-}
-
-static void __devexit ds_w1_fini(void)
-{
-	w1_remove_master_device(ds_bus_master);
-	ds_put_device(ds_dev);
-	kfree(ds_bus_master);
-}
-
-module_init(ds_w1_init);
-module_exit(ds_w1_fini);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
diff --git a/drivers/w1/masters/dscore.h b/drivers/w1/masters/dscore.h
deleted file mode 100644
index 6cf5671..0000000
--- a/drivers/w1/masters/dscore.h
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- *	dscore.h
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef __DSCORE_H
-#define __DSCORE_H
-
-#include <linux/usb.h>
-#include <asm/atomic.h>
-
-/* COMMAND TYPE CODES */
-#define CONTROL_CMD			0x00
-#define COMM_CMD			0x01
-#define MODE_CMD			0x02
-
-/* CONTROL COMMAND CODES */
-#define CTL_RESET_DEVICE		0x0000
-#define CTL_START_EXE			0x0001
-#define CTL_RESUME_EXE			0x0002
-#define CTL_HALT_EXE_IDLE		0x0003
-#define CTL_HALT_EXE_DONE		0x0004
-#define CTL_FLUSH_COMM_CMDS		0x0007
-#define CTL_FLUSH_RCV_BUFFER		0x0008
-#define CTL_FLUSH_XMT_BUFFER		0x0009
-#define CTL_GET_COMM_CMDS		0x000A
-
-/* MODE COMMAND CODES */
-#define MOD_PULSE_EN			0x0000
-#define MOD_SPEED_CHANGE_EN		0x0001
-#define MOD_1WIRE_SPEED			0x0002
-#define MOD_STRONG_PU_DURATION		0x0003
-#define MOD_PULLDOWN_SLEWRATE		0x0004
-#define MOD_PROG_PULSE_DURATION		0x0005
-#define MOD_WRITE1_LOWTIME		0x0006
-#define MOD_DSOW0_TREC			0x0007
-
-/* COMMUNICATION COMMAND CODES */
-#define COMM_ERROR_ESCAPE		0x0601
-#define COMM_SET_DURATION		0x0012
-#define COMM_BIT_IO			0x0020
-#define COMM_PULSE			0x0030
-#define COMM_1_WIRE_RESET		0x0042
-#define COMM_BYTE_IO			0x0052
-#define COMM_MATCH_ACCESS		0x0064
-#define COMM_BLOCK_IO			0x0074
-#define COMM_READ_STRAIGHT		0x0080
-#define COMM_DO_RELEASE			0x6092
-#define COMM_SET_PATH			0x00A2
-#define COMM_WRITE_SRAM_PAGE		0x00B2
-#define COMM_WRITE_EPROM		0x00C4
-#define COMM_READ_CRC_PROT_PAGE		0x00D4
-#define COMM_READ_REDIRECT_PAGE_CRC	0x21E4
-#define COMM_SEARCH_ACCESS		0x00F4
-
-/* Communication command bits */
-#define COMM_TYPE			0x0008
-#define COMM_SE				0x0008
-#define COMM_D				0x0008
-#define COMM_Z				0x0008
-#define COMM_CH				0x0008
-#define COMM_SM				0x0008
-#define COMM_R				0x0008
-#define COMM_IM				0x0001
-
-#define COMM_PS				0x4000
-#define COMM_PST			0x4000
-#define COMM_CIB			0x4000
-#define COMM_RTS			0x4000
-#define COMM_DT				0x2000
-#define COMM_SPU			0x1000
-#define COMM_F				0x0800
-#define COMM_NTP			0x0400
-#define COMM_ICP			0x0200
-#define COMM_RST			0x0100
-
-#define PULSE_PROG			0x01
-#define PULSE_SPUE			0x02
-
-#define BRANCH_MAIN			0xCC
-#define BRANCH_AUX			0x33
-
-/*
- * Duration of the strong pull-up pulse in milliseconds.
- */
-#define PULLUP_PULSE_DURATION		750
-
-/* Status flags */
-#define ST_SPUA				0x01  /* Strong Pull-up is active */
-#define ST_PRGA				0x02  /* 12V programming pulse is being generated */
-#define ST_12VP				0x04  /* external 12V programming voltage is present */
-#define ST_PMOD				0x08  /* DS2490 powered from USB and external sources */
-#define ST_HALT				0x10  /* DS2490 is currently halted */
-#define ST_IDLE				0x20  /* DS2490 is currently idle */
-#define ST_EPOF				0x80
-
-#define SPEED_NORMAL			0x00
-#define SPEED_FLEXIBLE			0x01
-#define SPEED_OVERDRIVE			0x02
-
-#define NUM_EP				4
-#define EP_CONTROL			0
-#define EP_STATUS			1
-#define EP_DATA_OUT			2
-#define EP_DATA_IN			3
-
-struct ds_device
-{
-	struct usb_device	*udev;
-	struct usb_interface	*intf;
-
-	int			ep[NUM_EP];
-
-	atomic_t		refcnt;
-};
-
-struct ds_status
-{
-	u8			enable;
-	u8			speed;
-	u8			pullup_dur;
-	u8			ppuls_dur;
-	u8			pulldown_slew;
-	u8			write1_time;
-	u8			write0_time;
-	u8			reserved0;
-	u8			status;
-	u8			command0;
-	u8			command1;
-	u8			command_buffer_status;
-	u8			data_out_buffer_status;
-	u8			data_in_buffer_status;
-	u8			reserved1;
-	u8			reserved2;
-
-};
-
-int ds_touch_bit(struct ds_device *, u8, u8 *);
-int ds_read_byte(struct ds_device *, u8 *);
-int ds_read_bit(struct ds_device *, u8 *);
-int ds_write_byte(struct ds_device *, u8);
-int ds_write_bit(struct ds_device *, u8);
-int ds_reset(struct ds_device *, struct ds_status *);
-struct ds_device * ds_get_device(void);
-void ds_put_device(struct ds_device *);
-int ds_write_block(struct ds_device *, u8 *, int);
-int ds_read_block(struct ds_device *, u8 *, int);
-
-#endif /* __DSCORE_H */
-
-- 
1.4.0


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbUK2Bxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbUK2Bxw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 20:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUK2Bxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 20:53:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42251 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261616AbUK2Bw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 20:52:59 -0500
Date: Mon, 29 Nov 2004 02:52:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/w1/: possible cleanups
Message-ID: <20041129015257.GN4390@stusta.de>
References: <1101108672.2843.55.camel@uganda> <20041122133344.GA19419@stusta.de> <1101140745.9784.7.camel@uganda> <20041122165145.GH19419@stusta.de> <1101143109.9784.9.camel@uganda> <20041122171956.GI19419@stusta.de> <1101145020.9784.17.camel@uganda> <20041123002028.GN19419@stusta.de> <1101206052.9784.26.camel@uganda> <20041125155614.GD3537@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125155614.GD3537@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below includes the following possible cleanups:
- make needlessly global code static
- remove unused code

Please review and comment which parts are correct and which conflict 
with pending changes that will add in-kernel users for the functions in 
question.


diffstat output:
 drivers/w1/dscore.c    |  103 +++++++++++------------------------------
 drivers/w1/dscore.h    |    7 --
 drivers/w1/w1.c        |   25 ++++-----
 drivers/w1/w1.h        |    1 
 drivers/w1/w1_family.c |   16 +-----
 drivers/w1/w1_family.h |    2 
 drivers/w1/w1_int.c    |    7 --
 drivers/w1/w1_int.h    |    2 
 drivers/w1/w1_io.c     |   13 ++---
 drivers/w1/w1_io.h     |    3 -
 10 files changed, 51 insertions(+), 128 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.h.old	2004-11-29 02:07:27.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.h	2004-11-29 02:12:44.000000000 +0100
@@ -156,14 +156,7 @@
 int ds_read_bit(struct ds_device *, u8 *);
 int ds_write_byte(struct ds_device *, u8);
 int ds_write_bit(struct ds_device *, u8);
-int ds_start_pulse(struct ds_device *, int);
-int ds_set_speed(struct ds_device *, int);
 int ds_reset(struct ds_device *, struct ds_status *);
-int ds_detect(struct ds_device *, struct ds_status *);
-int ds_stop_pulse(struct ds_device *, int);
-int ds_send_data(struct ds_device *, unsigned char *, int);
-int ds_recv_data(struct ds_device *, unsigned char *, int);
-int ds_recv_status(struct ds_device *, struct ds_status *);
 struct ds_device * ds_get_device(void);
 void ds_put_device(struct ds_device *);
 int ds_write_block(struct ds_device *, u8 *, int);
--- linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.c.old	2004-11-29 02:07:43.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.c	2004-11-29 02:24:28.000000000 +0100
@@ -32,22 +32,19 @@
 };
 MODULE_DEVICE_TABLE(usb, ds_id_table);
 
-int ds_probe(struct usb_interface *, const struct usb_device_id *);
-void ds_disconnect(struct usb_interface *);
+static int ds_probe(struct usb_interface *, const struct usb_device_id *);
+static void ds_disconnect(struct usb_interface *);
 
 int ds_touch_bit(struct ds_device *, u8, u8 *);
 int ds_read_byte(struct ds_device *, u8 *);
 int ds_read_bit(struct ds_device *, u8 *);
 int ds_write_byte(struct ds_device *, u8);
 int ds_write_bit(struct ds_device *, u8);
-int ds_start_pulse(struct ds_device *, int);
-int ds_set_speed(struct ds_device *, int);
+static int ds_start_pulse(struct ds_device *, int);
 int ds_reset(struct ds_device *, struct ds_status *);
-int ds_detect(struct ds_device *, struct ds_status *);
-int ds_stop_pulse(struct ds_device *, int);
-int ds_send_data(struct ds_device *, unsigned char *, int);
-int ds_recv_data(struct ds_device *, unsigned char *, int);
-int ds_recv_status(struct ds_device *, struct ds_status *);
+static int ds_send_data(struct ds_device *, unsigned char *, int);
+static int ds_recv_data(struct ds_device *, unsigned char *, int);
+static int ds_recv_status(struct ds_device *, struct ds_status *);
 struct ds_device * ds_get_device(void);
 void ds_put_device(struct ds_device *);
 
@@ -129,7 +126,7 @@
 	printk("%45s: %8x\n", str, buf[off]);
 }
 
-int ds_recv_status_nodump(struct ds_device *dev, struct ds_status *st, unsigned char *buf, int size)
+static int ds_recv_status_nodump(struct ds_device *dev, struct ds_status *st, unsigned char *buf, int size)
 {
 	int count, err;
 		
@@ -148,7 +145,7 @@
 	return count;
 }
 
-int ds_recv_status(struct ds_device *dev, struct ds_status *st)
+static int ds_recv_status(struct ds_device *dev, struct ds_status *st)
 {
 	unsigned char buf[64];
 	int count, err = 0, i;
@@ -206,7 +203,7 @@
 	return err;
 }
 
-int ds_recv_data(struct ds_device *dev, unsigned char *buf, int size)
+static int ds_recv_data(struct ds_device *dev, unsigned char *buf, int size)
 {
 	int count, err;
 	struct ds_status st;
@@ -234,7 +231,7 @@
 	return count;
 }
 
-int ds_send_data(struct ds_device *dev, unsigned char *buf, int len)
+static int ds_send_data(struct ds_device *dev, unsigned char *buf, int len)
 {
 	int count, err;
 	
@@ -248,7 +245,8 @@
 	return err;
 }
 
-int ds_stop_pulse(struct ds_device *dev, int limit)
+#if 0
+static int ds_stop_pulse(struct ds_device *dev, int limit)
 {
 	struct ds_status st;
 	int count = 0, err = 0;
@@ -274,33 +272,9 @@
 
 	return err;
 }
+#endif
 
-int ds_detect(struct ds_device *dev, struct ds_status *st)
-{
-	int err;
-	
-	err = ds_send_control_cmd(dev, CTL_RESET_DEVICE, 0);
-	if (err)
-		return err;
-
-	err = ds_send_control(dev, COMM_SET_DURATION | COMM_IM, 0);
-	if (err)
-		return err;
-	
-	err = ds_send_control(dev, COMM_SET_DURATION | COMM_IM | COMM_TYPE, 0x40);
-	if (err)
-		return err;
-	
-	err = ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_PROG);
-	if (err)
-		return err;
-
-	err = ds_recv_status(dev, st);
-
-	return err;
-}
-
-int ds_wait_status(struct ds_device *dev, struct ds_status *st)
+static int ds_wait_status(struct ds_device *dev, struct ds_status *st)
 {
 	u8 buf[0x20];
 	int err, count = 0;
@@ -348,26 +322,7 @@
 	return 0;
 }
 
-int ds_set_speed(struct ds_device *dev, int speed)
-{
-	int err;
-	
-	if (speed != SPEED_NORMAL && speed != SPEED_FLEXIBLE && speed != SPEED_OVERDRIVE)
-		return -EINVAL;
-
-	if (speed != SPEED_OVERDRIVE)
-		speed = SPEED_FLEXIBLE;
-
-	speed &= 0xff;
-	
-	err = ds_send_control_mode(dev, MOD_1WIRE_SPEED, speed);
-	if (err)
-		return err;
-
-	return err;
-}
-
-int ds_start_pulse(struct ds_device *dev, int delay)
+static int ds_start_pulse(struct ds_device *dev, int delay)
 {
 	int err;
 	u8 del = 1 + (u8)(delay >> 4);
@@ -555,7 +510,8 @@
 	return !(err == len);
 }
 
-int ds_search(struct ds_device *dev, u64 init, u64 *buf, u8 id_number, int conditional_search)
+#if 0
+static int ds_search(struct ds_device *dev, u64 init, u64 *buf, u8 id_number, int conditional_search)
 {
 	int err;
 	u16 value, index;
@@ -583,8 +539,10 @@
 
 	return err/8;
 }
+#endif
 
-int ds_match_access(struct ds_device *dev, u64 init)
+#if 0
+static int ds_match_access(struct ds_device *dev, u64 init)
 {
 	int err;
 	struct ds_status st;
@@ -603,8 +561,10 @@
 
 	return 0;
 }
+#endif
 
-int ds_set_path(struct ds_device *dev, u64 init)
+#if 0
+static int ds_set_path(struct ds_device *dev, u64 init)
 {
 	int err;
 	struct ds_status st;
@@ -627,8 +587,9 @@
 
 	return 0;
 }
+#endif
 
-int ds_probe(struct usb_interface *intf, const struct usb_device_id *udev_id)
+static int ds_probe(struct usb_interface *intf, const struct usb_device_id *udev_id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_endpoint_descriptor *endpoint;
@@ -723,7 +684,7 @@
 	return 0;
 }
 
-void ds_disconnect(struct usb_interface *intf)
+static void ds_disconnect(struct usb_interface *intf)
 {
 	struct ds_device *dev;
 	
@@ -743,7 +704,7 @@
 	ds_dev = NULL;
 }
 
-int ds_init(void)
+static int ds_init(void)
 {
 	int err;
 
@@ -756,7 +717,7 @@
 	return 0;
 }
 
-void ds_fini(void)
+static void ds_fini(void)
 {
 	usb_deregister(&ds_driver);
 }
@@ -774,15 +735,7 @@
 EXPORT_SYMBOL(ds_write_byte);
 EXPORT_SYMBOL(ds_write_bit);
 EXPORT_SYMBOL(ds_write_block);
-EXPORT_SYMBOL(ds_start_pulse);
-EXPORT_SYMBOL(ds_set_speed);
 EXPORT_SYMBOL(ds_reset);
-EXPORT_SYMBOL(ds_detect);
-EXPORT_SYMBOL(ds_stop_pulse);
-EXPORT_SYMBOL(ds_send_data);
-EXPORT_SYMBOL(ds_recv_data);
-EXPORT_SYMBOL(ds_recv_status);
-EXPORT_SYMBOL(ds_search);
 EXPORT_SYMBOL(ds_get_device);
 EXPORT_SYMBOL(ds_put_device);
 
--- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_int.h.old	2004-11-29 02:19:06.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_int.h	2004-11-29 02:19:32.000000000 +0100
@@ -27,8 +27,6 @@
 
 #include "w1.h"
 
-struct w1_master * w1_alloc_dev(u32, int, int, struct device_driver *, struct device *);
-void w1_free_dev(struct w1_master *dev);
 int w1_add_master_device(struct w1_bus_master *);
 void w1_remove_master_device(struct w1_bus_master *);
 void __w1_remove_master_device(struct w1_master *);
--- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_int.c.old	2004-11-29 02:13:29.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_int.c	2004-11-29 02:19:40.000000000 +0100
@@ -30,7 +30,6 @@
 static u32 w1_ids = 1;
 
 extern struct device_driver w1_driver;
-extern struct bus_type w1_bus_type;
 extern struct device w1_device;
 extern int w1_max_slave_count;
 extern int w1_max_slave_ttl;
@@ -39,7 +38,7 @@
 
 extern int w1_process(void *);
 
-struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
+static struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 	      struct device_driver *driver, struct device *device)
 {
 	struct w1_master *dev;
@@ -109,7 +108,7 @@
 	return dev;
 }
 
-void w1_free_dev(struct w1_master *dev)
+static void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
 	if (dev->nls->sk_socket)
@@ -220,8 +219,6 @@
 	__w1_remove_master_device(dev);
 }
 
-EXPORT_SYMBOL(w1_alloc_dev);
-EXPORT_SYMBOL(w1_free_dev);
 EXPORT_SYMBOL(w1_add_master_device);
 EXPORT_SYMBOL(w1_remove_master_device);
 EXPORT_SYMBOL(__w1_remove_master_device);
--- linux-2.6.10-rc2-mm3-full/drivers/w1/w1.h.old	2004-11-29 02:14:36.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1.h	2004-11-29 02:14:40.000000000 +0100
@@ -126,7 +126,6 @@
 };
 
 int w1_create_master_attributes(struct w1_master *);
-void w1_destroy_master_attributes(struct w1_master *);
 
 #endif /* __KERNEL__ */
 
--- linux-2.6.10-rc2-mm3-full/drivers/w1/w1.c.old	2004-11-29 02:13:43.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1.c	2004-11-29 02:16:47.000000000 +0100
@@ -101,7 +101,7 @@
 	return sprintf(buf, "No family registered.\n");
 }
 
-struct bus_type w1_bus_type = {
+static struct bus_type w1_bus_type = {
 	.name = "w1",
 	.match = w1_master_match,
 };
@@ -139,7 +139,7 @@
 	.show = &w1_default_read_name,
 };
 
-ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of (dev, struct w1_master, dev);
 	ssize_t count;
@@ -154,7 +154,7 @@
 	return count;
 }
 
-ssize_t w1_master_attribute_show_pointer(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_pointer(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -168,14 +168,14 @@
 	return count;
 }
 
-ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
 {
 	ssize_t count;
 	count = sprintf(buf, "%d\n", w1_timeout);
 	return count;
 }
 
-ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -189,7 +189,7 @@
 	return count;
 }
 
-ssize_t w1_master_attribute_show_attempts(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_attempts(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -203,7 +203,7 @@
 	return count;
 }
 
-ssize_t w1_master_attribute_show_slave_count(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_slave_count(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -217,7 +217,7 @@
 	return count;
 }
 
-ssize_t w1_master_attribute_show_slaves(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_slaves(struct device *dev, char *buf)
 
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
@@ -600,7 +600,7 @@
 	return 0;
 }
 
-void w1_destroy_master_attributes(struct w1_master *dev)
+static void w1_destroy_master_attributes(struct w1_master *dev)
 {
 	device_remove_file(&dev->dev, &w1_master_attribute_slaves);
 	device_remove_file(&dev->dev, &w1_master_attribute_slave_count);
@@ -612,7 +612,7 @@
 }
 
 
-int w1_control(void *data)
+static int w1_control(void *data)
 {
 	struct w1_slave *sl;
 	struct w1_master *dev;
@@ -749,7 +749,7 @@
 	return 0;
 }
 
-int w1_init(void)
+static int w1_init(void)
 {
 	int retval;
 
@@ -789,7 +789,7 @@
 	return retval;
 }
 
-void w1_fini(void)
+static void w1_fini(void)
 {
 	struct w1_master *dev;
 	struct list_head *ent, *n;
@@ -811,4 +811,3 @@
 module_exit(w1_fini);
 
 EXPORT_SYMBOL(w1_create_master_attributes);
-EXPORT_SYMBOL(w1_destroy_master_attributes);
--- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_family.h.old	2004-11-29 02:17:17.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_family.h	2004-11-29 02:18:19.000000000 +0100
@@ -54,10 +54,8 @@
 
 extern spinlock_t w1_flock;
 
-void w1_family_get(struct w1_family *);
 void w1_family_put(struct w1_family *);
 void __w1_family_get(struct w1_family *);
-void __w1_family_put(struct w1_family *);
 struct w1_family * w1_family_registered(u8);
 void w1_unregister_family(struct w1_family *);
 int w1_register_family(struct w1_family *);
--- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_family.c.old	2004-11-29 02:17:29.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_family.c	2004-11-29 02:18:38.000000000 +0100
@@ -115,25 +115,17 @@
 	return (ret) ? f : NULL;
 }
 
-void w1_family_put(struct w1_family *f)
-{
-	spin_lock(&w1_flock);
-	__w1_family_put(f);
-	spin_unlock(&w1_flock);
-}
-
-void __w1_family_put(struct w1_family *f)
+static void __w1_family_put(struct w1_family *f)
 {
 	if (atomic_dec_and_test(&f->refcnt))
 		f->need_exit = 1;
 }
 
-void w1_family_get(struct w1_family *f)
+void w1_family_put(struct w1_family *f)
 {
 	spin_lock(&w1_flock);
-	__w1_family_get(f);
+	__w1_family_put(f);
 	spin_unlock(&w1_flock);
-
 }
 
 void __w1_family_get(struct w1_family *f)
@@ -141,10 +133,8 @@
 	atomic_inc(&f->refcnt);
 }
 
-EXPORT_SYMBOL(w1_family_get);
 EXPORT_SYMBOL(w1_family_put);
 EXPORT_SYMBOL(__w1_family_get);
-EXPORT_SYMBOL(__w1_family_put);
 EXPORT_SYMBOL(w1_family_registered);
 EXPORT_SYMBOL(w1_unregister_family);
 EXPORT_SYMBOL(w1_register_family);
--- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_io.h.old	2004-11-29 02:19:54.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_io.h	2004-11-29 02:21:08.000000000 +0100
@@ -24,12 +24,9 @@
 
 #include "w1.h"
 
-void w1_delay(unsigned long);
 u8 w1_touch_bit(struct w1_master *, int);
 void w1_write_bit(struct w1_master *, int);
 void w1_write_8(struct w1_master *, u8);
-u8 w1_read_bit(struct w1_master *);
-u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, u8 *, int);
--- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_io.c.old	2004-11-29 02:20:11.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_io.c	2004-11-29 02:21:39.000000000 +0100
@@ -28,7 +28,9 @@
 #include "w1_log.h"
 #include "w1_io.h"
 
-int w1_delay_parm = 1;
+static u8 w1_read_bit(struct w1_master *dev);
+
+static int w1_delay_parm = 1;
 module_param_named(delay_coef, w1_delay_parm, int, 0);
 
 static u8 w1_crc8_table[] = {
@@ -50,7 +52,7 @@
 	116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
 };
 
-void w1_delay(unsigned long tm)
+static void w1_delay(unsigned long tm)
 {
 	udelay(tm * w1_delay_parm);
 }
@@ -89,7 +91,7 @@
 			w1_write_bit(dev, (byte >> i) & 0x1);
 }
 
-u8 w1_read_bit(struct w1_master *dev)
+static u8 w1_read_bit(struct w1_master *dev)
 {
 	int result;
 
@@ -104,7 +106,7 @@
 	return result & 0x1;
 }
 
-u8 w1_read_8(struct w1_master * dev)
+static u8 w1_read_8(struct w1_master * dev)
 {
 	int i;
 	u8 res = 0;
@@ -176,10 +178,7 @@
 
 EXPORT_SYMBOL(w1_write_bit);
 EXPORT_SYMBOL(w1_write_8);
-EXPORT_SYMBOL(w1_read_bit);
-EXPORT_SYMBOL(w1_read_8);
 EXPORT_SYMBOL(w1_reset_bus);
 EXPORT_SYMBOL(w1_calc_crc8);
-EXPORT_SYMBOL(w1_delay);
 EXPORT_SYMBOL(w1_read_block);
 EXPORT_SYMBOL(w1_write_block);


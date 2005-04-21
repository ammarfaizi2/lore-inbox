Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVDUHwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVDUHwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVDUHvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:51:00 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:46519 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261442AbVDUHaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:15 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 7/22] W1: bus operations cleanup
Date: Thu, 21 Apr 2005 02:13:56 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210213.57219.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: cleanup bus operations code:
    - have bus operatiions accept w1_master instead of unsigned long
      and drop data field from w1_bus_master so the structure can be
      statically allocated by driver implementing it;
    - rename w1_bus_master to w1_bus_ops to avoid confusion with
      w1_master;
    - separate master registering and allocation so drivers can set
      up proper link between private data and master and set useable
      master's name.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 ds_w1_bridge.c |   87 ++++++++++++++++++++++++++++---------------------------
 matrox_w1.c    |   64 +++++++++++++++++++++-------------------
 w1.c           |   36 +++--------------------
 w1.h           |   30 ++++++++-----------
 w1_int.c       |   89 +++++++++++++++++++--------------------------------------
 w1_int.h       |    8 ++---
 w1_io.c        |   54 ++++++++++++++++++----------------
 7 files changed, 160 insertions(+), 208 deletions(-)

Index: dtor/drivers/w1/ds_w1_bridge.c
===================================================================
--- dtor.orig/drivers/w1/ds_w1_bridge.c
+++ dtor/drivers/w1/ds_w1_bridge.c
@@ -27,12 +27,12 @@
 #include "dscore.h"
 
 static struct ds_device *ds_dev;
-static struct w1_bus_master *ds_bus_master;
+static struct w1_master *ds_master;
 
-static u8 ds9490r_touch_bit(unsigned long data, u8 bit)
+static u8 ds9490r_touch_bit(struct w1_master *master, u8 bit)
 {
+	struct ds_device *dev = master->private;
 	u8 ret;
-	struct ds_device *dev = (struct ds_device *)data;
 
 	if (ds_touch_bit(dev, bit, &ret))
 		return 0;
@@ -40,23 +40,23 @@ static u8 ds9490r_touch_bit(unsigned lon
 	return ret;
 }
 
-static void ds9490r_write_bit(unsigned long data, u8 bit)
+static void ds9490r_write_bit(struct w1_master *master, u8 bit)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = master->private;
 
 	ds_write_bit(dev, bit);
 }
 
-static void ds9490r_write_byte(unsigned long data, u8 byte)
+static void ds9490r_write_byte(struct w1_master *master, u8 byte)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = master->private;
 
 	ds_write_byte(dev, byte);
 }
 
-static u8 ds9490r_read_bit(unsigned long data)
+static u8 ds9490r_read_bit(struct w1_master *master)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = master->private;
 	int err;
 	u8 bit = 0;
 
@@ -70,9 +70,9 @@ static u8 ds9490r_read_bit(unsigned long
 	return bit & 1;
 }
 
-static u8 ds9490r_read_byte(unsigned long data)
+static u8 ds9490r_read_byte(struct w1_master *master)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = master->private;
 	int err;
 	u8 byte = 0;
 
@@ -83,16 +83,16 @@ static u8 ds9490r_read_byte(unsigned lon
 	return byte;
 }
 
-static void ds9490r_write_block(unsigned long data, u8 *buf, int len)
+static void ds9490r_write_block(struct w1_master *master, u8 *buf, int len)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = master->private;
 
 	ds_write_block(dev, buf, len);
 }
 
-static u8 ds9490r_read_block(unsigned long data, u8 *buf, int len)
+static u8 ds9490r_read_block(struct w1_master *master, u8 *buf, int len)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = master->private;
 	int err;
 
 	err = ds_read_block(dev, buf, len);
@@ -102,9 +102,9 @@ static u8 ds9490r_read_block(unsigned lo
 	return len;
 }
 
-static u8 ds9490r_reset(unsigned long data)
+static u8 ds9490r_reset(struct w1_master *master)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = master->private;
 	struct ds_status st;
 	int err;
 
@@ -112,59 +112,60 @@ static u8 ds9490r_reset(unsigned long da
 
 	err = ds_reset(dev, &st);
 	if (err)
-		return 1;
+		return -1;
 
 	return 0;
 }
 
+static struct w1_bus_ops ds_bus_ops = {
+	.touch_bit	= ds9490r_touch_bit,
+	.read_bit	= ds9490r_read_bit,
+	.write_bit	= ds9490r_write_bit,
+	.read_byte	= ds9490r_read_byte,
+	.write_byte	= ds9490r_write_byte,
+	.read_block	= ds9490r_read_block,
+	.write_block	= ds9490r_write_block,
+	.reset_bus	= ds9490r_reset,
+};
+
 static int __devinit ds_w1_init(void)
 {
 	int err;
 
-	ds_bus_master = kmalloc(sizeof(*ds_bus_master), GFP_KERNEL);
-	if (!ds_bus_master) {
-		printk(KERN_ERR "Failed to allocate DS9490R USB<->W1 bus_master structure.\n");
-		return -ENOMEM;
-	}
-
 	ds_dev = ds_get_device();
 	if (!ds_dev) {
 		printk(KERN_ERR "DS9490R is not registered.\n");
-		err =  -ENODEV;
-		goto err_out_free_bus_master;
+		return -ENODEV;
 	}
 
-	memset(ds_bus_master, 0, sizeof(*ds_bus_master));
+	ds_master = w1_allocate_master_device();
+	if (!ds_master) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
-	ds_bus_master->data		= (unsigned long)ds_dev;
-	ds_bus_master->touch_bit	= &ds9490r_touch_bit;
-	ds_bus_master->read_bit		= &ds9490r_read_bit;
-	ds_bus_master->write_bit	= &ds9490r_write_bit;
-	ds_bus_master->read_byte	= &ds9490r_read_byte;
-	ds_bus_master->write_byte	= &ds9490r_write_byte;
-	ds_bus_master->read_block	= &ds9490r_read_block;
-	ds_bus_master->write_block	= &ds9490r_write_block;
-	ds_bus_master->reset_bus	= &ds9490r_reset;
+	strlcpy(ds_master->name, "DS <-> 1-Wire Bridge",
+		sizeof(ds_master->name));
+	ds_master->bus_ops = &ds_bus_ops;
+	ds_master->private = ds_dev;
 
-	err = w1_add_master_device(ds_bus_master);
+	err = w1_add_master_device(ds_master);
 	if (err)
-		goto err_out_put_device;
+		goto err_out;
 
 	return 0;
 
-err_out_put_device:
+err_out:
+	kfree(ds_master);
 	ds_put_device(ds_dev);
-err_out_free_bus_master:
-	kfree(ds_bus_master);
 
 	return err;
 }
 
 static void __devexit ds_w1_fini(void)
 {
-	w1_remove_master_device(ds_bus_master);
+	w1_remove_master_device(ds_master);
 	ds_put_device(ds_dev);
-	kfree(ds_bus_master);
 }
 
 module_init(ds_w1_init);
Index: dtor/drivers/w1/w1_int.c
===================================================================
--- dtor.orig/drivers/w1/w1_int.c
+++ dtor/drivers/w1/w1_int.c
@@ -39,16 +39,14 @@ extern spinlock_t w1_mlock;
 
 extern int w1_process(void *);
 
-struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
-	      struct device_driver *driver, struct device *device)
+struct w1_master *w1_allocate_master_device(void)
 {
 	struct w1_master *dev;
-	int err;
 
 	/*
 	 * We are in process context(kernel thread), so can sleep.
 	 */
-	dev = kmalloc(sizeof(struct w1_master) + sizeof(struct w1_bus_master), GFP_KERNEL);
+	dev = kcalloc(1, sizeof(struct w1_master), GFP_KERNEL);
 	if (!dev) {
 		printk(KERN_ERR
 			"Failed to allocate %zd bytes for new w1 device.\n",
@@ -56,17 +54,10 @@ struct w1_master * w1_alloc_dev(u32 id, 
 		return NULL;
 	}
 
-	memset(dev, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
-
-	dev->bus_master = (struct w1_bus_master *)(dev + 1);
-
-	dev->max_slave_count	= slave_count;
-	dev->slave_count	= 0;
-	dev->attempts		= 0;
+	dev->max_slave_count	= w1_max_slave_count;
 	dev->kpid		= -1;
-	dev->initialized	= 0;
-	dev->id			= id;
-	dev->slave_ttl		= slave_ttl;
+	dev->id			= w1_ids++;
+	dev->slave_ttl		= w1_max_slave_ttl;
 
 	atomic_set(&dev->refcnt, 2);
 
@@ -76,30 +67,14 @@ struct w1_master * w1_alloc_dev(u32 id, 
 	init_completion(&dev->dev_released);
 	init_completion(&dev->dev_exited);
 
-	memcpy(&dev->dev, device, sizeof(struct device));
+	dev->dev = w1_device;
 	snprintf(dev->dev.bus_id, sizeof(dev->dev.bus_id),
 		  "w1_bus_master%u", dev->id);
-	snprintf(dev->name, sizeof(dev->name), "w1_bus_master%u", dev->id);
 
-	dev->driver = driver;
+	dev->driver = &w1_driver;
 
 	dev->groups = 23;
 	dev->seq = 1;
-	dev->nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
-	if (!dev->nls) {
-		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
-			NETLINK_NFLOG, dev->dev.bus_id);
-	}
-
-	err = device_register(&dev->dev);
-	if (err) {
-		printk(KERN_ERR "Failed to register master device. err=%d\n", err);
-		if (dev->nls && dev->nls->sk_socket)
-			sock_release(dev->nls->sk_socket);
-		memset(dev, 0, sizeof(struct w1_master));
-		kfree(dev);
-		dev = NULL;
-	}
 
 	return dev;
 }
@@ -109,35 +84,43 @@ void w1_free_dev(struct w1_master *dev)
 	device_unregister(&dev->dev);
 	if (dev->nls && dev->nls->sk_socket)
 		sock_release(dev->nls->sk_socket);
-	memset(dev, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
+	memset(dev, 0, sizeof(struct w1_master));
 	kfree(dev);
 }
 
-int w1_add_master_device(struct w1_bus_master *master)
+int w1_add_master_device(struct w1_master *dev)
 {
-	struct w1_master *dev;
-	int retval = 0;
+	int error;
 	struct w1_netlink_msg msg;
 
-	dev = w1_alloc_dev(w1_ids++, w1_max_slave_count, w1_max_slave_ttl, &w1_driver, &w1_device);
-	if (!dev)
-		return -ENOMEM;
+	dev->nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
+	if (!dev->nls) {
+		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
+			NETLINK_NFLOG, dev->dev.bus_id);
+		return -1;
+	}
+
+	error = device_register(&dev->dev);
+	if (error) {
+		printk(KERN_ERR "Failed to register master device. err=%d\n", error);
+		if (dev->nls && dev->nls->sk_socket)
+			sock_release(dev->nls->sk_socket);
+		return error;
+	}
 
 	dev->kpid = kernel_thread(&w1_process, dev, 0);
 	if (dev->kpid < 0) {
 		dev_err(&dev->dev,
 			 "Failed to create new kernel thread. err=%d\n",
 			 dev->kpid);
-		retval = dev->kpid;
+		error = dev->kpid;
 		goto err_out_free_dev;
 	}
 
-	retval =  w1_create_master_attributes(dev);
-	if (retval)
+	error = w1_create_master_attributes(dev);
+	if (error)
 		goto err_out_kill_thread;
 
-	memcpy(dev->bus_master, master, sizeof(struct w1_bus_master));
-
 	dev->initialized = 1;
 
 	spin_lock(&w1_mlock);
@@ -162,10 +145,10 @@ err_out_kill_thread:
 err_out_free_dev:
 	w1_free_dev(dev);
 
-	return retval;
+	return error;
 }
 
-void __w1_remove_master_device(struct w1_master *dev)
+void w1_remove_master_device(struct w1_master *dev)
 {
 	int err;
 	struct w1_netlink_msg msg;
@@ -193,18 +176,6 @@ void __w1_remove_master_device(struct w1
 	w1_free_dev(dev);
 }
 
-void w1_remove_master_device(struct w1_bus_master *bm)
-{
-	struct w1_master *dev;
-
-	list_for_each_entry(dev, &w1_masters, node)
-		if (dev->initialized && dev->bus_master->data == bm->data) {
-			__w1_remove_master_device(dev);
-			break;
-		}
-
-	printk(KERN_ERR "Device doesn't exist.\n");
-}
-
+EXPORT_SYMBOL(w1_allocate_master_device);
 EXPORT_SYMBOL(w1_add_master_device);
 EXPORT_SYMBOL(w1_remove_master_device);
Index: dtor/drivers/w1/matrox_w1.c
===================================================================
--- dtor.orig/drivers/w1/matrox_w1.c
+++ dtor/drivers/w1/matrox_w1.c
@@ -85,14 +85,10 @@ struct matrox_device
 
 	unsigned long phys_addr;
 	void __iomem *virt_addr;
-	unsigned long found;
 
-	struct w1_bus_master *bus_master;
+	struct w1_master *master;
 };
 
-static u8 matrox_w1_read_ddc_bit(unsigned long);
-static void matrox_w1_write_ddc_bit(unsigned long, u8);
-
 /*
  * These functions read and write DDC Data bit.
  *
@@ -122,10 +118,10 @@ static __inline__ void matrox_w1_write_r
 	wmb();
 }
 
-static void matrox_w1_write_ddc_bit(unsigned long data, u8 bit)
+static void matrox_w1_write_ddc_bit(struct w1_master *master, u8 bit)
 {
+	struct matrox_device *dev = master->private;
 	u8 ret;
-	struct matrox_device *dev = (struct matrox_device *) data;
 
 	if (bit)
 		bit = 0;
@@ -137,16 +133,18 @@ static void matrox_w1_write_ddc_bit(unsi
 	matrox_w1_write_reg(dev, MATROX_GET_DATA, 0x00);
 }
 
-static u8 matrox_w1_read_ddc_bit(unsigned long data)
+static u8 matrox_w1_read_ddc_bit(struct w1_master *master)
 {
-	u8 ret;
-	struct matrox_device *dev = (struct matrox_device *) data;
-
-	ret = matrox_w1_read_reg(dev, MATROX_GET_DATA);
+	struct matrox_device *dev = master->private;
 
-	return ret;
+	return matrox_w1_read_reg(dev, MATROX_GET_DATA);
 }
 
+static struct w1_bus_ops matrox_bus_ops = {
+	.read_bit	= matrox_w1_read_ddc_bit,
+	.write_bit	= matrox_w1_write_ddc_bit,
+};
+
 static void matrox_w1_hw_init(struct matrox_device *dev)
 {
 	matrox_w1_write_reg(dev, MATROX_GET_DATA, 0xFF);
@@ -156,6 +154,7 @@ static void matrox_w1_hw_init(struct mat
 static int __devinit matrox_w1_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct matrox_device *dev;
+	struct w1_master *master;
 	int err;
 
 	assert(pdev != NULL);
@@ -164,8 +163,7 @@ static int __devinit matrox_w1_probe(str
 	if (pdev->vendor != PCI_VENDOR_ID_MATROX || pdev->device != PCI_DEVICE_ID_MATROX_G400)
 		return -ENODEV;
 
-	dev = kmalloc(sizeof(struct matrox_device) +
-		       sizeof(struct w1_bus_master), GFP_KERNEL);
+	dev = kcalloc(1, sizeof(struct matrox_device), GFP_KERNEL);
 	if (!dev) {
 		dev_err(&pdev->dev,
 			"%s: Failed to create new matrox_device object.\n",
@@ -173,10 +171,6 @@ static int __devinit matrox_w1_probe(str
 		return -ENOMEM;
 	}
 
-	memset(dev, 0, sizeof(struct matrox_device) + sizeof(struct w1_bus_master));
-
-	dev->bus_master = (struct w1_bus_master *)(dev + 1);
-
 	/*
 	 * True for G400, for some other we need resource 0, see drivers/video/matrox/matroxfb_base.c
 	 */
@@ -196,24 +190,34 @@ static int __devinit matrox_w1_probe(str
 	dev->port_data = dev->base_addr + MATROX_PORT_DATA_OFFSET;
 	dev->data_mask = (MATROX_G400_DDC_DATA);
 
-	matrox_w1_hw_init(dev);
 
-	dev->bus_master->data = (unsigned long) dev;
-	dev->bus_master->read_bit = &matrox_w1_read_ddc_bit;
-	dev->bus_master->write_bit = &matrox_w1_write_ddc_bit;
+	dev->master = master = w1_allocate_master_device();
+	if (!master) {
+		err = -ENOMEM;
+		goto err_out_free_device;
+	}
+
+	strlcpy(master->name, "Matrox <-> 1-Wire Bridge",
+		sizeof(master->name));
+	master->bus_ops = &matrox_bus_ops;
+	master->private = dev;
+	master->dev.parent = &pdev->dev;
+
+	matrox_w1_hw_init(dev);
 
-	err = w1_add_master_device(dev->bus_master);
+	err = w1_add_master_device(master);
 	if (err)
-		goto err_out_free_device;
+		goto err_out_free_master;
 
 	pci_set_drvdata(pdev, dev);
 
-	dev->found = 1;
-
 	dev_info(&pdev->dev, "Matrox G400 GPIO transport layer for 1-wire.\n");
 
 	return 0;
 
+err_out_free_master:
+	kfree(master);
+
 err_out_free_device:
 	kfree(dev);
 
@@ -226,10 +230,8 @@ static void __devexit matrox_w1_remove(s
 
 	assert(dev != NULL);
 
-	if (dev->found) {
-		w1_remove_master_device(dev->bus_master);
-		iounmap(dev->virt_addr);
-	}
+	w1_remove_master_device(dev->master);
+	iounmap(dev->virt_addr);
 	kfree(dev);
 }
 
Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -125,7 +125,7 @@ static ssize_t w1_master_attribute_show_
 	if (down_interruptible(&md->mutex))
 		return -EBUSY;
 
-	count = sprintf(buf, "0x%p\n", md->bus_master);
+	count = sprintf(buf, "0x%p\n", md->private);
 
 	up(&md->mutex);
 	return count;
@@ -475,37 +475,13 @@ static void w1_slave_detach(struct w1_sl
 	w1_netlink_send(sl->master, &msg);
 }
 
-static struct w1_master *w1_search_master(unsigned long data)
-{
-	struct w1_master *master;
-	int found = 0;
-
-	spin_lock_irq(&w1_mlock);
-	list_for_each_entry(master, &w1_masters, node) {
-		if (master->bus_master->data == data) {
-			found = 1;
-			atomic_inc(&master->refcnt);
-			break;
-		}
-	}
-	spin_unlock_irq(&w1_mlock);
-
-	return found ? master : NULL;
-}
-
-void w1_slave_found(unsigned long data, u64 rn)
+void w1_slave_found(struct w1_master *dev, u64 rn)
 {
 	int slave_count;
 	struct w1_slave *slave;
 	struct w1_reg_num *tmp;
-	struct w1_master *dev;
 
-	dev = w1_search_master(data);
-	if (!dev) {
-		printk(KERN_ERR "Failed to find w1 master device for data %08lx, it is impossible.\n",
-				data);
-		return;
-	}
+	atomic_inc(&dev->refcnt);
 
 	tmp = (struct w1_reg_num *) &rn;
 
@@ -600,7 +576,7 @@ void w1_search(struct w1_master *dev)
 			 * and make all who don't have "search_bit" in "i"'th position
 			 * in it's registration number sleep.
 			 */
-			if (dev->bus_master->touch_bit)
+			if (dev->bus_ops->touch_bit)
 				w1_touch_bit(dev, search_bit);
 			else
 				w1_write_bit(dev, search_bit);
@@ -613,7 +589,7 @@ void w1_search(struct w1_master *dev)
 
 		desc_bit = last_zero;
 
-		w1_slave_found(dev->bus_master->data, rn);
+		w1_slave_found(dev, rn);
 	}
 }
 
@@ -772,7 +748,7 @@ void w1_fini(void)
 	struct w1_master *master, *next;
 
 	list_for_each_entry_safe(master, next, &w1_masters, node)
-		__w1_remove_master_device(master);
+		w1_remove_master_device(master);
 
 	control_needs_exit = 1;
 
Index: dtor/drivers/w1/w1_io.c
===================================================================
--- dtor.orig/drivers/w1/w1_io.c
+++ dtor/drivers/w1/w1_io.c
@@ -13,7 +13,7 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
+ ate*
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
@@ -57,23 +57,25 @@ void w1_delay(unsigned long tm)
 
 u8 w1_touch_bit(struct w1_master *dev, int bit)
 {
-	if (dev->bus_master->touch_bit)
-		return dev->bus_master->touch_bit(dev->bus_master->data, bit);
+	if (dev->bus_ops->touch_bit)
+		return dev->bus_ops->touch_bit(dev, bit);
 	else
 		return w1_read_bit(dev);
 }
 
 void w1_write_bit(struct w1_master *dev, int bit)
 {
+	struct w1_bus_ops *bus_ops = dev->bus_ops;
+
 	if (bit) {
-		dev->bus_master->write_bit(dev->bus_master->data, 0);
+		bus_ops->write_bit(dev, 0);
 		w1_delay(6);
-		dev->bus_master->write_bit(dev->bus_master->data, 1);
+		bus_ops->write_bit(dev, 1);
 		w1_delay(64);
 	} else {
-		dev->bus_master->write_bit(dev->bus_master->data, 0);
+		bus_ops->write_bit(dev, 0);
 		w1_delay(60);
-		dev->bus_master->write_bit(dev->bus_master->data, 1);
+		bus_ops->write_bit(dev, 1);
 		w1_delay(10);
 	}
 }
@@ -82,8 +84,8 @@ void w1_write_8(struct w1_master *dev, u
 {
 	int i;
 
-	if (dev->bus_master->write_byte)
-		dev->bus_master->write_byte(dev->bus_master->data, byte);
+	if (dev->bus_ops->write_byte)
+		dev->bus_ops->write_byte(dev, byte);
 	else
 		for (i = 0; i < 8; ++i)
 			w1_write_bit(dev, (byte >> i) & 0x1);
@@ -91,14 +93,15 @@ void w1_write_8(struct w1_master *dev, u
 
 u8 w1_read_bit(struct w1_master *dev)
 {
+	struct w1_bus_ops *bus_ops = dev->bus_ops;
 	int result;
 
-	dev->bus_master->write_bit(dev->bus_master->data, 0);
+	bus_ops->write_bit(dev, 0);
 	w1_delay(6);
-	dev->bus_master->write_bit(dev->bus_master->data, 1);
+	bus_ops->write_bit(dev, 1);
 	w1_delay(9);
 
-	result = dev->bus_master->read_bit(dev->bus_master->data);
+	result = bus_ops->read_bit(dev);
 	w1_delay(55);
 
 	return result & 0x1;
@@ -109,8 +112,8 @@ u8 w1_read_8(struct w1_master * dev)
 	int i;
 	u8 res = 0;
 
-	if (dev->bus_master->read_byte)
-		res = dev->bus_master->read_byte(dev->bus_master->data);
+	if (dev->bus_ops->read_byte)
+		res = dev->bus_ops->read_byte(dev);
 	else
 		for (i = 0; i < 8; ++i)
 			res |= (w1_read_bit(dev) << i);
@@ -122,8 +125,8 @@ void w1_write_block(struct w1_master *de
 {
 	int i;
 
-	if (dev->bus_master->write_block)
-		dev->bus_master->write_block(dev->bus_master->data, buf, len);
+	if (dev->bus_ops->write_block)
+		dev->bus_ops->write_block(dev, buf, len);
 	else
 		for (i = 0; i < len; ++i)
 			w1_write_8(dev, buf[i]);
@@ -134,8 +137,8 @@ u8 w1_read_block(struct w1_master *dev, 
 	int i;
 	u8 ret;
 
-	if (dev->bus_master->read_block)
-		ret = dev->bus_master->read_block(dev->bus_master->data, buf, len);
+	if (dev->bus_ops->read_block)
+		ret = dev->bus_ops->read_block(dev, buf, len);
 	else {
 		for (i = 0; i < len; ++i)
 			buf[i] = w1_read_8(dev);
@@ -147,17 +150,18 @@ u8 w1_read_block(struct w1_master *dev, 
 
 int w1_reset_bus(struct w1_master *dev)
 {
+	struct w1_bus_ops *bus_ops = dev->bus_ops;
 	int result = 0;
 
-	if (dev->bus_master->reset_bus)
-		result = dev->bus_master->reset_bus(dev->bus_master->data) & 0x1;
+	if (bus_ops->reset_bus)
+		result = bus_ops->reset_bus(dev) & 0x1;
 	else {
-		dev->bus_master->write_bit(dev->bus_master->data, 0);
+		bus_ops->write_bit(dev, 0);
 		w1_delay(480);
-		dev->bus_master->write_bit(dev->bus_master->data, 1);
+		bus_ops->write_bit(dev, 1);
 		w1_delay(70);
 
-		result = dev->bus_master->read_bit(dev->bus_master->data) & 0x1;
+		result = bus_ops->read_bit(dev) & 0x1;
 		w1_delay(410);
 	}
 
@@ -177,8 +181,8 @@ u8 w1_calc_crc8(u8 * data, int len)
 void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb)
 {
 	dev->attempts++;
-	if (dev->bus_master->search)
-		dev->bus_master->search(dev->bus_master->data, cb);
+	if (dev->bus_ops->search)
+		dev->bus_ops->search(dev, cb);
 	else
 		w1_search(dev);
 }
Index: dtor/drivers/w1/w1_int.h
===================================================================
--- dtor.orig/drivers/w1/w1_int.h
+++ dtor/drivers/w1/w1_int.h
@@ -24,13 +24,13 @@
 
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/err.h>
 
 #include "w1.h"
 
-struct w1_master * w1_alloc_dev(u32, int, int, struct device_driver *, struct device *);
+struct w1_master *w1_allocate_master_device(void);
 void w1_free_dev(struct w1_master *dev);
-int w1_add_master_device(struct w1_bus_master *);
-void w1_remove_master_device(struct w1_bus_master *);
-void __w1_remove_master_device(struct w1_master *);
+int w1_add_master_device(struct w1_master *);
+void w1_remove_master_device(struct w1_master *);
 
 #endif /* __W1_INT_H */
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -82,26 +82,25 @@ struct w1_slave
 };
 #define to_w1_slave(dev)	container_of((dev), struct w1_slave, dev)
 
-typedef void (* w1_slave_found_callback)(unsigned long, u64);
+struct w1_master;
+typedef void (*w1_slave_found_callback)(struct w1_master *, u64);
 
-struct w1_bus_master
+struct w1_bus_ops
 {
-	unsigned long		data;
+	u8			(*read_bit)(struct w1_master *);
+	void			(*write_bit)(struct w1_master *, u8);
 
-	u8			(*read_bit)(unsigned long);
-	void			(*write_bit)(unsigned long, u8);
+	u8			(*read_byte)(struct w1_master *);
+	void			(*write_byte)(struct w1_master *, u8);
 
-	u8			(*read_byte)(unsigned long);
-	void			(*write_byte)(unsigned long, u8);
+	u8			(*read_block)(struct w1_master *, u8 *, int);
+	void			(*write_block)(struct w1_master *, u8 *, int);
 
-	u8			(*read_block)(unsigned long, u8 *, int);
-	void			(*write_block)(unsigned long, u8 *, int);
+	u8			(*touch_bit)(struct w1_master *, u8);
 
-	u8			(*touch_bit)(unsigned long, u8);
+	u8			(*reset_bus)(struct w1_master *);
 
-	u8			(*reset_bus)(unsigned long);
-
-	void			(*search)(unsigned long, w1_slave_found_callback);
+	void			(*search)(struct w1_master *, w1_slave_found_callback);
 };
 
 struct w1_master
@@ -117,8 +116,7 @@ struct w1_master
 
 	atomic_t		refcnt;
 
-	void			*priv;
-	int			priv_size;
+	void			*private;
 
 	int			need_exit;
 	pid_t			kpid;
@@ -129,7 +127,7 @@ struct w1_master
 	struct completion	dev_released;
 	struct completion	dev_exited;
 
-	struct w1_bus_master	*bus_master;
+	struct w1_bus_ops	*bus_ops;
 
 	u32			seq, groups;
 	struct sock		*nls;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUATAd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUATAWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:22:17 -0500
Received: from mail.kroah.org ([65.200.24.183]:31404 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264391AbUATAAR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:17 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567661565@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:27 -0800
Message-Id: <10745567673681@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.26, 2004/01/19 15:06:56-08:00, greg@kroah.com

[PATCH] I2C: add I2C_DEBUG_CORE config option and convert the i2c core code to use it.

This cleans up the mismatch of ways we could enable debugging messages.


 drivers/i2c/Kconfig      |    8 +++
 drivers/i2c/i2c-core.c   |  110 +++++++++++++++++++++--------------------------
 drivers/i2c/i2c-dev.c    |   10 ++--
 drivers/i2c/i2c-sensor.c |    5 +-
 4 files changed, 69 insertions(+), 64 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Jan 19 15:28:09 2004
+++ b/drivers/i2c/Kconfig	Mon Jan 19 15:28:09 2004
@@ -41,5 +41,13 @@
 source drivers/i2c/busses/Kconfig
 source drivers/i2c/chips/Kconfig
 
+config I2C_DEBUG_CORE
+	bool "I2C Core debugging messages"
+	depends on I2C
+	help
+	  Say Y here if you want the I2C core to produce a bunch of debug
+	  messages to the system log.  Select this if you are having a
+	  problem with I2C support and want to see more of what is going on.
+
 endmenu
 
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Jan 19 15:28:09 2004
+++ b/drivers/i2c/i2c-core.c	Mon Jan 19 15:28:09 2004
@@ -23,7 +23,10 @@
 
 /* $Id: i2c-core.c,v 1.95 2003/01/22 05:25:08 kmalkki Exp $ */
 
-/* #define DEBUG 1 */		/* needed to pick up the dev_dbg() calls */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CORE
+#define DEBUG	1
+#endif
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -35,16 +38,10 @@
 #include <asm/uaccess.h>
 
 
-#define DEB(x) if (i2c_debug>=1) x;
-#define DEB2(x) if (i2c_debug>=2) x;
-
 static LIST_HEAD(adapters);
 static LIST_HEAD(drivers);
 static DECLARE_MUTEX(core_lists);
 
-/**** debug level */
-static int i2c_debug;
-
 int i2c_device_probe(struct device *dev)
 {
 	return -ENODEV;
@@ -162,7 +159,7 @@
 	}
 	up(&core_lists);
 
-	DEB(dev_dbg(&adap->dev, "registered as adapter #%d\n", adap->nr));
+	dev_dbg(&adap->dev, "registered as adapter #%d\n", adap->nr);
 	return 0;
 }
 
@@ -217,7 +214,7 @@
 	wait_for_completion(&adap->dev_released);
 	wait_for_completion(&adap->class_dev_released);
 
-	DEB(dev_dbg(&adap->dev, "adapter unregistered\n"));
+	dev_dbg(&adap->dev, "adapter unregistered\n");
 
  out_unlock:
 	up(&core_lists);
@@ -250,7 +247,7 @@
 		goto out_unlock;
 	
 	list_add_tail(&driver->list,&drivers);
-	DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
+	pr_debug("i2c-core: driver %s registered.\n", driver->name);
 
 	/* now look for instances of driver on our adapters */
 	if (driver->flags & I2C_DF_NOTIFY) {
@@ -279,14 +276,14 @@
 	 * attached. If so, detach them to be able to kill the driver 
 	 * afterwards.
 	 */
-	DEB2(printk(KERN_DEBUG "i2c-core.o: unregister_driver - looking for clients.\n"));
+	pr_debug("i2c-core: unregister_driver - looking for clients.\n");
 	/* removing clients does not depend on the notify flag, else 
 	 * invalid operation might (will!) result, when using stale client
 	 * pointers.
 	 */
 	list_for_each(item1,&adapters) {
 		adap = list_entry(item1, struct i2c_adapter, list);
-		DEB2(dev_dbg(&adap->dev, "examining adapter\n"));
+		dev_dbg(&adap->dev, "examining adapter\n");
 		if (driver->detach_adapter) {
 			if ((res = driver->detach_adapter(adap))) {
 				dev_warn(&adap->dev, "while unregistering "
@@ -300,9 +297,7 @@
 				client = list_entry(item2, struct i2c_client, list);
 				if (client->driver != driver)
 					continue;
-				DEB2(printk(KERN_DEBUG "i2c-core.o: "
-					    "detaching client %s:\n",
-					    client->name));
+				pr_debug("i2c-core.o: detaching client %s:\n", client->name);
 				if ((res = driver->detach_client(client))) {
 					dev_err(&adap->dev, "while "
 						"unregistering driver "
@@ -321,7 +316,7 @@
 
 	driver_unregister(&driver->driver);
 	list_del(&driver->list);
-	DEB(printk(KERN_DEBUG "i2c-core.o: driver unregistered: %s\n",driver->name));
+	pr_debug("i2c-core: driver unregistered: %s\n", driver->name);
 
  out_unlock:
 	up(&core_lists);
@@ -372,8 +367,8 @@
 		}
 	}
 
-	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter\n",
-			client->name));
+	dev_dbg(&adapter->dev, "client [%s] registered to adapter\n",
+		client->name);
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;
@@ -385,7 +380,7 @@
 	
 	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id),
 		"%d-%04x", i2c_adapter_id(adapter), client->addr);
-	printk("registering %s\n", client->dev.bus_id);
+	pr_debug("registering %s\n", client->dev.bus_id);
 	device_register(&client->dev);
 	device_create_file(&client->dev, &dev_attr_client_name);
 	
@@ -404,8 +399,8 @@
 	if (adapter->client_unregister)  {
 		res = adapter->client_unregister(client);
 		if (res) {
-			printk(KERN_ERR
-			       "i2c-core.o: client_unregister [%s] failed, "
+			dev_err(&client->dev,
+			       "client_unregister [%s] failed, "
 			       "client not detached", client->name);
 			goto out;
 		}
@@ -467,9 +462,9 @@
 	if(client->flags & I2C_CLIENT_ALLOW_USE) {
 		if(client->usage_count>0)
 			client->usage_count--;
-		else
-		{
-			printk(KERN_WARNING " i2c-core.o: dec_use_client used one too many times\n");
+		else {
+			pr_debug("i2c-core: %s used one too many times\n",
+				__FUNCTION__);
 			return -EPERM;
 		}
 	}
@@ -544,7 +539,7 @@
 	int ret;
 
 	if (adap->algo->master_xfer) {
- 	 	DEB2(dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n", num));
+ 	 	dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n", num);
 
 		down(&adap->bus_lock);
 		ret = adap->algo->master_xfer(adap,msgs,num);
@@ -552,7 +547,7 @@
 
 		return ret;
 	} else {
-		DEB2(dev_dbg(&adap->dev, "I2C level transfers not supported\n"));
+		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
 		return -ENOSYS;
 	}
 }
@@ -569,8 +564,8 @@
 		msg.len = count;
 		msg.buf = (char *)buf;
 	
-		DEB2(dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
-				count));
+		dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
+			count);
 	
 		down(&adap->bus_lock);
 		ret = adap->algo->master_xfer(adap,&msg,1);
@@ -598,15 +593,15 @@
 		msg.len = count;
 		msg.buf = buf;
 
-		DEB2(dev_dbg(&client->adapter->dev, "master_recv: reading %d bytes.\n",
-				count));
+		dev_dbg(&client->adapter->dev, "master_recv: reading %d bytes.\n",
+			count);
 	
 		down(&adap->bus_lock);
 		ret = adap->algo->master_xfer(adap,&msg,1);
 		up(&adap->bus_lock);
 	
-		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
-			ret, count, client->addr));
+		dev_dbg(&client->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
+			ret, count, client->addr);
 	
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
 	 	* transmitted, else error code.
@@ -625,8 +620,8 @@
 	int ret = 0;
 	struct i2c_adapter *adap = client->adapter;
 
-	DEB2(printk(KERN_DEBUG "i2c-core.o: i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg));
-	switch ( cmd ) {
+	dev_dbg(&client->dev, "i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg);
+	switch (cmd) {
 		case I2C_RETRIES:
 			adap->retries = arg;
 			break;
@@ -670,8 +665,8 @@
 			if (((adap_id == address_data->force[i]) || 
 			     (address_data->force[i] == ANY_I2C_BUS)) &&
 			     (addr == address_data->force[i+1])) {
-				DEB2(printk(KERN_DEBUG "i2c-core.o: found force parameter for adapter %d, addr %04x\n",
-				            adap_id,addr));
+				dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n",
+					adap_id, addr);
 				if ((err = found_proc(adapter,addr,0)))
 					return err;
 				found = 1;
@@ -688,8 +683,8 @@
 			if (((adap_id == address_data->ignore[i]) || 
 			    ((address_data->ignore[i] == ANY_I2C_BUS))) &&
 			    (addr == address_data->ignore[i+1])) {
-				DEB2(printk(KERN_DEBUG "i2c-core.o: found ignore parameter for adapter %d, "
-				     "addr %04x\n", adap_id ,addr));
+				dev_dbg(&adapter->dev, "found ignore parameter for adapter %d, "
+					"addr %04x\n", adap_id ,addr);
 				found = 1;
 			}
 		}
@@ -700,8 +695,8 @@
 			    ((address_data->ignore_range[i]==ANY_I2C_BUS))) &&
 			    (addr >= address_data->ignore_range[i+1]) &&
 			    (addr <= address_data->ignore_range[i+2])) {
-				DEB2(printk(KERN_DEBUG "i2c-core.o: found ignore_range parameter for adapter %d, "
-				            "addr %04x\n", adap_id,addr));
+				dev_dbg(&adapter->dev, "found ignore_range parameter for adapter %d, "
+					"addr %04x\n", adap_id,addr);
 				found = 1;
 			}
 		}
@@ -715,8 +710,8 @@
 		     i += 1) {
 			if (addr == address_data->normal_i2c[i]) {
 				found = 1;
-				DEB2(printk(KERN_DEBUG "i2c-core.o: found normal i2c entry for adapter %d, "
-				            "addr %02x", adap_id,addr));
+				dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, "
+					"addr %02x", adap_id,addr);
 			}
 		}
 
@@ -726,8 +721,8 @@
 			if ((addr >= address_data->normal_i2c_range[i]) &&
 			    (addr <= address_data->normal_i2c_range[i+1])) {
 				found = 1;
-				DEB2(printk(KERN_DEBUG "i2c-core.o: found normal i2c_range entry for adapter %d, "
-				            "addr %04x\n", adap_id,addr));
+				dev_dbg(&adapter->dev, "found normal i2c_range entry for adapter %d, "
+					"addr %04x\n", adap_id,addr);
 			}
 		}
 
@@ -738,8 +733,8 @@
 			    ((address_data->probe[i] == ANY_I2C_BUS))) &&
 			    (addr == address_data->probe[i+1])) {
 				found = 1;
-				DEB2(printk(KERN_DEBUG "i2c-core.o: found probe parameter for adapter %d, "
-				            "addr %04x\n", adap_id,addr));
+				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, "
+					"addr %04x\n", adap_id,addr);
 			}
 		}
 		for (i = 0;
@@ -750,8 +745,8 @@
 			   (addr >= address_data->probe_range[i+1]) &&
 			   (addr <= address_data->probe_range[i+2])) {
 				found = 1;
-				DEB2(printk(KERN_DEBUG "i2c-core.o: found probe_range parameter for adapter %d, "
-				            "addr %04x\n", adap_id,addr));
+				dev_dbg(&adapter->dev, "found probe_range parameter for adapter %d, "
+					"addr %04x\n", adap_id,addr);
 			}
 		}
 		if (!found) 
@@ -908,9 +903,9 @@
 			cpec = rpec = 0;
 			break;
 	}
-	if(rpec != cpec) {
-		DEB(printk(KERN_DEBUG "i2c-core.o: Bad PEC 0x%02x vs. 0x%02x\n",
-		           rpec, cpec));
+	if (rpec != cpec) {
+		pr_debug("i2c-core: Bad PEC 0x%02x vs. 0x%02x\n",
+			rpec, cpec);
 		return -1;
 	}
 	return 0;	
@@ -1130,13 +1125,13 @@
 	case I2C_SMBUS_BLOCK_DATA:
 	case I2C_SMBUS_BLOCK_DATA_PEC:
 		if (read_write == I2C_SMBUS_READ) {
-			printk(KERN_ERR "i2c-core.o: Block read not supported "
+			dev_err(&adapter->dev, "Block read not supported "
 			       "under I2C emulation!\n");
 			return -1;
 		} else {
 			msg[0].len = data->block[0] + 2;
 			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
-				printk(KERN_ERR "i2c-core.o: smbus_access called with "
+				dev_err(&adapter->dev, "smbus_access called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
 				return -1;
@@ -1149,7 +1144,7 @@
 		break;
 	case I2C_SMBUS_BLOCK_PROC_CALL:
 	case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-		printk(KERN_ERR "i2c-core.o: Block process call not supported "
+		dev_dbg(&adapter->dev, "Block process call not supported "
 		       "under I2C emulation!\n");
 		return -1;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
@@ -1158,7 +1153,7 @@
 		} else {
 			msg[0].len = data->block[0] + 1;
 			if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 1) {
-				printk("i2c-core.o: i2c_smbus_xfer_emulated called with "
+				dev_err(&adapter->dev, "i2c_smbus_xfer_emulated called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
 				return -1;
@@ -1168,7 +1163,7 @@
 		}
 		break;
 	default:
-		printk(KERN_ERR "i2c-core.o: smbus_access called with invalid size (%d)\n",
+		dev_err(&adapter->dev, "smbus_access called with invalid size (%d)\n",
 		       size);
 		return -1;
 	}
@@ -1303,6 +1298,3 @@
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
-
-MODULE_PARM(i2c_debug, "i");
-MODULE_PARM_DESC(i2c_debug,"debug level");
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon Jan 19 15:28:09 2004
+++ b/drivers/i2c/i2c-dev.c	Mon Jan 19 15:28:09 2004
@@ -29,8 +29,10 @@
 /* The devfs code is contributed by Philipp Matthias Hahn 
    <pmhahn@titan.lahn.de> */
 
-/* If you want debugging uncomment: */
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CORE
+#define DEBUG	1
+#endif
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -137,7 +139,7 @@
 	if (tmp==NULL)
 		return -ENOMEM;
 
-	pr_debug("i2c-dev.o: i2c-%d reading %d bytes.\n",
+	pr_debug("i2c-dev: i2c-%d reading %d bytes.\n",
 		iminor(file->f_dentry->d_inode), count);
 
 	ret = i2c_master_recv(client,tmp,count);
@@ -165,7 +167,7 @@
 		return -EFAULT;
 	}
 
-	pr_debug("i2c-dev.o: i2c-%d writing %d bytes.\n",
+	pr_debug("i2c-dev: i2c-%d writing %d bytes.\n",
 		iminor(file->f_dentry->d_inode), count);
 
 	ret = i2c_master_send(client,tmp,count);
diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Mon Jan 19 15:28:09 2004
+++ b/drivers/i2c/i2c-sensor.c	Mon Jan 19 15:28:09 2004
@@ -19,7 +19,10 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CORE
+#define DEBUG	1
+#endif
 
 #include <linux/module.h>
 #include <linux/kernel.h>


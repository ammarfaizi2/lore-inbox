Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbTCJHX3>; Mon, 10 Mar 2003 02:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbTCJHX3>; Mon, 10 Mar 2003 02:23:29 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5394 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262302AbTCJHXY>;
	Mon, 10 Mar 2003 02:23:24 -0500
Date: Sun, 9 Mar 2003 23:23:37 -0800
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: [RFC] driver core support for i2c bus and drivers
Message-ID: <20030310072337.GJ6512@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a fairly small patch against 2.5.64 that adds initial driver core
support for the i2c code.  It only has logic for the i2c bus, i2c bus
controllers, and i2c drivers, but it's a start :)

As an example, with this patch, the i2c-piix4 driver shows up in the pci
bus as (other devices omitted for clarity):

[greg@desk sys]$ tree bus/pci
bus/pci/
|-- devices
|   |-- 00:07.3 -> ../../../devices/pci0/00:07.3
`-- drivers
    |-- piix4 smbus
    |   `-- 00:07.3 -> ../../../../devices/pci0/00:07.3

And within that device, the first i2c bus is located:

[greg@desk sys]$ tree devices/pci0/00:07.3
devices/pci0/00:07.3
|-- i2c-0
|   |-- name
|   `-- power

And the i2c bus looks like:

[greg@desk sys]$ tree bus/i2c/
bus/i2c/
|-- devices
`-- drivers
    `-- EEPROM READER

I'll move on to adding i2c device support to the core, but that will be
a bit more work.  Comments on this patch are appreciated.

thanks,

greg k-h

p.s. Yes, I added the i2c-piix4 and i2c-ali15x3 and i2c-i801 drivers to
my kernel tree, from the i2c CVS tree, and tweaked them to actually work
properly.  If someone wants those patches right now, please let me know.


diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Sun Mar  9 23:27:10 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Sun Mar  9 23:27:10 2003
@@ -547,6 +546,9 @@
 
 		return -ENODEV;
 	}
+
+	/* set up the driverfs linkage to our parent device */
+	ali15x3_adapter.dev.parent = &dev->dev;
 
 	sprintf(ali15x3_adapter.name, "SMBus ALI15X3 adapter at %04x",
 		ali15x3_smba);
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Sun Mar  9 23:27:10 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Sun Mar  9 23:27:10 2003
@@ -375,6 +375,9 @@
 	printk(KERN_DEBUG DRV_NAME ": AMD756_smba = 0x%X\n", amd756_ioport);
 #endif
 
+	/* set up the driverfs linkage to our parent device */
+	amd756_adapter.dev.parent = &pdev->dev;
+
 	sprintf(amd756_adapter.name,
 		"SMBus AMD75x adapter at %04x", amd756_ioport);
 
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Sun Mar  9 23:27:10 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Sun Mar  9 23:27:10 2003
@@ -363,6 +363,9 @@
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 
+	/* set up the driverfs linkage to our parent device */
+	smbus->adapter.dev.parent = &dev->dev;
+
 	error = i2c_add_adapter(&smbus->adapter);
 	if (error)
 		goto out_release_region;
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Sun Mar  9 23:27:10 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Sun Mar  9 23:27:10 2003
@@ -679,6 +679,9 @@
 		return -ENODEV;
 	}
 
+	/* set up the driverfs linkage to our parent device */
+	i801_adapter.dev.parent = &dev->dev;
+
 	sprintf(i801_adapter.name, "SMBus I801 adapter at %04x",
 		i801_smba);
 	i2c_add_adapter(&i801_adapter);
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Sun Mar  9 23:27:10 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Sun Mar  9 23:27:10 2003
@@ -504,6 +492,9 @@
 	retval = piix4_setup(dev, id);
 	if (retval)
 		return retval;
+
+	/* set up the driverfs linkage to our parent device */
+	piix4_adapter.dev.parent = &dev->dev;
 
 	sprintf(piix4_adapter.name, "SMBus PIIX4 adapter at %04x",
 		piix4_smba);
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Sun Mar  9 23:27:10 2003
+++ b/drivers/i2c/i2c-core.c	Sun Mar  9 23:27:10 2003
@@ -87,6 +87,16 @@
 #endif /* CONFIG_PROC_FS */
 
 
+int i2c_device_probe(struct device *dev)
+{
+	return -ENODEV;
+}
+
+int i2c_device_remove(struct device *dev)
+{
+	return 0;
+}
+
 /* ---------------------------------------------------
  * registering functions 
  * --------------------------------------------------- 
@@ -140,6 +150,13 @@
 	}
 #endif /* def CONFIG_PROC_FS */
 
+	/* add the adapter to the driver core.
+	 * The parent pointer should already have been set up.
+	 */
+	sprintf(adap->dev.bus_id, "i2c-%d", i);
+	strcpy(adap->dev.name, "i2c controller");
+	device_register(&adap->dev);
+	
 	/* inform drivers of new adapters */
 	DRV_LOCK();	
 	for (j=0;j<I2C_DRIVER_MAX;j++)
@@ -222,6 +239,9 @@
 	}
 #endif /* def CONFIG_PROC_FS */
 
+	/* clean up the sysfs representation */
+	device_unregister(&adap->dev);
+
 	adapters[i] = NULL;
 	
 	ADAP_UNLOCK();	
@@ -246,6 +266,8 @@
 int i2c_add_driver(struct i2c_driver *driver)
 {
 	int i;
+	int retval;
+
 	DRV_LOCK();
 	for (i = 0; i < I2C_DRIVER_MAX; i++)
 		if (NULL == drivers[i])
@@ -264,6 +286,16 @@
 	DRV_UNLOCK();	/* driver was successfully added */
 	
 	DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
+
+	/* add the driver to the list of i2c drivers in the driver core */
+	driver->driver.name = driver->name;
+	driver->driver.bus = &i2c_bus_type;
+	driver->driver.probe = i2c_device_probe;
+	driver->driver.remove = i2c_device_remove;
+
+	retval = driver_register(&driver->driver);
+	if (retval)
+		return retval;
 	
 	ADAP_LOCK();
 
@@ -294,6 +326,9 @@
 		DRV_UNLOCK();
 		return -ENODEV;
 	}
+
+	driver_unregister(&driver->driver);
+
 	/* Have a look at each adapter, if clients of this driver are still
 	 * attached. If so, detach them to be able to kill the driver 
 	 * afterwards.
@@ -614,10 +649,37 @@
 
 	remove_proc_entry("i2c",proc_bus);
 }
+#else
+static int __init i2cproc_init(void) { return 0; }
+static void __exit i2cproc_cleanup(void) { }
+#endif /* CONFIG_PROC_FS */
 
-module_init(i2cproc_init);
-module_exit(i2cproc_cleanup);
-#endif /* def CONFIG_PROC_FS */
+/* match always succeeds, as we want the probe() to tell if we really accept this match */
+static int i2c_device_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+struct bus_type i2c_bus_type = {
+	.name =		"i2c",
+	.match =	i2c_device_match,
+};
+
+
+static int __init i2c_init(void)
+{
+	bus_register(&i2c_bus_type);
+	return i2cproc_init();
+}
+
+static void __exit i2c_exit(void)
+{
+	i2cproc_cleanup();
+	bus_unregister(&i2c_bus_type);
+}
+
+module_init(i2c_init);
+module_exit(i2c_exit);
 
 /* ----------------------------------------------------
  * the functional interface to the i2c busses.
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Sun Mar  9 23:27:10 2003
+++ b/include/linux/i2c.h	Sun Mar  9 23:27:10 2003
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/i2c-id.h>
+#include <linux/device.h>	/* for struct device */
 #include <asm/semaphore.h>
 
 /* --- General options ------------------------------------------------	*/
@@ -142,7 +143,12 @@
 	 * with the device.
 	 */
 	int (*command)(struct i2c_client *client,unsigned int cmd, void *arg);
+
+	struct device_driver driver;
 };
+#define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
+
+extern struct bus_type i2c_bus_type;
 
 /*
  * i2c_client identifies a single device (i.e. chip) that is connected to an 
@@ -164,8 +170,9 @@
 	void *data;			/* for the clients		*/
 	int usage_count;		/* How many accesses currently  */
 					/* to the client		*/
+	struct device dev;		/* the device structure		*/
 };
-
+#define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
 /*
  * The following structs are for those who like to implement new bus drivers:
@@ -228,12 +235,14 @@
 
 	int timeout;
 	int retries;
+	struct device dev;	/* the adapter device */
 
 #ifdef CONFIG_PROC_FS 
 	/* No need to set this when you initialize the adapter          */
 	int inode;
 #endif /* def CONFIG_PROC_FS */
 };
+#define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
 /*flags for the driver struct: */
 #define I2C_DF_NOTIFY	0x01		/* notify on bus (de/a)ttaches 	*/

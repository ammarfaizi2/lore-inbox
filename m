Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbSJYVVM>; Fri, 25 Oct 2002 17:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSJYVVK>; Fri, 25 Oct 2002 17:21:10 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:1967 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261605AbSJYVUw>; Fri, 25 Oct 2002 17:20:52 -0400
Date: Fri, 25 Oct 2002 16:29:09 -0500 (CDT)
From: Kent Yoder <key@austin.ibm.com>
To: mochel@osdl.org, <greg@kroah.com>
cc: stekloff@us.ibm.com, <linux-kernel@vger.kernel.org>
Subject: LDM network DD changes
Message-ID: <Pine.LNX.4.44.0210251610320.20123-100000@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Patrick and Greg,

	Below is a patch that Daniel Stekloff and I have made sort of as a
prototype for integrating network devices into the LDM.  We implmented a net
class and tokenring and ethernet interfaces on top of that, with minimal
additions to eepro100 and lanstreamer to get them hooked in.  The code
appears to work, here's my /driverfs/class directory after loading the 2
drivers:

/driverfs/class/
|-- cpu
|   |-- devices
|   |   `-- 0 -> ../../../root/sys/cpu0
|   `-- drivers
|-- disk
|   |-- devices
|   `-- drivers
|-- input
|   |-- devices
|   |-- drivers
|   `-- mouse
`-- net
    |-- devices
    |   |-- 0 -> ../../../root/pci0/00:1e.0/01:0d.0
    |   `-- 1 -> ../../../root/pci0/00:1e.0/01:0e.0
    |-- drivers
    |-- ethernet
    |   `-- 1 -> ../../../root/pci0/00:1e.0/01:0d.0
    `-- tokenring
        `-- 1 -> ../../../root/pci0/00:1e.0/01:0e.0


	We're unsure about many things here and have a few questions though.  
Specifically, what should be stored in class data vs. interface data and how 
exactly interfaces go about doing things (ie exposing what they're 
supposed to expose).

	Are we way off course with this patch? Would it be better for tokenring 
and ethernet to be classes instead of interfaces?

	Thoughts and tips are greatly appreciated.

Thanks,
Kent


diff -urN -X 2.5.nodiff linux-2.5/drivers/net/eepro100.c linux-2.5.devel/drivers/net/eepro100.c
--- linux-2.5/drivers/net/eepro100.c	2002-10-24 16:47:54.000000000 -0600
+++ linux-2.5.devel/drivers/net/eepro100.c	2002-10-25 13:49:09.000000000 -0600
@@ -2413,6 +2413,9 @@
 	.suspend	= eepro100_suspend,
 	.resume		= eepro100_resume,
 #endif /* CONFIG_PM */
+	.driver		= {
+		.devclass	= &net_devclass,
+	},
 };
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,48)
diff -urN -X 2.5.nodiff linux-2.5/drivers/net/Makefile linux-2.5.devel/drivers/net/Makefile
--- linux-2.5/drivers/net/Makefile	2002-10-24 16:46:49.000000000 -0600
+++ linux-2.5.devel/drivers/net/Makefile	2002-10-24 16:06:28.000000000 -0600
@@ -7,7 +7,7 @@
 
 export-objs     :=	8390.o arlan.o aironet4500_core.o aironet4500_card.o \
 			ppp_async.o ppp_generic.o slhc.o pppox.o auto_irq.o \
-			net_init.o mii.o
+			net_init.o mii.o setup.o
 rcpci-objs	:=	rcpci45.o rclanmtl.o
 
 ifeq ($(CONFIG_ISDN_PPP),y)
diff -urN -X 2.5.nodiff linux-2.5/drivers/net/net_init.c linux-2.5.devel/drivers/net/net_init.c
--- linux-2.5/drivers/net/net_init.c	2002-10-24 16:46:38.000000000 -0600
+++ linux-2.5.devel/drivers/net/net_init.c	2002-10-25 14:50:59.000000000 -0600
@@ -42,6 +42,8 @@
 #include <linux/slab.h>
 #include <linux/if_ether.h>
 #include <linux/string.h>
+#include <linux/pci.h>
+#include <linux/device.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/fddidevice.h>
@@ -250,6 +252,53 @@
 	return 0;
 }
 
+struct device_interface eth_netdev_intf;
+
+static struct eth_intf_data 
+{
+	struct intf_data ifd;
+
+	/* Things an ethernet device would want to export */
+};
+
+static int eth_intf_add(struct device *dev)
+{
+	struct eth_intf_data *ethifd;
+	struct netdev_class_data *cls_data = dev->class_data;
+
+	if(!cls_data || cls_data->netdev->type != ARPHRD_ETHER)
+		return -ENODEV; /* no class data || not an ethernet device */
+	
+	printk("LDM ethernet interface found device %s\n", cls_data->netdev->name);
+
+	if((ethifd = kmalloc(sizeof(struct eth_intf_data), GFP_ATOMIC)) == NULL) {
+		printk("No memory for ethernet device interface\n");
+		return -ENOMEM;
+	}
+
+	ethifd->ifd.dev = dev;
+	ethifd->ifd.intf = &eth_netdev_intf;
+
+	return interface_add_data(&ethifd->ifd);
+}
+
+#define to_eth_intf_data(d)	container_of(d, struct eth_intf_data, ifd)
+
+static int eth_intf_remove(struct intf_data *ifd)
+{
+	struct eth_intf_data *ethifd = to_eth_intf_data(ifd);
+
+	kfree(ethifd);
+	return 0;
+}
+
+struct device_interface eth_netdev_intf = {
+        .name           = "ethernet",
+        .devclass       = &net_devclass,
+	.add_device	= eth_intf_add,
+	.remove_device	= eth_intf_remove,
+};
+
 #ifdef CONFIG_FDDI
 
 /**
@@ -577,6 +626,53 @@
 
 #ifdef CONFIG_TR
 
+struct device_interface tr_netdev_intf;
+
+static struct tr_intf_data {
+	struct intf_data ifd;
+
+	/* Things a token ring device would want to export */
+};
+
+static int tr_intf_add(struct device *dev)
+{
+	struct tr_intf_data *trifd;
+	struct netdev_class_data *cls_data = dev->class_data;
+
+	if(!cls_data || cls_data->netdev->type != ARPHRD_IEEE802_TR)
+		return -ENODEV; /* no class data || not a token ring device */
+	
+	printk("LDM token ring interface found device %s\n", cls_data->netdev->name);
+
+	if((trifd = kmalloc(sizeof(struct tr_intf_data), GFP_ATOMIC)) == NULL) {
+		printk("No memory for token ring device interface\n");
+		return -ENOMEM;
+	}
+
+	trifd->ifd.dev = dev;
+	trifd->ifd.intf = &tr_netdev_intf;
+
+	return interface_add_data(&trifd->ifd);
+}
+
+#define to_tr_intf_data(d)	container_of(d, struct tr_intf_data, ifd)
+
+static int tr_intf_remove(struct intf_data *ifd)
+{
+	struct tr_intf_data *trifd = to_tr_intf_data(ifd);
+
+	kfree(trifd);
+	return 0;
+}
+
+struct device_interface tr_netdev_intf = {
+        .name           = "tokenring",
+        .devclass       = &net_devclass,
+	.add_device	= tr_intf_add,
+	.remove_device	= tr_intf_remove,
+};
+
+
 void tr_setup(struct net_device *dev)
 {
 	/*
diff -urN -X 2.5.nodiff linux-2.5/drivers/net/setup.c linux-2.5.devel/drivers/net/setup.c
--- linux-2.5/drivers/net/setup.c	2002-10-24 16:48:20.000000000 -0600
+++ linux-2.5.devel/drivers/net/setup.c	2002-10-25 13:39:34.000000000 -0600
@@ -8,6 +8,9 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/netlink.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/pci.h>
 
 extern int slip_init_ctrl_dev(void);
 extern int x25_asy_init_ctrl_dev(void);
@@ -153,12 +156,78 @@
 #endif
 }
 
+/**
+ * net_add_device - Adds device to device class
+ * @dev = the device structure to add to the class
+ */
+static int net_add_device(struct device *dev)
+{
+	struct pci_dev *pdev;
+	struct net_device *netdev = NULL;
+	struct netdev_class_data *cls_data;
+	
+	if(pci_bus_type.match(dev, dev->driver)) {
+		pdev = to_pci_dev(dev);
+		netdev = pci_get_drvdata(pdev);
+	} else if(platform_bus_type.match(dev, dev->driver)) {
+		/* 
+		 * Figure out a way back to struct net_device 
+		 * from here.
+		 */
+	}
+
+	if(!netdev)
+		return -ENODEV;
+
+	if((cls_data = kmalloc(sizeof(struct netdev_class_data), GFP_ATOMIC)) == NULL) {
+		printk(KERN_WARNING "No memory for net device class data.\n");
+		return -ENOMEM;
+	}
+	
+	printk(KERN_INFO "net: adding device %s to net class\n", dev->name);
+
+	cls_data->netdev = netdev;
+	dev->class_data = cls_data;
+	
+	return 0;
+};
+
+/**
+ * net_remove_device - Removes device from device class
+ * @dev = the device structure to be removed from the class
+ */
+static void net_remove_device(struct device *dev)
+{
+	if(dev->class_data)
+		kfree(dev->class_data);
+	
+	printk(KERN_INFO "net: removing device %s from net class\n", dev->name);
+};
+
+struct device_class net_devclass = {
+	.name		= "net",
+	.add_device	= net_add_device,
+	.remove_device	= net_remove_device,
+};
+
 /*
  *	Initialise network devices
  */
  
+extern struct device_interface eth_netdev_intf;
+#ifdef CONFIG_TR
+extern struct device_interface tr_netdev_intf;
+#endif
+
 void __init net_device_init(void)
 {
+	/* register net device class */
+	devclass_register(&net_devclass);
+	/* register interfaces for the net device class */
+	interface_register(&eth_netdev_intf);
+#ifdef CONFIG_TR
+	interface_register(&tr_netdev_intf);
+#endif
 	/* Devices supporting the new probing API */
 	network_probe();
 	/* Line disciplines */
@@ -167,3 +236,5 @@
 	special_device_init();
 	/* That kicks off the legacy init functions */
 }
+
+EXPORT_SYMBOL(net_devclass);
diff -urN -X 2.5.nodiff linux-2.5/drivers/net/tokenring/lanstreamer.c linux-2.5.devel/drivers/net/tokenring/lanstreamer.c
--- linux-2.5/drivers/net/tokenring/lanstreamer.c	2002-10-25 14:34:03.000000000 -0600
+++ linux-2.5.devel/drivers/net/tokenring/lanstreamer.c	2002-10-24 16:06:28.000000000 -0600
@@ -76,6 +76,8 @@
  *  if compiled into the kernel).
  */
 
+#define NEW_DRIVER_MODEL 1
+ 
 /* Change STREAMER_DEBUG to 1 to get verbose, and I mean really verbose, messages */
 
 #define STREAMER_DEBUG 0
@@ -120,6 +122,7 @@
 #include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/version.h>
+#include <linux/device.h>
 #include <net/checksum.h>
 
 #include <asm/io.h>
@@ -137,7 +140,7 @@
  */
 
 static char version[] = "LanStreamer.c v0.4.0 03/08/01 - Mike Sullivan\n"
-                        "              v0.5.2 09/30/02 - Kent Yoder";
+                        "              v0.5.3 10/24/02 - LDM";
 
 static struct pci_device_id streamer_pci_tbl[] __initdata = {
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_TR, PCI_ANY_ID, PCI_ANY_ID,},
@@ -162,6 +165,45 @@
 	"Monitor Contention failer for RPL", "FDX Protocol Error"
 };
 
+#if NEW_DRIVER_MODEL
+
+/* driverfs changes keep token ring bleeding edge */
+
+static ssize_t show_ringspeed(struct device *dev, char *buf, size_t count, loff_t off)
+{
+	struct net_device *net_dev;
+	struct streamer_private *streamer_priv;
+	struct pci_dev *pdev;
+
+	if(off)
+		return 0;
+
+	pdev = to_pci_dev(dev);
+	net_dev = pci_get_drvdata(pdev);
+	streamer_priv = net_dev->priv;
+
+	return sprintf(buf, "%d\n", streamer_priv->streamer_ring_speed);
+}
+static DEVICE_ATTR(ringspeed,S_IRUGO,show_ringspeed,NULL);
+
+static void streamer_create_driverfs_files(struct device *dev)
+{
+	if(device_create_file(dev, &dev_attr_ringspeed))
+		printk(KERN_INFO "%s: driverfs file creation failed.\n", dev->name);
+}
+
+static void streamer_remove_driverfs_files(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_ringspeed);
+}
+
+#else
+
+static void streamer_create_driverfs_files(struct device *dev) {}
+static void streamer_remove_driverfs_files(struct device *dev) {}
+
+#endif
+
 /* Module paramters */
 
 /* Ring Speed 0,4,16
@@ -878,6 +927,8 @@
 		ntohs(readw(streamer_mmio + LAPDINC)));
 #endif
 
+	streamer_create_driverfs_files(&streamer_priv->pci_dev->dev);
+
 	netif_start_queue(dev);
 	return 0;
 }
@@ -1211,6 +1262,8 @@
 
 	spin_unlock_irqrestore(&streamer_priv->streamer_lock, flags);
 
+	streamer_remove_driverfs_files(&streamer_priv->pci_dev->dev);
+	
 	while (streamer_priv->srb_queued) 
 	{
 		interruptible_sleep_on_timeout(&streamer_priv->srb_wait,
@@ -1978,6 +2031,20 @@
 }
 #endif
 
+#if NEW_DRIVER_MODEL
+
+static struct pci_driver streamer_pci_driver = {
+	name:		"lanstreamer",
+	id_table:	streamer_pci_tbl,
+	probe:		streamer_init_one,
+	remove:		__devexit_p(streamer_remove_one),
+	driver:         {
+		devclass:	&net_devclass,
+       },
+};
+
+#else
+
 static struct pci_driver streamer_pci_driver = {
   .name     = "lanstreamer",
   .id_table = streamer_pci_tbl,
@@ -1985,6 +2052,8 @@
   .remove   = __devexit_p(streamer_remove_one),
 };
 
+#endif
+
 static int __init streamer_init_module(void) {
   return pci_module_init(&streamer_pci_driver);
 }
diff -urN -X 2.5.nodiff linux-2.5/include/linux/netdevice.h linux-2.5.devel/include/linux/netdevice.h
--- linux-2.5/include/linux/netdevice.h	2002-10-24 16:48:30.000000000 -0600
+++ linux-2.5.devel/include/linux/netdevice.h	2002-10-25 11:02:00.000000000 -0600
@@ -450,6 +450,11 @@
 	struct packet_type	*next;
 };
 
+struct netdev_class_data 
+{
+	struct net_device *netdev;
+};
+
 
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
@@ -457,6 +462,7 @@
 extern struct net_device		loopback_dev;		/* The loopback */
 extern struct net_device		*dev_base;		/* All devices */
 extern rwlock_t				dev_base_lock;		/* Device list lock */
+extern struct device_class		net_devclass;		/* Net device class */
 
 extern int			netdev_boot_setup_add(char *name, struct ifmap *map);
 extern int 			netdev_boot_setup_check(struct net_device *dev);


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVAXG1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVAXG1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVAXG1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:27:06 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261460AbVAXGOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:30 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][10/12] InfiniBand/core: add IsSM userspace support
In-Reply-To: <20051232214.j7TLAr2Uqj9NHnIa@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:24 -0800
Message-Id: <20051232214.MwCsxKOebnykJtRc@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0512 (UTC) FILETIME=[F41FD680:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement setting/clearing IsSM port capability bit from userspace via
"issm" special files (set IsSM bit on open, clear on close).

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/core/user_mad.c	2005-01-23 20:57:19.946654072 -0800
+++ linux-bk/drivers/infiniband/core/user_mad.c	2005-01-23 20:57:56.183145288 -0800
@@ -45,6 +45,7 @@
 #include <linux/kref.h>
 
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 
 #include <ib_mad.h>
 #include <ib_user_mad.h>
@@ -54,7 +55,7 @@
 MODULE_LICENSE("Dual BSD/GPL");
 
 enum {
-	IB_UMAD_MAX_PORTS  = 256,
+	IB_UMAD_MAX_PORTS  = 64,
 	IB_UMAD_MAX_AGENTS = 32
 };
 
@@ -62,6 +63,12 @@
 	int                    devnum;
 	struct cdev            dev;
 	struct class_device    class_dev;
+
+	int                    sm_devnum;
+	struct cdev            sm_dev;
+	struct class_device    sm_class_dev;
+	struct semaphore       sm_sem;
+
 	struct ib_device      *ib_dev;
 	struct ib_umad_device *umad_dev;
 	u8                     port_num;
@@ -92,7 +99,7 @@
 
 static dev_t base_dev;
 static spinlock_t map_lock;
-static DECLARE_BITMAP(dev_map, IB_UMAD_MAX_PORTS);
+static DECLARE_BITMAP(dev_map, IB_UMAD_MAX_PORTS * 2);
 
 static void ib_umad_add_one(struct ib_device *device);
 static void ib_umad_remove_one(struct ib_device *device);
@@ -511,6 +518,54 @@
 	.release        = ib_umad_close
 };
 
+static int ib_umad_sm_open(struct inode *inode, struct file *filp)
+{
+	struct ib_umad_port *port =
+		container_of(inode->i_cdev, struct ib_umad_port, sm_dev);
+	struct ib_port_modify props = {
+		.set_port_cap_mask = IB_PORT_SM
+	};
+	int ret;
+
+	if (filp->f_flags & O_NONBLOCK) {
+		if (down_trylock(&port->sm_sem))
+			return -EAGAIN;
+	} else {
+		if (down_interruptible(&port->sm_sem))
+			return -ERESTARTSYS;
+	}
+
+	ret = ib_modify_port(port->ib_dev, port->port_num, 0, &props);
+	if (ret) {
+		up(&port->sm_sem);
+		return ret;
+	}
+
+	filp->private_data = port;
+
+	return 0;
+}
+
+static int ib_umad_sm_close(struct inode *inode, struct file *filp)
+{
+	struct ib_umad_port *port = filp->private_data;
+	struct ib_port_modify props = {
+		.clr_port_cap_mask = IB_PORT_SM
+	};
+	int ret;
+
+	ret = ib_modify_port(port->ib_dev, port->port_num, 0, &props);
+	up(&port->sm_sem);
+
+	return ret;
+}
+
+static struct file_operations umad_sm_fops = {
+	.owner 	 = THIS_MODULE,
+	.open 	 = ib_umad_sm_open,
+	.release = ib_umad_sm_close
+};
+
 static struct ib_client umad_client = {
 	.name   = "umad",
 	.add    = ib_umad_add_one,
@@ -519,17 +574,18 @@
 
 static ssize_t show_dev(struct class_device *class_dev, char *buf)
 {
-	struct ib_umad_port *port =
-		container_of(class_dev, struct ib_umad_port, class_dev);
+	struct ib_umad_port *port = class_get_devdata(class_dev);
 
-	return print_dev_t(buf, port->dev.dev);
+	if (class_dev == &port->class_dev)
+		return print_dev_t(buf, port->dev.dev);
+	else
+		return print_dev_t(buf, port->sm_dev.dev);
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
 static ssize_t show_ibdev(struct class_device *class_dev, char *buf)
 {
-	struct ib_umad_port *port =
-		container_of(class_dev, struct ib_umad_port, class_dev);
+	struct ib_umad_port *port = class_get_devdata(class_dev);
 
 	return sprintf(buf, "%s\n", port->ib_dev->name);
 }
@@ -537,8 +593,7 @@
 
 static ssize_t show_port(struct class_device *class_dev, char *buf)
 {
-	struct ib_umad_port *port =
-		container_of(class_dev, struct ib_umad_port, class_dev);
+	struct ib_umad_port *port = class_get_devdata(class_dev);
 
 	return sprintf(buf, "%d\n", port->port_num);
 }
@@ -554,11 +609,16 @@
 
 static void ib_umad_release_port(struct class_device *class_dev)
 {
-	struct ib_umad_port *port =
-		container_of(class_dev, struct ib_umad_port, class_dev);
+	struct ib_umad_port *port = class_get_devdata(class_dev);
+
+	if (class_dev == &port->class_dev) {
+		cdev_del(&port->dev);
+		clear_bit(port->devnum, dev_map);
+	} else {
+		cdev_del(&port->sm_dev);
+		clear_bit(port->sm_devnum, dev_map);
+	}
 
-	cdev_del(&port->dev);
-	clear_bit(port->devnum, dev_map);
 	kref_put(&port->umad_dev->ref, ib_umad_release_dev);
 }
 
@@ -573,6 +633,94 @@
 }
 static CLASS_ATTR(abi_version, S_IRUGO, show_abi_version, NULL);
 
+static int ib_umad_init_port(struct ib_device *device, int port_num,
+			     struct ib_umad_port *port)
+{
+	spin_lock(&map_lock);
+	port->devnum = find_first_zero_bit(dev_map, IB_UMAD_MAX_PORTS);
+	if (port->devnum >= IB_UMAD_MAX_PORTS) {
+		spin_unlock(&map_lock);
+		return -1;
+	}
+	port->sm_devnum = find_next_zero_bit(dev_map, IB_UMAD_MAX_PORTS * 2, IB_UMAD_MAX_PORTS);
+	if (port->sm_devnum >= IB_UMAD_MAX_PORTS * 2) {
+		spin_unlock(&map_lock);
+		return -1;
+	}
+	set_bit(port->devnum, dev_map);
+	set_bit(port->sm_devnum, dev_map);
+	spin_unlock(&map_lock);
+
+	port->ib_dev   = device;
+	port->port_num = port_num;
+	init_MUTEX(&port->sm_sem);
+
+	cdev_init(&port->dev, &umad_fops);
+	port->dev.owner = THIS_MODULE;
+	kobject_set_name(&port->dev.kobj, "umad%d", port->devnum);
+	if (cdev_add(&port->dev, base_dev + port->devnum, 1))
+		return -1;
+
+	port->class_dev.class = &umad_class;
+	port->class_dev.dev   = device->dma_device;
+
+	snprintf(port->class_dev.class_id, BUS_ID_SIZE, "umad%d", port->devnum);
+
+	if (class_device_register(&port->class_dev))
+		goto err_cdev;
+
+	class_set_devdata(&port->class_dev, port);
+	kref_get(&port->umad_dev->ref);
+
+	if (class_device_create_file(&port->class_dev, &class_device_attr_dev))
+		goto err_class;
+	if (class_device_create_file(&port->class_dev, &class_device_attr_ibdev))
+		goto err_class;
+	if (class_device_create_file(&port->class_dev, &class_device_attr_port))
+		goto err_class;
+
+	cdev_init(&port->sm_dev, &umad_sm_fops);
+	port->sm_dev.owner = THIS_MODULE;
+	kobject_set_name(&port->dev.kobj, "issm%d", port->sm_devnum - IB_UMAD_MAX_PORTS);
+	if (cdev_add(&port->sm_dev, base_dev + port->sm_devnum, 1))
+		return -1;
+
+	port->sm_class_dev.class = &umad_class;
+	port->sm_class_dev.dev   = device->dma_device;
+
+	snprintf(port->sm_class_dev.class_id, BUS_ID_SIZE, "issm%d", port->sm_devnum - IB_UMAD_MAX_PORTS);
+
+	if (class_device_register(&port->sm_class_dev))
+		goto err_sm_cdev;
+
+	class_set_devdata(&port->sm_class_dev, port);
+	kref_get(&port->umad_dev->ref);
+
+	if (class_device_create_file(&port->sm_class_dev, &class_device_attr_dev))
+		goto err_sm_class;
+	if (class_device_create_file(&port->sm_class_dev, &class_device_attr_ibdev))
+		goto err_sm_class;
+	if (class_device_create_file(&port->sm_class_dev, &class_device_attr_port))
+		goto err_sm_class;
+
+	return 0;
+
+err_sm_class:
+	class_device_unregister(&port->sm_class_dev);
+
+err_sm_cdev:
+	cdev_del(&port->sm_dev);
+
+err_class:
+	class_device_unregister(&port->class_dev);
+
+err_cdev:
+	cdev_del(&port->dev);
+	clear_bit(port->devnum, dev_map);
+
+	return -1;
+}
+
 static void ib_umad_add_one(struct ib_device *device)
 {
 	struct ib_umad_device *umad_dev;
@@ -601,58 +749,20 @@
 
 	for (i = s; i <= e; ++i) {
 		umad_dev->port[i - s].umad_dev = umad_dev;
-		kref_get(&umad_dev->ref);
-
-		spin_lock(&map_lock);
-		umad_dev->port[i - s].devnum =
-			find_first_zero_bit(dev_map, IB_UMAD_MAX_PORTS);
-		if (umad_dev->port[i - s].devnum >= IB_UMAD_MAX_PORTS) {
-			spin_unlock(&map_lock);
-			goto err;
-		}
-		set_bit(umad_dev->port[i - s].devnum, dev_map);
-		spin_unlock(&map_lock);
 
-		umad_dev->port[i - s].ib_dev   = device;
-		umad_dev->port[i - s].port_num = i;
-
-		cdev_init(&umad_dev->port[i - s].dev, &umad_fops);
-		umad_dev->port[i - s].dev.owner = THIS_MODULE;
-		kobject_set_name(&umad_dev->port[i - s].dev.kobj,
-				 "umad%d", umad_dev->port[i - s].devnum);
-		if (cdev_add(&umad_dev->port[i - s].dev, base_dev +
-			     umad_dev->port[i - s].devnum, 1))
+		if (ib_umad_init_port(device, i, &umad_dev->port[i - s]))
 			goto err;
-
-		umad_dev->port[i - s].class_dev.class = &umad_class;
-		umad_dev->port[i - s].class_dev.dev   = device->dma_device;
-		snprintf(umad_dev->port[i - s].class_dev.class_id,
-			 BUS_ID_SIZE, "umad%d", umad_dev->port[i - s].devnum);
-		if (class_device_register(&umad_dev->port[i - s].class_dev))
-			goto err_class;
-
-		if (class_device_create_file(&umad_dev->port[i - s].class_dev,
-					     &class_device_attr_dev))
-			goto err_class;
-		if (class_device_create_file(&umad_dev->port[i - s].class_dev,
-					     &class_device_attr_ibdev))
-			goto err_class;
-		if (class_device_create_file(&umad_dev->port[i - s].class_dev,
-					     &class_device_attr_port))
-			goto err_class;
 	}
 
 	ib_set_client_data(device, &umad_client, umad_dev);
 
 	return;
 
-err_class:
-	cdev_del(&umad_dev->port[i - s].dev);
-	clear_bit(umad_dev->port[i - s].devnum, dev_map);
-
 err:
-	while (--i >= s)
+	while (--i >= s) {
 		class_device_unregister(&umad_dev->port[i - s].class_dev);
+		class_device_unregister(&umad_dev->port[i - s].sm_class_dev);
+	}
 
 	kref_put(&umad_dev->ref, ib_umad_release_dev);
 }
@@ -665,8 +775,10 @@
 	if (!umad_dev)
 		return;
 
-	for (i = 0; i <= umad_dev->end_port - umad_dev->start_port; ++i)
+	for (i = 0; i <= umad_dev->end_port - umad_dev->start_port; ++i) {
 		class_device_unregister(&umad_dev->port[i].class_dev);
+		class_device_unregister(&umad_dev->port[i].sm_class_dev);
+	}
 
 	kref_put(&umad_dev->ref, ib_umad_release_dev);
 }
@@ -677,7 +789,7 @@
 
 	spin_lock_init(&map_lock);
 
-	ret = alloc_chrdev_region(&base_dev, 0, IB_UMAD_MAX_PORTS,
+	ret = alloc_chrdev_region(&base_dev, 0, IB_UMAD_MAX_PORTS * 2,
 				  "infiniband_mad");
 	if (ret) {
 		printk(KERN_ERR "user_mad: couldn't get device number\n");
@@ -708,7 +820,7 @@
 	class_unregister(&umad_class);
 
 out_chrdev:
-	unregister_chrdev_region(base_dev, IB_UMAD_MAX_PORTS);
+	unregister_chrdev_region(base_dev, IB_UMAD_MAX_PORTS * 2);
 
 out:
 	return ret;
@@ -718,7 +830,7 @@
 {
 	ib_unregister_client(&umad_client);
 	class_unregister(&umad_class);
-	unregister_chrdev_region(base_dev, IB_UMAD_MAX_PORTS);
+	unregister_chrdev_region(base_dev, IB_UMAD_MAX_PORTS * 2);
 }
 
 module_init(ib_umad_init);
--- linux-bk.orig/Documentation/infiniband/user_mad.txt	2005-01-23 08:30:27.000000000 -0800
+++ linux-bk/Documentation/infiniband/user_mad.txt	2005-01-23 20:57:46.505616496 -0800
@@ -2,9 +2,10 @@
 
 Device files
 
-  Each port of each InfiniBand device has a "umad" device attached.
-  For example, a two-port HCA will have two devices, while a switch
-  will have one device (for switch port 0).
+  Each port of each InfiniBand device has a "umad" device and an
+  "issm" device attached.  For example, a two-port HCA will have two
+  umad devices and two issm devices, while a switch will have one
+  device of each type (for switch port 0).
 
 Creating MAD agents
 
@@ -63,19 +64,36 @@
 	if (ret != sizeof mad)
 		perror("write");
 
+Setting IsSM Capability Bit
+
+  To set the IsSM capability bit for a port, simply open the
+  corresponding issm device file.  If the IsSM bit is already set,
+  then the open call will block until the bit is cleared (or return
+  immediately with errno set to EAGAIN if the O_NONBLOCK flag is
+  passed to open()).  The IsSM bit will be cleared when the issm file
+  is closed.  No read, write or other operations can be performed on
+  the issm file.
+
 /dev files
 
   To create the appropriate character device files automatically with
   udev, a rule like
 
     KERNEL="umad*", NAME="infiniband/%k"
+    KERNEL="issm*", NAME="infiniband/%k"
 
-  can be used.  This will create a device node named
+  can be used.  This will create device nodes named
 
     /dev/infiniband/umad0
+    /dev/infiniband/issm0
 
   for the first port, and so on.  The InfiniBand device and port
-  associated with this device can be determined from the files
+  associated with these devices can be determined from the files
 
     /sys/class/infiniband_mad/umad0/ibdev
     /sys/class/infiniband_mad/umad0/port
+
+  and
+
+    /sys/class/infiniband_mad/issm0/ibdev
+    /sys/class/infiniband_mad/issm0/port


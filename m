Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbSLUIzB>; Sat, 21 Dec 2002 03:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266841AbSLUIzB>; Sat, 21 Dec 2002 03:55:01 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:30888 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266839AbSLUIy7>; Sat, 21 Dec 2002 03:54:59 -0500
Date: Sat, 21 Dec 2002 01:00:45 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: bus_type and device_class merge (or partial merge)
Message-ID: <20021221010045.A8861@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>If you're interested, I've finished a paper for linux.conf.au on the 
>driver model that should describe the various objects and purposes (much 
>better than the Ottawa paper did). You can find it at: 
>
>http://kernel.org/pub/linux/kernel/people/mochel/doc/lca/driver-model-lca2003.tar.gz

	Thanks.  I've read it now.  Here is a proposed patch.  The
only substantive change is a correction to the misunderstanding about
the risk of bus driver modules being unloaded (you might want to
delete the second paragraph that I added).  I've cc'ed linux-kernel
as others might want to comment that proposed change.

	The other changes are just typos and one TeX quirk (apparentlyd
underscores don't have to be escaped in "verbatim" sections).

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=diffs
Content-Transfer-Encoding: 8bit

diff -u -r driver-model-lca2003/source/buses.tex driver-model-lca2003.modified/source/buses.tex
--- driver-model-lca2003/source/buses.tex	2002-12-18 09:57:33.000000000 -0800
+++ driver-model-lca2003.modified/source/buses.tex	2002-12-21 00:57:20.000000000 -0800
@@ -211,24 +211,28 @@
 \end{table}
 
 
-There are two caveats of using bus drivers as they are currently
-implemented in the driver model . First, the de facto means of
-referencing a bus driver is via a pointer to its struct
-bus\_type. This implies that the bus drivers must not declare the
-object as 'static' and must be explicitly exported for modules to
-use. An alternative is to provide a helper that searches for and
-returns a bus with a specified name. This is a more desirable solution
-from an abstraction perspective, and will likely be added to the
-model.  
-
-Secondly, bus drivers contain no internal means of preventing their
-module to unload while their reference count is positive. This causes
-the referring object to access invalid memory if the module is
-unloaded. The proposed solution is to use a semaphore, like device
-drivers contain, that bus\_unregister() waits on, and is only unlocked
-when the reference count reaches 0. This will be fixed in the near
-future. 
-
+A bus driver is referenced via a pointer to its struct bus\_type. This
+implies that the bus drivers must not declare the object as 'static'
+and that it must be explicitly exported for modules to use. The reference
+to the bus driver's struct bus\_type means that the bus driver module
+will automatically be loaded by modprobe before any users of that
+bus type.  It also means that the dependency code built into the
+kernel module system will prevent a bus driver from being unloaded
+until all device drivers for that bus are unloaded, elmininating the
+need to reference counting or other locking schemes.
+
+An alternative is to provide a helper that searches for and
+returns a bus with a specified name, which might be useful with,
+for example, a module that contained drivers for PCI and
+MicroChannel versions of a device and one wanted to build a kernel
+with support for both drivers built in and then run this driver
+in a situtation where, say, the MicroChannel bus module was not
+available (for example on a customized ram disk).  However, if this
+were really necessary, then splitting such a module into bus specific
+parts and a ``core'' would reduce kernel footprint and probably result
+in less complexity than implementing run-time lookup of bus types,
+and developing a scheme for rebinding such a driver if, for example,
+the microchannel bus driver is loaded later.
 
 \subsection*{Driver Binding}
 
@@ -339,16 +343,16 @@
 \begin{footnotesize}
 \begin{verbatim}
 
-struct callback\_data {
+struct callback_data {
        struct device * dev;
        char * id;
 };
 
 static int callback(struct device * dev, void * data)
 {
-        struct callback\_data * cd = (struct callback\_data *)data;
-        if (!strcmp(dev->bus\_id,cd->id)) {
-                cd->dev = get\_device(dev);
+        struct callback_data * cd = data;
+        if (!strcmp(dev->bus_id,cd->id)) {
+                cd->dev = get_device(dev);
                 return 1;
         }
         return 0;
@@ -356,15 +360,15 @@
 
 static int caller(void)
 {
-        struct callback\_data data = {
+        struct callback_data data = {
                 .id = "00:00.0",
         };
 
         /* find PCI device with ID 00:00.0  */
-        if(bus\_for\_each\_dev(&pci\_bus\_type,&data,callback)) {
+        if(bus_for_each_dev(&pci_bus_type,&data,callback)) {
                 struct device * dev = data.dev;
                 /* fiddle with device */
-                put\_device(dev);
+                put_device(dev);
         }
 }
 
diff -u -r driver-model-lca2003/source/classes.tex driver-model-lca2003.modified/source/classes.tex
--- driver-model-lca2003/source/classes.tex	2002-12-18 11:53:00.000000000 -0800
+++ driver-model-lca2003.modified/source/classes.tex	2002-12-21 00:07:01.000000000 -0800
@@ -122,10 +122,10 @@
 
 
 Struct device\_class most closely resembles struct bus\_type. Indeed,
-many of the fields of struct device\_class server a similar purpose as
+many of the fields of struct device\_class serve a similar purpose as
 those in struct bus\_type. The subordinate subsystem 'devsubsys' and
 the 'devices' list manage the list of devices registered with the
-class. Like with buses, these structures must exist in parallel, since
+class. As with buses, these structures must exist in parallel, since
 a kobject may not belong to more than one subsystem at a time. The
 same is true of the 'drvsubsys' and 'drivers' list with regard to
 drivers registered with the classes.
diff -u -r driver-model-lca2003/source/devices.tex driver-model-lca2003.modified/source/devices.tex
--- driver-model-lca2003/source/devices.tex	2002-12-18 11:35:06.000000000 -0800
+++ driver-model-lca2003.modified/source/devices.tex	2002-12-20 08:35:20.000000000 -0800
@@ -63,7 +63,7 @@
 
 saved\_state	& void *	& Pointer to saved state for device. \\\hline
 
-dma\_mask	& dma\_mask\_t *	& DMA address mask the device
+dma\_mask	& dma\_mask\_t	& DMA address mask the device
 	can support.\\\hline
 
 \end{tabularx} \\
diff -u -r driver-model-lca2003/source/platform.tex driver-model-lca2003.modified/source/platform.tex
--- driver-model-lca2003/source/platform.tex	2002-12-18 10:33:57.000000000 -0800
+++ driver-model-lca2003.modified/source/platform.tex	2002-12-21 00:08:28.000000000 -0800
@@ -216,7 +216,7 @@
 cause problems, though, when a driver is running on a platform where
 the ports to probe for existence are different. It doesn't even have
 to be different architectures, only different revisions of the same
-platform. Probing undefined I/O ports is dangerous and cause very
+platform. Probing undefined I/O ports is dangerous and causes very
 unpredictable behavior. It can also be a very slow process, and
 significantly delay the boot process.
 
diff -u -r driver-model-lca2003/source/sysfs.tex driver-model-lca2003.modified/source/sysfs.tex
--- driver-model-lca2003/source/sysfs.tex	2002-12-18 09:57:33.000000000 -0800
+++ driver-model-lca2003.modified/source/sysfs.tex	2002-12-20 08:34:42.000000000 -0800
@@ -74,7 +74,7 @@
 sysfs has been a standard part of the Linux kernel as of version
 2.5.45. It has existed under a different name (driverfs or ddfs) since
 kernel version 2.5.2. The de-facto standard mount point for sysfs is a
-new directory named '/sys'. It may be mounted from user pace by doing:
+new directory named '/sys'. It may be mounted from user space by doing:
 
 
 \begin{alltt}

--/9DWx/yDrRhgMJTb--

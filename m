Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261331AbSKBTXc>; Sat, 2 Nov 2002 14:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSKBTXb>; Sat, 2 Nov 2002 14:23:31 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:9442 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261331AbSKBTX3>; Sat, 2 Nov 2002 14:23:29 -0500
Date: Sat, 2 Nov 2002 11:29:51 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mochel@osdl.org, linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.45/drivers/base/bus.c - new field to consolidate memory allocation in many drivers
Message-ID: <20021102112951.A6910@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I believe that the following little change will enable
elimination of a kmalloc/kfree pair from many device drivers,
and, more importantly, eliminate the rarely tested often buggy
error leg for dealing with that memory allocation failure.

	This patch allows device drivers to tell the generic device
code to handle allocating the per-device blob of memory that is
normally stored in device.driver_data.  It does so by adding a new
field device_driver.drvdata_size, with the following semantics:

	0	- Do not attempt to allocate or free device.driver_data.
		  This is compatible with previous behavior (although we
		  now initialize driver_data to NULL before calling the
		  probe routine).

	>0	- Allocate the specified number of bytes, fill it with
		  all zeroes, and store the address in device.driver_data
		  before calling the device's probe routine.  Abort the
		  probe with -ENOMEM if memory allocation fails.  Free the
		  storage if the probe fails or when the driver is
		  removed.  (The allocation and freeing mechanisms are
		  not specified, although the current mechanism uses
		  kmalloc/kfree).

	-1	- Set device.driver_data to NULL before calling the probe
		  routine.  When the probe routine returns failure and
		  when the driver is removed, check the value of
		  device.driver_data.  If it is non-NULL, kfree it.
		  This is handy for drivers that want to do their own
		  memory allocation.  This is handy if the driver needs
		  a variable sized block or really really really does not
		  want the allocated memory initialized to all zeroes.

	You may wonder about the trade-off of initializing the
allocated memory to all zeroes (in the drvdata_size > 0 case).  Driver
probes are executed relatively rarely (as opposed to an IO path that
might get executed a thousand times per second) and it is hard to
identify bugs due to uninitialized values.  The structures that the
probles fill in often gain new parameters over time, so it is easy to
make initialization bugs that gcc cannot easily detect.  It also makes
it easier to design new fields in these structures where a value of
zero will provide backward compatible behavior.  A small bonus is that
driver initialization code only needs to fill in non-zero values
explicitly.

	If there is a case where the performance hit from clearing the
memory is sustantial, you could use drvdata_size = -1.  If it turns
out that the situation is common, we could have a flag to skip the
clearing of the memory, but I don't think that such cases will be
common.

	I realize that many drivers store the result of some high
level allocate routine in their private data (for example,
scsi_register).  Later, I intend to make versions of those routines
that take pointer to a block of zero-filled memory rather than calling
kmalloc themselves.

	Anyhow, here is the patch.  I would like to start writing
driver clean-ups that use this patch soon, so I would like to see this
addition integrated into the kernel as sson as possible.  I am running
a kernel with this patch compiled in now, although I have not yet
changed any drivers to take advantage of it.

	Pat, are you the person I should be submitting this patch
to?  Is there someone else I should be submitting this patch to?
Please let me know.  Thanks in advance.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="devalloc.diff"

--- linux-2.5.45/include/linux/device.h	2002-10-30 16:43:40.000000000 -0800
+++ linux/include/linux/device.h	2002-11-02 05:20:36.000000000 -0800
@@ -114,6 +114,7 @@
 	char			* name;
 	struct bus_type		* bus;
 	struct device_class	* devclass;
+	int			drvdata_size;
 
 	rwlock_t		lock;
 	atomic_t		refcount;
--- linux-2.5.45/drivers/base/bus.c	2002-10-30 16:42:20.000000000 -0800
+++ linux/drivers/base/bus.c	2002-11-02 05:21:37.000000000 -0800
@@ -98,6 +98,17 @@
 {
 	int error = -ENODEV;
 	if (dev->bus->match(dev,drv)) {
+
+		if (drv->drvdata_size > 0) {
+			dev->driver_data = kmalloc(drv->drvdata_size);
+			if (dev->driver_data)
+				memset(dev->driver_data, 0, drv->drvdata_size);
+			else
+				return -ENOMEM;
+		}
+		else
+			dev->driver_data = NULL;
+
 		dev->driver = drv;
 		if (drv->probe) {
 			if (!(error = drv->probe(dev)))
@@ -166,6 +177,12 @@
 		devclass_remove_device(dev);
 		if (drv->remove)
 			drv->remove(dev);
+		if (drv->drvdata_size) {
+			if (dev->driver_data)
+				kfree(dev->driver_data);
+			else
+				BUG_ON(drv->drvdata_size != -1);
+		}
 		dev->driver = NULL;
 	}
 }

--FL5UXtIhxfXey3p5--

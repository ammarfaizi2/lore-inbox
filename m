Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUC0O1P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 09:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUC0O1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 09:27:15 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:42117 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261756AbUC0O0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 09:26:53 -0500
From: Frank.A.Uepping@t-online.de (Frank A. Uepping)
To: Greg KH <greg@kroah.com>
Subject: Re: struct device::release issue
Date: Sat, 27 Mar 2004 15:26:25 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
References: <200403061247.24251.Frank.A.Uepping@t-online.de> <20040327011436.GB14076@kroah.com>
In-Reply-To: <20040327011436.GB14076@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_R8YZA6stHKqfCfV"
Message-Id: <200403271526.25505.Frank.A.Uepping@t-online.de>
X-Seen: false
X-ID: ECTMMqZage-VUdeT1-66Pjz+jztrMPjEBBwoZLwd9bA+9h4Sk9jG0a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_R8YZA6stHKqfCfV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 27 March 2004 02:14, Greg KH wrote:
> On Sat, Mar 06, 2004 at 12:47:24PM +0100, Frank A. Uepping wrote:
> > Hi,
> > if device_add fails (e.g. bus_add_device returns an error) then the release 
> > method will be called for the device. Is this a bug or a feature?
> 
> Are you sure this will happen?  device_initialize() gets a reference
> that is still present after device_add() fails, right?  So release()
> will not get called.
At the label PMError, kobject_unregister is called, which decrements the
recount by 2, which will result in calling release at label Done (put_device).

kobject_unregister should be superseded by kobject_del.
Here is a patch:

--- linux-2.6.4/drivers/base/core.c.orig        Sat Mar 13 10:33:40 2004
+++ linux-2.6.4/drivers/base/core.c     Sat Mar 27 15:04:27 2004
@@ -249,7 +249,7 @@
  BusError:
        device_pm_remove(dev);
  PMError:
-       kobject_unregister(&dev->kobj);
+       kobject_del(&dev->kobj);
  Error:
        if (parent)
                put_device(parent);


I have attached a simple module, which demonstrates the behavior.

/FAU

--Boundary-00=_R8YZA6stHKqfCfV
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="device_add_bug.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="device_add_bug.c"

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/device.h>
#include <../drivers/base/power/power.h>


#define DBG(format, arg...) do { printk(KERN_DEBUG "foo: %s(): " format "\n", __FUNCTION__ , ## arg); } while (0)


int device_add(struct device *dev)  // Defined in drivers/base/core.c
{
	struct device * parent;
	int error;

	DBG("1. refcount=%d", atomic_read(&dev->kobj.refcount));

	dev = get_device(dev);
	if (!dev || !strlen(dev->bus_id))
		return -EINVAL;

	DBG("2. refcount=%d", atomic_read(&dev->kobj.refcount));

	parent = get_device(dev->parent);

	pr_debug("DEV: registering device: ID = '%s'\n", dev->bus_id);

	/* first, register with generic layer. */
	kobject_set_name(&dev->kobj,dev->bus_id);
	if (parent)
		dev->kobj.parent = &parent->kobj;

	if ((error = kobject_add(&dev->kobj)))
		goto Error;

	DBG("3. refcount=%d", atomic_read(&dev->kobj.refcount));

	// e.g. device_pm_add failed
	error = -EBUSY;
	goto PMError;
/*
	if ((error = device_pm_add(dev)))
		goto PMError;
	if ((error = bus_add_device(dev)))
		goto BusError;
	down_write(&devices_subsys.rwsem);
	if (parent)
		list_add_tail(&dev->node,&parent->children);
	up_write(&devices_subsys.rwsem);

	if (platform_notify)
		platform_notify(dev);
*/
 Done:
	put_device(dev);
	DBG("5. refcount=%d", atomic_read(&dev->kobj.refcount));
	return error;
 BusError:
	device_pm_remove(dev);
 PMError:
	kobject_unregister(&dev->kobj);
	DBG("4. refcount=%d", atomic_read(&dev->kobj.refcount));
 Error:
	if (parent)
		put_device(parent);
	goto Done;
}


void foo_release(struct device* dev)
{
	DBG("XXX: called even if device_add fails?");
}


struct device foo_dev = {
	.bus_id		= "bus",
	.release	= foo_release
};


int __init foo_init(void)
{
	device_initialize(&foo_dev);
	return device_add(&foo_dev);
}


module_init(foo_init);

--Boundary-00=_R8YZA6stHKqfCfV
Content-Type: text/x-makefile;
  charset="iso-8859-1";
  name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Makefile"

obj-m += device_add_bug.o
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

default:
	$(MAKE) -C $(KDIR) SUBDIRS="$(PWD)" modules

--Boundary-00=_R8YZA6stHKqfCfV--

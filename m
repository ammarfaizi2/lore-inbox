Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSHOT2j>; Thu, 15 Aug 2002 15:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSHOT2j>; Thu, 15 Aug 2002 15:28:39 -0400
Received: from imo-m01.mx.aol.com ([64.12.136.4]:30947 "EHLO
	imo-m01.mx.aol.com") by vger.kernel.org with ESMTP
	id <S317347AbSHOT2f>; Thu, 15 Aug 2002 15:28:35 -0400
Message-ID: <3D5BCA32.5060805@netscape.net>
Date: Thu, 15 Aug 2002 15:35:14 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: mochel@osdl.org
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: driverfs: [PATCH] remove bus and improve driver management (2.5.30)
References: <Pine.LNX.4.44.0208150915380.1241-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



mochel@osdl.org wrote:

>
>You're missing the point of the bus driver structure. It is simply there 
>to group all the devices on all the instances of that particular bus in 
>the system. It doesn't care about hierarchy, and what you're doing makes 
>absolutely no sense in anything but a typical PC:
>
>- Not all PCI bridges are Host/PCI bridges. They may exist on some other 
>  proprietary bus. 
>
This is not a problem.  My code does not force pci to be the root driver.

>
>
>- In some embedded systems, USB controllers are sometimes root devices
>
Once again not a problem.

>
>
>- There are such things as PCI->Cardbus->USB->PCI bridge device 
>  pathologies
>
This causes me to change my position.  Drivers should be aranged in the 
following manner while using my patch.
/driverfs
/driverfs/driver
/driverfs/driver/pci
/driverfs/driver/pci/agpgart
/driverfs/driver/pci/parport
/driverfs/driver/pci/parport/lp
/driverfs/driver/pci/parport/parport-ide
/driverfs/driver/pci/serial
/driverfs/driver/pci/cardbus
/driverfs/driver/usb
/driverfs/driver/usb/usb-storage
/driverfs/driver/usb/hid

The code in my patch can do this now.  the only problem is parport could 
belong to a bus other than pci.  The current model (without my patch) 
isn't even capable of presenting parport properly.  Parport has IEEE 
1284 transfers and therefore has device ids.  The truth is parport could 
almost be considered a bus.  It already allows for drivers to be 
attached to it.  And parport is just one example.  These drivers of 
course can not be represented in the current model.

Here's a more experimental way to go about it that would solve the 
problem listed above: (> = link)
/driverfs
/driverfs/driver
/driverfs/driver/pci
/driverfs/driver/sys
/driverfs/driver/usb
/driverfs/driver/ide
/driverfs/driver/agpgart
/driverfs/driver/parport
/driverfs/driver/serial
/driverfs/driver/lp
/driverfs/driver/hid
/driverfs/driver/pci/agpgart>
/driverfs/driver/pci/parport>
/driverfs/driver/pci/serial>
/driverfs/driver/pci/usb>
/driverfs/driver/pci/ide>
/driverfs/driver/sys/parport>
/driverfs/driver/sys/serial>
/driverfs/driver/usb/hid>
/driverfs/driver/parport/ide>
/driverfs/driver/parport/lp>
/driverfs/driver/serial/lp>


This is just something to think about.  Drivers could attach to multiple 
drivers and create links for each driver that they're attached to.  The 
links would create an illusion to the user that there was a complex 
driver tree.  Therefore this idea is simple yet ellegant.  I just came 
up with this right now and actually I like it quite a bit.  Links like 
this would be easy as pie to make.  All I'd have to do is change the 
make_dir code as well as a couple things in adm.c.


>
>
>As far as the lp driver goes: fix it. It's been on my list for sometime, 
>but I havne't had a chance to get to it. But, I'm not going to change the 
>driver model to special case legacy devices. 
>
lp isn't the only parport child driver.  parport-ide also comes to mind. 
 There probably are more and there could be more added in the future.

>
>But, that's a _bad_ thing. Bus drivers and device drivers are completely 
>separate entities, with completely separate semantics. Why munge them 
>together? That only convolutes the model and the code. 
>
Look at the code for yourself, I've attached it to the end of the email. 
 It's not munged or convoluted at all.  If anything it's more efficient 
than the previous code.

>
>
>>>>  `This patch also provides user level driver management support 
>>>>through the advanced features of the new interface.  It creates a file 
>>>>entry named "driver" for each device.
>>>>To attach a driver simply echo the name of the driver you want to 
>>>>attach.  For example:
>>>>#cd ./root/pci0/00:00.0
>>>>#echo "agpgart" > driver
>>>>
>
>man 8 modprobe
>
I am fully aware of modutils.  The problem is modutils should not manage 
drivers.  I feel its most important function is to load code into a 
running kernel.  The driver model, as it already does manage drivers 
including those loaded as modules, should do the rest.  If a user wants 
more control over the driver attaching process he or she can use 
"driver".  I may even add more functionality to it later.  When 
contrasting it's similair to the relationship between a manual and 
automatic.  More user control is always better.  In this case you get an 
automatic with a manual override.  When designing an interface that is 
going to unite all the existing methods it has to be scaleable.  3rd 
party drivers will come in to play for some users and users may want to 
choose which drivers attach to which devices.  This provides the 
foundation for such a system.

The ability to remove drivers is also important becuase if you rmmod a 
module then it will detach from all devices it controls.  What if the 
user wanted it to be removed only from one particular device?

>>>>If you read the driver file you will get the name of the loaded driver 
>>>>if a driver is loaded.  For example:
>>>>#cat driver
>>>>output: agpgart
>>>>
>>>Now this is a nice idea.  But I was thinking of moving the symlink from
>>>the bus/pci/devices to be under the specific driver in
>>>bus/pci/drivers/foo_driver.  That would show you at a simple glance
>>>which driver is bound to which device.  But putting the name in the
>>>device entry in the /root tree would be good enough too.
>>>
>
>I've been meaning to do both for sometime. I'll consider a patch that does 
>that (and just that).
>
Ok.


Thanks,
Adam
/*from device.h */
struct device_driver {
    char            * name;
    struct device_driver    * parent;

    rwlock_t        lock;
    atomic_t        refcount;
    list_t            node;         /* node in parent driver's list */
    list_t            children;
    list_t            attached_devices;/* devices the driver is attached 
to */
    list_t            child_devices;     /* devices attached to the 
devices in
                           in "attached_devices" */

    struct driver_dir_entry    dir;

    int    (*probe)    (struct device * dev);
    int     (*remove)    (struct device * dev);

    int    (*suspend)    (struct device * dev, u32 state, u32 level);
    int    (*resume)    (struct device * dev, u32 level);

    void    (*release)    (struct device_driver * drv);
    int    (*match)    (struct device * dev, struct device_driver * drv);

};


/*
 * driver.c - centralized device driver management
 *
 */

#define DEBUG 0

#include <linux/device.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/init.h>
#include "base.h"

static LIST_HEAD(global_driver_list);

static struct driver_dir_entry driver_root_dir = {
    name:    "driver",
    mode:    (S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO),
};

int driver_for_each_attached_dev(struct device_driver * drv, void * 
data, int (*callback)(struct device *, void * ))
{
    struct device * next;
    struct device * dev = NULL;
    struct list_head * node;
    int error = 0;

    get_driver(drv);
    read_lock(&drv->lock);
    node = drv->attached_devices.next;
    while (node != &drv->attached_devices) {
        next = list_entry(node,struct device,driver_list);
        get_device(next);
        read_unlock(&drv->lock);

        if (dev)
            put_device(dev);
        dev = next;
        if ((error = callback(dev,data))) {
            put_device(dev);
            break;
        }
        read_lock(&drv->lock);
        node = dev->driver_list.next;
    }
    read_unlock(&drv->lock);
    if (dev)
        put_device(dev);
    put_driver(drv);
    return error;
}

int driver_for_each_child_dev(struct device_driver * bus, void * data,
             int (*callback)(struct device * dev, void * data))
{
    struct device * next;
    struct device * dev = NULL;
    struct list_head * node;
    int error = 0;

    get_driver(bus);
    read_lock(&bus->lock);
    node = bus->child_devices.next;
    while (node != &bus->child_devices) {
        next = list_entry(node,struct device,bus_list);
        get_device(next);
        read_unlock(&bus->lock);

        if (dev)
            put_device(dev);
        dev = next;
        if ((error = callback(dev,data))) {
            put_device(dev);
            break;
        }
        read_lock(&bus->lock);
        node = dev->bus_list.next;
    }
    read_unlock(&bus->lock);
    if (dev)
        put_device(dev);
    put_driver(bus);
    return error;
}

int driver_for_each_drv(struct device_driver * bus, void * data,
             int (*callback)(struct device_driver * drv, void * data))
{
    struct device_driver * next;
    struct device_driver * drv = NULL;
    struct list_head * driver;
    int error = 0;

    /* pin bus in memory */
    get_driver(bus);

    read_lock(&bus->lock);
    driver = bus->children.next;
    while (driver != &bus->children) {
        next = list_entry(driver,struct device_driver,node);
        get_driver(next);
        read_unlock(&bus->lock);

        if (drv)
            put_driver(drv);
        drv = next;
        if ((error = callback(drv,data))) {
            put_driver(drv);
            break;
        }
        read_lock(&bus->lock);
        driver = drv->node.next;
    }
    read_unlock(&bus->lock);
    if (drv)
        put_driver(drv);
    put_driver(bus);
    return error;
}


/**
 * drv_add_device - add device to driver
 * @dev:    device being added
 *
 * Add the device to its driver's list of child devices.
 * Try and bind the device to a driver.
 */
int driver_add_device(struct device * dev)
{
    if (dev->bus) {
        pr_debug("registering %s with bus 
'%s'\n",dev->bus_id,dev->bus->name);
        get_driver(dev->bus);
        write_lock(&dev->bus->lock);
        list_add_tail(&dev->bus_list,&dev->bus->child_devices);
        write_unlock(&dev->bus->lock);
}
    return 0;
}

/**
 * drv_remove_device - remove device from driver
 * @dev:    device to be removed
 *
 * Delete device from drivers's list.
 */
void driver_remove_device(struct device * dev)
{
    if (dev->bus) {
        write_lock(&dev->bus->lock);
        list_del_init(&dev->bus_list);
        write_unlock(&dev->bus->lock);
        put_driver(dev->bus);
    }
}


/**
 * driver_make_dir - create a driverfs directory for a driver
 * @drv:    driver in question
 */

static int driver_make_dir(struct device_driver * drv)
{
    int error;
    struct driver_dir_entry * parent = NULL;
    drv->dir.name = drv->name;
    if (drv->parent)
        parent = &drv->parent->dir;
    else
        parent = &driver_root_dir;

    error = device_create_dir(&drv->dir,parent);
    return error;
}

/**
 * driver_register - register driver with bus driver
 * @drv:    driver to register
 *
 * Add to parent driver's list of drivers
 */
int driver_register(struct device_driver * drv)
{
    atomic_set(&drv->refcount,2);
    rwlock_init(&drv->lock);
    INIT_LIST_HEAD(&drv->attached_devices);
    INIT_LIST_HEAD(&drv->child_devices);
    INIT_LIST_HEAD(&drv->children);
    INIT_LIST_HEAD(&drv->node);
    if (drv->parent){
        pr_debug("Registering driver '%s' with bus 
'%s'\n",drv->name,drv->parent->name);
        get_driver(drv->parent);
        list_add_tail(&drv->node,&drv->parent->children);
    }else
        list_add_tail(&drv->node,&global_driver_list);
    driver_make_dir(drv);
    if (drv->parent)
        driver_attach(drv);
    put_driver(drv);
    return 0;
}


static void __remove_driver(struct device_driver * drv)
{
    pr_debug("Unregistering driver '%s' from bus 
'%s'\n",drv->name,drv->parent->name);
    driver_detach(drv);
    driverfs_remove_dir(&drv->dir);
    if (drv->release)
        drv->release(drv);
    put_driver(drv->parent);
}

void remove_driver(struct device_driver * drv)
{
    write_lock(&drv->parent->lock);
    atomic_set(&drv->refcount,0);
    list_del_init(&drv->node);
    write_unlock(&drv->parent->lock);
    __remove_driver(drv);
}

/**
 * put_driver - decrement driver's refcount and clean up if necessary
 * @drv:    driver in question
 */
void put_driver(struct device_driver * drv)
{
    if (!atomic_dec_and_lock(&drv->refcount,&device_lock))
        return;
    list_del_init(&drv->node);
    spin_unlock(&device_lock);
    __remove_driver(drv);
}

static int __init drv_init(void)
{
    return driverfs_create_dir(&driver_root_dir,NULL);
}

core_initcall(drv_init);

EXPORT_SYMBOL(driver_for_each_dev);
EXPORT_SYMBOL(driver_for_each_child_dev);
EXPORT_SYMBOL(driver_for_each_drv);
EXPORT_SYMBOL(driver_register);
EXPORT_SYMBOL(put_driver);
EXPORT_SYMBOL(remove_driver);




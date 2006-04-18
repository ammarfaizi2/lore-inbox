Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWDRAy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWDRAy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 20:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWDRAy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 20:54:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:44000 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932093AbWDRAyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 20:54:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rudolf Marek <r.marek@sh.cvut.cz>
Subject: Re: [RFC] Watchdog device class
Date: Tue, 18 Apr 2006 02:54:47 +0200
User-Agent: KMail/1.9.1
Cc: wim@iguana.be, linux-kernel@vger.kernel.org
References: <4443EED9.30603@sh.cvut.cz>
In-Reply-To: <4443EED9.30603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200604180254.47827.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 April 2006 21:39, Rudolf Marek wrote:
> I wanted to create a watchdog driver for I2C W83792D chip and I realized
> that there is no clean way how to connect the existing I2C device driver
> with the watchdog ops. As the consequence of this I created new watchdog
> device class.

Good, I've missed this before as well, but did have the patience to
do something about it.

Wim used to have an experimental tree with a similar idea. Did you look
at that before you started this? Is that tree still maintained?

> +#include <linux/module.h>
> +#include "watchdog.h"
> +
> +static struct class *watchdog_dev_class;
> +static dev_t watchdog_devt;
> +
> +#define WATCHDOG_DEV_MAX 8 /* 8 watchdogs should be enough for everyone... */
> +

What's the point in having more than one watchdog active?
If you want more than one, why hardcode a specific limit?

> +static int watchdog_dev_add_device(struct class_device *class_dev,
> +                               struct class_interface *class_intf)
> +{
> +       int err = 0;
> +       struct watchdog_device *watchdog = to_watchdog_device(class_dev);
> +
> +       if (watchdog->id >= WATCHDOG_DEV_MAX) {
> +               dev_err(class_dev->dev, "too many watchdogs\n");
> +               return -EINVAL;
> +       }
> +
> +       mutex_init(&watchdog->char_lock);
> +
> +       cdev_init(&watchdog->char_dev, &watchdog_dev_fops);
> +       watchdog->char_dev.owner = watchdog->owner;
> +
> +       if (cdev_add(&watchdog->char_dev, MKDEV(MAJOR(watchdog_devt), watchdog->id), 1)) {
> +               cdev_del(&watchdog->char_dev);
> +               dev_err(class_dev->dev,
> +                       "failed to add char device %d:%d\n",
> +                       MAJOR(watchdog_devt), watchdog->id);
> +               return -ENODEV;
> +       }
> +
> +       watchdog->watchdog_dev = class_device_create(watchdog_dev_class, NULL,
> +                                               MKDEV(MAJOR(watchdog_devt), watchdog->id),
> +                                               class_dev->dev, "watchdog%d", watchdog->id);

Existing user space typically depends on the watchdog device being called
/dev/watchdog, which breaks if your devices are called watchdog%d.
I can see two ways out of this:

1. add a udev rule that creates /dev/watchdog as an alias for /dev/watchdog0.
2. add a misc device /dev/watchdog that works as a multiplexer for all others,
   similar to the idea of /dev/input/mice as a multiplexer for /dev/input/mouse%d.

> +#define WATCHDOG_DEVICE_NAME_SIZE 20
> +
> +struct watchdog_device {
> +       struct class_device class_dev;
> +       struct module *owner;
> +
> +       int id;
> +       char name[WATCHDOG_DEVICE_NAME_SIZE];

Can this be the embedded name in class_device?

> +
> +       struct watchdog_class_ops *ops;
> +       struct mutex ops_lock;
> +
> +       struct class_device *watchdog_dev; 

Having two classes (watchdog_class and watchdog_dev_class) as well as
two class_devices (class_dev and watchdog_dev) per device seems wrong.
What is the reason for splitting these?

> +/* watchdog_device_register_simple, will register device into watchdog class
> +   just with default timeout from kernel configuration.
> +   
> +   watchdog_device_register_selfping, will register the watchdog device same 
> +   way as above function, but the device will be pinged every selfping interval
> +   (useful for watchdog with damm fast timeouts)
> +*/
> +
> +#define watchdog_device_register_simple(name, dev, ops)  \
> +           _watchdog_device_register(name, dev, ops, THIS_MODULE, CONFIG_WATCHDOG_DEFAULT_TIMEOUT, 0)
> +
> +#define watchdog_device_register_selfping(name, dev, ops, selfping)  \
> +           _watchdog_device_register(name, dev, ops, THIS_MODULE, CONFIG_WATCHDOG_DEFAULT_TIMEOUT, selfping)

All callers of this seem to have constant arguments (except dev), so you
could easily put name, owner, timeout and selfping into the ops structure.
Maybe the structure could use a different name then.

> +static ssize_t watchdog_sysfs_show_name(struct class_device *dev, char *buf)
> +{
> +       return sprintf(buf, "%s\n", to_watchdog_device(dev)->name);
> +}
> +static CLASS_DEVICE_ATTR(name, S_IRUGO, watchdog_sysfs_show_name, NULL);

Why do you need a name attribute? Should the name of the class_device
itself not be enough as an identifier?

> +
> +module_init(watchdog_sysfs_init);
> +module_exit(watchdog_sysfs_exit);
> +
> +MODULE_AUTHOR("Rudolf Marek <r.marek@sh.cvut.cz>");
> +MODULE_DESCRIPTION("Watchdog class sysfs interface");
> +MODULE_LICENSE("GPL");

What's the point in making the sysfs stuff an extra module? I guess it
would be a lot simpler to just always add the files. We might want to
make the dev interface optional, but then again it is what all applications
to date are using, so you may just as well have a single base module
and no infrastructure for multiple interfaces at all.

	Arnd <><

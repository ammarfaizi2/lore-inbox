Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVC0WsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVC0WsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVC0WsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:48:25 -0500
Received: from peabody.ximian.com ([130.57.169.10]:62118 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261615AbVC0Wrx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:47:53 -0500
Subject: [RFC] Driver States
From: Adam Belay <abelay@novell.com>
To: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Content-Type: text/plain
Date: Sun, 27 Mar 2005 17:42:47 -0500
Message-Id: <1111963367.3503.152.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic power management may require devices and drivers to transition
between various physical and logical states.  I would like to start a
discussion on how these might be defined at the bus, driver, and class
levels.

Bus Level
=========
At the bus level, there are two state attributes, power and
enable/disable.  Enable/disable may mean different things on different
buses, but they generally refer to resource decoding.  A device can only
be enabled during a non-off power state.

A possible API:

struct bus_type {
	char			* name;

	struct subsystem	subsys;
	struct kset		drivers;
	struct kset		devices;

	struct bus_attribute	* bus_attrs;
	struct device_attribute	* dev_attrs;
	struct driver_attribute	* drv_attrs;

	int		(*match)(struct device * dev, struct device_driver * drv);
	int		(*hotplug) (struct device *dev, char **envp, 
				    int num_envp, char *buffer, int buffer_size);
	int		(*suspend)(struct device * dev, pm_message_t state);
	int		(*resume)(struct device * dev);
	int		(*enable)(struct device * dev);
	int		(*disable)(struct device * dev);
};

Driver Level
============
At the driver level there are two areas of interest, physical and
logical state.  There is an additional concern of transitioning between
these states multiple times.  Because a driver acts as a bridge between
physical and logical components, I think separating these steps seems
natural.

A possible API:

struct device_driver {
	char			* name;
	struct bus_type		* bus;

	struct semaphore	unload_sem;
	struct kobject		kobj;
	struct list_head	devices;

	struct module 		* owner;

	int	(*attach)	(struct device * dev);
	int	(*start)	(struct device * dev);
	int	(*open)		(struct device * dev);
	int	(*close)	(struct device * dev);
	void 	(*stop)		(struct device * dev);
	void	(*detach)	(struct device * dev);
	void	(*shutdown)	(struct device * dev);
	int	(*suspend)	(struct device * dev, u32 state, u32 level);
	int	(*resume)	(struct device * dev, u32 level);
};

*attach - allocates data structures, creates sysfs entries, prepares driver
       to handle the hardware.
 
*start -  Sets up device resources and configures the hardware.  Loads
firmware, etc.
(physical)
 
*open -   engages the hardware, and makes it usable by the class device.
(logical and physical)
 
*close -  disengages the hardware, and stops class level access
(logical and physical)
 
*stop -   physically disables the hardware
(physical)
 
*detach - tears down the driver and releases it from the "struct device"

The idea behind *attach and *detach is to move code that would only need
to be called once out of *probe and *remove.

A table could be defined that indicates what should be called for each
power level transition.  *suspend and *resume could handle any extra
steps (ex. saving state).  As an example, *start and *stop may only be
called when power is going to be lost entirely.

Additional states are class specific and would only be used after *open
is called.

Class Level
===========
At the class level, we could have a simple start/stop mechanism.

A possible API:

struct class_device {
	struct list_head	node;

	struct kobject		kobj;
	struct class		* class;
	struct device		* dev;
	void			* class_data;

	char	class_id[BUS_ID_SIZE];

	int	(*attach)	(struct device * dev);
	int	(*start)	(struct device * dev);
	void 	(*stop)		(struct device * dev);
	void	(*detach)	(struct device * dev);
};

*attach - allocates data structures, creates sysfs entries, prepares
class to handle the device.

*start - start the logical class device, accept userspace interaction

*stop - stop the logical class device, deny userspace interaction

*detach - tear down the class driver's bindings with this class device


These are just rough ideas.  I look forward to any comments or
alternative approaches.

Thanks,
Adam



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270372AbUJUHQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270372AbUJUHQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270333AbUJUHNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:13:24 -0400
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:59016 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270321AbUJUHFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:05:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Driver core change request
Date: Thu, 21 Oct 2004 02:05:40 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
References: <200410062354.18885.dtor_core@ameritech.net> <20041008214820.GA1096@kroah.com> <200410120129.59221.dtor_core@ameritech.net>
In-Reply-To: <200410120129.59221.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210205.43399.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 October 2004 01:29 am, Dmitry Torokhov wrote:
> For now I added:
> 
> - "driver" default device attribute that produces name of currently bound
>   driver uppon read.
> - bus->rebind_handler method that is called when someone writes to "driver"
>   attribute and allows to perform bunctions like disconnecting device or
>   rebinding it to alternative driver in bus-specific way.
> - "bind_mode" default device and driver attributes that can be "auto" or
>   "manual". When device or driver marked as manual bind device_attach()
>   and driver_attach() will ignore them. They are expected to be bound by
>   bus->rebind_handler (via driver_probe_device()).
> 
> I also renamed bus_match to driver_probe_device() and exported it, along
> with device_attach and driver_attach.
> 
> Please let me know if its acceptable.
> 

Greg,

Sorry for bothering you but cold you tell me if you are staisfied with the
patches or I need to look for some alternative. As an example of usage
please find my working copy of serio.c below.

Thanks! 

-- 
Dmitry

/*
 *  The Serio abstraction module
 *
 *  Copyright (c) 1999-2004 Vojtech Pavlik
 *  Copyright (c) 2004 Dmitry Torokhov
 *  Copyright (c) 2003 Daniele Bellucci
 */

/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 * Should you need to contact me, the author, you can do so either by
 * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
 * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
 */

#include <linux/stddef.h>
#include <linux/module.h>
#include <linux/serio.h>
#include <linux/errno.h>
#include <linux/wait.h>
#include <linux/completion.h>
#include <linux/sched.h>
#include <linux/smp_lock.h>
#include <linux/suspend.h>
#include <linux/slab.h>

MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
MODULE_DESCRIPTION("Serio abstraction core");
MODULE_LICENSE("GPL");

EXPORT_SYMBOL(serio_interrupt);
EXPORT_SYMBOL(__serio_register_port);
EXPORT_SYMBOL(serio_unregister_port);
EXPORT_SYMBOL(__serio_unregister_port_delayed);
EXPORT_SYMBOL(serio_register_driver);
EXPORT_SYMBOL(serio_unregister_driver);
EXPORT_SYMBOL(serio_open);
EXPORT_SYMBOL(serio_close);
EXPORT_SYMBOL(serio_rescan);
EXPORT_SYMBOL(serio_reconnect);

/*
 * serio_sem protects entire serio subsystem and is taken every time
 * serio port or driver registrered or unregistered.
 */
static DECLARE_MUTEX(serio_sem);

static LIST_HEAD(serio_list);

struct bus_type serio_bus = {
	.name =	"serio",
};

static void serio_add_port(struct serio *serio);
static void serio_destroy_port(struct serio *serio);
static void serio_reconnect_port(struct serio *serio);
static void serio_disconnect_port(struct serio *serio);

/*
 * Basic serio -> driver core mappings
 */

static void serio_bind_driver(struct serio *serio, struct serio_driver *drv)
{
	down_write(&serio_bus.subsys.rwsem);
	driver_probe_device(&drv->driver, &serio->dev);
	up_write(&serio_bus.subsys.rwsem);
}

static void serio_release_driver(struct serio *serio)
{
	down_write(&serio_bus.subsys.rwsem);
	device_release_driver(&serio->dev);
	up_write(&serio_bus.subsys.rwsem);
}

static void serio_find_driver(struct serio *serio)
{
	down_write(&serio_bus.subsys.rwsem);
	device_attach(&serio->dev);
	up_write(&serio_bus.subsys.rwsem);
}

/*
 * Serio event processing.
 */

struct serio_event {
	int type;
	struct serio *serio;
	struct module *owner;
	struct list_head node;
};

enum serio_event_type {
	SERIO_RESCAN,
	SERIO_RECONNECT,
	SERIO_REGISTER_PORT,
	SERIO_UNREGISTER_PORT,
};

static spinlock_t serio_event_lock = SPIN_LOCK_UNLOCKED;	/* protects serio_event_list */
static LIST_HEAD(serio_event_list);
static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
static DECLARE_COMPLETION(serio_exited);
static int serio_pid;

static void serio_queue_event(struct serio *serio, struct module *owner, int event_type)
{
	unsigned long flags;
	struct serio_event *event;

	spin_lock_irqsave(&serio_event_lock, flags);

	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
		__module_get(owner);

		event->type = event_type;
		event->serio = serio;
		event->owner = owner;

		list_add_tail(&event->node, &serio_event_list);
		wake_up(&serio_wait);
	} else
		printk(KERN_ERR "serio: Not enough memory to queue event %d\n", event_type);

	spin_unlock_irqrestore(&serio_event_lock, flags);
}

static struct serio_event *serio_get_event(void)
{
	struct serio_event *event = NULL;
	struct list_head *node;
	unsigned long flags;

	spin_lock_irqsave(&serio_event_lock, flags);

	if (!list_empty(&serio_event_list)) {
		node = serio_event_list.next;
		event = container_of(node, struct serio_event, node);
		list_del_init(node);
	}

	spin_unlock_irqrestore(&serio_event_lock, flags);

	return event;
}

static void serio_handle_events(void)
{
	struct serio_event *event;

	down(&serio_sem);

	while ((event = serio_get_event())) {

		switch (event->type) {
			case SERIO_REGISTER_PORT :
				serio_add_port(event->serio);
				serio_find_driver(event->serio);
				break;

			case SERIO_UNREGISTER_PORT :
				serio_disconnect_port(event->serio);
				serio_destroy_port(event->serio);
				break;

			case SERIO_RECONNECT :
				serio_reconnect_port(event->serio);
				break;

			case SERIO_RESCAN :
				serio_disconnect_port(event->serio);
				serio_find_driver(event->serio);
				break;
			default:
				break;
		}

		module_put(event->owner);
		kfree(event);
	}

	up(&serio_sem);
}

/*
 * Remove all events that have been submitted for a gicen serio port.
 */
static void serio_remove_pending_events(struct serio *serio)
{
	struct list_head *node, *next;
	struct serio_event *event;
	unsigned long flags;

	spin_lock_irqsave(&serio_event_lock, flags);

	list_for_each_safe(node, next, &serio_event_list) {
		event = list_entry(node, struct serio_event, node);
		if (event->serio == serio) {
			list_del_init(node);
			kfree(event);
		}
	}

	spin_unlock_irqrestore(&serio_event_lock, flags);
}

/*
 * Destroy child serio port (if any) that has not been fully registered yet.
 *
 * Note that we rely on the fact that port can have only one child and therefore
 * only one child registration request can be pending. Additionally, children
 * are registered by driver's connect() handler so there can't be a grandchild
 * pending registration together with a child.
 */
static struct serio *serio_get_pending_child(struct serio *parent)
{
	struct serio_event *event;
	struct serio *serio = NULL;
	unsigned long flags;

	spin_lock_irqsave(&serio_event_lock, flags);

	list_for_each_entry(event, &serio_event_list, node) {
		if (event->type == SERIO_REGISTER_PORT && event->serio->parent == parent) {
			serio = event->serio;
			break;
		}
	}

	spin_unlock_irqrestore(&serio_event_lock, flags);
	return serio;
}

static int serio_thread(void *nothing)
{
	lock_kernel();
	daemonize("kseriod");
	allow_signal(SIGTERM);

	do {
		serio_handle_events();
		wait_event_interruptible(serio_wait, !list_empty(&serio_event_list));
		if (current->flags & PF_FREEZE)
			refrigerator(PF_FREEZE);
	} while (!signal_pending(current));

	printk(KERN_DEBUG "serio: kseriod exiting\n");

	unlock_kernel();
	complete_and_exit(&serio_exited, 0);
}


/*
 * Serio port operations
 */

static ssize_t serio_show_description(struct device *dev, char *buf)
{
	struct serio *serio = to_serio_port(dev);
	return sprintf(buf, "%s\n", serio->name);
}

static struct device_attribute serio_device_attrs[] = {
	__ATTR(description, S_IRUGO, serio_show_description, NULL),
	__ATTR_NULL
};


static void serio_release_port(struct device *dev)
{
	struct serio *serio = to_serio_port(dev);

printk(KERN_INFO "serio: releasing %s\n", serio->name);
	kfree(serio);
	module_put(THIS_MODULE);
}

/*
 * Prepare serio port for registration.
 */
static void serio_init_port(struct serio *serio)
{
	static atomic_t serio_no = ATOMIC_INIT(0);

	__module_get(THIS_MODULE);

	spin_lock_init(&serio->lock);
	init_MUTEX(&serio->drv_sem);
	device_initialize(&serio->dev);
	snprintf(serio->dev.bus_id, sizeof(serio->dev.bus_id),
		 "serio%d", atomic_inc_return(&serio_no) - 1);
	serio->dev.bus = &serio_bus;
	serio->dev.release = serio_release_port;
	if (serio->parent)
		serio->dev.parent = &serio->parent->dev;
}

/*
 * Complete serio port registration.
 * Driver core will attempt to find appropriate driver for the port.
 */
static void serio_add_port(struct serio *serio)
{
	if (serio->parent) {
		serio_pause_rx(serio->parent);
		serio->parent->child = serio;
		serio_continue_rx(serio->parent);
	}

	list_add_tail(&serio->node, &serio_list);
	device_add(&serio->dev);
	serio->registered = 1;
}

/*
 * serio_destroy_port() completes deregistration process and removes
 * port from the system.
 */
static void serio_destroy_port(struct serio *serio)
{
	struct serio *child;

printk(KERN_INFO "serio: destroying port %s, cnt: %d\n", serio->name,  atomic_read(&serio->dev.kobj.kref.refcount));
	child = serio_get_pending_child(serio);
	if (child) {
		serio_remove_pending_events(child);
		put_device(&child->dev);
	}

	if (serio->parent) {
		serio_pause_rx(serio->parent);
		serio->parent->child = NULL;
		serio->parent = NULL;
		serio_continue_rx(serio->parent);
	}

	if (serio->registered) {
printk(KERN_INFO "serio: destroying port %s (device_del)\n", serio->name);
		device_del(&serio->dev);
		list_del_init(&serio->node);
		serio->registered = 0;
	}

	serio_remove_pending_events(serio);
printk(KERN_INFO "serio: destroying port %s (put_device)\n", serio->name);
	put_device(&serio->dev);
}

/*
 * Reconnect serio port and all its children (re-initialize attached devices)
 */
static void serio_reconnect_port(struct serio *serio)
{
	do {
		if (!serio->drv || !serio->drv->reconnect || serio->drv->reconnect(serio)) {
			serio_disconnect_port(serio);
			serio_find_driver(serio);
			/* Ok, old children are now gone, we are done */
			break;
		}
		serio = serio->child;
	} while (serio);
}

/*
 * serio_disconnect_port() unbinds a port from its driver. As a side effect
 * all child ports are unbound and destroyed.
 */
static void serio_disconnect_port(struct serio *serio)
{
	struct serio *s, *parent;

printk(KERN_INFO "serio: disconnecting port %s\n", serio->name);

	if (serio->child) {
		/*
		 * Children ports should be disconnected and destroyed
		 * first, staring with the leaf one, since we don't want
		 * to do recursion
		 */
		for (s = serio; s->child; s = s->child)
			/* empty */;

		do {
			parent = s->parent;

printk(KERN_INFO "serio: releasing driver on child port %s\n", s->name);
			serio_release_driver(s);
printk(KERN_INFO "serio: destroying port %s\n", s->name);
			serio_destroy_port(s);
		} while ((s = parent) != serio);
	}

	/*
	 * Ok, no children left, now disconnect this port
	 */
printk(KERN_INFO "serio: releasing driver on port %s\n", serio->name);
	serio_release_driver(serio);
}

void serio_rescan(struct serio *serio)
{
	serio_queue_event(serio, NULL, SERIO_RESCAN);
}

void serio_reconnect(struct serio *serio)
{
	serio_queue_event(serio, NULL, SERIO_RECONNECT);
}

/*
 * Submits register request to kseriod for subsequent execution.
 * Note that port registration is always asynchronous.
 */
void __serio_register_port(struct serio *serio, struct module *owner)
{
	serio_init_port(serio);
	serio_queue_event(serio, owner, SERIO_REGISTER_PORT);
}

/*
 * Synchronously unregisters serio port.
 */
void serio_unregister_port(struct serio *serio)
{
	down(&serio_sem);
	serio_disconnect_port(serio);
	serio_destroy_port(serio);
	up(&serio_sem);
}

/*
 * Submits unregister request to kseriod for subsequent execution.
 * Can be used when it is not obvious whether the serio_sem is
 * taken or not and when delayed execution is feasible.
 */
void __serio_unregister_port_delayed(struct serio *serio, struct module *owner)
{
	serio_queue_event(serio, owner, SERIO_UNREGISTER_PORT);
}


/*
 * Serio driver operations
 */

static ssize_t serio_driver_show_description(struct device_driver *drv, char *buf)
{
	struct serio_driver *driver = to_serio_driver(drv);
	return sprintf(buf, "%s\n", driver->description ? driver->description : "(none)");
}

static struct driver_attribute serio_driver_attrs[] = {
	__ATTR(description, S_IRUGO, serio_driver_show_description, NULL),
	__ATTR_NULL
};

static int serio_driver_probe(struct device *dev)
{
	struct serio *serio = to_serio_port(dev);
	struct serio_driver *drv = to_serio_driver(dev->driver);

printk(KERN_INFO "serio: driver probe for %s and %s\n", drv->driver.name, serio->name);
	drv->connect(serio, drv);
	return serio->drv ? 0 : -ENODEV;
}

static int serio_driver_remove(struct device *dev)
{
	struct serio *serio = to_serio_port(dev);
	struct serio_driver *drv = to_serio_driver(dev->driver);

printk(KERN_INFO "serio: driver remove for %s and %s\n", drv->driver.name, serio->name);
	drv->disconnect(serio);
	return 0;
}

void serio_register_driver(struct serio_driver *drv)
{
	down(&serio_sem);

	drv->driver.bus = &serio_bus;
	drv->driver.probe = serio_driver_probe;
	drv->driver.remove = serio_driver_remove;
	driver_register(&drv->driver);

	up(&serio_sem);
}

void serio_unregister_driver(struct serio_driver *drv)
{
	struct serio *serio;

	down(&serio_sem);
	drv->driver.manual_bind = 1;	/* so serio_find_driver ignores it */

start_over:
	list_for_each_entry(serio, &serio_list, node) {
		if (serio->drv == drv) {
			serio_disconnect_port(serio);
			serio_find_driver(serio);
			/* we could've deleted some ports, restart */
			goto start_over;
		}
	}

	driver_unregister(&drv->driver);
	up(&serio_sem);
}

static int serio_rebind_driver(struct device *dev, const char *buf, size_t count)
{
	struct serio *serio = to_serio_port(dev);
	struct device_driver *drv;
	int retval;

	retval = down_interruptible(&serio_sem);
	if (retval)
		return retval;

	if (!strncmp(buf, "none", count)) {
		serio_disconnect_port(serio);
	} else if (!strncmp(buf, "reconnect", count)) {
		serio_reconnect_port(serio);
	} else if (!strncmp(buf, "rescan", count)) {
		serio_disconnect_port(serio);
		serio_find_driver(serio);
	} else if ((drv = driver_find(buf, &serio_bus)) != NULL) {
		serio_disconnect_port(serio);
		serio_bind_driver(serio, to_serio_driver(drv));
		put_driver(drv);
	} else {
		retval = -EINVAL;
	}

	up(&serio_sem);

	return retval;
}

static int serio_bus_match(struct device *dev, struct device_driver *drv)
{
	/*
	 * For now we match everything as real checks are done in
	 * connect methods.
	 */
	return 1;
}

static void serio_set_drv(struct serio *serio, struct serio_driver *drv)
{
	down(&serio->drv_sem);
	serio_pause_rx(serio);
	serio->drv = drv;
	serio_continue_rx(serio);
	up(&serio->drv_sem);
}

/* called from serio_driver->connect/disconnect methods under serio_sem */
int serio_open(struct serio *serio, struct serio_driver *drv)
{
	serio_set_drv(serio, drv);

	if (serio->open && serio->open(serio)) {
		serio_set_drv(serio, NULL);
		return -1;
	}
	return 0;
}

/* called from serio_driver->connect/disconnect methods under serio_sem */
void serio_close(struct serio *serio)
{
	if (serio->close)
		serio->close(serio);

	serio_set_drv(serio, NULL);
}

irqreturn_t serio_interrupt(struct serio *serio,
		unsigned char data, unsigned int dfl, struct pt_regs *regs)
{
	unsigned long flags;
	irqreturn_t ret = IRQ_NONE;

	spin_lock_irqsave(&serio->lock, flags);

        if (likely(serio->drv)) {
                ret = serio->drv->interrupt(serio, data, dfl, regs);
	} else {
		if (!dfl) {
			if ((serio->type != SERIO_8042 &&
			     serio->type != SERIO_8042_XL) || (data == 0xaa)) {
				serio_rescan(serio);
				ret = IRQ_HANDLED;
			}
		}
	}

	spin_unlock_irqrestore(&serio->lock, flags);

	return ret;
}

static int __init serio_init(void)
{
	if (!(serio_pid = kernel_thread(serio_thread, NULL, CLONE_KERNEL))) {
		printk(KERN_ERR "serio: Failed to start kseriod\n");
		return -1;
	}

	serio_bus.dev_attrs = serio_device_attrs;
	serio_bus.drv_attrs = serio_driver_attrs;
	serio_bus.match = serio_bus_match;
	serio_bus.rebind_helper = serio_rebind_driver;
	bus_register(&serio_bus);

	return 0;
}

static void __exit serio_exit(void)
{
	bus_unregister(&serio_bus);
	kill_proc(serio_pid, SIGTERM, 1);
	wait_for_completion(&serio_exited);
}

module_init(serio_init);
module_exit(serio_exit);

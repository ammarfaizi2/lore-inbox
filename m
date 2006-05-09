Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWEITmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWEITmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWEITmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:42:24 -0400
Received: from cantor2.suse.de ([195.135.220.15]:39091 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750777AbWEITmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:42:24 -0400
Date: Tue, 9 May 2006 12:40:44 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device hotplug driver.
Message-ID: <20060509194044.GA374@kroah.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085200.826853000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085200.826853000@sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:00:33AM -0700, Chris Wright wrote:
> +/* xenbus_probe.c */
> +extern char *kasprintf(const char *fmt, ...);

Belongs in a .h file.

> +#define DPRINTK(fmt, args...) \
> +    pr_debug("xenbus_client (%s:%d) " fmt ".\n", __FUNCTION__, __LINE__, ##args)

Please use the dev_dbg() function instead of DPRINTK() or pr_debug().
It's much better and uniquely identifies the driver and device that you
are referring to.

Also, all of the printk() calls in these files should be switched to
dev_err() or dev_warn() for the same reason.

> +int xenbus_watch_path(struct xenbus_device *dev, const char *path,
> +		      struct xenbus_watch *watch,
> +		      void (*callback)(struct xenbus_watch *,
> +				       const char **, unsigned int))
> +{
> +	int err;
> +
> +	watch->node = path;
> +	watch->callback = callback;
> +
> +	err = register_xenbus_watch(watch);
> +
> +	if (err) {
> +		watch->node = NULL;
> +		watch->callback = NULL;
> +		xenbus_dev_fatal(dev, err, "adding watch on %s", path);
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(xenbus_watch_path);
> +
> +
> +int xenbus_watch_path2(struct xenbus_device *dev, const char *path,
> +		       const char *path2, struct xenbus_watch *watch,
> +		       void (*callback)(struct xenbus_watch *,
> +					const char **, unsigned int))
> +{
> +	int err;
> +	char *state = kasprintf("%s/%s", path, path2);
> +	if (!state) {
> +		xenbus_dev_fatal(dev, -ENOMEM, "allocating path for watch");
> +		return -ENOMEM;
> +	}
> +	err = xenbus_watch_path(dev, state, watch, callback);
> +
> +	if (err)
> +		kfree(state);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(xenbus_watch_path2);
> +
> +
> +int xenbus_switch_state(struct xenbus_device *dev,
> +			xenbus_transaction_t xbt,
> +			XenbusState state)

I'm guessing that XenbusState is a typedef?  Please fix the naming to be
Linux kernel compatible.

> +{
> +	/* We check whether the state is currently set to the given value, and
> +	   if not, then the state is set.  We don't want to unconditionally
> +	   write the given state, because we don't want to fire watches
> +	   unnecessarily.  Furthermore, if the node has gone, we don't write
> +	   to it, as the device will be tearing down, and we don't want to
> +	   resurrect that directory.
> +	 */
> +
> +	int current_state;
> +	int err;
> +
> +	if (state == dev->state)
> +		return 0;
> +
> +	err = xenbus_scanf(xbt, dev->nodename, "state", "%d",
> +			       &current_state);
> +	if (err != 1)
> +		return 0;
> +
> +	err = xenbus_printf(xbt, dev->nodename, "state", "%d", state);
> +	if (err) {
> +		if (state != XenbusStateClosing) /* Avoid looping */
> +			xenbus_dev_fatal(dev, err, "writing new state");
> +		return err;
> +	}
> +
> +	dev->state = state;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xenbus_switch_state);
> +
> +
> +/**
> + * Return the path to the error node for the given device, or NULL on failure.
> + * If the value returned is non-NULL, then it is the caller's to kfree.
> + */
> +static char *error_path(struct xenbus_device *dev)
> +{
> +	return kasprintf("error/%s", dev->nodename);
> +}
> +
> +
> +void _dev_error(struct xenbus_device *dev, int err, const char *fmt,
> +		va_list ap)

Global function?  With no description of what it does?  (hint,
describing it in the .h file, in pseudo-kerneldoc form doesn't really
count, it only makes the tools break...)

> +void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt,
> +		      ...)

No kerneldoc for all of the global functions?

> +extern void xenbus_probe(void *);
> +extern int xenstored_ready;

Should be in a .h file.

> +#include <asm/io.h>
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/hypervisor.h>
> +#include <xen/xenbus.h>
> +#ifdef XEN_XENBUS_PROC_INTERFACE
> +#include <xen/xen_proc.h>
> +#endif

#ifdef is not needed.  Put it in the .h file.

> +#include <xen/evtchn.h>
> +
> +#include "xenbus_comms.h"
> +
> +extern struct mutex xenwatch_mutex;

Should be in a .h file.

> +struct xen_bus_type
> +{
> +	char *root;
> +	unsigned int levels;
> +	int (*get_bus_id)(char bus_id[BUS_ID_SIZE], const char *nodename);
> +	int (*probe)(const char *type, const char *dir);
> +	struct bus_type bus;
> +	struct device dev;
> +};

Why have you embedded both a struct bus_type and a struct device into
this structure?  How is the lifecycle handled due to 2 different
reference counted structures?

Also, I note that you statically create this, which isn't the nicest,
why not dynamically create it?

And why a different probe function per bus types?

And the bus id is part of the struct bus_type, why a separate function
to retrieve it?

And what are you doing with the different "levels"?  Is there some
description of how you are using sysfs for this?  Busses should not be
"nested", devices should.  How does sysfs look with this code in it?
What is the /sys/bus/ structure?  What is the /sys/devices/ structure?

> +/* device/<type>/<id> => <type>-<id> */
> +static int frontend_bus_id(char bus_id[BUS_ID_SIZE], const char *nodename)
> +{
> +	nodename = strchr(nodename, '/');
> +	if (!nodename || strlen(nodename + 1) >= BUS_ID_SIZE) {
> +		printk(KERN_WARNING "XENBUS: bad frontend %s\n", nodename);
> +		return -EINVAL;
> +	}
> +
> +	strlcpy(bus_id, nodename + 1, BUS_ID_SIZE);
> +	if (!strchr(bus_id, '/')) {
> +		printk(KERN_WARNING "XENBUS: bus_id %s no slash\n", bus_id);
> +		return -EINVAL;
> +	}
> +	*strchr(bus_id, '/') = '-';
> +	return 0;
> +}

And why all the string logic for device ids and names?  Is that the only
unique way to identify the different devices on your bus?  Why not just
give them a numerical id then?  It would save you a lot of
computation...

> +/* Bus type for frontend drivers. */
> +static int xenbus_probe_frontend(const char *type, const char *name);
> +static struct xen_bus_type xenbus_frontend = {
> +	.root = "device",
> +	.levels = 2, 		/* device/type/<id> */
> +	.get_bus_id = frontend_bus_id,
> +	.probe = xenbus_probe_frontend,
> +	.bus = {
> +		.name  = "xen",
> +		.match = xenbus_match,
> +	},
> +	.dev = {
> +		.bus_id = "xen",
> +	},
> +};
> +
> +/* backend/<type>/<fe-uuid>/<id> => <type>-<fe-domid>-<id> */
> +static int backend_bus_id(char bus_id[BUS_ID_SIZE], const char *nodename)
> +{
> +	int domid, err;
> +	const char *devid, *type, *frontend;
> +	unsigned int typelen;
> +
> +	type = strchr(nodename, '/');
> +	if (!type)
> +		return -EINVAL;
> +	type++;
> +	typelen = strcspn(type, "/");
> +	if (!typelen || type[typelen] != '/')
> +		return -EINVAL;
> +
> +	devid = strrchr(nodename, '/') + 1;
> +
> +	err = xenbus_gather(XBT_NULL, nodename, "frontend-id", "%i", &domid,
> +			    "frontend", NULL, &frontend,
> +			    NULL);
> +	if (err)
> +		return err;
> +	if (strlen(frontend) == 0)
> +		err = -ERANGE;
> +	if (!err && !xenbus_exists(XBT_NULL, frontend, ""))
> +		err = -ENOENT;
> +
> +	kfree(frontend);
> +
> +	if (err)
> +		return err;
> +
> +	if (snprintf(bus_id, BUS_ID_SIZE,
> +		     "%.*s-%i-%s", typelen, type, domid, devid) >= BUS_ID_SIZE)
> +		return -ENOSPC;
> +	return 0;
> +}
> +
> +static int xenbus_uevent_backend(struct device *dev, char **envp,
> +				 int num_envp, char *buffer, int buffer_size);
> +static int xenbus_probe_backend(const char *type, const char *domid);
> +static struct xen_bus_type xenbus_backend = {
> +	.root = "backend",
> +	.levels = 3, 		/* backend/type/<frontend>/<id> */
> +	.get_bus_id = backend_bus_id,
> +	.probe = xenbus_probe_backend,
> +	.bus = {
> +		.name  = "xen-backend",
> +		.match = xenbus_match,
> +		.uevent = xenbus_uevent_backend,
> +	},
> +	.dev = {
> +		.bus_id = "xen-backend",
> +	},
> +};

What is the "frontend/backend" relationship here?

> +static int xenbus_uevent_backend(struct device *dev, char **envp,
> +				 int num_envp, char *buffer, int buffer_size)
> +{
> +	struct xenbus_device *xdev;
> +	struct xenbus_driver *drv;
> +	int i = 0;
> +	int length = 0;
> +
> +	DPRINTK("");
> +
> +	if (dev == NULL)
> +		return -ENODEV;
> +
> +	xdev = to_xenbus_device(dev);
> +	if (xdev == NULL)
> +		return -ENODEV;
> +
> +	/* stuff we want to pass to /sbin/hotplug */
> +	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
> +		       "XENBUS_TYPE=%s", xdev->devicetype);
> +
> +	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
> +		       "XENBUS_PATH=%s", xdev->nodename);
> +
> +	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
> +		       "XENBUS_BASE_PATH=%s", xenbus_backend.root);

Why not use the standard "TYPE" "PATH" and no "XENBUS" stuff?

> +static int xenbus_register_driver_common(struct xenbus_driver *drv,
> +					 struct xen_bus_type *bus)
> +{
> +	int ret;
> +
> +	drv->driver.name = drv->name;
> +	drv->driver.bus = &bus->bus;
> +	drv->driver.owner = drv->owner;

Hint, put the owner in the function, which will force the caller to pass
it in.  It's forgotten to be set in the structure a lot.  Look at USB
and PCI register functions now for an example of this.

> +	drv->driver.probe = xenbus_dev_probe;
> +	drv->driver.remove = xenbus_dev_remove;
> +
> +	mutex_lock(&xenwatch_mutex);
> +	ret = driver_register(&drv->driver);
> +	mutex_unlock(&xenwatch_mutex);

What's with the lock?  What is wrong with the driver core lock that is
taken?  What are you trying to protect?

> +void xenbus_suspend(void)
> +{
> +	DPRINTK("");
> +
> +	bus_for_each_dev(&xenbus_frontend.bus, NULL, NULL, suspend_dev);
> +	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL, suspend_dev);
> +	xs_suspend();
> +}
> +EXPORT_SYMBOL_GPL(xenbus_suspend);

I think the driver core will handle walking your devices and suspending
them.  You don't have to do it by hand like this.

> +void xenbus_resume(void)
> +{
> +	xb_init_comms();
> +	xs_resume();
> +	bus_for_each_dev(&xenbus_frontend.bus, NULL, NULL, resume_dev);
> +	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL, resume_dev);
> +}
> +EXPORT_SYMBOL_GPL(xenbus_resume);

Same thing for resume.

> +#ifdef XEN_XENBUS_PROC_INTERFACE
> +static struct file_operations xsd_kva_fops;
> +static struct proc_dir_entry *xsd_kva_intf;
> +static struct proc_dir_entry *xsd_port_intf;

#ifdef not needed if your .h file is written correctly.

> +static int __init xenbus_probe_init(void)
> +{
> +	int err = 0, dom0;
> +
> +	DPRINTK("");
> +
> +	if (xen_init() < 0) {
> +		DPRINTK("failed");
> +		return -ENODEV;
> +	}
> +
> +	/* Register ourselves with the kernel bus & device subsystems */
> +	bus_register(&xenbus_frontend.bus);
> +	bus_register(&xenbus_backend.bus);
> +	device_register(&xenbus_frontend.dev);
> +	device_register(&xenbus_backend.dev);

No error handling?

> +
> +	/*
> +	 * Domain0 doesn't have a store_evtchn or store_mfn yet.
> +	 */
> +	dom0 = (xen_start_info->store_evtchn == 0);
> +
> +#ifdef XEN_XENBUS_PROC_INTERFACE

No #ifdef needed if your .h file is written correctly.

> +/* xenbus_probe.c */
> +extern char *kasprintf(const char *fmt, ...);

Should be in a .h file

> +/*
> + * Details of the xenwatch callback kernel thread. The thread waits on the
> + * watch_events_waitq for work to do (queued on watch_events list). When it
> + * wakes up it acquires the xenwatch_mutex before reading the list and
> + * carrying out work.
> + */
> +static pid_t xenwatch_pid;
> +/* static */ DEFINE_MUTEX(xenwatch_mutex);

Drop the static comment?

> +/* Create a new directory. */
> +int xenbus_mkdir(xenbus_transaction_t t,
> +		 const char *dir, const char *node)
> +{
> +	char *path;
> +	int ret;
> +
> +	path = join(dir, node);
> +	if (IS_ERR(path))
> +		return PTR_ERR(path);
> +
> +	ret = xs_error(xs_single(t, XS_MKDIR, path, NULL));
> +	kfree(path);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xenbus_mkdir);

Create a new directory in what?  sysfs?

> +/* Destroy a file or directory (directories must be empty). */
> +int xenbus_rm(xenbus_transaction_t t, const char *dir, const char *node)
> +{
> +	char *path;
> +	int ret;
> +
> +	path = join(dir, node);
> +	if (IS_ERR(path))
> +		return PTR_ERR(path);
> +
> +	ret = xs_error(xs_single(t, XS_RM, path, NULL));
> +	kfree(path);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xenbus_rm);

Remove a file or directory in what?  sysfs?

> +#define XBT_NULL 0

What is this for?  What's wrong with just "NULL"?

> +/* A xenbus device. */
> +struct xenbus_device {
> +	const char *devicetype;
> +	const char *nodename;
> +	const char *otherend;
> +	int otherend_id;
> +	struct xenbus_watch otherend_watch;
> +	struct device dev;
> +	XenbusState state;
> +	void *data;

The data field can be dropped.  Use the space in the struct device for
this.

> +typedef u32 xenbus_transaction_t;

Why the typedef?  Please don't.

thanks,

greg k-h

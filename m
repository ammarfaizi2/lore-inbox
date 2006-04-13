Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWDMF2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWDMF2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 01:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWDMF2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 01:28:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964797AbWDMF2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 01:28:12 -0400
Date: Wed, 12 Apr 2006 22:27:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mochel@linux.intel.com, arjan@linux.intel.com,
       muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru,
       kristen.c.accardi@intel.com
Subject: Re: [patch 1/3] acpi: dock driver
Message-Id: <20060412222735.38aa0f58.akpm@osdl.org>
In-Reply-To: <1144880322.11215.44.camel@whizzy>
References: <20060412221027.472109000@intel.com>
	<1144880322.11215.44.camel@whizzy>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Accardi <kristen.c.accardi@intel.com> wrote:
>
> Create a driver which lives in the acpi subsystem to handle dock events.  This 
> driver is not an acpi driver, because acpi drivers require that the object
> be present when the driver is loaded.
> 
> ...
>
> +/**
> + * add_dock_dependent_device - associate a device with the dock station
> + * @ds: The dock station
> + * @dd: The dependent device
> + *
> + * Add the dependent device to the dock's dependent device list.
> + */
> +static void
> +add_dock_dependent_device(struct dock_station *ds,
> +			  struct dock_dependent_device *dd)
> +{
> +	list_add_tail(&dd->list, &ds->dependent_devices);
> +}
> +

Does this not need any locking?

> +/**
> + * find_dock_dependent_device - get a device dependent on this dock
> + * @ds: the dock station
> + * @handle: the acpi_handle of the device we want
> + *
> + * iterate over the dependent device list for this dock.  If the
> + * dependent device matches the handle, return.
> + */
> +static struct dock_dependent_device *
> +find_dock_dependent_device(struct dock_station *ds, acpi_handle handle)
> +{
> +	struct dock_dependent_device *dd;
> +
> +	list_for_each_entry(dd, &ds->dependent_devices, list) {
> +		if (handle == dd->handle)
> +			return dd;
> +	}
> +	return NULL;
> +}

Nor this?

> +
> +
> +
> +

The driver has a lot of blank lines between functions.  I don't think this
adds any benefit - it just makes less of the code visible.

> +EXPORT_SYMBOL_GPL(is_dock_device);

I assume all these exports are used?

> +
> +
> +
> +
> +/**
> + * hotplug_devices - insert or remove devices on the dock station
> + * @ds: the dock station
> + * @event: either bus check or eject request
> + *
> + * Some devices on the dock station need to have drivers called
> + * to perform hotplug operations after a dock event has occurred.
> + * Traverse the list of dock devices that have registered a
> + * hotplug handler, and call the handler.
> + */
> +static void hotplug_devices(struct dock_station *ds, u32 event)
> +{
> +	struct dock_dependent_device *dd;
> +
> +	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list) {
> +		if (dd->handler)
> +			dd->handler(dd->handle, event, dd->context);
> +	}
> +}
> +
> +
> +
> +

There's a reasonable chance that someone else will choose identifiers such
as `hotplug_devices' and `hotplug_list'.  Let's hope they're not put in a
header file which gets included here...


> +/**
> + * dock_in_progress - see if we are in the middle of handling a dock event
> + * @ds: the dock station
> + *
> + * Sometimes while docking, false dock events can be sent to the driver
> + * because good connections aren't made or some other reason.  Ignore these
> + * if we are in the middle of doing something.
> + */
> +static int dock_in_progress(struct dock_station *ds)
> +{
> +	if (ds->flags & DOCK_DOCKING ||
> +		(jiffies < (ds->last_dock_time + 10))) {

Peculiar mixture of paranoid and trusting parenthesisation there..

It'll malfunction if jiffies happens to wrap - use time_before() or
time_after() to fix.

> +static void acpi_dock_notify(acpi_handle handle, u32 event, void *data)
> +{
> +	struct dock_station *ds = (struct dock_station *)data;
> +	struct acpi_device *device;
> +
> +	ACPI_FUNCTION_TRACE("acpi_dock_notify");
> +
> +	switch (event) {
> +		case ACPI_NOTIFY_BUS_CHECK:

We normally indent thusly:

	switch (event) {
	case ACPI_NOTIFY_BUS_CHECK:

> +			if (!dock_in_progress(ds) && dock_present(ds)) {
> +				begin_dock(ds);
> +				dock(ds);
> +				if (!dock_present(ds)) {
> +					printk(KERN_ERR PREFIX "Unable to dock!\n");
> +					break;
> +				}
> +				atomic_notifier_call_chain(&dock_notifier_list,
> +					 event, NULL);
> +				hotplug_devices(ds, event);
> +				complete_dock(ds);
> +				if (acpi_bus_get_device(ds->handle, &device))
> +					acpi_bus_generate_event(device,
> +						event, 0);
> +			}

and if you do that here, this code will look nicer.

> +
> +/**
> + * acpi_dock_add - add a new dock station
> + * @handle: the dock station handle
> + *
> + * allocated and initialize a new dock station device.  Find all devices
> + * that are on the dock station, and register for dock event notifications.
> + */
> +static int acpi_dock_add(acpi_handle handle)
> +{
> +	int ret;
> +	acpi_status status;
> +
> +	ACPI_FUNCTION_TRACE("acpi_dock_add");
> +
> +	/* allocate & initialize the dock_station private data */
> +	ds = kzalloc(sizeof(*ds), GFP_KERNEL);

<wonders what ds is>

Oh, it's a file-wide `struct dock_station *'.

Suggest that it be given a more file-widey name.

Would it be better if `ds' be defined at compile time?  Perhaps not..

> +	if (!ds)
> +		return_VALUE(-ENOMEM);
> +	ds->handle = handle;
> +	INIT_LIST_HEAD(&ds->dependent_devices);
> +	INIT_LIST_HEAD(&ds->hotplug_devices);
> +
> +	/* Find dependent devices */
> +	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +			ACPI_UINT32_MAX, find_dock_devices, ds, NULL);
> +
> +	/* register for dock events */
> +	status = acpi_install_notify_handler(ds->handle, ACPI_SYSTEM_NOTIFY,
> +				acpi_dock_notify, ds);
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +			"Error installing notify handler\n"));
> +		ret = -ENODEV;
> +		goto dock_add_err;
> +	}
> +
> +	printk(KERN_INFO PREFIX "%s \n", ACPI_DOCK_DRIVER_NAME);
> +
> +	return_VALUE(0);
> +dock_add_err:
> +	kfree(ds);
> +	return_VALUE(ret);
> +}
> +
>
> ...
>
> --- 2.6-git-kca2.orig/drivers/acpi/Kconfig
> +++ 2.6-git-kca2/drivers/acpi/Kconfig
> @@ -134,6 +134,12 @@ config ACPI_FAN
>  	  This driver adds support for ACPI fan devices, allowing user-mode 
>  	  applications to perform basic fan control (on, off, status).
>  
> +config ACPI_DOCK
> +	tristate "Dock"
> +	default y
> +	help
> +	  This driver adds support for ACPI controlled docking stations

It doesn't depend upon anything else?



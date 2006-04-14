Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWDNVxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWDNVxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWDNVxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:53:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:30893 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965120AbWDNVxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:53:34 -0400
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23400319:sNHT28991347"
Subject: Re: [patch 1/3] acpi: dock driver
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mochel@linux.intel.com, arjan@linux.intel.com,
       muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru
In-Reply-To: <20060412222735.38aa0f58.akpm@osdl.org>
References: <20060412221027.472109000@intel.com>
	 <1144880322.11215.44.camel@whizzy>  <20060412222735.38aa0f58.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Apr 2006 15:02:13 -0700
Message-Id: <1145052133.29319.44.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 14 Apr 2006 21:53:33.0788 (UTC) FILETIME=[E02329C0:01C6600D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 22:27 -0700, Andrew Morton wrote:
> Kristen Accardi <kristen.c.accardi@intel.com> wrote:
> >
> > Create a driver which lives in the acpi subsystem to handle dock events.  This 
> > driver is not an acpi driver, because acpi drivers require that the object
> > be present when the driver is loaded.
> > 
> > ...
> >
> > +/**
> > + * add_dock_dependent_device - associate a device with the dock station
> > + * @ds: The dock station
> > + * @dd: The dependent device
> > + *
> > + * Add the dependent device to the dock's dependent device list.
> > + */
> > +static void
> > +add_dock_dependent_device(struct dock_station *ds,
> > +			  struct dock_dependent_device *dd)
> > +{
> > +	list_add_tail(&dd->list, &ds->dependent_devices);
> > +}
> > +
> 
> Does this not need any locking?

yes, I'll fix this.

> 
> > +/**
> > + * find_dock_dependent_device - get a device dependent on this dock
> > + * @ds: the dock station
> > + * @handle: the acpi_handle of the device we want
> > + *
> > + * iterate over the dependent device list for this dock.  If the
> > + * dependent device matches the handle, return.
> > + */
> > +static struct dock_dependent_device *
> > +find_dock_dependent_device(struct dock_station *ds, acpi_handle handle)
> > +{
> > +	struct dock_dependent_device *dd;
> > +
> > +	list_for_each_entry(dd, &ds->dependent_devices, list) {
> > +		if (handle == dd->handle)
> > +			return dd;
> > +	}
> > +	return NULL;
> > +}
> 
> Nor this?

yes, I'll fix this too.

> 
> > +
> > +
> > +
> > +
> 
> The driver has a lot of blank lines between functions.  I don't think this
> adds any benefit - it just makes less of the code visible.
> 
> > +EXPORT_SYMBOL_GPL(is_dock_device);
> 
> I assume all these exports are used?
> 

Yes, they are.

> > +
> > +
> > +
> > +
> > +/**
> > + * hotplug_devices - insert or remove devices on the dock station
> > + * @ds: the dock station
> > + * @event: either bus check or eject request
> > + *
> > + * Some devices on the dock station need to have drivers called
> > + * to perform hotplug operations after a dock event has occurred.
> > + * Traverse the list of dock devices that have registered a
> > + * hotplug handler, and call the handler.
> > + */
> > +static void hotplug_devices(struct dock_station *ds, u32 event)
> > +{
> > +	struct dock_dependent_device *dd;
> > +
> > +	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list) {
> > +		if (dd->handler)
> > +			dd->handler(dd->handle, event, dd->context);
> > +	}
> > +}
> > +
> > +
> > +
> > +
> 
> There's a reasonable chance that someone else will choose identifiers such
> as `hotplug_devices' and `hotplug_list'.  Let's hope they're not put in a
> header file which gets included here...
> 

No, they aren't included, however, I'll change the function name just in
case the function is ever exported.

> 
> > +/**
> > + * dock_in_progress - see if we are in the middle of handling a dock event
> > + * @ds: the dock station
> > + *
> > + * Sometimes while docking, false dock events can be sent to the driver
> > + * because good connections aren't made or some other reason.  Ignore these
> > + * if we are in the middle of doing something.
> > + */
> > +static int dock_in_progress(struct dock_station *ds)
> > +{
> > +	if (ds->flags & DOCK_DOCKING ||
> > +		(jiffies < (ds->last_dock_time + 10))) {
> 
> Peculiar mixture of paranoid and trusting parenthesisation there..
> 
> It'll malfunction if jiffies happens to wrap - use time_before() or
> time_after() to fix.
> 

Thanks, I'll fix this.

> > +static void acpi_dock_notify(acpi_handle handle, u32 event, void *data)
> > +{
> > +	struct dock_station *ds = (struct dock_station *)data;
> > +	struct acpi_device *device;
> > +
> > +	ACPI_FUNCTION_TRACE("acpi_dock_notify");
> > +
> > +	switch (event) {
> > +		case ACPI_NOTIFY_BUS_CHECK:
> 
> We normally indent thusly:
> 
> 	switch (event) {
> 	case ACPI_NOTIFY_BUS_CHECK:
> 
> > +			if (!dock_in_progress(ds) && dock_present(ds)) {
> > +				begin_dock(ds);
> > +				dock(ds);
> > +				if (!dock_present(ds)) {
> > +					printk(KERN_ERR PREFIX "Unable to dock!\n");
> > +					break;
> > +				}
> > +				atomic_notifier_call_chain(&dock_notifier_list,
> > +					 event, NULL);
> > +				hotplug_devices(ds, event);
> > +				complete_dock(ds);
> > +				if (acpi_bus_get_device(ds->handle, &device))
> > +					acpi_bus_generate_event(device,
> > +						event, 0);
> > +			}
> 
> and if you do that here, this code will look nicer.
> 
> > +
> > +/**
> > + * acpi_dock_add - add a new dock station
> > + * @handle: the dock station handle
> > + *
> > + * allocated and initialize a new dock station device.  Find all devices
> > + * that are on the dock station, and register for dock event notifications.
> > + */
> > +static int acpi_dock_add(acpi_handle handle)
> > +{
> > +	int ret;
> > +	acpi_status status;
> > +
> > +	ACPI_FUNCTION_TRACE("acpi_dock_add");
> > +
> > +	/* allocate & initialize the dock_station private data */
> > +	ds = kzalloc(sizeof(*ds), GFP_KERNEL);
> 
> <wonders what ds is>
> 
> Oh, it's a file-wide `struct dock_station *'.
> 
> Suggest that it be given a more file-widey name.
> 
> Would it be better if `ds' be defined at compile time?  Perhaps not..
> 

Probably not.

> > +	if (!ds)
> > +		return_VALUE(-ENOMEM);
> > +	ds->handle = handle;
> > +	INIT_LIST_HEAD(&ds->dependent_devices);
> > +	INIT_LIST_HEAD(&ds->hotplug_devices);
> > +
> > +	/* Find dependent devices */
> > +	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> > +			ACPI_UINT32_MAX, find_dock_devices, ds, NULL);
> > +
> > +	/* register for dock events */
> > +	status = acpi_install_notify_handler(ds->handle, ACPI_SYSTEM_NOTIFY,
> > +				acpi_dock_notify, ds);
> > +	if (ACPI_FAILURE(status)) {
> > +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> > +			"Error installing notify handler\n"));
> > +		ret = -ENODEV;
> > +		goto dock_add_err;
> > +	}
> > +
> > +	printk(KERN_INFO PREFIX "%s \n", ACPI_DOCK_DRIVER_NAME);
> > +
> > +	return_VALUE(0);
> > +dock_add_err:
> > +	kfree(ds);
> > +	return_VALUE(ret);
> > +}
> > +
> >
> > ...
> >
> > --- 2.6-git-kca2.orig/drivers/acpi/Kconfig
> > +++ 2.6-git-kca2/drivers/acpi/Kconfig
> > @@ -134,6 +134,12 @@ config ACPI_FAN
> >  	  This driver adds support for ACPI fan devices, allowing user-mode 
> >  	  applications to perform basic fan control (on, off, status).
> >  
> > +config ACPI_DOCK
> > +	tristate "Dock"
> > +	default y
> > +	help
> > +	  This driver adds support for ACPI controlled docking stations
> 
> It doesn't depend upon anything else?

It doesn't have to.  If you want to be able to hotplug any PCI devices
on the dock station, then it does depend on HOTPLUG_PCI, however, there
are dock stations which have no PCI devices on them which would not need
to do this.

I'll send a new version which incorporates your feedback soon.  Thanks
for reviewing, I really appreciate it.

Kristen

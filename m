Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWDRW6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWDRW6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWDRW6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:58:32 -0400
Received: from fmr18.intel.com ([134.134.136.17]:29833 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750778AbWDRW6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:58:31 -0400
Date: Tue, 18 Apr 2006 15:54:27 -0700
From: Patrick Mochel <mochel@linux.intel.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Prarit Bhargava <prarit@sgi.com>, Andrew Morton <akpm@osdl.org>,
       len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz,
       temnota@kmv.ru
Subject: Re: [patch 1/3] acpi: dock driver
Message-ID: <20060418225427.GE4556@linux.intel.com>
References: <20060412221027.472109000@intel.com> <1144880322.11215.44.camel@whizzy> <20060412222735.38aa0f58.akpm@osdl.org> <1145054985.29319.51.camel@whizzy> <44410360.6090003@sgi.com> <1145383396.10783.32.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145383396.10783.32.camel@whizzy>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 11:03:16AM -0700, Kristen Accardi wrote:
> Create a driver which lives in the acpi subsystem to handle dock events.  This 
> driver is not an acpi driver, because acpi drivers require that the object
> be present when the driver is loaded.

A few comments.. 


> --- /dev/null
> +++ 2.6-git-kca2/drivers/acpi/dock.c
> @@ -0,0 +1,652 @@

> +#define ACPI_DOCK_COMPONENT 0x10000000
> +#define ACPI_DOCK_DRIVER_NAME "ACPI Dock Station Driver"
> +#define _COMPONENT		ACPI_DOCK_COMPONENT

These aren't necessary for code that is outside of the ACPI-CA. 

> +struct dock_station {
> +	acpi_handle handle;
> +	unsigned long last_dock_time;
> +	u32 flags;
> +	spinlock_t dd_lock;
> +	spinlock_t hp_lock;
> +	struct list_head dependent_devices;
> +	struct list_head hotplug_devices;
> +};
> +
> +struct dock_dependent_device {
> +	struct list_head list;
> +	struct list_head hotplug_list;
> +	acpi_handle handle;
> +	acpi_notify_handler handler;
> +	void *context;
> +};
> +
> +#define DOCK_DOCKING	0x00000001
> +
> +static struct dock_station *dock_station;

Does this need to be dynamically allocated? Static initialization
would be a bit cleaner and obviate the need for the NULL checks in
several of the functions below. 

> +/**
> + * eject_dock - respond to a dock eject request
> + * @ds: the dock station
> + *
> + * This is called after _DCK is called, to execute the dock station's
> + * _EJ0 method.
> + */
> +static void eject_dock(struct dock_station *ds)
> +{
> +	struct acpi_object_list arg_list;
> +	union acpi_object arg;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +
> +	acpi_get_name(ds->handle, ACPI_FULL_PATHNAME, &buffer);
> +	obj = buffer.pointer;
> +
> +	arg_list.count = 1;
> +	arg_list.pointer = &arg;
> +	arg.type = ACPI_TYPE_INTEGER;
> +	arg.integer.value = 1;

Minor nit (that is replicated in many of the ACPI drivers). This can be
done by just describing the data better: 

	struct acpi_object arg = {
		.type		= ACPI_TYPE_INTEGER,
		.integer	= {
			.value	= 1,
		},
	};
	struct acpi_object_list arg_list = {
		.count		= 1,
		.pointer	= &arg,
	};

	... 

In the long run, since the same exact code exists in dozens of places
in the ACPI drivers, there should just be a helper for it. E.g.: 


	int ret;
	unsigned long value;

	ret = acpi_get_int(ds->handle, "_EJO", &value);
	if (!ret)
		/* Use Value */
	else
		/* Error */

...and get rid of the awkward object/object list handling. 

> +static inline void begin_dock(struct dock_station *ds)
> +{
> +	ds->flags |= DOCK_DOCKING;
> +}
> +
> +static inline void complete_dock(struct dock_station *ds)
> +{
> +	ds->flags &= ~(DOCK_DOCKING);
> +	ds->last_dock_time = jiffies;
> +}
> +
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
> +	if ((ds->flags & DOCK_DOCKING) ||
> +	    time_before(jiffies, (ds->last_dock_time + HZ)))
> +		return 1;
> +	return 0;
> +}

These seem racy. It seems the flag should should at least be an atomic_t. But,
if it's that, then it might as well be a mutex, eh? And, if it's a mutex, then
do we need the other spinlocks? 

> +acpi_status
> +register_hotplug_dock_device(acpi_handle handle, acpi_notify_handler handler,
> +			     void *context)

If this is called from outside drivers/acpi/, you should return an int with a 
real errno value. The AE_* values shouldn't be used outside of the ACPI CA. 


> +acpi_status unregister_hotplug_dock_device(acpi_handle handle)

Does unregister need to return an error? 


Thanks,


	Pat

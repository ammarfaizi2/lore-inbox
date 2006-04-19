Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWDSRO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWDSRO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWDSRO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:14:57 -0400
Received: from mga03.intel.com ([143.182.124.21]:46223 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751122AbWDSRO4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:14:56 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25086516:sNHT1505551565"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/3] acpi: dock driver
Date: Wed, 19 Apr 2006 10:14:46 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4200AD4@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/3] acpi: dock driver
Thread-Index: AcZj0usgpYMxySC2QeKhP642GIFd3wAAcBVw
From: "Moore, Robert" <robert.moore@intel.com>
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       "Patrick Mochel" <mochel@linux.intel.com>
Cc: "Prarit Bhargava" <prarit@sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, <greg@kroah.com>,
       <linux-acpi@vger.kernel.org>, <pcihpd-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <arjan@linux.intel.com>,
       <muneda.takahiro@jp.fujitsu.com>, <pavel@ucw.cz>, <temnota@kmv.ru>
X-OriginalArrivalTime: 19 Apr 2006 17:14:47.0513 (UTC) FILETIME=[C290E490:01C663D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is something to think about before we rip out all the ACPI
core-style debug stuff.


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Kristen Accardi
> Sent: Wednesday, April 19, 2006 10:09 AM
> To: Patrick Mochel
> Cc: Prarit Bhargava; Andrew Morton; Brown, Len; greg@kroah.com; linux-
> acpi@vger.kernel.org; pcihpd-discuss@lists.sourceforge.net; linux-
> kernel@vger.kernel.org; arjan@linux.intel.com;
> muneda.takahiro@jp.fujitsu.com; pavel@ucw.cz; temnota@kmv.ru
> Subject: Re: [patch 1/3] acpi: dock driver
> 
> On Tue, 2006-04-18 at 15:54 -0700, Patrick Mochel wrote:
> > On Tue, Apr 18, 2006 at 11:03:16AM -0700, Kristen Accardi wrote:
> > > Create a driver which lives in the acpi subsystem to handle dock
> events.  This
> > > driver is not an acpi driver, because acpi drivers require that
the
> object
> > > be present when the driver is loaded.
> >
> > A few comments..
> >
> >
> > > --- /dev/null
> > > +++ 2.6-git-kca2/drivers/acpi/dock.c
> > > @@ -0,0 +1,652 @@
> >
> > > +#define ACPI_DOCK_COMPONENT 0x10000000
> > > +#define ACPI_DOCK_DRIVER_NAME "ACPI Dock Station Driver"
> > > +#define _COMPONENT		ACPI_DOCK_COMPONENT
> >
> > These aren't necessary for code that is outside of the ACPI-CA.
> 
> Originally I did not include these, but it turns out if you wish to
use
> the ACPI_DEBUG macro, you need to have these things defined.  I did go
> ahead and use this macro in a couple places, mainly because I felt
that
> even though this isn't strictly an acpi driver (using the acpi driver
> model), it does live in drivers/acpi and perhaps people might expect
to
> be able to debug it the same way.
> 
> >
> > > +struct dock_station {
> > > +	acpi_handle handle;
> > > +	unsigned long last_dock_time;
> > > +	u32 flags;
> > > +	spinlock_t dd_lock;
> > > +	spinlock_t hp_lock;
> > > +	struct list_head dependent_devices;
> > > +	struct list_head hotplug_devices;
> > > +};
> > > +
> > > +struct dock_dependent_device {
> > > +	struct list_head list;
> > > +	struct list_head hotplug_list;
> > > +	acpi_handle handle;
> > > +	acpi_notify_handler handler;
> > > +	void *context;
> > > +};
> > > +
> > > +#define DOCK_DOCKING	0x00000001
> > > +
> > > +static struct dock_station *dock_station;
> >
> > Does this need to be dynamically allocated? Static initialization
> > would be a bit cleaner and obviate the need for the NULL checks in
> > several of the functions below.
> >
> 
> It could be statically allocated, but I have a preference towards not
> allocating statically in this case.  I will consider the option of
> making it static.
> 
> > > +/**
> > > + * eject_dock - respond to a dock eject request
> > > + * @ds: the dock station
> > > + *
> > > + * This is called after _DCK is called, to execute the dock
station's
> > > + * _EJ0 method.
> > > + */
> > > +static void eject_dock(struct dock_station *ds)
> > > +{
> > > +	struct acpi_object_list arg_list;
> > > +	union acpi_object arg;
> > > +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > > +	union acpi_object *obj;
> > > +
> > > +	acpi_get_name(ds->handle, ACPI_FULL_PATHNAME, &buffer);
> > > +	obj = buffer.pointer;
> > > +
> > > +	arg_list.count = 1;
> > > +	arg_list.pointer = &arg;
> > > +	arg.type = ACPI_TYPE_INTEGER;
> > > +	arg.integer.value = 1;
> >
> > Minor nit (that is replicated in many of the ACPI drivers). This can
be
> > done by just describing the data better:
> >
> > 	struct acpi_object arg = {
> > 		.type		= ACPI_TYPE_INTEGER,
> > 		.integer	= {
> > 			.value	= 1,
> > 		},
> > 	};
> > 	struct acpi_object_list arg_list = {
> > 		.count		= 1,
> > 		.pointer	= &arg,
> > 	};
> >
> > 	...
> >
> > In the long run, since the same exact code exists in dozens of
places
> > in the ACPI drivers, there should just be a helper for it. E.g.:
> >
> >
> > 	int ret;
> > 	unsigned long value;
> >
> > 	ret = acpi_get_int(ds->handle, "_EJO", &value);
> > 	if (!ret)
> > 		/* Use Value */
> > 	else
> > 		/* Error */
> >
> > ...and get rid of the awkward object/object list handling.
> >
> > > +static inline void begin_dock(struct dock_station *ds)
> > > +{
> > > +	ds->flags |= DOCK_DOCKING;
> > > +}
> > > +
> > > +static inline void complete_dock(struct dock_station *ds)
> > > +{
> > > +	ds->flags &= ~(DOCK_DOCKING);
> > > +	ds->last_dock_time = jiffies;
> > > +}
> > > +
> > > +/**
> > > + * dock_in_progress - see if we are in the middle of handling a
dock
> event
> > > + * @ds: the dock station
> > > + *
> > > + * Sometimes while docking, false dock events can be sent to the
> driver
> > > + * because good connections aren't made or some other reason.
Ignore
> these
> > > + * if we are in the middle of doing something.
> > > + */
> > > +static int dock_in_progress(struct dock_station *ds)
> > > +{
> > > +	if ((ds->flags & DOCK_DOCKING) ||
> > > +	    time_before(jiffies, (ds->last_dock_time + HZ)))
> > > +		return 1;
> > > +	return 0;
> > > +}
> >
> > These seem racy. It seems the flag should should at least be an
> atomic_t. But,
> > if it's that, then it might as well be a mutex, eh? And, if it's a
> mutex, then
> > do we need the other spinlocks?
> >
> 
> yes, the flag might be racy.  we do need the other spinlocks however,
> because they are locking lists within the dock_station struct, but not
> the entire struct (unless I just change to something that locks the
> entire struct).
> 
> > > +acpi_status
> > > +register_hotplug_dock_device(acpi_handle handle,
acpi_notify_handler
> handler,
> > > +			     void *context)
> >
> > If this is called from outside drivers/acpi/, you should return an
int
> with a
> > real errno value. The AE_* values shouldn't be used outside of the
ACPI
> CA.
> >
> 
> Really?  We use these all over the place in drivers/pci/hotplug.  In
> fact, you kinda have to use them if you are calling certain acpi
> symbols, since they return these types.
> 
> For example, here are some functions will return acpi_status that we
use
> in hotplug land.
> 
> pci_osc_control_set()
> acpi_run_oshp()
> acpi_walk_namespace requires its use.
> 
> I felt that by returning acpi_status I was being consistent with how
> other acpi calls acted.  Is this another example of the iceberg that
Len
> was talking about in a previous email?? (ugh.)
> 
> 
> >
> > > +acpi_status unregister_hotplug_dock_device(acpi_handle handle)
> >
> > Does unregister need to return an error?
> >
> 
> No probably not.
> 
> >
> > Thanks,
> >
> >
> > 	Pat
> 
> thanks for reviewing again :).
> 
> Kristen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

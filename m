Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWKGTJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWKGTJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWKGTJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:09:39 -0500
Received: from bay0-omc3-s38.bay0.hotmail.com ([65.54.246.238]:39613 "EHLO
	bay0-omc3-s38.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751471AbWKGTJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:09:38 -0500
Message-ID: <BAY20-F108DBB83BFAD45696B1CD7D8F20@phx.gbl>
X-Originating-IP: [80.178.105.247]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <20061106131535.04ffa895.akpm@osdl.org>
From: "Burman Yan" <yan_952@hotmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org, dtor@mail.ru
Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt handling
Date: Tue, 07 Nov 2006 21:09:32 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Nov 2006 19:09:37.0653 (UTC) FILETIME=[44DA5250:01C702A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Andrew Morton <akpm@osdl.org>
>To: "Burman Yan" <yan_952@hotmail.com>
>CC: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,   
>Dmitry Torokhov <dtor@mail.ru>
>Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt 
>handling
>Date: Mon, 6 Nov 2006 13:15:35 -0800
>
>On Fri, 03 Nov 2006 18:33:31 +0200
>"Burman Yan" <yan_952@hotmail.com> wrote:
>
> > Hi.
> >
> > I posted a previous version of my driver a few weeks ago, so here is a 
>new
> > version that
> > handles interrupts from the device when the accelerometer detects that 
>the
> > laptop is falling.
> > The interrupt part only works with 2.6.19-rc* since previous kernels (at
> > least 2.6.17 and 2.6.18 could not allocate the device's IRQ - perhaps 
>due to
> > some ACPI bios bug that now is handled better)
> > The driver supports:
> > 1) interface similar to hdaps that allows running hdapsd with trivial
> > modifiations
>
>It would (I assume) be nice to make the interface 100% compatible with
>existing hdaps drivers.
>
>What are the interface differences and why are they necessary?


The diference is that hdaps is something specific to IBM/Lenovo laptops.
hdaps provides /sys/devices/platform/hdaps/*
I provide /sys/devices/platform/mdps/*, but the interface is kept similar
to hdaps just to make it possible to use hdapsd. This interface is far from
the best way to use mdps, since it does polling on accelerometer values.
HP's accelerometer can provide an interrupt when it detects that the laptop
is falling. I implemented that by the means of /dev/accel. This makes the 
user space
daemon extremely dumb, since it has no need to do heuristics in order to 
detect
if the laptop is falling or just somebody wanted to scratch his knee and the 
laptop shifted.


>
> > 2) input class device that allows playing games such as neverball by 
>using
> > the laptop as a joystick
>
>heh.
>
> > 3) Ability to power off the acceleromter (it may prolong just a litlte
> > battery life)
>
>OK.
>
> > 4) A misc device /dev/acel similar in interface to /dev/rtc that reacts 
>on
> > interrupts from the accelerometer allowing userspace to catch such 
>events
> > and react accordingly - park the HD heads, or perhaps print "Your laptop 
>is
> > falling. Are you sure you want to catch it?" The daemon for that
> > i trivial.
>
>Should be spelled "accel".

Point taken and fixed.

>
>Is this capability something which other hdaps drivers could provide?  If
>so, all drivers should provide the same interface as much as poss, so we'd
>need to look at this one from that point of view.

>From my googling, I found that there are 3 drivers that provide similar 
functionality
right now:
1) hdaps. I don't know if the device is capable of generating interrupts on 
free falls.
The driver does not do that right now from what I saw. It is also the only 
2D acceleromter of the 3.
2) ams - something that is present on apple laptops - these can generate 
interrupts.
3) mdps - this can generate interrupts on free fall - that's what I created 
/dev/acel for.

>From what I saw these are the only 3 laptop classes that have accelerometers 
in them right now.

>
> > Should I also add a documentation file to document all the interfaces - 
>it
> > should be quite short though.
>
>That would help a lot.  In fact it'll be hard to address the above
>questions without that document, because they're all about the interface.

No problem - working on it.

>
>
>Some minor points:
>
>
> > diff -puN 
>drivers/hwmon/Kconfig~hp-mobile-data-protection-system-driver-with-interrupt-handling 
>drivers/hwmon/Kconfig
> > --- 
>a/drivers/hwmon/Kconfig~hp-mobile-data-protection-system-driver-with-interrupt-handling
> > +++ a/drivers/hwmon/Kconfig
> > @@ -547,6 +547,26 @@ config SENSORS_HDAPS
> >  	  Say Y here if you have an applicable laptop and want to experience
> >  	  the awesome power of hdaps.
> >
> > +config SENSORS_MDPS
> > +        tristate "HP Mobile Data Protection System 3D (mdps)"
> > +        depends on ACPI && HWMON && INPUT && X86
>
>OK, so it's x86-only.  It needs to be...
>
> > +        default n
> > +        help
> > +          This driver provides support for the HP Mobile Data 
>Protection
> > +          System 3D (mdps), which is an accelerometer. Only HP nc6400 
>and nc6420
> > +          is supported right now, but it may work on other models as 
>well.  The
> > +          accelerometer data is readable via 
>/sys/devices/platform/mdps.
> > +
> > +          This driver also provides an absolute input class device, 
>allowing
> > +          the laptop to act as a pinball machine-esque joystick.
> > +
> > +          Another feature of the driver is misc device called mdps that 
>acts
> > +          similar to /dev/rtc and reacts on free-fall interrupts 
>received from
> > +          the device.
> > +
> > +          This driver can also be built as a module.  If so, the module
> > +          will be called mdps.
> > +
> >
> > ...
> >
> > +
> > +#define MDPS_ID 0x3A
> > +
> > +/* mouse device poll interval in milliseconds */
> > +#define MDPS_POLL_INTERVAL 30
> > +
> > +static unsigned int mouse = 0;
>
>The `= 0' is unneeded.
>
> > +module_param(mouse, bool, S_IRUGO);
> > +MODULE_PARM_DESC(mouse, "Enable the input class device on module 
>load");
> > +
> > +static unsigned int power_off = 0;
>
>Here also.

I though it would be more visual this way, but you're probably right.
Changed that.

>
> > +module_param(power_off, bool, S_IRUGO);
> > +MODULE_PARM_DESC(power_off, "Turn off device on module load");
> > +
> > +struct acpi_mdps
> > +{
>
>Should be formatted as
>
>struct acpi_mdps {
>
> > +	struct acpi_device*     device;    /* The ACPI device */
>
>Should be formatted as
>
>	struct acpi_device     *device;    /* The ACPI device */
>
>(entire patch)

I'm more used to C++ semantics, but changed that for the next iteration 
patch.

>
> > +	u32                     irq;       /* IRQ number */
> > +	struct input_dev*       idev;      /* input device */
> > +	struct task_struct*     kthread;   /* kthread for input */
> > +	int                     xcalib;    /* calibrated null value for x */
> > +	int                     ycalib;    /* calibrated null value for y */
> > +	int                     is_on;     /* whether the device is on or off 
>*/
> > +	struct platform_device* pdev;      /* platform device */
> > +	atomic_t                count;     /* how many times we got interrupts 
>after the last read */
> > +	struct completion       complete;  /* we wait on this in read */
> > +	int                     reader_waiting;
> > +};
> > +
> >
> > ...
> >
> > +
> > +/** Kthread polling function
> > + * @param data unused - here to conform to threadfn prototype
> > + * @return 0 unused - here to conform to threadfn prototype
> > + */
> > +static int mdps_mouse_kthread(void *data)
> > +{
> > +	int x, y;
> > +
> > +	while (!kthread_should_stop()) {
> > +		mdps_get_xy(mdps.device->handle, &x, &y);
> > +
> > +		/* need to invert the X axis for this to look natural */
> > +		input_report_abs(mdps.idev, ABS_X, -(x - mdps.xcalib));
> > +		input_report_abs(mdps.idev, ABS_Y, y - mdps.ycalib);
> > +
> > +		input_sync(mdps.idev);
> > +
> > +		msleep(MDPS_POLL_INTERVAL);
> > +	}
> > +
> > +	return 0;
> > +}
>
>This will probably break software suspend.  You'll need a try_to_freeze()
>in that loop.

Well, I stop the kthread all together upon suspend, but I added this just in 
case, since
to be honest I don't know all the details of software suspend handling.

>
> >
> > ...
> >
> > +
> > +static int mdps_misc_open(struct inode *inode, struct file *file)
> > +{
> > +	if (!atomic_dec_and_test(&mdps_available)) {
> > +		atomic_inc(&mdps_available);
> > +		return -EBUSY; /* already open */
> > +	}
> > +
> > +	atomic_set(&mdps.count, 0);
> > +	return 0;
> > +}
>
>That's a bit awkward-looking.  It would be simpler to use mdps_lock
>to force the single-opener behaviour.

I took this code almost verbatim from LDD3 and I saw it in a few places 
before.
mdps_lock is used for interrupt counter access.

>
> > +static ssize_t mdps_misc_read(struct file *file, char __user *buf,
> > +                                size_t count, loff_t *pos)
> > +{
> > +	u32 tmp;
> > +	int ret;
> > +	unsigned long flags;
> > +	u32* user_buf = (u32*)buf;
> > +
> > +	if (count != sizeof(u32))
> > +		return -EINVAL;
> > +
> > +	init_completion(&mdps.complete);
> > +
> > +	spin_lock_irqsave(&mdps_lock, flags);
> > +	mdps.reader_waiting = 1;
> > +	spin_unlock_irqrestore(&mdps_lock, flags);
> > +
> > +	ret = wait_for_completion_interruptible(&mdps.complete);
> > +	if (ret)
> > +		return ret;
> > +	tmp = atomic_read(&mdps.count);
> > +	atomic_set(&mdps.count, 0);
> > +
> > +	if (put_user(tmp, user_buf))
> > +		return -EFAULT;
> > +
> > +	return count;
> > +}
>
>It'd be nice to have a few more code comments in there..
>
>This function is the one which provides the use-your-laptop-as-a-joystick
>interface, yes?

No - this stuff gives you /dev/rtc like interface (/dev/accel) to whenever 
your laptop is thrown in
the air or dropped from the 5th floor.

>
>It's peculiar that the read() function will lose events if there's no
>process waiting in the read() function.  A more typical implementation
>would queue the events up and the read() implementation would dequeue them.
>I'm sure the input layer provides planty of things to support that.

I added poll and fasync to this interface, so that should be cleaner in my 
next post,
since the completion API had to go anyway and I replaced that with 
wait_queue stuff.

>
>The forcing of a char __user * into a u32* is a bit ugly.  Fortunately x86
>will permit random alignments, but perhaps a copy_to_user() would be
>cleaner.  Or perhaps just return the number as an ascii decimal string.  At
>a minimum the type should be u32 __user * to keep sparse happy.

Point taken - converted to copy_to_user.

>
> >
> > ..
> >
> > +
> > +static void mdps_enum_resources(struct acpi_device * device)
> > +{
> > +	acpi_status status;
> > +
> > +	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> > +	                             mdps_get_resource, &mdps.irq);
> > +	if (ACPI_FAILURE(status))
> > +		printk(KERN_DEBUG "mdps: Error getting resources\n");
> > +}
> > +
> > +int mdps_add(struct acpi_device *device)
>
>mdps_add() was declared as static, but it wasn't defined as static.

Been programming too much C++ lately - this stuff generates an error in C++.
Fixed.


P.S.
Off topic.
Would that be of any value going through kernel and replacing
kmalloc+memset with kzalloc - this should lower memory footprint, no?

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/


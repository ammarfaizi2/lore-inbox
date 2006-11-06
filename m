Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752745AbWKFVQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbWKFVQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbWKFVQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:16:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752745AbWKFVQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:16:29 -0500
Date: Mon, 6 Nov 2006 13:15:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Burman Yan" <yan_952@hotmail.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: [PATCH] HP Mobile data protection system driver with interrupt
 handling
Message-Id: <20061106131535.04ffa895.akpm@osdl.org>
In-Reply-To: <BAY20-F36829F468180F55694798D8FE0@phx.gbl>
References: <BAY20-F36829F468180F55694798D8FE0@phx.gbl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Nov 2006 18:33:31 +0200
"Burman Yan" <yan_952@hotmail.com> wrote:

> Hi.
> 
> I posted a previous version of my driver a few weeks ago, so here is a new 
> version that
> handles interrupts from the device when the accelerometer detects that the 
> laptop is falling.
> The interrupt part only works with 2.6.19-rc* since previous kernels (at 
> least 2.6.17 and 2.6.18 could not allocate the device's IRQ - perhaps due to 
> some ACPI bios bug that now is handled better)
> The driver supports:
> 1) interface similar to hdaps that allows running hdapsd with trivial 
> modifiations

It would (I assume) be nice to make the interface 100% compatible with
existing hdaps drivers.

What are the interface differences and why are they necessary?

> 2) input class device that allows playing games such as neverball by using 
> the laptop as a joystick

heh.

> 3) Ability to power off the acceleromter (it may prolong just a litlte 
> battery life)

OK.

> 4) A misc device /dev/acel similar in interface to /dev/rtc that reacts on 
> interrupts from the accelerometer allowing userspace to catch such events 
> and react accordingly - park the HD heads, or perhaps print "Your laptop is 
> falling. Are you sure you want to catch it?" The daemon for that
> i trivial.

Should be spelled "accel".

Is this capability something which other hdaps drivers could provide?  If
so, all drivers should provide the same interface as much as poss, so we'd
need to look at this one from that point of view.

> Should I also add a documentation file to document all the interfaces - it 
> should be quite short though.

That would help a lot.  In fact it'll be hard to address the above
questions without that document, because they're all about the interface.


Some minor points:


> diff -puN drivers/hwmon/Kconfig~hp-mobile-data-protection-system-driver-with-interrupt-handling drivers/hwmon/Kconfig
> --- a/drivers/hwmon/Kconfig~hp-mobile-data-protection-system-driver-with-interrupt-handling
> +++ a/drivers/hwmon/Kconfig
> @@ -547,6 +547,26 @@ config SENSORS_HDAPS
>  	  Say Y here if you have an applicable laptop and want to experience
>  	  the awesome power of hdaps.
>  
> +config SENSORS_MDPS
> +        tristate "HP Mobile Data Protection System 3D (mdps)"
> +        depends on ACPI && HWMON && INPUT && X86

OK, so it's x86-only.  It needs to be...

> +        default n
> +        help
> +          This driver provides support for the HP Mobile Data Protection
> +          System 3D (mdps), which is an accelerometer. Only HP nc6400 and nc6420
> +          is supported right now, but it may work on other models as well.  The
> +          accelerometer data is readable via /sys/devices/platform/mdps.
> +
> +          This driver also provides an absolute input class device, allowing
> +          the laptop to act as a pinball machine-esque joystick.
> +
> +          Another feature of the driver is misc device called mdps that acts
> +          similar to /dev/rtc and reacts on free-fall interrupts received from
> +          the device.
> +
> +          This driver can also be built as a module.  If so, the module
> +          will be called mdps.
> +
>
> ...
>
> +
> +#define MDPS_ID 0x3A
> +
> +/* mouse device poll interval in milliseconds */
> +#define MDPS_POLL_INTERVAL 30
> +
> +static unsigned int mouse = 0;

The `= 0' is unneeded.

> +module_param(mouse, bool, S_IRUGO);
> +MODULE_PARM_DESC(mouse, "Enable the input class device on module load");
> +
> +static unsigned int power_off = 0;

Here also.

> +module_param(power_off, bool, S_IRUGO);
> +MODULE_PARM_DESC(power_off, "Turn off device on module load");
> +
> +struct acpi_mdps
> +{

Should be formatted as

struct acpi_mdps {

> +	struct acpi_device*     device;    /* The ACPI device */

Should be formatted as

	struct acpi_device     *device;    /* The ACPI device */

(entire patch)

> +	u32                     irq;       /* IRQ number */
> +	struct input_dev*       idev;      /* input device */
> +	struct task_struct*     kthread;   /* kthread for input */
> +	int                     xcalib;    /* calibrated null value for x */
> +	int                     ycalib;    /* calibrated null value for y */
> +	int                     is_on;     /* whether the device is on or off */
> +	struct platform_device* pdev;      /* platform device */
> +	atomic_t                count;     /* how many times we got interrupts after the last read */
> +	struct completion       complete;  /* we wait on this in read */
> +	int                     reader_waiting;
> +};
> +
>
> ...
>
> +
> +/** Kthread polling function
> + * @param data unused - here to conform to threadfn prototype
> + * @return 0 unused - here to conform to threadfn prototype
> + */
> +static int mdps_mouse_kthread(void *data)
> +{
> +	int x, y;
> +
> +	while (!kthread_should_stop()) {
> +		mdps_get_xy(mdps.device->handle, &x, &y);
> +
> +		/* need to invert the X axis for this to look natural */
> +		input_report_abs(mdps.idev, ABS_X, -(x - mdps.xcalib));
> +		input_report_abs(mdps.idev, ABS_Y, y - mdps.ycalib);
> +
> +		input_sync(mdps.idev);
> +
> +		msleep(MDPS_POLL_INTERVAL);
> +	}
> +
> +	return 0;
> +}

This will probably break software suspend.  You'll need a try_to_freeze()
in that loop.

>
> ...
>
> +
> +static int mdps_misc_open(struct inode *inode, struct file *file)
> +{
> +	if (!atomic_dec_and_test(&mdps_available)) {
> +		atomic_inc(&mdps_available);
> +		return -EBUSY; /* already open */
> +	}
> +
> +	atomic_set(&mdps.count, 0);
> +	return 0;
> +}

That's a bit awkward-looking.  It would be simpler to use mdps_lock
to force the single-opener behaviour.

> +static ssize_t mdps_misc_read(struct file *file, char __user *buf,
> +                                size_t count, loff_t *pos)
> +{
> +	u32 tmp;
> +	int ret;
> +	unsigned long flags;
> +	u32* user_buf = (u32*)buf;
> +
> +	if (count != sizeof(u32))
> +		return -EINVAL;
> +
> +	init_completion(&mdps.complete);
> +
> +	spin_lock_irqsave(&mdps_lock, flags);
> +	mdps.reader_waiting = 1;
> +	spin_unlock_irqrestore(&mdps_lock, flags);
> +
> +	ret = wait_for_completion_interruptible(&mdps.complete);
> +	if (ret)
> +		return ret;
> +	tmp = atomic_read(&mdps.count);
> +	atomic_set(&mdps.count, 0);
> +
> +	if (put_user(tmp, user_buf))
> +		return -EFAULT;
> +
> +	return count;
> +}

It'd be nice to have a few more code comments in there..

This function is the one which provides the use-your-laptop-as-a-joystick
interface, yes?

It's peculiar that the read() function will lose events if there's no
process waiting in the read() function.  A more typical implementation
would queue the events up and the read() implementation would dequeue them.
I'm sure the input layer provides planty of things to support that.

The forcing of a char __user * into a u32* is a bit ugly.  Fortunately x86
will permit random alignments, but perhaps a copy_to_user() would be
cleaner.  Or perhaps just return the number as an ascii decimal string.  At
a minimum the type should be u32 __user * to keep sparse happy.

>
> ..
>
> +
> +static void mdps_enum_resources(struct acpi_device * device)
> +{
> +	acpi_status status;
> +
> +	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +	                             mdps_get_resource, &mdps.irq);
> +	if (ACPI_FAILURE(status))
> +		printk(KERN_DEBUG "mdps: Error getting resources\n");
> +}
> +
> +int mdps_add(struct acpi_device *device)

mdps_add() was declared as static, but it wasn't defined as static.

> +{
> +	unsigned long val;
> +	int ret;
> +
> +	if (!device)
> +		return -EINVAL;
> +
> +	mdps.device = device;
> +	strcpy(acpi_device_name(device), DRIVER_NAME);
> +	strcpy(acpi_device_class(device), ACPI_MDPS_CLASS);
> +	acpi_driver_data(device) = &mdps;
> +
> +	mdps_ALRD(device->handle, MDPS_WHO_AM_I, &val);
> +	if (val != MDPS_ID) {
> +		printk(KERN_INFO "mdps: Accelerometer chip not LIS3LV02D{L,Q}\n");
> +		return -ENODEV;
> +	}
> +
> +	mdps_enum_resources(device);
> +	mdps_add_fs(device);
> +	mdps_resume(device, 3);
> +
> +	if (power_off)
> +		mdps_poweroff(mdps.device->handle);
> +
> +	if (mdps.irq) {
> +		ret = request_irq(mdps.irq, mdps_irq, 0, "mdps", mdps_irq);
> +		if (ret) {
> +			printk(KERN_INFO "mdps: (IRQ%d) allocation failed\n", mdps.irq);
> +			mdps.irq = 0;
> +		} else {
> +			ret = misc_register(&mdps_misc_device);
> +			if (ret) {
> +				free_irq(mdps.irq, mdps_irq);
> +				mdps.irq = 0;
> +				printk(KERN_ERR "mdps: misc_register failed\n");
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int mdps_remove(struct acpi_device *device, int type)

static scope.

> +{
> +	if (!device)
> +		return -EINVAL;
> +
> +	if (mdps.irq) {
> +		misc_deregister(&mdps_misc_device);
> +		free_irq(mdps.irq, mdps_irq);
> +		mdps.irq = 0;
> +	}
> +
> +	if (mouse)
> +		mdps_mouse_disable();
> +
> +	return mdps_remove_fs();
> +}
> +
> +static void mdps_calibrate_mouse(void)
> +{
> +	int x, y;
> +	mdps_get_xy(mdps.device->handle, &x, &y);
> +
> +	mdps.xcalib = x;
> +	mdps.ycalib = y;
> +}
> +
> +void mdps_mouse_enable(void)

static scope.

> +{
> +	if (mdps.idev)
> +		return;
> +
> +	mdps.idev = input_allocate_device();
> +	if (!mdps.idev)
> +		return;
> +
> +	mdps_calibrate_mouse();
> +
> +	mdps.idev->name       = "HP Mobile Data Protection System";
> +	mdps.idev->id.bustype = BUS_HOST;
> +	mdps.idev->id.vendor  = 0;
> +
> +	set_bit(EV_ABS, mdps.idev->evbit);
> +	set_bit(EV_KEY, mdps.idev->evbit);
> +
> +	input_set_abs_params(mdps.idev, ABS_X, -2048, 2048, 3, 0);
> +	input_set_abs_params(mdps.idev, ABS_Y, -2048, 2048, 3, 0);
> +
> +	if (input_register_device(mdps.idev)) {
> +		input_free_device(mdps.idev);
> +		mdps.idev = NULL;
> +		return;
> +	}
> +
> +	mdps.kthread = kthread_run(mdps_mouse_kthread, NULL, "kmdps");
> +	if (IS_ERR(mdps.kthread)) {
> +		input_unregister_device(mdps.idev);
> +		mdps.idev = NULL;
> +		return;
> +	}
> +
> +	mouse = 1;
> +}
> +
> +void mdps_mouse_disable(void)

static scope.

> +{
> +	if (!mdps.idev)
> +		return;
> +
> +	kthread_stop(mdps.kthread);
> +
> +	input_unregister_device(mdps.idev);
> +	mdps.idev = NULL;
> +}
> +
>
> ..
>
> +static struct attribute_group mdps_attribute_group = {
> +	.attrs = mdps_attributes
> +};
> +
> +int mdps_add_fs(struct acpi_device *device)

static

> +{
> +	mdps.pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
> +	if (IS_ERR(mdps.pdev))
> +		return PTR_ERR(mdps.pdev);
> +
> +	return sysfs_create_group(&mdps.pdev->dev.kobj, &mdps_attribute_group);
> +}
> +
> +int mdps_remove_fs(void)

static



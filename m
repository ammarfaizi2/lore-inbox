Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759434AbWLFBNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759434AbWLFBNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 20:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759433AbWLFBNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 20:13:52 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:63126 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759385AbWLFBNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 20:13:51 -0500
Date: Tue, 5 Dec 2006 17:14:01 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Miguel Ojeda <maxextreme@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org
Subject: Re: Display class
Message-Id: <20061205171401.fd11160d.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	<653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	<Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
	<Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 18:03:39 +0000 (GMT) James Simmons wrote:

> This is the pass at a display class to meet the needs of the output class 
> of Mr. Yu for acpi. Also this class could in time replace the lcd class 
> located in the backlight directory since a lcd is a type of display.
> The final hope is that the purpose auxdisplay could fall under this 
> catergory.
> 
> P.S
>    I know the edid parsing would have to be pulled out of the fbdev layer.

Hi,

Where is "struct display_properties" defined?

  CC [M]  drivers/acpi/video.o
drivers/acpi/video.c:183: error: field 'acpi_display_properties' has incomplete type
make[2]: *** [drivers/acpi/video.o] Error 1

Lots of style issues (see below).

> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/acpi/video.c fbdev-2.6/drivers/acpi/video.c
> --- linus-2.6/drivers/acpi/video.c	2006-11-07 05:38:34.000000000 -0500
> +++ fbdev-2.6/drivers/acpi/video.c	2006-12-04 10:40:48.000000000 -0500
> @@ -30,6 +30,9 @@
>  #include <linux/list.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
> +#if defined(CONFIG_DISPLAY_DDC)
> +#include <linux/display.h> 
> +#endif
>  
>  #include <asm/uaccess.h>
>  
> @@ -154,6 +157,20 @@
>  	int *levels;
>  };
>  
> +#if defined(CONFIG_DISPLAY_DDC)
> +static int
> +acpi_display_get_power(struct display_device *dev)

Combine those 2 lines into 1 line.

> +{
> +	return 0;
> +}
> +
> +static int
> +acpi_display_set_power(struct display_device *dev)

Ditto.

> +{
> +	return 0;
> +}
> +#endif
> +
>  struct acpi_video_device {
>  	unsigned long device_id;
>  	struct acpi_video_device_flags flags;
> @@ -162,6 +179,10 @@
>  	struct acpi_video_bus *video;
>  	struct acpi_device *dev;
>  	struct acpi_video_device_brightness *brightness;
> +#if defined(CONFIG_DISPLAY_DDC)
> +	struct display_properties acpi_display_properties;
> +	struct display_device *display;
> +#endif
>  };
>  
>  /* bus */
> @@ -399,6 +420,27 @@
>  	return status;
>  }
>  
> +#if defined(CONFIG_DISPLAY_DDC)
> +static void*
> +acpi_display_get_EDID(struct acpi_video_device *dev)

Combine and place '*' immediately before the function name,
not immediately after "void".

> +{
> +	union acpi_object *edid = NULL;
> +	void *data = NULL;
> +	int status;
> +
> +	status = acpi_video_device_EDID(dev, &edid, 128);
> +	if (ACPI_FAILURE(status))
> +		status = acpi_video_device_EDID(dev, &edid, 256);
> +
> +	if (ACPI_SUCCESS(status)) {
> +		if (edid && edid->type == ACPI_TYPE_BUFFER) {
> +			data = edid->buffer.pointer;

No braces for one-statement "blocks".

> +		}
> +	}
> +	return data;
> +}
> +#endif
> +
>  /* bus */
>  
>  static int

> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/display-ddc.c fbdev-2.6/drivers/video/display/display-ddc.c
> --- linus-2.6/drivers/video/display/display-ddc.c	1969-12-31 19:00:00.000000000 -0500
> +++ fbdev-2.6/drivers/video/display/display-ddc.c	2006-12-03 05:27:00.000000000 -0500
> @@ -0,0 +1,45 @@
> +/*
> + *  display-ddc.c - EDID paring code

typo:  parsing

> +#include <linux/module.h>
> +#include <linux/display.h>
> +#include <linux/err.h>
> +#include <linux/ctype.h>
> +
> +#include <linux/fb.h>
> +
> +int probe_edid(struct display_device *dev, void *data)
> +{
> +	struct fb_monspecs spec;
> +	ssize_t size = 45;

Where does the magic # 45 come from?
Can you use a #define or sizeof(X) for it instead?

> +
> +	dev->name = kzalloc(size, GFP_KERNEL);
> +	fb_edid_to_monspecs((unsigned char *) data, &spec);
> +	strcpy(dev->name, spec.manufacturer);
> +	return snprintf(dev->name, size, "%s %s %s\n", spec.manufacturer, spec.monitor, spec.ascii);

Try to limit source lines to < 80 columns.

> +}
> +EXPORT_SYMBOL(probe_edid);
> +
> +MODULE_DESCRIPTION("Display Hardware handling");
> +MODULE_AUTHOR("James Simmons <jsimmons@infradead.org>");
> +MODULE_LICENSE("GPL");

> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/display-sysfs.c fbdev-2.6/drivers/video/display/display-sysfs.c
> --- linus-2.6/drivers/video/display/display-sysfs.c	1969-12-31 19:00:00.000000000 -0500
> +++ fbdev-2.6/drivers/video/display/display-sysfs.c	2006-12-04 07:48:34.000000000 -0500
> @@ -0,0 +1,164 @@
> +#include <linux/module.h>
> +#include <linux/display.h>
> +#include <linux/err.h>
> +#include <linux/ctype.h>
> +
> +struct display_device *display_device_register(struct display_driver *driver,
> +						struct device *dev, void *devdata)
> +{
> +	struct display_device *new_dev;
> +	int ret = -ENOMEM, i;
> +
> +	if (unlikely(!driver))
> +		return ERR_PTR(-EINVAL);
> +
> +	new_dev = kzalloc(sizeof(struct display_device), GFP_KERNEL);
> +	if (likely(new_dev)) {
> +		driver->probe(new_dev, devdata);
> +
> +		mutex_init(&new_dev->lock);
> +		new_dev->driver = driver;
> +		new_dev->class_dev.class = &display_class;
> +		new_dev->class_dev.dev = dev;
> +		sprintf(new_dev->class_dev.class_id, "display%d", index++);
> +		class_set_devdata(&new_dev->class_dev, devdata);
> +		ret = class_device_register(&new_dev->class_dev);
> +
> +		if (likely(ret)) {
> +			for (i = 0; i < ARRAY_SIZE(display_attributes); i++) {
> +				ret = class_device_create_file(&new_dev->class_dev,
> +								&display_attributes[i]);
> +				if (unlikely(ret)) {
> +					while (--i >= 0)
> +						class_device_remove_file(&new_dev->class_dev,
> +								&display_attributes[i]);
> +					class_device_unregister(&new_dev->class_dev);

Several lines > 80 columns there.

> +				}
> +			}
> +		}
> +	}
> +	if (unlikely(ret)) {
> +		printk("failed to register display device\n");

*			KERN_ERR or some such printk log level

> +		kfree(new_dev);
> +		new_dev = ERR_PTR(ret);
> +	}
> +	return new_dev;
> +}
> +EXPORT_SYMBOL(display_device_register);
> +
> +void display_device_unregister(struct display_device *dev)
> +{
> +	int i;
> +
> +	if (!dev)
> +		return;
> +	mutex_lock(&dev->lock);
> +	dev->driver = NULL;
> +	for (i = 0; i < ARRAY_SIZE(display_attributes); i++)
> +		class_device_remove_file(&dev->class_dev,
> +					&display_attributes[i]);
> +	mutex_unlock(&dev->lock);
> +	class_device_unregister(&dev->class_dev);
> +}
> +EXPORT_SYMBOL(display_device_unregister);
> +
> +static void __exit display_class_exit(void)
> +{
> +	class_unregister(&display_class);
> +}
> +
> +static int __init display_class_init(void)
> +{
> +	return class_register(&display_class);
> +}
> +
> +postcore_initcall(display_class_init);
> +module_exit(display_class_exit);
> +
> +MODULE_DESCRIPTION("Display Hardware handling");
> +MODULE_AUTHOR("James Simmons <jsimmons@infradead.org>");
> +MODULE_LICENSE("GPL");

> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/Kconfig fbdev-2.6/drivers/video/display/Kconfig
> --- linus-2.6/drivers/video/display/Kconfig	1969-12-31 19:00:00.000000000 -0500
> +++ fbdev-2.6/drivers/video/display/Kconfig	2006-12-04 11:41:03.000000000 -0500
> @@ -0,0 +1,29 @@
> +#
> +# Display drivers configuration
> +#
> +
> +menu "Display device support"
> +
> +config DISPLAY_SUPPORT
> +	tristate "Display panel/monitor support"
> +	---help---
> +	  This framework adds support for low-level control of a display. 
> +	  This includes support for power.
> +
> +	  Enable this to be able to choose the drivers for controlling the
> +	  physical display panel/monitor on some platforms. This not only
> +	  covers LCD displays for PDAs but also other types of displays
> +	  such as CRT, TVout etc.
> +
> +	  To have support for your specific display panel you will have to
> +	  select the proper drivers which depend on this option.
> +
> +config DISPLAY_DDC
> +	tristate "Enable EDID parsing"
> +	---help---
> +	  Enable EDID parsing

"Enable" makes it sound like a boolean, not a tristate....

> +
> +comment "Display hardware drivers"
> +	depends on DISPLAY_SUPPORT
> +
> +endmenu
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/Makefile fbdev-2.6/drivers/video/display/Makefile
> --- linus-2.6/drivers/video/display/Makefile	1969-12-31 19:00:00.000000000 -0500
> +++ fbdev-2.6/drivers/video/display/Makefile	2006-12-03 05:02:07.000000000 -0500
> @@ -0,0 +1,7 @@
> +# Display drivers
> +
> +display-objs				:= display-sysfs.o 
> +
> +obj-$(CONFIG_DISPLAY_SUPPORT)		+= display.o
> +
> +obj-$(CONFIG_DISPLAY_DDC)		+= display-ddc.o
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/Kconfig fbdev-2.6/drivers/video/Kconfig
> --- linus-2.6/drivers/video/Kconfig	2006-11-30 05:06:13.000000000 -0500
> +++ fbdev-2.6/drivers/video/Kconfig	2006-12-04 10:40:48.000000000 -0500
> @@ -4,21 +4,6 @@
>  
>  menu "Graphics support"
>  
> -config FIRMWARE_EDID
> -       bool "Enable firmware EDID"
> -       default y
> -       ---help---
> -         This enables access to the EDID transferred from the firmware.
> -	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
> -	 transfers do not work for your driver and if you are using
> -	 nvidiafb, i810fb or savagefb.
> -
> -	 In general, choosing Y for this option is safe.  If you
> -	 experience extremely long delays while booting before you get
> -	 something on your display, try setting this to N.  Matrox cards in
> -	 combination with certain motherboards and monitors are known to
> -	 suffer from this problem.
> -
>  config FB
>  	tristate "Support for frame buffer devices"
>  	---help---
> @@ -53,6 +38,22 @@
>  	  (e.g. an accelerated X server) and that are not frame buffer
>  	  device-aware may cause unexpected results. If unsure, say N.
>  
> +config FIRMWARE_EDID
> +       bool "Enable firmware EDID"
> +       depends on FB
> +       default n 
> +       ---help---
> +         This enables access to the EDID transferred from the firmware.
> +	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
> +	 transfers do not work for your driver and if you are using
> +	 nvidiafb, i810fb or savagefb.
> +

All of the help text (above & below) should be indented like the
first line above is:  one tab + 2 spaces.

> +	 In general, choosing Y for this option is safe.  If you
> +	 experience extremely long delays while booting before you get
> +	 something on your display, try setting this to N.  Matrox cards in
> +	 combination with certain motherboards and monitors are known to
> +	 suffer from this problem.
> +
>  config FB_DDC
>         tristate
>         depends on FB && I2C && I2C_ALGOBIT

---
~Randy

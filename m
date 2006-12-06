Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760588AbWLFNTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760588AbWLFNTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 08:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760594AbWLFNT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 08:19:29 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:62926 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760588AbWLFNT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 08:19:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=csfQO/63WLEFa3l2TKeWWwi1/NS0leCqTB/fcnYld+CFYEltoLCzOKicxh7DFCQYhsKj5elxa0wgG8G2wq1Z08juGGv4eAPTtMV9NrOj4+O3G4Z0xI/d6QI0TqilsOt+uswEmKrMdQFHnm1gH8ki4NIypoV1yerMTCHmyUHeszo=
Message-ID: <653402b90612060519q412412c6xaa66022d75ec1abb@mail.gmail.com>
Date: Wed, 6 Dec 2006 14:19:26 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: Display class
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Luming Yu" <Luming.yu@intel.com>, "Andrew Zabolotny" <zap@homelink.ru>,
       linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org
In-Reply-To: <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	 <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	 <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
	 <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, James Simmons <jsimmons@infradead.org> wrote:
>
> This is the pass at a display class to meet the needs of the output class
> of Mr. Yu for acpi. Also this class could in time replace the lcd class
> located in the backlight directory since a lcd is a type of display.
> The final hope is that the purpose auxdisplay could fall under this
> catergory.
>
> P.S
>    I know the edid parsing would have to be pulled out of the fbdev layer.
>

Few comments about EXPORT_SYMBOL_GPL:

>
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/acpi/video.c fbdev-2.6/drivers/acpi/video.c
> --- linus-2.6/drivers/acpi/video.c      2006-11-07 05:38:34.000000000 -0500
> +++ fbdev-2.6/drivers/acpi/video.c      2006-12-04 10:40:48.000000000 -0500
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
>         int *levels;
>  };
>
> +#if defined(CONFIG_DISPLAY_DDC)
> +static int
> +acpi_display_get_power(struct display_device *dev)
> +{
> +       return 0;
> +}
> +
> +static int
> +acpi_display_set_power(struct display_device *dev)
> +{
> +       return 0;
> +}
> +#endif
> +
>  struct acpi_video_device {
>         unsigned long device_id;
>         struct acpi_video_device_flags flags;
> @@ -162,6 +179,10 @@
>         struct acpi_video_bus *video;
>         struct acpi_device *dev;
>         struct acpi_video_device_brightness *brightness;
> +#if defined(CONFIG_DISPLAY_DDC)
> +       struct display_properties acpi_display_properties;
> +       struct display_device *display;
> +#endif
>  };
>
>  /* bus */
> @@ -399,6 +420,27 @@
>         return status;
>  }
>
> +#if defined(CONFIG_DISPLAY_DDC)
> +static void*
> +acpi_display_get_EDID(struct acpi_video_device *dev)
> +{
> +       union acpi_object *edid = NULL;
> +       void *data = NULL;
> +       int status;
> +
> +       status = acpi_video_device_EDID(dev, &edid, 128);
> +       if (ACPI_FAILURE(status))
> +               status = acpi_video_device_EDID(dev, &edid, 256);
> +
> +       if (ACPI_SUCCESS(status)) {
> +               if (edid && edid->type == ACPI_TYPE_BUFFER) {
> +                       data = edid->buffer.pointer;
> +               }
> +       }
> +       return data;
> +}
> +#endif
> +
>  /* bus */
>
>  static int
> @@ -1255,7 +1297,6 @@
>         int status;
>         struct acpi_video_device *data;
>
> -
>         if (!device || !video)
>                 return -EINVAL;
>
> @@ -1263,12 +1304,10 @@
>             acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
>         if (ACPI_SUCCESS(status)) {
>
> -               data = kmalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
> +               data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
>                 if (!data)
>                         return -ENOMEM;
>
> -               memset(data, 0, sizeof(struct acpi_video_device));
> -
>                 strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
>                 strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
>                 acpi_driver_data(device) = data;
> @@ -1295,6 +1334,13 @@
>                 acpi_video_device_bind(video, data);
>                 acpi_video_device_find_cap(data);
>
> +#ifdef CONFIG_DISPLAY_DDC
> +               data->acpi_display_properties.get_power = acpi_display_get_power;
> +               data->acpi_display_properties.set_power = acpi_display_set_power;
> +               data->acpi_display_properties.probe = probe_edid;
> +               data->display = display_device_register(NULL, acpi_display_get_EDID(data),
> +                                                       &data->acpi_display_properties);
> +#endif
>                 status = acpi_install_notify_handler(device->handle,
>                                                      ACPI_DEVICE_NOTIFY,
>                                                      acpi_video_device_notify,
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/display-ddc.c fbdev-2.6/drivers/video/display/display-ddc.c
> --- linus-2.6/drivers/video/display/display-ddc.c       1969-12-31 19:00:00.000000000 -0500
> +++ fbdev-2.6/drivers/video/display/display-ddc.c       2006-12-03 05:27:00.000000000 -0500
> @@ -0,0 +1,45 @@
> +/*
> + *  display-ddc.c - EDID paring code
> + *
> + *  Copyright (C) 2006 James Simmons <jsimmons@infradead.org>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or (at
> + *  your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +#include <linux/module.h>
> +#include <linux/display.h>
> +#include <linux/err.h>
> +#include <linux/ctype.h>
> +
> +#include <linux/fb.h>
> +
> +int probe_edid(struct display_device *dev, void *data)
> +{
> +       struct fb_monspecs spec;
> +       ssize_t size = 45;
> +
> +       dev->name = kzalloc(size, GFP_KERNEL);
> +       fb_edid_to_monspecs((unsigned char *) data, &spec);
> +       strcpy(dev->name, spec.manufacturer);
> +       return snprintf(dev->name, size, "%s %s %s\n", spec.manufacturer, spec.monitor, spec.ascii);
> +}
> +EXPORT_SYMBOL(probe_edid);

Shouldn't be EXPORT_SYMBOL_GPL?

> +
> +MODULE_DESCRIPTION("Display Hardware handling");
> +MODULE_AUTHOR("James Simmons <jsimmons@infradead.org>");
> +MODULE_LICENSE("GPL");
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/display-sysfs.c fbdev-2.6/drivers/video/display/display-sysfs.c
> --- linus-2.6/drivers/video/display/display-sysfs.c     1969-12-31 19:00:00.000000000 -0500
> +++ fbdev-2.6/drivers/video/display/display-sysfs.c     2006-12-04 07:48:34.000000000 -0500
> @@ -0,0 +1,164 @@
> +/*
> + *  display.c - Display output driver
> + *
> + *  Copyright (C) 2006 James Simmons <jsimmons@infradead.org>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or (at
> + *  your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +#include <linux/module.h>
> +#include <linux/display.h>
> +#include <linux/err.h>
> +#include <linux/ctype.h>
> +
> +static ssize_t display_show_name(struct class_device *dev, char *buf)
> +{
> +       struct display_device *dsp = to_display_device(dev);
> +       return snprintf(buf, PAGE_SIZE, "%s\n", dsp->name);
> +}
> +
> +static ssize_t display_show_power(struct class_device *dev, char *buf)
> +{
> +       struct display_device *dsp = to_display_device(dev);
> +       ssize_t ret = -ENXIO;
> +
> +       mutex_lock(&dsp->lock);
> +       if (likely(dsp->driver->get_power))
> +               ret = sprintf(buf,"%.8x\n", dsp->driver->get_power(dsp));
> +       mutex_unlock(&dsp->lock);
> +       return ret;
> +}
> +
> +static ssize_t display_store_power(struct class_device *dev,
> +       const char *buf,size_t count)
> +{
> +       struct display_device *dsp = to_display_device(dev);
> +       size_t size;
> +       char *endp;
> +       int power;
> +
> +       power = simple_strtoul(buf, &endp, 0);
> +       size = endp - buf;
> +       if (*endp && isspace(*endp))
> +               size++;
> +       if (size != count)
> +               return -EINVAL;
> +
> +       mutex_lock(&dsp->lock);
> +       if (likely(dsp->driver->set_power)) {
> +               dsp->request_state = power;
> +               dsp->driver->set_power(dsp);
> +       }
> +       mutex_unlock(&dsp->lock);
> +       return count;
> +}
> +
> +static void display_class_release(struct class_device *dev)
> +{
> +       struct display_device *dsp = to_display_device(dev);
> +       kfree(dsp);
> +}
> +
> +static struct class_device_attribute display_attributes[] = {
> +       __ATTR(name, S_IRUGO, display_show_name, NULL),
> +       __ATTR(power, S_IRUGO | S_IWUSR, display_show_power, display_store_power),
> +};
> +
> +static struct class display_class = {
> +       .name = "display",
> +       .release = display_class_release,
> +       .class_dev_attrs = display_attributes,
> +};
> +
> +static int index;
> +
> +struct display_device *display_device_register(struct display_driver *driver,
> +                                               struct device *dev, void *devdata)
> +{
> +       struct display_device *new_dev;
> +       int ret = -ENOMEM, i;
> +
> +       if (unlikely(!driver))
> +               return ERR_PTR(-EINVAL);
> +
> +       new_dev = kzalloc(sizeof(struct display_device), GFP_KERNEL);
> +       if (likely(new_dev)) {
> +               driver->probe(new_dev, devdata);
> +
> +               mutex_init(&new_dev->lock);
> +               new_dev->driver = driver;
> +               new_dev->class_dev.class = &display_class;
> +               new_dev->class_dev.dev = dev;
> +               sprintf(new_dev->class_dev.class_id, "display%d", index++);
> +               class_set_devdata(&new_dev->class_dev, devdata);
> +               ret = class_device_register(&new_dev->class_dev);
> +
> +               if (likely(ret)) {
> +                       for (i = 0; i < ARRAY_SIZE(display_attributes); i++) {
> +                               ret = class_device_create_file(&new_dev->class_dev,
> +                                                               &display_attributes[i]);
> +                               if (unlikely(ret)) {
> +                                       while (--i >= 0)
> +                                               class_device_remove_file(&new_dev->class_dev,
> +                                                               &display_attributes[i]);
> +                                       class_device_unregister(&new_dev->class_dev);
> +                               }
> +                       }
> +               }
> +       }
> +       if (unlikely(ret)) {
> +               printk("failed to register display device\n");
> +               kfree(new_dev);
> +               new_dev = ERR_PTR(ret);
> +       }
> +       return new_dev;
> +}
> +EXPORT_SYMBOL(display_device_register);

Shouldn't be EXPORT_SYMBOL_GPL?

> +
> +void display_device_unregister(struct display_device *dev)
> +{
> +       int i;
> +
> +       if (!dev)
> +               return;
> +       mutex_lock(&dev->lock);
> +       dev->driver = NULL;
> +       for (i = 0; i < ARRAY_SIZE(display_attributes); i++)
> +               class_device_remove_file(&dev->class_dev,
> +                                       &display_attributes[i]);
> +       mutex_unlock(&dev->lock);
> +       class_device_unregister(&dev->class_dev);
> +}
> +EXPORT_SYMBOL(display_device_unregister);

Shouldn't be EXPORT_SYMBOL_GPL?

> +
> +static void __exit display_class_exit(void)
> +{
> +       class_unregister(&display_class);
> +}
> +
> +static int __init display_class_init(void)
> +{
> +       return class_register(&display_class);
> +}
> +
> +postcore_initcall(display_class_init);
> +module_exit(display_class_exit);
> +
> +MODULE_DESCRIPTION("Display Hardware handling");
> +MODULE_AUTHOR("James Simmons <jsimmons@infradead.org>");
> +MODULE_LICENSE("GPL");
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/Kconfig fbdev-2.6/drivers/video/display/Kconfig
> --- linus-2.6/drivers/video/display/Kconfig     1969-12-31 19:00:00.000000000 -0500
> +++ fbdev-2.6/drivers/video/display/Kconfig     2006-12-04 11:41:03.000000000 -0500
> @@ -0,0 +1,29 @@
> +#
> +# Display drivers configuration
> +#
> +
> +menu "Display device support"
> +
> +config DISPLAY_SUPPORT
> +       tristate "Display panel/monitor support"
> +       ---help---
> +         This framework adds support for low-level control of a display.
> +         This includes support for power.
> +
> +         Enable this to be able to choose the drivers for controlling the
> +         physical display panel/monitor on some platforms. This not only
> +         covers LCD displays for PDAs but also other types of displays
> +         such as CRT, TVout etc.
> +
> +         To have support for your specific display panel you will have to
> +         select the proper drivers which depend on this option.
> +
> +config DISPLAY_DDC
> +       tristate "Enable EDID parsing"
> +       ---help---
> +         Enable EDID parsing
> +
> +comment "Display hardware drivers"
> +       depends on DISPLAY_SUPPORT
> +
> +endmenu
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/Makefile fbdev-2.6/drivers/video/display/Makefile
> --- linus-2.6/drivers/video/display/Makefile    1969-12-31 19:00:00.000000000 -0500
> +++ fbdev-2.6/drivers/video/display/Makefile    2006-12-03 05:02:07.000000000 -0500
> @@ -0,0 +1,7 @@
> +# Display drivers
> +
> +display-objs                           := display-sysfs.o
> +
> +obj-$(CONFIG_DISPLAY_SUPPORT)          += display.o
> +
> +obj-$(CONFIG_DISPLAY_DDC)              += display-ddc.o
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/Kconfig fbdev-2.6/drivers/video/Kconfig
> --- linus-2.6/drivers/video/Kconfig     2006-11-30 05:06:13.000000000 -0500
> +++ fbdev-2.6/drivers/video/Kconfig     2006-12-04 10:40:48.000000000 -0500
> @@ -4,21 +4,6 @@
>
>  menu "Graphics support"
>
> -config FIRMWARE_EDID
> -       bool "Enable firmware EDID"
> -       default y
> -       ---help---
> -         This enables access to the EDID transferred from the firmware.
> -        On the i386, this is from the Video BIOS. Enable this if DDC/I2C
> -        transfers do not work for your driver and if you are using
> -        nvidiafb, i810fb or savagefb.
> -
> -        In general, choosing Y for this option is safe.  If you
> -        experience extremely long delays while booting before you get
> -        something on your display, try setting this to N.  Matrox cards in
> -        combination with certain motherboards and monitors are known to
> -        suffer from this problem.
> -
>  config FB
>         tristate "Support for frame buffer devices"
>         ---help---
> @@ -53,6 +38,22 @@
>           (e.g. an accelerated X server) and that are not frame buffer
>           device-aware may cause unexpected results. If unsure, say N.
>
> +config FIRMWARE_EDID
> +       bool "Enable firmware EDID"
> +       depends on FB
> +       default n
> +       ---help---
> +         This enables access to the EDID transferred from the firmware.
> +        On the i386, this is from the Video BIOS. Enable this if DDC/I2C
> +        transfers do not work for your driver and if you are using
> +        nvidiafb, i810fb or savagefb.
> +
> +        In general, choosing Y for this option is safe.  If you
> +        experience extremely long delays while booting before you get
> +        something on your display, try setting this to N.  Matrox cards in
> +        combination with certain motherboards and monitors are known to
> +        suffer from this problem.
> +
>  config FB_DDC
>         tristate
>         depends on FB && I2C && I2C_ALGOBIT
> @@ -126,6 +127,9 @@
>          This is particularly important to one driver, matroxfb.  If
>          unsure, say N.
>
> +comment "Frambuffer hardware drivers"
> +       depends on FB
> +
>  config FB_CIRRUS
>         tristate "Cirrus Logic support"
>         depends on FB && (ZORRO || PCI)
> @@ -1641,6 +1647,7 @@
>  endif
>
>  if SYSFS
> +       source "drivers/video/display/Kconfig"
>         source "drivers/video/backlight/Kconfig"
>  endif
>
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/Makefile fbdev-2.6/drivers/video/Makefile
> --- linus-2.6/drivers/video/Makefile    2006-11-07 05:38:36.000000000 -0500
> +++ fbdev-2.6/drivers/video/Makefile    2006-12-04 10:40:48.000000000 -0500
> @@ -12,7 +12,7 @@
>
>  obj-$(CONFIG_VT)                 += console/
>  obj-$(CONFIG_LOGO)               += logo/
> -obj-$(CONFIG_SYSFS)              += backlight/
> +obj-$(CONFIG_SYSFS)              += backlight/ display/
>
>  obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
>  obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/include/linux/display.h fbdev-2.6/include/linux/display.h
> --- linus-2.6/include/linux/display.h   1969-12-31 19:00:00.000000000 -0500
> +++ fbdev-2.6/include/linux/display.h   2006-12-04 07:42:29.000000000 -0500
> @@ -0,0 +1,55 @@
> +/*
> + *  Copyright (C) 2006 James Simmons <jsimmons@infradead.org>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or (at
> + *  your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +
> +#ifndef _LINUX_DISPLAY_H
> +#define _LINUX_DISPLAY_H
> +
> +#include <linux/device.h>
> +
> +struct display_device;
> +
> +/* This structure defines all the properties of a Display. */
> +struct display_driver {
> +       int (*set_power)(struct display_device *);
> +       int (*get_power)(struct display_device *);
> +       int (*probe)(struct display_device *, void *);
> +       int (*remove)(struct display_device *);
> +};
> +
> +struct display_device {
> +       struct module *owner;   /* Owner module */
> +       char *name;
> +       struct mutex lock;
> +       int request_state;
> +       struct display_driver *driver;
> +       struct class_device class_dev;          /* The class device structure */
> +};
> +
> +extern struct display_device *display_device_register(struct display_driver *driver,
> +                                       struct device *dev, void *devdata);
> +extern void display_device_unregister(struct display_device *dev);
> +
> +extern int probe_edid(struct display_device *dev, void *devdata);
> +
> +#define to_display_device(obj) container_of(obj, struct display_device, class_dev)
> +
> +#endif
> diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/MAINTAINERS fbdev-2.6/MAINTAINERS
> --- linus-2.6/MAINTAINERS       2006-12-04 04:11:38.000000000 -0500
> +++ fbdev-2.6/MAINTAINERS       2006-12-04 10:40:48.000000000 -0500
> @@ -911,6 +923,12 @@
>  L:     linux-kernel@vger.kernel.org
>  S:     Maintained
>
> +DISPLAY SUBSYSTEM
> +P:     James Simmons
> +M:     jsimmons@infradead.org
> +L:     linux-kernel@vger.kernel.org
> +S:     Maintained
> +
>  DISTRIBUTED LOCK MANAGER
>  P:     Patrick Caulfield
>  M:     pcaulfie@redhat.com
>


-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm

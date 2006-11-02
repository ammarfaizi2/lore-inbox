Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752440AbWKBVWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbWKBVWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbWKBVWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:22:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1802 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1752334AbWKBVWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:22:47 -0500
Date: Thu, 2 Nov 2006 20:59:55 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Yu Luming <luming.yu@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch 3/6] backlight and output sysfs support for acpi video driver
Message-ID: <20061102205954.GB4887@ucw.cz>
References: <200611042118.08629.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611042118.08629.luming.yu@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> backlight and output sysfs support for acpi video driver

Yes, using generic interfaces is always nice...

> @@ -482,6 +536,134 @@ acpi_video_bus_DOS(struct acpi_video_bus
>  	return status;
>  }
>  
> +
> +/*
> + * copy & paste some code for acpi_pci_data, acpi_pci_data_handler,acpi_pci_data
> + * from pci_bind.c
> + * To-do: write a new API: acpi_pci_get.
> + */

This comment only(?) serves to confuse me...

> +	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
> +	if (!pathname)
> +		return -ENOMEM;
> +	memset(pathname, 0, ACPI_PATHNAME_MAX);

kzalloc()? (More than once in this file).

> +	buffer.length = ACPI_PATHNAME_MAX;
> +	buffer.pointer = pathname;
> +
> +	data = kmalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
> +	if (!data) {
> +		kfree(pathname);
> +		return NULL;
> +	}
> +	memset(data, 0, sizeof(struct acpi_pci_data));
> +
> +	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
> +	printk(KERN_INFO PREFIX "finding PCI device [%s]...\n", pathname);
> +
> +	/*
> +	 * Segment & Bus
> +	 * -------------
> +	 * These are obtained via the parent device's ACPI-PCI context.
> +	 */
> +go_up:
> +	status = acpi_get_data(device->parent->handle, acpi_pci_data_handler,
> +			       (void **)&pdata);
> +	if (ACPI_FAILURE(status) || !pdata || !pdata->bus) {
> +		struct acpi_device *tmp_dev;
> +
> +		tmp_dev = device->parent;
> +		if (tmp_dev->parent && (tmp_dev->parent->handle != ACPI_ROOT_OBJECT)) {
> +			device = tmp_dev;
> +			goto go_up;
> +		}

Could we use plain old loop here?

> +	printk(KERN_INFO PREFIX "data->dev =%p", &data->dev);
> +	printk(KERN_INFO PREFIX "data->dev->dev =%p\n", &data->dev->dev);

I doubt this is useful info for non-debugging. dprintk?
>  
>  
> +	data = acpi_pci_get (device->video->device);
> +        if (!data || !(data->dev)) {

tabs vs. spaces... more than once in this file.

> +		printk(KERN_ERR PREFIX "acpi_video_device:no valid data from acpi_pci_get\n");
> +		return ;

return; looks more natural.

> @@ -1691,8 +1913,9 @@ static int acpi_video_bus_add(struct acp
>  	int result = 0;
>  	acpi_status status = 0;
>  	struct acpi_video_bus *video = NULL;
> +        char proc_dir_name[32];
>  
> -
> +	memset(proc_dir_name, 0, 32);

What about '= { 0, };', instead?

						Pavel
-- 
Thanks for all the (sleeping) penguins.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWAFTTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWAFTTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWAFTTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:19:40 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:59732 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932470AbWAFTTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:19:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=T7agrLGl+sIV/i9wUWKP3HjPRn1jGMX7iDarksrijB/zOLUbOI4G7+Cm67/ZOif8jbISJ2DCf3pt8Hd2Sy52lE1UIvnP8g+YhAhWgn7tOjBAlPMMGsC/QM7tM0YujtDumUP+GvVB+aFHS6hm/GVIVYf1c8g6ES81DfCysUEE25g=
Date: Fri, 6 Jan 2006 22:36:26 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/acpi/scan.c: inconsequent NULL handling
Message-ID: <20060106193625.GA26372@mipter.zuzino.mipt.ru>
References: <20060106162929.GK12131@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106162929.GK12131@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 05:29:29PM +0100, Adrian Bunk wrote:
> static int
> acpi_bus_match (
>         struct acpi_device      *device,
>         struct acpi_driver      *driver)
> {
>         if (driver && driver->ops.match)
>                 return driver->ops.match(device, driver);
>         return acpi_match_ids(device, driver->ids);
> }

> Either driver can be NULL, in which case the driver->ids is a possible
> NULL pointer reference, or it can't, in which case the check whether
> it's NULL is superfluous.

Follow the mon^Wcall tree.

drivers/acpi/scan.c:478: * acpi_bus_match 
drivers/acpi/scan.c:484:acpi_bus_match(struct acpi_device *device, struct acpi_driver *driver)
drivers/acpi/scan.c:564:		if (!acpi_bus_match(dev, drv)) {
drivers/acpi/scan.c:682:		if (!acpi_bus_match(device, driver)) {

1. acpi_bus_match()

   Second arg is passed without changes.

	acpi_driver_attach()
		acpi_bus_register_driver()

	  ===>	if (!driver) <===
			return_VALUE(-EINVAL);

		spin_lock(&acpi_device_lock);
		list_add_tail(&driver->node, &acpi_bus_drivers);
		spin_unlock(&acpi_device_lock);
		count = acpi_driver_attach(driver);

2. acpi_bus_match()
	acpi_bus_find_driver()

		atomic_inc(&driver->references);
			    ^^^^^^^^
                spin_unlock(&acpi_device_lock);
		if (!acpi_bus_match(device, driver)) {

Looks like it can't.


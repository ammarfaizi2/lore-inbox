Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVF3G1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVF3G1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVF3G0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:26:22 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:1644 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262860AbVF3GZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:25:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Date: Thu, 30 Jun 2005 01:25:39 -0500
User-Agent: KMail/1.8.1
Cc: gregkh@suse.de
References: <11201114613610@kroah.com>
In-Reply-To: <11201114613610@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506300125.40851.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 June 2005 01:04, Greg KH wrote:
> [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
> 
> This adds a single file, "unbind", to the sysfs directory of every
> device that is currently bound to a driver.  To unbind the driver from
> the device, write anything to this file and they will be disconnected
> from each other.
>

Comment and the patch disagree with each other.
 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
> commit 151ef38f7c0ec1b0420f04438b0316e3a30bf2e4
> tree 3aa6504e12c08f70cacb7f9de6ef5858b45ee86d
> parent 0edb586049e57c56e625536476931117a57671e9
> author Greg Kroah-Hartman <gregkh@suse.de> Wed, 22 Jun 2005 16:09:05 -0700
> committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 29 Jun 2005 22:48:04 -0700
> 
>  drivers/base/bus.c |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -133,6 +133,34 @@ static struct kobj_type ktype_bus = {
>  decl_subsys(bus, &ktype_bus, NULL);
>  
>  
> +/* Manually detach a device from it's associated driver. */
> +static int driver_helper(struct device *dev, void *data)
> +{
> +	const char *name = data;
> +
> +	if (strcmp(name, dev->bus_id) == 0)
> +		return 1;
> +	return 0;
> +}
> +
> +static ssize_t driver_unbind(struct device_driver *drv,
> +			     const char *buf, size_t count)
> +{
> +	struct bus_type *bus = get_bus(drv->bus);
> +	struct device *dev;
> +	int err = -ENODEV;
> +
> +	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
> +	if ((dev) &&
> +	    (dev->driver == drv)) {
> +		device_release_driver(dev);
> +		err = count;
> +	}
> +	return err;
> +}
> +static DRIVER_ATTR(unbind, S_IWUSR, NULL, driver_unbind);
> +
> +
>  static struct device * next_device(struct klist_iter * i)
>  {
>  	struct klist_node * n = klist_next(i);
> @@ -396,6 +424,7 @@ int bus_add_driver(struct device_driver 
>  		module_add_driver(drv->owner, drv);
>  
>  		driver_add_attrs(bus, drv);
> +		driver_create_file(drv, &driver_attr_unbind);
>  	}
>  	return error;
>  }
> @@ -413,6 +442,7 @@ int bus_add_driver(struct device_driver 
>  void bus_remove_driver(struct device_driver * drv)
>  {
>  	if (drv->bus) {
> +		driver_remove_file(drv, &driver_attr_unbind);
>  		driver_remove_attrs(drv->bus, drv);
>  		klist_remove(&drv->knode_bus);
>  		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Dmitry

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUKUSGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUKUSGs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUKUSGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:06:47 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:39596 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261169AbUKUSGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:06:37 -0500
Message-ID: <41A0D930.8060809@free.fr>
Date: Sun, 21 Nov 2004 19:06:40 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>,
       "Li, Shaohua" <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] PNPACPI
References: <41960B24.9010807@free.fr>
In-Reply-To: <41960B24.9010807@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
> Hi,
> 
> this patch allow to choose the behavior of the pnpacpi driver, it could 
>  don't lock the acpi device like in mm5 or it could lock it like in mm2.
> 
> I have add extra check (CRS presence), so it shouldn't lock too much 
> driver like in mm2.
> I also add the hpet id in the blacklist, because we need to do an pnp 
> driver for it.
> 
> Battery, Button and Fan may be remove from the blacklist because they 
> don't seem to have CRS.
> 
> Please review it and apply if possible
> 
> thanks,
> 
> Matthieu CASTET
> 
Could I have some comments ?

If you don't want the binding part, could the other fix be applied ?
What about in this case about the other patch(to be improved) I made in 
order to give priority to acpi driver over pnp one ?

It could be good to have something clean : I know that the blacklist is 
not a good solution : I even told it before Shaohua implemented it. But 
could you propose something else? It is ugly to stay with 2 layers that 
accepts the same device.


Regards

Matthieu CASTET


> Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.9/drivers/pnp/pnpacpi/core.c.old	2004-11-13 11:53:23.000000000 +0100
> +++ linux-2.6.9/drivers/pnp/pnpacpi/core.c	2004-11-13 13:17:53.000000000 +0100
> @@ -26,15 +26,16 @@
>  
>  static int num = 0;
>  
> -static char __initdata excluded_id_list[] =
> -	"PNP0C0A," /* Battery */
> -	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
> +static char excluded_id_list[] =
> +	"PNP0C0A," /* Battery */ /* is there a CRS ?*/
> +	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */ /* is there a CRS ?*/
> +	"PNP0C0B," /* Fan */ /* is there a CRS ?*/
>  	"PNP0C09," /* EC */
> -	"PNP0C0B," /* Fan */
>  	"PNP0A03," /* PCI root */
>  	"PNP0C0F," /* Link device */
>  	"PNP0000," /* PIC */
>  	"PNP0100," /* Timer */
> +	"PNP0103," /* hpet could be converted, but need work on irq/address */
>  	;
>  static inline int is_exclusive_device(struct acpi_device *dev)
>  {
> @@ -58,7 +59,7 @@
>  #define TEST_ALPHA(c) \
>  	if (!('@' <= (c) || (c) <= 'Z')) \
>  		return 0
> -static int __init ispnpidacpi(char *id)
> +static int ispnpidacpi(char *id)
>  {
>  	TEST_ALPHA(id[0]);
>  	TEST_ALPHA(id[1]);
> @@ -72,7 +73,7 @@
>  	return 1;
>  }
>  
> -static void __init pnpidacpi_to_pnpid(char *id, char *str)
> +static void pnpidacpi_to_pnpid(char *id, char *str)
>  {
>  	str[0] = id[0];
>  	str[1] = id[1];
> @@ -131,17 +132,13 @@
>  	.disable = pnpacpi_disable_resources,
>  };
>  
> -static int __init pnpacpi_add_device(struct acpi_device *device)
> +static int acpi_pnp_add(struct acpi_device *device)
>  {
>  	acpi_handle temp = NULL;
>  	acpi_status status;
>  	struct pnp_id *dev_id;
>  	struct pnp_dev *dev;
>  
> -	if (!ispnpidacpi(acpi_device_hid(device)) ||
> -		is_exclusive_device(device))
> -		return 0;
> -
>  	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
>  	dev =  pnpacpi_kmalloc(sizeof(struct pnp_dev), GFP_KERNEL);
>  	if (!dev) {
> @@ -221,6 +218,9 @@
>  	pnp_add_device(dev);
>  	num ++;
>  
> +#ifndef CONFIG_PNPACPI_NOLOCK
> +	acpi_driver_data(device) = dev;
> +#endif
>  	return AE_OK;
>  err1:
>  	kfree(dev_id);
> @@ -229,15 +229,50 @@
>  	return -EINVAL;
>  }
>  
> +static int acpi_pnp_match(struct acpi_device *device,
> +	struct acpi_driver	*driver)
> +{
> +	acpi_handle temp = NULL;
> +	acpi_status status;
> +	/* don't lock non standard pnp device */
> +	status = acpi_get_handle(device->handle, "_CRS", &temp);
> +	return (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
> +		is_exclusive_device(device));
> +}
> +
> +#ifndef CONFIG_PNPACPI_NOLOCK
> +static int acpi_pnp_remove (struct acpi_device *device, int type)
> +{
> +	struct pnp_dev *dev = acpi_driver_data(device);
> +	if (!dev)
> +		return AE_ERROR;
> +
> +	pnp_remove_device(dev);
> +	return AE_OK;
> +}
> +
> +/* default acpi PNP device driver, support hotplug */
> +static struct acpi_driver acpi_pnp_driver = {
> +	.name =		"ACPI PNP Driver",
> +	.class =	"acpi_pnp",
> +	.ops =		{
> +				.add = acpi_pnp_add,
> +				.remove = acpi_pnp_remove,
> +				.match = acpi_pnp_match,
> +			},
> +};
> +#else
>  static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,
>  	u32 lvl, void *context, void **rv)
>  {
>  	struct acpi_device *device;
>  
> -	if (!acpi_bus_get_device(handle, &device))
> -		pnpacpi_add_device(device);
> +	if (!acpi_bus_get_device(handle, &device) &&
> +		!acpi_pnp_match(device, NULL))
> +		acpi_pnp_add(device);
>  	return AE_OK;
>  }
> +#endif
>  
>  int __init pnpacpi_init(void)
>  {
> @@ -247,9 +282,14 @@
>  	}
>  	pnp_info("PnP ACPI init");
>  	pnp_register_protocol(&pnpacpi_protocol);
> +#ifndef CONFIG_PNPACPI_NOLOCK
> +	if (acpi_bus_register_driver(&acpi_pnp_driver) < 0)
> +		return -ENODEV;
> +#else
>  	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
>  			ACPI_UINT32_MAX, pnpacpi_add_device_handler,
>  			NULL, NULL);
> +#endif
>  	pnp_info("PnP ACPI: found %d devices", num);
>  	return 0;
>  }
> --- linux-2.6.9/drivers/pnp/pnpacpi/Kconfig.old	2004-11-13 12:04:44.000000000 +0100
> +++ linux-2.6.9/drivers/pnp/pnpacpi/Kconfig	2004-11-13 12:20:48.000000000 +0100
> @@ -16,3 +16,13 @@
>            your mainboard devices (on some systems they are disabled by the
>            BIOS) say Y here.  Also the PNPACPI can help prevent resource
>            conflicts between mainboard devices and other bus devices.
> +
> +config PNPACPI_NOLOCK
> +	bool "Don't lock acpi device(OBSOLETE)"
> +	depends on PNPACPI
> +	default y
> +	---help---
> +	  This option allow you to don't lock acpi devices that are used
> +	  by pnpacpi. It could avoid locking some devices that shouldn't
> +	  be locked, or allow to used acpi drivers instead of pnp drivers.
> +	  Note that it will disable hotplug support for pnpacpi devices.


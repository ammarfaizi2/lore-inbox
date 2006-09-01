Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWIAXUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWIAXUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 19:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIAXUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 19:20:07 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:45520 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751207AbWIAXUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 19:20:05 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: kmannth@us.ibm.com
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception code:  0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Fri, 1 Sep 2006 17:20:35 -0600
User-Agent: KMail/1.9.1
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com> <49303.24.9.204.52.1157080555.squirrel@mail.cce.hp.com> <1157151674.5656.21.camel@keithlap>
In-Reply-To: <1157151674.5656.21.camel@keithlap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609011720.36318.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 September 2006 17:01, keith mannthey wrote:
> On Thu, 2006-08-31 at 21:15 -0600, Bjorn Helgaas wrote:
> > The current ACPI driver binding algorithm in acpi_bus_find_driver()
> > looks at each driver, checking whether it can match either the _HID
> > or the _CID of a device.  Since we try the motherboard driver first,
> > it matches the memory device _CID.
> 
> Ok I reverted the motherboard driver patch and cooked up the following
> patch that works for my issue.  
> 
>   It creates the idea that acpi_match_ids has a type of request to check
> against for _HID, _CID or both.  See acpi_bus_match_req. I then fix up
> all the needed callers to change the API to acpi_match_ids and
> acpi_bus_match and have callers can say what they want to match
> against. 
>   
>   Then in acpi_bus_find_driver I have it do 2 passes to search for _HID
> first then the _CID.  
> 
> Does this look like it is in the right ballpark or should we be doing
> something else?  Built/tested against 2.6.18-rc4-mm3. 

Conceptually I like this much better than mucking with the motherboard
driver.  I'm not sure the important people have signed off on this
strategy of binding with _HID first, then _CID (hi, Len :-))  Maybe
there are ramifications that we need to consider.  But I think it
is a better match for "what people expect should happen."

> Signed-off-by: Keith Mannthey <kmannth@us.ibm.com>
> 
> 
> diff -urN linux-2.6.17-orig/drivers/acpi/scan.c linux-2.6.17/drivers/acpi/scan.c
> --- linux-2.6.17-orig/drivers/acpi/scan.c	2006-09-01 17:11:37.000000000 -0400
> +++ linux-2.6.17/drivers/acpi/scan.c	2006-09-01 18:13:53.000000000 -0400
> @@ -235,13 +235,13 @@
>  	return 0;
>  }
>  
> -int acpi_match_ids(struct acpi_device *device, char *ids)
> +int acpi_match_ids(struct acpi_device *device, char *ids, int type)
>  {
> -	if (device->flags.hardware_id)
> +	if ((device->flags.hardware_id) && (type != ACPI_BUS_MATCH_CID))
>  		if (strstr(ids, device->pnp.hardware_id))
>  			return 0;
>  
> -	if (device->flags.compatible_ids) {
> +	if ((device->flags.compatible_ids) && (type != ACPI_BUS_MATCH_HID)) {
>  		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
>  		int i;
>  
> @@ -329,7 +329,8 @@
>  
>  	device->wakeup.flags.valid = 1;
>  	/* Power button, Lid switch always enable wakeup */
> -	if (!acpi_match_ids(device, "PNP0C0D,PNP0C0C,PNP0C0E"))
> +	if (!acpi_match_ids(device, "PNP0C0D,PNP0C0C,PNP0C0E", 
> +							ACPI_BUS_MATCH_ALL))
>  		device->wakeup.flags.run_wake = 1;
>  
>        end:
> @@ -471,11 +472,11 @@
>   * matches the specified driver's criteria.
>   */
>  static int
> -acpi_bus_match(struct acpi_device *device, struct acpi_driver *driver)
> +acpi_bus_match(struct acpi_device *device, struct acpi_driver *driver, int type)
>  {
>  	if (driver && driver->ops.match)
>  		return driver->ops.match(device, driver);
> -	return acpi_match_ids(device, driver->ids);
> +	return acpi_match_ids(device, driver->ids, type);
>  }
>  
>  /**
> @@ -549,7 +550,7 @@
>  			continue;
>  		spin_unlock(&acpi_device_lock);
>  
> -		if (!acpi_bus_match(dev, drv)) {
> +		if (!acpi_bus_match(dev, drv, ACPI_BUS_MATCH_ALL)) {
>  			if (!acpi_bus_driver_init(dev, drv)) {
>  				acpi_start_single_object(dev);
>  				atomic_inc(&drv->references);
> @@ -651,7 +652,22 @@
>  
>  		atomic_inc(&driver->references);
>  		spin_unlock(&acpi_device_lock);
> -		if (!acpi_bus_match(device, driver)) {
> +		if (!acpi_bus_match(device, driver, ACPI_BUS_MATCH_HID)) {
> +			result = acpi_bus_driver_init(device, driver);
> +			if (!result)
> +				goto Done;
> +		}
> +		atomic_dec(&driver->references);
> +		spin_lock(&acpi_device_lock);
> +	}
> +
> +	list_for_each_safe(node, next, &acpi_bus_drivers) {
> +		struct acpi_driver *driver =
> +		    container_of(node, struct acpi_driver, node);
> +
> +		atomic_inc(&driver->references);
> +		spin_unlock(&acpi_device_lock);
> +		if (!acpi_bus_match(device, driver, ACPI_BUS_MATCH_ALL)) {
>  			result = acpi_bus_driver_init(device, driver);
>  			if (!result)
>  				goto Done;
> diff -urN linux-2.6.17-orig/drivers/pnp/pnpacpi/core.c linux-2.6.17/drivers/pnp/pnpacpi/core.c
> --- linux-2.6.17-orig/drivers/pnp/pnpacpi/core.c	2006-09-01 17:11:37.000000000 -0400
> +++ linux-2.6.17/drivers/pnp/pnpacpi/core.c	2006-09-01 18:03:26.000000000 -0400
> @@ -41,7 +41,7 @@
>  	;
>  static inline int is_exclusive_device(struct acpi_device *dev)
>  {
> -	return (!acpi_match_ids(dev, excluded_id_list));
> +	return (!acpi_match_ids(dev, excluded_id_list, ACPI_BUS_MATCH_ALL));
>  }
>  
>  /*
> diff -urN linux-2.6.17-orig/include/acpi/acpi_bus.h linux-2.6.17/include/acpi/acpi_bus.h
> --- linux-2.6.17-orig/include/acpi/acpi_bus.h	2006-09-01 17:11:38.000000000 -0400
> +++ linux-2.6.17/include/acpi/acpi_bus.h	2006-09-01 18:00:27.000000000 -0400
> @@ -79,6 +79,12 @@
>  	ACPI_BUS_DEVICE_TYPE_COUNT
>  };
>  
> +enum acpi_bus_match_req {
> +	ACPI_BUS_MATCH_HID = 0,
> +	ACPI_BUS_MATCH_CID,
> +	ACPI_BUS_MATCH_ALL
> +};
> +
>  struct acpi_driver;
>  struct acpi_device;
>  
> @@ -335,7 +341,7 @@
>  int acpi_bus_trim(struct acpi_device *start, int rmdevice);
>  int acpi_bus_start(struct acpi_device *device);
>  acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd);
> -int acpi_match_ids(struct acpi_device *device, char *ids);
> +int acpi_match_ids(struct acpi_device *device, char *ids, int type);
>  int acpi_create_dir(struct acpi_device *);
>  void acpi_remove_dir(struct acpi_device *);
>  
> 
> 
> 

-- 
VGER BF report: H 0

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWG0QLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWG0QLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWG0QLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:11:00 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:63626 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750822AbWG0QK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:10:59 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [PATCH] DMI: Decode and save OEM String information
Date: Thu, 27 Jul 2006 10:10:53 -0600
User-Agent: KMail/1.9.1
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Matt Domsch" <Matt_Domsch@dell.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Henrique de Moraes Holschuh" <hmh@debian.org>
References: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com>
In-Reply-To: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607271010.53489.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 07:47, Shem Multinymous wrote:
> This teachs dmi_decode() how to to save OEM Strings (type 11) information.
> OEM Strings are  the only safe way to identify some hardware, e.g., the ThinkPad
> embedded controller used by the soon-to-be-submitted tp_smapi driver.

I always thought that ACPI was supposed to describe everything that
(a) consumes resources or requires a driver and (b) is not enumerable
by other hardware standards such as PCI.

If that's true, isn't it a BIOS defect if this embedded controller isn't
described via ACPI?

I don't object to this patch, but it seems like the ideal way forward
would be to get the BIOS fixed so you could claim the device with PNP
for future ThinkPads, and the table of OEM strings would not require
ongoing maintenance.

> Follows the "System Management BIOS (SMBIOS) Specification"
> (http://www.dmtf.org/standards/smbios), and also the userspace
> dmidecode.c code.
> 
> ---
>  drivers/firmware/dmi_scan.c |   21 +++++++++++++++++++++
>  include/linux/dmi.h         |    3 ++-
>  2 files changed, 23 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index b9e3886..d1add3f 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -123,6 +123,24 @@ static void __init dmi_save_devices(stru
>  		dev->type = *d++ & 0x7f;
>  		dev->name = dmi_string(dm, *d);
>  		dev->device_data = NULL;
> +		list_add(&dev->list, &dmi_devices);
> +	}
> +}
> +
> +static void __init dmi_save_oem_strings_devices(struct dmi_header *dm)
> +{
> +	int i, count = *(u8 *)(dm + 1);
> +	struct dmi_device *dev;
> +
> +	for (i = 1; i <= count; i++) {
> +		dev = dmi_alloc(sizeof(*dev));
> +		if (!dev) {
> +			break;
> +		}
> +
> +		dev->type = DMI_DEV_TYPE_OEM_STRING;
> +		dev->name = dmi_string(dm, i);
> +		dev->device_data = NULL;
> 
>  		list_add(&dev->list, &dmi_devices);
>  	}
> @@ -181,6 +199,9 @@ static void __init dmi_decode(struct dmi
>  	case 10:	/* Onboard Devices Information */
>  		dmi_save_devices(dm);
>  		break;
> +	case 11:	/* OEM Strings */
> +		dmi_save_oem_strings_devices(dm);
> +		break;
>  	case 38:	/* IPMI Device Information */
>  		dmi_save_ipmi_device(dm);
>  	}
> diff --git a/include/linux/dmi.h b/include/linux/dmi.h
> index b2cd207..38dc403 100644
> --- a/include/linux/dmi.h
> +++ b/include/linux/dmi.h
> @@ -27,7 +27,8 @@ enum dmi_device_type {
>  	DMI_DEV_TYPE_ETHERNET,
>  	DMI_DEV_TYPE_TOKENRING,
>  	DMI_DEV_TYPE_SOUND,
> -	DMI_DEV_TYPE_IPMI = -1
> +	DMI_DEV_TYPE_IPMI = -1,
> +	DMI_DEV_TYPE_OEM_STRING = -2
>  };
> 
>  struct dmi_header {
> 

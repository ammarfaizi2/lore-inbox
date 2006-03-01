Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWCACAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWCACAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWCACAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:00:11 -0500
Received: from xenotime.net ([66.160.160.81]:11400 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932647AbWCACAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:00:10 -0500
Date: Tue, 28 Feb 2006 18:01:27 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [patch] pci hotplug: add common acpi functions to core
Message-Id: <20060228180127.1fd21b7b.rdunlap@xenotime.net>
In-Reply-To: <1141174017.28842.6.camel@whizzy>
References: <1141174017.28842.6.camel@whizzy>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006 16:46:57 -0800 Kristen Accardi wrote:

> shpchprm_acpi.c and pciehprm_acpi.c are nearly identical.
> In addition, there are functions in both these files that
> are also in acpiphp_glue.c.  This patch will remove duplicate 
> functions from shpchp, pciehp, and acpiphp and move this 
> functionality to pci_hotplug, as it is not hardware specific.  
> Get rid of shpchprm* and pciehprm* files since they are no longer needed.
> shpchprm_nonacpi.c and pciehprm_nonacpi.c are identical, as well
> as shpchprm_legacy.c and can be replaced with a macro.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> ---
>  13 files changed, 331 insertions(+), 663 deletions(-)

> --- /dev/null
> +++ 2.6-git-gregkh/drivers/pci/hotplug/acpi_pcihp.c
> @@ -0,0 +1,201 @@
> +/*
> + * ACPI related functions for PCI hotplug drivers
> + *
> + * Copyright (C) 2006 Intel Corporation
> + *
> + * All rights reserved.
> + *
> + * Send feedback to <kristen.c.accardi@intel.com>
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +#include <acpi/acpi.h>
> +#include <acpi/acpi_bus.h>
> +#include <acpi/actypes.h>
> +#include "pci_hotplug.h"
> +
> +#define	METHOD_NAME__SUN	"_SUN"
> +#define	METHOD_NAME__HPP	"_HPP"
> +#define	METHOD_NAME_OSHP	"OSHP"
> +
> +u8 * acpi_path_name( acpi_handle	handle)

odd spacing.

> +{
> +	acpi_status		status;
> +	static u8	path_name[ACPI_PATHNAME_MAX];
> +	struct acpi_buffer		ret_buf = { ACPI_PATHNAME_MAX, path_name };
> +
> +	memset(path_name, 0, sizeof (path_name));
> +	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &ret_buf);
> +
> +	if (ACPI_FAILURE(status))
> +		return NULL;
> +	else
> +		return path_name;
> +}
> +EXPORT_SYMBOL_GPL(acpi_path_name);

Can acpi_path_name() be used safely by more than 1 caller?
Previously it was duplicated, so the return <path_name> was duplicated,
which made it multiple-caller safe.  Now it seems that in a worst-case
scenario, one caller's path could be clobbered by another.  ?
or maybe (probably) caller 1 is finished with it before caller 2
can ever run.  ?

> +acpi_status acpi_run_oshp(acpi_handle handle)
> +{
> +	acpi_status		status;
> +	u8			*path_name = acpi_path_name(handle);
> +
> +	/* run OSHP */
> +	status = acpi_evaluate_object(handle, METHOD_NAME_OSHP, NULL, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		printk(KERN_ERR "%s:%s OSHP fails=0x%x\n", __FUNCTION__,
> +			path_name, status);
> +	} else {
> +		pr_debug("%s:%s OSHP passes\n", __FUNCTION__, path_name);

{} braces not needed here (on the if nor the else).

> +	}
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(acpi_run_oshp);


A little kernel-doc for non-static (non-private) functions would
be a good thing.

> +int is_root_bridge(acpi_handle handle)
> +{
> +	acpi_status status;
> +	struct acpi_device_info *info;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	int i;
> +
> +	status = acpi_get_object_info(handle, &buffer);
> +	if (ACPI_SUCCESS(status)) {
> +		info = buffer.pointer;
> +		if ((info->valid & ACPI_VALID_HID) &&
> +			!strcmp(PCI_ROOT_HID_STRING,
> +					info->hardware_id.value)) {
> +			acpi_os_free(buffer.pointer);
> +			return 1;
> +		}
> +		if (info->valid & ACPI_VALID_CID) {
> +			for (i=0; i < info->compatibility_id.count; i++) {
> +				if (!strcmp(PCI_ROOT_HID_STRING,
> +					info->compatibility_id.id[i].value)) {
> +					acpi_os_free(buffer.pointer);
> +					return 1;
> +				}
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(is_root_bridge);
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/pci_hotplug.h
> +++ 2.6-git-gregkh/drivers/pci/hotplug/pci_hotplug.h
> @@ -176,5 +176,22 @@ extern int pci_hp_change_slot_info	(stru
> +
> +#ifdef CONFIG_ACPI
> +#include <acpi/acpi.h>
> +#include <acpi/acpi_bus.h>
> +#include <acpi/actypes.h>
> +extern acpi_status acpi_run_oshp(acpi_handle handle);
> +extern void acpi_get_hp_params_from_firmware(struct pci_dev *dev,
> +		struct hotplug_params *hpp);
> +extern u8 * acpi_path_name( acpi_handle	handle);

odd spacing (again).

> +int is_root_bridge(acpi_handle handle);
> +#endif
>  #endif
>  
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/pciehp_hpc.c
> +++ 2.6-git-gregkh/drivers/pci/hotplug/pciehp_hpc.c
> @@ -38,6 +38,9 @@
>  
>  #include "../pci.h"
>  #include "pciehp.h"
> +#ifdef CONFIG_ACPI
> +#include <linux/pci-acpi.h>
> +#endif

Does this driver work with or without ACPI, depending on CONFIG_ACPI?

We don't usually bracket #includes in .c files with ifdef/endif.

> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/shpchp.h
> +++ 2.6-git-gregkh/drivers/pci/hotplug/shpchp.h
> @@ -193,15 +187,24 @@ extern u8	shpchp_handle_power_fault(u8 h
>  
> +
> +#ifdef CONFIG_ACPI
> +#define get_hp_params_from_firmware(dev, hpp) \
> +	acpi_get_hp_params_from_firmware(dev, hpp)
> +#define get_hp_hw_control_from_firmware(pdev) \
> +	do { \
> +		if (DEVICE_ACPI_HANDLE(&(pdev->dev))) \
> +			acpi_run_oshp(DEVICE_ACPI_HANDLE(&(pdev->dev))); \
> +	} while (0)
> +#else
> +#define get_hp_params_from_firmware(dev, hpp)
> +#define get_hp_hw_control_from_firmware(dev)

usually empty macros are like so in Linux:
#define foo(bar)		do { } while(0)

> +#endif
> +

---
~Randy

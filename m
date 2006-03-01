Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbWCACF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWCACF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWCACF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:05:57 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:7075 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932647AbWCACF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:05:56 -0500
Message-ID: <44050100.8070003@jp.fujitsu.com>
Date: Wed, 01 Mar 2006 11:03:44 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Kristen Accardi <kristen.c.accardi@intel.com>
CC: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [Pcihpd-discuss] [patch] pci hotplug: add common acpi functions
 to core
References: <1141174017.28842.6.camel@whizzy>
In-Reply-To: <1141174017.28842.6.camel@whizzy>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristen,

This looks very nice to me!

Here is one comment.

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

I think this seems to leak memory (buffer.pointer), though
I guess you just copy and paste from the original code. I think
we need to free buffer.pointer whenever acpi_get_object_info()
returns as success.

Thanks,
Kenji Kaneshige


Kristen Accardi wrote:
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
>  dev/null                               |binary
>  dev/null                               |binary
>  drivers/pci/hotplug/pciehprm_acpi.c    |  257 ---------------------------------
>  drivers/pci/hotplug/pciehprm_nonacpi.c |   47 ------
>  drivers/pci/hotplug/shpchprm_acpi.c    |  186 -----------------------
>  drivers/pci/hotplug/shpchprm_legacy.c  |   54 ------
>  drivers/pci/hotplug/shpchprm_nonacpi.c |   57 -------
>  drivers/pci/hotplug/Makefile           |   17 --
>  drivers/pci/hotplug/acpi_pcihp.c       |  201 +++++++++++++++++++++++++
>  drivers/pci/hotplug/acpiphp_glue.c     |   28 ---
>  drivers/pci/hotplug/pci_hotplug.h      |   17 ++
>  drivers/pci/hotplug/pciehp.h           |   19 +-
>  drivers/pci/hotplug/pciehp_hpc.c       |   69 ++++++++
>  drivers/pci/hotplug/shpchp.h           |   25 +--
>  drivers/pci/hotplug/shpchp_core.c      |   17 ++
>  13 files changed, 331 insertions(+), 663 deletions(-)
> 
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/Makefile
> +++ 2.6-git-gregkh/drivers/pci/hotplug/Makefile
> @@ -22,6 +22,9 @@ ifdef CONFIG_HOTPLUG_PCI_CPCI
>  pci_hotplug-objs	+=	cpci_hotplug_core.o	\
>  				cpci_hotplug_pci.o
>  endif
> +ifdef CONFIG_ACPI
> +pci_hotplug-objs 	+= 	acpi_pcihp.o
> +endif
>  
>  cpqphp-objs		:=	cpqphp_core.o	\
>  				cpqphp_ctrl.o	\
> @@ -51,23 +54,9 @@ pciehp-objs		:=	pciehp_core.o	\
>  				pciehp_ctrl.o	\
>  				pciehp_pci.o	\
>  				pciehp_hpc.o
> -ifdef CONFIG_ACPI
> -	pciehp-objs += pciehprm_acpi.o
> -else
> -	pciehp-objs += pciehprm_nonacpi.o
> -endif
>  
>  shpchp-objs		:=	shpchp_core.o	\
>  				shpchp_ctrl.o	\
>  				shpchp_pci.o	\
>  				shpchp_sysfs.o	\
>  				shpchp_hpc.o
> -ifdef CONFIG_ACPI
> -	shpchp-objs += shpchprm_acpi.o
> -else
> -	ifdef CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY
> -		shpchp-objs += shpchprm_legacy.o
> -	else
> -		shpchp-objs += shpchprm_nonacpi.o
> -	endif
> -endif
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
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or (at
> + * your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
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
> +
> +static acpi_status
> +acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
> +{
> +	acpi_status		status;
> +	u8			nui[4];
> +	struct acpi_buffer	ret_buf = { 0, NULL};
> +	union acpi_object	*ext_obj, *package;
> +	u8			*path_name = acpi_path_name(handle);
> +	int			i, len = 0;
> +
> +	/* get _hpp */
> +	status = acpi_evaluate_object(handle, METHOD_NAME__HPP, NULL, &ret_buf);
> +	switch (status) {
> +	case AE_BUFFER_OVERFLOW:
> +		ret_buf.pointer = kmalloc (ret_buf.length, GFP_KERNEL);
> +		if (!ret_buf.pointer) {
> +			printk(KERN_ERR "%s:%s alloc for _HPP fail\n",
> +				__FUNCTION__, path_name);
> +			return AE_NO_MEMORY;
> +		}
> +		status = acpi_evaluate_object(handle, METHOD_NAME__HPP,
> +				NULL, &ret_buf);
> +		if (ACPI_SUCCESS(status))
> +			break;
> +	default:
> +		if (ACPI_FAILURE(status)) {
> +			pr_debug("%s:%s _HPP fail=0x%x\n", __FUNCTION__,
> +					path_name, status);
> +			return status;
> +		}
> +	}
> +
> +	ext_obj = (union acpi_object *) ret_buf.pointer;
> +	if (ext_obj->type != ACPI_TYPE_PACKAGE) {
> +		printk(KERN_ERR "%s:%s _HPP obj not a package\n", __FUNCTION__,
> +				path_name);
> +		status = AE_ERROR;
> +		goto free_and_return;
> +	}
> +
> +	len = ext_obj->package.count;
> +	package = (union acpi_object *) ret_buf.pointer;
> +	for ( i = 0; (i < len) || (i < 4); i++) {
> +		ext_obj = (union acpi_object *) &package->package.elements[i];
> +		switch (ext_obj->type) {
> +		case ACPI_TYPE_INTEGER:
> +			nui[i] = (u8)ext_obj->integer.value;
> +			break;
> +		default:
> +			printk(KERN_ERR "%s:%s _HPP obj type incorrect\n",
> +				__FUNCTION__, path_name);
> +			status = AE_ERROR;
> +			goto free_and_return;
> +		}
> +	}
> +
> +	hpp->cache_line_size = nui[0];
> +	hpp->latency_timer = nui[1];
> +	hpp->enable_serr = nui[2];
> +	hpp->enable_perr = nui[3];
> +
> +	pr_debug("  _HPP: cache_line_size=0x%x\n", hpp->cache_line_size);
> +	pr_debug("  _HPP: latency timer  =0x%x\n", hpp->latency_timer);
> +	pr_debug("  _HPP: enable SERR    =0x%x\n", hpp->enable_serr);
> +	pr_debug("  _HPP: enable PERR    =0x%x\n", hpp->enable_perr);
> +
> +free_and_return:
> +	kfree(ret_buf.pointer);
> +	return status;
> +}
> +
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
> +	}
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(acpi_run_oshp);
> +
> +
> +
> +void acpi_get_hp_params_from_firmware(struct pci_dev *dev,
> +		struct hotplug_params *hpp)
> +{
> +	acpi_status status = AE_NOT_FOUND;
> +	struct pci_dev *pdev = dev;
> +
> +	/*
> +	 * _HPP settings apply to all child buses, until another _HPP is
> +	 * encountered. If we don't find an _HPP for the input pci dev,
> +	 * look for it in the parent device scope since that would apply to
> +	 * this pci dev. If we don't find any _HPP, use hardcoded defaults
> +	 */
> +	while (pdev && (ACPI_FAILURE(status))) {
> +		acpi_handle handle = DEVICE_ACPI_HANDLE(&(pdev->dev));
> +		if (!handle)
> +			break;
> +		status = acpi_run_hpp(handle, hpp);
> +		if (!(pdev->bus->parent))
> +			break;
> +		/* Check if a parent object supports _HPP */
> +		pdev = pdev->bus->parent->self;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_hp_params_from_firmware);
> +
> +
> +
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
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/acpiphp_glue.c
> +++ 2.6-git-gregkh/drivers/pci/hotplug/acpiphp_glue.c
> @@ -1408,34 +1408,6 @@ void handle_hotplug_event_func(acpi_hand
>  	}
>  }
>  
> -static int is_root_bridge(acpi_handle handle)
> -{
> -	acpi_status status;
> -	struct acpi_device_info *info;
> -	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> -	int i;
> -
> -	status = acpi_get_object_info(handle, &buffer);
> -	if (ACPI_SUCCESS(status)) {
> -		info = buffer.pointer;
> -		if ((info->valid & ACPI_VALID_HID) &&
> -			!strcmp(PCI_ROOT_HID_STRING,
> -					info->hardware_id.value)) {
> -			acpi_os_free(buffer.pointer);
> -			return 1;
> -		}
> -		if (info->valid & ACPI_VALID_CID) {
> -			for (i=0; i < info->compatibility_id.count; i++) {
> -				if (!strcmp(PCI_ROOT_HID_STRING,
> -					info->compatibility_id.id[i].value)) {
> -					acpi_os_free(buffer.pointer);
> -					return 1;
> -				}
> -			}
> -		}
> -	}
> -	return 0;
> -}
>  
>  static acpi_status
>  find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/pci_hotplug.h
> +++ 2.6-git-gregkh/drivers/pci/hotplug/pci_hotplug.h
> @@ -176,5 +176,22 @@ extern int pci_hp_change_slot_info	(stru
>  					 struct hotplug_slot_info *info);
>  extern struct subsystem pci_hotplug_slots_subsys;
>  
> +struct hotplug_params {
> +	u8 cache_line_size;
> +	u8 latency_timer;
> +	u8 enable_serr;
> +	u8 enable_perr;
> +};
> +
> +#ifdef CONFIG_ACPI
> +#include <acpi/acpi.h>
> +#include <acpi/acpi_bus.h>
> +#include <acpi/actypes.h>
> +extern acpi_status acpi_run_oshp(acpi_handle handle);
> +extern void acpi_get_hp_params_from_firmware(struct pci_dev *dev,
> +		struct hotplug_params *hpp);
> +extern u8 * acpi_path_name( acpi_handle	handle);
> +int is_root_bridge(acpi_handle handle);
> +#endif
>  #endif
>  
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/pciehp.h
> +++ 2.6-git-gregkh/drivers/pci/hotplug/pciehp.h
> @@ -50,12 +50,6 @@ extern int pciehp_force;
>  #define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
>  #define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME , ## arg)
>  
> -struct hotplug_params {
> -	u8 cache_line_size;
> -	u8 latency_timer;
> -	u8 enable_serr;
> -	u8 enable_perr;
> -};
>  
>  struct slot {
>  	struct slot *next;
> @@ -192,9 +186,6 @@ extern u8	pciehp_handle_power_fault	(u8 
>  /* pci functions */
>  extern int	pciehp_configure_device		(struct slot *p_slot);
>  extern int	pciehp_unconfigure_device	(struct slot *p_slot);
> -extern int	pciehp_get_hp_hw_control_from_firmware(struct pci_dev *dev);
> -extern void	pciehp_get_hp_params_from_firmware(struct pci_dev *dev,
> -	       	struct hotplug_params *hpp);
>  
>  
>  
> @@ -286,4 +277,14 @@ struct hpc_ops {
>  	int	(*check_lnk_status)	(struct controller *ctrl);
>  };
>  
> +
> +#ifdef CONFIG_ACPI
> +#define pciehp_get_hp_hw_control_from_firmware(dev) \
> +	pciehp_acpi_get_hp_hw_control_from_firmware(dev)
> +#define pciehp_get_hp_params_from_firmware(dev, hpp) \
> +	acpi_get_hp_params_from_firmware(dev, hpp)
> +#else
> +#define pciehp_get_hp_hw_control_from_firmware(dev) 	0
> +#define acpi_get_hp_params_from_firmware(dev, hpp)
> +#endif 				/* CONFIG_ACPI */
>  #endif				/* _PCIEHP_H */
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/pciehp_hpc.c
> +++ 2.6-git-gregkh/drivers/pci/hotplug/pciehp_hpc.c
> @@ -38,6 +38,9 @@
>  
>  #include "../pci.h"
>  #include "pciehp.h"
> +#ifdef CONFIG_ACPI
> +#include <linux/pci-acpi.h>
> +#endif
>  
>  #ifdef DEBUG
>  #define DBG_K_TRACE_ENTRY      ((unsigned int)0x00000001)	/* On function entry */
> @@ -1236,6 +1239,72 @@ static struct hpc_ops pciehp_hpc_ops = {
>  	.check_lnk_status		= hpc_check_lnk_status,
>  };
>  
> +#ifdef CONFIG_ACPI
> +int pciehp_acpi_get_hp_hw_control_from_firmware(struct pci_dev *dev)
> +{
> +	acpi_status status;
> +	acpi_handle chandle, handle = DEVICE_ACPI_HANDLE(&(dev->dev));
> +	struct pci_dev *pdev = dev;
> +	struct pci_bus *parent;
> +	u8 *path_name;
> +
> +	/*
> +	 * Per PCI firmware specification, we should run the ACPI _OSC
> +	 * method to get control of hotplug hardware before using it.
> +	 * If an _OSC is missing, we look for an OSHP to do the same thing.
> +	 * To handle different BIOS behavior, we look for _OSC and OSHP
> +	 * within the scope of the hotplug controller and its parents, upto
> +	 * the host bridge under which this controller exists.
> +	 */
> +	while (!handle) {
> +		/*
> +		 * This hotplug controller was not listed in the ACPI name
> +		 * space at all. Try to get acpi handle of parent pci bus.
> +		 */
> +		if (!pdev || !pdev->bus->parent)
> +			break;
> +		parent = pdev->bus->parent;
> +		dbg("Could not find %s in acpi namespace, trying parent\n",
> +				pci_name(pdev));
> +		if (!parent->self)
> +			/* Parent must be a host bridge */
> +			handle = acpi_get_pci_rootbridge_handle(
> +					pci_domain_nr(parent),
> +					parent->number);
> +		else
> +			handle = DEVICE_ACPI_HANDLE(
> +					&(parent->self->dev));
> +		pdev = parent->self;
> +	}
> +
> +	while (handle) {
> +		path_name = acpi_path_name(handle);
> +		dbg("Trying to get hotplug control for %s \n", path_name);
> +		status = pci_osc_control_set(handle,
> +				OSC_PCI_EXPRESS_NATIVE_HP_CONTROL);
> +		if (status == AE_NOT_FOUND)
> +			status = acpi_run_oshp(handle);
> +		if (ACPI_SUCCESS(status)) {
> +			dbg("Gained control for hotplug HW for pci %s (%s)\n",
> +				pci_name(dev), path_name);
> +			return 0;
> +		}
> +		if (is_root_bridge(handle))
> +			break;
> +		chandle = handle;
> +		status = acpi_get_parent(chandle, &handle);
> +		if (ACPI_FAILURE(status))
> +			break;
> +	}
> +
> +	err("Cannot get control of hotplug hardware for pci %s\n",
> +			pci_name(dev));
> +	return -1;
> +}
> +#endif
> +
> +
> +
>  int pcie_init(struct controller * ctrl, struct pcie_device *dev)
>  {
>  	struct php_ctlr_state_s *php_ctlr, *p;
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/pciehprm_acpi.c
> +++ /dev/null
> @@ -1,257 +0,0 @@
> -/*
> - * PCIEHPRM ACPI: PHP Resource Manager for ACPI platform
> - *
> - * Copyright (C) 2003-2004 Intel Corporation
> - *
> - * All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or (at
> - * your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> - * NON INFRINGEMENT.  See the GNU General Public License for more
> - * details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - *
> - * Send feedback to <kristen.c.accardi@intel.com>
> - *
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/pci.h>
> -#include <linux/acpi.h>
> -#include <linux/pci-acpi.h>
> -#include <acpi/acpi_bus.h>
> -#include <acpi/actypes.h>
> -#include "pciehp.h"
> -
> -#define	METHOD_NAME__SUN	"_SUN"
> -#define	METHOD_NAME__HPP	"_HPP"
> -#define	METHOD_NAME_OSHP	"OSHP"
> -
> -static u8 * acpi_path_name( acpi_handle	handle)
> -{
> -	acpi_status		status;
> -	static u8		path_name[ACPI_PATHNAME_MAX];
> -	struct acpi_buffer	ret_buf = { ACPI_PATHNAME_MAX, path_name };
> -
> -	memset(path_name, 0, sizeof (path_name));
> -	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &ret_buf);
> -
> -	if (ACPI_FAILURE(status))
> -		return NULL;
> -	else
> -		return path_name;	
> -}
> -
> -static acpi_status
> -acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
> -{
> -	acpi_status		status;
> -	u8			nui[4];
> -	struct acpi_buffer	ret_buf = { 0, NULL};
> -	union acpi_object	*ext_obj, *package;
> -	u8			*path_name = acpi_path_name(handle);
> -	int			i, len = 0;
> -
> -	/* get _hpp */
> -	status = acpi_evaluate_object(handle, METHOD_NAME__HPP, NULL, &ret_buf);
> -	switch (status) {
> -	case AE_BUFFER_OVERFLOW:
> -		ret_buf.pointer = kmalloc (ret_buf.length, GFP_KERNEL);
> -		if (!ret_buf.pointer) {
> -			err ("%s:%s alloc for _HPP fail\n", __FUNCTION__,
> -					path_name);
> -			return AE_NO_MEMORY;
> -		}
> -		status = acpi_evaluate_object(handle, METHOD_NAME__HPP,
> -				NULL, &ret_buf);
> -		if (ACPI_SUCCESS(status))
> -			break;
> -	default:
> -		if (ACPI_FAILURE(status)) {
> -			dbg("%s:%s _HPP fail=0x%x\n", __FUNCTION__,
> -					path_name, status);
> -			return status;
> -		}
> -	}
> -
> -	ext_obj = (union acpi_object *) ret_buf.pointer;
> -	if (ext_obj->type != ACPI_TYPE_PACKAGE) {
> -		err ("%s:%s _HPP obj not a package\n", __FUNCTION__,
> -				path_name);
> -		status = AE_ERROR;
> -		goto free_and_return;
> -	}
> -
> -	len = ext_obj->package.count;
> -	package = (union acpi_object *) ret_buf.pointer;
> -	for ( i = 0; (i < len) || (i < 4); i++) {
> -		ext_obj = (union acpi_object *) &package->package.elements[i];
> -		switch (ext_obj->type) {
> -		case ACPI_TYPE_INTEGER:
> -			nui[i] = (u8)ext_obj->integer.value;
> -			break;
> -		default:
> -			err ("%s:%s _HPP obj type incorrect\n", __FUNCTION__,
> -					path_name);
> -			status = AE_ERROR;
> -			goto free_and_return;
> -		}
> -	}
> -
> -	hpp->cache_line_size = nui[0];
> -	hpp->latency_timer = nui[1];
> -	hpp->enable_serr = nui[2];
> -	hpp->enable_perr = nui[3];
> -
> -	dbg("  _HPP: cache_line_size=0x%x\n", hpp->cache_line_size);
> -	dbg("  _HPP: latency timer  =0x%x\n", hpp->latency_timer);
> -	dbg("  _HPP: enable SERR    =0x%x\n", hpp->enable_serr);
> -	dbg("  _HPP: enable PERR    =0x%x\n", hpp->enable_perr);
> -
> -free_and_return:
> -	kfree(ret_buf.pointer);
> -	return status;
> -}
> -
> -static acpi_status acpi_run_oshp(acpi_handle handle)
> -{
> -	acpi_status		status;
> -	u8			*path_name = acpi_path_name(handle);
> -
> -	/* run OSHP */
> -	status = acpi_evaluate_object(handle, METHOD_NAME_OSHP, NULL, NULL);
> -	if (ACPI_FAILURE(status)) {
> -		dbg("%s:%s OSHP fails=0x%x\n", __FUNCTION__, path_name,
> -				status);
> -	} else {
> -		dbg("%s:%s OSHP passes\n", __FUNCTION__, path_name);
> -	}
> -	return status;
> -}
> -
> -static int is_root_bridge(acpi_handle handle)
> -{
> -	acpi_status status;
> -	struct acpi_device_info *info;
> -	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> -	int i;
> -
> -	status = acpi_get_object_info(handle, &buffer);
> -	if (ACPI_SUCCESS(status)) {
> -		info = buffer.pointer;
> -		if ((info->valid & ACPI_VALID_HID) &&
> -			!strcmp(PCI_ROOT_HID_STRING,
> -					info->hardware_id.value)) {
> -			acpi_os_free(buffer.pointer);
> -			return 1;
> -		}
> -		if (info->valid & ACPI_VALID_CID) {
> -			for (i=0; i < info->compatibility_id.count; i++) {
> -				if (!strcmp(PCI_ROOT_HID_STRING,
> -					info->compatibility_id.id[i].value)) {
> -					acpi_os_free(buffer.pointer);
> -					return 1;
> -				}
> -			}
> -		}
> -	}
> -	return 0;
> -}
> -
> -int pciehp_get_hp_hw_control_from_firmware(struct pci_dev *dev)
> -{
> -	acpi_status status;
> -	acpi_handle chandle, handle = DEVICE_ACPI_HANDLE(&(dev->dev));
> -	struct pci_dev *pdev = dev;
> -	struct pci_bus *parent;
> -	u8 *path_name;
> -
> -	/*
> -	 * Per PCI firmware specification, we should run the ACPI _OSC
> -	 * method to get control of hotplug hardware before using it.
> -	 * If an _OSC is missing, we look for an OSHP to do the same thing.
> -	 * To handle different BIOS behavior, we look for _OSC and OSHP
> -	 * within the scope of the hotplug controller and its parents, upto
> -	 * the host bridge under which this controller exists.
> -	 */
> -	while (!handle) {
> -		/*
> -		 * This hotplug controller was not listed in the ACPI name
> -		 * space at all. Try to get acpi handle of parent pci bus.
> -		 */
> -		if (!pdev || !pdev->bus->parent)
> -			break;
> -		parent = pdev->bus->parent;
> -		dbg("Could not find %s in acpi namespace, trying parent\n",
> -				pci_name(pdev));
> -		if (!parent->self)
> -			/* Parent must be a host bridge */
> -			handle = acpi_get_pci_rootbridge_handle(
> -					pci_domain_nr(parent),
> -					parent->number);
> -		else
> -			handle = DEVICE_ACPI_HANDLE(
> -					&(parent->self->dev));
> -		pdev = parent->self;
> -	}
> -
> -	while (handle) {
> -		path_name = acpi_path_name(handle);
> -		dbg("Trying to get hotplug control for %s \n", path_name);
> -		status = pci_osc_control_set(handle,
> -				OSC_PCI_EXPRESS_NATIVE_HP_CONTROL);
> -		if (status == AE_NOT_FOUND)
> -			status = acpi_run_oshp(handle);
> -		if (ACPI_SUCCESS(status)) {
> -			dbg("Gained control for hotplug HW for pci %s (%s)\n",
> -				pci_name(dev), path_name);
> -			return 0;
> -		}
> -		if (is_root_bridge(handle))
> -			break;
> -		chandle = handle;
> -		status = acpi_get_parent(chandle, &handle);
> -		if (ACPI_FAILURE(status))
> -			break;
> -	}
> -
> -	err("Cannot get control of hotplug hardware for pci %s\n",
> -			pci_name(dev));
> -	return -1;
> -}
> -
> -void pciehp_get_hp_params_from_firmware(struct pci_dev *dev,
> -		struct hotplug_params *hpp)
> -{
> -	acpi_status status = AE_NOT_FOUND;
> -	struct pci_dev *pdev = dev;
> -
> -	/*
> -	 * _HPP settings apply to all child buses, until another _HPP is
> -	 * encountered. If we don't find an _HPP for the input pci dev,
> -	 * look for it in the parent device scope since that would apply to
> -	 * this pci dev. If we don't find any _HPP, use hardcoded defaults
> -	 */
> -	while (pdev && (ACPI_FAILURE(status))) {
> -		acpi_handle handle = DEVICE_ACPI_HANDLE(&(pdev->dev));
> -		if (!handle)
> -			break;
> -		status = acpi_run_hpp(handle, hpp);
> -		if (!(pdev->bus->parent))
> -			break;
> -		/* Check if a parent object supports _HPP */
> -		pdev = pdev->bus->parent->self;
> -	}
> -}
> -
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/pciehprm_nonacpi.c
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -/*
> - * PCIEHPRM NONACPI: PHP Resource Manager for Non-ACPI/Legacy platform
> - *
> - * Copyright (C) 1995,2001 Compaq Computer Corporation
> - * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
> - * Copyright (C) 2001 IBM Corp.
> - * Copyright (C) 2003-2004 Intel Corporation
> - *
> - * All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or (at
> - * your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> - * NON INFRINGEMENT.  See the GNU General Public License for more
> - * details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - *
> - * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
> - *
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/sched.h>
> -#include <linux/pci.h>
> -#include <linux/slab.h>
> -#include "pciehp.h"
> -
> -void pciehp_get_hp_params_from_firmware(struct pci_dev *dev,
> -		struct hotplug_params *hpp)
> -{
> -	return;
> -}
> -
> -int pciehp_get_hp_hw_control_from_firmware(struct pci_dev *dev)
> -{
> -	return 0;
> -}
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/shpchp.h
> +++ 2.6-git-gregkh/drivers/pci/hotplug/shpchp.h
> @@ -106,12 +106,6 @@ struct controller {
>  	volatile int cmd_busy;
>  };
>  
> -struct hotplug_params {
> -	u8	cache_line_size;
> -	u8	latency_timer;
> -	u8	enable_serr;
> -	u8	enable_perr;
> -};
>  
>  /* Define AMD SHPC ID  */
>  #define PCI_DEVICE_ID_AMD_GOLAM_7450	0x7450 
> @@ -193,15 +187,24 @@ extern u8	shpchp_handle_power_fault(u8 h
>  extern int	shpchp_save_config(struct controller *ctrl, int busnumber, int num_ctlr_slots, int first_device_num);
>  extern int	shpchp_configure_device(struct slot *p_slot);
>  extern int	shpchp_unconfigure_device(struct slot *p_slot);
> -extern void	get_hp_hw_control_from_firmware(struct pci_dev *dev);
> -extern void	get_hp_params_from_firmware(struct pci_dev *dev,
> -		struct hotplug_params *hpp);
> -extern int	shpchprm_get_physical_slot_number(struct controller *ctrl,
> -		u32 *sun, u8 busnum, u8 devnum);
>  extern void	shpchp_remove_ctrl_files(struct controller *ctrl);
>  extern void	cleanup_slots(struct controller *ctrl);
>  extern void	queue_pushbutton_work(void *data);
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
> +#endif
> +
>  struct ctrl_reg {
>  	volatile u32 base_offset;
>  	volatile u32 slot_avail1;
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/shpchp_core.c
> +++ 2.6-git-gregkh/drivers/pci/hotplug/shpchp_core.c
> @@ -104,6 +104,23 @@ static void make_slot_name(struct slot *
>  		 slot->bus, slot->number);
>  }
>  
> +
> +
> +
> +static int
> +shpchprm_get_physical_slot_number(struct controller *ctrl, u32 *sun,
> +				u8 busnum, u8 devnum)
> +{
> +	int offset = devnum - ctrl->slot_device_offset;
> +
> +	dbg("%s: ctrl->slot_num_inc %d, offset %d\n", __FUNCTION__,
> +			ctrl->slot_num_inc, offset);
> +	*sun = (u8) (ctrl->first_slot + ctrl->slot_num_inc *offset);
> +	return 0;
> +}
> +
> +
> +
>  static int init_slots(struct controller *ctrl)
>  {
>  	struct slot *slot;
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/shpchprm_acpi.c
> +++ /dev/null
> @@ -1,186 +0,0 @@
> -/*
> - * SHPCHPRM ACPI: PHP Resource Manager for ACPI platform
> - *
> - * Copyright (C) 2003-2004 Intel Corporation
> - *
> - * All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or (at
> - * your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> - * NON INFRINGEMENT.  See the GNU General Public License for more
> - * details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - *
> - * Send feedback to <kristen.c.accardi@intel.com>
> - *
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/pci.h>
> -#include <acpi/acpi.h>
> -#include <acpi/acpi_bus.h>
> -#include <acpi/actypes.h>
> -#include "shpchp.h"
> -
> -#define	METHOD_NAME__SUN	"_SUN"
> -#define	METHOD_NAME__HPP	"_HPP"
> -#define	METHOD_NAME_OSHP	"OSHP"
> -
> -static u8 * acpi_path_name( acpi_handle	handle)
> -{
> -	acpi_status		status;
> -	static u8	path_name[ACPI_PATHNAME_MAX];
> -	struct acpi_buffer		ret_buf = { ACPI_PATHNAME_MAX, path_name };
> -
> -	memset(path_name, 0, sizeof (path_name));
> -	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &ret_buf);
> -
> -	if (ACPI_FAILURE(status))
> -		return NULL;
> -	else
> -		return path_name;	
> -}
> -
> -static acpi_status
> -acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
> -{
> -	acpi_status		status;
> -	u8			nui[4];
> -	struct acpi_buffer	ret_buf = { 0, NULL};
> -	union acpi_object	*ext_obj, *package;
> -	u8			*path_name = acpi_path_name(handle);
> -	int			i, len = 0;
> -
> -	/* get _hpp */
> -	status = acpi_evaluate_object(handle, METHOD_NAME__HPP, NULL, &ret_buf);
> -	switch (status) {
> -	case AE_BUFFER_OVERFLOW:
> -		ret_buf.pointer = kmalloc (ret_buf.length, GFP_KERNEL);
> -		if (!ret_buf.pointer) {
> -			err ("%s:%s alloc for _HPP fail\n", __FUNCTION__,
> -					path_name);
> -			return AE_NO_MEMORY;
> -		}
> -		status = acpi_evaluate_object(handle, METHOD_NAME__HPP,
> -				NULL, &ret_buf);
> -		if (ACPI_SUCCESS(status))
> -			break;
> -	default:
> -		if (ACPI_FAILURE(status)) {
> -			dbg("%s:%s _HPP fail=0x%x\n", __FUNCTION__,
> -					path_name, status);
> -			return status;
> -		}
> -	}
> -
> -	ext_obj = (union acpi_object *) ret_buf.pointer;
> -	if (ext_obj->type != ACPI_TYPE_PACKAGE) {
> -		err ("%s:%s _HPP obj not a package\n", __FUNCTION__,
> -				path_name);
> -		status = AE_ERROR;
> -		goto free_and_return;
> -	}
> -
> -	len = ext_obj->package.count;
> -	package = (union acpi_object *) ret_buf.pointer;
> -	for ( i = 0; (i < len) || (i < 4); i++) {
> -		ext_obj = (union acpi_object *) &package->package.elements[i];
> -		switch (ext_obj->type) {
> -		case ACPI_TYPE_INTEGER:
> -			nui[i] = (u8)ext_obj->integer.value;
> -			break;
> -		default:
> -			err ("%s:%s _HPP obj type incorrect\n", __FUNCTION__,
> -					path_name);
> -			status = AE_ERROR;
> -			goto free_and_return;
> -		}
> -	}
> -
> -	hpp->cache_line_size = nui[0];
> -	hpp->latency_timer = nui[1];
> -	hpp->enable_serr = nui[2];
> -	hpp->enable_perr = nui[3];
> -
> -	dbg("  _HPP: cache_line_size=0x%x\n", hpp->cache_line_size);
> -	dbg("  _HPP: latency timer  =0x%x\n", hpp->latency_timer);
> -	dbg("  _HPP: enable SERR    =0x%x\n", hpp->enable_serr);
> -	dbg("  _HPP: enable PERR    =0x%x\n", hpp->enable_perr);
> -
> -free_and_return:
> -	kfree(ret_buf.pointer);
> -	return status;
> -}
> -
> -static void acpi_run_oshp(acpi_handle handle)
> -{
> -	acpi_status		status;
> -	u8			*path_name = acpi_path_name(handle);
> -
> -	/* run OSHP */
> -	status = acpi_evaluate_object(handle, METHOD_NAME_OSHP, NULL, NULL);
> -	if (ACPI_FAILURE(status)) {
> -		err("%s:%s OSHP fails=0x%x\n", __FUNCTION__, path_name,
> -				status);
> -	} else {
> -		dbg("%s:%s OSHP passes\n", __FUNCTION__, path_name);
> -	}
> -}
> -
> -int shpchprm_get_physical_slot_number(struct controller *ctrl, u32 *sun, u8 busnum, u8 devnum)
> -{
> -	int offset = devnum - ctrl->slot_device_offset;
> -
> -	dbg("%s: ctrl->slot_num_inc %d, offset %d\n", __FUNCTION__, ctrl->slot_num_inc, offset);
> -	*sun = (u8) (ctrl->first_slot + ctrl->slot_num_inc *offset);
> -	return 0;
> -}
> -
> -void get_hp_hw_control_from_firmware(struct pci_dev *dev)
> -{
> -	/*
> -	 * OSHP is an optional ACPI firmware control method. If present,
> -	 * we need to run it to inform BIOS that we will control SHPC
> -	 * hardware from now on.
> -	 */
> -	acpi_handle handle = DEVICE_ACPI_HANDLE(&(dev->dev));
> -	if (!handle)
> -		return;
> -	acpi_run_oshp(handle);
> -}
> -
> -void get_hp_params_from_firmware(struct pci_dev *dev,
> -		struct hotplug_params *hpp)
> -{
> -	acpi_status status = AE_NOT_FOUND;
> -	struct pci_dev *pdev = dev;
> -
> -	/*
> -	 * _HPP settings apply to all child buses, until another _HPP is
> -	 * encountered. If we don't find an _HPP for the input pci dev,
> -	 * look for it in the parent device scope since that would apply to
> -	 * this pci dev. If we don't find any _HPP, use hardcoded defaults
> -	 */
> -	while (pdev && (ACPI_FAILURE(status))) {
> -		acpi_handle handle = DEVICE_ACPI_HANDLE(&(pdev->dev));
> -		if (!handle)
> -			break;
> -		status = acpi_run_hpp(handle, hpp);
> -		if (!(pdev->bus->parent))
> -			break;
> -		/* Check if a parent object supports _HPP */
> -		pdev = pdev->bus->parent->self;
> -	}
> -}
> -
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/shpchprm_legacy.c
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -/*
> - * SHPCHPRM Legacy: PHP Resource Manager for Non-ACPI/Legacy platform
> - *
> - * Copyright (C) 1995,2001 Compaq Computer Corporation
> - * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
> - * Copyright (C) 2001 IBM Corp.
> - * Copyright (C) 2003-2004 Intel Corporation
> - *
> - * All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or (at
> - * your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> - * NON INFRINGEMENT.  See the GNU General Public License for more
> - * details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - *
> - * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
> - *
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/pci.h>
> -#include "shpchp.h"
> -
> -int shpchprm_get_physical_slot_number(struct controller *ctrl, u32 *sun, u8 busnum, u8 devnum)
> -{
> -	int	offset = devnum - ctrl->slot_device_offset;
> -
> -	*sun = (u8) (ctrl->first_slot + ctrl->slot_num_inc * offset);
> -	return 0;
> -}
> -
> -void get_hp_params_from_firmware(struct pci_dev *dev,
> -		struct hotplug_params *hpp)
> -{
> -	return;
> -}
> -
> -void get_hp_hw_control_from_firmware(struct pci_dev *dev)
> -{
> -	return;
> -}
> -
> --- 2.6-git-gregkh.orig/drivers/pci/hotplug/shpchprm_nonacpi.c
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -/*
> - * SHPCHPRM NONACPI: PHP Resource Manager for Non-ACPI/Legacy platform
> - *
> - * Copyright (C) 1995,2001 Compaq Computer Corporation
> - * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
> - * Copyright (C) 2001 IBM Corp.
> - * Copyright (C) 2003-2004 Intel Corporation
> - *
> - * All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or (at
> - * your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> - * NON INFRINGEMENT.  See the GNU General Public License for more
> - * details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - *
> - * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
> - *
> - */
> -
> -#include <linux/config.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/pci.h>
> -#include <linux/slab.h>
> -
> -#include "shpchp.h"
> -
> -int shpchprm_get_physical_slot_number(struct controller *ctrl, u32 *sun, u8 busnum, u8 devnum)
> -{
> -	int	offset = devnum - ctrl->slot_device_offset;
> -
> -	dbg("%s: ctrl->slot_num_inc %d, offset %d\n", __FUNCTION__, ctrl->slot_num_inc, offset);
> -	*sun = (u8) (ctrl->first_slot + ctrl->slot_num_inc * offset);
> -	return 0;
> -}
> -
> -void get_hp_params_from_firmware(struct pci_dev *dev,
> -		struct hotplug_params *hpp)
> -{
> -	return;
> -}
> -
> -void get_hp_hw_control_from_firmware(struct pci_dev *dev)
> -{
> -	return;
> -}
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Pcihpd-discuss mailing list
> Pcihpd-discuss@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/pcihpd-discuss
> 


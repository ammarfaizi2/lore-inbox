Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932739AbWCAAxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbWCAAxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWCAAxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:53:12 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:27054
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932739AbWCAAxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:53:11 -0500
Date: Tue, 28 Feb 2006 16:53:16 -0800
From: Greg KH <greg@kroah.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] pci hotplug: add common acpi functions to core
Message-ID: <20060301005316.GA3681@kroah.com>
References: <1141174017.28842.6.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141174017.28842.6.camel@whizzy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 04:46:57PM -0800, Kristen Accardi wrote:
> shpchprm_acpi.c and pciehprm_acpi.c are nearly identical.
> In addition, there are functions in both these files that
> are also in acpiphp_glue.c.  This patch will remove duplicate 
> functions from shpchp, pciehp, and acpiphp and move this 
> functionality to pci_hotplug, as it is not hardware specific.  
> Get rid of shpchprm* and pciehprm* files since they are no longer needed.
> shpchprm_nonacpi.c and pciehprm_nonacpi.c are identical, as well
> as shpchprm_legacy.c and can be replaced with a macro.

Looks good, only a minor comment:

> +u8 * acpi_path_name( acpi_handle	handle)

Funky spacing here.

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

The name "is_root_bridge" is pretty generic.  Especially as it wants an
acpi handle.  "acpi_is_root_bridge" perhaps?

thanks,

greg k-h

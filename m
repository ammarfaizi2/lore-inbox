Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVCSFP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVCSFP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 00:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVCSFP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 00:15:26 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:59484 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262412AbVCSFPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 00:15:01 -0500
Date: Fri, 18 Mar 2005 21:14:46 -0800
From: Greg KH <gregkh@suse.de>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: tony.luck@intel.com, len.brown@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [patch 07/12] Make the PCI remove routines safe for failed hot-plug
Message-ID: <20050319051446.GD21485@suse.de>
References: <20050318133856.A878@unix-os.sc.intel.com> <20050318141143.G1145@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318141143.G1145@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 02:11:44PM -0800, Rajesh Shah wrote:
> diff -puN drivers/pci/remove.c~pci-remove-device-hotplug-safe drivers/pci/remove.c
> --- linux-2.6.11-mm4-iohp/drivers/pci/remove.c~pci-remove-device-hotplug-safe	2005-03-16 13:07:22.667319764 -0800
> +++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/remove.c	2005-03-16 13:07:22.775718200 -0800
> @@ -26,17 +26,21 @@ static void pci_free_resources(struct pc
>  
>  static void pci_destroy_dev(struct pci_dev *dev)
>  {
> -	pci_proc_detach_device(dev);
> -	pci_remove_sysfs_dev_files(dev);
> -	device_unregister(&dev->dev);
> +	if (!list_empty(&dev->global_list)) {
> +		pci_proc_detach_device(dev);
> +		pci_remove_sysfs_dev_files(dev);
> +		device_unregister(&dev->dev);
> +		spin_lock(&pci_bus_lock);
> +		list_del(&dev->global_list);
> +		dev->global_list.next = dev->global_list.prev = NULL;
> +		spin_unlock(&pci_bus_lock);
> +	}
>  
>  	/* Remove the device from the device lists, and prevent any further
>  	 * list accesses from this device */
>  	spin_lock(&pci_bus_lock);
>  	list_del(&dev->bus_list);
> -	list_del(&dev->global_list);
>  	dev->bus_list.next = dev->bus_list.prev = NULL;
> -	dev->global_list.next = dev->global_list.prev = NULL;
>  	spin_unlock(&pci_bus_lock);
>  
>  	pci_free_resources(dev);

I did have a comment about this code at first glance, but in reviewing
it again, nevermind, it looks fine...

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbULUSoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbULUSoS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbULUSoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:44:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:5310 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261841AbULUSoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:44:08 -0500
Date: Tue, 21 Dec 2004 10:43:55 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export PCI resources in sysfs
Message-ID: <20041221184355.GB8557@kroah.com>
References: <200412210943.40101.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412210943.40101.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 09:43:39AM -0800, Jesse Barnes wrote:
>  int pci_create_sysfs_dev_files (struct pci_dev *pdev)
>  {
> +#ifdef HAVE_PCI_MMAP
> +	int i;
> +#endif
> +
>  	if (!sysfs_initialized)
>  		return -EACCES;
>  
> @@ -269,6 +300,31 @@
>  	else
>  		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
>  
> +#ifdef HAVE_PCI_MMAP
> +	/* Expose the PCI resources from this device as files */
> +	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
> +		struct bin_attribute *res_attr;
> +
> +		/* skip empty resources */
> +		if (!pci_resource_len(pdev, i))
> +			continue;
> +
> +		res_attr = kmalloc(sizeof(*res_attr) + 10, GFP_ATOMIC);
> +		if (res_attr) {
> +			pdev->res_attr[i] = res_attr;
> +			/* Allocated above after the res_attr struct */
> +			res_attr->attr.name = (char *)(res_attr + 1);
> +			sprintf(res_attr->attr.name, "resource%d", i);
> +			res_attr->size = pci_resource_len(pdev, i);
> +			res_attr->attr.mode = S_IRUSR | S_IWUSR;
> +			res_attr->attr.owner = THIS_MODULE;
> +			res_attr->mmap = pci_mmap_resource;
> +			res_attr->private = &pdev->resource[i];
> +			sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
> +		}
> +	}
> +#endif /* HAVE_PCI_MMAP */

How about wrapping these two #ifdef blocks into one function, and moving
it up in the file under the other #ifdef.  Do that for the other cleanup
function, and it will drop a bunch of #ifdefs.

thanks,

greg k-h

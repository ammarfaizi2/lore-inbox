Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVAMUaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVAMUaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVAMU1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:27:44 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:13048 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261675AbVAMUZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:25:39 -0500
Date: Thu, 13 Jan 2005 12:25:32 -0800
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] release_pcibus_dev() crash
Message-ID: <20050113202532.GA30780@kroah.com>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com> <1105638551.30960.16.camel@sinatra.austin.ibm.com> <20050113181850.GA24952@kroah.com> <200501131021.19434.jbarnes@engr.sgi.com> <20050113183729.GA25049@kroah.com> <1105647135.30960.22.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105647135.30960.22.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 02:12:15PM -0600, John Rose wrote:
> > So, does the patch below fix the problem for you?
> > (warning, not even compile tested)
> 
> Unfortunately, the class device attribute and pci_remove_legacy_files()
> are statically defined in probe.c.  The patch below augments yours to account
> for this.
> 
> This set of changes also fixes the crash.  I'll let you decide if explicitly
> cleaning up these files is worth exporting this stuff outside of probe.c.  
> Also, suggestions are welcome for a cleaner way to do this, I'm not totally
> comfortable with the ifdef's and inlines :)

Yeah, I don't think some of it is correct :)

> @@ -70,7 +70,7 @@ static void pci_remove_legacy_files(stru
>  }
>  #else /* !HAVE_PCI_LEGACY */
>  static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
> -static inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
> +inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
>  #endif /* HAVE_PCI_LEGACY */

Why make it inline?  I don't think that will work with gcc 4.

> -static CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);
> +CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);

That's fine with me.

>  /*
>   * PCI Bus Class
> @@ -95,10 +95,6 @@ static void release_pcibus_dev(struct cl
>  {
>  	struct pci_bus *pci_bus = to_pci_bus(class_dev);
>  
> -	pci_remove_legacy_files(pci_bus);
> -	class_device_remove_file(&pci_bus->class_dev,
> -				 &class_device_attr_cpuaffinity);
> -	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
>  	if (pci_bus->bridge)
>  		put_device(pci_bus->bridge);
>  	kfree(pci_bus);
> diff -puN drivers/pci/remove.c~01_release_pcibus_dev drivers/pci/remove.c
> --- 2_6_linus_2/drivers/pci/remove.c~01_release_pcibus_dev	2005-01-13 13:42:39.000000000 -0600
> +++ 2_6_linus_2-johnrose/drivers/pci/remove.c	2005-01-13 13:47:18.000000000 -0600
> @@ -61,15 +61,18 @@ int pci_remove_device_safe(struct pci_de
>  }
>  EXPORT_SYMBOL(pci_remove_device_safe);
>  
> -void pci_remove_bus(struct pci_bus *b)
> +void pci_remove_bus(struct pci_bus *pci_bus)
>  {
> -	pci_proc_detach_bus(b);
> +	pci_proc_detach_bus(pci_bus);
>  
>  	spin_lock(&pci_bus_lock);
> -	list_del(&b->node);
> +	list_del(&pci_bus->node);
>  	spin_unlock(&pci_bus_lock);
> -
> -	class_device_unregister(&b->class_dev);
> +	pci_remove_legacy_files(pci_bus);
> +	class_device_remove_file(&pci_bus->class_dev,
> +		&class_device_attr_cpuaffinity);
> +	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
> +	class_device_unregister(&pci_bus->class_dev);
>  }
>  EXPORT_SYMBOL(pci_remove_bus);
>  
> diff -puN include/linux/pci.h~01_release_pcibus_dev include/linux/pci.h
> --- 2_6_linus_2/include/linux/pci.h~01_release_pcibus_dev	2005-01-13 13:53:28.000000000 -0600
> +++ 2_6_linus_2-johnrose/include/linux/pci.h	2005-01-13 13:58:06.000000000 -0600

No, put these in drivers/pci/pci.h instead.

Care to redo this?

thanks,

greg k-h

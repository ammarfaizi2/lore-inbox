Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWDJRrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWDJRrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWDJRrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:47:08 -0400
Received: from smtp1.oregonstate.edu ([128.193.0.11]:25533 "EHLO
	smtp1.oregonstate.edu") by vger.kernel.org with ESMTP
	id S1751161AbWDJRrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:47:06 -0400
Date: Mon, 10 Apr 2006 07:41:49 -0700
From: Greg KH <greg@kroah.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, mochel@linux.intel.com,
       len.brown@intel.com, ACPI <linux-acpi@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] memory hotplug : change phys_device to symbolic [1/2]
Message-ID: <20060410144149.GA15186@kroah.com>
References: <20060410182052.f5c0a444.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410182052.f5c0a444.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 06:20:52PM +0900, KAMEZAWA Hiroyuki wrote:
> This patch changes memoryX/phys_device to symbolic link.
> 
> This phys_device always contains 0 now, and of no use.
> 
> This patch changes it to symbolic link. acpi memohotplug is changed to support
> this.
> 
> When this is applied, phys_device becomes meaningful.
> ==
> [kamezawa@casares ~]$ readlink /sys/devices/system/memory/memory10/phys_device
> ../../../../firmware/acpi/namespace/ACPI/_SB/LSB1/MEM2
> 
> ==
> I posted previous version in Feb/2006.
> Several changes to acpi_memhotplug.c in these days simplified acpi part of
> this patch :) This patch is against 2.6.17-rc1-mm2.
> 
> Note:
> There looks no code to make symbolic link to acpi namespace now. But this patch 
> will not bother Patrick-san's acpi refactoring work now goes on. 
> (I asked him , he answerd if enough simple.)
> 
> [1/2] includes sysfs changes.
> [2/2] includes acpi memhoplug changes.
> 
> Thanks,
> -Kame
> 
> Now, memory device 's sysfs entry (/sys/devices/system/memory/memoryX)
> has phys_device file. Now, it contains just an integer.
> But it is always 0.
> 
> The purpose of phys_device is to show relationship between memory section
> and physical ram device. But to show relationship, we have to maintain
> a table phys_device number <-> device.
> 
> This patch changes phys_device file to symbolic link to the device.
> By this, phys_device directly points to a physical device to which it
> belongs to.
> 
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> Index: linux-2.6.17-rc1-mm2/drivers/base/memory.c
> ===================================================================
> --- linux-2.6.17-rc1-mm2.orig/drivers/base/memory.c	2006-04-10 15:48:17.000000000 +0900
> +++ linux-2.6.17-rc1-mm2/drivers/base/memory.c	2006-04-10 15:50:19.000000000 +0900
> @@ -252,31 +252,33 @@
>  	return count;
>  }
>  
> -/*
> - * phys_device is a bad name for this.  What I really want
> - * is a way to differentiate between memory ranges that
> - * are part of physical devices that constitute
> - * a complete removable unit or fru.
> - * i.e. do these ranges belong to the same physical device,
> - * s.t. if I offline all of these sections I can then
> - * remove the physical device?
> - */
> -static ssize_t show_phys_device(struct sys_device *dev, char *buf)
> -{
> -	struct memory_block *mem =
> -		container_of(dev, struct memory_block, sysdev);
> -	return sprintf(buf, "%d\n", mem->phys_device);
> -}
>  
>  static SYSDEV_ATTR(phys_index, 0444, show_mem_phys_index, NULL);
>  static SYSDEV_ATTR(state, 0644, show_mem_state, store_mem_state);
> -static SYSDEV_ATTR(phys_device, 0444, show_phys_device, NULL);
>  
>  #define mem_create_simple_file(mem, attr_name)	\
>  	sysdev_create_file(&mem->sysdev, &attr_##attr_name)
>  #define mem_remove_simple_file(mem, attr_name)	\
>  	sysdev_remove_file(&mem->sysdev, &attr_##attr_name)
>  
> +static int attach_phys_device(struct memory_block *mem, struct kobject *kobj)
> +{
> +	int ret;
> +	ret = sysfs_create_link(&mem->sysdev.kobj, kobj, "phys_device");
> +	if (ret)
> +		return ret;
> +	mem->phys_device = kobj;

mem->phys_device = kobject_get(kobj);
is probably better, as you are storing a pointer to a kobject, so you
need to increment its reference count.

> +static void remove_phys_device(struct memory_block *mem)
> +{
> +	if (mem->phys_device) {
> +		sysfs_remove_link(&mem->sysdev.kobj, "phys_device");
> +		mem->phys_device = NULL;

kobject_put(mem->phys_device);
mem->phys_device = NULL;

is a better way to do this.

And yes, the sysfs_create_link() function does increment the reference
count of the kobject, but it's better to be safe :)

thanks,

greg k-h

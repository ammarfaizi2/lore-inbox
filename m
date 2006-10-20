Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946135AbWJTD1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946135AbWJTD1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946141AbWJTD1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:27:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:55271 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1946135AbWJTD1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:27:37 -0400
Date: Thu, 19 Oct 2006 20:26:24 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [PATCH] Add device addition/removal notifier
Message-ID: <20061020032624.GA7620@kroah.com>
References: <1161309350.10524.119.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161309350.10524.119.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 11:55:50AM +1000, Benjamin Herrenschmidt wrote:
> @@ -608,12 +615,14 @@ void device_del(struct device * dev)
>  	device_remove_groups(dev);
>  	device_remove_attrs(dev);
>  
> +	bus_remove_device(dev);
>  	/* Notify the platform of the removal, in case they
>  	 * need to do anything...
>  	 */
>  	if (platform_notify_remove)
>  		platform_notify_remove(dev);
> -	bus_remove_device(dev);
> +	blocking_notifier_call_chain(&device_notifier, DEVICE_NOTIFY_DEL_DEV,
> +				     dev);

Why did you move the call to bus_remove_device() to be before the
platform_notify_remove() and notifier is called?

And I don't think this is really going to work well.  You have created a
notifier for all devices in the system, right?  How do you know what
type of struct device is being passed to your notifier callback?  At
least with the platform callback, you knew it was a platform device :)



>  	device_pm_remove(dev);
>  	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
>  	kobject_del(&dev->kobj);
> @@ -836,3 +845,15 @@ int device_rename(struct device *dev, ch
>  
>  	return error;
>  }
> +
> +int register_device_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&device_notifier, nb);
> +}
> +EXPORT_SYMBOL(register_device_notifier);
> +
> +int unregister_device_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&device_notifier, nb);
> +}
> +EXPORT_SYMBOL(unregister_device_notifier);

All driver core exports should be _GPL() please.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTH1Vp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTH1VpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:45:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18192 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264322AbTH1VpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:45:22 -0400
Date: Thu, 28 Aug 2003 22:45:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PCI PM & compatibility
Message-ID: <20030828224510.H14031@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg KH <greg@kroah.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030826185147.H28810@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308271523490.4140-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308271523490.4140-100000@cherise>; from mochel@osdl.org on Wed, Aug 27, 2003 at 03:57:14PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 03:57:14PM -0700, Patrick Mochel wrote:
> Bah, sorry, I overlooked that. The patch below will add the device before 
> calling bus_add_device(). Sorry about the confusion. 

For the record, this patch solves the problem, thanks.

> ===== drivers/base/core.c 1.73 vs edited =====
> --- 1.73/drivers/base/core.c	Fri Aug 15 10:27:01 2003
> +++ edited/drivers/base/core.c	Wed Aug 27 15:49:08 2003
> @@ -225,28 +225,30 @@
>  		dev->kobj.parent = &parent->kobj;
>  
>  	if ((error = kobject_add(&dev->kobj)))
> -		goto register_done;
> -
> -	/* now take care of our own registration */
> -
> +		goto Error;
> +	if ((error = device_pm_add(dev)))
> +		goto PMError;
> +	if ((error = bus_add_device(dev)))
> +		goto BusError;
>  	down_write(&devices_subsys.rwsem);
>  	if (parent)
>  		list_add_tail(&dev->node,&parent->children);
>  	up_write(&devices_subsys.rwsem);
>  
> -	bus_add_device(dev);
> -
> -	device_pm_add(dev);
> -
>  	/* notify platform of device entry */
>  	if (platform_notify)
>  		platform_notify(dev);
> -
> - register_done:
> -	if (error && parent)
> -		put_device(parent);
> + Done:
>  	put_device(dev);
>  	return error;
> + BusError:
> +	device_pm_remove(dev);
> + PMError:
> +	kobject_unregister(&dev->kobj);
> + Error:
> +	if (parent)
> +		put_device(parent);
> +	goto Done;
>  }
>  
>  
> @@ -312,8 +314,6 @@
>  {
>  	struct device * parent = dev->parent;
>  
> -	device_pm_remove(dev);
> -
>  	down_write(&devices_subsys.rwsem);
>  	if (parent)
>  		list_del_init(&dev->node);
> @@ -324,14 +324,11 @@
>  	 */
>  	if (platform_notify_remove)
>  		platform_notify_remove(dev);
> -
>  	bus_remove_device(dev);
> -
> +	device_pm_remove(dev);
>  	kobject_del(&dev->kobj);
> -
>  	if (parent)
>  		put_device(parent);
> -
>  }
>  
>  /**
> 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


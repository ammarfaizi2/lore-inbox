Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbTAGVem>; Tue, 7 Jan 2003 16:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbTAGVem>; Tue, 7 Jan 2003 16:34:42 -0500
Received: from havoc.daloft.com ([64.213.145.173]:14270 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266464AbTAGVek>;
	Tue, 7 Jan 2003 16:34:40 -0500
Date: Tue, 7 Jan 2003 16:43:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: mochel@osdl.org
Subject: Re: net devices: Get network devices to show up in sysfs.
Message-ID: <20030107214315.GA23011@gtf.org>
References: <200301072106.h07L63v29621@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301072106.h07L63v29621@hera.kernel.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 07:50:37PM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.838.151.11, 2003/01/06 13:50:37-06:00, mochel@osdl.org
> 
> 	net devices: Get network devices to show up in sysfs.
> 	
> 	- declare net_subsys, and register during net_dev_init().
> 	- Add kobject to struct net_device.
> 	- initialize name and register in register_netdevice().
> 	- remove in unregister_netdevice().
> 	
> diff -Nru a/include/linux/netdevice.h b/include/linux/netdevice.h
> --- a/include/linux/netdevice.h	Tue Jan  7 13:06:05 2003
> +++ b/include/linux/netdevice.h	Tue Jan  7 13:06:05 2003
> @@ -28,6 +28,7 @@
>  #include <linux/if.h>
>  #include <linux/if_ether.h>
>  #include <linux/if_packet.h>
> +#include <linux/kobject.h>
>  
>  #include <asm/atomic.h>
>  #include <asm/cache.h>
> @@ -438,6 +439,9 @@
>  	/* this will get initialized at each interface type init routine */
>  	struct divert_blk	*divert;
>  #endif /* CONFIG_NET_DIVERT */
> +
> +	/* generic object representation */
> +	struct kobject kobj;
>  };

Just curious, is this needed purely for reference counting, or mainly to
hook into sysfs?  If the former, net devices already have reference
counting, so I want to make sure kobjects do not run afoul of that.



> +static struct subsystem net_subsys;
> +
>  
>  /*******************************************************************************
>  
> @@ -2545,7 +2547,10 @@
>  	notifier_call_chain(&netdev_chain, NETDEV_REGISTER, dev);
>  
>  	net_run_sbin_hotplug(dev, "register");
> -	ret = 0;
> +
> +	snprintf(dev->kobj.name,KOBJ_NAME_LEN,dev->name);
> +	kobj_set_kset_s(dev,net_subsys);
> +	ret = kobject_register(&dev->kobj);

If the return code matters, shouldn't you be checking for its success?


> @@ -2671,6 +2676,8 @@
>  		goto out;
>  	}
>  
> +	kobject_unregister(&dev->kobj);
> +

...especially if kobject_register failed above

	Jeff




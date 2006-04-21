Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWDURZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWDURZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 13:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWDURZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 13:25:25 -0400
Received: from hera.kernel.org ([140.211.167.34]:12500 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932112AbWDURZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 13:25:24 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Hotplug race on name change
Date: Fri, 21 Apr 2006 10:25:03 -0700
Organization: OSDL
Message-ID: <20060421102503.4e44eb28@localhost.localdomain>
References: <20060418042300.GA11061@kroah.com>
	<20060418042345.GB11061@kroah.com>
	<44448DFF.3080108@ums.usu.ru>
	<20060418153951.GC30485@kroah.com>
	<4445BB0F.6010305@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1145640304 2274 10.8.0.54 (21 Apr 2006 17:25:04 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 21 Apr 2006 17:25:04 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This:
> Without that patch, there is a race when registering network interfaces 
> and renaming it with udev rules, because initially the "address" in 
> sysfs doesn't contain useful data. See 
> http://marc.theaimsgroup.com/?t=114460338900002&r=1&w=2
> 
> Breaking the recommended way of assigning persistent network interface 
> names is, IMHO, a bug serious enough to be fixed in -stable.
> 
> Signed-off-by: Alexander E. Patrakov <patrakov@ums.usu.ru>
> 
> ---
> 
> --- linux-2.6.16.5/net/core/dev.c
> +++ linux-2.6.16.5/net/core/dev.c
> @@ -2932,11 +2932,11 @@
>  
>  		switch(dev->reg_state) {
>  		case NETREG_REGISTERING:
> +			dev->reg_state = NETREG_REGISTERED;
>  			err = netdev_register_sysfs(dev);
>  			if (err)
>  				printk(KERN_ERR "%s: failed sysfs registration (%d)\n",
>  				       dev->name, err);
> -			dev->reg_state = NETREG_REGISTERED;
>  			break;
>  
>  		case NETREG_UNREGISTERING:

Introduces new races in netdev_register_sysfs if the name changes, because
netdev_register_sysfs runs without RTNL at this point. So if some application gets
in and changes the device name while netdev_register_sysfs is running, then
the class_dev->class_id would end up not matching the netdevice->name.

Not a big issue since, hotplug doesn't get run until the device is registered.
Ideally, it would be possible to create the groups in the class device before it
was registered. It won't work with existing class device interface.

I am working on a patch to extend class_device to allow the creation of groups
to be atomic (like the attributes are).

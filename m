Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUI0R3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUI0R3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUI0R3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:29:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:20684 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266807AbUI0R3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:29:16 -0400
Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices
From: Stephen Hemminger <shemminger@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nico Schottelius <nico-kernel@schottelius.org>
In-Reply-To: <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost>
Content-Type: text/plain
Organization: Open Source Development Lab
Date: Mon, 27 Sep 2004 10:29:13 -0700
Message-Id: <1096306153.1729.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 00:51 +0200, Jesper Juhl wrote:
> Hi,
> 
> Here's a patch that adds a new sysfs attribute for net devices. The new 
> attribute 'carrier' exposes the result of netif_carrier_ok() so that when 
> a network device has carrier the attribute value is 1 and when there is no 
> carrier the attribute value is 0.
> Very rellevant attribute for network devices in my oppinion, and sysfs is 
> the logical place for it.
> 
> I've tested this only on my own machine, but I get the expected results:
> 
> With network cable plugged into eth0 : 
> 
> juhl@dragon:~$ cat /sys/class/net/eth0/carrier
> 1
> juhl@dragon:~$
> 
> With network cable unplugged : 
> 
> juhl@dragon:~$ cat /sys/class/net/eth0/carrier
> 0
> juhl@dragon:~$
> 
> Please review and consider applying.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -u linux-2.6.9-rc2-bk5-orig/net/core/net-sysfs.c linux-2.6.9-rc2-bk5/net/core/net-sysfs.c
> --- linux-2.6.9-rc2-bk5-orig/net/core/net-sysfs.c	2004-09-14 23:19:53.000000000 +0200
> +++ linux-2.6.9-rc2-bk5/net/core/net-sysfs.c	2004-09-27 00:24:01.000000000 +0200
> @@ -126,8 +126,21 @@
>  	return -EINVAL;
>  }
>  
> +static ssize_t show_carrier(struct class_device *dev, char *buf)
> +{
> +	struct net_device *net = to_net_dev(dev);
> +	if (netif_running(net)) {
> +		if (netif_carrier_ok(net))
> +			return snprintf(buf, 3, "%d\n", 1);
> +		else
> +			return snprintf(buf, 3, "%d\n", 0);

Using snprintf in this way is kind of silly. since buffer is PAGESIZE.
The most concise format of this would be:
	return sprintf(buf, dec_fmt, !!netif_carrier_ok(dev));




> +	}
> +	return -EINVAL;
> +}
> +
>  static CLASS_DEVICE_ATTR(address, S_IRUGO, show_address, NULL);
>  static CLASS_DEVICE_ATTR(broadcast, S_IRUGO, show_broadcast, NULL);
> +static CLASS_DEVICE_ATTR(carrier, S_IRUGO, show_carrier, NULL);
>  
>  /* read-write attributes */
>  NETDEVICE_SHOW(mtu, fmt_dec);
> @@ -186,6 +199,7 @@
>  	&class_device_attr_type,
>  	&class_device_attr_address,
>  	&class_device_attr_broadcast,
> +	&class_device_attr_carrier,
>  	NULL
>  };
>  


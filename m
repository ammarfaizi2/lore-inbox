Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUI1TXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUI1TXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 15:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbUI1TXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 15:23:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:24294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267746AbUI1TWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 15:22:54 -0400
Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices - try 2.
From: Stephen Hemminger <shemminger@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nico Schottelius <nico-kernel@schottelius.org>,
       Paulo Marques <pmarques@grupopie.com>,
       Martin Waitz <tali@admingilde.org>
In-Reply-To: <Pine.LNX.4.61.0409282118340.2729@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost>
	 <1096306153.1729.2.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0409281316191.22088@jjulnx.backbone.dif.dk>
	 <Pine.LNX.4.61.0409282118340.2729@dragon.hygekrogen.localhost>
Content-Type: text/plain
Organization: Open Source Development Lab
Date: Tue, 28 Sep 2004 12:22:47 -0700
Message-Id: <1096399367.21799.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 21:23 +0200, Jesper Juhl wrote:
> On Tue, 28 Sep 2004, Jesper Juhl wrote:
> 
> > On Mon, 27 Sep 2004, Stephen Hemminger wrote:
> > 
> > > Date: Mon, 27 Sep 2004 10:29:13 -0700
> > > From: Stephen Hemminger <shemminger@osdl.org>
> > > To: Jesper Juhl <juhl-lkml@dif.dk>
> > > Cc: linux-kernel <linux-kernel@vger.kernel.org>,
> > >     Nico Schottelius <nico-kernel@schottelius.org>
> > > Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices
> > > 
> > > On Mon, 2004-09-27 at 00:51 +0200, Jesper Juhl wrote:
> > > >  
> > > > +static ssize_t show_carrier(struct class_device *dev, char *buf)
> > > > +{
> > > > +	struct net_device *net = to_net_dev(dev);
> > > > +	if (netif_running(net)) {
> > > > +		if (netif_carrier_ok(net))
> > > > +			return snprintf(buf, 3, "%d\n", 1);
> > > > +		else
> > > > +			return snprintf(buf, 3, "%d\n", 0);
> > > 
> > > Using snprintf in this way is kind of silly. since buffer is PAGESIZE.
> > > The most concise format of this would be:
> > > 	return sprintf(buf, dec_fmt, !!netif_carrier_ok(dev));
> > > 
> > 
> > I see your point and I'll create a new patch this evening when I get home 
> > from work.
> > Thank you for your feedback.
> > 
> 
> Here's a second try at a patch to properly implement a 'carrier' sysfs 
> attribute for net devices.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -u linux-2.6.9-rc2-bk14-orig/net/core/net-sysfs.c linux-2.6.9-rc2-bk14/net/core/net-sysfs.c
> --- linux-2.6.9-rc2-bk14-orig/net/core/net-sysfs.c	2004-09-14 23:19:53.000000000 +0200
> +++ linux-2.6.9-rc2-bk14/net/core/net-sysfs.c	2004-09-28 19:37:45.000000000 +0200
> @@ -126,8 +126,18 @@
>  	return -EINVAL;
>  }
>  
> +static ssize_t show_carrier(struct class_device *dev, char *buf)
> +{
> +	struct net_device *netdev = to_net_dev(dev);
> +	if (netif_running(netdev)) {
> +		return sprintf(buf, fmt_dec, !!netif_carrier_ok(netdev));
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
> @@ -186,6 +196,7 @@
>  	&class_device_attr_type,
>  	&class_device_attr_address,
>  	&class_device_attr_broadcast,
> +	&class_device_attr_carrier,
>  	NULL
>  };

Looks great, it kind of shows how easy sysfs is but how baroque it is as
well.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbUKXPZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbUKXPZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUKXPXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:23:43 -0500
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:17050
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S262749AbUKXPVO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:21:14 -0500
Date: Wed, 24 Nov 2004 10:21:06 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Ian Campbell <icampbell@arcom.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: "deadlock" between smc91x driver and link_watch
In-Reply-To: <1101290297.10841.15.camel@icampbell-debian>
Message-ID: <Pine.LNX.4.61.0411241014160.8946@xanadu.home>
References: <1101230194.14370.12.camel@icampbell-debian> 
 <20041123153158.6f20a7d7.akpm@osdl.org>  <1101289309.10841.9.camel@icampbell-debian>
  <20041124014650.47af8ae4.akpm@osdl.org> <1101290297.10841.15.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Ian Campbell wrote:

> Quite right. Fixed patch included.

Small question:

> + * smc_phy_configure_wq
> + *
> + * The net_device is referenced when the work was scheduled to avoid
> + * the need for a flush_scheduled_work() in smc_close(). Drop the
> + * reference and then do the configuration.

You probably want to invert the comment here too.

> +static void smc_phy_configure_wq(void *data)
> +{
> +	struct net_device *dev = data;
> +	smc_phy_configure(data);
> +	dev_put(dev);
> +}

[...]

> @@ -1536,10 +1553,8 @@
>  	/* clear everything */
>  	smc_shutdown(dev);
>  
> -	if (lp->phy_type != 0) {
> -		flush_scheduled_work();
> +	if (lp->phy_type != 0)
>  		smc_phy_powerdown(dev, lp->mii.phy_id);


How do you ensure that smc_phy_configure() can't end up being called 
after smc_phy_powerdown() here?


Nicolas

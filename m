Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263716AbTKDGBD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 01:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTKDGBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 01:01:03 -0500
Received: from out1.mx.nwbl.wi.voyager.net ([169.207.3.119]:42178 "EHLO
	out1.mx.nwbl.wi.voyager.net") by vger.kernel.org with ESMTP
	id S263716AbTKDGBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 01:01:00 -0500
Message-ID: <3FA7418B.3A6F83BF@megsinet.net>
Date: Tue, 04 Nov 2003 00:04:59 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test8 ISAPNP ne.c initialization
References: <Pine.LNX.4.10.10009211329001.1627-100000@penguin.transmeta.com> <3F97596F.3E1A6F23@megsinet.net> <20031103234311.GE16854@neo.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:
> 
> How about something like this? (untested)

I had the same reservation with re-ordering inits...

Removed my patch, added this one, compiled and booted; works for me.

Thanks,
Martin

> 
> The patch removes the legacy probing function from dev.c and gives it its
> own initcall later in the cycle.  Any testing would be appreciated.  I
> also have some patches that update the probing code in some of these
> drivers so that they don't have to use legacy techniques but they need
> to be updated to test9.  This fix is probably the least intrusive.
> 
> --- a/drivers/net/Space.c       2003-10-25 18:42:56.000000000 +0000
> +++ b/drivers/net/Space.c       2003-11-01 22:15:01.000000000 +0000
> @@ -422,7 +422,7 @@
>  extern int loopback_init(void);
> 
>  /*  Statically configured drivers -- order matters here. */
> -void __init probe_old_netdevs(void)
> +int __init net_olddevs_init(void)
>  {
>         int num;
> 
> @@ -450,8 +450,12 @@
>  #ifdef CONFIG_LTPC
>         ltpc_probe();
>  #endif
> +
> +       return 0;
>  }
> 
> +device_initcall(net_olddevs_init);
> +
>  /*
>   * The @dev_base list is protected by @dev_base_lock and the rtln
>   * semaphore.
> --- a/include/linux/netdevice.h 2003-10-25 18:44:45.000000000 +0000
> +++ b/include/linux/netdevice.h 2003-11-01 22:11:04.000000000 +0000
> @@ -494,7 +494,6 @@
>  extern struct net_device               *dev_base;              /* All devices */
>  extern rwlock_t                                dev_base_lock;          /* Device list lock */
> 
> -extern void            probe_old_netdevs(void);
>  extern int                     netdev_boot_setup_add(char *name, struct ifmap *map);
>  extern int                     netdev_boot_setup_check(struct net_device *dev);
>  extern struct net_device    *dev_getbyhwaddr(unsigned short type, char *hwaddr);
> --- a/net/core/dev.c    2003-10-25 18:43:39.000000000 +0000
> +++ b/net/core/dev.c    2003-11-02 16:10:51.000000000 +0000
> @@ -3007,8 +3007,6 @@
> 
>         dev_boot_phase = 0;
> 
> -       probe_old_netdevs();
> -
>         open_softirq(NET_TX_SOFTIRQ, net_tx_action, NULL);
>         open_softirq(NET_RX_SOFTIRQ, net_rx_action, NULL);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWJZHUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWJZHUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 03:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWJZHUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 03:20:06 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:16145 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751759AbWJZHUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 03:20:03 -0400
Date: Thu, 26 Oct 2006 09:20:19 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Damien Wyart <damien.wyart@free.fr>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Linux 2.6.19-rc3
Message-Id: <20061026092019.5ca9f706.khali@linux-fr.org>
In-Reply-To: <453F8FEA.7040909@intel.com>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061025132534.df8466c0.khali@linux-fr.org>
	<20061025120155.GA2436@localhost.localdomain>
	<453F8FEA.7040909@intel.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Auke,

On Wed, 25 Oct 2006 09:25:14 -0700, Auke Kok wrote:
> Damien Wyart wrote:
> > > > Auke Kok (1):
> > > >       e100: fix reboot -f with netconsole enabled
> > 
> > * Jean Delvare <khali@linux-fr.org> [2006-10-25 13:25]: This one breaks
> > > power-off and reboot on my laptop (thanks to git bisect for isolating
> > > it). The shutdown freezes after "Shutdown: hda" or "Rebooting".
> > > SysRq-p says the CPU is idle. If you need additional information on my
> > > config or want me to do more tests, just ask.
> > 
> > This has already been discussed, a fix has been posted (see recent
> > netdev messages) and should be pulled soon into mainline (I guess).
> 
> for those interested, here's the fix (which is already pushed to jgarzik)
> 
> diff --git a/drivers/net/e100.c b/drivers/net/e100.c
> index d4a2572..815eb29 100644
> --- a/drivers/net/e100.c
> +++ b/drivers/net/e100.c
> @@ -2719,7 +2719,10 @@ static int e100_suspend(struct pci_dev *
>   	struct net_device *netdev = pci_get_drvdata(pdev);
>   	struct nic *nic = netdev_priv(netdev);
> 
> -	netif_poll_disable(nic->netdev);
> +#ifdef CONFIG_E100_NAPI
> +	if (netif_running(netdev))
> +		netif_poll_disable(nic->netdev);
> +#endif
>   	del_timer_sync(&nic->watchdog);
>   	netif_carrier_off(nic->netdev);
> 
> @@ -2763,7 +2766,10 @@ static void e100_shutdown(struct pci_dev
>   	struct net_device *netdev = pci_get_drvdata(pdev);
>   	struct nic *nic = netdev_priv(netdev);
> 
> -	netif_poll_disable(nic->netdev);
> +#ifdef CONFIG_E100_NAPI
> +	if (netif_running(netdev))
> +		netif_poll_disable(nic->netdev);
> +#endif
>   	del_timer_sync(&nic->watchdog);
>   	netif_carrier_off(nic->netdev);

The patch above had some formating problems, but after fixing that I
could apply it and I confirm it fixes my problem. Thanks!

-- 
Jean Delvare

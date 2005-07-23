Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVGWJPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVGWJPM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 05:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVGWJPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 05:15:12 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:46829 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261637AbVGWJPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 05:15:09 -0400
Date: Sat, 23 Jul 2005 13:14:55 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Harald Welte <laforge@netfilter.org>, David Miller <davem@davemloft.net>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 1 Wire drivers illegally overload NETLINK_NFLOG
Message-ID: <20050723091455.GA12015@2ka.mipt.ru>
References: <20050723125427.GA11177@rama>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20050723125427.GA11177@rama>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 23 Jul 2005 13:14:56 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2005 at 08:54:27AM -0400, Harald Welte (laforge@netfilter.org) wrote:
> Hi Dave,
> Hi Evgeniy,
> 
> the following patch fixes the illegal use of NETLINK_NFLOG by the
> 1wire drivers.  It assumes that the netlink tap families can now safely
> be reclaimed, which is the case according to Dave at netconf'05.
> 
> I'm not sure who would be the right person to fix this, but this patch
> needs to go into both 2.6.12.x and 2.6.13 trees, since it potentially
> causes a security problem by preventing the iptables ULOG

Yep.
Actually w1 uses it only for simple event notifications, 
which definitely will be replaced with connector stuff...

So I woulf like to ask Dave about it, and if network people are still 
against it, I have no objection against this patch.
But I sould definitely prefer to move all such simple events into separate
event bus.

> This has been the third new piece of code that reuses NETLINK_NFLOG
> within a couple of months.  I would really appreciate if people would
> actually ask/apply for a new protocol number instead of just overloading
> existing values and thereby causing breakage.  

I even know who added it... :)

I still have question opened about message bus and connector.
Andrew has no objection against connector and it lives in -mm
quite long time, although was several time removed due to GregKH i2c
tree changes. All objections against it was only type of - "I do not like it"
Dmitry had some bugfixes which were added.
It was tested under quite heavy load on different types of systems
without overhead (with CBUS) and with _very_ convenient way of
controlling kernelspace from userspace and reverse event bus.


> Thanks,
> 	Harald
> 
> -- 
> - Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
> ============================================================================
>   "Fragmentation is like classful addressing -- an interesting early
>    architectural error that shows how much experimentation was going
>    on while IP was being designed."                    -- Paul Vixie

> Give the 1-wire driver stack its own netlink protocol number, instead of
> overloading NETLINK_NFLOG.
> 
> I wonder what I have done to people, that they always overload the
> NETLINK_NFLOG protocol number and thereby effectively prevent the packet
> filter logging mechanism.  Please don't re-use protocol numbers.
> 
> Signed-off-by: Harald Welte <laforge@netfilter.org>
> 
> ---
> commit b4a566c332048b642506eff7de825fce710ff42c
> tree 07ef162f6d449dd67c586c9c63680004787b86c5
> parent d5d3fb40b6db511dbd47a84634a1249de6b7b297
> author laforge <laforge@netfilter.org> Sa, 23 Jul 2005 08:41:24 -0400
> committer laforge <laforge@netfilter.org> Sa, 23 Jul 2005 08:41:24 -0400
> 
>  drivers/w1/w1_int.c     |    4 ++--
>  include/linux/netlink.h |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
> --- a/drivers/w1/w1_int.c
> +++ b/drivers/w1/w1_int.c
> @@ -88,10 +88,10 @@ static struct w1_master * w1_alloc_dev(u
>  
>  	dev->groups = 23;
>  	dev->seq = 1;
> -	dev->nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
> +	dev->nls = netlink_kernel_create(NETLINK_W1, NULL);
>  	if (!dev->nls) {
>  		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
> -			NETLINK_NFLOG, dev->dev.bus_id);
> +			NETLINK_W1, dev->dev.bus_id);
>  	}
>  
>  	err = device_register(&dev->dev);
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -20,7 +20,7 @@
>  #define NETLINK_IP6_FW		13
>  #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
>  #define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
> -#define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
> +#define NETLINK_W1		16	/* 16 to 31 are ethertap */
>  
>  #define MAX_LINKS 32		
>  




-- 
	Evgeniy Polyakov

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269388AbUI3SY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269388AbUI3SY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269398AbUI3SWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:22:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39917 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269399AbUI3SWR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:22:17 -0400
Message-ID: <415C4EC5.4040603@pobox.com>
Date: Thu, 30 Sep 2004 14:21:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Franz Pletz <franz_pletz@t-online.de>, Michal Rokos <michal@rokos.info>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2.6] Natsemi - remove compilation warnings
References: <200409230958.31758.michal@rokos.info> <200409231618.56861.michal@rokos.info> <415C37D8.20203@t-online.de> <Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 30 Sep 2004, Franz Pletz wrote:
> 
>>It seems like your patch unfortunately went into 2.6.9-rc2-mm[3,4] and 
>>2.6.9-rc3.
> 
> 
> It's definitely not in _my_ -rc3. Which kernel are you looking at?
> 
> 
>>My Natsemi network card stops working with 2.6.9-rc3. After succesfully 
>>revoking your patch from 
>>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm3/broken-out/natsemi-remove-compilation-warnings.patch
>>everything works fine.
> 
> 
> That patch does indeed look totally bogus. The reason a lot of network

<blink> <blink> <blink>  This patch is so bogus its laffable.  I think 
akpm forgot his coffee, I know he's smarter than that :)


> drivers complain about readl/writel is that "struct net_device" is very
> confused about what the IO addresses mean, and they mean different things
> for different users. Which makes type safety basically disappear, and now
> that we check it more carefully, things break.
> 
> This patch should clean up natsemi.c a bit, and makes the warnings go 
> away. Does it work for you? (It really should, it's just a basic 
> search-and-replace fix).
> 
> This is bigger than the broken patch, but that's really pretty
> unavoidable, unless "struct net_device" is fixed. And the way it's
> structured, if "net_device" ever _is_ fixed, this driver will now be
> trivially updated.
> 
> 		Linus
> 
> ----
> ===== drivers/net/natsemi.c 1.68 vs edited =====
> --- 1.68/drivers/net/natsemi.c	2004-07-27 11:18:53 -07:00
> +++ edited/drivers/net/natsemi.c	2004-09-30 10:22:44 -07:00
> @@ -719,7 +719,7 @@
>  };
>  
>  static void move_int_phy(struct net_device *dev, int addr);
> -static int eeprom_read(long ioaddr, int location);
> +static int eeprom_read(void __iomem *ioaddr, int location);
>  static int mdio_read(struct net_device *dev, int reg);
>  static void mdio_write(struct net_device *dev, int reg, u16 data);
>  static void init_phy_fixup(struct net_device *dev);
> @@ -769,9 +769,15 @@
>  static int netdev_get_regs(struct net_device *dev, u8 *buf);
>  static int netdev_get_eeprom(struct net_device *dev, u8 *buf);
>  
> +static inline void __iomem *ns_ioaddr(struct net_device *dev)
> +{
> +	return (void __iomem *) dev->base_addr;
> +}
> +

hmmmm.  Since dev->base_addr gets exported to userspace, I don't think 
it's that quick/easy to change.

Wouldn't it be better to just phase out the base of dev->base_addr 
completely?  I tend to prefer adding a "void __iomem *regs" to struct 
netdev_private, and ignore dev->base_addr completely.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965333AbWHOJ0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbWHOJ0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965334AbWHOJ0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:26:05 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:12760 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S965333AbWHOJ0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:26:01 -0400
Date: Tue, 15 Aug 2006 11:25:52 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Jiri Benc <jbenc@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Message-ID: <20060815092551.GA17881@ojjektum.uhulinux.hu>
References: <20050427124911.6212670f@griffin.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427124911.6212670f@griffin.suse.cz>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Recently I had similar problems as you described below, that's how I 
found your email. (My exact problem is that there's no link when I plug 
in a cable, reloading the driver a few times usually helps.)
The problem is, that since you made the patch, the uli526x driver has 
been split out from the tulip driver.
Do you know anything about the current state of the uli526x driver 
regarding the problems you tried patch?

Thanks in advance,
Balazs Pozsar



On Wed, Apr 27, 2005 at 12:49:11PM +0200, Jiri Benc wrote:
> With integrated ALi/ULi M5261 ethernet controller using tulip driver,
> autonegotation doesn't work and card is forced to 10 Mbps half-duplex mode.
> 
> I found two problems with tulip driver regarding ULi5261.
> 
> 1. In tulip_up() media selection does not work properly. No media from
> EEPROM media list is set as default in ULi's EEPROM. In such case tulip
> driver searches for first non-fullduplex media.
> 
> I have no idea why the search is not performed for MII capable media first.
> Maybe because of problems with some other cards?
> 
> EEPROM media list is reported to be as follows:
> 
> tulip0:  EEPROM default media type Autosense.
> tulip0:  MII interface PHY 1, setup/reset sequences 0/2 long, capabilities 00 01.
> tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
> tulip0:  Index #1 - Media 10baseT (#0) described by a <unknown> (128) block.
> tulip0:  Index #2 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
> tulip0:  Index #3 - Media 10base2 (#1) described by a 21140 non-MII (0) block.
> tulip0:  Index #4 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
> tulip0:  Index #5 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
> 
> I added code that performs search for MII capable media in case of ULi5261
> card. Shouldn't it be performed generally?
> 
> 2. PHY chip DM9161E used on my M5261 seems to claim (in BMCR register) that
> autonegotiation is enabled after initialization, but it needs to set
> BMCR_ANRESTART for autonegotiation to work. Without forcing of restart of
> autonegotiation, MII_LPA returns always 0.
> 
> Is there any way to detect that DM9161E is used? It may be used with another
> ethernet cards (and there may be another PHY used in M5261 as well), so
> restarting autonegotiation in case of ULi5261 doesn't seem to be
> a solution.
> 
> The only way I see is to always restart autonegotiation in tulip_find_mii().
> It probably has the side-effect that other cards with autonegotiation
> enabled by default will perform autonegotiation twice.
> 
> Thanks for your suggestions.
> 
> 
> --- linux-2.6.12-rc3/drivers/net/tulip/media.c
> +++ linux-2.6.12-rc3-patched/drivers/net/tulip/media.c
> @@ -517,10 +517,11 @@ void __devinit tulip_find_mii (struct ne
>  		/* Enable autonegotiation: some boards default to off. */
>  		if (tp->default_port == 0) {
>  			new_bmcr = mii_reg0 | BMCR_ANENABLE;
> -			if (new_bmcr != mii_reg0) {
> -				new_bmcr |= BMCR_ANRESTART;
> -				ane_switch = 1;
> -			}
> +			/* DM9161E PHY seems to need to restart
> +			 * autonegotiation even if it defaults to enabled.
> +			 */
> +			new_bmcr |= BMCR_ANRESTART;
> +			ane_switch = 1;
>  		}
>  		/* ...or disable nway, if forcing media */
>  		else {
> --- linux-2.6.12-rc3/drivers/net/tulip/tulip_core.c
> +++ linux-2.6.12-rc3-patched/drivers/net/tulip/tulip_core.c
> @@ -383,6 +383,11 @@ static void tulip_up(struct net_device *
>  				goto media_picked;
>  			}
>  	}
> +	if (tp->chip_id == ULI526X) {
> +		for (i = tp->mtable->leafcount - 1; i >= 0; i--)
> +			if (tulip_media_cap[tp->mtable->mleaf[i].media] & MediaIsMII)
> +				goto media_picked;
> +	}
>  	/* Start sensing first non-full-duplex media. */
>  	for (i = tp->mtable->leafcount - 1;
>  		 (tulip_media_cap[tp->mtable->mleaf[i].media] & MediaAlwaysFD) && i > 0; i--)
> 
> 
> --
> Jiri Benc
> SUSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
pozsy

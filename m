Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWEHQ2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWEHQ2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWEHQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:28:33 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:30347 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751082AbWEHQ2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:28:33 -0400
In-Reply-To: <20060508160531.GA2131@digi.com>
References: <20060508160531.GA2131@digi.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FA22B12D-5910-4EE9-A351-6AB770330AFC@freescale.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Victor <andrew@sanpeople.com>
Content-Transfer-Encoding: 7bit
From: Andy Fleming <afleming@freescale.com>
Subject: Re: LXT971 driver in the phy lib
Date: Mon, 8 May 2006 11:22:47 -0500
To: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 8, 2006, at 11:05, Uwe Zeisberger wrote:

> Hello,
>
> I try to get an network interface running that has an LXT971A[1].
>
> If I apply the following patch, the target can detect the phy.
>
> diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
> index bef79e4..4c66fac 100644
> --- a/drivers/net/phy/lxt.c
> +++ b/drivers/net/phy/lxt.c
> @@ -137,9 +137,9 @@ static struct phy_driver lxt970_driver =
>  };
>
>  static struct phy_driver lxt971_driver = {
> -	.phy_id		= 0x0001378e,
> +	.phy_id		= 0x001378e0,
>  	.name		= "LXT971",
> -	.phy_id_mask	= 0x0fffffff,
> +	.phy_id_mask	= 0xfffffff0,
>  	.features	= PHY_BASIC_FEATURES,
>  	.flags		= PHY_HAS_INTERRUPT,
>  	.config_aneg	= genphy_config_aneg,


This looks good.

>
> According to
>
> 	http://www.intel.com/design/network/products/LAN/datashts/ 
> 24941402.pdf
>
> page 90f the id registers yield 0x001378eX (with X being current
> revision ID)
>
> 	uzeisberger@io:~/gsrc/linux-2.6$ git grep -i 1378e drivers/net/
> 	drivers/net/arm/at91_ether.h:#define MII_LXT971A_ID     0x001378E0
> 	drivers/net/e1000/e1000_hw.h:#define L1LXT971A_PHY_ID   0x001378E0
> 	drivers/net/fec.c:      .id = 0x0001378e,
> 	drivers/net/fec_8xx/fec_mii.c:   .id = 0x0001378e,
> 	drivers/net/phy/lxt.c:  .phy_id         = 0x0001378e,

The fec.c and fec_mii.c drivers used a shift by 4 to chop off the end  
of the ID.  When the PHY Layer switched to using a mask, not all of  
the drivers got properly switched.

>
> So both variants occur more than once.  (I only took a quick glance at
> the usage of these ids, but I think they all use it in the same way.
> That is, ID1 << 16 | ID2.)

The fec-style drivers do this:

         if(phy_info[i]->id == (fep->phy_id >> 4))

Anyway, your patch is correct.

>
> "My" phy reports 0x001378e2 and now I wonder if there are different
> chips out there with the same name.
>
> Can anybody explain this mismatch to me?  (Or point me to the right
> query for google.)



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265784AbUFSODq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUFSODq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 10:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUFSODq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 10:03:46 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:21442 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265760AbUFSODo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 10:03:44 -0400
Date: Sat, 19 Jun 2004 15:55:51 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Brian Lazara <blazara@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew de Quincey <adq@lidskialf.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new device support for forcedeth.c second try
Message-ID: <20040619155551.A1517@electric-eye.fr.zoreil.com>
References: <40D43DC3.9000909@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40D43DC3.9000909@gmx.net>; from c-d.hailfinger.kernel.2004@gmx.net on Sat, Jun 19, 2004 at 03:21:07PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> :
[...]
> +static int phy_reset(struct net_device *dev)
> +{
> +	struct fe_priv *np = get_nvpriv(dev);
> +	u32 miicontrol;
> +	u32 microseconds = 0;
> +	u32 milliseconds = 0;
> +
> +	miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
> +	miicontrol |= BMCR_RESET;
> +	if (mii_rw(dev, np->phyaddr, MII_BMCR, miicontrol)) {
> +		return -1;
> +	}
> +
> +	//wait for 500ms
> +	mdelay(500);
> +
> +	//must wait till reset is deasserted
> +	while (miicontrol & BMCR_RESET) {
> +		udelay(NV_MIIBUSY_DELAY);
> +		miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
> +		microseconds++;
> +		if (microseconds == 20) {
> +			microseconds = 0;
> +			milliseconds++;
> +		}
> +		if (milliseconds > 50)
> +			return -1;
> +	}
> +	return 0;
> +}

Afaiks this function is not called from a spinlocked nor is it time-critical.
You should make it use schedule_timeout().

--
Ueimor

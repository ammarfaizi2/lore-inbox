Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264766AbUD1Mjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbUD1Mjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 08:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbUD1Mjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 08:39:36 -0400
Received: from chiapa.terra.com.br ([200.154.55.224]:42977 "EHLO
	chiapa.terra.com.br") by vger.kernel.org with ESMTP id S264766AbUD1Mja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 08:39:30 -0400
Message-ID: <408FA6B3.1000805@terra.com.br>
Date: Wed, 28 Apr 2004 09:42:27 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Andy Lutomirski <luto@myrealbox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH r8169] ethtool support and sane speed selection/detection
References: <20040424050931.14C341D4F@luto.stanford.edu>
In-Reply-To: <20040424050931.14C341D4F@luto.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Andy,

Andy Lutomirski wrote:
> +static void rtl8169_set_speed(struct net_device *dev,
> +			      u8 autoneg, u16 speed, u8 duplex)
> +{
> +	struct rtl8169_private *tp = dev->priv;
> +	void *ioaddr = tp->mmio_addr;
> +	unsigned long flags;
> +	u8 status;
> +
> +	int auto_nego, giga_ctrl;
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +
> +	status = RTL_R8(PHYstatus);
> +	if ((status & TBI_Enable) && autoneg == AUTONEG_DISABLE) {
> +		autoneg = AUTONEG_ENABLE;
> +		printk(KERN_WARNING PFX
> +		       "%s: ignoring request to force speed in TBI mode\n",
> +		       dev->name);
> +	}
> +
> +	auto_nego = mdio_read(ioaddr, PHY_AUTO_NEGO_REG);
> +	auto_nego &= ~(PHY_Cap_10_Half | PHY_Cap_10_Full |
> +		       PHY_Cap_100_Half | PHY_Cap_100_Full);
> +	giga_ctrl = mdio_read(ioaddr, PHY_1000_CTRL_REG);
> +	giga_ctrl &= ~(PHY_Cap_1000_Full | PHY_Cap_Null);
> +
> +	if (autoneg == AUTONEG_ENABLE) {
> +		auto_nego |= (PHY_Cap_10_Half | PHY_Cap_10_Full |
> +			      PHY_Cap_100_Half | PHY_Cap_100_Full);
> +		giga_ctrl |= PHY_Cap_1000_Full;
> +	} else {
> +		if (speed == SPEED_10)
> +			auto_nego |= PHY_Cap_10_Half | PHY_Cap_10_Full;
> +		else if (speed == SPEED_100)
> +			auto_nego |= PHY_Cap_100_Half | PHY_Cap_100_Full;
> +
> +		if (speed == SPEED_1000)
> +			giga_ctrl |= PHY_Cap_1000_Full;
> +		else
> +			giga_ctrl |= PHY_Cap_Null;
> +
> +		if (duplex == DUPLEX_HALF)
> +			auto_nego &= ~(PHY_Cap_10_Full | PHY_Cap_100_Full);
> +	}
> +
> +	tp->phy_auto_nego_reg = auto_nego;
> +	tp->phy_1000_ctrl_reg = giga_ctrl;
> +
> +	if(!(status & TBI_Enable)) {
> +		mdio_write(ioaddr, PHY_AUTO_NEGO_REG, auto_nego);
> +		mdio_write(ioaddr, PHY_1000_CTRL_REG, giga_ctrl);
> +	}
> +
> +	mdio_write(ioaddr, PHY_CTRL_REG,
> +		   PHY_Enable_Auto_Nego | PHY_Restart_Auto_Nego);
> +
> +	if (tp->if_up && (giga_ctrl & PHY_Cap_1000_Full))
> +		mod_timer(&tp->timer, jiffies + RTL8169_PHY_TIMEOUT);
> +
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +}
> +

	I think you can use the mii's interface here..

	Please look 8139cp's way of doind this. Using that interface is much 
cleaner and doesn't duplicate code.

> +static int rtl8169_get_settings(struct net_device *dev,
> +				   struct ethtool_cmd *cmd)
> +{
> +	struct rtl8169_private *tp = dev->priv;
> +	void *ioaddr = tp->mmio_addr;
> +	u8 status = RTL_R8(PHYstatus);

	IMHO you should hold the device lock here (tp->lock).

> +	cmd->supported = SUPPORTED_10baseT_Half |
> +			 SUPPORTED_10baseT_Full |
> +			 SUPPORTED_100baseT_Half |
> +			 SUPPORTED_100baseT_Full |
> +			 SUPPORTED_1000baseT_Full |
> +			 SUPPORTED_Autoneg |
> +		         SUPPORTED_TP;
> +
> +	cmd->autoneg = 1;
> +	cmd->advertising = ADVERTISED_TP | ADVERTISED_Autoneg;
> +	if (tp->phy_auto_nego_reg & PHY_Cap_10_Half)
> +		cmd->advertising |= ADVERTISED_10baseT_Half;
> +	if (tp->phy_auto_nego_reg & PHY_Cap_10_Full)
> +		cmd->advertising |= ADVERTISED_10baseT_Full;
> +	if (tp->phy_auto_nego_reg & PHY_Cap_100_Half)
> +		cmd->advertising |= ADVERTISED_100baseT_Half;
> +	if (tp->phy_auto_nego_reg & PHY_Cap_100_Full)
> +		cmd->advertising |= ADVERTISED_100baseT_Full;
> +	if (tp->phy_1000_ctrl_reg & PHY_Cap_1000_Full)
> +		cmd->advertising |= ADVERTISED_1000baseT_Full;
> +
> +	if (status & _1000bpsF) cmd->speed = SPEED_1000;
> +	else if (status & _100bps) cmd->speed = SPEED_100;
> +	else if (status & _10bps) cmd->speed = SPEED_10;
> +
> +	if (status & _1000bpsF || status & FullDup)
> +		cmd->duplex = DUPLEX_FULL;
> +	else
> +		cmd->duplex = DUPLEX_HALF;
> +
> +	return 0;
> +}

	You should use mii's interface on this. There's no need to duplicate 
code.	Please use mii_ethtool_gset here.

	Also rtl8169_set_settings should use mii_ethtool_sset. If the card gets 
a LinkChg interrupt you should treat with mii_check_media at 
rtl8169_set_settings.

	Cheers,

Felipe

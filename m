Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264836AbUD1PZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264836AbUD1PZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 11:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264859AbUD1PZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 11:25:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18823 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264836AbUD1PZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 11:25:08 -0400
Message-ID: <408FCCC3.4050704@pobox.com>
Date: Wed, 28 Apr 2004 11:24:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
CC: Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH r8169] ethtool support and sane speed selection/detection
References: <20040424050931.14C341D4F@luto.stanford.edu> <408FA6B3.1000805@terra.com.br>
In-Reply-To: <408FA6B3.1000805@terra.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe W Damasio wrote:
>     Hi Andy,
> 
> Andy Lutomirski wrote:
> 
>> +static void rtl8169_set_speed(struct net_device *dev,
>> +                  u8 autoneg, u16 speed, u8 duplex)
>> +{
>> +    struct rtl8169_private *tp = dev->priv;
>> +    void *ioaddr = tp->mmio_addr;
>> +    unsigned long flags;
>> +    u8 status;
>> +
>> +    int auto_nego, giga_ctrl;
>> +
>> +    spin_lock_irqsave(&tp->lock, flags);
>> +
>> +    status = RTL_R8(PHYstatus);
>> +    if ((status & TBI_Enable) && autoneg == AUTONEG_DISABLE) {
>> +        autoneg = AUTONEG_ENABLE;
>> +        printk(KERN_WARNING PFX
>> +               "%s: ignoring request to force speed in TBI mode\n",
>> +               dev->name);
>> +    }
>> +
>> +    auto_nego = mdio_read(ioaddr, PHY_AUTO_NEGO_REG);
>> +    auto_nego &= ~(PHY_Cap_10_Half | PHY_Cap_10_Full |
>> +               PHY_Cap_100_Half | PHY_Cap_100_Full);
>> +    giga_ctrl = mdio_read(ioaddr, PHY_1000_CTRL_REG);
>> +    giga_ctrl &= ~(PHY_Cap_1000_Full | PHY_Cap_Null);
>> +
>> +    if (autoneg == AUTONEG_ENABLE) {
>> +        auto_nego |= (PHY_Cap_10_Half | PHY_Cap_10_Full |
>> +                  PHY_Cap_100_Half | PHY_Cap_100_Full);
>> +        giga_ctrl |= PHY_Cap_1000_Full;
>> +    } else {
>> +        if (speed == SPEED_10)
>> +            auto_nego |= PHY_Cap_10_Half | PHY_Cap_10_Full;
>> +        else if (speed == SPEED_100)
>> +            auto_nego |= PHY_Cap_100_Half | PHY_Cap_100_Full;
>> +
>> +        if (speed == SPEED_1000)
>> +            giga_ctrl |= PHY_Cap_1000_Full;
>> +        else
>> +            giga_ctrl |= PHY_Cap_Null;
>> +
>> +        if (duplex == DUPLEX_HALF)
>> +            auto_nego &= ~(PHY_Cap_10_Full | PHY_Cap_100_Full);
>> +    }
>> +
>> +    tp->phy_auto_nego_reg = auto_nego;
>> +    tp->phy_1000_ctrl_reg = giga_ctrl;
>> +
>> +    if(!(status & TBI_Enable)) {
>> +        mdio_write(ioaddr, PHY_AUTO_NEGO_REG, auto_nego);
>> +        mdio_write(ioaddr, PHY_1000_CTRL_REG, giga_ctrl);
>> +    }
>> +
>> +    mdio_write(ioaddr, PHY_CTRL_REG,
>> +           PHY_Enable_Auto_Nego | PHY_Restart_Auto_Nego);
>> +
>> +    if (tp->if_up && (giga_ctrl & PHY_Cap_1000_Full))
>> +        mod_timer(&tp->timer, jiffies + RTL8169_PHY_TIMEOUT);
>> +
>> +    spin_unlock_irqrestore(&tp->lock, flags);
>> +}
>> +
> 
> 
>     I think you can use the mii's interface here..
> 
>     Please look 8139cp's way of doind this. Using that interface is much 
> cleaner and doesn't duplicate code.


Unfortunately mii_xxx doesn't do gigabit ethernet and GMII...

	Jeff




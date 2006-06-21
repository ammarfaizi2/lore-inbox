Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWFUUtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWFUUtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWFUUtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:49:04 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:5765
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932278AbWFUUtA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:49:00 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 1/3] PAL: Support of the fixed PHY
Date: Wed, 21 Jun 2006 22:48:27 +0200
User-Agent: KMail/1.9.1
References: <20060621160950.4860.92979.stgit@vitb.ru.mvista.com>
In-Reply-To: <20060621160950.4860.92979.stgit@vitb.ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606212248.27836.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 June 2006 18:09, Vitaly Bordug wrote:

> +static int fixed_mdio_update_regs(struct fixed_info *fixed)
> +{
> +	u16 *regs = fixed->regs;
> +	u16 bmsr = 0;
> +	u16 bmcr = 0;
> +
> +	if(!regs) {
> +		printk(KERN_ERR "%s: regs not set up", __FUNCTION__);
> +		return -1;

-EINVAL perhaps?

> +static int fixed_mdio_register_device(int number, int speed, int duplex)
> +{
> +	struct mii_bus *new_bus;
> +	struct fixed_info *fixed;
> +	struct phy_device *phydev;
> +	int err = 0;
> +
> +	struct device* dev = kzalloc(sizeof(struct device), GFP_KERNEL);
> +
> +	if (NULL == dev)
> +		return -EINVAL;

-ENOMEM here.

> +	new_bus = kzalloc(sizeof(struct mii_bus), GFP_KERNEL);
> +
> +	if (NULL == new_bus) {
> +		kfree(dev);
> +		return -ENOMEM;
> +	}
> +	fixed = fixed_ptr = kzalloc(sizeof(struct fixed_info), GFP_KERNEL);
> +
> +	if (NULL == fixed) {
> +		kfree(dev);
> +		kfree(new_bus);
> +		return -ENOMEM;
> +	}
> +
> +	fixed->regs = kzalloc(MII_REGS_NUM*sizeof(int), GFP_KERNEL);
> +
> +	if (NULL == fixed->regs) {
> +		kfree(dev);
> +		kfree(new_bus);
> +		kfree (fixed);
> +		return -ENOMEM;
> +	}
> +
> +	fixed->regs_num = MII_REGS_NUM;
> +	fixed->phy_status.speed = speed;
> +	fixed->phy_status.duplex = duplex;
> +	fixed->phy_status.link = 1;
> +
> +	new_bus->name = "Fixed MII Bus",
> +	new_bus->read = &fixed_mii_read,
> +	new_bus->write = &fixed_mii_write,
> +	new_bus->reset = &fixed_mii_reset,
> +
> +	/*set up workspace*/
> +	fixed_mdio_update_regs(fixed);
> +	new_bus->priv = fixed;
> +
> +	new_bus->dev = dev;
> +	dev_set_drvdata(dev, new_bus);
> +
> +	/* create phy_device and register it on the mdio bus */
> +	phydev = phy_device_create(new_bus, 0, 0);
> +
> +	/*
> +	 Put the phydev pointer into the fixed pack so that bus read/write code could be able
> +	 to access for instance attached netdev. Well it doesn't have  to do so, only in case
> +	 of utilizing user-specified link-update...
> +	 */
> +	fixed->phydev = phydev;
> +
> +	if (IS_ERR(phydev)) {
> +		err = PTR_ERR(-ENOMEM);
> +		goto bus_register_fail;
> +	}
> +
> +	phydev->irq = -1;
> +	phydev->dev.bus = &mdio_bus_type;
> +
> +	if(number)
> +		snprintf(phydev->dev.bus_id, BUS_ID_SIZE,
> +				"fixed_%d@%d:%d", number, speed, duplex);
> +	else
> +		snprintf(phydev->dev.bus_id, BUS_ID_SIZE,
> +				"fixed@%d:%d", speed, duplex);
> +	phydev->bus = new_bus;
> +
> +	err = device_register(&phydev->dev);
> +	if(err) {
> +		printk(KERN_ERR "Phy %s failed to register\n",
> +				phydev->dev.bus_id);
> +		goto bus_register_fail;
> +	}
> +
> +	/*
> +	   the mdio bus has phy_id match... In order not to do it
> +	   artificially, we are binding the driver here by hand;
> +	   it will be the same
> +	   for all the fixed phys anyway.
> +	 */
> +	down_write(&phydev->dev.bus->subsys.rwsem);
> +
> +	phydev->dev.driver = &fixed_mdio_driver.driver;
> +
> +	err = phydev->dev.driver->probe(&phydev->dev);
> +	if(err < 0) {
> +		printk(KERN_ERR "Phy %s: problems with fixed driver\n",
> +				phydev->dev.bus_id);
> +		up_write(&phydev->dev.bus->subsys.rwsem);
> +		goto bus_register_fail;

Probably need some additional error unwinding code.
Of doesn't device_register() have to be reverted?
What about phy_device_create()?

> +	}
> +
> +	device_bind_driver(&phydev->dev);
> +	up_write(&phydev->dev.bus->subsys.rwsem);
> +
> +	return 0;
> +
> +bus_register_fail:
> +	kfree(dev);
> +	kfree (fixed);
> +	kfree(new_bus);
> +
> +	return err;
> +}

-- 
Greetings Michael.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbUKLABk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbUKLABk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbUKKX72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:59:28 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:26791 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262428AbUKKX4m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:56:42 -0500
Date: Fri, 12 Nov 2004 00:54:39 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jason McMullan <jason.mcmullan@timesys.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] MII bus API for PHY devices
Message-ID: <20041111235439.GB13327@electric-eye.fr.zoreil.com>
References: <20041111224845.GA12646@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111224845.GA12646@jmcmullan.timesys>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason McMullan <jason.mcmullan@timesys.com> :
[...]
> --- /dev/null
> +++ linux/drivers/net/mii_bus.c
[...]
> +struct phy_cmd {
> +    u32 mii_reg;
> +    u32 mii_data;
> +    u16 (*funct) (u16 mii_reg, int bus, int id);
   ^^^^

-> spaces

[...]
> +    /* Local state information */
> +    struct {
> +	int irq;
> +	unsigned long msecs;
> +	void (*func)(void *data);
> +	void *data;
> +    	struct work_struct tq;
> +	struct timer_list timer;
   ^^^^^

-> tab...

> +    } delta;
   ^^^^

-> ...spaces

[...]
> +/* Write value to the PHY for this device to the register at regnum, */
> +/* waiting until the write is done before it returns.  All PHY */
> +/* configuration has to be done through the TSEC1 MIIM regs */
> +EXPORT_SYMBOL(mii_bus_write);
> +int mii_bus_write(int bus, int id, int regnum, uint16_t value)
                                                  ^^^^^^^^
-> the code of this file has already used some u16/u32 before this point.

> +{
> +	if (!VALID_BUS(bus))
> +		return -EINVAL;
> +
> +       	mii_bus[bus]->write(mii_bus[bus]->priv,id,regnum,value);
   ^^^^^^^^^^^^^

-> spaces instead of tab
-> please add a space after a colon

-> AFAIKS, the code guarantees that VALID_BUS will not fail.

> +	return 0;
> +}
> +
> +/* Reads from register regnum in the PHY for device dev, */
> +/* returning the value.  Clears miimcom first.  All PHY */
> +/* configuration has to be done through the TSEC1 MIIM regs */
> +EXPORT_SYMBOL(mii_bus_read);
> +int mii_bus_read(int bus, int id, int regnum)
> +{
> +	if (!VALID_BUS(bus))
> +		return -EINVAL;
> +
> +       	return mii_bus[bus]->read(mii_bus[bus]->priv,id,regnum);

-> see above.

[...]
> +#define BRIEF_MII_ERRORS
> +/* Wait for auto-negotiation to complete */
> +u16 mii_parse_sr(u16 mii_reg, int bus, int id)
> +{
> +	unsigned int timeout = MII_TIMEOUT;
> +	struct phy_state *pstate;
> +
> +	if (!VALID(bus, id)) return 0xffff;

-> the return on a separate line only costs an extra character
   and makes the style more consistent (see the code above).

[...]
> +u16 mii_parse_cis8201(u16 mii_reg, int bus, int id)
> +{
> +	unsigned int speed;
> +	struct phy_state *pstate;
> +
> +	if (!VALID(bus, id)) return 0xffff;
> +	pstate = &mii_bus[bus]->phy[id]->state;
> +
> +	if (pstate->link) {
> +		if (mii_reg & MIIM_CIS8201_AUXCONSTAT_DUPLEX)
> +			pstate->duplex = 1;
> +		else
> +			pstate->duplex = 0;

-> If you are really concerned about the size of the source code:
		pstate->duplex =
			(mii_reg & MIIM_CIS8201_AUXCONSTAT_DUPLEX) ? 1 : 0;
> +	NULL
> +};
> +
> +/* Use the PHY ID registers to determine what type of PHY is attached
> + * to device dev.  return a struct phy_info structure describing that PHY
> + */
> +struct phy_info *mii_phy_get_info(int bus, int id)
> +{
> +	u16 phy_reg;
> +	u32 phy_ID;
> +	int i;
> +	struct phy_info *theInfo = NULL;

-> s/theInfo/info/ ?


> +	if (mii_bus[bus] == NULL)
> +		return NULL;

-> This function is not exported and the caller has already
   issued a VALID_BUS.

[...]
> +	/* loop through all the known PHY types, and find one that */
> +	/* matches the ID we read from the PHY. */
> +	for (i = 0; phy_info[i]; i++)
> +		if (phy_info[i]->id == (phy_ID >> phy_info[i]->shift))
> +			theInfo = phy_info[i];

-> add braces around the for block + break ?

> +
> +	if (theInfo == NULL) {
> +		printk("phy %d.%d: PHY id 0x%x is not supported!\n", bus, id, phy_ID);
> +		return NULL;

-> no need to return here.

> +	} else {
> +		printk("phy %d.%d: PHY is %s (%x)\n", bus, id, theInfo->name,
> +		       phy_ID);
> +	}
> +
> +	return theInfo;
> +}
[...]
> +int mii_phy_attach(struct mii_if_info *mii, struct net_device *dev, int bus, int id)
> +{
> +	struct phy_info *phy,*info;
> +
> +	if (mii_bus[bus] == NULL) {
> +		printk(KERN_ERR "mii_phy_attach: Can't attach %s, no MII bus %d present\n",dev->name,bus);
> +		return -ENODEV;
> +	}
> +
> +	if (VALID(bus,id)) {
> +		printk(KERN_ERR "mii_phy_attach: PHY %d.%d is already attached to %s\n",bus,id,dev->name);
> +		return -EBUSY;
> +	}
> +
> +	info = mii_phy_get_info(bus, id);
> +	if (info == NULL)
> +		return -ENODEV;
> +
> +	phy = kmalloc(sizeof(*phy), GFP_KERNEL);
> +	memcpy(phy,info,sizeof(*phy));

-> kmalloc can fail.

[...]
> +int mii_bus_register(struct mii_bus *bus)
> +{
> +	int bus_id;
> +
> +	if (bus == NULL || bus->name == NULL || bus->read == NULL ||
> +	    bus->write == NULL)
> +		return -EINVAL;
[...]
> +	mii_bus[bus_id] = bus;
> +
> +	if (mii_bus[bus_id] == NULL) {

-> bus is not NULL, neither is mii_bus[bus_id] (see above).

> +		up(&mii_bus_lock);
> +		return -EINVAL;
> +	}
> +
> +	if (mii_bus[bus_id]->reset)
> +		mii_bus[bus_id]->reset(mii_bus[bus_id]->priv);

	if (bus->reset)
		bus->reset(bus->priv);

Please, pretty please, more polish (I did not say that it could
be done instantly :o) ).

--
Ueimor

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVAMGZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVAMGZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVAMGZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:25:53 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:47375 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261168AbVAMGZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:25:27 -0500
Date: Thu, 13 Jan 2005 07:15:22 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Radheka Godse <radheka.godse@intel.com>
Cc: bonding-devel@lists.sourceforge.net, fubar@us.ibm.com,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bonding-devel] [PATCH] Support to configure multiple bonds with different module params
Message-ID: <20050113061522.GI7048@alpha.home.local>
References: <Pine.LNX.4.61.0501131630550.18721@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0501131630550.18721@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Radheka,

On Thu, Jan 13, 2005 at 05:46:34PM -0800, Radheka Godse wrote:
> The attached patches add support to the channel bonding module for 
> configuring multiple bonds at load time.
> This eliminates the need to reload the module for each new 
> differently-configured bond. A maximum of 16 bonds is supported.

This is very good news. I've been hoping for this for a long time (since 2.2)
but never found time to implement it. I might try to backport this to 2.4 if
I find some time.

I just have a few comments on the code, which are not problems at all, but
which could be cleaned up before merging :
  - there are a few changes that you made for debugging purpose that were
    left in (see below)
  - some tabs have been randomly replaced with spaces, possibly because of
    some copy-paste (see below too). We often try to avoid this because it
    later annoys people who post new patches. I think that the simplest
    way to fix this would be to replace leading spaces with tabs (vi/sed)
    and visually check for the resulting indentation.

Overall, I'm very interested in this work. And BTW, I really appreciate
that you took the time to fix quite a number of typos in the documentation.

Thanks,
Willy

PS: see below for comments.

>  #ifdef BONDING_DEBUG
>  #define dprintk(fmt, args...) \
> -	printk(KERN_DEBUG     \
> +	printk(KERN_ERR     \
>  	       DRV_NAME ": %s() %d: " fmt, __FUNCTION__, __LINE__ , ## args )

here : KERN_ERR ?

> @@ -203,6 +210,8 @@
>  	struct   bond_params params;
>  	struct   list_head vlan_list;
>  	struct   vlan_group *vlgrp;
> +	u32	 my_ip;
> +        struct   kobject kobj;

here: mixed spaces and tabs

> +#define BOND_PARAM_STR(X, S, D) \
> +        static char __initdata *X[BOND_MAX_UNITS +1] = BOND_PARAM_INIT(D); \
> +	static int num_##X; \
> +	module_param_array(X, charp, &num_##X, 0); \
> +	MODULE_PARM_DESC(X, S);

here: mixed spaces and tabs

  	if (bond->slave_cnt == 0) {
> +            dprintk("last slave removed\n");
>  		/* if the last slave was removed, zero the mac address

here: mixed spaces and tabs

> @@ -3146,6 +3186,8 @@
>  {
>  	struct bonding *bond = seq->private;
>  	struct slave *curr;
> +        int i;
> +	u32 target;

here: mixed spaces and tabs

>  
>  	read_lock(&bond->curr_slave_lock);
>  	curr = bond->curr_active_slave;
> @@ -3170,6 +3212,24 @@
>  	seq_printf(seq, "Down Delay (ms): %d\n",
>  		   bond->params.downdelay * bond->params.miimon);
>  
> +       
> +        // ARP information
> +        if(bond->params.arp_interval > 0)
> +	{

here: mixed spaces and tabs

> -	dprintk("bond_ioctl: master=%s, cmd=%d\n",
> -		bond_dev->name, cmd);
> +//	dprintk("bond_ioctl: master=%s, cmd=%d\n",
> +//		bond_dev->name, cmd);

here : debug code commented out. This was already debug anyway. If it's too
verbose, perhaps it should be removed ?

> +	struct bonding *bond;
> +        bond = bond_dev->priv;

here: mixed spaces and tabs

> +		struct net_device *bond_dev;
> +    int res;

here: mixed spaces and tabs

> +
> +    bond_dev = alloc_netdev(sizeof(struct bonding), name, ether_setup);
> +		if (!bond_dev) {

here: mixed spaces and tabs

> +        printk(KERN_ERR "eek! can't alloc netdev!\n");
> +        return -ENOMEM;
> +		}

here: mixed spaces and tabs

> +
> +		/* bond_init() must be called after dev_alloc_name() (for the
> +		 * /proc files), but before register_netdevice(), because we
> +		 * need to set function pointers.
> +		 */
> +    
> +    res = bond_init(bond_dev, params);
> +		if (res < 0) {
> +			free_netdev(bond_dev);
> +          return res;
> +		}
> +

here: mixed spaces and tabs

> +		SET_MODULE_OWNER(bond_dev);
> +
> +		res = register_netdevice(bond_dev);
> +		if (res < 0) {
> +			bond_deinit(bond_dev);
> +			free_netdev(bond_dev);
> +          return res;
> +		}

here: mixed spaces and tabs

> +    if (newbond) *newbond = bond_dev->priv;
> +    return res;
> +}

here: mixed spaces and tabs

> +	{
> +		//printk(KERN_ERR"Freeing bond %s\n", bond->dev->name);
> +		bond_destroy_dev(bond->dev);
> +        }

here: mixed spaces and tabs

> +        
> +        // set input values 
> +	if(miimon[position] != BOND_LINK_MON_INTERV)
> +        {

here: mixed spaces and tabs

> +        if(use_carrier[position] != BOND_DEF_USE_CARRIER)
> +	        params->use_carrier = use_carrier[position];
> +        if(updelay[position] != BOND_DEF_DELAY)
> +	        params->updelay = updelay[position];
> +        if(downdelay[position] != BOND_DEF_DELAY)
> +	        params->downdelay = downdelay[position];

here: mixed spaces and tabs
  
> -	There is no limit.
> +	Up to 16 max bond devices can be created and configured 
> +        by specifying commandline options to modprobe. 

here: mixed spaces and tabs

That's all.


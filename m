Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVCaAnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVCaAnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVCaAnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:43:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49110 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262675AbVCaAj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:39:29 -0500
Message-ID: <424B46AF.6080205@pobox.com>
Date: Wed, 30 Mar 2005 19:39:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dbrownell@users.sourceforge.net, gregkh@suse.de
Subject: Re: [PATCH] USB: pegasus uses netif_msg_*() filters
References: <200503302318.j2UNImZh019630@hera.kernel.org>
In-Reply-To: <200503302318.j2UNImZh019630@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2181.4.70, 2005/03/24 15:30:57-08:00, david-b@pacbell.net
> 
> 	[PATCH] USB: pegasus uses netif_msg_*() filters
> 	
> 	This updates the messaging for the pegasus driver:
> 	
> 	  - Use driver model diagnostics or printk using the interface name
> 	    for all diagnostic messages ... not dbg()/warn()/err().
> 	
> 	  - Almost everywhere, use the netif_msg_XXX() macros to check the
> 	    message control bitmask maintained by ethtool.  The default mask
> 	    is initialized using a new "message_level" module parameter.
> 	
> 	Also:
> 	
> 	  - Removes the needless PEGASUS_RUNNING flag, replacing it with the
> 	    standard netdevice mechanism.
> 	
> 	  - Cleaner access for unaligned values.  Not all processors spend
> 	    silicon to support them like x86 does.
> 	
> 	  - Adds a few "sparse" fixes.
> 	
> 	  - Saves the return values for the requests that manipulate chip
> 	    registers ... doesn't yet check them, but at least anyone looking
> 	    at the code (e.g. to find out why the link check task is wedged...)
> 	    will see where those failure modes are ignored.  Currently the
> 	    errors may be reported by printk, but the netif_msg_*() filters
> 	    make that an even worse alert mechanism.
> 	
> 	Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> 
> 
>  pegasus.c |  297 +++++++++++++++++++++++++++++++++++++++-----------------------
>  pegasus.h |    4 
>  2 files changed, 193 insertions(+), 108 deletions(-)
> 
> 
> diff -Nru a/drivers/usb/net/pegasus.c b/drivers/usb/net/pegasus.c
> --- a/drivers/usb/net/pegasus.c	2005-03-30 15:19:01 -08:00
> +++ b/drivers/usb/net/pegasus.c	2005-03-30 15:19:01 -08:00
> @@ -85,6 +85,11 @@
>  MODULE_PARM_DESC(loopback, "Enable MAC loopback mode (bit 0)");
>  MODULE_PARM_DESC(mii_mode, "Enable HomePNA mode (bit 0),default=MII mode = 0");
>  
> +/* use ethtool to change the level for any given device */
> +static int msg_level = -1;

incorrect -- this should be an integer which indicates verbosity level; 
netif_msg_init() then converts that into a bitmap.

ditto this comment for my previous email (forgot to mention this).


> @@ -289,21 +309,23 @@
>  	int i;
>  	__u8 data[4] = { phy, 0, 0, indx };
>  	__le16 regdi;
> +	int ret;
>  
> -	set_register(pegasus, PhyCtrl, 0);
> -	set_registers(pegasus, PhyAddr, sizeof (data), data);
> -	set_register(pegasus, PhyCtrl, (indx | PHY_READ));
> +	ret = set_register(pegasus, PhyCtrl, 0);
> +	ret = set_registers(pegasus, PhyAddr, sizeof (data), data);
> +	ret = set_register(pegasus, PhyCtrl, (indx | PHY_READ));
>  	for (i = 0; i < REG_TIMEOUT; i++) {
> -		get_registers(pegasus, PhyCtrl, 1, data);
> +		ret = get_registers(pegasus, PhyCtrl, 1, data);
>  		if (data[0] & PHY_DONE)
>  			break;
>  	}
>  	if (i < REG_TIMEOUT) {
> -		get_registers(pegasus, PhyData, 2, &regdi);
> +		ret = get_registers(pegasus, PhyData, 2, &regdi);
>  		*regd = le16_to_cpu(regdi);
>  		return 1;
>  	}

these changes are completely pointless.  please revert.


> @@ -311,7 +333,7 @@
>  static int mdio_read(struct net_device *dev, int phy_id, int loc)
>  {
>  	pegasus_t *pegasus = (pegasus_t *) netdev_priv(dev);
> -	__le16 res;
> +	u16 res;
>  
>  	read_mii_word(pegasus, phy_id, loc, &res);
>  	return (int)res;

pointless cast in last line (though I realize this wasn't actually 
changed by your patch)


> @@ -321,20 +343,23 @@
>  {
>  	int i;
>  	__u8 data[4] = { phy, 0, 0, indx };
> +	int ret;
>  
> -	*(data + 1) = cpu_to_le16p(&regd);
> -	set_register(pegasus, PhyCtrl, 0);
> -	set_registers(pegasus, PhyAddr, sizeof(data), data);
> -	set_register(pegasus, PhyCtrl, (indx | PHY_WRITE));
> +	data[1] = (u8) regd;
> +	data[2] = (u8) (regd >> 8);
> +	ret = set_register(pegasus, PhyCtrl, 0);
> +	ret = set_registers(pegasus, PhyAddr, sizeof(data), data);
> +	ret = set_register(pegasus, PhyCtrl, (indx | PHY_WRITE));
>  	for (i = 0; i < REG_TIMEOUT; i++) {
> -		get_registers(pegasus, PhyCtrl, 1, data);
> +		ret = get_registers(pegasus, PhyCtrl, 1, data);
>  		if (data[0] & PHY_DONE)
>  			break;
>  	}

more pointless changes


> @@ -350,23 +375,25 @@
>  	int i;
>  	__u8 tmp;
>  	__le16 retdatai;
> +	int ret;
>  
> -	set_register(pegasus, EpromCtrl, 0);
> -	set_register(pegasus, EpromOffset, index);
> -	set_register(pegasus, EpromCtrl, EPROM_READ);
> +	ret = set_register(pegasus, EpromCtrl, 0);
> +	ret = set_register(pegasus, EpromOffset, index);
> +	ret = set_register(pegasus, EpromCtrl, EPROM_READ);
>  
>  	for (i = 0; i < REG_TIMEOUT; i++) {
> -		get_registers(pegasus, EpromCtrl, 1, &tmp);
> +		ret = get_registers(pegasus, EpromCtrl, 1, &tmp);
>  		if (tmp & EPROM_DONE)
>  			break;
>  	}
>  	if (i < REG_TIMEOUT) {
> -		get_registers(pegasus, EpromData, 2, &retdatai);
> +		ret = get_registers(pegasus, EpromData, 2, &retdatai);
>  		*retdata = le16_to_cpu(retdatai);
>  		return 0;
>  	}

and more


> @@ -374,40 +401,44 @@
>  static inline void enable_eprom_write(pegasus_t * pegasus)
>  {
>  	__u8 tmp;
> +	int ret;
>  
> -	get_registers(pegasus, EthCtrl2, 1, &tmp);
> -	set_register(pegasus, EthCtrl2, tmp | EPROM_WR_ENABLE);
> +	ret = get_registers(pegasus, EthCtrl2, 1, &tmp);
> +	ret = set_register(pegasus, EthCtrl2, tmp | EPROM_WR_ENABLE);
>  }
>  
>  static inline void disable_eprom_write(pegasus_t * pegasus)
>  {
>  	__u8 tmp;
> +	int ret;
>  
> -	get_registers(pegasus, EthCtrl2, 1, &tmp);
> -	set_register(pegasus, EpromCtrl, 0);
> -	set_register(pegasus, EthCtrl2, tmp & ~EPROM_WR_ENABLE);
> +	ret = get_registers(pegasus, EthCtrl2, 1, &tmp);
> +	ret = set_register(pegasus, EpromCtrl, 0);
> +	ret = set_register(pegasus, EthCtrl2, tmp & ~EPROM_WR_ENABLE);
>  }
>  
>  static int write_eprom_word(pegasus_t * pegasus, __u8 index, __u16 data)
>  {
>  	int i;
>  	__u8 tmp, d[4] = { 0x3f, 0, 0, EPROM_WRITE };
> +	int ret;
>  
> -	set_registers(pegasus, EpromOffset, 4, d);
> +	ret = set_registers(pegasus, EpromOffset, 4, d);
>  	enable_eprom_write(pegasus);
> -	set_register(pegasus, EpromOffset, index);
> -	set_registers(pegasus, EpromData, 2, &data);
> -	set_register(pegasus, EpromCtrl, EPROM_WRITE);
> +	ret = set_register(pegasus, EpromOffset, index);
> +	ret = set_registers(pegasus, EpromData, 2, &data);
> +	ret = set_register(pegasus, EpromCtrl, EPROM_WRITE);
>  
>  	for (i = 0; i < REG_TIMEOUT; i++) {
> -		get_registers(pegasus, EpromCtrl, 1, &tmp);
> +		ret = get_registers(pegasus, EpromCtrl, 1, &tmp);
>  		if (tmp & EPROM_DONE)
>  			break;
>  	}

and more


> @@ -426,9 +457,10 @@
>  static void set_ethernet_addr(pegasus_t * pegasus)
>  {
>  	__u8 node_id[6];
> +	int ret;
>  
>  	get_node_id(pegasus, node_id);
> -	set_registers(pegasus, EthID, sizeof (node_id), node_id);
> +	ret = set_registers(pegasus, EthID, sizeof (node_id), node_id);
>  	memcpy(pegasus->net->dev_addr, node_id, sizeof (node_id));
>  }
>  
> @@ -436,19 +468,20 @@
>  {
>  	__u8 data = 0x8;
>  	int i;
> +	int ret;
>  
> -	set_register(pegasus, EthCtrl1, data);
> +	ret = set_register(pegasus, EthCtrl1, data);
>  	for (i = 0; i < REG_TIMEOUT; i++) {
> -		get_registers(pegasus, EthCtrl1, 1, &data);
> +		ret = get_registers(pegasus, EthCtrl1, 1, &data);
>  		if (~data & 0x08) {
>  			if (loopback & 1)
>  				break;
>  			if (mii_mode && (pegasus->features & HAS_HOME_PNA))
> -				set_register(pegasus, Gpio1, 0x34);
> +				ret = set_register(pegasus, Gpio1, 0x34);
>  			else
> -				set_register(pegasus, Gpio1, 0x26);
> -			set_register(pegasus, Gpio0, pegasus->features);
> -			set_register(pegasus, Gpio0, DEFAULT_GPIO_SET);
> +				ret = set_register(pegasus, Gpio1, 0x26);
> +			ret = set_register(pegasus, Gpio0, pegasus->features);
> +			ret = set_register(pegasus, Gpio0, DEFAULT_GPIO_SET);
>  			break;
>  		}
>  	}
> @@ -457,8 +490,8 @@
>  
>  	if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS ||
>  	    usb_dev_id[pegasus->dev_index].vendor == VENDOR_DLINK) {
> -		set_register(pegasus, Gpio0, 0x24);
> -		set_register(pegasus, Gpio0, 0x26);
> +		ret = set_register(pegasus, Gpio0, 0x24);
> +		ret = set_register(pegasus, Gpio0, 0x26);
>  	}
>  	if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_ELCON) {
>  		__u16 auxmode;
> @@ -474,6 +507,7 @@
>  	__u16 linkpart;
>  	__u8 data[4];
>  	pegasus_t *pegasus = netdev_priv(dev);
> +	int ret;
>  
>  	read_mii_word(pegasus, pegasus->phy, MII_LPA, &linkpart);
>  	data[0] = 0xc9;
> @@ -487,7 +521,7 @@
>  	data[2] = (loopback & 1) ? 0x09 : 0x01;
>  
>  	memcpy(pegasus->eth_regs, data, sizeof (data));
> -	set_registers(pegasus, EthCtrl0, 3, data);
> +	ret = set_registers(pegasus, EthCtrl0, 3, data);
>  
>  	if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS ||
>  	    usb_dev_id[pegasus->dev_index].vendor == VENDOR_DLINK) {

and more and more and more


>  	case -ENOENT:
>  	case -ECONNRESET:
>  	case -ESHUTDOWN:
> -		dbg("%s: rx unlink, %d", net->name, urb->status);
> +		if (netif_msg_ifdown(pegasus))
> +			pr_debug("%s: rx unlink, %d\n", net->name, urb->status);

inappropriate


> -		dbg("%s: tx unlink, %d", net->name, urb->status);
> +		if (netif_msg_ifdown(pegasus))
> +			pr_debug("%s: tx unlink, %d\n", net->name, urb->status);
>  		return;
>  	default:

ditto


> @@ -731,7 +782,9 @@
>  		/* some Pegasus-I products report LOTS of data
>  		 * toggle errors... avoid log spamming
>  		 */
> -		pr_debug("%s: intr status %d\n", net->name, urb->status);
> +		if (netif_msg_timer(pegasus))
> +			pr_debug("%s: intr status %d\n", net->name,
> +					urb->status);
>  	}
>  
>  	if (urb->actual_length >= 6) {

avoid log spamming by net_ratelimit() or similar.

also, this seems unrelated to timer (inappropriate)


> @@ -763,7 +816,7 @@
>  	}
>  
>  	status = usb_submit_urb(urb, SLAB_ATOMIC);
> -	if (status)
> +	if (status && netif_msg_timer(pegasus))
>  		printk(KERN_ERR "%s: can't resubmit interrupt urb, %d\n",
>  				net->name, status);
>  }

ditto?


> @@ -771,7 +824,8 @@
>  static void pegasus_tx_timeout(struct net_device *net)
>  {
>  	pegasus_t *pegasus = netdev_priv(net);
> -	printk(KERN_WARNING "%s: tx timeout\n", net->name);
> +	if (netif_msg_timer(pegasus))
> +		printk(KERN_WARNING "%s: tx timeout\n", net->name);
>  	pegasus->tx_urb->transfer_flags |= URB_ASYNC_UNLINK;
>  	usb_unlink_urb(pegasus->tx_urb);
>  	pegasus->stats.tx_errors++;

inappropriate


> @@ -822,8 +878,9 @@
>  static inline void disable_net_traffic(pegasus_t * pegasus)
>  {
>  	int tmp = 0;
> +	int ret;
>  
> -	set_registers(pegasus, EthCtrl0, 2, &tmp);
> +	ret = set_registers(pegasus, EthCtrl0, 2, &tmp);
>  }
>  
>  static inline void get_interrupt_interval(pegasus_t * pegasus)

pointless


> @@ -912,24 +971,32 @@
>  	if (!pegasus->rx_skb)
>  		return -ENOMEM;
>  
> -	set_registers(pegasus, EthID, 6, net->dev_addr);
> +	res = set_registers(pegasus, EthID, 6, net->dev_addr);

pointless


>  	usb_fill_bulk_urb(pegasus->rx_urb, pegasus->usb,
>  			  usb_rcvbulkpipe(pegasus->usb, 1),
>  			  pegasus->rx_skb->data, PEGASUS_MTU + 8,
>  			  read_bulk_callback, pegasus);
> -	if ((res = usb_submit_urb(pegasus->rx_urb, GFP_KERNEL)))
> -		warn("%s: failed rx_urb %d", __FUNCTION__, res);
> +	if ((res = usb_submit_urb(pegasus->rx_urb, GFP_KERNEL))) {
> +		if (netif_msg_ifup(pegasus))
> +			pr_debug("%s: failed rx_urb, %d", net->name, res);
> +		goto exit;
> +	}
> +
>  	usb_fill_int_urb(pegasus->intr_urb, pegasus->usb,
>  			 usb_rcvintpipe(pegasus->usb, 3),
>  			 pegasus->intr_buff, sizeof (pegasus->intr_buff),
>  			 intr_callback, pegasus, pegasus->intr_interval);
> -	if ((res = usb_submit_urb(pegasus->intr_urb, GFP_KERNEL)))
> -		warn("%s: failed intr_urb %d", __FUNCTION__, res);
> -	netif_start_queue(net);
> -	pegasus->flags |= PEGASUS_RUNNING;
> +	if ((res = usb_submit_urb(pegasus->intr_urb, GFP_KERNEL))) {
> +		if (netif_msg_ifup(pegasus))
> +			pr_debug("%s: failed intr_urb, %d\n", net->name, res);
> +		usb_kill_urb(pegasus->rx_urb);
> +		goto exit;
> +	}
>  	if ((res = enable_net_traffic(net, pegasus->usb))) {
> -		err("can't enable_net_traffic() - %d", res);
> +		if (netif_msg_ifup(pegasus))
> +			pr_debug("%s: can't enable_net_traffic() - %d\n",
> +					net->name, res);
>  		res = -EIO;
>  		usb_kill_urb(pegasus->rx_urb);
>  		usb_kill_urb(pegasus->intr_urb);

inappropriate


> @@ -937,6 +1004,9 @@
>  		goto exit;
>  	}
>  	set_carrier(net);
> +	netif_start_queue(net);
> +	if (netif_msg_ifup(pegasus))
> +		pr_debug("%s: open\n", net->name);
>  	res = 0;
>  exit:
>  	return res;

OK!  (yay)


> @@ -946,7 +1016,6 @@
>  {
>  	pegasus_t *pegasus = netdev_priv(net);
>  
> -	pegasus->flags &= ~PEGASUS_RUNNING;
>  	netif_stop_queue(net);
>  	if (!(pegasus->flags & PEGASUS_UNPLUG))
>  		disable_net_traffic(pegasus);

where is the netif_msg_ifdown()?



> @@ -1094,12 +1164,14 @@
>  
>  	if (net->flags & IFF_PROMISC) {
>  		pegasus->eth_regs[EthCtrl2] |= RX_PROMISCUOUS;
> -		pr_info("%s: Promiscuous mode enabled.\n", net->name);
> +		if (netif_msg_link(pegasus))
> +			pr_info("%s: Promiscuous mode enabled.\n", net->name);
>  	} else if ((net->mc_count > multicast_filter_limit) ||
>  		   (net->flags & IFF_ALLMULTI)) {
>  		pegasus->eth_regs[EthCtrl0] |= RX_MULTICAST;
>  		pegasus->eth_regs[EthCtrl2] &= ~RX_PROMISCUOUS;
> -		pr_info("%s: set allmulti\n", net->name);
> +		if (netif_msg_link(pegasus))
> +			pr_info("%s: set allmulti\n", net->name);
>  	} else {
>  		pegasus->eth_regs[EthCtrl0] &= ~RX_MULTICAST;
>  		pegasus->eth_regs[EthCtrl2] &= ~RX_PROMISCUOUS;

inappropriate


> @@ -1128,17 +1200,18 @@
>  static inline void setup_pegasus_II(pegasus_t * pegasus)
>  {
>  	__u8 data = 0xa5;
> +	int ret;
>  	
> -	set_register(pegasus, Reg1d, 0);
> -	set_register(pegasus, Reg7b, 1);
> +	ret = set_register(pegasus, Reg1d, 0);
> +	ret = set_register(pegasus, Reg7b, 1);
>  	mdelay(100);
>  	if ((pegasus->features & HAS_HOME_PNA) && mii_mode)
> -		set_register(pegasus, Reg7b, 0);
> +		ret = set_register(pegasus, Reg7b, 0);
>  	else
> -		set_register(pegasus, Reg7b, 2);
> +		ret = set_register(pegasus, Reg7b, 2);
>  
> -	set_register(pegasus, 0x83, data);
> -	get_registers(pegasus, 0x83, 1, &data);
> +	ret = set_register(pegasus, 0x83, data);
> +	ret = get_registers(pegasus, 0x83, 1, &data);
>  
>  	if (data == 0xa5) {
>  		pegasus->chip = 0x8513;

more addition-of-dead-stores


> @@ -1146,14 +1219,14 @@
>  		pegasus->chip = 0;
>  	}
>  
> -	set_register(pegasus, 0x80, 0xc0);
> -	set_register(pegasus, 0x83, 0xff);
> -	set_register(pegasus, 0x84, 0x01);
> +	ret = set_register(pegasus, 0x80, 0xc0);
> +	ret = set_register(pegasus, 0x83, 0xff);
> +	ret = set_register(pegasus, 0x84, 0x01);
>  	
>  	if (pegasus->features & HAS_HOME_PNA && mii_mode)
> -		set_register(pegasus, Reg81, 6);
> +		ret = set_register(pegasus, Reg81, 6);
>  	else
> -		set_register(pegasus, Reg81, 2);
> +		ret = set_register(pegasus, Reg81, 2);
>  }
>  
>  

ditto


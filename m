Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWEYAw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWEYAw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWEYAw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:52:56 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12435 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964800AbWEYAw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:52:56 -0400
Message-ID: <4474FFE1.4030202@garzik.org>
Date: Wed, 24 May 2006 20:52:49 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] pci: gt96100eth use pci probing
References: <20060525003151.598EAC7C19@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060525003151.598EAC7C19@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> gt96100eth use pci probing
> 
> Convert pci_find_device to pci probing. Use dev_* macros for printing.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> commit 4bdf11796756f0bdc50d2f4251d7a405fcbfd9b6
> tree ed9cfdec21d187307abebff973ab963d767bc51d
> parent 75664d3c6fe1d8d00b87e42cc001cb5d90613dae
> author Jiri Slaby <ku@bellona.localdomain> Thu, 25 May 2006 02:09:25 +0159
> committer Jiri Slaby <ku@bellona.localdomain> Thu, 25 May 2006 02:09:25 +0159
> 
>  drivers/net/gt96100eth.c |  167 +++++++++++++++++++++++++++++-----------------
>  1 files changed, 107 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/net/gt96100eth.c b/drivers/net/gt96100eth.c
> index 2d24354..47095ca 100644
> --- a/drivers/net/gt96100eth.c
> +++ b/drivers/net/gt96100eth.c
> @@ -56,6 +56,8 @@ #define GT96100_DEBUG 2
>  
>  #include "gt96100eth.h"
>  
> +struct gt96100_if_t;
> +
>  // prototypes
>  static void* dmaalloc(size_t size, dma_addr_t *dma_handle);
>  static void dmafree(size_t size, void *vaddr);
> @@ -65,8 +67,6 @@ static int gt96100_add_hash_entry(struct
>  static void read_mib_counters(struct gt96100_private *gp);
>  static int read_MII(int phy_addr, u32 reg);
>  static int write_MII(int phy_addr, u32 reg, u16 data);
> -static int gt96100_init_module(void);
> -static void gt96100_cleanup_module(void);
>  static void dump_MII(int dbg_lvl, struct net_device *dev);
>  static void dump_tx_desc(int dbg_lvl, struct net_device *dev, int i);
>  static void dump_rx_desc(int dbg_lvl, struct net_device *dev, int i);
> @@ -77,7 +77,11 @@ static void abort(struct net_device *dev
>  static void hard_stop(struct net_device *dev);
>  static void enable_ether_irq(struct net_device *dev);
>  static void disable_ether_irq(struct net_device *dev);
> -static int gt96100_probe1(struct pci_dev *pci, int port_num);
> +static int __devinit gt96100_probe(struct pci_dev *,
> +		const struct pci_device_id *);
> +static void __devexit gt96100_remove(struct pci_dev *);
> +static int gt96100_probe1(struct pci_dev *, int);
> +static void gt96100_remove1(struct gt96100_if_t *);
>  static void reset_tx(struct net_device *dev);
>  static void reset_rx(struct net_device *dev);
>  static int gt96100_check_tx_consistent(struct gt96100_private *gp);
> @@ -600,57 +604,93 @@ disable_ether_irq(struct net_device *dev
>  	GT96100ETH_WRITE(gp, GT96100_ETH_INT_MASK, 0);
>  }
>  
> +static struct pci_device_id gt96100_pci_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT96100) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT96100A) },
> +	{ 0 }
> +};
> +MODULE_DEVICE_TABLE(pci, gt96100_pci_tbl);
>  
> -/*
> - * Init GT96100 ethernet controller driver
> - */
> -static int gt96100_init_module(void)
> +static struct pci_driver gt96100_driver = {
> +	.name		= "isicom",
> +	.id_table	= gt96100_pci_tbl,
> +	.probe		= gt96100_probe,
> +	.remove		= __devexit_p(gt96100_remove)
> +};
> +
> +static int __devinit gt96100_probe(struct pci_dev *pdev,
> +		const struct pci_device_id *ent)
>  {
> -	struct pci_dev *pci;
> -	int i, retval=0;
> -	u32 cpuConfig;
> +	struct gt96100_if_t *gtifs;
> +	unsigned int i, j;
> +	int retval;
>  
> -	/*
> -	 * Stupid probe because this really isn't a PCI device
> -	 */
> -	if (!(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
> -	                            PCI_DEVICE_ID_MARVELL_GT96100, NULL)) &&
> -	    !(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
> -		                    PCI_DEVICE_ID_MARVELL_GT96100A, NULL))) {
> -		printk(KERN_ERR __FILE__ ": GT96100 not found!\n");
> +	if (GT96100_READ(GT96100_CPU_INTERF_CONFIG) & (1 << 12)) {
> +		dev_err(&pdev->dev, "must be in Big Endian mode!\n");
>  		return -ENODEV;
>  	}
>  
> -	cpuConfig = GT96100_READ(GT96100_CPU_INTERF_CONFIG);
> -	if (cpuConfig & (1<<12)) {
> -		printk(KERN_ERR __FILE__
> -		       ": must be in Big Endian mode!\n");
> -		return -ENODEV;

Please don't include silly and unnecessary pseudo-optimizations like 
eliminating the cpuConfig variable.  The maintainer may have felt it was 
more readable in its original form (as do I).


> +	gtifs = kmalloc(sizeof(gt96100_iflist), GFP_KERNEL);
> +	if (gtifs == NULL) {
> +		dev_err(&pdev->dev, "unable to alloc ifs\n");
> +		return -ENOMEM;
> +	}

the kmalloc should go before we start touching the hardware.


> +	memcpy(gtifs, &gt96100_iflist, sizeof(gt96100_iflist));
> +
> +	pci_set_drvdata(pdev,gtifs);
> +
> +	for (i = 0; i < NUM_INTERFACES; i++) {
> +		retval = gt96100_probe1(pdev, i);
> +		if (retval)
> +			goto unprobe;
>  	}
>  
> -	for (i=0; i < NUM_INTERFACES; i++)
> -		retval |= gt96100_probe1(pci, i);
> +	return 0;
> +unprobe:
> +	for (j = i; j > 0; j--) {
> +		struct gt96100_if_t *gtif = &gtifs[j - 1];
> +		gt96100_remove1(gtif);
> +	}
> +	kfree(gtifs);

upon failure, you fail to set drvdata back to NULL


> -static int __init gt96100_probe1(struct pci_dev *pci, int port_num)
> +static void __devexit gt96100_remove(struct pci_dev *pdev)
> +{
> +	struct gt96100_if_t *gtifs = pci_get_drvdata(pdev);
> +	unsigned int i;
> +
> +	for (i = 0; i < NUM_INTERFACES; i++) {
> +		struct gt96100_if_t *gtif = &gtifs[i];
> +		gt96100_remove1(gtif);
> +	}
> +	kfree(gtifs);

on exit, you fail to set drvdata back to NULL


> +static int __init gt96100_probe1(struct pci_dev *pdev, int port_num)
>  {
>  	struct gt96100_private *gp = NULL;
> -	struct gt96100_if_t *gtif = &gt96100_iflist[port_num];
> +	struct gt96100_if_t *gtifs = pci_get_drvdata(pdev);
> +	struct gt96100_if_t *gtif = &gtifs[port_num];
>  	int phy_addr, phy_id1, phy_id2;
>  	u32 phyAD;
> -	int retval;
> +	int retval = -ENOMEM;
>  	unsigned char chip_rev;
>  	struct net_device *dev = NULL;
>      
>  	if (gtif->irq < 0) {
> -		printk(KERN_ERR "%s: irq unknown - probing not supported\n",
> -		      __FUNCTION__);
> +		dev_err(&pdev->dev, "irq unknown - probing not supported\n");
>  		return -ENODEV;
>  	}
> +
> +	retval = pci_enable_device(pdev);
> +	if (retval) {
> +		dev_err(&pdev->dev, "cannot enable pci device\n");
> +		return retval;
> +	}

bug #1:  please confirm pci_enable_device() is OK on this embedded hardware

bug #2:  you call pci_enable_device() multiple times for the same PCI device


> -	pci_read_config_byte(pci, PCI_REVISION_ID, &chip_rev);
> +	pci_read_config_byte(pdev, PCI_REVISION_ID, &chip_rev);
>  
>  	if (chip_rev >= REV_GT96100A_1) {
>  		phyAD = GT96100_READ(GT96100_ETH_PHY_ADDR_REG);
> @@ -669,12 +709,12 @@ static int __init gt96100_probe1(struct 
>  	// probe for the external PHY
>  	if ((phy_id1 = read_MII(phy_addr, 2)) <= 0 ||
>  	    (phy_id2 = read_MII(phy_addr, 3)) <= 0) {
> -		printk(KERN_ERR "%s: no PHY found on MII%d\n", __FUNCTION__, port_num);
> +		dev_err(&pdev->dev, "no PHY found on MII%d\n", port_num);
>  		return -ENODEV;
>  	}
>  	
>  	if (!request_region(gtif->iobase, GT96100_ETH_IO_SIZE, "GT96100ETH")) {
> -		printk(KERN_ERR "%s: request_region failed\n", __FUNCTION__);
> +		dev_err(&pdev->dev, "request_region failed\n");
>  		return -EBUSY;
>  	}
>  
> @@ -689,7 +729,7 @@ static int __init gt96100_probe1(struct 
>  	dev->irq = gtif->irq;
>  
>  	if ((retval = parse_mac_addr(dev, gtif->mac_str))) {
> -		err("%s: MAC address parse failed\n", __FUNCTION__);
> +		dev_err(&pdev->dev, "MAC address parse failed\n");
>  		retval = -EINVAL;
>  		goto out1;
>  	}
> @@ -704,12 +744,15 @@ static int __init gt96100_probe1(struct 
>  	gp->phy_addr = phy_addr;
>  	gp->chip_rev = chip_rev;
>  
> -	info("%s found at 0x%x, irq %d\n",
> -	     chip_name(gp->chip_rev), gtif->iobase, gtif->irq);
> +	dev_info(&pdev->dev, "%s found at 0x%x, irq %d\n",
> +			chip_name(gp->chip_rev), gtif->iobase, gtif->irq);
>  	dump_hw_addr(0, dev, "%s: HW Address ", __FUNCTION__, dev->dev_addr);
> -	info("%s chip revision=%d\n", chip_name(gp->chip_rev), gp->chip_rev);
> -	info("%s ethernet port %d\n", chip_name(gp->chip_rev), gp->port_num);
> -	info("external PHY ID1=0x%04x, ID2=0x%04x\n", phy_id1, phy_id2);
> +	dev_info(&pdev->dev, "%s chip revision=%d\n", chip_name(gp->chip_rev),
> +			gp->chip_rev);
> +	dev_info(&pdev->dev, "%s ethernet port %d\n", chip_name(gp->chip_rev),
> +			gp->port_num);
> +	dev_info(&pdev->dev, "external PHY ID1=0x%04x, ID2=0x%04x\n", phy_id1,
> +			phy_id2);
>  
>  	// Allocate Rx and Tx descriptor rings
>  	if (gp->rx_ring == NULL) {
> @@ -737,8 +780,8 @@ static int __init gt96100_probe1(struct 
>  		}
>  	}
>      
> -	dbg(3, "%s: rx_ring=%p, tx_ring=%p\n", __FUNCTION__,
> -	    gp->rx_ring, gp->tx_ring);
> +	dev_dbg(&pdev->dev, "rx_ring=%p, tx_ring=%p\n", gp->rx_ring,
> +			gp->tx_ring);
>  
>  	// Allocate Rx Hash Table
>  	if (gp->hash_table == NULL) {
> @@ -750,7 +793,7 @@ static int __init gt96100_probe1(struct 
>  		}
>  	}
>      
> -	dbg(3, "%s: hash=%p\n", __FUNCTION__, gp->hash_table);
> +	dev_dbg(&pdev->dev, "hash=%p\n", gp->hash_table);
>  
>  	spin_lock_init(&gp->lock);
>      
> @@ -781,10 +824,24 @@ out1:
>  out:
>  	release_region(gtif->iobase, GT96100_ETH_IO_SIZE);
>  
> -	err("%s failed.  Returns %d\n", __FUNCTION__, retval);
> +	dev_err(&pdev->dev, "%s failed.  Returns %d\n", __FUNCTION__, retval);
>  	return retval;

all this dev_foo() stuff creates patch noise.  It should be in a 
separate patch.


> +static void gt96100_remove1(struct gt96100_if_t *gtif)
> +{
> +	if (gtif->dev != NULL) {

unindent by doing

	if (gtif->dev == NULL)
		return;

	...


> +		struct gt96100_private *gp = netdev_priv(gtif->dev);
> +		unregister_netdev(gtif->dev);
> +		dmafree(RX_HASH_TABLE_SIZE, gp->hash_table_dma);
> +		dmafree(PKT_BUF_SZ*RX_RING_SIZE, gp->rx_buff);
> +		dmafree(sizeof(gt96100_rd_t) * RX_RING_SIZE
> +			+ sizeof(gt96100_td_t) * TX_RING_SIZE,
> +			gp->rx_ring);
> +		free_netdev(gtif->dev);
> +		release_region(gtif->iobase, gp->io_size);

shouldn't this be using pci_request_regions() / pci_release_regions() ?


>  static void
>  reset_tx(struct net_device *dev)
> @@ -1516,24 +1573,14 @@ gt96100_get_stats(struct net_device *dev
>  	return &gp->stats;
>  }
>  
> -static void gt96100_cleanup_module(void)
> +static int __init gt96100_init_module(void)
>  {
> -	int i;
> -	for (i=0; i<NUM_INTERFACES; i++) {
> -		struct gt96100_if_t *gtif = &gt96100_iflist[i];
> -		if (gtif->dev != NULL) {
> -			struct gt96100_private *gp = (struct gt96100_private *)
> -				netdev_priv(gtif->dev);
> -			unregister_netdev(gtif->dev);
> -			dmafree(RX_HASH_TABLE_SIZE, gp->hash_table_dma);
> -			dmafree(PKT_BUF_SZ*RX_RING_SIZE, gp->rx_buff);
> -			dmafree(sizeof(gt96100_rd_t) * RX_RING_SIZE
> -				+ sizeof(gt96100_td_t) * TX_RING_SIZE,
> -				gp->rx_ring);
> -			free_netdev(gtif->dev);
> -			release_region(gtif->iobase, gp->io_size);
> -		}
> -	}
> +	return pci_register_driver(&gt96100_driver);
> +}
> +
> +static void __exit gt96100_cleanup_module(void)
> +{
> +	pci_unregister_driver(&gt96100_driver);
>  }
>  
>  static int __init gt96100_setup(char *options)
> 
> 


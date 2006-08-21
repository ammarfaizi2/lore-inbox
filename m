Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWHUQWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWHUQWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 12:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbWHUQWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 12:22:10 -0400
Received: from xenotime.net ([66.160.160.81]:9139 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751899AbWHUQWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 12:22:08 -0400
Date: Mon, 21 Aug 2006 09:25:11 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: romieu@fr.zoreil.com, penberg@cs.Helsinki.FI, akpm@osdl.org,
       dvrabel@cantab.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] IP1000A: IC Plus update
Message-Id: <20060821092511.32108665.rdunlap@xenotime.net>
In-Reply-To: <1156192327.5852.3.camel@localhost.localdomain>
References: <1156192327.5852.3.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 16:32:07 -0400 Jesse Huang wrote:

> Dear All:
> I had regenerate this patch from:
> git://git.kernel.org/pub/scm/linux/kernel/git/penberg/netdev-ipg-2.6.git
> 
> And, submit those modifications as one patch.
> 
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> Change Logs:
>    - update maintainer information
>    - remove some default phy params
>    - remove threshold config from ipg_io_config
>    - ip1000 ipg_config_autoneg rewrite
>    - modify coding style of ipg_config_autoneg
>    - Add IPG_AC_FIFO flag when Tx reset
>    - For compatible at PCI 66MHz issue
> 
> Signed-off-by: Jesse Huang <jesse@icplus.com.tw>
> ---
> 
>  ipg.c |  394 ++++++++++++++
> +-------------------------------------------------- ipg.h |   96
> +--------------- 2 files changed, 92 insertions(+), 398 deletions(-)

Please use "diffstat -p1 -w 70" for diffstat output so that we can
see the full path/file names that are modified in the patch.

> 8bd0325e52d2578c37cd251aeac2136f7cca9098
> diff --git a/ipg.c b/ipg.c
> index 754ddb5..7c541c2 100644
> --- a/ipg.c
> +++ b/ipg.c

Similar to the diffstat comment, the "diff" a & b filenames should
show the full path to the source file, e.g.:

--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c

> @@ -511,14 +513,13 @@ static int ipg_config_autoneg(struct net
>  	 */
>  	sp->tenmbpsmode = 0;
>  
> -	printk("Link speed = ");
> +	printk(KERN_INFO "Link speed = ");
>  
>  	/* Determine actual speed of operation. */
>  	switch (phyctrl & IPG_PC_LINK_SPEED) {
>  	case IPG_PC_LINK_SPEED_10MBPS:
>  		printk("10Mbps.\n");
> -		printk(KERN_INFO "%s: 10Mbps operational mode
> enabled.\n",
> -		       dev->name);
> +		printk("%s: 10Mbps operational mode enabled.
> \n",dev->name);

Space before "dev->name".
Why dropping the KERN_INFO here?  The previous printk contains
a newline character, so KERN_* is still valid.

> 		sp->tenmbpsmode = 1;
>  		break;
>  	case IPG_PC_LINK_SPEED_100MBPS:

> @@ -530,283 +531,50 @@ static int ipg_config_autoneg(struct net

> +	/* Configure full duplex, and flow control. */
> +	if (fullduplex == 1) {
> +		/* Configure IPG for full duplex operation. */
> +		printk(KERN_INFO "setting full duplex, ");

This series of printk calls needs some kind of device or driver
identification.

> -		if ((advertisement & ADVERTISE_1000XFULL) ==
> -		    (linkpartner_ability & ADVERTISE_1000XFULL)) {
> -			fullduplex = 1;
> +		mac_ctrl_value |= IPG_MC_DUPLEX_SELECT_FD;
>  
> -			/* In 1000BASE-X using IPG's internal PCS
> -			 * layer, so write to the GMII duplex bit.
> -			 */
> -			bmcr |= ADVERTISE_1000HALF; // Typo ?
> +		if (txflowcontrol == 1) {
> +			printk("TX flow control");
> +			mac_ctrl_value |=
> IPG_MC_TX_FLOW_CONTROL_ENABLE; } else {
> -			fullduplex = 0;
> -
> -			/* In 1000BASE-X using IPG's internal PCS
> -			 * layer, so write to the GMII duplex bit.
> -			 */
> -			bmcr &= ~ADVERTISE_1000HALF; // Typo ?
> +			printk("no TX flow control");
> +			mac_ctrl_value &=
> ~IPG_MC_TX_FLOW_CONTROL_ENABLE; }
> -		mdio_write(dev, phyaddr, MII_BMCR, bmcr);
> -	}

> +	} else {
> +		/* Configure IPG for half duplex operation. */
> +	        printk(KERN_INFO "setting half duplex, no TX flow
> control, no RX flow control.\n"); 

Same here:  needs device (preferably) or driver identification.

> -		default:
> -			txflowcontrol = 0;
> -			rxflowcontrol = 0;
> -		}
> +		mac_ctrl_value &= ~IPG_MC_DUPLEX_SELECT_FD &
> ~IPG_MC_TX_FLOW_CONTROL_ENABLE & ~IPG_MC_RX_FLOW_CONTROL_ENABLE; }

> @@ -1158,6 +916,7 @@ static void ipg_nic_txfree(struct net_de
>  	struct ipg_nic_private *sp = netdev_priv(dev);
>  	int NextToFree;
>  	int maxtfdcount;
> +	long CurrentTxTFDPtr=(ioread32(ipg_ioaddr(dev)
> +TFD_LIST_PTR_0)-(long)sp->TFDListDMAhandle)/(long)sizeof(struct
> TFD);

Space before and after '=' sign.
 
> @@ -1180,8 +939,10 @@ static void ipg_nic_txfree(struct net_de
>  		 * If the TFDDone bit is set, free the associated
>  		 * buffer.
>  		 */
> -		if ((le64_to_cpu(sp->TFDList[NextToFree].TFC) &
> -		     IPG_TFC_TFDDONE) && (NextToFree !=
> sp->CurrentTFD)) {
> +		if((NextToFree != sp->CurrentTFD)&&(NextToFree!
> =CurrentTxTFDPtr))

Spaces before and after "&&" and "!=" etc. (as in the former code).

> +		{
> +			//JesseAdd: setup TFDDONE for compatible
> issue.
> +			sp->TFDList[NextToFree].TFC = cpu_to_le64
> (sp->TFDList[NextToFree].TFC|IPG_TFC_TFDDONE); /* Free the transmit
> buffer. */ if (sp->TxBuff[NextToFree] != NULL) {
>  				pci_unmap_single(sp->pdev,
> @@ -1204,6 +965,15 @@ static void ipg_nic_txfree(struct net_de
>  		maxtfdcount--;
>  
>  	} while (maxtfdcount != 0);
> +	if(sp->LastTFDHoldCnt>1000) {

Space between "if" and "(".  Space before/after ">".
and on next line ("=").

> +		sp->LastTFDHoldCnt=0;
> +		ipg_reset(dev, IPG_AC_TX_RESET | IPG_AC_DMA |
> IPG_AC_NETWORK | IPG_AC_FIFO);
> +		// Re-configure after DMA reset. 
> +		if ((ipg_io_config(dev) < 0) ||(init_tfdlist(dev)
> < 0)) {
> +			printk(KERN_INFO"%s: Error during
> re-configuration.\n",dev->name);

Space before "dev->name".  And after KERN_INFO.

Could you save an error code from ipg_io_config() or init_tfdlist()
and give the user a bit more meaningful message?


> +		}

> @@ -2280,10 +2050,17 @@ static int ipg_nic_hard_start_xmit(struc
>  	 * counter, modulus the length of the TFDList.
>  	 */
>  	NextTFD = (sp->CurrentTFD + 1) % IPG_TFDLIST_LENGTH;
> +	if(sp->ResetCurrentTFD!=0)

Spaces.  Make it human-readable, not just machine-readable.

> +	{
> +		sp->ResetCurrentTFD=0;
> +		NextTFD=0;	
> +	}
> +	/* Check for availability of next TFD. Reserve 1 for not
> become ring*/
> +	if (NextTFD == sp->LastFreedTxBuff) {
> +		
> +		if(sp->LastTFDHoldAddr==sp->CurrentTFD)

Spaces....


> diff --git a/ipg.h b/ipg.h
> index 58b1417..9688483 100644
> --- a/ipg.h
> +++ b/ipg.h
> @@ -919,59 +883,7 @@ unsigned short DefaultPhyParam[] = {
>  	// 01/09/04 IP1000A v1-5 rev=0x41
>  	(0x4100 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31, 0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x42
> -	(0x4200 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x43
> -	(0x4300 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x44
> -	(0x4400 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x45
> -	(0x4500 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x46
> -	(0x4600 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x47
> -	(0x4700 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x48
> -	(0x4800 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x49
> -	(0x4900 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x4A
> -	(0x4A00 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x4B
> -	(0x4B00 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x4C
> -	(0x4C00 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x4D
> -	(0x4D00 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> -	// 01/09/04 IP1000A v1-5 rev=0x4E
> -	(0x4E00 | (07 * 4)), 31, 0x0001, 27, 0x01e0, 31, 0x0002,
> 27, 0xeb8e, 31,
> -	    0x0000,
> -	30, 0x005e, 9, 0x0700,
> +	30, 0x005e, 9, 0x0700,	

Eh?  This change just adds whitespace at end of line.
This happens in other places too.  Please clean up all of those.

Does removing all of those other entries prevent anyone's
hardware from working correctly?


---
~Randy

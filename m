Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUFULn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUFULn5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 07:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUFULn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 07:43:57 -0400
Received: from mail.gmx.de ([213.165.64.20]:5253 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266198AbUFULny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 07:43:54 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>, Daniele Venzano <webvenza@libero.it>
Subject: Re: 2.6.7-mm1
Date: Mon, 21 Jun 2004 13:43:47 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040620174632.74e08e09.akpm@osdl.org> <200406211248.08190.dominik.karall@gmx.net> <20040621040029.48367636.akpm@osdl.org>
In-Reply-To: <20040621040029.48367636.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406211343.50142.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 June 2004 13:00, Andrew Morton wrote:
> Dominik Karall <dominik.karall@gmx.net> wrote:
> >  On Monday 21 June 2004 02:46, Andrew Morton wrote:
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.
> >  >6.7-m m1/
> >
> >  My network does not work with this patch.
>
> Bummer.  Does this reversion fix it?

Yes. With this patch it works, but it works in that way, that the wrong 
transceiver will be set as default. Maybe the current bk-netdev.patch is 
incompatible with this patch? Or something isn't ok in bk-netdev.patch?
Because the SiS900 patch is long time in -mm tree now, and it worked before!

greets dominik

> diff -puN drivers/net/sis900.c~a drivers/net/sis900.c
> --- 25/drivers/net/sis900.c~a	2004-06-21 04:00:05.242017088 -0700
> +++ 25-akpm/drivers/net/sis900.c	2004-06-21 04:00:07.832623256 -0700
> @@ -116,7 +116,6 @@ static struct mii_chip_info {
>  #define	HOME 	0x0001
>  #define LAN	0x0002
>  #define MIX	0x0003
> -#define UNKNOWN	0x0
>  } mii_chip_table[] = {
>  	{ "SiS 900 Internal MII PHY", 		0x001d, 0x8000, LAN },
>  	{ "SiS 7014 Physical Layer Solution", 	0x0016, 0xf830, LAN },
> @@ -578,11 +577,9 @@ static int __init sis900_mii_probe (stru
>  				break;
>  			}
>
> -		if( !mii_chip_table[i].phy_id1 ) {
> +		if( !mii_chip_table[i].phy_id1 )
>  			printk(KERN_INFO "%s: Unknown PHY transceiver found at address %d.\n",
> -			       net_dev->name, phy_addr);
> -			mii_phy->phy_types = UNKNOWN;
> -		}
> +			       net_dev->name, phy_addr);
>  	}
>
>  	if (sis_priv->mii == NULL) {
> @@ -647,15 +644,15 @@ static int __init sis900_mii_probe (stru
>  static u16 sis900_default_phy(struct net_device * net_dev)
>  {
>  	struct sis900_private * sis_priv = net_dev->priv;
> - 	struct mii_phy *phy = NULL, *phy_home = NULL, *default_phy = NULL,
> *phy_lan = NULL; + 	struct mii_phy *phy = NULL, *phy_home = NULL,
> *default_phy = NULL; u16 status;
>
>          for( phy=sis_priv->first_mii; phy; phy=phy->next ){
>  		status = mdio_read(net_dev, phy->phy_addr, MII_STATUS);
>  		status = mdio_read(net_dev, phy->phy_addr, MII_STATUS);
>
> -		/* Link ON & Not select default PHY & not ghost PHY */
> -		 if ( (status & MII_STAT_LINK) && !default_phy && (phy->phy_types !=
> UNKNOWN) ) +		/* Link ON & Not select deafalut PHY */
> +		 if ( (status & MII_STAT_LINK) && !(default_phy) )
>  		 	default_phy = phy;
>  		 else{
>  			status = mdio_read(net_dev, phy->phy_addr, MII_CONTROL);
> @@ -663,16 +660,12 @@ static u16 sis900_default_phy(struct net
>  				status | MII_CNTL_AUTO | MII_CNTL_ISOLATE);
>  			if( phy->phy_types == HOME )
>  				phy_home = phy;
> -			else if (phy->phy_types == LAN)
> -				phy_lan = phy;
>  		 }
>  	}
>
> -	if( !default_phy && phy_home )
> +	if( (!default_phy) && phy_home )
>  		default_phy = phy_home;
> -	else if( !default_phy && phy_lan )
> -		default_phy = phy_lan;
> -	else if ( !default_phy )
> +	else if(!default_phy)
>  		default_phy = sis_priv->first_mii;
>
>  	if( sis_priv->mii != default_phy ){

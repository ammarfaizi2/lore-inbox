Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUJHTNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUJHTNG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 15:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUJHTJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 15:09:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58305 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264377AbUJHTFz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 15:05:55 -0400
Message-ID: <4166E501.4000708@pobox.com>
Date: Fri, 08 Oct 2004 15:05:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org,
       marcelo.tosatti@cyclades.com
Subject: Re: [patch 2.4.28-pre3] 3c59x: resync with 2.6
References: <20041008121307.C14378@tuxdriver.com>
In-Reply-To: <20041008121307.C14378@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:

>  static struct ethtool_ops vortex_ethtool_ops = {
> -	.get_drvinfo		= vortex_get_drvinfo,
> +	.get_drvinfo =		vortex_get_drvinfo,
>  };

reverting good style.


>  
> -static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> +#ifdef CONFIG_PCI
> +static int vortex_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>  {
> -	struct vortex_private *vp = (struct vortex_private *)dev->priv;
> +	struct vortex_private *vp = netdev_priv(dev);
>  	long ioaddr = dev->base_addr;
> -	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
> +	struct mii_ioctl_data *data = if_mii(rq);
>  	int phy = vp->phys[0] & 0x1f;
>  	int retval;
>  
>  	switch(cmd) {
>  	case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
> -	case SIOCDEVPRIVATE:		/* for binary compat, remove in 2.5 */
>  		data->phy_id = phy;
>  
>  	case SIOCGMIIREG:		/* Read MII PHY register. */
> -	case SIOCDEVPRIVATE+1:		/* for binary compat, remove in 2.5 */
>  		EL3WINDOW(4);
>  		data->val_out = mdio_read(dev, data->phy_id & 0x1f, data->reg_num & 0x1f);
>  		retval = 0;
>  		break;
>  
>  	case SIOCSMIIREG:		/* Write MII PHY register. */
> -	case SIOCDEVPRIVATE+2:		/* for binary compat, remove in 2.5 */

breaks ABI in the middle of a stable series



> @@ -144,6 +145,12 @@ struct mii_ioctl_data {
>  };
>  
>  
> +static inline struct mii_ioctl_data *if_mii(struct ifreq *rq)
> +{
> +	return (struct mii_ioctl_data *) &rq->ifr_ifru;
> +}
> +
> +

This should be in include/linux/mii.h like it is in 2.6.x.

	Jeff



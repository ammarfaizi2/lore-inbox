Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVAMSDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVAMSDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVAMSBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:01:33 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:60053 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261299AbVAMR4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:56:49 -0500
Date: Thu, 13 Jan 2005 12:54:22 -0500
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include PNP device names in /proc/ioports and debug output
Message-ID: <20050113175421.GQ6069@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org
References: <1105487544.31942.70.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105487544.31942.70.camel@eeyore>
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

Thanks,
Adam


On Tue, Jan 11, 2005 at 04:52:24PM -0700, Bjorn Helgaas wrote:
> Include PNP device names in /proc/ioports and when matching
> driver with devices.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> ===== drivers/pnp/driver.c 1.14 vs edited =====
> --- 1.14/drivers/pnp/driver.c	2003-03-09 16:44:14 -07:00
> +++ edited/drivers/pnp/driver.c	2005-01-11 14:57:28 -07:00
> @@ -94,7 +94,7 @@
>  	pnp_dev = to_pnp_dev(dev);
>  	pnp_drv = to_pnp_driver(dev->driver);
>  
> -	pnp_dbg("match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
> +	pnp_dbg("match found with the PnP device '%s' (%s) and the driver '%s'", dev->bus_id, pnp_dev->name, pnp_drv->name);
>  
>  	error = pnp_device_attach(pnp_dev);
>  	if (error < 0)
> ===== drivers/pnp/system.c 1.12 vs edited =====
> --- 1.12/drivers/pnp/system.c	2004-10-19 10:54:38 -06:00
> +++ edited/drivers/pnp/system.c	2005-01-11 11:21:49 -07:00
> @@ -21,18 +21,19 @@
>  	{	"",			0	}
>  };
>  
> -static void reserve_ioport_range(char *pnpid, int start, int end)
> +static void reserve_ioport_range(struct pnp_dev *dev, int start, int end)
>  {
>  	struct resource *res;
>  	char *regionid;
> +	int length = strlen(dev->dev.bus_id) + strlen(dev->name) + 8;
>  
> -	regionid = kmalloc(16, GFP_KERNEL);
> -	if ( regionid == NULL )
> +	regionid = kmalloc(length, GFP_KERNEL);
> +	if (regionid == NULL)
>  		return;
> -	snprintf(regionid, 16, "pnp %s", pnpid);
> -	res = request_region(start,end-start+1,regionid);
> -	if ( res == NULL )
> -		kfree( regionid );
> +	snprintf(regionid, length, "pnp %s (%s)", dev->dev.bus_id, dev->name);
> +	res = request_region(start, end - start + 1, regionid);
> +	if (res == NULL)
> +		kfree(regionid);
>  	else
>  		res->flags &= ~IORESOURCE_BUSY;
>  	/*
> @@ -41,15 +42,15 @@
>  	 * have double reservations.
>  	 */
>  	printk(KERN_INFO
> -		"pnp: %s: ioport range 0x%x-0x%x %s reserved\n",
> -		pnpid, start, end,
> +		"pnp: %s (%s): ioport range 0x%x-0x%x %s reserved\n",
> +		dev->dev.bus_id, dev->name, start, end,
>  		NULL != res ? "has been" : "could not be"
>  	);
>  
>  	return;
>  }
>  
> -static void reserve_resources_of_dev( struct pnp_dev *dev )
> +static void reserve_resources_of_dev(struct pnp_dev *dev)
>  {
>  	int i;
>  
> @@ -76,7 +77,7 @@
>  			/* Do nothing */
>  			continue;
>  		reserve_ioport_range(
> -			dev->dev.bus_id,
> +			dev,
>  			pnp_port_start(dev, i),
>  			pnp_port_end(dev, i)
>  		);
> 

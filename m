Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263526AbTC3JB2>; Sun, 30 Mar 2003 04:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263527AbTC3JB2>; Sun, 30 Mar 2003 04:01:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3844 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263526AbTC3JB0>; Sun, 30 Mar 2003 04:01:26 -0500
Date: Sun, 30 Mar 2003 10:12:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] pcmcia: add struct pcmcia_device
Message-ID: <20030330101243.D3375@flint.arm.linux.org.uk>
Mail-Followup-To: Dominik Brodowski <linux@brodo.de>,
	linux-kernel@vger.kernel.org
References: <20030329144547.GA17956@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030329144547.GA17956@brodo.de>; from linux@brodo.de on Sat, Mar 29, 2003 at 03:45:47PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, some comments on this patch.

On Sat, Mar 29, 2003 at 03:45:47PM +0100, Dominik Brodowski wrote:
> diff -ruN linux-original/drivers/pcmcia/cistpl.c linux/drivers/pcmcia/cistpl.c
> --- linux-original/drivers/pcmcia/cistpl.c	2003-03-29 15:16:03.000000000 +0100
> +++ linux/drivers/pcmcia/cistpl.c	2003-03-29 15:37:35.000000000 +0100
> @@ -1392,6 +1392,7 @@
>      ret = pcmcia_parse_tuple(handle, &tuple, parse);
>      return ret;
>  }
> +EXPORT_SYMBOL(read_tuple);
>  
>  /*======================================================================
>  
> @@ -1451,4 +1452,4 @@
>  
>      return CS_SUCCESS;
>  }
> -
> +EXPORT_SYMBOL(pcmcia_validate_cis);
> diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
> --- linux-original/drivers/pcmcia/ds.c	2003-03-29 15:22:14.000000000 +0100
> +++ linux/drivers/pcmcia/ds.c	2003-03-29 15:37:35.000000000 +0100
> @@ -108,11 +108,16 @@
>  	struct device		*socket_dev;
>  	struct list_head	socket_list;
>  	unsigned int		socket_no; /* deprecated */
> +	/* the PCMCIA devices connected to this socket (normally one, more
> +	 * for multifunction devices: */
> +	struct list_head	devices_list;
> +	struct semaphore	devices_list_sem;
>  };
>  
>  #define SOCKET_PRESENT		0x01
>  #define SOCKET_BUSY		0x02
>  #define SOCKET_REMOVAL_PENDING	0x10
> +#define SOCKET_ADDING_PENDING	0x20
>  
>  /*====================================================================*/
>  
> @@ -121,6 +126,12 @@
>  
>  static int major_dev = -1;
>  
> +/* this is set to 1 when the iomem/ioport configuration of rsrc_mgr.c
> + * is completed -- only then it is possible to decode the name, manfid,
> + * prodid, etc. of the pcmcia card.
> + */
> +static int resources_available = 0;
> +

This isn't actually such a clear-cut situation.  Statically mapped
sockets like SA11x0-based stuff are able to access the card with no
resources loaded - in fact, there are no resources to be loaded.

One of my patches (which was the troublesome pcmcia-10 patch from akpm's
patch set) changes the way we deal with the CIS.  For windowed sockets,
when a card detected, we immediately try to claim a resource for the CIS
window.  If this fails, we whinge about "PCMCIA: insert failed" but
continue anyway.  We could fail at this point.

When resources are changed, I simulate a card removal + insertion request
so that the CIS gets re-setup.  The longer term solution, imho, is to
change the socket setup/reset/unreset code in cs.c to be more of a state
machine which could be re-started when resources become available.

> +	/* first case: no resources are available, so we can't decode
> +	 * any device information */
> +	if (!resources_available) {
> +		sprintf (p_dev->dev.bus_id, "pcmcia%d:%d.?", 
> +			 s->socket_dev->class_num, s->socket_no);
> +		sprintf (p_dev->dev.name, "unknown");
> +		ret = device_register(&p_dev->dev);
> +		if (ret) {
> +			kfree(p_dev);
> +			goto out;
> +		}
> +		list_add(&p_dev->socket_device_list, &s->devices_list);
> +		goto out;
> +	}

I'm not completely sure we want to add a device in this case - if we don't
have any resources, there isn't much point in making the device available
to drivers.

> +	if (!func) {
> +		cisinfo_t cisinfo;
> +		ret = pcmcia_validate_cis(s->handle, &cisinfo);
> +		if (ret || !cisinfo.Chains) {
> +			printk(KERN_INFO "pcmcia: inserted card has invalid CIS.\n");

I have a memory-type pcmcia card here, and I believe it doesn't have any
CIS what so ever, so this would fail.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


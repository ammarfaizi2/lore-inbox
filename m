Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWCIPYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWCIPYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 10:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWCIPYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 10:24:40 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50564 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751810AbWCIPYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 10:24:40 -0500
Date: Thu, 9 Mar 2006 10:24:38 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Horst Schirmeier <horst@schirmeier.com>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usbcore: usb_set_configuration oops (NULL ptr dereference)
In-Reply-To: <20060309131048.GL22994@quickstop.soohrt.org>
Message-ID: <Pine.LNX.4.44L0.0603091023430.5232-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2006, Horst Schirmeier wrote:

> When trying to deconfigure a device via usb_set_configuration(dev, 0),
> 2.6.16-rc kernels after 55c527187c9d78f840b284d596a0b298bc1493af oops
> with "Unable to handle NULL pointer dereference at...". This is due to
> an unchecked dereference of cp in the power budget part.
> 
> Signed-off-by: Horst Schirmeier <horst@schirmeier.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>

> 
> ---
> 
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 7135e54..96cabeb 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1388,11 +1388,13 @@ free_interfaces:
>  	if (dev->state != USB_STATE_ADDRESS)
>  		usb_disable_device (dev, 1);	// Skip ep0
>  
> -	i = dev->bus_mA - cp->desc.bMaxPower * 2;
> -	if (i < 0)
> -		dev_warn(&dev->dev, "new config #%d exceeds power "
> -				"limit by %dmA\n",
> -				configuration, -i);
> +	if (cp) {
> +		i = dev->bus_mA - cp->desc.bMaxPower * 2;
> +		if (i < 0)
> +			dev_warn(&dev->dev, "new config #%d exceeds power "
> +					"limit by %dmA\n",
> +					configuration, -i);
> +	}
>  
>  	if ((ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
>  			USB_REQ_SET_CONFIGURATION, 0, configuration, 0,



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267688AbTCFCIC>; Wed, 5 Mar 2003 21:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267692AbTCFCIC>; Wed, 5 Mar 2003 21:08:02 -0500
Received: from [203.94.130.164] ([203.94.130.164]:36315 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S267688AbTCFCIA>;
	Wed, 5 Mar 2003 21:08:00 -0500
Date: Thu, 6 Mar 2003 13:07:58 +1100 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: Dominik Brodowski <linux@brodo.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: pcmcia no worky in 2.5.6[32]
In-Reply-To: <20030305063635.GA2507@brodo.de>
Message-ID: <Pine.LNX.4.44.0303061307130.15121-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Mar 2003, Dominik Brodowski wrote:

> Hi,
> 
> On Wed, Mar 05, 2003 at 11:54:36AM +1100, Brett wrote:
> > On Mon, 3 Mar 2003, Dominik Brodowski wrote:
> > 
> > > > Hey,
> > > > 
> > > > since 2.5.62, I've not been able to get pcmcia working.
> > > > 
> > > > Hardware: toshiba 100CS
> > > > 
> > > > I've attached my .config for 2.5.63,
> > > > and a dmesg directly after boot for 2.5.61 and 2.5.63
> > > > 
> > > > any other details needed, please let me know
> > > > 
> > > > thanks,
> > > > 
> > > > 	/ Brett
> > > 
> > > Could you please try this patch? It *should* fix this problem:
> > > 
> > 
> > Sadly, it didn't do a thing
> > same dmesg/no pcmcia as vanilla 2.5.63
> > 
> > any other ideas ??
> 
> Yes: platform_match within the pcmcia core wasn't doing was it was supposed
> to do... and it still doesn't work in 2.5.64. So could you please try if it
> works with this patch against 2.5.64?
> 

Yep, the patch fixed it.
Now happy in 2.5.64 with pcmcia again

many thanks,

	/ Brett

> 
> 
> diff -ruN linux-original/drivers/base/platform.c linux/drivers/base/platform.c
> --- linux-original/drivers/base/platform.c	2003-03-05 07:19:19.000000000 +0100
> +++ linux/drivers/base/platform.c	2003-03-05 07:22:31.000000000 +0100
> @@ -59,12 +59,9 @@
>  
>  static int platform_match(struct device * dev, struct device_driver * drv)
>  {
> -	char name[BUS_ID_SIZE];
> +	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
>  
> -	if (sscanf(dev->bus_id,"%s",name))
> -		return (strcmp(name,drv->name) == 0);
> -
> -	return 0;
> +	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
>  }
>  
>  struct bus_type platform_bus_type = {
> diff -ruN linux-original/drivers/pcmcia/hd64465_ss.c linux/drivers/pcmcia/hd64465_ss.c
> --- linux-original/drivers/pcmcia/hd64465_ss.c	2003-03-05 07:19:13.000000000 +0100
> +++ linux/drivers/pcmcia/hd64465_ss.c	2003-03-05 07:35:34.000000000 +0100
> @@ -1070,8 +1070,8 @@
>  	}
>  
>  /*	hd64465_io_debug = 0; */
> -	platform_device_register(&hd64465_device);
>  	hd64465_device.dev.class_data = &hd64465_data;
> +	platform_device_register(&hd64465_device);
>  
>  	return 0;
>  }
> diff -ruN linux-original/drivers/pcmcia/i82365.c linux/drivers/pcmcia/i82365.c
> --- linux-original/drivers/pcmcia/i82365.c	2003-03-05 07:19:13.000000000 +0100
> +++ linux/drivers/pcmcia/i82365.c	2003-03-05 07:35:34.000000000 +0100
> @@ -1628,11 +1628,11 @@
>  	request_irq(cs_irq, pcic_interrupt, 0, "i82365", pcic_interrupt);
>  #endif
>      
> -    platform_device_register(&i82365_device);
> -
>      i82365_data.nsock = sockets;
>      i82365_device.dev.class_data = &i82365_data;
>      
> +    platform_device_register(&i82365_device);
> +
>      /* Finally, schedule a polling interrupt */
>      if (poll_interval != 0) {
>  	poll_timer.function = pcic_interrupt_wrapper;
> diff -ruN linux-original/drivers/pcmcia/tcic.c linux/drivers/pcmcia/tcic.c
> --- linux-original/drivers/pcmcia/tcic.c	2003-03-05 07:19:13.000000000 +0100
> +++ linux/drivers/pcmcia/tcic.c	2003-03-05 07:35:34.000000000 +0100
> @@ -452,8 +452,6 @@
>  	sockets++;
>      }
>  
> -    platform_device_register(&tcic_device);
> -
>      switch (socket_table[0].id) {
>      case TCIC_ID_DB86082:
>  	printk("DB86082"); break;
> @@ -527,6 +525,8 @@
>      tcic_data.nsock = sockets;
>      tcic_device.dev.class_data = &tcic_data;
>  
> +    platform_device_register(&tcic_device);
> +
>      return 0;
>      
>  } /* init_tcic */
> 


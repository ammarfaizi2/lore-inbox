Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269321AbTCDIUG>; Tue, 4 Mar 2003 03:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269325AbTCDIUG>; Tue, 4 Mar 2003 03:20:06 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:11990 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S269321AbTCDIUE>; Tue, 4 Mar 2003 03:20:04 -0500
From: <mika.penttila@kolumbus.fi>
To: Dominik Brodowski <linux@brodo.de>, <torvalds@transmeta.com>,
       <jt@hpl.hp.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] pcmcia: get initialization ordering right [Was: [PATCH 2.5] : i82365 & platform_bus_type]
Date: Tue, 4 Mar 2003 10:30:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <20030304083031.JEP4145.fep02-app.kolumbus.fi@[193.229.5.109]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the problem is platform_match() :

static int platform_match(struct device * dev, struct device_driver * drv)
{
	return 0;
}

which effectively makes driver binding impossible, pcmcia_socket_class->add_device isn't called.

--Mika


> 
> Lähettäjä: Dominik Brodowski <linux@brodo.de>
> Päiväys: 2003/03/04 ti AM 09:39:15 GMT+02:00
> Vastaanottaja: torvalds@transmeta.com,  jt@hpl.hp.com
> Kopio: Linux kernel mailing list <linux-kernel@vger.kernel.org>, 
> 	Patrick Mochel <mochel@osdl.org>
> Aihe: [PATCH] pcmcia: get initialization ordering right [Was: [PATCH 2.5] : i82365 & platform_bus_type]
> 
> Hi,
> 
> On Mon, Mar 03, 2003 at 05:30:20PM -0800, Jean Tourrilhes wrote:
> > 	Hi,
> > 
> > 	I'm trying to get i82365 to work again, because I need to test
> <snip>
> > Intel PCIC probe: 
> >   Vadem VG-469 ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
> >     host opts [0]: none
> >     host opts [1]: none
> >     ISA irqs (scanned) = 4,5 polling interval = 1000 ms
> > ds: no socket drivers loaded!
> 
> Sorry about that -- I mixed up the ordering of initializing the class data
> and registering the platform device. Here's a bugfix for the three pcmcia
> socket drivers that are platform devices.
> 
> Please apply,
> 	Dominik
> 
> diff -ruN linux-original/drivers/pcmcia/hd64465_ss.c linux/drivers/pcmcia/hd64465_ss.c
> --- linux-original/drivers/pcmcia/hd64465_ss.c	2003-03-04 08:27:06.000000000 +0100
> +++ linux/drivers/pcmcia/hd64465_ss.c	2003-03-04 08:30:37.000000000 +0100
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
> --- linux-original/drivers/pcmcia/i82365.c	2003-03-04 08:27:06.000000000 +0100
> +++ linux/drivers/pcmcia/i82365.c	2003-03-04 08:28:28.000000000 +0100
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
> --- linux-original/drivers/pcmcia/tcic.c	2003-03-04 08:27:06.000000000 +0100
> +++ linux/drivers/pcmcia/tcic.c	2003-03-04 08:30:03.000000000 +0100
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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBNLOu>; Wed, 14 Feb 2001 06:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBNLOa>; Wed, 14 Feb 2001 06:14:30 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:38678 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129055AbRBNLOW>; Wed, 14 Feb 2001 06:14:22 -0500
Date: Wed, 14 Feb 2001 05:14:19 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Tim Waugh <twaugh@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug
In-Reply-To: <20010214105332.U9459@redhat.com>
Message-ID: <Pine.LNX.3.96.1010214051314.12910E-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Tim Waugh wrote:

> On Wed, Feb 14, 2001 at 02:03:07AM -0600, Jeff Garzik wrote:
> 
> > If pci_register_driver returns < 0, the driver is not registered with
> > the system.
> 
> Thanks.  Okay, second try:
> 
> 2001-01-14  Tim Waugh  <twaugh@redhat.com>
> 
> 	* parport_pc.c: Fix PCI driver list corruption on
> 	unsuccessful module load (Andrew Morton).
> 
> --- linux/drivers/parport/parport_pc.c.init	Wed Feb 14 10:49:28 2001
> +++ linux/drivers/parport/parport_pc.c	Wed Feb 14 10:50:31 2001
> @@ -89,6 +89,7 @@
>  } superios[NR_SUPERIOS] __devinitdata = { {0,},};
>  
>  static int user_specified __devinitdata = 0;
> +static int registered_parport;
>  
>  /* frob_control, but for ECR */
>  static void frob_econtrol (struct parport *pb, unsigned char m,
> @@ -2605,8 +2606,10 @@
>  	count += parport_pc_find_nonpci_ports (autoirq, autodma);
>  
>  	r = pci_register_driver (&parport_pc_pci_driver);
> -	if (r > 0)
> +	if (r >= 0) {
> +		registered_parport = 1;
>  		count += r;
> +	}
>  
>  	return count;
>  }

Should the call to pci_unregister_driver in cleanup_module be
conditional on registered_parport as well?  I didn't check...

Also, is it possible to convert parport_pc to new-style module_init()?

	Jeff





Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131502AbRBNIDd>; Wed, 14 Feb 2001 03:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131631AbRBNIDY>; Wed, 14 Feb 2001 03:03:24 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:30526 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131502AbRBNIDK>; Wed, 14 Feb 2001 03:03:10 -0500
Date: Wed, 14 Feb 2001 02:03:07 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Tim Waugh <twaugh@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug
In-Reply-To: <20010213234349.O9459@redhat.com>
Message-ID: <Pine.LNX.3.96.1010214020126.28011B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Tim Waugh wrote:
> Here's a patch that fixes a bug that can cause PCI driver list
> corruption.  If parport_pc's init_module fails after it calls
> pci_register_driver, cleanup_module isn't called and so it's still
> registered when it gets unloaded.

> --- linux/drivers/parport/parport_pc.c.init	Tue Feb 13 23:31:25 2001
> +++ linux/drivers/parport/parport_pc.c	Tue Feb 13 23:35:56 2001
> @@ -89,6 +89,7 @@
>  } superios[NR_SUPERIOS] __devinitdata = { {0,},};
>  
>  static int user_specified __devinitdata = 0;
> +static int registered_parport;
>  
>  /* frob_control, but for ECR */
>  static void frob_econtrol (struct parport *pb, unsigned char m,
> @@ -2605,6 +2606,7 @@
>  	count += parport_pc_find_nonpci_ports (autoirq, autodma);
>  
>  	r = pci_register_driver (&parport_pc_pci_driver);
> +	registered_parport = 1;
>  	if (r > 0)
>  		count += r;

Bad patch.  It should be

	if (r >= 0) {
		registered_parport = 1;
		if (r > 0)
			count += r;
	}

If pci_register_driver returns < 0, the driver is not registered with
the system.

	Jeff





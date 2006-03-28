Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWC1QSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWC1QSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWC1QSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:18:15 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:63007 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751066AbWC1QSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:18:14 -0500
In-Reply-To: <Pine.LNX.4.44.0603241429220.19557-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0603241429220.19557-100000@gate.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <52F4EC29-680D-4F23-AF10-A4986B375AF0@kernel.crashing.org>
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       LKML mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] compile error when building multiple EHCI host controllers as modules
Date: Tue, 28 Mar 2006 10:18:17 -0600
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 24, 2006, at 2:32 PM, Kumar Gala wrote:

>> The issue I have this is that it makes two (or more) things that were
>> independent now dependent.  What about just moving the module_init/
>> exit() functions into files that are built separately.  For the ehci-
>> fsl case it was trivial, need to look at ehci-pci case.
>
> Ok, my idea required exporting things I didn't really want to  
> export, so
> what about something like this or where you thinking of some more
> sophisticated?
>
> If this is good, I'll do the same for ohci.

David, any comments?

- k

> diff --git a/drivers/usb/host/ehci-au1xxx.c b/drivers/usb/host/ehci- 
> au1xxx.c
> index 63eadee..036a1c0 100644
> --- a/drivers/usb/host/ehci-au1xxx.c
> +++ b/drivers/usb/host/ehci-au1xxx.c
> @@ -280,18 +280,3 @@ static struct device_driver ehci_hcd_au1
>  	/*.suspend      = ehci_hcd_au1xxx_drv_suspend, */
>  	/*.resume       = ehci_hcd_au1xxx_drv_resume, */
>  };
> -
> -static int __init ehci_hcd_au1xxx_init(void)
> -{
> -	pr_debug(DRIVER_INFO " (Au1xxx)\n");
> -
> -	return driver_register(&ehci_hcd_au1xxx_driver);
> -}
> -
> -static void __exit ehci_hcd_au1xxx_cleanup(void)
> -{
> -	driver_unregister(&ehci_hcd_au1xxx_driver);
> -}
> -
> -module_init(ehci_hcd_au1xxx_init);
> -module_exit(ehci_hcd_au1xxx_cleanup);
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index f985f12..30410c2 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -339,28 +339,3 @@ static struct platform_driver ehci_fsl_m
>  		   .name = "fsl-usb2-mph",
>  		   },
>  };
> -
> -static int __init ehci_fsl_init(void)
> -{
> -	int retval;
> -
> -	pr_debug("%s: block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd\n",
> -		 hcd_name,
> -		 sizeof(struct ehci_qh), sizeof(struct ehci_qtd),
> -		 sizeof(struct ehci_itd), sizeof(struct ehci_sitd));
> -
> -	retval = platform_driver_register(&ehci_fsl_dr_driver);
> -	if (retval)
> -		return retval;
> -
> -	return platform_driver_register(&ehci_fsl_mph_driver);
> -}
> -
> -static void __exit ehci_fsl_cleanup(void)
> -{
> -	platform_driver_unregister(&ehci_fsl_mph_driver);
> -	platform_driver_unregister(&ehci_fsl_dr_driver);
> -}
> -
> -module_init(ehci_fsl_init);
> -module_exit(ehci_fsl_cleanup);
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 79f2d8b..549ce59 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -905,3 +905,57 @@ MODULE_LICENSE ("GPL");
>  #ifndef	EHCI_BUS_GLUED
>  #error "missing bus glue for ehci-hcd"
>  #endif
> +
> +static int __init ehci_hcd_init(void)
> +{
> +	int retval = 0;
> +
> +	pr_debug("%s: block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd\n",
> +		 hcd_name,
> +		 sizeof(struct ehci_qh), sizeof(struct ehci_qtd),
> +		 sizeof(struct ehci_itd), sizeof(struct ehci_sitd));
> +
> +#ifdef CONFIG_PPC_83xx
> +	retval = platform_driver_register(&ehci_fsl_dr_driver);
> +	if (retval < 0)
> +		return retval;
> +
> +	retval = platform_driver_register(&ehci_fsl_dr_driver);
> +	if (retval < 0)
> +		return retval;
> +#endif
> +
> +#ifdef CONFIG_SOC_AU1X00
> +	pr_debug(DRIVER_INFO " (Au1xxx)\n");
> +
> +	retval = driver_register(&ehci_hcd_au1xxx_driver);
> +	if (retval < 0)
> +		return retval;
> +#endif
> +
> +#ifdef CONFIG_PCI
> +	retval = pci_register_driver(&ehci_pci_driver);
> +	if (retval < 0)
> +		return retval;
> +#endif
> +
> +	return retval;
> +}
> +
> +static void __exit ehci_hcd_cleanup(void)
> +{
> +#ifdef CONFIG_PPC_83xx
> +	platform_driver_unregister(&ehci_fsl_mph_driver);
> +	platform_driver_unregister(&ehci_fsl_dr_driver);
> +#endif
> +#ifdef CONFIG_SOC_AU1X00
> +	driver_unregister(&ehci_hcd_au1xxx_driver);
> +#endif
> +#ifdef CONFIG_PCI
> +	pci_unregister_driver(&ehci_pci_driver);
> +#endif
> +}
> +
> +module_init(ehci_hcd_init);
> +module_exit(ehci_hcd_cleanup);
> +
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 1e03f1a..e0641bc 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -370,23 +370,3 @@ static struct pci_driver ehci_pci_driver
>  	.resume =	usb_hcd_pci_resume,
>  #endif
>  };
> -
> -static int __init ehci_hcd_pci_init(void)
> -{
> -	if (usb_disabled())
> -		return -ENODEV;
> -
> -	pr_debug("%s: block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd\n",
> -		hcd_name,
> -		sizeof(struct ehci_qh), sizeof(struct ehci_qtd),
> -		sizeof(struct ehci_itd), sizeof(struct ehci_sitd));
> -
> -	return pci_register_driver(&ehci_pci_driver);
> -}
> -module_init(ehci_hcd_pci_init);
> -
> -static void __exit ehci_hcd_pci_cleanup(void)
> -{
> -	pci_unregister_driver(&ehci_pci_driver);
> -}
> -module_exit(ehci_hcd_pci_cleanup);
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTJVGQc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 02:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTJVGQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 02:16:32 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:36055 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S263273AbTJVGQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 02:16:28 -0400
Date: Wed, 22 Oct 2003 08:16:20 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi <linux-acpi@intel.com>
Subject: Re: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup -- same with .22-ac4
Message-ID: <20031022061620.GA82@pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
References: <7F740D512C7C1046AB53446D3720017304AEF1@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AEF1@scsmsx402.sc.intel.com>
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: OpenPGP or S/MIME encrypted e-mail is welcome.
X-01-Privacy-Policy-GPG-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?search=dzieko@pwr.wroc.pl&op=get
X-02-Privacy-Policy-GPG-Key_ID: 5AA7253D
X-03-Privacy-Policy-GPG-Key_fingerprint: A80B 5022 185B 1BB5 8848  74C4 A7E1 423C 5AA7 253D
X-04-Privacy-Policy-Personal_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=000001D2&certdir=/usr/local/cafe/data/polish_ca/certs/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On pon, 01 wrz 2003 at 07:07:32  -0700, Nakajima, Jun wrote:
> Can you try the following patch that I sent out the other day? I saw
> this message when I was debugging, and it's gone with the patch. I
> assume you have ACPI enabled.

Hi,

after upgrading to 2.4.22-ac4 your patch does not apply
and I still have hard lockup with acpi enabled.

thanks in advance, P

> Thanks,
> Jun
> 
> > -----Original Message-----
> > From: Pawel Dziekonski [mailto:pawel.dziekonski@pwr.wroc.pl]
> > Sent: Monday, September 01, 2003 8:36 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: Re: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
> > 
> > On nie, 31 sie 2003 at 04:11:25  +0200, Pawel Dziekonski wrote:
> > > Hi,
> > >
> > > clean 2.4.22-ac1, load of usb-uhci.o locks my machine hard :-(
> > > it was working OK with 2.4.22-rc2-ac2! machine is on KT133 chipset.
> > > I cant use plain 2.4.22 because of trouble of compiling it with XFS
> > > support (unofficial patch has no .config entries).
> > 
> > update: i have compiled usbcore and usb-uhci into the kernel
> > and now it hangs with:
> > spurious 8259A interrupt: IRQ7
> > 
> > anybody?
> > --
> > Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
> > Wroclaw Networking & Supercomputing Center, HPC Department
> > -> See message headers for privacy policy info.
> > -
> ---
> diff -ru /build/orig/linux-2.4.23-pre1/drivers/acpi/pci_link.c
> linux-2.4.23-pre1/drivers/acpi/pci_link.c
> --- /build/orig/linux-2.4.23-pre1/drivers/acpi/pci_link.c
> 2003-08-25 04:44:41.000000000 -0700
> +++ linux-2.4.23-pre1/drivers/acpi/pci_link.c	2003-08-29
> 20:21:13.000000000 -0700
> @@ -216,7 +216,6 @@
>  	return AE_CTRL_TERMINATE;
>  }
>  
> -
>  static int
>  acpi_pci_link_get_current (
>  	struct acpi_pci_link	*link)
> @@ -275,6 +274,26 @@
>  	return_VALUE(result);
>  }
>  
> +static int
> +acpi_pci_link_try_get_current (
> +	struct acpi_pci_link *link,
> +	int irq)
> +{
> +	int result;
> +
> +	result = acpi_pci_link_get_current(link);
> +	if (result && link->irq.active) {
> + 		return_VALUE(result);
> + 	}
> +
> +	if (!link->irq.active) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No active IRQ resource
> found\n"));
> +		printk(KERN_WARNING "_CRS returns NULL! Using IRQ %d for
> device (%s [%s]).\n", irq, acpi_device_name(link->device),
> acpi_device_bid(link->device));
> +		link->irq.active = irq;
> +	}
> +	
> +	return 0;
> +}
>  
>  static int
>  acpi_pci_link_set (
> @@ -359,7 +378,7 @@
>  	}
>  
>  	/* Make sure the active IRQ is the one we requested. */
> -	result = acpi_pci_link_get_current(link);
> +	result = acpi_pci_link_try_get_current(link, irq);
>  	if (result) {
>  		return_VALUE(result);
>  	}
> @@ -573,10 +592,6 @@
>  		else
>  			printk(" %d", link->irq.possible[i]);
>  	}
> -	if (!link->irq.active)
> -		printk(", disabled");
> -	else if (!found)
> -		printk(", enabled at IRQ %d", link->irq.active);
>  	printk(")\n");
>  
>  	/* TBD: Acquire/release lock */
> 
> 
> 

-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.

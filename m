Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133083AbREBMxg>; Wed, 2 May 2001 08:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133105AbREBMx0>; Wed, 2 May 2001 08:53:26 -0400
Received: from as2-2-8.kt.g.bonet.se ([194.236.2.9]:3076 "HELO mail.fatbob.nu")
	by vger.kernel.org with SMTP id <S133083AbREBMxR>;
	Wed, 2 May 2001 08:53:17 -0400
From: martin@fatbob.nu
Date: Wed, 2 May 2001 14:53:05 +0200
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4, 2.4.4-ac1 and -ac3: oops loading future domain scsi module
Message-ID: <20010502145305.B6889@kungen.fatbob.nu>
In-Reply-To: <20010502083018.A5717@qn-212-127-137-79.fluido.as> <20010502090359.A484@qn-212-127-137-79.fluido.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010502090359.A484@qn-212-127-137-79.fluido.as>; from fluido@fluido.as on Wed, May 02, 2001 at 09:03:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 09:03:59AM +0200, Carlo E. Prelz wrote:

> 	Subject: 2.4.4, 2.4.4-ac1 and -ac3: oops loading future domain scsi module
> 	Date: Wed, May 02, 2001 at 08:30:18AM +0200
> 
> Quoting Carlo E. Prelz (fluido@fluido.as):
> 
> > Here I am with another, fresh oops that I encountered while exploring
> > new kernels. This time, the oops is generated when trying to load the
> > module for a very old (1993) Future Domain SCSI card. 2.4.3-ac7 was my
> > previous kernel and worked perfectly. 
> 
> I made some more research. Eventually, it seems the problem is in this
> patch that was included in 2.4.4:
> 
> @@ -969,6 +971,7 @@
>         return 0;
>     shpnt->irq = interrupt_level;
>     shpnt->io_port = port_base;
> +   scsi_set_pci_device(shpnt->pci_dev, pdev);
>     shpnt->n_io_port = 0x10;
>     print_banner( shpnt );
> 
> Well, but my card is ISA! It should not set any PCI device. 
> 
> I applied the following patch, and the problem disappeared:
> 
> --- fdomain.c~	Wed May  2 07:08:27 2001
> +++ fdomain.c	Wed May  2 08:58:03 2001
> @@ -971,6 +971,7 @@
>     	return 0;
>     shpnt->irq = interrupt_level;
>     shpnt->io_port = port_base;
> +	 if(pdev!=NULL)
>     scsi_set_pci_device(shpnt->pci_dev, pdev);
>     shpnt->n_io_port = 0x10;
>     print_banner( shpnt );
> 
> I hope this is the right way...

Well I got the same oops with a PCI card...
After some research I found that the first argument to the inline
function scsi_set_pci_device is supposed to be a pointer to a
struct Scsi_Host.
The patch below should work for both ISA and PCI.

Regards
/Martin


--- fdomain.c.orig	Wed May  2 13:33:09 2001
+++ fdomain.c	Wed May  2 14:04:45 2001
@@ -971,7 +971,7 @@
    	return 0;
    shpnt->irq = interrupt_level;
    shpnt->io_port = port_base;
-   scsi_set_pci_device(shpnt->pci_dev, pdev);
+   scsi_set_pci_device(shpnt, pdev);
    shpnt->n_io_port = 0x10;
    print_banner( shpnt );
 



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283618AbRLWFRD>; Sun, 23 Dec 2001 00:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283658AbRLWFQn>; Sun, 23 Dec 2001 00:16:43 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:46600 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283618AbRLWFQk>; Sun, 23 Dec 2001 00:16:40 -0500
Message-ID: <3C256851.CD91C2A@zip.com.au>
Date: Sat, 22 Dec 2001 21:14:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Phil Brutsche <pbrutsch@tux.creighton.edu>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.17 compile error + fix
In-Reply-To: <1009081736.968.0.camel@fury>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Brutsche wrote:
> 
> --- linux/drivers/usb/usb-uhci.c        Fri Dec 21 11:41:55 2001
> +++ linux-2.4.17-modified/drivers/usb/usb-uhci.c        Sat Dec 22
> 22:10:27 2001
> @@ -3001,7 +3001,7 @@
>         s->irq = irq;
> 
>         if(uhci_start_usb (s) < 0) {
> -               uhci_pci_remove(dev);
> +               __devexit_p (uhci_pci_remove(dev));
>                 return -1;
>         }
>

If uhci_start_usb() fails, the driver still wants to call
uhci_pci_remove() to clean stuff up.  Same with bttv.



--- linux-2.4.17/drivers/media/video/bttv-driver.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/media/video/bttv-driver.c	Sat Dec 22 21:09:22 2001
@@ -2820,7 +2820,7 @@ static void bttv_irq(int irq, void *dev_
  *	Scan for a Bt848 card, request the irq and map the io memory 
  */
 
-static void __devexit bttv_remove(struct pci_dev *pci_dev)
+static void bttv_remove(struct pci_dev *pci_dev)
 {
         u8 command;
         int j;
@@ -3025,7 +3025,7 @@ static struct pci_driver bttv_pci_driver
         name:     "bttv",
         id_table: bttv_pci_tbl,
         probe:    bttv_probe,
-        remove:   __devexit_p(bttv_remove),
+        remove:   bttv_remove,
 };
 
 int bttv_init_module(void)
--- linux-2.4.17/drivers/usb/uhci.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/drivers/usb/uhci.c	Sat Dec 22 21:09:01 2001
@@ -2929,7 +2929,7 @@ static int __devinit uhci_pci_probe(stru
 	return -ENODEV;
 }
 
-static void __devexit uhci_pci_remove(struct pci_dev *dev)
+static void uhci_pci_remove(struct pci_dev *dev)
 {
 	struct uhci *uhci = pci_get_drvdata(dev);
 
@@ -2990,7 +2990,7 @@ static struct pci_driver uhci_pci_driver
 	id_table:	uhci_pci_ids,
 
 	probe:		uhci_pci_probe,
-	remove:		__devexit_p(uhci_pci_remove),
+	remove:		uhci_pci_remove,
 
 #ifdef	CONFIG_PM
 	suspend:	uhci_pci_suspend,

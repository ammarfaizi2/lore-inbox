Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSBODxP>; Thu, 14 Feb 2002 22:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSBODxF>; Thu, 14 Feb 2002 22:53:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17925 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286687AbSBODwy>;
	Thu, 14 Feb 2002 22:52:54 -0500
Message-ID: <3C6C85DF.FFC47676@zip.com.au>
Date: Thu, 14 Feb 2002 19:51:59 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] compile fixes
In-Reply-To: <3C6A2F86.E5C322D4@zip.com.au> <Pine.NEB.4.44.0202141452240.9063-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> On Wed, 13 Feb 2002, Andrew Morton wrote:
> 
> > This patch should fix all the remaining .text.exit problems
> > which have resulted from recent binutils changes.   For all
> > files which are accessible to an x86 build.
> >...
> > --- linux-2.4.18-pre9/drivers/sound/cs4232.c  Sun Sep 30 12:26:08 2001
> > +++ linux-akpm/drivers/sound/cs4232.c Tue Feb 12 23:47:28 2002
> > @@ -277,7 +277,7 @@ void __init attach_cs4232(struct address
> >       }
> >  }
> >
> > -void __exit unload_cs4232(struct address_info *hw_config)
> > +void unload_cs4232(struct address_info *hw_config)
> >  {
> >       int base = hw_config->io_base, irq = hw_config->irq;
> >       int dma1 = hw_config->dma, dma2 = hw_config->dma2;
> >...
> 
> unload_cs4232 is __exit
> the only non-__exit caller of unload_cs4232 is cs4232_isapnp_remove
> the only caller of cs4232_isapnp_remove (cleanup_cs4232) is __exit
> 
> Am I right to assume that the following alternative patch is correct, too?
> 

Yes, that's better.   Here's a patch against -rc1.  It also
fixes wdt_pci.c.  I missed all the watchdog cards on the
first pass.   Thanks.



--- linux-2.4.18-rc1/drivers/sound/cs4232.c	Wed Feb 13 12:59:14 2002
+++ linux-akpm/drivers/sound/cs4232.c	Thu Feb 14 18:57:21 2002
@@ -277,7 +277,7 @@ void __init attach_cs4232(struct address
 	}
 }
 
-void unload_cs4232(struct address_info *hw_config)
+static void __exit unload_cs4232(struct address_info *hw_config)
 {
 	int base = hw_config->io_base, irq = hw_config->irq;
 	int dma1 = hw_config->dma, dma2 = hw_config->dma2;
@@ -460,10 +460,12 @@ static int __init init_cs4232(void)
 	return 0;
 }
 
-int cs4232_isapnp_remove(struct pci_dev *dev, const struct isapnp_device_id *id)
+static int __exit cs4232_isapnp_remove(struct pci_dev *dev,
+			const struct isapnp_device_id *id)
 {
 	struct address_info *cfg = (struct address_info*)pci_get_drvdata(dev);
-	if (cfg) unload_cs4232(cfg);
+	if (cfg)
+		unload_cs4232(cfg);
 	pci_set_drvdata(dev,NULL);
 	dev->deactivate(dev);
 	return 0;
--- linux-2.4.18-rc1/drivers/char/wdt_pci.c	Wed Feb 13 12:59:10 2002
+++ linux-akpm/drivers/char/wdt_pci.c	Thu Feb 14 19:23:21 2002
@@ -577,7 +577,7 @@ out_reg:
 }
 
 
-static void __exit wdtpci_remove_one (struct pci_dev *pdev)
+static void __devexit wdtpci_remove_one (struct pci_dev *pdev)
 {
 	/* here we assume only one device will ever have
 	 * been picked up and registered by probe function */
@@ -602,7 +602,7 @@ static struct pci_driver wdtpci_driver =
 	name:		"wdt-pci",
 	id_table:	wdtpci_pci_tbl,
 	probe:		wdtpci_init_one,
-	remove:		wdtpci_remove_one,
+	remove:		__devexit_p(wdtpci_remove_one),
 };
 
 

-

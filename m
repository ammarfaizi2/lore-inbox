Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUEPAVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUEPAVh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 20:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264844AbUEPAVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 20:21:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53501 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264819AbUEPAV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 20:21:29 -0400
Date: Sun, 16 May 2004 02:21:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Samuel S Chessman <chessman@tux.org>
Subject: Re: [PATCH] fix tlan.c for !PCI
Message-ID: <20040516002124.GG22742@fs.tum.de>
References: <200405151823.i4FINj8T001262@hera.kernel.org> <40A6670F.3050300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A6670F.3050300@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 02:53:03PM -0400, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> >ChangeSet 1.1691, 2004/05/15 10:23:43-07:00, akpm@osdl.org
> >
> >	[PATCH] fix tlan.c for !PCI
> >	
> >	From: Adrian Bunk <bunk@fs.tum.de>
> >	
> >	drivers/net/tlan.c: In function `tlan_remove_one':
> >	drivers/net/tlan.c:449: warning: implicit declaration of function 
> >	`pci_release_regions'
> >
> >
> ># This patch includes the following deltas:
> >#	           ChangeSet	1.1690  -> 1.1691 
> >#	  drivers/net/tlan.c	1.31    -> 1.32   
> >#
> >
> > tlan.c |    4 ++++
> > 1 files changed, 4 insertions(+)
> >
> >
> >diff -Nru a/drivers/net/tlan.c b/drivers/net/tlan.c
> >--- a/drivers/net/tlan.c	Sat May 15 11:23:50 2004
> >+++ b/drivers/net/tlan.c	Sat May 15 11:23:50 2004
> >@@ -446,7 +446,9 @@
> > 		pci_free_consistent(priv->pciDev, priv->dmaSize, 
> > 		priv->dmaStorage, priv->dmaStorageDMA );
> > 	}
> > 
> >+#ifdef CONFIG_PCI
> > 	pci_release_regions(pdev);
> >+#endif
> 
> 
> Ug.  Please revert and fix it the right way.
> 
> Think about this one:  we are getting the warning inside a function that 
> will only ever be called when CONFIG_PCI is defined, the PCI ->remove hook.
> 
> IMO one of two things needs to happen:
> a) wrap the PCI probe functions in tlan.c with CONFIG_PCI

Updated patch below.

> 	or
> b) create the proper wrapper in include/linux/pci.h, following 
> established practice in that header

  http://www.ussg.iu.edu/hypermail/linux/kernel/0405.1/1204.html

cu
Adrian


--- linux-2.6.6-mm2-full/drivers/net/tlan.c.old	2004-05-16 02:09:52.000000000 +0200
+++ linux-2.6.6-mm2-full/drivers/net/tlan.c	2004-05-16 02:13:47.000000000 +0200
@@ -435,6 +435,7 @@
 	 **************************************************************/
 
 
+#ifdef CONFIG_PCI
 static void __devexit tlan_remove_one( struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata( pdev );
@@ -452,12 +453,15 @@
 		
 	pci_set_drvdata( pdev, NULL );
 } 
+#endif
 
 static struct pci_driver tlan_driver = {
 	.name		= "tlan",
 	.id_table	= tlan_pci_tbl,
 	.probe		= tlan_init_one,
+#ifdef CONFIG_PCI
 	.remove		= __devexit_p(tlan_remove_one),	
+#endif
 };
 
 static int __init tlan_probe(void)
@@ -673,8 +677,10 @@
 err_out_free_dev:
 	free_netdev(dev);
 err_out_regions:
+#ifdef CONFIG_PCI
 	if (pdev)
 		pci_release_regions(pdev);
+#endif
 err_out:
 	if (pdev)
 		pci_disable_device(pdev);

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSIWJ7Z>; Mon, 23 Sep 2002 05:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265343AbSIWJ7Z>; Mon, 23 Sep 2002 05:59:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63371 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265276AbSIWJ7Y>;
	Mon, 23 Sep 2002 05:59:24 -0400
Date: Mon, 23 Sep 2002 12:04:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 oopses at boot in ide_toggle_bounce
Message-ID: <20020923100424.GH25682@suse.de>
References: <UTC200209211211.g8LCBcW16848.aeb@smtp.cwi.nl> <20020923074142.GB15479@suse.de> <20020923100134.GA16260@win.tue.nl> <20020923100219.GG25682@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020923100219.GG25682@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23 2002, Jens Axboe wrote:
> On Mon, Sep 23 2002, Andries Brouwer wrote:
> > On Mon, Sep 23, 2002 at 09:41:42AM +0200, Jens Axboe wrote:
> > 
> > > Patch is fine, thanks Andries.
> > 
> > Yes, that patch allows the kernel to boot.
> > The booted system has two main problems that 2.5.33 does not have:
> > (i) It no longer sees my disks on an HPT366,
> > (ii) pgrp handling changed, so that some programs hang.
> 
> I'm assuming we are talking about 2.5.38? Can you send me the kernel
> boot log, thanks.

Ah hang on, please boot with this patch from Ivan. That should make it
work again.

--- linux/drivers/ide/setup-pci.c.bk	Sat Sep 21 12:58:45 2002
+++ linux/drivers/ide/setup-pci.c	Sat Sep 21 12:59:59 2002
@@ -421,20 +421,17 @@ static ide_hwif_t *ide_hwif_configure(st
 {
 	unsigned long ctl = 0, base = 0;
 	ide_hwif_t *hwif;
-	
-	if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
-	{
-	    	/*  Possibly we should fail if these checks report true */
-	    	ide_pci_check_iomem(dev, d, 2*port);
-	    	ide_pci_check_iomem(dev, d, 2*port+1);
-	 
-		ctl  = pci_resource_start(dev, 2*port+1);
-		base = pci_resource_start(dev, 2*port);
-		if ((ctl && !base) || (base && !ctl)) {
-			printk(KERN_ERR "%s: inconsistent baseregs (BIOS) "
-				"for port %d, skipping\n", d->name, port);
-			return NULL;
-		}
+
+	/*  Possibly we should fail if these checks report true */
+	ide_pci_check_iomem(dev, d, 2*port);
+	ide_pci_check_iomem(dev, d, 2*port+1);
+ 
+	ctl  = pci_resource_start(dev, 2*port+1);
+	base = pci_resource_start(dev, 2*port);
+	if ((ctl && !base) || (base && !ctl)) {
+		printk(KERN_ERR "%s: inconsistent baseregs (BIOS) "
+			"for port %d, skipping\n", d->name, port);
+		return NULL;
 	}
 	if (!ctl)
 	{


-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUHIWev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUHIWev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267318AbUHIWev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:34:51 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:15744 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267323AbUHIWcV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:32:21 -0400
Date: Tue, 10 Aug 2004 00:27:56 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Max Asbock <masbock@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibmasm: add missing pci_enable_device()
Message-ID: <20040809222756.GA1555@electric-eye.fr.zoreil.com>
References: <200408041532.55146.bjorn.helgaas@hp.com> <1092071925.3711.17.camel@w-amax> <200408091128.35896.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091128.35896.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> :
[...]
> > > ===== drivers/misc/ibmasm/module.c 1.2 vs edited =====
> > > --- 1.2/drivers/misc/ibmasm/module.c	2004-05-14 06:00:50 -06:00
> > > +++ edited/drivers/misc/ibmasm/module.c	2004-08-04 13:15:46 -06:00
> > > @@ -62,10 +62,17 @@
> > >  	int result = -ENOMEM;
> > >  	struct service_processor *sp;
> > >  
> > > +	if (pci_enable_device(pdev)) {
> > > +		printk(KERN_ERR "%s: can't enable PCI device at %s\n",
> > > +			DRIVER_NAME, pci_name(pdev));
> > > +		return -ENODEV;

Btw, pci_enable_device returns a perfectly fine status code. There is no
reason to override it ('result = pci_enable_device(...' and you can even 
remove the previous ENOMEM initialization).

[...]
> > >  	sp = kmalloc(sizeof(struct service_processor), GFP_KERNEL);
> > >  	if (sp == NULL) {
> > >  		dev_err(&pdev->dev, "Failed to allocate memory\n");
> > > -		return result;
> > > +		result = -ENOMEM;
> > > +		goto error_kmalloc;

You may consider calling it err_pci_disable (or such). This way:
- one can check that the kmalloc is preceeded by a pci_enable;
- one can locally check that the unroll path does its job
  (error_pci_disable is followed by a pci_disable_xxx -> makes sense).

--
Ueimor

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269458AbUI3UPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269458AbUI3UPB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269489AbUI3UOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:14:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:26274 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269458AbUI3UKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:10:37 -0400
Date: Thu, 30 Sep 2004 22:06:30 +0200
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Andi Kleen <ak@suse.de>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix improper use of pci_module_init() in drivers/char/agp/amd64-agp.c
Message-ID: <20040930200630.GB28315@wotan.suse.de>
References: <20040930184248.GA17546@kroah.com> <20040930192008.GA28315@wotan.suse.de> <20040930195905.GA18162@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930195905.GA18162@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 12:59:05PM -0700, Greg KH wrote:
> On Thu, Sep 30, 2004 at 09:20:09PM +0200, Andi Kleen wrote:
> > On Thu, Sep 30, 2004 at 11:42:48AM -0700, Greg KH wrote:
> > > Hi,
> > > 
> > > In going through the tree and auditing the usage of pci_module_init(), I
> > > noticed that the amd64-agp driver was assuming that the return value of
> > > this function could be greater than 0 (which is what could happen in 2.2
> > > and 2.4 kernels.)  As this is no longer true, I think the following
> > > patch is correct.
> > > 
> > > I can add this to my bk-pci tree if you wish, otherwise feel free to
> > > send it upwards.
> > 
> > There needs to be some replacement for it, you cannot just delete 
> > the code.
> 
> But that code has not ever run, since early 2.5 days.  Don't tell me
> people are used to it :)

No, but it's needed for new chipsets that are not in the PCI tables.
People probably didn't complain because we're covering the current
generation of K8 AGP bridges, but there should be new ones soon

2.4 had similar code.

> 
> > The idea is to run it as fallback when no devices are found. 
> > 
> > How about this patch?
> 
> That does not work the way you are asking it to work.  pci_module_init()
> is just a replacement for pci_register_driver these days.  It will
> return either "0" if the driver is successfully registered, or a
> negative value if something bad happened.  It will not return the number
> of devices that this driver bound to.
> 
> So, if no devices are in the system, it will return 0, and again, the
> code you are wanting to run, will not.

Oh, yes I forgot that hotplug makes everything simple complicated.

> 
> So, how about using the new pci_dev_present() call instead?  That should
> be what you want, right?


% grep pci_dev_present include/linux/*
% 

This patch will probably do and doesn't rely on any nonexisting
calls.

-Andi

----------------------------------------------------------------------

Fix fallback code in K8 AGP driver.

Problem pointed out by Greg KH

Signed-off-by: Andi Kleen <ak@suse.de>


diff -u linux-2.6.9rc3-work/drivers/char/agp/amd64-agp.c-o linux-2.6.9rc3-work/drivers/char/agp/amd64-agp.c
--- linux-2.6.9rc3-work/drivers/char/agp/amd64-agp.c-o	2004-09-30 10:35:07.000000000 +0200
+++ linux-2.6.9rc3-work/drivers/char/agp/amd64-agp.c	2004-09-30 22:04:56.000000000 +0200
@@ -55,6 +55,8 @@
 static int gart_iterator;
 #define for_each_nb() for(gart_iterator=0;gart_iterator<nr_garts;gart_iterator++)
 
+static int num_bridges;
+
 static void flush_amd64_tlb(struct pci_dev *dev)
 {
 	u32 tmp;
@@ -514,6 +516,7 @@
 	}
 
 	pci_set_drvdata(pdev, bridge);
+	num_bridges++;
 	return agp_add_bridge(bridge);
 }
 
@@ -627,7 +630,8 @@
 	int err = 0;
 	if (agp_off)
 		return -EINVAL;
-	if (pci_module_init(&agp_amd64_pci_driver) > 0) {
+	pci_module_init(&agp_amd64_pci_driver);
+	if (num_bridges == 0) { 
 		struct pci_dev *dev;
 		if (!agp_try_unsupported && !agp_try_unsupported_boot) {
 			printk(KERN_INFO PFX "No supported AGP bridge found.\n");



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269438AbUI3TYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269438AbUI3TYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269452AbUI3TYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:24:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:61420 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269438AbUI3TVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:21:24 -0400
Date: Thu, 30 Sep 2004 21:20:09 +0200
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Cc: davej@codemonkey.org.uk, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix improper use of pci_module_init() in drivers/char/agp/amd64-agp.c
Message-ID: <20040930192008.GA28315@wotan.suse.de>
References: <20040930184248.GA17546@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930184248.GA17546@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 11:42:48AM -0700, Greg KH wrote:
> Hi,
> 
> In going through the tree and auditing the usage of pci_module_init(), I
> noticed that the amd64-agp driver was assuming that the return value of
> this function could be greater than 0 (which is what could happen in 2.2
> and 2.4 kernels.)  As this is no longer true, I think the following
> patch is correct.
> 
> I can add this to my bk-pci tree if you wish, otherwise feel free to
> send it upwards.

There needs to be some replacement for it, you cannot just delete 
the code.


The idea is to run it as fallback when no devices are found. 

How about this patch?

-Andi



diff -u linux-2.6.9rc3-work/drivers/char/agp/amd64-agp.c-o linux-2.6.9rc3-work/drivers/char/agp/amd64-agp.c
--- linux-2.6.9rc3-work/drivers/char/agp/amd64-agp.c-o	2004-09-30 10:35:07.000000000 +0200
+++ linux-2.6.9rc3-work/drivers/char/agp/amd64-agp.c	2004-09-30 21:19:00.000000000 +0200
@@ -627,7 +627,7 @@
 	int err = 0;
 	if (agp_off)
 		return -EINVAL;
-	if (pci_module_init(&agp_amd64_pci_driver) > 0) {
+	if (pci_module_init(&agp_amd64_pci_driver) < 0) {
 		struct pci_dev *dev;
 		if (!agp_try_unsupported && !agp_try_unsupported_boot) {
 			printk(KERN_INFO PFX "No supported AGP bridge found.\n");



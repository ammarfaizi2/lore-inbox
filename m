Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269481AbUI3UK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269481AbUI3UK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269488AbUI3UK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:10:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:60861 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269481AbUI3UJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:09:14 -0400
Date: Thu, 30 Sep 2004 13:09:02 -0700
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix improper use of pci_module_init() in drivers/char/agp/amd64-agp.c
Message-ID: <20040930200902.GA18271@kroah.com>
References: <20040930184248.GA17546@kroah.com> <20040930192008.GA28315@wotan.suse.de> <20040930195905.GA18162@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930195905.GA18162@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 12:59:05PM -0700, Greg KH wrote:
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
> 
> So, how about using the new pci_dev_present() call instead?  That should
> be what you want, right?

Something like this perhaps?  (warning, not even compile tested...)

greg k-h

===== amd64-agp.c 1.33 vs edited =====
--- 1.33/drivers/char/agp/amd64-agp.c	2004-09-30 13:00:52 -07:00
+++ edited/amd64-agp.c	2004-09-30 13:07:07 -07:00
@@ -627,8 +627,15 @@
 	int err = 0;
 	if (agp_off)
 		return -EINVAL;
-	if (pci_module_init(&agp_amd64_pci_driver) > 0) {
+	if (pci_dev_present(agp_amd_pci_table))
+		return pci_register_driver(&agp_amd64_pci_driver);
+	else {
 		struct pci_dev *dev;
+		static struct pci_device_id amd64NB[] = {
+			{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1103) },
+			{ },
+		};
+
 		if (!agp_try_unsupported && !agp_try_unsupported_boot) {
 			printk(KERN_INFO PFX "No supported AGP bridge found.\n");
 #ifdef MODULE
@@ -640,13 +647,13 @@
 		}
 
 		/* First check that we have at least one AMD64 NB */
-		if (!pci_find_device(PCI_VENDOR_ID_AMD, 0x1103, NULL))
+		if (!pci_dev_present(amd64NB))
 			return -ENODEV;
 
 		/* Look for any AGP bridge */
 		dev = NULL;
 		err = -ENODEV;
-		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev))) {
+		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev))) {
 			if (!pci_find_capability(dev, PCI_CAP_ID_AGP))
 				continue;
 			/* Only one bridge supported right now */

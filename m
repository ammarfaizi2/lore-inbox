Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263906AbTJ1KEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 05:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTJ1KEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 05:04:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48909 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263906AbTJ1KEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 05:04:08 -0500
Date: Tue, 28 Oct 2003 10:04:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Prevent PCI driver registration failure oopsing
Message-ID: <20031028100402.F22424@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

As discussed about six or so months ago, we agreed to hold off this
patch until fairly late, due to its ability to catch duplicate PCI
driver names.  Please note that I haven't attempted to reproduce the
problem with recent kernels, and that all ARM kernel patches released
since then have had this patch in.

I'm guessing this will actually be 2.6.1 material since it probably
doesn't show for PCI drivers which are part of the kernel tree.


If pci_register_driver fails, the register the PCI driver structure
will not be registered with the driver model.  pci_register_driver
returns with negative value, and we then attempt to unregister the
driver structure.  This leads to an oops in the driver model.

The driver model does not return the number of devices it successfully
bound the driver to, and neither does pci_register_driver() return
this information.

Therefore, all of the code below is redundant.

(There's a little redundancy left in drivers/pci/pci-driver.c but it
is harmless unlike this block.)

--- orig/include/linux/pci.h	Thu Mar 13 14:24:56 2003
+++ linux/include/linux/pci.h	Wed Mar 12 19:37:41 2003
@@ -768,26 +768,7 @@
 {
 	int rc = pci_register_driver (drv);
 
-	if (rc > 0)
-		return 0;
-
-	/* iff CONFIG_HOTPLUG and built into kernel, we should
-	 * leave the driver around for future hotplug events.
-	 * For the module case, a hotplug daemon of some sort
-	 * should load a module in response to an insert event. */
-#if defined(CONFIG_HOTPLUG) && !defined(MODULE)
-	if (rc == 0)
-		return 0;
-#else
-	if (rc == 0)
-		rc = -ENODEV;		
-#endif
-
-	/* if we get here, we need to clean up pci driver instance
-	 * and return some sort of error */
-	pci_unregister_driver (drv);
-	
-	return rc;
+	return rc < 0 ? : 0;
 }
 
 /*


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

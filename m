Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUA3BtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUA3Ber
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:34:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:8412 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266509AbUA3BcB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:01 -0500
Subject: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <20040130012925.GA11727@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:45 -0800
Message-Id: <10754263054147@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1509, 2004/01/29 14:26:16-08:00, rmk+lkml@arm.linux.org.uk

[PATCH] Prevent PCI driver registration failure oopsing

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


 include/linux/pci.h |   21 +--------------------
 1 files changed, 1 insertion(+), 20 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jan 29 17:24:49 2004
+++ b/include/linux/pci.h	Thu Jan 29 17:24:49 2004
@@ -785,26 +785,7 @@
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
+	return rc < 0 ? rc : 0;
 }
 
 /*


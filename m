Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268660AbUJDWXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268660AbUJDWXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268650AbUJDWWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:22:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:36552 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268685AbUJDWPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:15:18 -0400
Date: Mon, 4 Oct 2004 15:11:08 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm1, bk-pci patch, USB hubs
Message-ID: <20041004221107.GC11110@kroah.com>
References: <9e473391041003113351c6e237@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391041003113351c6e237@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2004 at 02:33:48PM -0400, Jon Smirl wrote:
> These changes make the USB hub module fail to load. I get a trap in
> kmem_cache_alloc called from uhci_alloc_urb_private. Reverting them
> fixes it.

Thanks, but I've fixed up pci_register_driver() to not return a fake
"1", which was undocumented, and not a nice thing to do.

That patch is below, and is in my trees, which will cause it to show up
in the next -mm release.

thanks,

greg k-h


===== pci-driver.c 1.46 vs edited =====
--- 1.46/drivers/pci/pci-driver.c	2004-09-29 23:09:23 -07:00
+++ edited/pci-driver.c	2004-10-04 11:11:20 -07:00
@@ -396,13 +396,13 @@
  * @drv: the driver structure to register
  * 
  * Adds the driver structure to the list of registered drivers.
- * Returns a negative value on error. The driver remains registered
- * even if no device was claimed during registration.
+ * Returns a negative value on error, otherwise 0. 
+ * If no error occured, the driver remains registered even if 
+ * no device was claimed during registration.
  */
-int
-pci_register_driver(struct pci_driver *drv)
+int pci_register_driver(struct pci_driver *drv)
 {
-	int count = 0;
+	int error;
 
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
@@ -414,13 +414,12 @@
 	pci_init_dynids(&drv->dynids);
 
 	/* register with core */
-	count = driver_register(&drv->driver);
+	error = driver_register(&drv->driver);
 
-	if (count >= 0) {
+	if (!error)
 		pci_populate_driver_dir(drv);
-	}
 
-	return count ? count : 1;
+	return error;
 }
 
 /**

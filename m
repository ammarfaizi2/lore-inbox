Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUJDUK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUJDUK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUJDUK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:10:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:52871 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268282AbUJDUKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:10:55 -0400
Date: Mon, 4 Oct 2004 13:10:16 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Reuben Farrelly <reuben-news@reub.net>,
       Hanno Meyer-Thurow <h.mth@web.de>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (as387)] UHCI: check return code from pci_register_driver
Message-ID: <20041004201016.GA29771@kroah.com>
References: <20041001225636.76224a2c.akpm@osdl.org> <Pine.LNX.4.44L0.0410041125290.1358-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0410041125290.1358-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 11:33:35AM -0400, Alan Stern wrote:
> Greg:
> 
> This is all your fault!  :-)
> 
> The patch below fixes the problem in which the UHCI driver doesn't
> properly check the return code from pci_register_driver().

Yeah, it's all my fault, what else is new...

Anyway, no, my change to the uhci (and ohci and ehci drivers) is ok,
it's just that pci_register_driver() is incorrect :)

Here's a fix for it, that lets the USB host controllers work properly.
Now PCI works like the other bus drivers.  As we had no idea of how many
devices bound to the driver, this function was just lying and returning
"1".  What a stinker.

I'll add this to my trees, and I've gone through and audited all callers
of this function to now work properly (there were some pretty strange
ideas of what to do on an error returned from this function...)

Alan, these error messages lead me to believe that the error recovery
code in the uhci driver doesn't quite work properly, as even if the
register of the pci driver fails, we shouldn't error out with this mess,
right?

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

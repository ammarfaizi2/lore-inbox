Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270069AbUJSXW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270069AbUJSXW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270150AbUJSXRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:17:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:23178 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270176AbUJSWqn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:43 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225739880@kroah.com>
Date: Tue, 19 Oct 2004 15:42:19 -0700
Message-Id: <10982257392211@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.60, 2004/10/06 14:07:29-07:00, greg@kroah.com

[PATCH] PCI: fix up pci_register_driver() to stop lying in its return value.

It shouldn't return 1, it needs to return either -ERROR or 0.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-driver.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-10-19 15:22:08 -07:00
+++ b/drivers/pci/pci-driver.c	2004-10-19 15:22:08 -07:00
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
@@ -413,13 +413,12 @@
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


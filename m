Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVFQSbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVFQSbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVFQSbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:31:09 -0400
Received: from verein.lst.de ([213.95.11.210]:24969 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262050AbVFQSbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:31:04 -0400
Date: Fri, 17 Jun 2005 20:30:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: gregkh@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pci: don't override drv->shutdown unconditionally
Message-ID: <20050617183057.GA20966@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,REMOVE_REMOVAL_NEAR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are many drivers that have been setting the generic driver
model­level shutdown callback, and pci thus must not override it.

Without this patch we can have really bad data loss on various
raid controllers.


Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c	2005-05-05 11:01:03.000000000 +0200
+++ linux-2.6/drivers/pci/pci-driver.c	2005-06-17 18:44:52.000000000 +0200
@@ -393,7 +393,8 @@
 	drv->driver.bus = &pci_bus_type;
 	drv->driver.probe = pci_device_probe;
 	drv->driver.remove = pci_device_remove;
-	drv->driver.shutdown = pci_device_shutdown,
+	if (!drv->driver.shutdown)
+		drv->driver.shutdown = pci_device_shutdown,
 	drv->driver.owner = drv->owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 	pci_init_dynids(&drv->dynids);

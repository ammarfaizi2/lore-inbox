Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTFECDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTFECCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:02:03 -0400
Received: from granite.he.net ([216.218.226.66]:54534 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264380AbTFECB5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:01:57 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787464095@kroah.com>
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <10547787462276@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:46 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1229.25.2, 2003/05/28 16:37:35-05:00, Matt_Domsch@dell.com

dynids: free dynids on driver unload


 drivers/pci/pci-driver.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Wed Jun  4 18:12:25 2003
+++ b/drivers/pci/pci-driver.c	Wed Jun  4 18:12:25 2003
@@ -315,6 +315,22 @@
 	INIT_LIST_HEAD(&dynids->list);
 }
 
+static void
+pci_free_dynids(struct pci_driver *drv)
+{
+	struct list_head *pos, *n;
+	struct dynid *dynid;
+
+	spin_lock(&drv->dynids.lock);
+	list_for_each_safe(pos, n, &drv->dynids.list) {
+		dynid = list_entry(pos, struct dynid, node);
+		list_del(&dynid->node);
+		kfree(dynid);
+	}
+	spin_unlock(&drv->dynids.lock);
+}
+
+
 /**
  * pci_register_driver - register a new pci driver
  * @drv: the driver structure to register
@@ -363,6 +379,7 @@
 pci_unregister_driver(struct pci_driver *drv)
 {
 	driver_unregister(&drv->driver);
+	pci_free_dynids(drv);
 }
 
 static struct pci_driver pci_compat_driver = {


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbUB1AJp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbUB1AJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:09:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:47013 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263210AbUB1AJl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:09:41 -0500
Subject: [PATCH] PCI fixes for 2.6.4-rc1
In-Reply-To: <20040228000725.GB13346@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 27 Feb 2004 16:09:42 -0800
Message-Id: <10779269823390@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1613, 2004/02/24 11:07:29-08:00, rmk-pci@arm.linux.org.uk

[PATCH] PCI: Report meaningful error for failed resource allocation

pci_assign_resource reports odd messages when resource allocation fails.
This is because res->end and res->start are modified by allocate_resource.
For example:

PCI: Failed to allocate resource 1(0-ffffffff) for 0000:00:01.0

The following patch reports whether it's an IO or memory resource, and
includes the correct size.  For consistency, we report it in a similar
way to the failure message in pci_request_region(), even though
res->start is unlikely to be useful.


 drivers/pci/setup-res.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	Fri Feb 27 15:57:35 2004
+++ b/drivers/pci/setup-res.c	Fri Feb 27 15:57:35 2004
@@ -143,8 +143,9 @@
 	}
 
 	if (ret) {
-		printk(KERN_ERR "PCI: Failed to allocate resource %d(%lx-%lx) for %s\n",
-		       resno, res->start, res->end, pci_name(dev));
+		printk(KERN_ERR "PCI: Failed to allocate %s resource #%d:%lx@%lx for %s\n",
+		       res->flags & IORESOURCE_IO ? "I/O" : "mem",
+		       resno, size, res->start, pci_name(dev));
 	} else if (resno < PCI_BRIDGE_RESOURCES) {
 		pci_update_resource(dev, res, resno);
 	}


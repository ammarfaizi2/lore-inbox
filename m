Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVDBAIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVDBAIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVDBAGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:06:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:37084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262941AbVDAXsP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:15 -0500
Cc: gregkh@suse.de
Subject: PCI: fix an oops in some pci devices on hotplug remove when their resources are being freed.
In-Reply-To: <11123992702166@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:50 -0800
Message-Id: <11123992703458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.7, 2005/03/17 10:30:46-08:00, gregkh@suse.de

PCI: fix an oops in some pci devices on hotplug remove when their resources are being freed.

As reported by Prarit Bhargava <prarit@sgi.com>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/remove.c |    2 +-
 kernel/resource.c    |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
--- a/drivers/pci/remove.c	2005-04-01 15:37:58 -08:00
+++ b/drivers/pci/remove.c	2005-04-01 15:37:58 -08:00
@@ -19,7 +19,7 @@
 	pci_cleanup_rom(dev);
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *res = dev->resource + i;
-		if (res->parent)
+		if (res && res->parent)
 			release_resource(res);
 	}
 }
diff -Nru a/kernel/resource.c b/kernel/resource.c
--- a/kernel/resource.c	2005-04-01 15:37:58 -08:00
+++ b/kernel/resource.c	2005-04-01 15:37:58 -08:00
@@ -505,6 +505,7 @@
 			*p = res->sibling;
 			write_unlock(&resource_lock);
 			kfree(res);
+			res = NULL;
 			return;
 		}
 		p = &res->sibling;


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUHXBcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUHXBcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267238AbUHWTWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:22:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:196 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267209AbUHWSgq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:46 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860853384@kroah.com>
Date: Mon, 23 Aug 2004 11:34:45 -0700
Message-Id: <10932860853649@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.15, 2004/08/04 18:23:24-07:00, greg@kroah.com

PCI: fix compiler warning in quirks file, and other minor quirks cleanup
    
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.c    |    2 +-
 drivers/pci/probe.c  |    2 +-
 drivers/pci/quirks.c |   20 ++++++++------------
 3 files changed, 10 insertions(+), 14 deletions(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2004-08-23 11:05:55 -07:00
+++ b/drivers/pci/pci.c	2004-08-23 11:05:55 -07:00
@@ -745,7 +745,7 @@
 	struct pci_dev *dev = NULL;
 
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		pci_fixup_device(PCI_FIXUP_FINAL, dev);
+		pci_fixup_device(pci_fixup_final, dev);
 	}
 	return 0;
 }
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2004-08-23 11:05:55 -07:00
+++ b/drivers/pci/probe.c	2004-08-23 11:05:55 -07:00
@@ -640,7 +640,7 @@
 		return NULL;
 	
 	/* Fix up broken headers */
-	pci_fixup_device(PCI_FIXUP_HEADER, dev);
+	pci_fixup_device(pci_fixup_header, dev);
 
 	/*
 	 * Add the device to our list of discovered devices
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-08-23 11:05:55 -07:00
+++ b/drivers/pci/quirks.c	2004-08-23 11:05:55 -07:00
@@ -1,10 +1,10 @@
 /*
- * $Id: quirks.c,v 1.5 1998/05/02 19:24:14 mj Exp $
- *
  *  This file contains work-arounds for many known PCI hardware
  *  bugs.  Devices present only on certain architectures (host
  *  bridges et cetera) should be handled in arch-specific code.
  *
+ *  Note: any quirks for hotpluggable devices must _NOT_ be declared __init.
+ *
  *  Copyright (c) 1999 Martin Mares <mj@ucw.cz>
  *
  *  The bridge optimization stuff has been removed. If you really
@@ -1011,13 +1011,6 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_SMCH,	quirk_pciehp_msi );
 
-/*
- *  The main table of quirks.
- *
- *  Note: any hooks for hotpluggable devices in this table must _NOT_
- *        be declared __init.
- */
-
 
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_fixup *end)
 {
@@ -1038,20 +1031,23 @@
 extern struct pci_fixup __start_pci_fixups_final[];
 extern struct pci_fixup __end_pci_fixups_final[];
 
-void pci_fixup_device(int pass, struct pci_dev *dev)
+void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 {
 	struct pci_fixup *start, *end;
 
 	switch(pass) {
-	case PCI_FIXUP_HEADER:
+	case pci_fixup_header:
 		start = __start_pci_fixups_header;
 		end = __end_pci_fixups_header;
 		break;
 
-	case PCI_FIXUP_FINAL:
+	case pci_fixup_final:
 		start = __start_pci_fixups_final;
 		end = __end_pci_fixups_final;
 		break;
+	default:
+		/* stupid compiler warning, you would think with an enum... */
+		return;
 	}
 	pci_do_fixups(dev, start, end);
 }


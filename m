Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVAJRpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVAJRpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVAJRo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:44:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:28305 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262354AbVAJRVE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:04 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776573816@kroah.com>
Date: Mon, 10 Jan 2005 09:20:57 -0800
Message-Id: <1105377657239@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.7, 2004/12/17 13:44:10-08:00, dhowells@redhat.com

[PATCH] PCI: Make pci_set_power_state() check register version

The attached patch makes pci_set_power_state() check the PM register version
and ignore non-version 2 registers. Trampling on earlier version PM registers
such as are sported by the Promise 20269 IDE card can cause the system to
hang.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2005-01-10 09:03:28 -08:00
+++ b/drivers/pci/pci.c	2005-01-10 09:03:28 -08:00
@@ -245,7 +245,7 @@
 pci_set_power_state(struct pci_dev *dev, int state)
 {
 	int pm;
-	u16 pmcsr;
+	u16 pmcsr, pmc;
 
 	/* bound the state we're entering */
 	if (state > 3) state = 3;
@@ -265,10 +265,16 @@
 	/* abort if the device doesn't support PM capabilities */
 	if (!pm) return -EIO; 
 
+	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
+	if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
+		printk(KERN_WARNING
+		       "PCI: %s has unsupported PM cap regs version (%u)\n",
+		       dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
+		return -EIO;
+	}
+
 	/* check if this device supports the desired state */
 	if (state == 1 || state == 2) {
-		u16 pmc;
-		pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
 		if (state == 1 && !(pmc & PCI_PM_CAP_D1)) return -EIO;
 		else if (state == 2 && !(pmc & PCI_PM_CAP_D2)) return -EIO;
 	}


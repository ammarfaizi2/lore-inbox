Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWDFUlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWDFUlo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 16:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWDFUlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 16:41:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47015 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932179AbWDFUln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 16:41:43 -0400
Date: Thu, 6 Apr 2006 15:41:41 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: powerpc/pseries: bugfix: balance calls to pci_device_put
Message-ID: <20060406204141.GA27256@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH]: powerpc/pseries: bugfix: balance calls to pci_device_put 

Repeated calls to eeh_remove_device() can result in multiple
(and thus unbalanced) calls to pci_dev_put(). Make sure the
pci_device_put() is called only once (since there was only 
one call to the matching pci_device_get()).

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh.c	2006-04-06 15:35:55.000000000 -0500
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh.c	2006-04-06 15:38:04.968433419 -0500
@@ -957,8 +957,10 @@ static void eeh_remove_device(struct pci
 	pci_addr_cache_remove_device(dev);
 
 	dn = pci_device_to_OF_node(dev);
-	PCI_DN(dn)->pcidev = NULL;
-	pci_dev_put (dev);
+	if (PCI_DN(dn)->pcidev) {
+		PCI_DN(dn)->pcidev = NULL;
+		pci_dev_put (dev);
+	}
 }
 
 void eeh_remove_bus_device(struct pci_dev *dev)

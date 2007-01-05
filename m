Return-Path: <linux-kernel-owner+w=401wt.eu-S1750847AbXAEXND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbXAEXND (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 18:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbXAEXND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 18:13:03 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:57828 "EHLO
	myri.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750847AbXAEXNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 18:13:01 -0500
X-Greylist: delayed 1188 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 18:13:01 EST
Message-ID: <459ED69E.4060801@myri.com>
Date: Fri, 05 Jan 2007 23:52:14 +0100
From: Brice Goglin <brice@myri.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>, Michael Ellerman <michael@ellerman.id.au>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] increment pos before looking for the next cap in __pci_find_next_ht_cap
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While testing 2.6.20-rc3 on a machine with some CK804 chipsets, we
noticed that quirk_nvidia_ck804_msi_ht_cap() was not detecting HT
MSI capabilities anymore. It is actually caused by the MSI mapping
on the root chipset being the 2nd HT capability in the chain.
pci_find_ht_capability() does not seem to find anything but the
first HT cap correctly, because it forgets to increment the position
before looking for the next cap. The following patch seems to fix it.

At least, this prooves that having a ttl is good idea since the
machine would have been stucked in an infinite loop if we didn't
have a ttl :)

The patch should go in 2.6.20 since this quirk was working fine in 2.6.19.
---
[PATCH] increment pos before looking for the next cap in __pci_find_next_ht_cap

We have to pass pos + PCI_CAP_LIST_NEXT to __pci_find_next_cap_ttl to
get the next HT cap instead of the same one again. 

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>
---
 drivers/pci/pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-rc/drivers/pci/pci.c
===================================================================
--- linux-rc.orig/drivers/pci/pci.c	2007-01-05 23:34:59.000000000 +0100
+++ linux-rc/drivers/pci/pci.c	2007-01-05 23:35:24.000000000 +0100
@@ -254,7 +254,8 @@
 		if ((cap & mask) == ht_cap)
 			return pos;
 
-		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
+		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
+					      pos + PCI_CAP_LIST_NEXT,
 					      PCI_CAP_ID_HT, &ttl);
 	}
 



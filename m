Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTJJV1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 17:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTJJV1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 17:27:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:30862 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263152AbTJJV1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 17:27:31 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_84 pci_map_sg fix for 2.6.0-test7
Date: Fri, 10 Oct 2003 14:26:33 -0700
User-Agent: KMail/1.4.1
Cc: ak@suse.de
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9W8KFFNGXIN4AJEQUH6N"
Message-Id: <200310101426.33773.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_9W8KFFNGXIN4AJEQUH6N
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Here is the patch to fix few minor issues with pci_map_sg() and pci_map_c=
ont()
for x86_64. I ran into these asserts while testing with qlogic fc driver.

The patch fixes following:

1) pci_map_sg() coalsces "sg" entries without modifying command's
"use_sg" value. It sets the "sg" entries length to "0" to indicate that
these entires are coalsced. If the command gets retried, the pci_map_sg()=
=20
code trips on the assert that all entries length should be > 0.

2) __pci_map_cont() incorrectly assumes that "start" is always 0, so it
trips on few asserts.

Thanks,
Badari




--------------Boundary-00=_9W8KFFNGXIN4AJEQUH6N
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pci-gart.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pci-gart.patch"

--- linux-2.6.0-test7/arch/x86_64/kernel/pci-gart.c	2003-10-10 11:48:40.324040400 -0700
+++ linux-2.6.0-test7.new/arch/x86_64/kernel/pci-gart.c	2003-10-10 11:49:12.281182176 -0700
@@ -395,7 +395,7 @@ static int __pci_map_cont(struct scatter
 	for (i = start; i < stopat; i++) {
 		struct scatterlist *s = &sg[i];
 		unsigned long start_addr = s->dma_address;
-		BUG_ON(i > 0 && s->offset);
+		BUG_ON(i > start && s->offset);
 		if (i == start) {
 			*sout = *s; 
 			sout->dma_address = iommu_bus_base;
@@ -409,8 +409,8 @@ static int __pci_map_cont(struct scatter
 			SET_LEAK(iommu_page);
 			addr += PAGE_SIZE;
 			iommu_page++;
-	} 
-		BUG_ON(i > 0 && addr % PAGE_SIZE); 
+		} 
+		BUG_ON(i > start && addr % PAGE_SIZE); 
 	} 
 	BUG_ON(iommu_page - iommu_start != pages);	
 	return 0;
@@ -451,7 +451,8 @@ int pci_map_sg(struct pci_dev *dev, stru
 		struct scatterlist *s = &sg[i];
 		dma_addr_t addr = page_to_phys(s->page) + s->offset;
 		s->dma_address = addr;
-		BUG_ON(s->length == 0); 
+		if (s->length == 0)
+			break;
 
 		size += s->length; 
 

--------------Boundary-00=_9W8KFFNGXIN4AJEQUH6N--


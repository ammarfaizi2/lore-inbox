Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbUCCPd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbUCCPad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:30:33 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:2255 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262490AbUCCP3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:29:48 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       willy@debian.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move dma_consistent_dma_mask to the generic device
References: <1077759287.14081.24.camel@mulgrave>
From: Jes Sorensen <jes@wildopensource.com>
Date: 03 Mar 2004 10:29:40 -0500
In-Reply-To: <1077759287.14081.24.camel@mulgrave>
Message-ID: <yq0llmit0d7.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "James" == James Bottomley <James.Bottomley@steeleye.com> writes:

James> pci_dev.consistent_dma_mask was introduced to get around
James> problems in the IA64 Altix machine.

James> Now, we have a use for it in x86: the aacraid needs coherent
James> memory in a 31 bit address range (2GB).  Unfortunately, x86 is
James> converted to the dma model, so it can't see the pci_dev by the
James> time coherent memory is allocated.

James,

Could you add this one to your patchset, it fixes the sn2 code to work
with the new location of the mask.

Thanks,
Jes

--- arch/ia64/sn/io/machvec/pci_dma.c~	Wed Mar  3 06:47:36 2004
+++ arch/ia64/sn/io/machvec/pci_dma.c	Wed Mar  3 07:23:34 2004
@@ -152,7 +152,7 @@
 	 *   pcibr_dmatrans_addr ignores a missing PCIIO_DMA_A64 flag on
 	 *   PCI-X buses.
 	 */
-	if (hwdev->consistent_dma_mask == ~0UL)
+	if (hwdev->dev.coherent_dma_mask == ~0UL)
 		*dma_handle = pcibr_dmatrans_addr(vhdl, NULL, phys_addr, size,
 					  PCIIO_DMA_CMD | PCIIO_DMA_A64);
 	else {
@@ -169,7 +169,7 @@
 		}
 	}
 
-	if (!*dma_handle || *dma_handle > hwdev->consistent_dma_mask) {
+	if (!*dma_handle || *dma_handle > hwdev->dev.coherent_dma_mask) {
 		if (dma_map) {
 			pcibr_dmamap_done(dma_map);
 			pcibr_dmamap_free(dma_map);

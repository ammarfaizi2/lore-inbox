Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbUBZC5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbUBZC5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:57:50 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:44478 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262613AbUBZC4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:56:04 -0500
Subject: Re: [PATCH] move dma_consistent_dma_mask to the generic device
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, willy@debian.org,
       Jes Sorensen <jes@wildopensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040225180600.273bbf55.akpm@osdl.org>
References: <1077759287.14081.24.camel@mulgrave> 
	<20040225180600.273bbf55.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 25 Feb 2004 20:55:58 -0600
Message-Id: <1077764159.14043.28.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-25 at 20:06, Andrew Morton wrote:
> A bit more grepping is needed.
> 
> sound/core/memalloc.c: In function `snd_pci_hack_alloc_consistent':
> sound/core/memalloc.c:103: structure has no member named `consistent_dma_mask'

Mea culpa, I don't have any boxes that define this hack, so I didn't see
it.  This sound memalloc is horribly illegal under the API...I suppose
we're just lucky the Altix doesn't have a sound card ;-)

This incremental patch should fix it up (I compiled it on parisc by
including it in the hacked architectures).

James

===== sound/core/memalloc.c 1.16 vs edited =====
--- 1.16/sound/core/memalloc.c	Mon Jan 19 04:37:35 2004
+++ edited/sound/core/memalloc.c	Wed Feb 25 20:51:28 2004
@@ -100,13 +100,13 @@
 	if (hwdev == NULL)
 		return pci_alloc_consistent(hwdev, size, dma_handle);
 	dma_mask = hwdev->dma_mask;
-	cdma_mask = hwdev->consistent_dma_mask;
+	cdma_mask = hwdev->dev.coherent_dma_mask;
 	mask = (unsigned long)dma_mask && (unsigned long)cdma_mask;
 	hwdev->dma_mask = 0xffffffff; /* do without masking */
-	hwdev->consistent_dma_mask = 0xffffffff; /* do without masking */
+	hwdev->dev.coherent_dma_mask = 0xffffffff; /* do without masking */
 	ret = pci_alloc_consistent(hwdev, size, dma_handle);
 	hwdev->dma_mask = dma_mask; /* restore */
-	hwdev->consistent_dma_mask = cdma_mask; /* restore */
+	hwdev->dev.coherent_dma_mask = cdma_mask; /* restore */
 	if (ret) {
 		/* obtained address is out of range? */
 		if (((unsigned long)*dma_handle + size - 1) & ~mask) {


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbTJJTgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbTJJTgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:36:46 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:52644 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263145AbTJJTgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:36:43 -0400
Message-ID: <3F870BDC.8090806@pacbell.net>
Date: Fri, 10 Oct 2003 12:43:24 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: mru@users.sourceforge.net, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
References: <3F86E9D7.9020104@pacbell.net>
In-Reply-To: <3F86E9D7.9020104@pacbell.net>
Content-Type: multipart/mixed;
 boundary="------------000406020106000904090900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000406020106000904090900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Brownell wrote:
> The BUG_ON at include/asm-generic/dma-mapping.h:19 is a
> bug in that "generic DMA" code ... and I've seen the
> same BUG reported from PPC folk too.

Something like this should be correct even on x86, but
there may be some cases where a platform_dma_supported()
is necessary.

IMO this needs an all-architectures patch.  Not many
will need a platform_dma_supported() ... but almost
every implementation of that simple call is broken.

- Dave



--------------000406020106000904090900
Content-Type: text/plain;
 name="Diff.dma"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff.dma"

--- 1.4/include/asm-generic/dma-mapping.h	Mon Jan 13 14:37:47 2003
+++ edited/include/asm-generic/dma-mapping.h	Fri Oct 10 10:53:25 2003
@@ -13,12 +13,13 @@
 /* need struct page definitions */
 #include <linux/mm.h>
 
+/* FIXME use this everywhere there's no platform_dma_supported() */
 static inline int
 dma_supported(struct device *dev, u64 mask)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	return pci_dma_supported(to_pci_dev(dev), mask);
+	/* device can dma, using those address bits */
+	return dev->dma_mask
+		&& (mask & *dev->dma_mask) == *dev->dma_mask;
 }
 
 static inline int

--------------000406020106000904090900--


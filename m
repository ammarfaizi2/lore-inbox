Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbTJKW5A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 18:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263403AbTJKW5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 18:57:00 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:57776 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263401AbTJKW46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 18:56:58 -0400
Message-ID: <3F888C52.9050006@pacbell.net>
Date: Sat, 11 Oct 2003 16:03:46 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: mru@users.sourceforge.net, linux-kernel@vger.kernel.org,
       Michal Jaegermann <michal@harddata.com>
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
References: <3F86E9D7.9020104@pacbell.net> <3F870BDC.8090806@pacbell.net> <20031011172700.A16499@jurassic.park.msu.ru> <3F882F20.5090903@pacbell.net>
In-Reply-To: <3F882F20.5090903@pacbell.net>
Content-Type: multipart/mixed;
 boundary="------------040200020007080402010504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040200020007080402010504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> Ivan Kokshaysky wrote:
>>
>> This doesn't work. You will always return success if mask = ~0ULL.

Whoops.  I didn't copy what I thought I was copying:

            (mask & *dev->dma_mask) == mask  /* not "== dma_mask" */

Updated code is appended ... which also provides a BUG()-free
version of dma_set_mask().  I think the only arch/platform hook
needed would be for dma_supported().

- Dave


--------------040200020007080402010504
Content-Type: text/plain;
 name="Diff.dma"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff.dma"

--- 1.4/include/asm-generic/dma-mapping.h	Mon Jan 13 14:37:47 2003
+++ edited/include/asm-generic/dma-mapping.h	Sat Oct 11 15:33:56 2003
@@ -13,20 +13,22 @@
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
+		&& (mask & *dev->dma_mask) == mask;
 }
 
 static inline int
-dma_set_mask(struct device *dev, u64 dma_mask)
+dma_set_mask(struct device *dev, u64 mask)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
+	if (!dma_supported(dev, mask))
+		return 0;
+	*dev->dma_mask = mask;
+	return 1;
 }
 
 static inline void *

--------------040200020007080402010504--


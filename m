Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbTHEUyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270691AbTHEUyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:54:39 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:49638 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S267520AbTHEUyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:54:38 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: pci_alloc_consistent() and/or dma_free_coherent() bug?
References: <m3r84010xt.fsf@defiant.pm.waw.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 05 Aug 2003 22:54:15 +0200
In-Reply-To: <m3r84010xt.fsf@defiant.pm.waw.pl>
Message-ID: <m38yq725c8.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually it would probably be better to do something like that:

--- arch/i386/kernel/pci-dma.c.orig	2003-05-27 03:00:25.000000000 +0200
+++ arch/i386/kernel/pci-dma.c	2003-08-05 18:55:42.000000000 +0200
@@ -20,7 +20,7 @@
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
-	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
+	if (dev == NULL || ((*dev->consistent_dma_mask & *dev->dma_mask) < 0xffffffff))
 		gfp |= GFP_DMA;
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 

So we don't need to touch pci_set*dma_mask and we don't need to call them
in specific order.
-- 
Krzysztof Halasa
Network Administrator

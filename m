Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUGIWZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUGIWZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 18:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUGIWZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 18:25:40 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:49822 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266009AbUGIWZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 18:25:27 -0400
Subject: Re: 2.6.7-mm7
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040709151448.28f1dbf7.akpm@osdl.org>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	<20040709210423.GB21066@holomorphy.com> 
	<20040709151448.28f1dbf7.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 09 Jul 2004 17:24:47 -0500
Message-Id: <1089411888.1799.146.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 17:14, Andrew Morton wrote:
> btw, James, I'm unable to convince myself that
> dma_mark_declared_memory_occupied() reserves enough pages if device_addr is
> not page-aligned.  Could you double-check that?  If all callers are
> expected to use a page-aligned address then a BUG_ON might be appropriate. 
> Or a comment.

Oh, you mean when addr isn't page aligned and size causes it just to
span a page, like addr = 0xfff, size=2?

You're right, it doesn't.  How about the attached

James

===== arch/i386/kernel/pci-dma.c 1.13 vs edited =====
--- 1.13/arch/i386/kernel/pci-dma.c	2004-06-30 21:37:55 -05:00
+++ edited/arch/i386/kernel/pci-dma.c	2004-07-09 17:20:14 -05:00
@@ -131,7 +131,7 @@
 					dma_addr_t device_addr, size_t size)
 {
 	struct dma_coherent_mem *mem = dev->dma_mem;
-	int pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	int pages = (size + (addr & ~PAGE_MASK) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	int pos, err;
 
 	if (!mem)


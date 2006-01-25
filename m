Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWAYI7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWAYI7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 03:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWAYI7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 03:59:23 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:13702 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750926AbWAYI7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 03:59:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ow5T0aQYZ7PQHioFNeRjxVTnbNHeD7UdUntDS0yhT780elGHd45gSRBnvAWjnI/6npUgTqtJ1s2YG96jiw9C+ESZbw7+A6xPOMst2kinU762b5jQwsaODEdidvIvzO7gYDh1hRsaIGW0brRyo59xVbNqoh23F2bGXLUyjRIJWjA=
Date: Wed, 25 Jan 2006 12:16:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc1-mm3: mips, sparc64 split_page breakage
Message-ID: <20060125091647.GA15301@mipter.zuzino.mipt.ru>
References: <20060124232406.50abccd1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm/page_alloc.c:762: * split_page takes a non-compound higher-order page, and splits it into
mm/page_alloc.c:769:void split_page(struct page *page, unsigned int order)
mm/memory.c:1213: * (see split_page()).
arch/sh/mm/consistent.c:26:	split_page(page, order);
arch/arm/mm/consistent.c:226:		split_page(page, order);
arch/frv/mm/dma-alloc.c:118:		split_page(rpage, order);
arch/ppc/kernel/dma-mapping.c:226:		split_page(page, order);

arch/mips/mm/init.c:69:	split_page(page);			<===
arch/sparc64/mm/init.c:1079:		split_page(page);	<===

arch/xtensa/mm/pgtable.c:24:		split_page(virt_to_page(p), COLOR_ORDER);
arch/xtensa/mm/pgtable.c:54:		split_page(p, COLOR_ORDER);
include/linux/mm.h:337:void split_page(struct page *page, unsigned int order);
include/linux/mm.h:339:static inline void split_page(struct page *page, unsigned int order) {}

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- linux-2.6.16-rc1-mm3/arch/mips/mm/init.c
+++ linux-1/arch/mips/mm/init.c
@@ -53,8 +53,9 @@ unsigned long empty_zero_page, zero_page
  */
 unsigned long setup_zero_pages(void)
 {
-	unsigned long order, size;
+	unsigned long size;
 	struct page *page;
+	int order;
 
 	if (cpu_has_vce)
 		order = 3;
@@ -66,7 +67,7 @@ unsigned long setup_zero_pages(void)
 		panic("Oh boy, that early out of memory?");
 
 	page = virt_to_page(empty_zero_page);
-	split_page(page);
+	split_page(page, order);
 	while (page < virt_to_page(empty_zero_page + (PAGE_SIZE << order))) {
 		SetPageReserved(page);
 		page++;


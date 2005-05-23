Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVEWXpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVEWXpD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVEWXlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:41:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:12679 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261222AbVEWXc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:32:59 -0400
Date: Mon, 23 May 2005 16:32:35 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de
Subject: [patch 16/16] x86_64: Don't look up struct page pointer of physical address in iounmap
Message-ID: <20050523233235.GB27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] x86_64: Don't look up struct page pointer of physical address in iounmap

It could be in a memory hole not mapped in mem_map and that causes the hash
lookup to go off to nirvana.

Back port to -stable tree by Chris Wright

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 ioremap.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: release-2.6.11/arch/x86_64/mm/ioremap.c
===================================================================
--- release-2.6.11.orig/arch/x86_64/mm/ioremap.c
+++ release-2.6.11/arch/x86_64/mm/ioremap.c
@@ -266,7 +266,7 @@ void iounmap(volatile void __iomem *addr
 	if ((p->flags >> 20) &&
 		p->phys_addr + p->size - 1 < virt_to_phys(high_memory)) {
 		/* p->size includes the guard page, but cpa doesn't like that */
-		change_page_attr(virt_to_page(__va(p->phys_addr)),
+		change_page_attr_addr((unsigned long)(__va(p->phys_addr)),
 				 (p->size - PAGE_SIZE) >> PAGE_SHIFT,
 				 PAGE_KERNEL); 				 
 		global_flush_tlb();

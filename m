Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVBWDg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVBWDg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 22:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVBWDg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 22:36:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:48866 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261401AbVBWDg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 22:36:56 -0500
Subject: [PATCH] ppc32: kernel mapping breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 14:35:56 +1100
Message-Id: <1109129756.5326.181.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Christoph Lameter's patch that change page allocators to use GFP_ZERO
broke ppc32 in a subtle way. Our allocator is designed to work before
mem_init_done, in which cases it uses a ppc specific early_get_page()
which doesn't return zeroed pages. However, he removed the call to
clear_page() unconditionally, thus causing the kernel initial page
tables to have random data in them.

They are initialized with set_pte, which means it's _mostly_ harmless,
except that set_pte on ppc32 preserves the _PAGE_HASHPTE bit, thus we
end up with random bits there, which can cause issues with further
manipulation of the kernel page tables and will slow down all hash
faults to them causing unnecessary searches.

Please apply in 2.6.11 if still possible ...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/mm/pgtable.c
===================================================================
--- linux-work.orig/arch/ppc/mm/pgtable.c	2005-01-24 17:09:23.000000000 +1100
+++ linux-work/arch/ppc/mm/pgtable.c	2005-02-23 14:31:41.000000000 +1100
@@ -107,8 +107,11 @@
 			ptepage->mapping = (void *) mm;
 			ptepage->index = address & PMD_MASK;
 		}
-	} else
+	} else {
 		pte = (pte_t *)early_get_page();
+		if (pte)
+			clear_page(pte);
+	}
 	return pte;
 }
 



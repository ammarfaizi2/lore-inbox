Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbWGJWKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbWGJWKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWGJWKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:10:16 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:5192 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965257AbWGJWKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:10:10 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 04/10] Modules support for kmemleak
Date: Mon, 10 Jul 2006 23:10:07 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060710221006.5191.28032.stgit@localhost.localdomain>
In-Reply-To: <20060710220901.5191.66488.stgit@localhost.localdomain>
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch handles the kmemleak operations needed for modules loading so
that memory allocations from inside a module are properly tracked.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 kernel/module.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 35e1b1f..3b88c06 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1481,6 +1481,11 @@ static struct module *load_module(void _
 	unsigned int unusedcrcindex;
 	unsigned int unusedgplindex;
 	unsigned int unusedgplcrcindex;
+#ifdef CONFIG_DEBUG_MEMLEAK
+	unsigned int dataindex;
+	unsigned int bssindex;
+	unsigned int mloffindex;
+#endif
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1577,6 +1582,11 @@ #endif
 #ifdef ARCH_UNWIND_SECTION_NAME
 	unwindex = find_sec(hdr, sechdrs, secstrings, ARCH_UNWIND_SECTION_NAME);
 #endif
+#ifdef CONFIG_DEBUG_MEMLEAK
+	dataindex = find_sec(hdr, sechdrs, secstrings, ".data");
+	bssindex = find_sec(hdr, sechdrs, secstrings, ".bss");
+	mloffindex = find_sec(hdr, sechdrs, secstrings, ".init.memleak_offsets");
+#endif
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1646,6 +1656,10 @@ #endif
 
 	/* Do the allocs. */
 	ptr = module_alloc(mod->core_size);
+	/* the pointer to this block is stored in the module structure
+	 * which is inside the block. Just mark it as not being a
+	 * leak */
+	memleak_not_leak(ptr);
 	if (!ptr) {
 		err = -ENOMEM;
 		goto free_percpu;
@@ -1654,6 +1668,11 @@ #endif
 	mod->module_core = ptr;
 
 	ptr = module_alloc(mod->init_size);
+	/* the pointer to this block is stored in the module structure
+	 * which is inside the block. This block doesn't need to be
+	 * scanned as it contains data and code that will be freed
+	 * after the module is initialized */
+	memleak_ignore(ptr);
 	if (!ptr && mod->init_size) {
 		err = -ENOMEM;
 		goto free_core;
@@ -1685,6 +1704,28 @@ #endif
 	/* Module has been moved. */
 	mod = (void *)sechdrs[modindex].sh_addr;
 
+#ifdef CONFIG_DEBUG_MEMLEAK
+	if (mloffindex)
+		memleak_insert_aliases((void *)sechdrs[mloffindex].sh_addr,
+				       (void *)sechdrs[mloffindex].sh_addr
+				         + sechdrs[mloffindex].sh_size);
+
+	/* only scan the sections containing data */
+	memleak_scan_area(mod->module_core,
+			  (unsigned long)mod - (unsigned long)mod->module_core,
+			  sizeof(struct module));
+	if (dataindex)
+		memleak_scan_area(mod->module_core,
+				  sechdrs[dataindex].sh_addr
+				    - (unsigned long)mod->module_core,
+				  sechdrs[dataindex].sh_size);
+	if (bssindex)
+		memleak_scan_area(mod->module_core,
+				  sechdrs[bssindex].sh_addr
+				    - (unsigned long)mod->module_core,
+				  sechdrs[bssindex].sh_size);
+#endif
+
 	/* Now we've moved module, initialize linked lists, etc. */
 	module_unload_init(mod);
 

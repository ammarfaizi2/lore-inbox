Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWHLWCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWHLWCB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 18:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWHLWAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 18:00:44 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:59551 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751198AbWHLWAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 18:00:24 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc4 04/10] Modules support for kmemleak
Date: Sat, 12 Aug 2006 23:00:20 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060812220020.17709.16347.stgit@localhost.localdomain>
In-Reply-To: <20060812215857.17709.79502.stgit@localhost.localdomain>
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
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
index 2a19cd4..a7f8c6d 100644
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
 

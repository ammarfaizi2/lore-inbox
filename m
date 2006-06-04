Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932274AbWFDWCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWFDWCJ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 18:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWFDWA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 18:00:57 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:5324 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932279AbWFDWAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 18:00:35 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc5 4/8] Modules support for kmemleak
Date: Sun, 04 Jun 2006 23:00:32 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060604220032.16277.7250.stgit@localhost.localdomain>
In-Reply-To: <20060604215636.16277.15454.stgit@localhost.localdomain>
References: <20060604215636.16277.15454.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch handles the kmemleak operations needed for modules loading so
that memory allocations from inside a module are properly tracked.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 kernel/module.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index bbe0486..2b66374 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1413,6 +1413,9 @@ static struct module *load_module(void _
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
 		crcindex, gplcrcindex, versindex, pcpuindex, gplfutureindex,
 		gplfuturecrcindex;
+#ifdef CONFIG_DEBUG_MEMLEAK
+	unsigned int dataindex, bssindex, mloffindex;
+#endif
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1510,6 +1513,11 @@ #ifdef CONFIG_KALLSYMS
 	sechdrs[symindex].sh_flags |= SHF_ALLOC;
 	sechdrs[strindex].sh_flags |= SHF_ALLOC;
 #endif
+#ifdef CONFIG_DEBUG_MEMLEAK
+	dataindex = find_sec(hdr, sechdrs, secstrings, ".data");
+	bssindex = find_sec(hdr, sechdrs, secstrings, ".bss");
+	mloffindex = find_sec(hdr, sechdrs, secstrings, ".init.memleak_offsets");
+#endif
 
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(sechdrs, versindex, mod)) {
@@ -1569,6 +1577,7 @@ #endif
 
 	/* Do the allocs. */
 	ptr = module_alloc(mod->core_size);
+	memleak_not_leak(ptr);
 	if (!ptr) {
 		err = -ENOMEM;
 		goto free_percpu;
@@ -1577,6 +1586,7 @@ #endif
 	mod->module_core = ptr;
 
 	ptr = module_alloc(mod->init_size);
+	memleak_ignore(ptr);
 	if (!ptr && mod->init_size) {
 		err = -ENOMEM;
 		goto free_core;
@@ -1608,6 +1618,28 @@ #endif
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
 

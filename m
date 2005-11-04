Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVKDP3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVKDP3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVKDP3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:29:47 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:36035 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750777AbVKDP3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:29:46 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH] powerpc: mem_init crash for sparsemem
Date: Fri, 4 Nov 2005 16:31:16 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041631.17237.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Cell blade with some broken memory in the middle of the
physical address space and this is correctly detected by the
firmware, but not relocated. When I enable CONFIG_SPARSEMEM,
the memsections for the nonexistant address space do not
get struct page entries allocated, as expected.

However, mem_init for the non-NUMA configuration tries to
access these pages without first looking if they are there.
I'm currently using the hack below to work around that, but
I have the feeling that there should be a cleaner solution
for this.

Please comment.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-2.6.15-rc.orig/arch/powerpc/mm/mem.c
+++ linux-2.6.15-rc/arch/powerpc/mm/mem.c
@@ -348,6 +348,9 @@ void __init mem_init(void)
 #endif
 	for_each_pgdat(pgdat) {
 		for (i = 0; i < pgdat->node_spanned_pages; i++) {
+			if (!section_has_mem_map(__pfn_to_section
+					(pgdat->node_start_pfn + i)))
+				continue;
 			page = pgdat_page_nr(pgdat, i);
 			if (PageReserved(page))
 				reservedpages++;

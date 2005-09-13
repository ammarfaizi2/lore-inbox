Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVIMAOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVIMAOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 20:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVIMAOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 20:14:43 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:34315 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932383AbVIMAOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 20:14:42 -0400
Date: Mon, 12 Sep 2005 20:14:29 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, tony.luck@intel.com
Subject: [patch 2.6.13] ia64: re-implement dma_get_cache_alignment to avoid EXPORT_SYMBOL
Message-ID: <20050913001429.GJ19644@tuxdriver.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	tony.luck@intel.com
References: <09122005104852.31327@bilbo.tuxdriver.com> <20050912192524.GA14360@infradead.org> <20050913000611.GI19644@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913000611.GI19644@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current ia64 implementation of dma_get_cache_alignment does not
work for modules because it relies on a symbol which is not exported.
Direct access to a global is a little ugly anyway, so this patch
re-implements dma_get_cache_alignment in a manner similar to what is
currently used for x86_64.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
This patch replaces the patch at the link below:

	http://www.ussg.iu.edu/hypermail/linux/kernel/0509.1/1365.html

 arch/ia64/kernel/setup.c       |    7 +++++++
 include/asm-ia64/dma-mapping.h |    7 +------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -79,6 +79,13 @@ unsigned long vga_console_iobase;
 unsigned long vga_console_membase;
 
 unsigned long ia64_max_cacheline_size;
+
+int dma_get_cache_alignment(void)
+{
+        return ia64_max_cacheline_size;
+}
+EXPORT_SYMBOL(dma_get_cache_alignment);
+
 unsigned long ia64_iobase;	/* virtual address for I/O accesses */
 EXPORT_SYMBOL(ia64_iobase);
 struct io_space io_space[MAX_IO_SPACES];
diff --git a/include/asm-ia64/dma-mapping.h b/include/asm-ia64/dma-mapping.h
--- a/include/asm-ia64/dma-mapping.h
+++ b/include/asm-ia64/dma-mapping.h
@@ -48,12 +48,7 @@ dma_set_mask (struct device *dev, u64 ma
 	return 0;
 }
 
-static inline int
-dma_get_cache_alignment (void)
-{
-	extern int ia64_max_cacheline_size;
-	return ia64_max_cacheline_size;
-}
+extern int dma_get_cache_alignment(void);
 
 static inline void
 dma_cache_sync (void *vaddr, size_t size, enum dma_data_direction dir)
-- 
John W. Linville
linville@tuxdriver.com

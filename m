Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVKEEiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVKEEiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 23:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVKEEiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 23:38:19 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:15630 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751178AbVKEEiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 23:38:18 -0500
Date: Fri, 4 Nov 2005 23:37:35 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch 2.6.14] ia64: re-implement dma_get_cache_alignment to avoid EXPORT_SYMBOL
Message-ID: <20051105043735.GD21567@tuxdriver.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>, davej@redhat.com,
	linux-kernel@vger.kernel.org
References: <20051104220737.GA16551@redhat.com> <20051104223441.GA16285@infradead.org> <20051104145534.17e913f2.akpm@osdl.org> <20051104235257.GA21674@infradead.org> <20051104160540.486051ed.akpm@osdl.org> <20051105043527.GC21567@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105043527.GC21567@tuxdriver.com>
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
index fc56ca2..3af6de3 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -92,6 +92,13 @@ extern void efi_initialize_iomem_resourc
 extern char _text[], _end[], _etext[];
 
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
index 6347c98..df67d40 100644
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

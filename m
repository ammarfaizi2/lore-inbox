Return-Path: <linux-kernel-owner+w=401wt.eu-S1755162AbWL3QuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbWL3QuV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 11:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755156AbWL3QuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 11:50:21 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3007 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbWL3QuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 11:50:20 -0500
Date: Sat, 30 Dec 2006 16:50:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061230165012.GB12622@flint.arm.linux.org.uk>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk> <20061230163955.GA12622@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061230163955.GA12622@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 04:39:55PM +0000, Russell King wrote:
> Given that no one has any outstanding issues with the following patch, I'm
> going to ask akpm to put this into -mm, and shortly after (a week or so)
> I'll submit it and the ARM flush_anon_page() patch to Linus for -rc to fix
> ARM data corruption issues.

And here's the flush_anon_page() part.

Add flush_anon_page() for ARM, to avoid data corruption issues when using
fuse or other subsystems using get_user_pages().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 628348c..86dd204 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -202,3 +202,39 @@ #endif
 	}
 }
 EXPORT_SYMBOL(flush_dcache_page);
+
+/*
+ * Flush an anonymous page so that users of get_user_pages()
+ * can safely access the data.  The expected sequence is:
+ *
+ *  get_user_pages()
+ *    -> flush_anon_page
+ *  memcpy() to/from page
+ *  if written to page, flush_dcache_page()
+ */
+void __flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr)
+{
+	/* VIPT non-aliasing caches need do nothing */
+	if (cache_is_vipt_nonaliasing())
+		return;
+
+	/*
+	 * Write back and invalidate userspace mapping.
+	 */
+	if (cache_is_vivt()) {
+		flush_cache_page(vma, vmaddr, page_to_pfn(page));
+	} else {
+		/*
+		 * For aliasing VIPT, we can flush an alias of the
+		 * userspace address only.
+		 */
+		flush_pfn_alias(page_to_pfn(page), vmaddr);
+	}
+
+	/*
+	 * Invalidate kernel mapping.  No data should be contained
+	 * in this mapping of the page.  FIXME: this is overkill
+	 * since we actually ask for a write-back and invalidate.
+	 */
+	__cpuc_flush_dcache_page(page_address(page));
+}
diff --git a/include/asm-arm/cacheflush.h b/include/asm-arm/cacheflush.h
index 378a3a2..506ef15 100644
--- a/include/asm-arm/cacheflush.h
+++ b/include/asm-arm/cacheflush.h
@@ -355,6 +355,16 @@ #define clean_dcache_area(start,size)	cp
  */
 extern void flush_dcache_page(struct page *);
 
+#define ARCH_HAS_FLUSH_ANON_PAGE
+static inline void flush_anon_page(struct vm_area_struct *vma,
+			 struct page *page, unsigned long vmaddr)
+{
+	extern void __flush_anon_page(struct vm_area_struct *vma,
+				struct page *, unsigned long);
+	if (PageAnon(page))
+		__flush_anon_page(vma, page, vmaddr);
+}
+
 #define flush_dcache_mmap_lock(mapping) \
 	write_lock_irq(&(mapping)->tree_lock)
 #define flush_dcache_mmap_unlock(mapping) \


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

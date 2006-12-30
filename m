Return-Path: <linux-kernel-owner+w=401wt.eu-S1755159AbWL3QkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbWL3QkG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 11:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbWL3QkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 11:40:06 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4148 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbWL3QkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 11:40:04 -0500
Date: Sat, 30 Dec 2006 16:39:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061230163955.GA12622@flint.arm.linux.org.uk>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221171739.GE3958@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given that no one has any outstanding issues with the following patch, I'm
going to ask akpm to put this into -mm, and shortly after (a week or so)
I'll submit it and the ARM flush_anon_page() patch to Linus for -rc to fix
ARM data corruption issues.

If anyone _does_ have a problem, holler ASAP.

On Thu, Dec 21, 2006 at 05:17:39PM +0000, Russell King wrote:
> On Thu, Dec 21, 2006 at 04:53:56PM +0100, Miklos Szeredi wrote:
> > Yes, note the flush_dcache_page() call in fuse_copy_finish().  That
> > could be replaced by the flush_kernel_dcache_page() (added by James
> > Bottomley together with flush_anon_page()) when all relevant
> > architectures have defined it.
> 
> I should say that flush_anon_page() in its current form is going to be
> problematic for ARM.  It is passed:
> 
> 1. the struct page
> 2. the virtual address in process memory for the page
> 
> It is not passed the mm or vma.  This means that we have no idea whether
> the virtual address is in the currently mapped VM space or not.  The
> common use of get_area_pages() is to get pages from other address
> spaces.
> 
> If we use the supplied virtual address to perform cache maintainence of
> the userspace mapping, we might end up hitting a completely different
> processes address space, which may contain some page sensitive to such
> operations, or may not contain any page and thereby could cause a page
> fault on some ARM CPUs.
> 
> Hence, I first need something like this patch so I can tell if the
> page to be flushed is in the current VMs address space or not:

diff --git a/Documentation/cachetlb.txt b/Documentation/cachetlb.txt
index 73e794f..920d0f6 100644
--- a/Documentation/cachetlb.txt
+++ b/Documentation/cachetlb.txt
@@ -373,7 +373,8 @@ maps this page at its virtual address.
 	likely that you will need to flush the instruction cache
 	for copy_to_user_page().
 
-  void flush_anon_page(struct page *page, unsigned long vmaddr)
+  void flush_anon_page(struct vm_area_struct *vma, struct page *page,
+                       unsigned long vmaddr)
   	When the kernel needs to access the contents of an anonymous
 	page, it calls this function (currently only
 	get_user_pages()).  Note: flush_dcache_page() deliberately
diff --git a/include/asm-parisc/cacheflush.h b/include/asm-parisc/cacheflush.h
index aedb051..a799dd8 100644
--- a/include/asm-parisc/cacheflush.h
+++ b/include/asm-parisc/cacheflush.h
@@ -186,7 +186,7 @@ flush_cache_page(struct vm_area_struct *
 }
 
 static inline void
-flush_anon_page(struct page *page, unsigned long vmaddr)
+flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr)
 {
 	if (PageAnon(page))
 		flush_user_dcache_page(vmaddr);
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ca9a602..645d440 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -8,7 +8,7 @@ #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
 
 #ifndef ARCH_HAS_FLUSH_ANON_PAGE
-static inline void flush_anon_page(struct page *page, unsigned long vmaddr)
+static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr)
 {
 }
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index c00bac6..13970fe 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1091,7 +1091,7 @@ int get_user_pages(struct task_struct *t
 			if (pages) {
 				pages[i] = page;
 
-				flush_anon_page(page, start);
+				flush_anon_page(vma, page, start);
 				flush_dcache_page(page);
 			}
 			if (vmas)


> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

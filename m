Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVBWKCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVBWKCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 05:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVBWKCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 05:02:16 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:19691 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261444AbVBWKBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 05:01:05 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: matthew@wil.cx, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050222020309.4289504c.akpm@osdl.org>
	<yq0ekf8lksf.fsf@jaguar.mkp.net>
	<20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
	<20050222112513.4162860d.akpm@osdl.org>
	<yq0zmxwgqxr.fsf@jaguar.mkp.net>
	<20050222153456.502c3907.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 23 Feb 2005 05:01:04 -0500
In-Reply-To: <20050222153456.502c3907.akpm@osdl.org>
Message-ID: <yq0sm3negtb.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Jes Sorensen <jes@wildopensource.com> wrote:
>>  After applying the clue 2x4 to my head a couple of times, I came
>> up with this patch. Hopefully it will work a bit better ;-)
>> 

Andrew> I know it's repetitious, but it's nice to maintain a changelog
Andrew> entry along with the patch.  Especially when seventy people
Andrew> have asked "wtf is this patch for?".

True, that got lost in the multi-iteration game. Added one now.

Andrew> Implementation-wise, do you really need to clone-and-own the
Andrew> mem.c functions?  Would it not be sufficient to do

Andrew> 	ptr = arch_translate_mem_ptr(page, ptr);

Andrew> inside mem.c?

I tried to avoid making too many changes to drivers/char/mem.c but on
the long run this is probably cleaner. It makes it slightly more
complex on all architectures to do large read/write calls on /dev/mem
but it's not exactly a performance path.

>> + * arch/ia64/kernel/mem.c ...  +extern loff_t memory_lseek(struct
>> file * file, loff_t offset, int orig); +extern int mmap_kmem(struct
>> file * file, struct vm_area_struct * vma); +extern int
>> open_port(struct inode * inode, struct file * filp); +

Andrew> Please find a .h file for the function prototypes.

All gone with the merge into drivers/char/mem.c

Note, I put the macros in include/asm-ia64/uaccess.h to avoid all hell
breaking lose in the ia64 build process which generates offsets.h. We
can introduce a new header file but it seems a bit overkill imho.

Cheers,
Jes

Convert /dev/mem read/write calls to use arch_translate_mem_ptr if
available. Needed on ia64 for pages converted fo uncached mappings to
avoid it being accessed in cached mode after the conversion which can
lead to memory corruption. Introduces PG_uncached page flag for
marking pages uncached.

Also folds do_write_mem into write_mem as it was it's only user.

Signed-off-by: Jes Sorensen <jes@wildopensource.com>


diff -urN -X /usr/people/jes/exclude-linux --exclude=shubio.h linux-2.6.11-rc3-mm2-vanilla/drivers/char/mem.c linux-2.6.11-rc3-mm2-2/drivers/char/mem.c
--- linux-2.6.11-rc3-mm2-vanilla/drivers/char/mem.c	2005-02-16 11:20:55 -08:00
+++ linux-2.6.11-rc3-mm2-2/drivers/char/mem.c	2005-02-23 01:51:54 -08:00
@@ -125,39 +125,6 @@
 	}
 	return 1;
 }
-static ssize_t do_write_mem(void *p, unsigned long realp,
-			    const char __user * buf, size_t count, loff_t *ppos)
-{
-	ssize_t written;
-	unsigned long copied;
-
-	written = 0;
-#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
-	/* we don't have page 0 mapped on sparc and m68k.. */
-	if (realp < PAGE_SIZE) {
-		unsigned long sz = PAGE_SIZE-realp;
-		if (sz > count) sz = count; 
-		/* Hmm. Do something? */
-		buf+=sz;
-		p+=sz;
-		count-=sz;
-		written+=sz;
-	}
-#endif
-	if (!range_is_allowed(realp, realp+count))
-		return -EPERM;
-	copied = copy_from_user(p, buf, count);
-	if (copied) {
-		ssize_t ret = written + (count - copied);
-
-		if (ret)
-			return ret;
-		return -EFAULT;
-	}
-	written += count;
-	*ppos += written;
-	return written;
-}
 
 #ifndef ARCH_HAS_DEV_MEM
 /*
@@ -168,7 +135,9 @@
 			size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	ssize_t read;
+	ssize_t read, sz;
+	struct page *page;
+	char *ptr;
 
 	if (!valid_phys_addr_range(p, &count))
 		return -EFAULT;
@@ -176,7 +145,7 @@
 #if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
 	/* we don't have page 0 mapped on sparc and m68k.. */
 	if (p < PAGE_SIZE) {
-		unsigned long sz = PAGE_SIZE-p;
+		sz = PAGE_SIZE - p;
 		if (sz > count) 
 			sz = count; 
 		if (sz > 0) {
@@ -189,9 +158,35 @@
 		}
 	}
 #endif
-	if (copy_to_user(buf, __va(p), count))
-		return -EFAULT;
-	read += count;
+
+	while (count > 0) {
+		/*
+		 * Handle first page in case it's not aligned
+		 */
+		if (-p & (PAGE_SIZE - 1))
+			sz = -p & (PAGE_SIZE - 1);
+		else
+			sz = min(PAGE_SIZE, count);
+
+		page = pfn_to_page(p >> PAGE_SHIFT);
+		/*
+		 * On ia64 if a page has been mapped somewhere as
+		 * uncached, then it must also be accessed uncached
+		 * by the kernel or data corruption may occur
+		 */
+#ifdef ARCH_HAS_TRANSLATE_MEM_PTR
+		ptr = arch_translate_mem_ptr(page, p);
+#else
+		ptr = __va(p);
+#endif
+		if (copy_to_user(buf, ptr, sz))
+			return -EFAULT;
+		buf += sz;
+		p += sz;
+		count -= sz;
+		read += sz;
+	}
+
 	*ppos += read;
 	return read;
 }
@@ -200,10 +195,70 @@
 			 size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
+	ssize_t written, sz;
+	unsigned long copied;
+	struct page *page;
+	void *ptr;
 
 	if (!valid_phys_addr_range(p, &count))
 		return -EFAULT;
-	return do_write_mem(__va(p), p, buf, count, ppos);
+
+	if (!range_is_allowed(p, p + count))
+		return -EPERM;
+
+	written = 0;
+
+#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
+	/* we don't have page 0 mapped on sparc and m68k.. */
+	if (p < PAGE_SIZE) {
+		unsigned long sz = PAGE_SIZE - p;
+		if (sz > count)
+			sz = count; 
+		/* Hmm. Do something? */
+		buf += sz;
+		p += sz;
+		count -= sz;
+		written += sz;
+	}
+#endif
+
+	while (count > 0) {
+		/*
+		 * Handle first page in case it's not aligned
+		 */
+		if (-p & (PAGE_SIZE - 1))
+			sz = -p & (PAGE_SIZE - 1);
+		else
+			sz = min(PAGE_SIZE, count);
+
+		page = pfn_to_page(p >> PAGE_SHIFT);
+		/*
+		 * On ia64 if a page has been mapped somewhere as
+		 * uncached, then it must also be accessed uncached
+		 * by the kernel or data corruption may occur
+		 */
+#ifdef ARCH_HAS_TRANSLATE_MEM_PTR
+		ptr = arch_translate_mem_ptr(page, p);
+#else
+		ptr = __va(p);
+#endif
+		copied = copy_from_user(ptr, buf, sz);
+		if (copied) {
+			ssize_t ret;
+
+			ret = written + (sz - copied);
+			if (ret)
+				return ret;
+			return -EFAULT;
+		}
+		buf += sz;
+		p += sz;
+		count -= sz;
+		written += sz;
+	}
+
+	*ppos += written;
+	return written;
 }
 #endif
 
diff -urN -X /usr/people/jes/exclude-linux --exclude=shubio.h linux-2.6.11-rc3-mm2-vanilla/include/asm-ia64/uaccess.h linux-2.6.11-rc3-mm2-2/include/asm-ia64/uaccess.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-ia64/uaccess.h	2005-02-16 11:20:23 -08:00
+++ linux-2.6.11-rc3-mm2-2/include/asm-ia64/uaccess.h	2005-02-23 00:42:12 -08:00
@@ -35,6 +35,8 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/page-flags.h>
+#include <linux/mm.h>
 
 #include <asm/intrinsics.h>
 #include <asm/pgtable.h>
@@ -365,6 +367,20 @@
 		return 1;
 	}
 	return 0;
+}
+
+#define ARCH_HAS_TRANSLATE_MEM_PTR	1
+static __inline__ char *
+arch_translate_mem_ptr (struct page *page, unsigned long p)
+{
+	char * ptr;
+
+	if (PageUncached(page))
+		ptr = (char *)p + __IA64_UNCACHED_OFFSET;
+	else
+		ptr = __va(p);
+
+	return ptr;
 }
 
 #endif /* _ASM_IA64_UACCESS_H */
diff -urN -X /usr/people/jes/exclude-linux --exclude=shubio.h linux-2.6.11-rc3-mm2-vanilla/include/linux/page-flags.h linux-2.6.11-rc3-mm2-2/include/linux/page-flags.h
--- linux-2.6.11-rc3-mm2-vanilla/include/linux/page-flags.h	2005-02-16 11:20:57 -08:00
+++ linux-2.6.11-rc3-mm2-2/include/linux/page-flags.h	2005-02-22 13:40:22 -08:00
@@ -76,7 +76,7 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_nosave_free		19	/* Free, should not be written */
-
+#define PG_uncached		20	/* Page has been mapped as uncached */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -301,6 +301,10 @@
 #else
 #define PageSwapCache(page)	0
 #endif
+
+#define PageUncached(page)	test_bit(PG_uncached, &(page)->flags)
+#define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
+#define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
 struct page;	/* forward declaration */
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVBXQTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVBXQTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVBXQTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:19:50 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:44676 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262379AbVBXQLz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:11:55 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050222020309.4289504c.akpm@osdl.org>
	<yq0ekf8lksf.fsf@jaguar.mkp.net>
	<20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
	<20050222112513.4162860d.akpm@osdl.org>
	<yq0zmxwgqxr.fsf@jaguar.mkp.net>
	<20050222153456.502c3907.akpm@osdl.org>
	<yq0sm3negtb.fsf@jaguar.mkp.net>
	<20050223223404.GA21383@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 24 Feb 2005 11:11:48 -0500
In-Reply-To: <20050223223404.GA21383@infradead.org>
Message-ID: <yq0k6oydjjv.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> Please remove the ifdef by letting every architecture
Christoph> implement a arch_translate_mem_ptr (and give it a saner
Christoph> name while you're at it).

Ok, I thought it was tidier the other way, but I am not biased.

Christoph> Also shouldn't the pfn_to_page be done inside
Christoph> arch_translate_mem_ptr?  The struct page * isn't used
Christoph> anywhere else.

Done!

>> + if (!range_is_allowed(p, p + count))

Christoph> isn't the name a little too generic?

Actually, thats an old function, nothing I added - but I renamed it.

Christoph> While you're at it replace the ifdef mania with a #ifdef
Christoph> __HAVE_ARCH_PAGE_ZERO_MAPPED or something similar.

Using __ARCH_HAS_NO_PAGE_ZERO_MAPPED for it now.

Cheers,
Jes

Convert /dev/mem read/write calls to use arch_translate_mem_ptr if
available. Needed on ia64 for pages converted fo uncached mappings to
avoid it being accessed in cached mode after the conversion which can
lead to memory corruption. Introduces PG_uncached page flag for
marking pages uncached.

Also folds do_write_mem into write_mem as it was it's only user.

Use __ARCH_HAS_NO_PAGE_ZERO_MAPPED for architectures to indicate they
require magic handling of the zero page (Sparc and m68k).

Signed-off-by: Jes Sorensen <jes@wildopensource.com>


diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/drivers/char/mem.c linux-2.6.11-rc3-mm2-3/drivers/char/mem.c
--- linux-2.6.11-rc3-mm2-vanilla/drivers/char/mem.c	2005-02-16 11:20:55 -08:00
+++ linux-2.6.11-rc3-mm2-3/drivers/char/mem.c	2005-02-24 04:45:34 -08:00
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
@@ -168,15 +135,16 @@
 			size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	ssize_t read;
+	ssize_t read, sz;
+	char *ptr;
 
 	if (!valid_phys_addr_range(p, &count))
 		return -EFAULT;
 	read = 0;
-#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
+#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
 	/* we don't have page 0 mapped on sparc and m68k.. */
 	if (p < PAGE_SIZE) {
-		unsigned long sz = PAGE_SIZE-p;
+		sz = PAGE_SIZE - p;
 		if (sz > count) 
 			sz = count; 
 		if (sz > 0) {
@@ -189,9 +157,31 @@
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
+		/*
+		 * On ia64 if a page has been mapped somewhere as
+		 * uncached, then it must also be accessed uncached
+		 * by the kernel or data corruption may occur
+		 */
+		ptr = xlate_dev_mem_ptr(p);
+
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
@@ -200,10 +190,65 @@
 			 size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
+	ssize_t written, sz;
+	unsigned long copied;
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
+#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
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
+		/*
+		 * On ia64 if a page has been mapped somewhere as
+		 * uncached, then it must also be accessed uncached
+		 * by the kernel or data corruption may occur
+		 */
+		ptr = xlate_dev_mem_ptr(p);
+
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
 
@@ -303,7 +348,7 @@
 		if (count > (unsigned long) high_memory - p)
 			read = (unsigned long) high_memory - p;
 
-#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
+#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
 		/* we don't have page 0 mapped on sparc and m68k.. */
 		if (p < PAGE_SIZE && read > 0) {
 			size_t tmp = PAGE_SIZE - p;
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-alpha/io.h linux-2.6.11-rc3-mm2-3/include/asm-alpha/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-alpha/io.h	2004-12-24 13:35:28 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-alpha/io.h	2005-02-24 04:41:25 -08:00
@@ -666,6 +666,12 @@
 #define writeq writeq
 #define readq readq
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* __KERNEL__ */
 
 #endif /* __ALPHA_IO_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-arm/io.h linux-2.6.11-rc3-mm2-3/include/asm-arm/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-arm/io.h	2004-12-24 13:34:30 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-arm/io.h	2005-02-24 04:41:48 -08:00
@@ -271,5 +271,11 @@
 #define BIOVEC_MERGEABLE(vec1, vec2)	\
 	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_ARM_IO_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-arm26/io.h linux-2.6.11-rc3-mm2-3/include/asm-arm26/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-arm26/io.h	2004-12-24 13:35:00 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-arm26/io.h	2005-02-24 04:41:56 -08:00
@@ -420,5 +420,11 @@
 #define BIOVEC_MERGEABLE(vec1, vec2)	\
 	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_ARM_IO_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-cris/io.h linux-2.6.11-rc3-mm2-3/include/asm-cris/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-cris/io.h	2004-12-24 13:35:23 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-cris/io.h	2005-02-24 04:42:07 -08:00
@@ -86,4 +86,10 @@
 #define outsw(x,y,z)
 #define outsl(x,y,z)
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-frv/io.h linux-2.6.11-rc3-mm2-3/include/asm-frv/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-frv/io.h	2005-02-16 11:20:23 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-frv/io.h	2005-02-24 04:42:19 -08:00
@@ -273,6 +273,13 @@
 	__asm__ __volatile__ ("membar" : : :"memory");
 }
 
+
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_IO_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-h8300/io.h linux-2.6.11-rc3-mm2-3/include/asm-h8300/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-h8300/io.h	2004-12-24 13:34:58 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-h8300/io.h	2005-02-24 04:42:32 -08:00
@@ -317,6 +317,12 @@
 #define virt_to_bus virt_to_phys
 #define bus_to_virt phys_to_virt
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* __KERNEL__ */
 
 #endif /* _H8300_IO_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-i386/io.h linux-2.6.11-rc3-mm2-3/include/asm-i386/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-i386/io.h	2004-12-24 13:35:40 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-i386/io.h	2005-02-24 04:41:07 -08:00
@@ -49,6 +49,12 @@
 
 #include <linux/vmalloc.h>
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 /**
  *	virt_to_phys	-	map virtual addresses to physical
  *	@address: address to remap
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-ia64/uaccess.h linux-2.6.11-rc3-mm2-3/include/asm-ia64/uaccess.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-ia64/uaccess.h	2005-02-16 11:20:23 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-ia64/uaccess.h	2005-02-24 04:47:01 -08:00
@@ -35,6 +35,8 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/page-flags.h>
+#include <linux/mm.h>
 
 #include <asm/intrinsics.h>
 #include <asm/pgtable.h>
@@ -365,6 +367,22 @@
 		return 1;
 	}
 	return 0;
+}
+
+#define ARCH_HAS_TRANSLATE_MEM_PTR	1
+static __inline__ char *
+xlate_dev_mem_ptr (unsigned long p)
+{
+	struct page *page;
+	char * ptr;
+
+	page = pfn_to_page(p >> PAGE_SHIFT);
+	if (PageUncached(page))
+		ptr = (char *)p + __IA64_UNCACHED_OFFSET;
+	else
+		ptr = __va(p);
+
+	return ptr;
 }
 
 #endif /* _ASM_IA64_UACCESS_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-m32r/io.h linux-2.6.11-rc3-mm2-3/include/asm-m32r/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-m32r/io.h	2004-12-24 13:34:45 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-m32r/io.h	2005-02-24 04:43:02 -08:00
@@ -216,6 +216,12 @@
 	memcpy((void __force *) dst, src, count);
 }
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif  /* __KERNEL__ */
 
 #endif  /* _ASM_M32R_IO_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-m68k/io.h linux-2.6.11-rc3-mm2-3/include/asm-m68k/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-m68k/io.h	2004-12-24 13:35:00 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-m68k/io.h	2005-02-24 04:43:18 -08:00
@@ -359,4 +359,13 @@
 #endif
 
 #endif /* __KERNEL__ */
+
+#define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
+
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* _IO_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-m68knommu/io.h linux-2.6.11-rc3-mm2-3/include/asm-m68knommu/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-m68knommu/io.h	2004-12-24 13:34:32 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-m68knommu/io.h	2005-02-24 04:43:31 -08:00
@@ -187,6 +187,12 @@
 #define virt_to_bus virt_to_phys
 #define bus_to_virt phys_to_virt
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* __KERNEL__ */
 
 #endif /* _M68KNOMMU_IO_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-mips/io.h linux-2.6.11-rc3-mm2-3/include/asm-mips/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-mips/io.h	2005-02-16 11:20:23 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-mips/io.h	2005-02-24 04:43:42 -08:00
@@ -616,4 +616,10 @@
 #define csr_out32(v,a) (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST) = (v))
 #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST))
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* _ASM_IO_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-parisc/io.h linux-2.6.11-rc3-mm2-3/include/asm-parisc/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-parisc/io.h	2005-02-16 11:20:23 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-parisc/io.h	2005-02-24 04:43:53 -08:00
@@ -403,4 +403,10 @@
 
 #include <asm-generic/iomap.h>
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-ppc/io.h linux-2.6.11-rc3-mm2-3/include/asm-ppc/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-ppc/io.h	2005-02-16 11:20:57 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-ppc/io.h	2005-02-24 04:44:04 -08:00
@@ -549,4 +549,10 @@
 #include <asm/mpc8260_pci9.h>
 #endif
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* __KERNEL__ */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-ppc64/io.h linux-2.6.11-rc3-mm2-3/include/asm-ppc64/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-ppc64/io.h	2005-02-16 11:20:23 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-ppc64/io.h	2005-02-24 04:44:11 -08:00
@@ -442,6 +442,12 @@
 extern int check_legacy_ioport(unsigned long base_port);
 
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* __KERNEL__ */
 
 #endif /* _PPC64_IO_H */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-s390/io.h linux-2.6.11-rc3-mm2-3/include/asm-s390/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-s390/io.h	2004-12-24 13:35:01 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-s390/io.h	2005-02-24 04:44:21 -08:00
@@ -107,6 +107,12 @@
 
 #define mmiowb()
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* __KERNEL__ */
 
 #endif
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-sparc/io.h linux-2.6.11-rc3-mm2-3/include/asm-sparc/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-sparc/io.h	2005-02-16 11:20:23 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-sparc/io.h	2005-02-24 04:44:28 -08:00
@@ -274,4 +274,12 @@
 
 #endif
 
+#define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
+
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* !(__SPARC_IO_H) */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-sparc64/io.h linux-2.6.11-rc3-mm2-3/include/asm-sparc64/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-sparc64/io.h	2004-12-24 13:35:25 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-sparc64/io.h	2005-02-24 04:44:38 -08:00
@@ -485,6 +485,12 @@
 #define dma_cache_wback(_start,_size)		do { } while (0)
 #define dma_cache_wback_inv(_start,_size)	do { } while (0)
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif
 
 #endif /* !(__SPARC64_IO_H) */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-um/io.h linux-2.6.11-rc3-mm2-3/include/asm-um/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-um/io.h	2004-12-24 13:35:28 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-um/io.h	2005-02-24 04:44:50 -08:00
@@ -22,4 +22,10 @@
 	return __va(address);
 }
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-v850/io.h linux-2.6.11-rc3-mm2-3/include/asm-v850/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-v850/io.h	2004-12-24 13:34:00 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-v850/io.h	2005-02-24 04:44:59 -08:00
@@ -119,4 +119,10 @@
 #define memcpy_fromio(dst, src, len) memcpy (dst, (void *)src, len)
 #define memcpy_toio(dst, src, len) memcpy ((void *)dst, src, len)
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* __V850_IO_H__ */
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/asm-x86_64/io.h linux-2.6.11-rc3-mm2-3/include/asm-x86_64/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-x86_64/io.h	2005-02-16 11:20:24 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/asm-x86_64/io.h	2005-02-24 04:45:07 -08:00
@@ -329,6 +329,12 @@
 extern int iommu_bio_merge;
 #define BIO_VMERGE_BOUNDARY iommu_bio_merge
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
 #endif /* __KERNEL__ */
 
 #endif
diff -X /usr/people/jes/exclude-linux -urN linux-2.6.11-rc3-mm2-vanilla/include/linux/page-flags.h linux-2.6.11-rc3-mm2-3/include/linux/page-flags.h
--- linux-2.6.11-rc3-mm2-vanilla/include/linux/page-flags.h	2005-02-16 11:20:57 -08:00
+++ linux-2.6.11-rc3-mm2-3/include/linux/page-flags.h	2005-02-24 02:08:57 -08:00
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
 

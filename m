Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVBVWlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVBVWlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVBVWlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:41:53 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:4073 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261316AbVBVWjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:39:33 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050222020309.4289504c.akpm@osdl.org>
	<yq0ekf8lksf.fsf@jaguar.mkp.net>
	<20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
	<20050222112513.4162860d.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 22 Feb 2005 17:39:28 -0500
In-Reply-To: <20050222112513.4162860d.akpm@osdl.org>
Message-ID: <yq0zmxwgqxr.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Matthew Wilcox <matthew@wil.cx> wrote:
>> 
>> On Tue, Feb 22, 2005 at 09:41:04AM -0500, Jes Sorensen wrote:
>> > >> + if (page->flags & PG_uncached)
>> > 
>> > Andrew> dude.  That ain't gonna work ;)
>> > 
>> > Pardon my lack of clue, but why not?

Andrew> 	if (page->flags & (1<<PG_uncached))

Andrew> would have been correcter.

Andrew,

After applying the clue 2x4 to my head a couple of times, I came up
with this patch. Hopefully it will work a bit better ;-)

Cheers,
Jes

Signed-off-by: Jes Sorensen <jes@wildopensource.com>

diff -urN -X /usr/people/jes/exclude-linux linux-2.6.11-rc3-mm2-vanilla/arch/ia64/kernel/Makefile linux-2.6.11-rc3-mm2/arch/ia64/kernel/Makefile
--- linux-2.6.11-rc3-mm2-vanilla/arch/ia64/kernel/Makefile	2005-02-16 11:20:19 -08:00
+++ linux-2.6.11-rc3-mm2/arch/ia64/kernel/Makefile	2005-02-16 11:58:35 -08:00
@@ -7,7 +7,7 @@
 obj-y := acpi.o entry.o efi.o efi_stub.o gate-data.o fsys.o ia64_ksyms.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o machvec.o pal.o patch.o process.o perfmon.o ptrace.o sal.o		\
 	 salinfo.o semaphore.o setup.o signal.o sys_ia64.o time.o traps.o unaligned.o \
-	 unwind.o mca.o mca_asm.o topology.o
+	 unwind.o mca.o mca_asm.o topology.o mem.o
 
 obj-$(CONFIG_IA64_BRL_EMU)	+= brl_emu.o
 obj-$(CONFIG_IA64_GENERIC)	+= acpi-ext.o
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.11-rc3-mm2-vanilla/arch/ia64/kernel/mem.c linux-2.6.11-rc3-mm2/arch/ia64/kernel/mem.c
--- linux-2.6.11-rc3-mm2-vanilla/arch/ia64/kernel/mem.c	1969-12-31 16:00:00 -08:00
+++ linux-2.6.11-rc3-mm2/arch/ia64/kernel/mem.c	2005-02-22 14:11:40 -08:00
@@ -0,0 +1,151 @@
+/*
+ *  arch/ia64/kernel/mem.c
+ *
+ *  IA64 specific  portions of /dev/mem access, notably handling
+ *  read/write from uncached memory
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 2005 Jes Sorensen <jes@wildopensource.com>
+ */
+
+
+#include <linux/mm.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+
+extern loff_t memory_lseek(struct file * file, loff_t offset, int orig);
+extern int mmap_kmem(struct file * file, struct vm_area_struct * vma);
+extern int open_port(struct inode * inode, struct file * filp);
+
+
+static inline int range_is_allowed(unsigned long from, unsigned long to)
+{
+	unsigned long cursor;
+
+	cursor = from >> PAGE_SHIFT;
+	while ((cursor << PAGE_SHIFT) < to) {
+		if (!devmem_is_allowed(cursor))
+			return 0;
+		cursor++;
+	}
+	return 1;
+}
+
+
+/*
+ * This funcion reads the *physical* memory. The f_pos points directly
+ * to the memory location. 
+ */
+static ssize_t read_mem(struct file * file, char __user * buf,
+			size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	ssize_t read, sz;
+	struct page *page;
+	char *ptr;
+
+
+	if (!valid_phys_addr_range(p, &count))
+		return -EFAULT;
+	read = 0;
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
+		if (PageUncached(page))
+			ptr = (char *)p + __IA64_UNCACHED_OFFSET;
+		else
+			ptr = __va(p);
+		if (copy_to_user(buf, ptr, sz))
+			return -EFAULT;
+		buf += sz;
+		p += sz;
+		count -= sz;
+		read += sz;
+	}
+
+	*ppos += read;
+	return read;
+}
+
+
+static ssize_t write_mem(struct file * file, const char __user * buf, 
+			 size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	unsigned long copied;
+	ssize_t written, sz;
+	struct page *page;
+	char *ptr;
+
+	if (!valid_phys_addr_range(p, &count))
+		return -EFAULT;
+
+	written = 0;
+
+	if (!range_is_allowed(p, p + count))
+		return -EPERM;
+	/*
+	 * Need virtual p below here
+	 */
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
+		if (PageUncached(page))
+			ptr = (char *)p + __IA64_UNCACHED_OFFSET;
+		else
+			ptr = __va(p);
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
+}
+
+
+struct file_operations mem_fops = {
+	.llseek		= memory_lseek,
+	.read		= read_mem,
+	.write		= write_mem,
+	.mmap		= mmap_kmem,
+	.open		= open_port,
+};
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.11-rc3-mm2-vanilla/drivers/char/mem.c linux-2.6.11-rc3-mm2/drivers/char/mem.c
--- linux-2.6.11-rc3-mm2-vanilla/drivers/char/mem.c	2005-02-16 11:20:55 -08:00
+++ linux-2.6.11-rc3-mm2/drivers/char/mem.c	2005-02-16 11:58:35 -08:00
@@ -125,39 +125,7 @@
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
@@ -196,6 +164,40 @@
 	return read;
 }
 
+static ssize_t do_write_mem(void *p, unsigned long realp,
+			    const char __user * buf, size_t count, loff_t *ppos)
+{
+	ssize_t written;
+	unsigned long copied;
+
+	written = 0;
+#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
+	/* we don't have page 0 mapped on sparc and m68k.. */
+	if (realp < PAGE_SIZE) {
+		unsigned long sz = PAGE_SIZE-realp;
+		if (sz > count) sz = count; 
+		/* Hmm. Do something? */
+		buf+=sz;
+		p+=sz;
+		count-=sz;
+		written+=sz;
+	}
+#endif
+	if (!range_is_allowed(realp, realp+count))
+		return -EPERM;
+	copied = copy_from_user(p, buf, count);
+	if (copied) {
+		ssize_t ret = written + (count - copied);
+
+		if (ret)
+			return ret;
+		return -EFAULT;
+	}
+	written += count;
+	*ppos += written;
+	return written;
+}
+
 static ssize_t write_mem(struct file * file, const char __user * buf, 
 			 size_t count, loff_t *ppos)
 {
@@ -207,7 +209,8 @@
 }
 #endif
 
-static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
+
+int mmap_kmem(struct file * file, struct vm_area_struct * vma)
 {
 #ifdef pgprot_noncached
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
@@ -553,7 +556,7 @@
  * also note that seeking relative to the "end of file" isn't supported:
  * it has no meaning, so it returns -EINVAL.
  */
-static loff_t memory_lseek(struct file * file, loff_t offset, int orig)
+loff_t memory_lseek(struct file * file, loff_t offset, int orig)
 {
 	loff_t ret;
 
@@ -576,7 +579,7 @@
 	return ret;
 }
 
-static int open_port(struct inode * inode, struct file * filp)
+int open_port(struct inode * inode, struct file * filp)
 {
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.11-rc3-mm2-vanilla/include/asm-ia64/io.h linux-2.6.11-rc3-mm2/include/asm-ia64/io.h
--- linux-2.6.11-rc3-mm2-vanilla/include/asm-ia64/io.h	2005-02-16 11:20:23 -08:00
+++ linux-2.6.11-rc3-mm2/include/asm-ia64/io.h	2005-02-16 11:58:35 -08:00
@@ -481,4 +481,6 @@
 #define BIO_VMERGE_BOUNDARY	(ia64_max_iommu_merge_mask + 1)
 #endif
 
+#define ARCH_HAS_DEV_MEM
+
 #endif /* _ASM_IA64_IO_H */
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.11-rc3-mm2-vanilla/include/linux/page-flags.h linux-2.6.11-rc3-mm2/include/linux/page-flags.h
--- linux-2.6.11-rc3-mm2-vanilla/include/linux/page-flags.h	2005-02-16 11:20:57 -08:00
+++ linux-2.6.11-rc3-mm2/include/linux/page-flags.h	2005-02-22 13:40:22 -08:00
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
 

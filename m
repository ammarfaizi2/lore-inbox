Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265752AbSLEJ1D>; Thu, 5 Dec 2002 04:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbSLEJ1D>; Thu, 5 Dec 2002 04:27:03 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:13560 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265752AbSLEJ07>; Thu, 5 Dec 2002 04:26:59 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021205092523.GG9882@holomorphy.com> 
References: <20021205092523.GG9882@holomorphy.com>  <20021204222039.A12956@flint.arm.linux.org.uk> <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de> <20021204115819.GB1137@gallifrey> <20021204124227.GB647@suse.de> <20021204183235.GA701@gallifrey> <3536.1039079718@passion.cambridge.redhat.com> 
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Dec 2002 09:34:22 +0000
Message-ID: <3907.1039080862@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


wli@holomorphy.com said:
>  Is there any chance you can send a testcase my way? I've got some
> testboxen that are good at bringing out races (NUMA stuff is beautiful
> for that -- I don't consider anything racetested until it passes
> there.) 

The race in vmalloc is purely theoretical but blatantly obvious -- I don't
think anyone's actually triggered it though. You have already tried the fix
and reported it works fine. Apparently for akpm ioremap() returns a 
bogus value to the aic7xxx driver and the box locks up. I can't see why it 
could do that -- more eyes welcome...


===== include/linux/vmalloc.h 1.8 vs edited =====
--- 1.8/include/linux/vmalloc.h	Fri Nov  8 07:47:15 2002
+++ edited/include/linux/vmalloc.h	Wed Nov 20 14:27:09 2002
@@ -2,12 +2,14 @@
 #define _LINUX_VMALLOC_H
 
 #include <linux/spinlock.h>
+#include <linux/list.h>
 #include <asm/page.h>		/* pgprot_t */
 
 /* bits in vm_struct->flags */
 #define VM_IOREMAP	0x00000001	/* ioremap() and friends */
 #define VM_ALLOC	0x00000002	/* vmalloc() */
 #define VM_MAP		0x00000004	/* vmap()ed pages */
+#define VM_DELETING	0x00000008	/* Being removed */
 
 struct vm_struct {
 	void			*addr;
@@ -16,7 +18,7 @@
 	struct page		**pages;
 	unsigned int		nr_pages;
 	unsigned long		phys_addr;
-	struct vm_struct	*next;
+	struct list_head	list;
 };
 
 /*
@@ -40,9 +42,9 @@
 extern void unmap_vm_area(struct vm_struct *area);
 
 /*
- *	Internals.  Dont't use..
+ *	Internals.  Don't use.
  */
 extern rwlock_t vmlist_lock;
-extern struct vm_struct *vmlist;
+extern struct list_head vmlist;
 
 #endif /* _LINUX_VMALLOC_H */
===== mm/vmalloc.c 1.23 vs edited =====
--- 1.23/mm/vmalloc.c	Thu Oct 31 15:28:17 2002
+++ edited/mm/vmalloc.c	Wed Nov 20 14:27:09 2002
@@ -21,7 +21,7 @@
 
 
 rwlock_t vmlist_lock = RW_LOCK_UNLOCKED;
-struct vm_struct *vmlist;
+LIST_HEAD(vmlist);
 
 static void unmap_area_pte(pmd_t *pmd, unsigned long address,
 				  unsigned long size)
@@ -192,7 +192,7 @@
  */
 struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
 {
-	struct vm_struct **p, *tmp, *area;
+	struct vm_struct *tmp, *area;
 	unsigned long addr = VMALLOC_START;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
@@ -209,7 +209,7 @@
 	}
 
 	write_lock(&vmlist_lock);
-	for (p = &vmlist; (tmp = *p) ;p = &tmp->next) {
+	list_for_each_entry(tmp, &vmlist, list) {
 		if ((size + addr) < addr)
 			goto out;
 		if (size + addr <= (unsigned long)tmp->addr)
@@ -220,8 +220,7 @@
 	}
 
 found:
-	area->next = *p;
-	*p = area;
+	list_add_tail(&area->list, &tmp->list);
 
 	area->flags = flags;
 	area->addr = (void *)addr;
@@ -250,18 +249,23 @@
  */
 struct vm_struct *remove_vm_area(void *addr)
 {
-	struct vm_struct **p, *tmp;
+	struct vm_struct *tmp;
 
 	write_lock(&vmlist_lock);
-	for (p = &vmlist ; (tmp = *p) ;p = &tmp->next) {
+	list_for_each_entry(tmp, &vmlist, list) {
 		 if (tmp->addr == addr)
 			 goto found;
 	}
 	write_unlock(&vmlist_lock);
 	return NULL;
 
-found:
-	*p = tmp->next;
+ found:
+	if (tmp->flags & VM_DELETING) {
+		printk(KERN_ERR "Trying to vfree() region being freed (%p)\n", addr);
+		tmp = NULL;
+	}
+	else 
+		tmp->flags |= VM_DELETING;
 	write_unlock(&vmlist_lock);
 	return tmp;
 }
@@ -299,6 +303,10 @@
 		kfree(area->pages);
 	}
 
+	write_lock(&vmlist_lock);
+	list_del(&area->list);
+	write_unlock(&vmlist_lock);
+
 	kfree(area);
 	return;
 }
@@ -308,7 +316,7 @@
  *
  *	@addr:		memory base address
  *
- *	Free the virtually continguos memory area starting at @addr, as
+ *	Free the virtually contiguous memory area starting at @addr, as
  *	obtained from vmalloc(), vmalloc_32() or __vmalloc().
  *
  *	May not be called in interrupt context.
@@ -324,7 +332,7 @@
  *
  *	@addr:		memory base address
  *
- *	Free the virtually continguos memory area starting at @addr,
+ *	Free the virtually contiguous memory area starting at @addr,
  *	which was created from the page array passed to vmap().
  *
  *	May not be called in interrupt context.
@@ -336,12 +344,12 @@
 }
 
 /**
- *	vmap  -  map an array of pages into virtually continguos space
+ *	vmap  -  map an array of pages into virtually contiguous space
  *
  *	@pages:		array of page pointers
  *	@count:		number of pages to map
  *
- *	Maps @count pages from @pages into continguos kernel virtual
+ *	Maps @count pages from @pages into contiguous kernel virtual
  *	space.
  */
 void *vmap(struct page **pages, unsigned int count)
@@ -363,14 +371,14 @@
 }
 
 /**
- *	__vmalloc  -  allocate virtually continguos memory
+ *	__vmalloc  -  allocate virtually contiguous memory
  *
  *	@size:		allocation size
  *	@gfp_mask:	flags for the page level allocator
  *	@prot:		protection mask for the allocated pages
  *
  *	Allocate enough pages to cover @size from the page level
- *	allocator with @gfp_mask flags.  Map them into continguos
+ *	allocator with @gfp_mask flags.  Map them into contiguous
  *	kernel virtual space, using a pagetable protection of @prot.
  */
 void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot)
@@ -418,12 +426,12 @@
 }
 
 /**
- *	vmalloc  -  allocate virtually continguos memory
+ *	vmalloc  -  allocate virtually contiguous memory
  *
  *	@size:		allocation size
  *
  *	Allocate enough pages to cover @size from the page level
- *	allocator and map them into continguos kernel virtual space.
+ *	allocator and map them into contiguous kernel virtual space.
  *
  *	For tight cotrol over page level allocator and protection flags
  *	use __vmalloc() instead.
@@ -434,12 +442,12 @@
 }
 
 /**
- *	vmalloc_32  -  allocate virtually continguos memory (32bit addressable)
+ *	vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
  *
  *	@size:		allocation size
  *
  *	Allocate enough 32bit PA addressable pages to cover @size from the
- *	page level allocator and map them into continguos kernel virtual space.
+ *	page level allocator and map them into contiguous kernel virtual space.
  */
 void *vmalloc_32(unsigned long size)
 {
@@ -457,7 +465,7 @@
 		count = -(unsigned long) addr;
 
 	read_lock(&vmlist_lock);
-	for (tmp = vmlist; tmp; tmp = tmp->next) {
+	list_for_each_entry(tmp, &vmlist, list) {
 		vaddr = (char *) tmp->addr;
 		if (addr >= vaddr + tmp->size - PAGE_SIZE)
 			continue;
@@ -495,7 +503,7 @@
 		count = -(unsigned long) addr;
 
 	read_lock(&vmlist_lock);
-	for (tmp = vmlist; tmp; tmp = tmp->next) {
+	list_for_each_entry(tmp, &vmlist, list) {
 		vaddr = (char *) tmp->addr;
 		if (addr >= vaddr + tmp->size - PAGE_SIZE)
 			continue;
===== fs/proc/kcore.c 1.7 vs edited =====
--- 1.7/fs/proc/kcore.c	Tue Oct 29 00:51:13 2002
+++ edited/fs/proc/kcore.c	Wed Nov 20 14:27:09 2002
@@ -121,12 +121,12 @@
 
 	*num_vma = 0;
 	size = ((size_t)high_memory - KCORE_BASE + PAGE_SIZE);
-	if (!vmlist) {
+	if (list_empty(&vmlist)) {
 		*elf_buflen = PAGE_SIZE;
 		return (size);
 	}
 
-	for (m=vmlist; m; m=m->next) {
+	list_for_each_entry(m, &vmlist, list) {
 		try = (size_t)m->addr + m->size;
 		if (try > KCORE_BASE + size)
 			size = try - KCORE_BASE;
@@ -246,7 +246,7 @@
 	phdr->p_align	= PAGE_SIZE;
 
 	/* setup ELF PT_LOAD program header for every vmalloc'd area */
-	for (m=vmlist; m; m=m->next) {
+	list_for_each_entry(m, &vmlist, list) {
 		if (m->flags & VM_IOREMAP) /* don't dump ioremap'd stuff! (TA) */
 			continue;
 
@@ -406,11 +406,15 @@
 			memset(elf_buf, 0, tsz);
 
 			read_lock(&vmlist_lock);
-			for (m=vmlist; m && cursize; m=m->next) {
+			list_for_each_entry(m, &vmlist, list) {
 				unsigned long vmstart;
 				unsigned long vmsize;
-				unsigned long msize = m->size - PAGE_SIZE;
+				unsigned long msize;
 
+				if (!cursize)
+					break;
+
+				msize = m->size - PAGE_SIZE;
 				if (((unsigned long)m->addr + msize) < 
 								curstart)
 					continue;

--
dwmw2




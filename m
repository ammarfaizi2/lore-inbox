Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262725AbSJCEeT>; Thu, 3 Oct 2002 00:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262729AbSJCEeT>; Thu, 3 Oct 2002 00:34:19 -0400
Received: from dp.samba.org ([66.70.73.150]:25472 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262725AbSJCEeQ>;
	Thu, 3 Oct 2002 00:34:16 -0400
Date: Thu, 3 Oct 2002 14:39:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@digeo.com>
Cc: David Miller <davem@redhat.com>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH,RFC] Add gfp_mask to get_vm_area()
Message-ID: <20021003043948.GN1102@zax>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	David Miller <davem@redhat.com>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
References: <20021001044226.GS10265@zax> <3D992DB0.9A8942D@digeo.com> <20021001053417.GW10265@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001053417.GW10265@zax>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 03:34:17PM +1000, David Gibson wrote:
> 
> On Mon, Sep 30, 2002 at 10:08:00PM -0700, Andrew Morton wrote:
> >
> > David Gibson wrote:
> > >
> > > Dave, please consider this patch.  It renames get_vm_area() to
> > > __get_vm_area() and adds a gfp_mask parameter which is passed on to
> > > kmalloc().  get_vm_area(size,flags) is then defined as as
> > > __get_vm_area(size,flags,GFP_KERNEL) to avoid messing with existing
> > > callers.
> > >
> > > We need this in order to sanely make pci_alloc_consistent() (and other
> > > consistent allocation functions) obey the DMA-mapping.txt rules on PPC
> > > embedded machines (specifically the requirement that it be callable
> > > from interrupt context).
> > >
> >
> > I can look after that for you.  But I'd prefer that you just add the
> > extra gfp_flags argument to get_vm_area() and update the 16 callers.
> >
> > You cannot call get_vm_area() from interrupt context at present;
> > it does write_lock(&vmlist_lock) unsafely.
> 
> Oh crap, I'm an idiot.  I've even seen prototype patches for this one
> that changed the write_lock() to write_lock_irq(). Duh.
> 
> > It would be a bit sad to make vmlist_lock interrupt-safe for this.  Is
> > there no alternative?
> 
> I don't see an easy one: PPC 4xx has non-coherent cache, so we have to
> mark consistent memory non-cacheable.  We want to make the normal
> lowmem mapping use large page TLB entries, so we can't frob the
> attribute bits on the pages in place.  That means we need to create a
> new, non-cacheable mapping for the physical RAM we allocate, which in
> turn means allocating a chunk of kernel virtual memory.

Well, here is an updated patch which should make the vmlist_lock
interrupt-safe.  It makes __get_vm_area() and remove_vm_area()
callable from interrupt context.  If you can think of some way of
avoiding doing that, I'd love to hear it - I agree this would be
rather sad.

Thoughts?

Incidentally, DaveM, what's the rationale for requiring the consistent
allocation functions to be callable from interrupt context?  It's not
immediately obvious to me.

diff -urN /home/dgibson/kernel/linuxppc-2.5/fs/proc/kcore.c linux-bluefish/fs/proc/kcore.c
--- /home/dgibson/kernel/linuxppc-2.5/fs/proc/kcore.c	2002-10-01 10:17:33.000000000 +1000
+++ linux-bluefish/fs/proc/kcore.c	2002-10-03 14:25:32.000000000 +1000
@@ -318,10 +318,10 @@
 	int num_vma;
 	unsigned long start;
 
-	read_lock(&vmlist_lock);
+	read_lock_irq(&vmlist_lock);
 	proc_root_kcore->size = size = get_kcore_size(&num_vma, &elf_buflen);
 	if (buflen == 0 || *fpos >= size) {
-		read_unlock(&vmlist_lock);
+		read_unlock_irq(&vmlist_lock);
 		return 0;
 	}
 
@@ -338,12 +338,12 @@
 			tsz = buflen;
 		elf_buf = kmalloc(elf_buflen, GFP_ATOMIC);
 		if (!elf_buf) {
-			read_unlock(&vmlist_lock);
+			read_unlock_irq(&vmlist_lock);
 			return -ENOMEM;
 		}
 		memset(elf_buf, 0, elf_buflen);
 		elf_kcore_store_hdr(elf_buf, num_vma, elf_buflen);
-		read_unlock(&vmlist_lock);
+		read_unlock_irq(&vmlist_lock);
 		if (copy_to_user(buffer, elf_buf + *fpos, tsz)) {
 			kfree(elf_buf);
 			return -EFAULT;
@@ -358,7 +358,7 @@
 		if (buflen == 0)
 			return acc;
 	} else
-		read_unlock(&vmlist_lock);
+		read_unlock_irq(&vmlist_lock);
 
 	/* where page 0 not mapped, write zeros into buffer */
 #if defined (__i386__) || defined (__mc68000__) || defined(__x86_64__)
@@ -403,7 +403,7 @@
 				return -ENOMEM;
 			memset(elf_buf, 0, tsz);
 
-			read_lock(&vmlist_lock);
+			read_lock_irq(&vmlist_lock);
 			for (m=vmlist; m && cursize; m=m->next) {
 				unsigned long vmstart;
 				unsigned long vmsize;
@@ -431,7 +431,7 @@
 				memcpy(elf_buf + (vmstart - start),
 					(char *)vmstart, vmsize);
 			}
-			read_unlock(&vmlist_lock);
+			read_unlock_irq(&vmlist_lock);
 			if (copy_to_user(buffer, elf_buf, tsz)) {
 				kfree(elf_buf);
 				return -EFAULT;
diff -urN /home/dgibson/kernel/linuxppc-2.5/include/linux/vmalloc.h linux-bluefish/include/linux/vmalloc.h
--- /home/dgibson/kernel/linuxppc-2.5/include/linux/vmalloc.h	2002-09-20 14:36:15.000000000 +1000
+++ linux-bluefish/include/linux/vmalloc.h	2002-10-01 14:29:10.000000000 +1000
@@ -32,7 +32,8 @@
 /*
  *	Lowlevel-APIs (not for driver use!)
  */
-extern struct vm_struct *get_vm_area(unsigned long size, unsigned long flags);
+extern struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags, int gfp_mask);
+#define get_vm_area(size, flags) __get_vm_area(size, flags, GFP_KERNEL)
 extern struct vm_struct *remove_vm_area(void *addr);
 extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
 			struct page ***pages);
diff -urN /home/dgibson/kernel/linuxppc-2.5/mm/vmalloc.c linux-bluefish/mm/vmalloc.c
--- /home/dgibson/kernel/linuxppc-2.5/mm/vmalloc.c	2002-09-20 14:36:26.000000000 +1000
+++ linux-bluefish/mm/vmalloc.c	2002-10-03 14:27:40.000000000 +1000
@@ -181,21 +181,23 @@
 
 
 /**
- *	get_vm_area  -  reserve a contingous kernel virtual area
+ *	__get_vm_area  -  reserve a contingous kernel virtual area
  *
  *	@size:		size of the area
  *	@flags:		%VM_IOREMAP for I/O mappings or VM_ALLOC
+ *	@gfp_mask:	gfp flags to pass to kmalloc()
  *
  *	Search an area of @size in the kernel virtual mapping area,
  *	and reserved it for out purposes.  Returns the area descriptor
  *	on success or %NULL on failure.
  */
-struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
+struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags, int gfp_mask)
 {
 	struct vm_struct **p, *tmp, *area;
 	unsigned long addr = VMALLOC_START;
+	unsigned long flags;
 
-	area = kmalloc(sizeof(*area), GFP_KERNEL);
+	area = kmalloc(sizeof(*area), gfp_mask);
 	if (unlikely(!area))
 		return NULL;
 
@@ -204,7 +206,7 @@
 	 */
 	size += PAGE_SIZE;
 
-	write_lock(&vmlist_lock);
+	write_lock_irqsave(&vmlist_lock, flags);
 	for (p = &vmlist; (tmp = *p) ;p = &tmp->next) {
 		if ((size + addr) < addr)
 			goto out;
@@ -225,12 +227,12 @@
 	area->pages = NULL;
 	area->nr_pages = 0;
 	area->phys_addr = 0;
-	write_unlock(&vmlist_lock);
+	write_unlock_irqrestore(&vmlist_lock, flags);
 
 	return area;
 
 out:
-	write_unlock(&vmlist_lock);
+	write_unlock_irqrestore(&vmlist_lock, flags);
 	kfree(area);
 	return NULL;
 }
@@ -247,18 +249,19 @@
 struct vm_struct *remove_vm_area(void *addr)
 {
 	struct vm_struct **p, *tmp;
+	unsigned long flags;
 
-	write_lock(&vmlist_lock);
+	write_lock_irqsave(&vmlist_lock, flags);
 	for (p = &vmlist ; (tmp = *p) ;p = &tmp->next) {
 		 if (tmp->addr == addr)
 			 goto found;
 	}
-	write_unlock(&vmlist_lock);
+	write_unlock_irqrestore(&vmlist_lock, flags);
 	return NULL;
 
 found:
 	*p = tmp->next;
-	write_unlock(&vmlist_lock);
+	write_unlock_irqrestore(&vmlist_lock, flags);
 	return tmp;
 }
 
@@ -452,7 +455,7 @@
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;
 
-	read_lock(&vmlist_lock);
+	read_lock_irq(&vmlist_lock);
 	for (tmp = vmlist; tmp; tmp = tmp->next) {
 		vaddr = (char *) tmp->addr;
 		if (addr >= vaddr + tmp->size - PAGE_SIZE)
@@ -476,7 +479,7 @@
 		} while (--n > 0);
 	}
 finished:
-	read_unlock(&vmlist_lock);
+	read_unlock_irq(&vmlist_lock);
 	return buf - buf_start;
 }
 
@@ -490,7 +493,7 @@
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;
 
-	read_lock(&vmlist_lock);
+	read_lock_irq(&vmlist_lock);
 	for (tmp = vmlist; tmp; tmp = tmp->next) {
 		vaddr = (char *) tmp->addr;
 		if (addr >= vaddr + tmp->size - PAGE_SIZE)
@@ -513,6 +516,6 @@
 		} while (--n > 0);
 	}
 finished:
-	read_unlock(&vmlist_lock);
+	read_unlock_irq(&vmlist_lock);
 	return buf - buf_start;
 }


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

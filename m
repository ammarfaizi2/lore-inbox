Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261484AbSJAEtM>; Tue, 1 Oct 2002 00:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbSJAEtM>; Tue, 1 Oct 2002 00:49:12 -0400
Received: from dp.samba.org ([66.70.73.150]:11447 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261484AbSJAEtL>;
	Tue, 1 Oct 2002 00:49:11 -0400
Date: Tue, 1 Oct 2002 14:54:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>, David Miller <davem@redhat.com>,
       linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Add gfp_mask to get_vm_area()
Message-ID: <20021001045439.GU10265@zax>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Paul Mackerras <paulus@samba.org>, David Miller <davem@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please consider this patch.  It renames get_vm_area() to
__get_vm_area() and adds a gfp_mask parameter which is passed on to
kmalloc().  get_vm_area(size,flags) is then defined as as
__get_vm_area(size,flags,GFP_KERNEL) to avoid messing with existing
callers.

We need this in order to sanely make pci_alloc_consistent() (and other
consistent allocation functions) obey the DMA-mapping.txt rules on PPC
embedded machines (specifically the requirement that it be callable
from interrupt context).

DaveM seems to think it's ok :-)

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
+++ linux-bluefish/mm/vmalloc.c	2002-10-01 14:30:02.000000000 +1000
@@ -181,21 +181,22 @@


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

-	area = kmalloc(sizeof(*area), GFP_KERNEL);
+	area = kmalloc(sizeof(*area), gfp_mask);
 	if (unlikely(!area))
 		return NULL;


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272316AbTHNMJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272319AbTHNMJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:09:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54544 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272316AbTHNMIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:08:13 -0400
Date: Thu, 14 Aug 2003 13:08:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Make modules work in Linus' tree on ARM
Message-ID: <20030814130810.A332@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows modules to work in Linus' tree for ARM, and is the one
thing which prevents Linus' tree from building for any ARM machine.

After reviewing the /proc/kcore and kclist issues, I've decided that I'm
no longer prepared to even _think_ about supporting /proc/kcore on ARM -
it just gets too ugly, and adds too much code to make it worth the effort,
the time or the energy to implement a solution to that problem.  This is
especially true since most people use kgdb or similar rather than
/proc/kcore anyway.  /proc/kcore is a "wouldn't it be nice" feature.

The reasons that I'm going with this solution rather than fixing
/proc/kcore is that:

- to add a kclist entry for each module would mean hacking the kclist
  structure into vm_struct's ->page pointer with disgusting hacks.
  I think we can all agree that this isn't the way to go.  The
  alternative is to create Yet Another Memory Allocator, and this
  isn't something I want to see in what is now an embedded architecture.

- we'd need to find some way to dynamically reserve the virtual mapped
  memory regions for the kernel direct mapped RAM.  Since ARM uses a
  generic memory initialisation implementation which handles contiguous
  and discontiguous memory, it doesn't lend itself well to the kclist
  approach, and I'm not about to add extra callbacks from init/main.c
  (so we have kmalloc available) just to support this.

If someone _else_ wants to put the effort into fixing ARM modules to work
nicely with /proc/kcore, be my guest - I'm just no longer interested in
this problem space.

Maybe in 2.7 a generic "reserve an area of memory in this region" 
function like __get_vm_area below is in order?

Therefore, I'm providing a patch which adds the necessary changes to the
core kernel code to make the current modules solution work for ARM.

Please merge.

--- orig/mm/vmalloc.c	Tue May 27 10:05:48 2003
+++ linux/mm/vmalloc.c	Tue May 27 10:14:45 2003
@@ -178,21 +178,11 @@
 	return err;
 }
 
-
-/**
- *	get_vm_area  -  reserve a contingous kernel virtual area
- *
- *	@size:		size of the area
- *	@flags:		%VM_IOREMAP for I/O mappings or VM_ALLOC
- *
- *	Search an area of @size in the kernel virtual mapping area,
- *	and reserved it for out purposes.  Returns the area descriptor
- *	on success or %NULL on failure.
- */
-struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
+struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
+				unsigned long start, unsigned long end)
 {
 	struct vm_struct **p, *tmp, *area;
-	unsigned long addr = VMALLOC_START;
+	unsigned long addr = start;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
@@ -209,12 +199,14 @@
 
 	write_lock(&vmlist_lock);
 	for (p = &vmlist; (tmp = *p) ;p = &tmp->next) {
+		if ((unsigned long)tmp->addr < addr)
+			continue;
 		if ((size + addr) < addr)
 			goto out;
 		if (size + addr <= (unsigned long)tmp->addr)
 			goto found;
 		addr = tmp->size + (unsigned long)tmp->addr;
-		if (addr > VMALLOC_END-size)
+		if (addr > end - size)
 			goto out;
 	}
 
@@ -239,6 +231,21 @@
 }
 
 /**
+ *	get_vm_area  -  reserve a contingous kernel virtual area
+ *
+ *	@size:		size of the area
+ *	@flags:		%VM_IOREMAP for I/O mappings or VM_ALLOC
+ *
+ *	Search an area of @size in the kernel virtual mapping area,
+ *	and reserved it for out purposes.  Returns the area descriptor
+ *	on success or %NULL on failure.
+ */
+struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
+{
+	return __get_vm_area(size, flags, VMALLOC_START, VMALLOC_END);
+}
+
+/**
  *	remove_vm_area  -  find and remove a contingous kernel virtual area
  *
  *	@addr:		base address

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


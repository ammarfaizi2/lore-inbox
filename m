Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267749AbTAaKKw>; Fri, 31 Jan 2003 05:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267750AbTAaKKw>; Fri, 31 Jan 2003 05:10:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26385 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267749AbTAaKKu>; Fri, 31 Jan 2003 05:10:50 -0500
Date: Fri, 31 Jan 2003 10:20:13 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: vmalloc/module_alloc: unable to handle two memory regions
Message-ID: <20030131102013.A19646@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ARM, modules need to either be placed within 32MB of the kernel
image, or we need to build a jump table for code jumps within the
module to reach the main kernel body.

In order to solve this problem, we created a 16MB region between
TASK_SIZE and PAGE_OFFSET for modules.  Any allocations within this
range are required to be linked into the "vmlist" for /proc/kcore -
this list also used by vmalloc() and friends.

On ARM, we end up with the following virtual memory layout:

 +----------------------------+ 4GB
   devices
 +----------------------------+
   vmalloc/ioremap
 +----------------------------+ PAGE_OFFSET + RAM_SIZE
   kernel direct-mapped ram
 +----------------------------+ PAGE_OFFSET (3GB) = MODULE_END = 0xc0000000
   module
 +----------------------------+ TASK_SIZE = MODULE_START = 0xbf000000
   user space
 +----------------------------+

This idea was borrowed from x86_64, and appears on the face of it to
be the perfect solution.  However, it can (and does) go horribly wrong.
After loading many modules, I end up with the following vm_struct vmlist:

=== vm list dump ===
area c1555e24 addr bf000000 size 00013000 flags 00000002
area c1555dac addr bf013000 size 00002000 flags 00000001
area c1555d84 addr bf015000 size 00002000 flags 00000001
area c1555d5c addr bf018000 size 00004000 flags 00000002
area c1555974 addr bf01c000 size 00002000 flags 00000002
area c15559ec addr bf01f000 size 00002000 flags 00000002
area c1555c44 addr bf021000 size 00003000 flags 00000002
area c1555dfc addr bf024000 size 00002000 flags 00000002
area c1555e74 addr bf027000 size 0000c000 flags 00000002
area c1307fdc addr bf033000 size 00003000 flags 00000002
area c155585c addr bf036000 size 00002000 flags 00000002
area c1555c94 addr bf038000 size 00002000 flags 00000002
area c15557e4 addr bf03a000 size 00002000 flags 00000002
area c155576c addr bf03c000 size 00002000 flags 00000002
area c1555514 addr bf03e000 size 00002000 flags 00000002
area c155549c addr bf040000 size 00002000 flags 00000001
area c1307f64 addr bf046000 size 00003000 flags 00000002
area c1555cbc addr bf06e000 size 00026000 flags 00000002
area c1555564 addr bf094000 size 01001000 flags 00000001

Pay special attention to the last entry - it starts at 0xbf094000, and
ends at 0xc0095000 - it overlaps the kernel direct mapped RAM.  What's
more is that the entries at 0xbf013000, 0xbf015000, 0xbf040000 and
0xbf094000 are for ioremapped memory, but are placed in the module
region.

This occurs due to the way get_vm_area() works:

	addr = VMALLOC_START;
...
        for (p = &vmlist; (tmp = *p) ;p = &tmp->next) {
                if ((size + addr) < addr)
                        goto out;
                if (size + addr <= (unsigned long)tmp->addr)	/* A */
                        goto found;
                addr = tmp->size + (unsigned long)tmp->addr;
                if (addr > VMALLOC_END - size)
                        goto out;
        }

Initially, addr is > PAGE_OFFSET.  If the first vmlist entry is 0xbf000000,
size 0x00013000, "A" is obviously false, and we calculate the new addr.
This ends up being 0xbf013000, which is _less than_ VMALLOC_START.  Let's
say, for the case of argument, that the size being requested is 0x02000000,
and VMALLOC_END is 0xe0000000.

addr + size = 0xc1013000, which overlaps the kernel direct mapped region.
It is still below VMALLOC_START, and it's less than VMALLOC_END.  We end
up allocating this region, and overwriting the kernel direct-mapped
page tables, in this case completely unmapping the kernel from virtual
memory space.

Oops.

The following should fix this, and needs to be applied to _all_ allocators
which touch the vmlist (I'd rather remove the duplication and have one
common allocation function, but that's a subject for separate discussion):

--- orig/mm/vmalloc.c	Tue Nov  5 12:51:41 2002
+++ linux/mm/vmalloc.c	Fri Jan 31 10:11:22 2003
@@ -212,6 +212,8 @@
 	for (p = &vmlist; (tmp = *p) ;p = &tmp->next) {
 		if ((size + addr) < addr)
 			goto out;
+		if (addr > (unsigned long)tmp->addr)
+			continue;
 		if (size + addr <= (unsigned long)tmp->addr)
 			goto found;
 		addr = tmp->size + (unsigned long)tmp->addr;


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


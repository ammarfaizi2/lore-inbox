Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269064AbRHLKoR>; Sun, 12 Aug 2001 06:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269067AbRHLKoI>; Sun, 12 Aug 2001 06:44:08 -0400
Received: from elin.scali.no ([195.139.250.10]:42500 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S269064AbRHLKoD>;
	Sun, 12 Aug 2001 06:44:03 -0400
Message-ID: <3B765F4D.17B4DB64@scali.no>
Date: Sun, 12 Aug 2001 12:49:49 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Write Combining (Write Coalescing) on memory mapped I/O on IA64.
In-Reply-To: <20010811090902.A1978@bytesex.org>
Content-Type: multipart/mixed;
 boundary="------------A8EF1264F1A4B7B91E5A9A57"
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A8EF1264F1A4B7B91E5A9A57
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I have a PCI adapter which does a lot of PIO (sort of network adapter using
host CPU to send data). On IA32 architechtures we could enable Write Combining
to get large burst on the PCI bus, but on IA64 I get at max 8 byte stores (ld8,
st8) at a time.

The driver for this adapter also exports the memory to user-space (with mmap())
and when doing this I do (inside the mmap function) :

int ssci_mmap(struct file *file, struct vm_area_struct *vma)
{
.....
#ifdef __ia64__      
   vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
#endif
   map_page_range(file, vma, vm_start,physaddr,
		      contlen, vma->vm_page_prot);

   remap_page_range(vma->vm_start,
		       phys_addr,
		       vma->vm_end - vma->vm_start,
		       vma->vm_page_prot))
....
}

This way we get Write Combining on IA64, but only for userspace mappings.
Kernel space clients use ioremap() and don't get Write Combining (ioremap on
IA64 use the uncacheable region directly).

To solve this I've tried to make my own __ia64_ioremap() (created
arch/ia64/mm/ioremap.c) wich has a 'flags' input paramenter so that I can set
the _PAGE_MA_WC attribute. I've taken a look on how other architechtures does
this (e.g i386 or s390), and made it nearly identical, but it doesn't seem to
work. The mapping gets set up, but if I try to read or write something to this
address I get a "Unable to handle kernel paging request at virtual address
0xa00000000015c000" which is the address I'm accessing.


I've attached the patch I made. Please let me know if this is doable on IA64 at
all. Feedback greatly appreciated.

Thanks,
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
--------------A8EF1264F1A4B7B91E5A9A57
Content-Type: text/plain; charset=us-ascii;
 name="ia64-ioremap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ia64-ioremap.patch"

--- linux-2.4.4/arch/ia64/mm/Makefile.~1~	Thu Jan  4 21:50:17 2001
+++ linux-2.4.4/arch/ia64/mm/Makefile	Sat Aug 11 21:20:03 2001
@@ -9,6 +9,6 @@
 
 O_TARGET := mm.o
 
-obj-y	 := init.o fault.o tlb.o extable.o
+obj-y	 := init.o fault.o ioremap.o tlb.o extable.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.4/arch/ia64/mm/ioremap.c.~1~	Tue May  5 22:32:27 1998
+++ linux-2.4.4/arch/ia64/mm/ioremap.c	Sat Aug 11 23:57:31 2001
@@ -0,0 +1,148 @@
+/*
+ *  arch/s390/mm/ioremap.c
+ *
+ *  IA64 version
+ *    Copyright (C) 2001 Scali AS
+ *    Author(s): Steffen Persvold (sp@scali.com)
+ *
+ *  Derived from "arch/i386/mm/ioremap.c"
+ *    (C) Copyright 1995 1996 Linus Torvalds
+ *
+ * Re-map IO memory to kernel address space so that we can access it.
+ */
+
+#include <linux/vmalloc.h>
+#include <asm/io.h>
+#include <asm/pgalloc.h>
+
+static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
+        unsigned long phys_addr, unsigned long flags)
+{
+        unsigned long end;
+
+        address &= ~PMD_MASK;
+        end = address + size;
+        if (end > PMD_SIZE)
+                end = PMD_SIZE;
+	if (address >= end)
+		BUG();
+        do {
+                if (!pte_none(*pte)) {
+                        printk("remap_area_pte: page already exists\n");
+			BUG();
+		}
+                set_pte(pte, mk_pte_phys(phys_addr, __pgprot(_PAGE_A | _PAGE_P | _PAGE_D |
+					_PAGE_AR_RW | _PAGE_PL_0 | flags)));
+                address += PAGE_SIZE;
+                phys_addr += PAGE_SIZE;
+                pte++;
+        } while (address && (address < end));
+}
+
+static inline int remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
+        unsigned long phys_addr, unsigned long flags)
+{
+	unsigned long end;
+
+	address &= ~PGDIR_MASK;
+	end = address + size;
+	if (end > PGDIR_SIZE)
+		end = PGDIR_SIZE;
+	phys_addr -= address;
+	if (address >= end)
+		BUG();
+	do {
+		pte_t * pte = pte_alloc(&init_mm, pmd, address);
+		if (!pte)
+			return -ENOMEM;
+		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
+		address = (address + PMD_SIZE) & PMD_MASK;
+		pmd++;
+	} while (address && (address < end));
+	return 0;
+}
+
+static int remap_area_pages(unsigned long address, unsigned long phys_addr,
+				 unsigned long size, unsigned long flags)
+{
+	int error;
+	pgd_t * dir;
+	unsigned long end = address + size;
+
+	phys_addr -= address;
+	dir = pgd_offset(&init_mm, address);
+	flush_cache_all();
+	if (address >= end)
+		BUG();
+	spin_lock(&init_mm.page_table_lock);
+	do {
+		pmd_t *pmd;
+		pmd = pmd_alloc(&init_mm, dir, address);
+		error = -ENOMEM;
+		if (!pmd)
+			break;
+		if (remap_area_pmd(pmd, address, end - address,
+					 phys_addr + address, flags))
+			break;
+		error = 0;
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		dir++;
+	} while (address && (address < end));
+	spin_unlock(&init_mm.page_table_lock);
+	flush_tlb_all();
+	return error;
+}
+
+/*
+ * Generic mapping function (not visible outside):
+ */
+
+/*
+ * Remap an arbitrary physical address space into the kernel virtual
+ * address space. Needed when the kernel wants to access high addresses
+ * directly.
+ *
+ * NOTE! We need to allow non-page-aligned mappings too: we will obviously
+ * have to convert them into an offset in a page-aligned mapping, but the
+ * caller shouldn't need to know that small detail.
+ */
+void * __ia64_ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
+{
+	void * addr;
+	struct vm_struct * area;
+	unsigned long offset, last_addr;
+
+	/* Don't allow wraparound or zero size */
+	last_addr = phys_addr + size - 1;
+	if (!size || last_addr < phys_addr)
+		return NULL;
+
+	/*
+	 * Mappings have to be page-aligned
+	 */
+	offset = phys_addr & ~PAGE_MASK;
+	phys_addr &= PAGE_MASK;
+	size = PAGE_ALIGN(last_addr) - phys_addr;
+
+	/*
+	 * Ok, go for it..
+	 */
+	area = get_vm_area(size, VM_IOREMAP);
+	if (!area)
+		return NULL;
+	addr = area->addr;
+
+	if (flags == 0)
+	   flags = _PAGE_MA_UC;
+		
+	if (remap_area_pages(VMALLOC_VMADDR(addr), phys_addr, size, flags)) {
+		vfree(addr);
+		return NULL;
+	}
+	return (void *) (offset + (char *)addr);
+}
+
+void __ia64_iounmap(void *addr)
+{
+	return vfree((void *) (PAGE_MASK & (unsigned long) addr));
+}
--- linux-2.4.4/arch/ia64/kernel/ia64_ksyms.c.~1~	Thu Apr  5 21:51:47 2001
+++ linux-2.4.4/arch/ia64/kernel/ia64_ksyms.c	Sat Aug 11 23:57:12 2001
@@ -39,6 +39,8 @@
 EXPORT_SYMBOL(ip_fast_csum);
 
 #include <asm/io.h>
+EXPORT_SYMBOL(__ia64_ioremap);
+EXPORT_SYMBOL(__ia64_iounmap);
 EXPORT_SYMBOL(__ia64_memcpy_fromio);
 EXPORT_SYMBOL(__ia64_memcpy_toio);
 EXPORT_SYMBOL(__ia64_memset_c_io);
--- linux-2.4.4/include/asm-ia64/io.h.~1~	Thu Apr  5 21:51:47 2001
+++ linux-2.4.4/include/asm-ia64/io.h	Sat Aug 11 23:59:36 2001
@@ -386,6 +386,9 @@
 
 #define ioremap_nocache(o,s)	ioremap(o,s)
 
+extern void * __ia64_ioremap(unsigned long offset, unsigned long size, unsigned long flags);
+extern void __ia64_iounmap(void *addr);
+
 # ifdef __KERNEL__
 
 /*

--------------A8EF1264F1A4B7B91E5A9A57--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVLCWSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVLCWSE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVLCWSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:18:04 -0500
Received: from cantor.suse.de ([195.135.220.2]:24994 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751298AbVLCWSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:18:03 -0500
Date: Sat, 3 Dec 2005 23:17:55 +0100
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Carlos Mart??n <carlos@cmartin.tk>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: Debug: sleeping function called in atomic context
Message-ID: <20051203221755.GC14247@wotan.suse.de>
References: <200512022132.36626.carlos@cmartin.tk> <200512031351.14458.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512031351.14458.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 01:51:14PM +0100, Arnd Bergmann wrote:
> It looks like the incorrect code has been in there for quite some time, but 
> that path was not taken for some reason.

Yes, or nobody tried it with preempt debugging. Anyways this patch
should fix it. Can the OP test?

----


i386/x86-64: Don't call change_page_attr with a spinlock hold.

It's illegal because it can sleep.

Use a two step lookup scheme instead. First look up the vm_struct,
then change the direct mapping, then finally unmap it. That's 
ok because nobody can change the particular virtual address range
as long as the vm_struct is still in the global list.

Also added some LinuxDoc documentation to iounmap.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/mm/ioremap.c
===================================================================
--- linux.orig/arch/i386/mm/ioremap.c
+++ linux/arch/i386/mm/ioremap.c
@@ -223,9 +223,15 @@ void __iomem *ioremap_nocache (unsigned 
 }
 EXPORT_SYMBOL(ioremap_nocache);
 
+/**
+ * iounmap - Free a IO remapping
+ * @addr: virtual address from ioremap_*
+ *
+ * Caller must ensure there is only one unmapping for the same pointer.
+ */
 void iounmap(volatile void __iomem *addr)
 {
-	struct vm_struct *p;
+	struct vm_struct *p, *o;
 
 	if ((void __force *)addr <= high_memory)
 		return;
@@ -239,22 +245,35 @@ void iounmap(volatile void __iomem *addr
 			addr < phys_to_virt(ISA_END_ADDRESS))
 		return;
 
-	write_lock(&vmlist_lock);
-	p = __remove_vm_area((void *)(PAGE_MASK & (unsigned long __force)addr));
-	if (!p) { 
-		printk(KERN_WARNING "iounmap: bad address %p\n", addr);
+	/* Use the vm area unlocked, assuming the caller
+	   ensures there isn't another iounmap for the same address
+	   in parallel. Reuse of the virtual address is prevented by
+	   leaving it in the global lists until we're done with it.
+	   cpa takes care of the direct mappings. */
+	read_lock(&vmlist_lock);
+	for (p = vmlist ; p ;p = p->next) {
+		if (p->addr == addr)
+			break;
+	}
+	read_unlock(&vmlist_lock);
+
+	if (!p) {
+		printk("iounmap: bad address %p\n", addr);
 		dump_stack();
-		goto out_unlock;
+		return;
 	}
 
+	/* Reset the direct mapping. Can block */
 	if ((p->flags >> 20) && p->phys_addr < virt_to_phys(high_memory) - 1) {
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
 				 PAGE_KERNEL);
 		global_flush_tlb();
 	} 
-out_unlock:
-	write_unlock(&vmlist_lock);
+
+	/* Finally remove it */
+	o = remove_vm_area((void *)((unsigned long)addr & PAGE_MASK));
+	BUG_ON(p != o || o == NULL);
 	kfree(p); 
 }
 EXPORT_SYMBOL(iounmap);
Index: linux/arch/x86_64/mm/ioremap.c
===================================================================
--- linux.orig/arch/x86_64/mm/ioremap.c
+++ linux/arch/x86_64/mm/ioremap.c
@@ -247,9 +247,15 @@ void __iomem *ioremap_nocache (unsigned 
 	return __ioremap(phys_addr, size, _PAGE_PCD);
 }
 
+/**
+ * iounmap - Free a IO remapping
+ * @addr: virtual address from ioremap_*
+ *
+ * Caller must ensure there is only one unmapping for the same pointer.
+ */
 void iounmap(volatile void __iomem *addr)
 {
-	struct vm_struct *p;
+	struct vm_struct *p, *o;
 
 	if (addr <= high_memory) 
 		return; 
@@ -257,12 +263,30 @@ void iounmap(volatile void __iomem *addr
 		addr < phys_to_virt(ISA_END_ADDRESS))
 		return;
 
-	write_lock(&vmlist_lock);
-	p = __remove_vm_area((void *)((unsigned long)addr & PAGE_MASK));
-	if (!p)
+	/* Use the vm area unlocked, assuming the caller
+	   ensures there isn't another iounmap for the same address
+	   in parallel. Reuse of the virtual address is prevented by
+	   leaving it in the global lists until we're done with it.
+	   cpa takes care of the direct mappings. */
+	read_lock(&vmlist_lock);
+	for (p = vmlist ; p ;p = p->next) {
+		if (p->addr == addr)
+			break;
+	}
+	read_unlock(&vmlist_lock);
+
+	if (!p) {
 		printk("iounmap: bad address %p\n", addr);
-	else if (p->flags >> 20)
+		dump_stack();
+		return;
+	}
+
+	/* Reset the direct mapping. Can block */
+	if (p->flags >> 20)
 		ioremap_change_attr(p->phys_addr, p->size, 0);
-	write_unlock(&vmlist_lock);
+
+	/* Finally remove it */
+	o = remove_vm_area((void *)((unsigned long)addr & PAGE_MASK));
+	BUG_ON(p != o || o == NULL);
 	kfree(p); 
 }

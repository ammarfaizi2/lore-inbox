Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVBYJxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVBYJxt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 04:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVBYJxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 04:53:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:30399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262661AbVBYJxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 04:53:30 -0500
Date: Fri, 25 Feb 2005 01:52:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, zwane@holomorphy.com
Subject: Re: 2.6.11-rc2-mm1 strange messages
Message-Id: <20050225015243.55e9eff8.akpm@osdl.org>
In-Reply-To: <20050225091516.GA5875@gamma.logic.tuwien.ac.at>
References: <20050125121704.GA22610@gamma.logic.tuwien.ac.at>
	<20050125102834.7e549322.akpm@osdl.org>
	<20050224141015.GA6756@gamma.logic.tuwien.ac.at>
	<20050224150326.3a82986c.akpm@osdl.org>
	<20050225012326.GA14302@gamma.logic.tuwien.ac.at>
	<20050224181412.64a1f351.akpm@osdl.org>
	<Pine.LNX.4.58.0502242210360.9237@ppc970.osdl.org>
	<20050224223308.778ef62e.akpm@osdl.org>
	<20050225091516.GA5875@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
>  On Don, 24 Feb 2005, Andrew Morton wrote:
>  > Norbert, does this make the warnings go away?
> 
>  Unfortunately no, still the very same error.

Doh.   This works.

--- 25/arch/i386/mm/ioremap.c~iounmap-isa-special-case	2005-02-25 01:38:51.000000000 -0800
+++ 25-akpm/arch/i386/mm/ioremap.c	2005-02-25 01:52:01.000000000 -0800
@@ -17,6 +17,9 @@
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
 
+#define ISA_START_ADDRESS	0xa0000
+#define ISA_END_ADDRESS		0x100000
+
 static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
 	unsigned long phys_addr, unsigned long flags)
 {
@@ -129,7 +132,7 @@ void __iomem * __ioremap(unsigned long p
 	/*
 	 * Don't remap the low PCI/ISA area, it's always mapped..
 	 */
-	if (phys_addr >= 0xA0000 && last_addr < 0x100000)
+	if (phys_addr >= ISA_START_ADDRESS && last_addr < ISA_END_ADDRESS)
 		return (void __iomem *) phys_to_virt(phys_addr);
 
 	/*
@@ -230,7 +233,17 @@ void iounmap(volatile void __iomem *addr
 {
 	struct vm_struct *p;
 	if ((void __force *) addr <= high_memory) 
-		return; 
+		return;
+
+	/*
+	 * __ioremap special-cases the PCI/ISA range by not instantiating a
+	 * vm_area and by simply returning an address into the kernel mapping
+	 * of ISA space.   So handle that here.
+	 */
+	if (addr >= phys_to_virt(ISA_START_ADDRESS) &&
+			addr < phys_to_virt(ISA_END_ADDRESS))
+		return;
+
 	p = remove_vm_area((void *) (PAGE_MASK & (unsigned long __force) addr));
 	if (!p) { 
 		printk("__iounmap: bad address %p\n", addr);
@@ -261,7 +274,7 @@ void __init *bt_ioremap(unsigned long ph
 	/*
 	 * Don't remap the low PCI/ISA area, it's always mapped..
 	 */
-	if (phys_addr >= 0xA0000 && last_addr < 0x100000)
+	if (phys_addr >= ISA_START_ADDRESS && last_addr < ISA_END_ADDRESS)
 		return phys_to_virt(phys_addr);
 
 	/*
_


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267924AbUHEX01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267924AbUHEX01 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267932AbUHEX01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:26:27 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41128 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S267924AbUHEX0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:26:20 -0400
Date: Thu, 5 Aug 2004 16:26:18 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Cleanup PPC44x mmu_mapin_ram()
Message-ID: <20040805162618.I14159@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some old cruft in the kernel lowmem mapping code and
save some memory in the process.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/mm/44x_mmu.c 1.3 vs edited =====
--- 1.3/arch/ppc/mm/44x_mmu.c	Fri Feb 13 08:24:55 2004
+++ edited/arch/ppc/mm/44x_mmu.c	Thu Aug  5 16:18:10 2004
@@ -93,10 +93,14 @@
 }
 
 /*
- * Configure PPC44x TLB for AS0 exception processing.
+ * MMU_init_hw does the chip-specific initialization of the MMU hardware.
  */
-static void __init
-ppc44x_tlb_config(void)
+void __init MMU_init_hw(void)
+{
+	flush_instruction_cache();
+}
+
+unsigned long __init mmu_mapin_ram(void)
 {
 	unsigned int pinned_tlbs = 1;
 	int i;
@@ -124,39 +128,6 @@
 			unsigned int phys_addr = (PPC44x_LOW_SLOT-i) * PPC44x_PIN_SIZE;
 			ppc44x_pin_tlb(i, phys_addr+PAGE_OFFSET, phys_addr);
 		}
-}
-
-/*
- * MMU_init_hw does the chip-specific initialization of the MMU hardware.
- */
-void __init MMU_init_hw(void)
-{
-	flush_instruction_cache();
-
-	ppc44x_tlb_config();
-}
-
-/* TODO: Add large page lowmem mapping support */
-unsigned long __init mmu_mapin_ram(void)
-{
-	unsigned long v, s, f = _PAGE_GUARDED;
-	phys_addr_t p;
-
-	v = KERNELBASE;
-	p = PPC_MEMSTART;
-
-	for (s = 0; s < total_lowmem; s += PAGE_SIZE) {
-		if ((char *) v >= _stext && (char *) v < etext)
-			f |= _PAGE_RAM_TEXT;
-		else
-			f |= _PAGE_RAM;
-		map_page(v, p, f);
-		v += PAGE_SIZE;
-		p += PAGE_SIZE;
-	}
-
-	if (ppc_md.progress)
-		ppc_md.progress("MMU:mmu_mapin_ram done", 0x401);
 
-	return s;
+	return total_lowmem;
 }

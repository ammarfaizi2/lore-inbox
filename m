Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSHJPZN>; Sat, 10 Aug 2002 11:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSHJPZM>; Sat, 10 Aug 2002 11:25:12 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:31502 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317025AbSHJPZJ>; Sat, 10 Aug 2002 11:25:09 -0400
Date: Sat, 10 Aug 2002 19:28:33 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.30] alpha: cia-1 fix [5/10]
Message-ID: <20020810192833.D20534@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Jay Estabrook:
CIA rev 1 can't use DAC and windows 1,2 for SG.

Ivan.

--- 2.5.30/arch/alpha/kernel/core_cia.c	Fri Aug  2 01:16:28 2002
+++ linux/arch/alpha/kernel/core_cia.c	Thu Aug  8 19:28:01 2002
@@ -370,7 +370,7 @@ cia_pci_tbi_try2(struct pci_controller *
 }
 
 static inline void
-cia_prepare_tbia_workaround(void)
+cia_prepare_tbia_workaround(int cia_rev, int is_pyxis)
 {
 	unsigned long *ppte, pte;
 	long i;
@@ -382,10 +382,20 @@ cia_prepare_tbia_workaround(void)
 	for (i = 0; i < CIA_BROKEN_TBIA_SIZE / sizeof(unsigned long); ++i)
 		ppte[i] = pte;
 
-	*(vip)CIA_IOC_PCI_W1_BASE = CIA_BROKEN_TBIA_BASE | 3;
-	*(vip)CIA_IOC_PCI_W1_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
-				    & 0xfff00000;
-	*(vip)CIA_IOC_PCI_T1_BASE = virt_to_phys(ppte) >> 2;
+	if (is_pyxis || cia_rev != 1) {
+		/* We can use W1 for SG on PYXIS/CIA rev 2. */
+		*(vip)CIA_IOC_PCI_W1_BASE = CIA_BROKEN_TBIA_BASE | 3;
+		*(vip)CIA_IOC_PCI_W1_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
+					    & 0xfff00000;
+		*(vip)CIA_IOC_PCI_T1_BASE = virt_to_phys(ppte) >> 2;
+	} else {
+		/* CIA rev 1 can't use W1 or W2 for SG, apparently,
+		   so use W3, which we made sure is not used for DAC. */
+		*(vip)CIA_IOC_PCI_W3_BASE = CIA_BROKEN_TBIA_BASE | 3;
+		*(vip)CIA_IOC_PCI_W3_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
+					    & 0xfff00000;
+		*(vip)CIA_IOC_PCI_T3_BASE = virt_to_phys(ppte) >> 2;
+	}
 }
 
 static void __init
@@ -684,10 +694,10 @@ do_init_arch(int is_pyxis)
 	/*
 	 * Set up the PCI to main memory translation windows.
 	 *
-	 * Window 0 is scatter-gather 8MB at 8MB (for isa)
-	 * Window 1 is scatter-gather 1MB at 768MB (for tbia)
+	 * Window 0 is S/G 8MB at 8MB (for isa)
+	 * Window 1 is S/G 1MB at 768MB (for tbia) (unused for CIA rev 1)
 	 * Window 2 is direct access 2GB at 2GB
-	 * Window 3 is DAC access 4GB at 8GB
+	 * Window 3 is DAC access 4GB at 8GB (or S/G for tbia if CIA rev 1)
 	 *
 	 * ??? NetBSD hints that page tables must be aligned to 32K,
 	 * possibly due to a hardware bug.  This is over-aligned
@@ -697,6 +707,7 @@ do_init_arch(int is_pyxis)
 
 	hose->sg_pci = NULL;
 	hose->sg_isa = iommu_arena_new(hose, 0x00800000, 0x00800000, 32768);
+
 	__direct_map_base = 0x80000000;
 	__direct_map_size = 0x80000000;
 
@@ -715,8 +726,14 @@ do_init_arch(int is_pyxis)
 	   are compared against W_DAC.  We can, however, directly map 4GB,
 	   which is better than before.  However, due to assumptions made
 	   elsewhere, we should not claim that we support DAC unless that
-	   4GB covers all of physical memory.  */
-	if (is_pyxis || max_low_pfn > (0x100000000 >> PAGE_SHIFT)) {
+	   4GB covers all of physical memory.
+
+	   Also, don't do DAC on CIA rev 1, it has other problems and is
+	   unlikely to have more than 2GB of memory anyway, so direct is
+	   fine.
+	*/
+	if (cia_rev == 1 || is_pyxis ||
+	    max_low_pfn > (0x100000000UL >> PAGE_SHIFT)) {
 		*(vip)CIA_IOC_PCI_W3_BASE = 0;
 	} else {
 		*(vip)CIA_IOC_PCI_W3_BASE = 0x00000000 | 1 | 8;
@@ -728,7 +745,7 @@ do_init_arch(int is_pyxis)
 	}
 
 	/* Prepare workaround for apparently broken tbia. */
-	cia_prepare_tbia_workaround();
+	cia_prepare_tbia_workaround(cia_rev, is_pyxis);
 }
 
 void __init

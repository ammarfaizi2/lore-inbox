Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268200AbTALCWe>; Sat, 11 Jan 2003 21:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268202AbTALCWe>; Sat, 11 Jan 2003 21:22:34 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:971 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S268200AbTALCWd>;
	Sat, 11 Jan 2003 21:22:33 -0500
Date: Sun, 12 Jan 2003 03:31:20 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301120231.DAA14711@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.5.55/.56 instant reboot problem on 486
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My '94 vintage 486 has problems booting 2.5.55 and 2.5.56.
When it fails, the boot gets to loading the kernel and
printing "Ok, booting the kernel.". Then there is a short
pause (line a tenth of a second) and the machine reboots.

After doing a binary search with "for(;;);" statements
(printk doesn't work this early) I found that the reboot
occurs in arch/i386/mm/init.c:kernel_physical_mapping_init():
(start_kernel() -> setup_arch() -> paging_init() ->
pagetable_init() -> kernel_physical_mapping_init())

diff -ruNp linux-2.5.55/arch/i386/mm/init.c linux-2.5.55.hack/arch/i386/mm/init.c
--- linux-2.5.55/arch/i386/mm/init.c	2003-01-12 02:20:49.000000000 +0100
+++ linux-2.5.55.hack/arch/i386/mm/init.c	2003-01-12 01:44:49.000000000 +0100
@@ -134,6 +134,7 @@ static void __init kernel_physical_mappi
 	pgd = pgd_base + pgd_ofs;
 	pfn = 0;
 
+	//for(;;);
 	for (; pgd_ofs < PTRS_PER_PGD; pgd++, pgd_ofs++) {
 		pmd = one_md_table_init(pgd);
 		if (pfn >= max_low_pfn)
@@ -151,6 +152,7 @@ static void __init kernel_physical_mappi
 			}
 		}
 	}	
+	for(;;);
 }
 
 static inline int page_kills_ppro(unsigned long pagenr)

If I uncomment the first "//for(;;);" the kernel hangs, but if
I keep it commented out, the kernel reboots -- i.e. it doesn't
get to the final "for(;;);" at the end of the function.

The problem is apparently related to the size of the kernel.
With gcc-2.95.3 and my normal config for this machine,
size vmlinux is

   text	   data	    bss	    dec	    hex	filename
1330953	 109008	 125656	1565617	 17e3b1	vmlinux

and the kernel reboots. If I alter the size by changing some
irrelevant config option (like disabling INPUT_MOUSEDEV or
enabling KALLSYMS), the reboot problem doesn't occur.

With gcc-3.2 the bug disappears, but only because gcc-3.2
generates a much larger code segment. If I remove some
driver & fs config options, the vmlinux size becomes almost
the same as above, and the reboot bug appears again.

The same kernel that fails on the 486 boots Ok on my newer
test boxes, so the problem is either 486-specific, related
to the actual memory size, or the BIOS memory size reporting
method (the 486 uses int 15 0x88); here's what 2.5.54 says:

BIOS-provided physical RAM map:
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 0000000001c00000 (usable)

The 486 has no known HW problems, and it survives memtest86.

/Mikael

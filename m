Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268198AbTB1VfP>; Fri, 28 Feb 2003 16:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268191AbTB1VeP>; Fri, 28 Feb 2003 16:34:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:23295 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268201AbTB1VdZ>; Fri, 28 Feb 2003 16:33:25 -0500
Date: Fri, 28 Feb 2003 13:33:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Bill Irwin <wli@holomorphy.com>
Subject: [PATCH] 3/7 Move pfn_to_nid inline
Message-ID: <361330000.1046468037@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from William Lee Irwin

Inline and simplify pfn_to_nid - this is called heavily, it's a tiny
function, and makes a noticable difference in system time for kernel 
compiles (sorry, lost the data). Is only used on NUMA machines.

Has been tested in my tree for over a month on UP, SMP, and NUMA and 
compile tested against a variety of different configs.

diff -urpN -X /home/fletch/.diff.exclude 011-mpc_apic_id/arch/i386/kernel/i386_ksyms.c 012-pfn_to_nid/arch/i386/kernel/i386_ksyms.c
--- 011-mpc_apic_id/arch/i386/kernel/i386_ksyms.c	Tue Feb 25 23:03:43 2003
+++ 012-pfn_to_nid/arch/i386/kernel/i386_ksyms.c	Fri Feb 28 08:05:34 2003
@@ -68,7 +68,6 @@ EXPORT_SYMBOL(EISA_bus);
 EXPORT_SYMBOL(MCA_bus);
 #ifdef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(node_data);
-EXPORT_SYMBOL(pfn_to_nid);
 #endif
 #ifdef CONFIG_X86_NUMAQ
 EXPORT_SYMBOL(xquad_portio);
diff -urpN -X /home/fletch/.diff.exclude 011-mpc_apic_id/arch/i386/kernel/numaq.c 012-pfn_to_nid/arch/i386/kernel/numaq.c
--- 011-mpc_apic_id/arch/i386/kernel/numaq.c	Sun Nov 17 20:29:51 2002
+++ 012-pfn_to_nid/arch/i386/kernel/numaq.c	Fri Feb 28 08:05:34 2003
@@ -27,6 +27,7 @@
 #include <linux/mm.h>
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
+#include <linux/module.h>
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
@@ -82,19 +83,7 @@ static void __init smp_dump_qct(void)
  * physnode_map[8- ] = -1;
  */
 int physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
-
-#define PFN_TO_ELEMENT(pfn) (pfn / PAGES_PER_ELEMENT)
-#define PA_TO_ELEMENT(pa) (PFN_TO_ELEMENT(pa >> PAGE_SHIFT))
-
-int pfn_to_nid(unsigned long pfn)
-{
-	int nid = physnode_map[PFN_TO_ELEMENT(pfn)];
-
-	if (nid == -1)
-		BUG(); /* address is not present */
-
-	return nid;
-}
+EXPORT_SYMBOL(physnode_map);
 
 /*
  * for each node mark the regions
diff -urpN -X /home/fletch/.diff.exclude 011-mpc_apic_id/include/asm-i386/numaq.h 012-pfn_to_nid/include/asm-i386/numaq.h
--- 011-mpc_apic_id/include/asm-i386/numaq.h	Thu Jan  9 19:16:11 2003
+++ 012-pfn_to_nid/include/asm-i386/numaq.h	Fri Feb 28 08:05:34 2003
@@ -36,10 +36,11 @@
 #define MAX_ELEMENTS 256
 #define PAGES_PER_ELEMENT (16777216/256)
 
+extern int physnode_map[];
+#define pfn_to_nid(pfn)	({ physnode_map[(pfn) / PAGES_PER_ELEMENT]; })
 #define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
 #define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
 #define MAX_NUMNODES		8
-extern int pfn_to_nid(unsigned long);
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
 


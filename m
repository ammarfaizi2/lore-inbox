Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSLQRnc>; Tue, 17 Dec 2002 12:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSLQRnW>; Tue, 17 Dec 2002 12:43:22 -0500
Received: from holomorphy.com ([66.224.33.161]:41144 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265246AbSLQRmb>;
	Tue, 17 Dec 2002 12:42:31 -0500
Date: Tue, 17 Dec 2002 09:49:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, gh@us.ibm.com
Subject: Re: 2.5.52-mjb1 (scalability / NUMA patchset)
Message-ID: <20021217174958.GY2690@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, gh@us.ibm.com
References: <19270000.1038270642@flay> <134580000.1039414279@titus> <32230000.1039502522@titus> <568990000.1040112629@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568990000.1040112629@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 12:10:29AM -0800, Martin J. Bligh wrote:
> The patchset contains mainly scalability and NUMA stuff, and
> anything else that stops things from irritating me. It's meant
> to be pretty stable, not so much a testing ground for new stuff.
> I'd be very interested in feedback from other people running
> large SMP or NUMA boxes.
> http://www.aracnet.com/~fletch/linux/2.5.52/patch-2.5.52-mjb1.bz2


pfn_to_nid() got lots of icache misses. Try using a macro.

 arch/i386/kernel/i386_ksyms.c |    1 -
 arch/i386/kernel/numaq.c      |   15 ++-------------
 include/asm-i386/numaq.h      |    3 ++-
 3 files changed, 4 insertions(+), 15 deletions(-)


diff -urpN linux-2.5.52-mm1/arch/i386/kernel/i386_ksyms.c mm1-2.5.52-1/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.52-mm1/arch/i386/kernel/i386_ksyms.c	2002-12-16 19:29:45.000000000 -0800
+++ mm1-2.5.52-1/arch/i386/kernel/i386_ksyms.c	2002-12-17 08:47:25.000000000 -0800
@@ -67,7 +67,6 @@ EXPORT_SYMBOL(EISA_bus);
 EXPORT_SYMBOL(MCA_bus);
 #ifdef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(node_data);
-EXPORT_SYMBOL(pfn_to_nid);
 #endif
 #ifdef CONFIG_X86_NUMAQ
 EXPORT_SYMBOL(xquad_portio);
diff -urpN linux-2.5.52-mm1/arch/i386/kernel/numaq.c mm1-2.5.52-1/arch/i386/kernel/numaq.c
--- linux-2.5.52-mm1/arch/i386/kernel/numaq.c	2002-12-15 18:08:13.000000000 -0800
+++ mm1-2.5.52-1/arch/i386/kernel/numaq.c	2002-12-17 08:51:44.000000000 -0800
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
diff -urpN linux-2.5.52-mm1/include/asm-i386/numaq.h mm1-2.5.52-1/include/asm-i386/numaq.h
--- linux-2.5.52-mm1/include/asm-i386/numaq.h	2002-12-15 18:08:09.000000000 -0800
+++ mm1-2.5.52-1/include/asm-i386/numaq.h	2002-12-17 08:45:19.000000000 -0800
@@ -38,10 +38,11 @@
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
 

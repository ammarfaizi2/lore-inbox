Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVADEpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVADEpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 23:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVADEpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:45:13 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:21704 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262025AbVADEns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:43:48 -0500
Date: Tue, 4 Jan 2005 15:04:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/11] PPC64: Consolidate cache sizing variables
Message-Id: <20050104150410.199b132e.sfr@canb.auug.org.au>
In-Reply-To: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_04_10_+1100_3T1Yj4u2biqJvpCT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_04_10_+1100_3T1Yj4u2biqJvpCT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch consolidates the variables that define the PPC64 cache sizes
into a single structure (the were in the naca and the systemcfg
structures).  Those that were in the systemcfg structure are left there
just because they are exported to user mode through /proc.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk/arch/ppc64/kernel/asm-offsets.c linus-bk-naca.1/arch/ppc64/kernel/asm-offsets.c
--- linus-bk/arch/ppc64/kernel/asm-offsets.c	2004-11-26 12:08:51.000000000 +1100
+++ linus-bk-naca.1/arch/ppc64/kernel/asm-offsets.c	2004-12-31 14:52:14.000000000 +1100
@@ -35,6 +35,7 @@
 #include <asm/iSeries/HvLpEvent.h>
 #include <asm/rtas.h>
 #include <asm/cputable.h>
+#include <asm/cache.h>
 
 #define DEFINE(sym, val) \
 	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -69,12 +70,12 @@
 
 	/* naca */
         DEFINE(PACA, offsetof(struct naca_struct, paca));
-	DEFINE(DCACHEL1LINESIZE, offsetof(struct systemcfg, dCacheL1LineSize));
-        DEFINE(DCACHEL1LOGLINESIZE, offsetof(struct naca_struct, dCacheL1LogLineSize));
-        DEFINE(DCACHEL1LINESPERPAGE, offsetof(struct naca_struct, dCacheL1LinesPerPage));
-        DEFINE(ICACHEL1LINESIZE, offsetof(struct systemcfg, iCacheL1LineSize));
-        DEFINE(ICACHEL1LOGLINESIZE, offsetof(struct naca_struct, iCacheL1LogLineSize));
-        DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct naca_struct, iCacheL1LinesPerPage));
+	DEFINE(DCACHEL1LINESIZE, offsetof(struct ppc64_caches, dline_size));
+	DEFINE(DCACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_dline_size));
+	DEFINE(DCACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, dlines_per_page));
+	DEFINE(ICACHEL1LINESIZE, offsetof(struct ppc64_caches, iline_size));
+	DEFINE(ICACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_iline_size));
+	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
 	DEFINE(PLATFORM, offsetof(struct systemcfg, platform));
 
 	/* paca */
diff -ruN linus-bk/arch/ppc64/kernel/eeh.c linus-bk-naca.1/arch/ppc64/kernel/eeh.c
--- linus-bk/arch/ppc64/kernel/eeh.c	2004-10-26 16:06:41.000000000 +1000
+++ linus-bk-naca.1/arch/ppc64/kernel/eeh.c	2004-12-31 14:52:14.000000000 +1100
@@ -32,6 +32,7 @@
 #include <asm/machdep.h>
 #include <asm/rtas.h>
 #include <asm/atomic.h>
+#include <asm/systemcfg.h>
 #include "pci.h"
 
 #undef DEBUG
diff -ruN linus-bk/arch/ppc64/kernel/iSeries_setup.c linus-bk-naca.1/arch/ppc64/kernel/iSeries_setup.c
--- linus-bk/arch/ppc64/kernel/iSeries_setup.c	2004-11-12 09:09:48.000000000 +1100
+++ linus-bk-naca.1/arch/ppc64/kernel/iSeries_setup.c	2004-12-31 14:52:14.000000000 +1100
@@ -44,6 +44,7 @@
 #include "iSeries_setup.h"
 #include <asm/naca.h>
 #include <asm/paca.h>
+#include <asm/cache.h>
 #include <asm/sections.h>
 #include <asm/iSeries/LparData.h>
 #include <asm/iSeries/HvCallHpt.h>
@@ -560,33 +561,36 @@
 	unsigned int i, n;
 	unsigned int procIx = get_paca()->lppaca.xDynHvPhysicalProcIndex;
 
-	systemcfg->iCacheL1Size =
-		xIoHriProcessorVpd[procIx].xInstCacheSize * 1024;
-	systemcfg->iCacheL1LineSize =
+	systemcfg->icache_size =
+	ppc64_caches.isize = xIoHriProcessorVpd[procIx].xInstCacheSize * 1024;
+	systemcfg->icache_line_size =
+	ppc64_caches.iline_size =
 		xIoHriProcessorVpd[procIx].xInstCacheOperandSize;
-	systemcfg->dCacheL1Size =
+	systemcfg->dcache_size =
+	ppc64_caches.dsize =
 		xIoHriProcessorVpd[procIx].xDataL1CacheSizeKB * 1024;
-	systemcfg->dCacheL1LineSize =
+	systemcfg->dcache_line_size =
+	ppc64_caches.dline_size =
 		xIoHriProcessorVpd[procIx].xDataCacheOperandSize;
-	naca->iCacheL1LinesPerPage = PAGE_SIZE / systemcfg->iCacheL1LineSize;
-	naca->dCacheL1LinesPerPage = PAGE_SIZE / systemcfg->dCacheL1LineSize;
+	ppc64_caches.ilines_per_page = PAGE_SIZE / ppc64_caches.iline_size;
+	ppc64_caches.dlines_per_page = PAGE_SIZE / ppc64_caches.dline_size;
 
-	i = systemcfg->iCacheL1LineSize;
+	i = ppc64_caches.iline_size;
 	n = 0;
 	while ((i = (i / 2)))
 		++n;
-	naca->iCacheL1LogLineSize = n;
+	ppc64_caches.log_iline_size = n;
 
-	i = systemcfg->dCacheL1LineSize;
+	i = ppc64_caches.dline_size;
 	n = 0;
 	while ((i = (i / 2)))
 		++n;
-	naca->dCacheL1LogLineSize = n;
+	ppc64_caches.log_dline_size = n;
 
 	printk("D-cache line size = %d\n",
-			(unsigned int)systemcfg->dCacheL1LineSize);
+			(unsigned int)ppc64_caches.dline_size);
 	printk("I-cache line size = %d\n",
-			(unsigned int)systemcfg->iCacheL1LineSize);
+			(unsigned int)ppc64_caches.iline_size);
 }
 
 /*
diff -ruN linus-bk/arch/ppc64/kernel/idle.c linus-bk-naca.1/arch/ppc64/kernel/idle.c
--- linus-bk/arch/ppc64/kernel/idle.c	2004-10-27 07:32:57.000000000 +1000
+++ linus-bk-naca.1/arch/ppc64/kernel/idle.c	2004-12-31 14:52:14.000000000 +1100
@@ -32,6 +32,7 @@
 #include <asm/iSeries/HvCall.h>
 #include <asm/iSeries/ItLpQueue.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/systemcfg.h>
 
 extern void power4_idle(void);
 
diff -ruN linus-bk/arch/ppc64/kernel/misc.S linus-bk-naca.1/arch/ppc64/kernel/misc.S
--- linus-bk/arch/ppc64/kernel/misc.S	2004-11-12 09:09:48.000000000 +1100
+++ linus-bk-naca.1/arch/ppc64/kernel/misc.S	2004-12-31 14:52:14.000000000 +1100
@@ -189,6 +189,11 @@
 	isync
 	blr
 
+	.section	".toc","aw"
+PPC64_CACHES:
+	.tc		ppc64_caches[TC],ppc64_caches
+	.section	".text"
+
 /*
  * Write any modified data cache blocks out to memory
  * and invalidate the corresponding instruction cache blocks.
@@ -207,11 +212,8 @@
  * and in some cases i-cache and d-cache line sizes differ from
  * each other.
  */
-	LOADADDR(r10,naca)		/* Get Naca address */
-	ld	r10,0(r10)
-	LOADADDR(r11,systemcfg)		/* Get systemcfg address */
-	ld	r11,0(r11)
-	lwz	r7,DCACHEL1LINESIZE(r11)/* Get cache line size */
+ 	ld	r10,PPC64_CACHES@toc(r2)
+	lwz	r7,DCACHEL1LINESIZE(r10)/* Get cache line size */
 	addi	r5,r7,-1
 	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
@@ -227,7 +229,7 @@
 
 /* Now invalidate the instruction cache */
 	
-	lwz	r7,ICACHEL1LINESIZE(r11)	/* Get Icache line size */
+	lwz	r7,ICACHEL1LINESIZE(r10)	/* Get Icache line size */
 	addi	r5,r7,-1
 	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
@@ -256,11 +258,8 @@
  * 
  * Different systems have different cache line sizes
  */
-	LOADADDR(r10,naca)		/* Get Naca address */
-	ld	r10,0(r10)
-	LOADADDR(r11,systemcfg)		/* Get systemcfg address */
-	ld	r11,0(r11)
-	lwz	r7,DCACHEL1LINESIZE(r11)	/* Get dcache line size */
+ 	ld	r10,PPC64_CACHES@toc(r2)
+	lwz	r7,DCACHEL1LINESIZE(r10)	/* Get dcache line size */
 	addi	r5,r7,-1
 	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
@@ -286,11 +285,8 @@
  *    flush all bytes from start to stop-1 inclusive
  */
 _GLOBAL(flush_dcache_phys_range)
-	LOADADDR(r10,naca)		/* Get Naca address */
-	ld	r10,0(r10)
-	LOADADDR(r11,systemcfg)		/* Get systemcfg address */
-	ld	r11,0(r11)
-	lwz	r7,DCACHEL1LINESIZE(r11)	/* Get dcache line size */
+ 	ld	r10,PPC64_CACHES@toc(r2)
+	lwz	r7,DCACHEL1LINESIZE(r10)	/* Get dcache line size */
 	addi	r5,r7,-1
 	andc	r6,r3,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
@@ -332,13 +328,10 @@
  */
 
 /* Flush the dcache */
-	LOADADDR(r7,naca)
-	ld	r7,0(r7)
-	LOADADDR(r8,systemcfg)			/* Get systemcfg address */
-	ld	r8,0(r8)
+ 	ld	r7,PPC64_CACHES@toc(r2)
 	clrrdi	r3,r3,12           	    /* Page align */
 	lwz	r4,DCACHEL1LINESPERPAGE(r7)	/* Get # dcache lines per page */
-	lwz	r5,DCACHEL1LINESIZE(r8)		/* Get dcache line size */
+	lwz	r5,DCACHEL1LINESIZE(r7)		/* Get dcache line size */
 	mr	r6,r3
 	mtctr	r4
 0:	dcbst	0,r6
@@ -349,7 +342,7 @@
 /* Now invalidate the icache */	
 
 	lwz	r4,ICACHEL1LINESPERPAGE(r7)	/* Get # icache lines per page */
-	lwz	r5,ICACHEL1LINESIZE(r8)		/* Get icache line size */
+	lwz	r5,ICACHEL1LINESIZE(r7)		/* Get icache line size */
 	mtctr	r4
 1:	icbi	0,r3
 	add	r3,r3,r5
diff -ruN linus-bk/arch/ppc64/kernel/nvram.c linus-bk-naca.1/arch/ppc64/kernel/nvram.c
--- linus-bk/arch/ppc64/kernel/nvram.c	2004-11-16 16:05:10.000000000 +1100
+++ linus-bk-naca.1/arch/ppc64/kernel/nvram.c	2004-12-31 14:52:14.000000000 +1100
@@ -31,6 +31,7 @@
 #include <asm/rtas.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
+#include <asm/systemcfg.h>
 
 #undef DEBUG_NVRAM
 
diff -ruN linus-bk/arch/ppc64/kernel/pSeries_iommu.c linus-bk-naca.1/arch/ppc64/kernel/pSeries_iommu.c
--- linus-bk/arch/ppc64/kernel/pSeries_iommu.c	2004-11-26 12:08:51.000000000 +1100
+++ linus-bk-naca.1/arch/ppc64/kernel/pSeries_iommu.c	2004-12-31 14:52:14.000000000 +1100
@@ -43,6 +43,7 @@
 #include <asm/machdep.h>
 #include <asm/abs_addr.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/systemcfg.h>
 #include "pci.h"
 
 
diff -ruN linus-bk/arch/ppc64/kernel/pacaData.c linus-bk-naca.1/arch/ppc64/kernel/pacaData.c
--- linus-bk/arch/ppc64/kernel/pacaData.c	2004-11-26 12:08:51.000000000 +1100
+++ linus-bk-naca.1/arch/ppc64/kernel/pacaData.c	2004-12-31 14:52:14.000000000 +1100
@@ -10,6 +10,8 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/threads.h>
+#include <linux/module.h>
+
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/page.h>
@@ -20,7 +22,9 @@
 #include <asm/paca.h>
 
 struct naca_struct *naca;
+EXPORT_SYMBOL(naca);
 struct systemcfg *systemcfg;
+EXPORT_SYMBOL(systemcfg);
 
 /* This symbol is provided by the linker - let it fill in the paca
  * field correctly */
diff -ruN linus-bk/arch/ppc64/kernel/pmac_setup.c linus-bk-naca.1/arch/ppc64/kernel/pmac_setup.c
--- linus-bk/arch/ppc64/kernel/pmac_setup.c	2004-10-25 18:18:33.000000000 +1000
+++ linus-bk-naca.1/arch/ppc64/kernel/pmac_setup.c	2004-12-31 14:52:14.000000000 +1100
@@ -70,6 +70,7 @@
 #include <asm/time.h>
 #include <asm/of_device.h>
 #include <asm/lmb.h>
+#include <asm/naca.h>
 
 #include "pmac.h"
 #include "mpic.h"
diff -ruN linus-bk/arch/ppc64/kernel/ppc_ksyms.c linus-bk-naca.1/arch/ppc64/kernel/ppc_ksyms.c
--- linus-bk/arch/ppc64/kernel/ppc_ksyms.c	2004-10-21 07:17:18.000000000 +1000
+++ linus-bk-naca.1/arch/ppc64/kernel/ppc_ksyms.c	2004-12-31 14:52:14.000000000 +1100
@@ -67,7 +67,6 @@
 
 EXPORT_SYMBOL(__down_interruptible);
 EXPORT_SYMBOL(__up);
-EXPORT_SYMBOL(naca);
 EXPORT_SYMBOL(__down);
 #ifdef CONFIG_PPC_ISERIES
 EXPORT_SYMBOL(itLpNaca);
@@ -162,4 +161,3 @@
 EXPORT_SYMBOL(tb_ticks_per_usec);
 EXPORT_SYMBOL(paca);
 EXPORT_SYMBOL(cur_cpu_spec);
-EXPORT_SYMBOL(systemcfg);
diff -ruN linus-bk/arch/ppc64/kernel/rtas-proc.c linus-bk-naca.1/arch/ppc64/kernel/rtas-proc.c
--- linus-bk/arch/ppc64/kernel/rtas-proc.c	2004-10-21 07:17:18.000000000 +1000
+++ linus-bk-naca.1/arch/ppc64/kernel/rtas-proc.c	2004-12-31 14:52:14.000000000 +1100
@@ -31,6 +31,7 @@
 #include <asm/rtas.h>
 #include <asm/machdep.h> /* for ppc_md */
 #include <asm/time.h>
+#include <asm/systemcfg.h>
 
 /* Token for Sensors */
 #define KEY_SWITCH		0x0001
diff -ruN linus-bk/arch/ppc64/kernel/rtas.c linus-bk-naca.1/arch/ppc64/kernel/rtas.c
--- linus-bk/arch/ppc64/kernel/rtas.c	2004-11-26 12:08:51.000000000 +1100
+++ linus-bk-naca.1/arch/ppc64/kernel/rtas.c	2004-12-31 14:52:14.000000000 +1100
@@ -29,6 +29,7 @@
 #include <asm/udbg.h>
 #include <asm/delay.h>
 #include <asm/uaccess.h>
+#include <asm/systemcfg.h>
 
 struct flash_block_list_header rtas_firmware_flash_list = {0, NULL};
 
diff -ruN linus-bk/arch/ppc64/kernel/rtasd.c linus-bk-naca.1/arch/ppc64/kernel/rtasd.c
--- linus-bk/arch/ppc64/kernel/rtasd.c	2004-11-16 16:05:10.000000000 +1100
+++ linus-bk-naca.1/arch/ppc64/kernel/rtasd.c	2004-12-31 14:52:14.000000000 +1100
@@ -26,6 +26,7 @@
 #include <asm/prom.h>
 #include <asm/nvram.h>
 #include <asm/atomic.h>
+#include <asm/systemcfg.h>
 
 #if 0
 #define DEBUG(A...)	printk(KERN_ERR A)
diff -ruN linus-bk/arch/ppc64/kernel/setup.c linus-bk-naca.1/arch/ppc64/kernel/setup.c
--- linus-bk/arch/ppc64/kernel/setup.c	2004-12-14 04:07:06.000000000 +1100
+++ linus-bk-naca.1/arch/ppc64/kernel/setup.c	2004-12-31 16:22:00.000000000 +1100
@@ -54,6 +54,7 @@
 #include <asm/rtas.h>
 #include <asm/iommu.h>
 #include <asm/serial.h>
+#include <asm/cache.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -111,6 +112,8 @@
 int boot_cpuid_phys = 0;
 dev_t boot_dev;
 
+struct ppc64_caches ppc64_caches;
+
 /*
  * These are used in binfmt_elf.c to put aux entries on the stack
  * for each elf executable being started.
@@ -489,15 +492,15 @@
 			lsizep = (u32 *) get_property(np, dc, NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
-
 			if (sizep == 0 || lsizep == 0)
 				DBG("Argh, can't find dcache properties ! "
 				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
 
-			systemcfg->dCacheL1Size = size;
-			systemcfg->dCacheL1LineSize = lsize;
-			naca->dCacheL1LogLineSize = __ilog2(lsize);
-			naca->dCacheL1LinesPerPage = PAGE_SIZE/(lsize);
+			systemcfg->dcache_size = ppc64_caches.dsize = size;
+			systemcfg->dcache_line_size =
+				ppc64_caches.dline_size = lsize;
+			ppc64_caches.log_dline_size = __ilog2(lsize);
+			ppc64_caches.dlines_per_page = PAGE_SIZE / lsize;
 
 			size = 0;
 			lsize = cur_cpu_spec->icache_bsize;
@@ -511,11 +514,11 @@
 				DBG("Argh, can't find icache properties ! "
 				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
 
-			systemcfg->iCacheL1Size = size;
-			systemcfg->iCacheL1LineSize = lsize;
-			naca->iCacheL1LogLineSize = __ilog2(lsize);
-			naca->iCacheL1LinesPerPage = PAGE_SIZE/(lsize);
-
+			systemcfg->icache_size = ppc64_caches.isize = size;
+			systemcfg->icache_line_size =
+				ppc64_caches.iline_size = lsize;
+			ppc64_caches.log_iline_size = __ilog2(lsize);
+			ppc64_caches.ilines_per_page = PAGE_SIZE / lsize;
 		}
 	}
 
@@ -664,8 +667,10 @@
 	printk("systemcfg->platform           = 0x%x\n", systemcfg->platform);
 	printk("systemcfg->processorCount     = 0x%lx\n", systemcfg->processorCount);
 	printk("systemcfg->physicalMemorySize = 0x%lx\n", systemcfg->physicalMemorySize);
-	printk("systemcfg->dCacheL1LineSize   = 0x%x\n", systemcfg->dCacheL1LineSize);
-	printk("systemcfg->iCacheL1LineSize   = 0x%x\n", systemcfg->iCacheL1LineSize);
+	printk("ppc64_caches.dcache_line_size = 0x%x\n",
+			ppc64_caches.dline_size);
+	printk("ppc64_caches.icache_line_size = 0x%x\n",
+			ppc64_caches.iline_size);
 	printk("htab_data.htab                = 0x%p\n", htab_data.htab);
 	printk("htab_data.num_ptegs           = 0x%lx\n", htab_data.htab_num_ptegs);
 	printk("-----------------------------------------------------\n");
@@ -1000,8 +1005,8 @@
 	 * Systems with OF can look in the properties on the cpu node(s)
 	 * for a possibly more accurate value.
 	 */
-	dcache_bsize = systemcfg->dCacheL1LineSize; 
-	icache_bsize = systemcfg->iCacheL1LineSize; 
+	dcache_bsize = ppc64_caches.dline_size;
+	icache_bsize = ppc64_caches.iline_size;
 
 	/* reboot on panic */
 	panic_timeout = 180;
diff -ruN linus-bk/arch/ppc64/kernel/sys_ppc32.c linus-bk-naca.1/arch/ppc64/kernel/sys_ppc32.c
--- linus-bk/arch/ppc64/kernel/sys_ppc32.c	2004-10-28 16:57:54.000000000 +1000
+++ linus-bk-naca.1/arch/ppc64/kernel/sys_ppc32.c	2004-12-31 14:52:14.000000000 +1100
@@ -73,6 +73,7 @@
 #include <asm/ppcdebug.h>
 #include <asm/time.h>
 #include <asm/mmu_context.h>
+#include <asm/systemcfg.h>
 
 #include "pci.h"
 
diff -ruN linus-bk/arch/ppc64/kernel/sysfs.c linus-bk-naca.1/arch/ppc64/kernel/sysfs.c
--- linus-bk/arch/ppc64/kernel/sysfs.c	2004-11-16 16:05:10.000000000 +1100
+++ linus-bk-naca.1/arch/ppc64/kernel/sysfs.c	2004-12-31 14:52:14.000000000 +1100
@@ -13,6 +13,7 @@
 #include <asm/cputable.h>
 #include <asm/hvcall.h>
 #include <asm/prom.h>
+#include <asm/systemcfg.h>
 
 
 /* SMT stuff */
diff -ruN linus-bk/arch/ppc64/kernel/time.c linus-bk-naca.1/arch/ppc64/kernel/time.c
--- linus-bk/arch/ppc64/kernel/time.c	2004-10-21 07:17:18.000000000 +1000
+++ linus-bk-naca.1/arch/ppc64/kernel/time.c	2004-12-31 14:52:14.000000000 +1100
@@ -66,6 +66,7 @@
 #include <asm/ppcdebug.h>
 #include <asm/prom.h>
 #include <asm/sections.h>
+#include <asm/systemcfg.h>
 
 void smp_local_timer_interrupt(struct pt_regs *);
 
diff -ruN linus-bk/arch/ppc64/kernel/traps.c linus-bk-naca.1/arch/ppc64/kernel/traps.c
--- linus-bk/arch/ppc64/kernel/traps.c	2004-09-09 09:59:49.000000000 +1000
+++ linus-bk-naca.1/arch/ppc64/kernel/traps.c	2004-12-31 14:52:14.000000000 +1100
@@ -37,6 +37,7 @@
 #include <asm/processor.h>
 #include <asm/ppcdebug.h>
 #include <asm/rtas.h>
+#include <asm/systemcfg.h>
 
 #ifdef CONFIG_PPC_PSERIES
 /* This is true if we are using the firmware NMI handler (typically LPAR) */
diff -ruN linus-bk/include/asm-ppc64/cache.h linus-bk-naca.1/include/asm-ppc64/cache.h
--- linus-bk/include/asm-ppc64/cache.h	2002-08-28 06:04:10.000000000 +1000
+++ linus-bk-naca.1/include/asm-ppc64/cache.h	2004-12-31 14:52:14.000000000 +1100
@@ -7,6 +7,8 @@
 #ifndef __ARCH_PPC64_CACHE_H
 #define __ARCH_PPC64_CACHE_H
 
+#include <asm/types.h>
+
 /* bytes per L1 cache line */
 #define L1_CACHE_SHIFT	7
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
@@ -14,4 +16,21 @@
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
 #define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
 
+#ifndef __ASSEMBLY__
+
+struct ppc64_caches {
+	u32	dsize;			/* L1 d-cache size */
+	u32	dline_size;		/* L1 d-cache line size	*/
+	u32	log_dline_size;
+	u32	dlines_per_page;
+	u32	isize;			/* L1 i-cache size */
+	u32	iline_size;		/* L1 i-cache line size	*/
+	u32	log_iline_size;
+	u32	ilines_per_page;
+};
+
+extern struct ppc64_caches ppc64_caches;
+
+#endif
+
 #endif
diff -ruN linus-bk/include/asm-ppc64/naca.h linus-bk-naca.1/include/asm-ppc64/naca.h
--- linus-bk/include/asm-ppc64/naca.h	2004-09-16 21:51:58.000000000 +1000
+++ linus-bk-naca.1/include/asm-ppc64/naca.h	2004-12-31 14:52:14.000000000 +1100
@@ -16,11 +16,7 @@
 #ifndef __ASSEMBLY__
 
 struct naca_struct {
-	/*==================================================================
-	 * Cache line 1: 0x0000 - 0x007F
-	 * Kernel only data - undefined for user space
-	 *==================================================================
-	 */
+	/* Kernel only data - undefined for user space */
 	void *xItVpdAreas;              /* VPD Data                  0x00 */
 	void *xRamDisk;                 /* iSeries ramdisk           0x08 */
 	u64   xRamDiskSize;		/* In pages                  0x10 */
@@ -32,12 +28,6 @@
 	u64 interrupt_controller;	/* Type of int controller    0x40 */ 
 	u64 unused1;			/* was SLB size in entries   0x48 */
 	u64 pftSize;			/* Log 2 of page table size  0x50 */
-	void *systemcfg;		/* Pointer to systemcfg data 0x58 */
-	u32 dCacheL1LogLineSize;	/* L1 d-cache line size Log2 0x60 */
-	u32 dCacheL1LinesPerPage;	/* L1 d-cache lines / page   0x64 */
-	u32 iCacheL1LogLineSize;	/* L1 i-cache line size Log2 0x68 */
-	u32 iCacheL1LinesPerPage;	/* L1 i-cache lines / page   0x6c */
-	u8  resv0[15];                  /* Reserved           0x71 - 0x7F */
 };
 
 extern struct naca_struct *naca;
diff -ruN linus-bk/include/asm-ppc64/page.h linus-bk-naca.1/include/asm-ppc64/page.h
--- linus-bk/include/asm-ppc64/page.h	2004-10-29 07:03:22.000000000 +1000
+++ linus-bk-naca.1/include/asm-ppc64/page.h	2004-12-31 14:52:14.000000000 +1100
@@ -93,7 +93,7 @@
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
-#include <asm/naca.h>
+#include <asm/cache.h>
 
 #undef STRICT_MM_TYPECHECKS
 
@@ -106,8 +106,8 @@
 {
 	unsigned long lines, line_size;
 
-	line_size = systemcfg->dCacheL1LineSize; 
-	lines = naca->dCacheL1LinesPerPage;
+	line_size = ppc64_caches.dline_size;
+	lines = ppc64_caches.dlines_per_page;
 
 	__asm__ __volatile__(
 	"mtctr  	%1	# clear_page\n\
diff -ruN linus-bk/include/asm-ppc64/processor.h linus-bk-naca.1/include/asm-ppc64/processor.h
--- linus-bk/include/asm-ppc64/processor.h	2004-12-29 18:05:40.000000000 +1100
+++ linus-bk-naca.1/include/asm-ppc64/processor.h	2004-12-31 15:01:17.000000000 +1100
@@ -19,6 +19,7 @@
 #endif
 #include <asm/ptrace.h>
 #include <asm/types.h>
+#include <asm/systemcfg.h>
 
 /* Machine State Register (MSR) Fields */
 #define MSR_SF_LG	63              /* Enable 64 bit mode */
diff -ruN linus-bk/include/asm-ppc64/systemcfg.h linus-bk-naca.1/include/asm-ppc64/systemcfg.h
--- linus-bk/include/asm-ppc64/systemcfg.h	2004-09-29 08:25:16.000000000 +1000
+++ linus-bk-naca.1/include/asm-ppc64/systemcfg.h	2004-12-31 14:52:14.000000000 +1100
@@ -15,14 +15,6 @@
  * End Change Activity 
  */
 
-
-#ifndef __KERNEL__
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <linux/types.h>
-#endif
-
 /*
  * If the major version changes we are incompatible.
  * Minor version changes are a hint.
@@ -50,10 +42,11 @@
 	__u64 tb_update_count;		/* Timebase atomicity ctr	0x50 */
 	__u32 tz_minuteswest;		/* Minutes west of Greenwich	0x58 */
 	__u32 tz_dsttime;		/* Type of dst correction	0x5C */
-	__u32 dCacheL1Size;		/* L1 d-cache size		0x60 */
-	__u32 dCacheL1LineSize;		/* L1 d-cache line size		0x64 */
-	__u32 iCacheL1Size;		/* L1 i-cache size		0x68 */
-	__u32 iCacheL1LineSize;		/* L1 i-cache line size		0x6C */
+	/* next four are no longer used except to be exported to /proc */
+	__u32 dcache_size;		/* L1 d-cache size		0x60 */
+	__u32 dcache_line_size;		/* L1 d-cache line size		0x64 */
+	__u32 icache_size;		/* L1 i-cache size		0x68 */
+	__u32 icache_line_size;		/* L1 i-cache line size		0x6C */
 	__u8  reserved0[3984];		/* Reserve rest of page		0x70 */
 };
 

--Signature=_Tue__4_Jan_2005_15_04_10_+1100_3T1Yj4u2biqJvpCT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2hW64CJfqux9a+8RAk//AJ9hHMRG/ZdK3w7y/e2Vmo+yw3+RlgCfTnZm
wNWsYJ77zeLIJJzzpj6SJJ0=
=1zNR
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_04_10_+1100_3T1Yj4u2biqJvpCT--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271856AbRIMQra>; Thu, 13 Sep 2001 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271869AbRIMQrR>; Thu, 13 Sep 2001 12:47:17 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:17669 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271858AbRIMQqw>; Thu, 13 Sep 2001 12:46:52 -0400
Date: Thu, 13 Sep 2001 18:36:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 5/11] #ifdef __x86_64__'s added where needed
Message-ID: <20010913183652.A2594@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch adds __x86_64__ #ifdefs where necessary so that the drivers
do compile on this architecture and don't complain of unknown
architecture.

diff -urN linux-x86_64/drivers/atm/eni.c linux/drivers/atm/eni.c
--- linux-x86_64/drivers/atm/eni.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/atm/eni.c	Tue Sep 11 09:49:17 2001
@@ -32,7 +32,7 @@
 #include "suni.h"
 #include "eni.h"
 
-#ifndef __i386__
+#if !defined(__i386__) && !defined(__x86_64__)
 #ifndef ioremap_nocache
 #define ioremap_nocache(X,Y) ioremap(X,Y)
 #endif 
diff -urN linux-x86_64/drivers/atm/zatm.c linux/drivers/atm/zatm.c
--- linux-x86_64/drivers/atm/zatm.c	Fri Jul  6 01:28:43 2001
+++ linux/drivers/atm/zatm.c	Thu Sep 13 13:47:46 2001
@@ -52,6 +52,12 @@
 #define DPRINTK(format,args...)
 #endif
 
+#ifndef __i386__
+#ifdef CONFIG_ATM_ZATM_EXACT_TS
+#warning Precise timestamping only available on i386 platform
+#undef CONFIG_ATM_ZATM_EXACT_TS
+#endif
+#endif
 
 #ifndef CONFIG_ATM_ZATM_DEBUG
 
diff -urN linux-x86_64/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux-x86_64/drivers/char/agp/agpgart_be.c	Thu Aug 23 18:14:36 2001
+++ linux/drivers/char/agp/agpgart_be.c	Thu Sep 13 13:57:58 2001
@@ -65,7 +65,7 @@
 
 static inline void flush_cache(void)
 {
-#if defined(__i386__)
+#if defined(__i386__) || defined(__x86_64__)
 	asm volatile ("wbinvd":::"memory");
 #elif defined(__alpha__) || defined(__ia64__) || defined(__sparc__)
 	/* ??? I wonder if we'll really need to flush caches, or if the
diff -urN linux-x86_64/drivers/char/ftape/lowlevel/ftape-calibr.c linux/drivers/char/ftape/lowlevel/ftape-calibr.c
--- linux-x86_64/drivers/char/ftape/lowlevel/ftape-calibr.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/char/ftape/lowlevel/ftape-calibr.c	Thu Sep 13 11:03:38 2001
@@ -31,7 +31,7 @@
 #include <asm/io.h>
 #if defined(__alpha__)
 # include <asm/hwrpb.h>
-#elif defined(__i386__)
+#elif defined(__i386__) || defined(__x86_64__)
 # include <linux/timex.h>
 #endif
 #include <linux/ftape.h>
@@ -41,7 +41,7 @@
 
 #undef DEBUG
 
-#if !defined(__alpha__) && !defined(__i386__)
+#if !defined(__alpha__) && !defined(__i386__) && !defined(__x86_64__)
 # error Ftape is not implemented for this architecture!
 #endif
 
@@ -70,7 +70,7 @@
 
 	asm volatile ("rpcc %0" : "=r" (r));
 	return r;
-#elif defined(__i386__)
+#elif defined(__i386__) || defined(__x86_64__)
 	unsigned long flags;
 	__u16 lo;
 	__u16 hi;
@@ -90,7 +90,7 @@
 {
 #if defined(__alpha__)
 	return ftape_timestamp();
-#elif defined(__i386__)
+#elif defined(__i386__) || defined(__x86_64__)
 	unsigned int count;
  	unsigned long flags;
  
@@ -108,7 +108,7 @@
 {
 #if defined(__alpha__)
 	return (t1 <= t0) ? t1 + (1UL << 32) - t0 : t1 - t0;
-#elif defined(__i386__)
+#elif defined(__i386__) || defined(__x86_64__)
 	/*
 	 * This is tricky: to work for both short and full ftape_timestamps
 	 * we'll have to discriminate between these.
@@ -124,7 +124,7 @@
 {
 #if defined(__alpha__)
 	return (ps_per_cycle * count) / 1000000UL;
-#elif defined(__i386__)
+#elif defined(__i386__) || defined(__x86_64__)
 	return (10000 * count) / ((CLOCK_TICK_RATE + 50) / 100);
 #endif
 }
@@ -164,7 +164,7 @@
 
 static void init_clock(void)
 {
-#if defined(__i386__)
+#if defined(__i386__) || defined(__x86_64__)
 	unsigned int t;
 	int i;
 	TRACE_FUN(ft_t_any);
@@ -214,7 +214,7 @@
 	unsigned int tc = 0;
 	unsigned int count;
 	unsigned int time;
-#if defined(__i386__)
+#if defined(__i386__) || defined(__x86_64__)
 	unsigned int old_tc = 0;
 	unsigned int old_count = 1;
 	unsigned int old_time = 1;
@@ -265,7 +265,7 @@
 		if (time >= 100*1000) {
 			break;
 		}
-#elif defined(__i386__)
+#elif defined(__i386__) || defined(__x86_64__)
 		/*
 		 * increase the count until the resulting time nears 2/HZ,
 		 * then the tc will drop sharply because we lose LATCH counts.
diff -urN linux-x86_64/drivers/char/nvram.c linux/drivers/char/nvram.c
--- linux-x86_64/drivers/char/nvram.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/char/nvram.c	Tue Sep 11 09:49:17 2001
@@ -43,7 +43,7 @@
 /* select machine configuration */
 #if defined(CONFIG_ATARI)
 #define MACH ATARI
-#elif defined(__i386__) || defined(__arm__) /* and others?? */
+#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) /* and others?? */
 #define MACH PC
 #else
 #error Cannot build nvram driver for this machine configuration.
diff -urN linux-x86_64/drivers/char/tpqic02.c linux/drivers/char/tpqic02.c
--- linux-x86_64/drivers/char/tpqic02.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/char/tpqic02.c	Tue Sep 11 09:49:17 2001
@@ -762,10 +762,11 @@
 static int get_status(volatile struct tpstatus *stp)
 {
 	int stat = rdstatus((char *) stp, TPSTATSIZE, QCMD_RD_STAT);
-#ifdef __i386__
+#if defined(__i386__) || defined (__x86_64__)
 	byte_swap_w(&(stp->dec));
 	byte_swap_w(&(stp->urc));
 #else
+#warning Undefined architecture
 	/* should probably swap status bytes #definition */
 #endif
 	return stat;
diff -urN linux-x86_64/drivers/mtd/devices/docprobe.c linux/drivers/mtd/devices/docprobe.c
--- linux-x86_64/drivers/mtd/devices/docprobe.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/mtd/devices/docprobe.c	Tue Sep 11 09:49:17 2001
@@ -70,7 +70,7 @@
 
 
 static unsigned long __initdata doc_locations[] = {
-#if defined (__alpha__) || defined(__i386__)
+#if defined (__alpha__) || defined(__i386__) || defined(__x86_64__)
 #ifdef CONFIG_MTD_DOCPROBE_HIGH
 	0xfffc8000, 0xfffca000, 0xfffcc000, 0xfffce000, 
 	0xfffd0000, 0xfffd2000, 0xfffd4000, 0xfffd6000,
diff -urN linux-x86_64/drivers/net/fealnx.c linux/drivers/net/fealnx.c
--- linux-x86_64/drivers/net/fealnx.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/net/fealnx.c	Tue Sep 11 09:49:17 2001
@@ -892,7 +892,7 @@
 //   np->bcrvalue=0x04 | 0x0x38;  /* big-endian, 256 burst length */
 	np->bcrvalue = 0x04 | 0x10;	/* big-endian, tx 8 burst length */
 	np->crvalue = 0xe00;	/* rx 128 burst length */
-#elif defined(__alpha__)
+#elif defined(__alpha__) || defined(__x86_64__)
 // 89/9/1 modify, 
 //   np->bcrvalue=0x38;           /* little-endian, 256 burst length */
 	np->bcrvalue = 0x10;	/* little-endian, 8 burst length */
diff -urN linux-x86_64/drivers/net/pcmcia/xircom_tulip_cb.c linux/drivers/net/pcmcia/xircom_tulip_cb.c
--- linux-x86_64/drivers/net/pcmcia/xircom_tulip_cb.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/net/pcmcia/xircom_tulip_cb.c	Tue Sep 11 09:49:17 2001
@@ -67,7 +67,7 @@
 	ToDo: Non-Intel setting could be better.
 */
 
-#if defined(__alpha__)
+#if defined(__alpha__) || defined(__ia64__) || defined(__x86_64__)
 static int csr0 = 0x01A00000 | 0xE000;
 #elif defined(__powerpc__)
 static int csr0 = 0x01B00000 | 0x8000;
diff -urN linux-x86_64/drivers/net/tulip/tulip_core.c linux/drivers/net/tulip/tulip_core.c
--- linux-x86_64/drivers/net/tulip/tulip_core.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/net/tulip/tulip_core.c	Tue Sep 11 09:49:17 2001
@@ -77,7 +77,7 @@
 	ToDo: Non-Intel setting could be better.
 */
 
-#if defined(__alpha__) || defined(__ia64__)
+#if defined(__alpha__) || defined(__ia64__) || defined(__x86_64__)
 static int csr0 = 0x01A00000 | 0xE000;
 #elif defined(__i386__) || defined(__powerpc__)
 static int csr0 = 0x01A00000 | 0x8000;
diff -urN linux-x86_64/drivers/net/winbond-840.c linux/drivers/net/winbond-840.c
--- linux-x86_64/drivers/net/winbond-840.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/net/winbond-840.c	Tue Sep 11 09:49:17 2001
@@ -952,7 +952,7 @@
 	} else {
 		i |= 0xE000;
 	}
-#elif defined(__powerpc__) || defined(__i386__) || defined(__alpha) || defined(__ia64__)
+#elif defined(__powerpc__) || defined(__i386__) || defined(__alpha__) || defined(__ia64__) || defined(__x86_64__)
 	i |= 0xE000;
 #elif defined(__sparc__)
 	i |= 0x4800;
diff -urN linux-x86_64/drivers/scsi/NCR53C9x.h linux/drivers/scsi/NCR53C9x.h
--- linux-x86_64/drivers/scsi/NCR53C9x.h	Thu Sep 13 15:17:33 2001
+++ linux/drivers/scsi/NCR53C9x.h	Tue Sep 11 09:49:17 2001
@@ -140,7 +140,7 @@
  * Yet, they all live within the same IO space.
  */
 
-#ifndef __i386__
+#if !defined(__i386__) && !defined(__x86_64__)
 
 #ifndef MULTIPLE_PAD_SIZES
 
@@ -232,7 +232,7 @@
 
 #endif
 
-#else /* !defined __i386__ */
+#else /* !defined(__i386__) && !defined(__x86_64__) */
 
 #define esp_write(__reg, __val) outb((__val), (__reg))
 #define esp_read(__reg) inb((__reg))
@@ -267,7 +267,7 @@
 #define esp_fgrnd   io_addr + 15 /* rw  Data base for fifo             0x3c  */
 };
 
-#endif /* !defined(__i386__) */
+#endif /* !defined(__i386__) && !defined(__x86_64__) */
 
 /* Various revisions of the ESP board. */
 enum esp_rev {
diff -urN linux-x86_64/drivers/scsi/aic7xxx/aic7xxx_osm.h linux/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- linux-x86_64/drivers/scsi/aic7xxx/aic7xxx_osm.h	Thu Sep 13 15:17:33 2001
+++ linux/drivers/scsi/aic7xxx/aic7xxx_osm.h	Thu Sep 13 14:38:43 2001
@@ -580,7 +580,7 @@
 
 
 /***************************** Low Level I/O **********************************/
-#if defined(__powerpc__) || defined(__i386__) || defined(__ia64__)
+#if defined(__powerpc__) || defined(__i386__) || defined(__ia64__) || defined(__x86_64__)
 #define MMAPIO
 #endif
 
diff -urN linux-x86_64/drivers/scsi/aic7xxx_old.c linux/drivers/scsi/aic7xxx_old.c
--- linux-x86_64/drivers/scsi/aic7xxx_old.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/scsi/aic7xxx_old.c	Tue Sep 11 09:49:17 2001
@@ -283,7 +283,7 @@
 #  define FALSE 0
 #endif
 
-#if defined(__powerpc__) || defined(__i386__)
+#if defined(__powerpc__) || defined(__i386__) || defined(__x86_64__)
 #  define MMAPIO
 #endif
 
diff -urN linux-x86_64/drivers/scsi/seagate.c linux/drivers/scsi/seagate.c
--- linux-x86_64/drivers/scsi/seagate.c	Thu Apr 19 22:02:10 2001
+++ linux/drivers/scsi/seagate.c	Thu Sep 13 11:44:26 2001
@@ -129,6 +129,10 @@
 #error Please use -DCONTROLLER=SEAGATE or -DCONTROLLER=FD to override controller type
 #endif
 
+#ifndef __i386__
+#undef SEAGATE_USE_ASM
+#endif
+
 /*
 	Thanks to Brian Antoine for the example code in his Messy-Loss ST-01
 		driver, and Mitsugu Suzuki for information on the ST-01
diff -urN linux-x86_64/drivers/scsi/sym53c8xx_defs.h linux/drivers/scsi/sym53c8xx_defs.h
--- linux-x86_64/drivers/scsi/sym53c8xx_defs.h	Thu Sep 13 15:17:33 2001
+++ linux/drivers/scsi/sym53c8xx_defs.h	Tue Sep 11 09:49:17 2001
@@ -455,7 +455,7 @@
  *  We want to be paranoid for ppc and ia64. :)
  */
 
-#if	defined	__i386__
+#if	defined(__i386__) || defined(__x86_64__)
 #define MEMORY_BARRIER()	do { ; } while(0)
 #elif	defined	__powerpc__
 #define MEMORY_BARRIER()	__asm__ volatile("eieio; sync" : : : "memory")
diff -urN linux-x86_64/drivers/video/cyber2000fb.c linux/drivers/video/cyber2000fb.c
--- linux-x86_64/drivers/video/cyber2000fb.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/video/cyber2000fb.c	Tue Sep 11 09:49:17 2001
@@ -1285,7 +1285,7 @@
 		cfb->mclk_div  = cyber2000_grphr(MCLK_DIV);
 	}
 #endif
-#ifdef __i386__
+#if defined(__i386__) || defined(__x86_64__)
 	/*
 	 * x86 is simple, we just do regular outb's instead of
 	 * cyber2000_outb.
diff -urN linux-x86_64/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-x86_64/drivers/video/fbmem.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/video/fbmem.c	Tue Sep 11 09:49:17 2001
@@ -593,7 +593,7 @@
 	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
 #elif defined(__alpha__)
 	/* Caching is off in the I/O space quadrant by design.  */
-#elif defined(__i386__)
+#elif defined(__i386__) || defined(__x86_64__)
 	if (boot_cpu_data.x86 > 3)
 		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 #elif defined(__mips__)
diff -urN linux-x86_64/drivers/video/matrox/matroxfb_base.h linux/drivers/video/matrox/matroxfb_base.h
--- linux-x86_64/drivers/video/matrox/matroxfb_base.h	Thu Sep 13 15:17:33 2001
+++ linux/drivers/video/matrox/matroxfb_base.h	Thu Sep 13 14:44:06 2001
@@ -102,7 +102,7 @@
 
 #endif /* MATROXFB_DEBUG */
 
-#ifndef __i386__
+#if !defined(__i386__) && !defined(__x86_64__)
 #ifndef ioremap_nocache
 #define ioremap_nocache(X,Y) ioremap(X,Y)
 #endif
@@ -117,7 +117,7 @@
 /* I benchmarked PII/350MHz with G200... MEMCPY, MEMCPYTOIO and WRITEL are on same speed ( <2% diff) */
 /* so that means that G200 speed (or AGP speed?) is our limit... I do not have benchmark to test, how */
 /* much of PCI bandwidth is used during transfers... */
-#if defined(__i386__)
+#if defined(__i386__) || defined(__x86_64__)
 #define MEMCPYTOIO_MEMCPY
 #else
 #define MEMCPYTOIO_WRITEL
diff -urN linux-x86_64/include/linux/brlock.h linux/include/linux/brlock.h
--- linux-x86_64/include/linux/brlock.h	Thu Sep 13 15:17:33 2001
+++ linux/include/linux/brlock.h	Wed Sep 12 17:23:38 2001
@@ -45,7 +45,7 @@
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 
-#if defined(__i386__) || defined(__ia64__)
+#if defined(__i386__) || defined(__ia64__) || defined(__x86_64__)
 #define __BRLOCK_USE_ATOMICS
 #else
 #undef __BRLOCK_USE_ATOMICS
diff -urN linux-x86_64/include/linux/mtd/doc2000.h linux/include/linux/mtd/doc2000.h
--- linux-x86_64/include/linux/mtd/doc2000.h	Thu Sep 13 15:17:33 2001
+++ linux/include/linux/mtd/doc2000.h	Thu Sep 13 14:32:52 2001
@@ -58,7 +58,7 @@
 
 #endif
 
-#if defined(__i386__)
+#if defined(__i386__) || defined(__x86_64__)
 #define USE_MEMCPY
 #endif
 
diff -urN linux-x86_64/include/linux/raid/md_compatible.h linux/include/linux/raid/md_compatible.h
--- linux-x86_64/include/linux/raid/md_compatible.h	Wed Aug 15 09:53:37 2001
+++ linux/include/linux/raid/md_compatible.h	Thu Sep 13 14:23:49 2001
@@ -27,12 +27,14 @@
 /* 000 */
 #define md__get_free_pages(x,y) __get_free_pages(x,y)
 
-#ifdef __i386__
+#if defined(__i386__) || defined(__x86_64__)
 /* 001 */
 static __inline__ int md_cpu_has_mmx(void)
 {
 	return test_bit(X86_FEATURE_MMX,  &boot_cpu_data.x86_capability);
 }
+#else
+#define md_cpu_has_mmx(x)	(0)
 #endif
 
 /* 002 */
diff -urN linux-x86_64/scripts/mkdep.c linux/scripts/mkdep.c
--- linux-x86_64/scripts/mkdep.c	Thu Sep 13 15:17:33 2001
+++ linux/scripts/mkdep.c	Tue Sep 11 09:49:17 2001
@@ -291,7 +291,7 @@
  * Thus, there is one memory access per sizeof(unsigned long) characters.
  */
 
-#if defined(__alpha__) || defined(__i386__) || defined(__ia64__) || defined(__MIPSEL__)	\
+#if defined(__alpha__) || defined(__i386__) || defined(__ia64__)  || defined(__x86_64__) || defined(__MIPSEL__)	\
     || defined(__arm__)
 #define LE_MACHINE
 #endif

-- 
Vojtech Pavlik
SuSE Labs

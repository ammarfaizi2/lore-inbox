Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVADExy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVADExy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 23:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVADExL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:53:11 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:30152 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262042AbVADEov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:44:51 -0500
Date: Tue, 4 Jan 2005 15:31:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/11] PPC64: remove debug_switch from the naca
Message-Id: <20050104153102.67284491.sfr@canb.auug.org.au>
In-Reply-To: <20050104152705.6030abc5.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
	<20050104151229.521e8083.sfr@canb.auug.org.au>
	<20050104151906.6e50f1d2.sfr@canb.auug.org.au>
	<20050104152340.67219ccf.sfr@canb.auug.org.au>
	<20050104152705.6030abc5.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_31_02_+1100_b7efbSMbT9SxcDEO"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_31_02_+1100_b7efbSMbT9SxcDEO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

The patch moves the debug_switch from the naca to a global variable.

Also, a couple of trivial naming tidy ups.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-naca.6/arch/ppc64/kernel/pSeries_setup.c linus-bk-naca.7/arch/ppc64/kernel/pSeries_setup.c
--- linus-bk-naca.6/arch/ppc64/kernel/pSeries_setup.c	2004-12-31 15:35:13.000000000 +1100
+++ linus-bk-naca.7/arch/ppc64/kernel/pSeries_setup.c	2004-12-31 15:39:01.000000000 +1100
@@ -56,7 +56,6 @@
 #include <asm/dma.h>
 #include <asm/machdep.h>
 #include <asm/irq.h>
-#include <asm/naca.h>
 #include <asm/time.h>
 #include <asm/nvram.h>
 
@@ -317,7 +316,7 @@
 		else if (strstr(typep, "ppc-xicp"))
 			ppc64_interrupt_controller = IC_PPC_XIC;
 		else
-			printk("initialize_naca: failed to recognize"
+			printk("pSeries_discover_pic: failed to recognize"
 			       " interrupt-controller\n");
 		break;
 	}
diff -ruN linus-bk-naca.6/arch/ppc64/kernel/setup.c linus-bk-naca.7/arch/ppc64/kernel/setup.c
--- linus-bk-naca.6/arch/ppc64/kernel/setup.c	2004-12-31 16:23:30.000000000 +1100
+++ linus-bk-naca.7/arch/ppc64/kernel/setup.c	2004-12-31 16:25:02.000000000 +1100
@@ -41,7 +41,6 @@
 #include <asm/elf.h>
 #include <asm/machdep.h>
 #include <asm/iSeries/LparData.h>
-#include <asm/naca.h>
 #include <asm/paca.h>
 #include <asm/ppcdebug.h>
 #include <asm/time.h>
@@ -113,6 +112,7 @@
 int boot_cpuid_phys = 0;
 dev_t boot_dev;
 u64 ppc64_pft_size;
+u64 ppc64_debug_switch;
 
 struct ppc64_caches ppc64_caches;
 
@@ -161,7 +161,7 @@
  */
 void __init ppcdbg_initialize(void)
 {
-	naca->debug_switch = PPC_DEBUG_DEFAULT; /* | PPCDBG_BUSWALK | */
+	ppc64_debug_switch = PPC_DEBUG_DEFAULT; /* | PPCDBG_BUSWALK | */
 	/* PPCDBG_PHBINIT | PPCDBG_MM | PPCDBG_MMINIT | PPCDBG_TCEINIT | PPCDBG_TCE */;
 }
 
@@ -399,7 +399,7 @@
 	DBG(" -> early_setup()\n");
 
 	/*
-	 * Fill the default DBG level in naca (do we want to keep
+	 * Fill the default DBG level (do we want to keep
 	 * that old mecanism around forever ?)
 	 */
 	ppcdbg_initialize();
@@ -453,17 +453,17 @@
 
 
 /*
- * Initialize some remaining members of the naca and systemcfg structures
+ * Initialize some remaining members of the ppc64_caches and systemcfg structures
  * (at least until we get rid of them completely). This is mostly some
  * cache informations about the CPU that will be used by cache flush
  * routines and/or provided to userland
  */
-static void __init initialize_naca(void)
+static void __init initialize_cache_info(void)
 {
 	struct device_node *np;
 	unsigned long num_cpus = 0;
 
-	DBG(" -> initialize_naca()\n");
+	DBG(" -> initialize_cache_info()\n");
 
 	for (np = NULL; (np = of_find_node_by_type(np, "cpu"));) {
 		num_cpus += 1;
@@ -530,7 +530,7 @@
 	systemcfg->version.minor = SYSTEMCFG_MINOR;
 	systemcfg->processor = mfspr(SPRN_PVR);
 
-	DBG(" <- initialize_naca()\n");
+	DBG(" <- initialize_cache_info()\n");
 }
 
 static void __init check_for_initrd(void)
@@ -591,7 +591,7 @@
 	unflatten_device_tree();
 
 	/*
-	 * Fill the naca & systemcfg structures with informations
+	 * Fill the ppc64_caches & systemcfg structures with informations
 	 * retreived from the device-tree. Need to be called before
 	 * finish_device_tree() since the later requires some of the
 	 * informations filled up here to properly parse the interrupt
@@ -600,7 +600,7 @@
 	 * routines like flush_icache_range (used by the hash init
 	 * later on).
 	 */
-	initialize_naca();
+	initialize_cache_info();
 
 #ifdef CONFIG_PPC_PSERIES
 	/*
@@ -661,9 +661,8 @@
 	printk("Starting Linux PPC64 %s\n", UTS_RELEASE);
 
 	printk("-----------------------------------------------------\n");
-	printk("naca                          = 0x%p\n", naca);
 	printk("ppc64_pft_size                = 0x%lx\n", ppc64_pft_size);
-	printk("naca->debug_switch            = 0x%lx\n", naca->debug_switch);
+	printk("ppc64_debug_switch            = 0x%lx\n", ppc64_debug_switch);
 	printk("ppc64_interrupt_controller    = 0x%ld\n", ppc64_interrupt_controller);
 	printk("systemcfg                     = 0x%p\n", systemcfg);
 	printk("systemcfg->platform           = 0x%x\n", systemcfg->platform);
diff -ruN linus-bk-naca.6/arch/ppc64/kernel/udbg.c linus-bk-naca.7/arch/ppc64/kernel/udbg.c
--- linus-bk-naca.6/arch/ppc64/kernel/udbg.c	2004-11-22 14:05:02.000000000 +1100
+++ linus-bk-naca.7/arch/ppc64/kernel/udbg.c	2004-12-11 02:31:17.000000000 +1100
@@ -15,7 +15,6 @@
 #include <linux/types.h>
 #include <asm/ppcdebug.h>
 #include <asm/processor.h>
-#include <asm/naca.h>
 #include <asm/uaccess.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -323,7 +322,7 @@
 /* Special print used by PPCDBG() macro */
 void udbg_ppcdbg(unsigned long debug_flags, const char *fmt, ...)
 {
-	unsigned long active_debugs = debug_flags & naca->debug_switch;
+	unsigned long active_debugs = debug_flags & ppc64_debug_switch;
 
 	if (active_debugs) {
 		va_list ap;
@@ -357,5 +356,5 @@
 
 unsigned long udbg_ifdebug(unsigned long flags)
 {
-	return (flags & naca->debug_switch);
+	return (flags & ppc64_debug_switch);
 }
diff -ruN linus-bk-naca.6/arch/ppc64/xmon/xmon.c linus-bk-naca.7/arch/ppc64/xmon/xmon.c
--- linus-bk-naca.6/arch/ppc64/xmon/xmon.c	2004-11-26 12:08:51.000000000 +1100
+++ linus-bk-naca.7/arch/ppc64/xmon/xmon.c	2004-12-11 02:33:00.000000000 +1100
@@ -26,7 +26,6 @@
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
-#include <asm/naca.h>
 #include <asm/paca.h>
 #include <asm/ppcdebug.h>
 #include <asm/cputable.h>
@@ -2360,9 +2359,9 @@
 	if (cmd == '\n') {
 		/* show current state */
 		unsigned long i;
-		printf("naca->debug_switch = 0x%lx\n", naca->debug_switch);
+		printf("ppc64_debug_switch = 0x%lx\n", ppc64_debug_switch);
 		for (i = 0; i < PPCDBG_NUM_FLAGS ;i++) {
-			on = PPCDBG_BITVAL(i) & naca->debug_switch;
+			on = PPCDBG_BITVAL(i) & ppc64_debug_switch;
 			printf("%02x %s %12s   ", i, on ? "on " : "off",  trace_names[i] ? trace_names[i] : "");
 			if (((i+1) % 3) == 0)
 				printf("\n");
@@ -2376,7 +2375,7 @@
 			on = (cmd == '+');
 			cmd = inchar();
 			if (cmd == ' ' || cmd == '\n') {  /* Turn on or off based on + or - */
-				naca->debug_switch = on ? PPCDBG_ALL:PPCDBG_NONE;
+				ppc64_debug_switch = on ? PPCDBG_ALL:PPCDBG_NONE;
 				printf("Setting all values to %s...\n", on ? "on" : "off");
 				if (cmd == '\n') return;
 				else cmd = skipbl(); 
@@ -2391,10 +2390,10 @@
 			return;
 		}
 		if (on) {
-			naca->debug_switch |= PPCDBG_BITVAL(val);
+			ppc64_debug_switch |= PPCDBG_BITVAL(val);
 			printf("enable debug %x %s\n", val, trace_names[val] ? trace_names[val] : "");
 		} else {
-			naca->debug_switch &= ~PPCDBG_BITVAL(val);
+			ppc64_debug_switch &= ~PPCDBG_BITVAL(val);
 			printf("disable debug %x %s\n", val, trace_names[val] ? trace_names[val] : "");
 		}
 		cmd = skipbl();
diff -ruN linus-bk-naca.6/include/asm-ppc64/naca.h linus-bk-naca.7/include/asm-ppc64/naca.h
--- linus-bk-naca.6/include/asm-ppc64/naca.h	2004-12-11 00:03:55.000000000 +1100
+++ linus-bk-naca.7/include/asm-ppc64/naca.h	2004-12-11 02:41:18.000000000 +1100
@@ -19,9 +19,6 @@
 	void *xItVpdAreas;              /* VPD Data                  0x00 */
 	void *xRamDisk;                 /* iSeries ramdisk           0x08 */
 	u64   xRamDiskSize;		/* In pages                  0x10 */
-	u64 debug_switch;		/* Debug print control       0x20 */
-	u64 banner;                     /* Ptr to banner string      0x28 */
-	u64 log;                        /* Ptr to log buffer         0x30 */
 };
 
 extern struct naca_struct *naca;
diff -ruN linus-bk-naca.6/include/asm-ppc64/ppcdebug.h linus-bk-naca.7/include/asm-ppc64/ppcdebug.h
--- linus-bk-naca.6/include/asm-ppc64/ppcdebug.h	2004-02-16 08:19:48.000000000 +1100
+++ linus-bk-naca.7/include/asm-ppc64/ppcdebug.h	2004-12-13 12:05:25.000000000 +1100
@@ -16,13 +16,14 @@
  ********************************************************************/
 
 #include <linux/config.h>
+#include <linux/types.h>
 #include <asm/udbg.h>
 #include <stdarg.h>
 
 #define PPCDBG_BITVAL(X)     ((1UL)<<((unsigned long)(X)))
 
 /* Defined below are the bit positions of various debug flags in the
- * debug_switch variable (defined in naca.h).
+ * ppc64_debug_switch variable.
  * -- When adding new values, please enter them into trace names below -- 
  *
  * Values 62 & 63 can be used to stress the hardware page table management
@@ -64,6 +65,8 @@
 
 #define PPCDBG_NUM_FLAGS     64
 
+extern u64 ppc64_debug_switch;
+
 #ifdef WANT_PPCDBG_TAB
 /* A table of debug switch names to allow name lookup in xmon 
  * (and whoever else wants it.

--Signature=_Tue__4_Jan_2005_15_31_02_+1100_b7efbSMbT9SxcDEO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2hwG4CJfqux9a+8RAgFkAJ9h8ypk2Qrike4hsAJMzODXFe1SCACglyaF
2/9it5gBAyBM3LuUMqKQ3IA=
=jxCO
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_31_02_+1100_b7efbSMbT9SxcDEO--

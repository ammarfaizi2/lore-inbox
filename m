Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266461AbUF3EnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUF3EnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 00:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUF3EnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 00:43:16 -0400
Received: from ozlabs.org ([203.10.76.45]:1238 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266461AbUF3El1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 00:41:27 -0400
Date: Wed, 30 Jun 2004 14:34:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PPC64] 1/2 - Remove RTAS arguments from PACA
Message-ID: <20040630043440.GB15526@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

This patch removes the RTAS arguments structure on ppc64 from the
PACA.  The args have to be in the RMO, but since we have a global
spinlock for RTAS anyway, there's no reason to have a separate copy of
the args per-CPU.  This patch replaces the PACA field with a single
instance in the global rtas structure.

The one exception is for the rtas_stop_self() call, which can't take
the lock, because it never returns.  But it has a fixed set of
arguments, so we can use another global instance which is initialized
at boot.

This lets us remove rtas.h from paca.h, which substantially reduces
overall #include hairiness (because paca.h is now, as it wants to be,
a nice low-level structure-defining header which relies on very little
and can safely be included almost anywhere).  Although it does add
some noise to the patch, because a bunch of places relied on the
indirect inclusion of rtas.h, or even more indirect inclusions (see
the hunks applying to eeh.h and current.h!).


Index: working-2.6/arch/ppc64/kernel/rtas.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/rtas.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/rtas.c	2004-06-29 11:49:46.371172728 +1000
@@ -45,11 +45,10 @@
 void
 call_rtas_display_status(char c)
 {
-	struct rtas_args *args;
+	struct rtas_args *args = &rtas.args;
 	unsigned long s;
 
 	spin_lock_irqsave(&rtas.lock, s);
-	args = &(get_paca()->xRtas);
 
 	args->token = 10;
 	args->nargs = 1;
@@ -90,15 +89,15 @@
 	err_args.args[2] = 0;
 
 	temp_args = *rtas_args;
-	get_paca()->xRtas = err_args;
+	rtas.args = err_args;
 
 	PPCDBG(PPCDBG_RTAS, "\tentering rtas with 0x%lx\n",
 	       __pa(&err_args));
-	enter_rtas(__pa(&get_paca()->xRtas));
+	enter_rtas(__pa(&rtas.args));
 	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
-	err_args = get_paca()->xRtas;
-	get_paca()->xRtas = temp_args;
+	err_args = rtas.args;
+	rtas.args = temp_args;
 
 	return err_args.rets[0];
 }
@@ -134,7 +133,7 @@
 
 	/* Gotta do something different here, use global lock for now... */
 	spin_lock_irqsave(&rtas.lock, s);
-	rtas_args = &(get_paca()->xRtas);
+	rtas_args = &rtas.args;
 
 	rtas_args->token = token;
 	rtas_args->nargs = nargs;
@@ -440,9 +439,9 @@
 
 	spin_lock_irqsave(&rtas.lock, flags);
 
-	get_paca()->xRtas = args;
-	enter_rtas(__pa(&get_paca()->xRtas));
-	args = get_paca()->xRtas;
+	rtas.args = args;
+	enter_rtas(__pa(&rtas.args));
+	args = rtas.args;
 
 	spin_unlock_irqrestore(&rtas.lock, flags);
 
@@ -460,19 +459,23 @@
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/* This version can't take the spinlock. */
+/* This version can't take the spinlock, because it never returns */
+
+struct rtas_args rtas_stop_self_args = {
+	/* The token is initialized for real in setup_system() */
+	.token = RTAS_UNKNOWN_SERVICE,
+	.nargs = 0,
+	.nret = 1,
+	.rets = &rtas_stop_self_args.args[0],
+};
 
 void rtas_stop_self(void)
 {
-	struct rtas_args *rtas_args = &(get_paca()->xRtas);
+	struct rtas_args *rtas_args = &rtas_stop_self_args;
 
 	local_irq_disable();
 
-	rtas_args->token = rtas_token("stop-self");
 	BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE);
-	rtas_args->nargs = 0;
-	rtas_args->nret  = 1;
-	rtas_args->rets  = &(rtas_args->args[0]);
 
 	printk("%u %u Ready to die...\n",
 	       smp_processor_id(), hard_smp_processor_id());
Index: working-2.6/arch/ppc64/kernel/traps.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/traps.c	2004-06-29 11:49:45.717138984 +1000
+++ working-2.6/arch/ppc64/kernel/traps.c	2004-06-29 11:49:46.372172576 +1000
@@ -36,6 +36,7 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/ppcdebug.h>
+#include <asm/rtas.h>
 
 #ifdef CONFIG_PPC_PSERIES
 /* This is true if we are using the firmware NMI handler (typically LPAR) */
Index: working-2.6/arch/ppc64/kernel/eeh.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/eeh.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/eeh.c	2004-06-29 11:49:46.373172424 +1000
@@ -31,6 +31,7 @@
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/pgtable.h>
+#include <asm/rtas.h>
 #include "pci.h"
 
 #undef DEBUG
Index: working-2.6/arch/ppc64/kernel/rtc.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/rtc.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/rtc.c	2004-06-29 11:49:46.374172272 +1000
@@ -40,6 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/time.h>
+#include <asm/rtas.h>
 
 #include <asm/iSeries/LparData.h>
 #include <asm/iSeries/mf.h>
Index: working-2.6/arch/ppc64/kernel/setup.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/setup.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/setup.c	2004-06-29 11:49:46.375172120 +1000
@@ -46,6 +46,7 @@
 #include <asm/nvram.h>
 #include <asm/setup.h>
 #include <asm/system.h>
+#include <asm/rtas.h>
 
 extern unsigned long klimit;
 /* extern void *stab; */
@@ -254,6 +255,10 @@
 	}
 #endif /* CONFIG_PPC_PMAC */
 
+#if defined(CONFIG_HOTPLUG_CPU) &&  !defined(CONFIG_PPC_PMAC)
+	rtas_stop_self_args.token = rtas_token("stop-self");
+#endif /* CONFIG_HOTPLUG_CPU && !CONFIG_PPC_PMAC */
+
 	/* Finish initializing the hash table (do the dynamic
 	 * patching for the fast-path hashtable.S code)
 	 */
Index: working-2.6/arch/ppc64/kernel/pSeries_pci.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/pSeries_pci.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/pSeries_pci.c	2004-06-29 11:49:46.376171968 +1000
@@ -40,6 +40,7 @@
 #include <asm/ppcdebug.h>
 #include <asm/naca.h>
 #include <asm/iommu.h>
+#include <asm/rtas.h>
 
 #include "open_pic.h"
 #include "pci.h"
Index: working-2.6/arch/ppc64/kernel/smp.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/smp.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/smp.c	2004-06-29 11:49:46.377171816 +1000
@@ -52,6 +52,7 @@
 #include <asm/xics.h>
 #include <asm/cputable.h>
 #include <asm/system.h>
+#include <asm/rtas.h>
 
 int smp_threads_ready;
 unsigned long cache_decay_ticks;
Index: working-2.6/arch/ppc64/kernel/lparcfg.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/lparcfg.c	2004-05-20 12:57:52.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/lparcfg.c	2004-06-29 11:49:46.377171816 +1000
@@ -28,6 +28,7 @@
 #include <asm/iSeries/ItLpPaca.h>
 #include <asm/hvcall.h>
 #include <asm/cputable.h>
+#include <asm/rtas.h>
 
 #define MODULE_VERS "1.0"
 #define MODULE_NAME "lparcfg"
Index: working-2.6/arch/ppc64/xmon/xmon.c
===================================================================
--- working-2.6.orig/arch/ppc64/xmon/xmon.c	2004-06-21 11:29:19.000000000 +1000
+++ working-2.6/arch/ppc64/xmon/xmon.c	2004-06-29 11:49:46.379171512 +1000
@@ -30,6 +30,7 @@
 #include <asm/paca.h>
 #include <asm/ppcdebug.h>
 #include <asm/cputable.h>
+#include <asm/rtas.h>
 
 #include "nonstdio.h"
 #include "privinst.h"
Index: working-2.6/include/asm-ppc64/rtas.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/rtas.h	2004-06-29 11:47:03.000000000 +1000
+++ working-2.6/include/asm-ppc64/rtas.h	2004-06-29 11:49:46.380171360 +1000
@@ -51,18 +51,17 @@
 	u32 nargs;
 	u32 nret; 
 	rtas_arg_t args[16];
-#if 0
-	spinlock_t lock;
-#endif
 	rtas_arg_t *rets;     /* Pointer to return values in args[]. */
 };  
 
+extern struct rtas_args rtas_stop_self_args;
+
 struct rtas_t {
 	unsigned long entry;		/* physical address pointer */
 	unsigned long base;		/* physical address pointer */
 	unsigned long size;
 	spinlock_t lock;
-
+	struct rtas_args args;
 	struct device_node *dev;	/* virtual address pointer */
 };
 
Index: working-2.6/include/asm-ppc64/paca.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/paca.h	2004-06-21 11:29:20.000000000 +1000
+++ working-2.6/include/asm-ppc64/paca.h	2004-06-29 11:49:46.381171208 +1000
@@ -29,7 +29,6 @@
 #include	<asm/iSeries/ItLpPaca.h>
 #include	<asm/iSeries/ItLpRegSave.h>
 #include	<asm/iSeries/ItLpQueue.h>
-#include	<asm/rtas.h>
 #include	<asm/mmu.h>
 #include	<asm/processor.h>
 
@@ -122,10 +121,9 @@
  * CACHE_LINE_17-18 0x0800 - 0x08FF Reserved
  *=====================================================================================
  */
-	struct rtas_args xRtas;		/* Per processor RTAS struct */
 	u64 xR1;			/* r1 save for RTAS calls */
 	u64 xSavedMsr;			/* Old msr saved here by HvCall */
-	u8 rsvd5[256-16-sizeof(struct rtas_args)];
+	u8 rsvd5[256-16];
 
 /*=====================================================================================
  * CACHE_LINE_19-30 0x0900 - 0x0EFF Reserved
Index: working-2.6/include/asm-ppc64/eeh.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/eeh.h	2004-06-22 09:56:21.000000000 +1000
+++ working-2.6/include/asm-ppc64/eeh.h	2004-06-29 11:49:46.381171208 +1000
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 
 struct pci_dev;
+struct device_node;
 
 /* I/O addresses are converted to EEH "tokens" such that a driver will cause
  * a bad page fault if the address is used directly (i.e. these addresses are
Index: working-2.6/include/asm-ppc64/current.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/current.h	2004-06-09 10:11:50.000000000 +1000
+++ working-2.6/include/asm-ppc64/current.h	2004-06-29 11:49:46.381171208 +1000
@@ -10,8 +10,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <asm/thread_info.h>
-
 #define get_current()   (get_paca()->xCurrent)
 #define current         get_current()
 
Index: working-2.6/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- working-2.6.orig/drivers/pci/hotplug/rpadlpar_core.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/drivers/pci/hotplug/rpadlpar_core.c	2004-06-29 11:49:46.382171056 +1000
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <asm/pci-bridge.h>
 #include <asm/semaphore.h>
+#include <asm/rtas.h>
 #include "../pci.h"
 #include "rpaphp.h"
 #include "rpadlpar.h"
Index: working-2.6/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- working-2.6.orig/drivers/pci/hotplug/rpaphp_pci.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/drivers/pci/hotplug/rpaphp_pci.c	2004-06-29 11:49:46.383170904 +1000
@@ -24,6 +24,7 @@
  */
 #include <linux/pci.h>
 #include <asm/pci-bridge.h>
+#include <asm/rtas.h>
 #include "../pci.h"		/* for pci_add_new_bus */
 
 #include "rpaphp.h"
Index: working-2.6/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- working-2.6.orig/drivers/pci/hotplug/rpaphp_slot.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/drivers/pci/hotplug/rpaphp_slot.c	2004-06-29 11:49:46.383170904 +1000
@@ -27,6 +27,7 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <linux/pci.h>
+#include <asm/rtas.h>
 #include "rpaphp.h"
 
 static ssize_t removable_read_file (struct hotplug_slot *php_slot, char *buf)


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

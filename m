Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVAXGbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVAXGbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVAXG2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:28:50 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261461AbVAXGOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:30 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][12/12] InfiniBand/mthca: remove x86 SSE pessimization
In-Reply-To: <20051232214.3TWW9w76vhKgw1zV@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:24 -0800
Message-Id: <20051232214.rXeANNOMpj6wmqS6@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0637 (UTC) FILETIME=[F432E950:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the x86 SSE code for atomic 64-bit writes to doorbell
registers.  Saving/setting CR0 plus a clts instruction are too
expensive for it to ever be a win, and the config option was just
confusing.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/Kconfig	2005-01-23 08:30:27.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/Kconfig	2005-01-23 21:00:44.744520064 -0800
@@ -14,13 +14,3 @@
 	  This option causes the mthca driver produce a bunch of debug
 	  messages.  Select this is you are developing the driver or
 	  trying to diagnose a problem.
-
-config INFINIBAND_MTHCA_SSE_DOORBELL
-	bool "SSE doorbell code"
-	depends on INFINIBAND_MTHCA && X86 && !X86_64
-	default n
-	---help---
-	  This option will have the mthca driver use SSE instructions
-	  to ring hardware doorbell registers.  This may improve
-	  performance for some workloads, but the driver will not run
-	  on processors without SSE instructions.
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-01-23 20:58:55.771086544 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_main.c	2005-01-23 21:00:44.745519912 -0800
@@ -40,10 +40,6 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 
-#ifdef CONFIG_INFINIBAND_MTHCA_SSE_DOORBELL
-#include <asm/cpufeature.h>
-#endif
-
 #include "mthca_dev.h"
 #include "mthca_config_reg.h"
 #include "mthca_cmd.h"
@@ -1117,22 +1113,6 @@
 {
 	int ret;
 
-	/*
-	 * TODO: measure whether dynamically choosing doorbell code at
-	 * runtime affects our performance.  Is there a "magic" way to
-	 * choose without having to follow a function pointer every
-	 * time we ring a doorbell?
-	 */
-#ifdef CONFIG_INFINIBAND_MTHCA_SSE_DOORBELL
-	if (!cpu_has_xmm) {
-		printk(KERN_ERR PFX "mthca was compiled with SSE doorbell code, but\n");
-		printk(KERN_ERR PFX "the current CPU does not support SSE.\n");
-		printk(KERN_ERR PFX "Turn off CONFIG_INFINIBAND_MTHCA_SSE_DOORBELL "
-		       "and recompile.\n");
-		return -ENODEV;
-	}
-#endif
-
 	ret = pci_register_driver(&mthca_driver);
 	return ret < 0 ? ret : 0;
 }
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_doorbell.h	2005-01-23 08:30:38.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_doorbell.h	2005-01-23 21:00:44.746519760 -0800
@@ -32,9 +32,7 @@
  * $Id: mthca_doorbell.h 1349 2004-12-16 21:09:43Z roland $
  */
 
-#include <linux/config.h>
 #include <linux/types.h>
-#include <linux/preempt.h>
 
 #define MTHCA_RD_DOORBELL      0x00
 #define MTHCA_SEND_DOORBELL    0x10
@@ -59,51 +57,13 @@
 	__raw_writeq(*(u64 *) val, dest);
 }
 
-#elif defined(CONFIG_INFINIBAND_MTHCA_SSE_DOORBELL)
-/* Use SSE to write 64 bits atomically without a lock. */
-
-#define MTHCA_DECLARE_DOORBELL_LOCK(name)
-#define MTHCA_INIT_DOORBELL_LOCK(ptr)    do { } while (0)
-#define MTHCA_GET_DOORBELL_LOCK(ptr)      (NULL)
-
-static inline unsigned long mthca_get_fpu(void)
-{
-	unsigned long cr0;
-
-	preempt_disable();
-	asm volatile("mov %%cr0,%0; clts" : "=r" (cr0));
-	return cr0;
-}
-
-static inline void mthca_put_fpu(unsigned long cr0)
-{
-	asm volatile("mov %0,%%cr0" : : "r" (cr0));
-	preempt_enable();
-}
-
-static inline void mthca_write64(u32 val[2], void __iomem *dest,
-				 spinlock_t *doorbell_lock)
-{
-	/* i386 stack is aligned to 8 bytes, so this should be OK: */
-	u8 xmmsave[8] __attribute__((aligned(8)));
-	unsigned long cr0;
-
-	cr0 = mthca_get_fpu();
-
-	asm volatile (
-		"movlps %%xmm0,(%0); \n\t"
-		"movlps (%1),%%xmm0; \n\t"
-		"movlps %%xmm0,(%2); \n\t"
-		"movlps (%0),%%xmm0; \n\t"
-		:
-		: "r" (xmmsave), "r" (val), "r" (dest)
-		: "memory" );
-
-	mthca_put_fpu(cr0);
-}
-
 #else
-/* Just fall back to a spinlock to protect the doorbell */
+
+/*
+ * Just fall back to a spinlock to protect the doorbell if
+ * BITS_PER_LONG is 32 -- there's no portable way to do atomic 64-bit
+ * MMIO writes.
+ */
 
 #define MTHCA_DECLARE_DOORBELL_LOCK(name) spinlock_t name;
 #define MTHCA_INIT_DOORBELL_LOCK(ptr)     spin_lock_init(ptr)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUGGUSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUGGUSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUGGUSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:18:18 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:15319 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265395AbUGGUSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:18:11 -0400
Date: Wed, 7 Jul 2004 15:17:16 -0500
From: Jack Steiner <steiner@sgi.com>
To: davidm@hpl.hp.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - Eliminate machvec calls to null functions
Message-ID: <20040707201716.GA14015@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a  patch to eliminate calls to null platform vectors for
non-GENERIC kernels.

If this looks ok, then I'll update the tlb_migrate patch & 
resubmit it. (Apply this machvec patch first...)




Signed-off-by: Jack Steiner <steiner@sgi.com>




Index: linux/include/asm-ia64/machvec.h
===================================================================
--- linux.orig/include/asm-ia64/machvec.h
+++ linux/include/asm-ia64/machvec.h
@@ -69,12 +69,20 @@ typedef unsigned short ia64_mv_readw_rel
 typedef unsigned int ia64_mv_readl_relaxed_t (void *);
 typedef unsigned long ia64_mv_readq_relaxed_t (void *);
 
-extern void machvec_noop (void);
 extern void machvec_setup (char **);
 extern void machvec_timer_interrupt (int, void *, struct pt_regs *);
 extern void machvec_dma_sync_single (struct device *, dma_addr_t, size_t, int);
 extern void machvec_dma_sync_sg (struct device *, struct scatterlist *, int, int);
 
+#ifdef CONFIG_IA64_GENERIC
+# define machvec_noop(noop_function)    noop_function
+#else
+# define machvec_null(...)
+# define machvec_noop(noop_function)	machvec_null
+#endif
+extern void machvec_noop_void (void);
+
+
 # if defined (CONFIG_IA64_HP_SIM)
 #  include <asm/machvec_hpsim.h>
 # elif defined (CONFIG_IA64_DIG)
@@ -245,10 +253,10 @@ extern ia64_mv_dma_supported		swiotlb_dm
 # define platform_setup			machvec_setup
 #endif
 #ifndef platform_cpu_init
-# define platform_cpu_init		machvec_noop
+# define platform_cpu_init		machvec_noop(machvec_noop_void)
 #endif
 #ifndef platform_irq_init
-# define platform_irq_init		machvec_noop
+# define platform_irq_init		machvec_noop(machvec_noop_void)
 #endif
 
 #ifndef platform_send_ipi
Index: linux/arch/ia64/kernel/machvec.c
===================================================================
--- linux.orig/arch/ia64/kernel/machvec.c
+++ linux/arch/ia64/kernel/machvec.c
@@ -44,10 +44,10 @@ machvec_init (const char *name)
 #endif /* CONFIG_IA64_GENERIC */
 
 void
-machvec_noop (void)
+machvec_noop_void (void)
 {
 }
-EXPORT_SYMBOL(machvec_noop);
+EXPORT_SYMBOL(machvec_noop_void);
 
 void
 machvec_setup (char **arg)
Index: linux/include/asm-ia64/machvec_sn2.h
===================================================================
--- linux.orig/include/asm-ia64/machvec_sn2.h
+++ linux/include/asm-ia64/machvec_sn2.h
@@ -101,7 +101,7 @@ extern ia64_mv_dma_supported		sn_dma_sup
 #define platform_irq_desc		sn_irq_desc
 #define platform_irq_to_vector		sn_irq_to_vector
 #define platform_local_vector_to_irq	sn_local_vector_to_irq
-#define platform_dma_init		machvec_noop
+#define platform_dma_init		machvec_noop_void
 #define platform_dma_alloc_coherent	sn_dma_alloc_coherent
 #define platform_dma_free_coherent	sn_dma_free_coherent
 #define platform_dma_map_single		sn_dma_map_single
Index: linux/include/asm-ia64/machvec_hpzx1.h
===================================================================
--- linux.orig/include/asm-ia64/machvec_hpzx1.h
+++ linux/include/asm-ia64/machvec_hpzx1.h
@@ -21,7 +21,7 @@ extern ia64_mv_dma_mapping_error	sba_dma
  */
 #define platform_name			"hpzx1"
 #define platform_setup			sba_setup
-#define platform_dma_init		machvec_noop
+#define platform_dma_init		machvec_noop_void
 #define platform_dma_alloc_coherent	sba_alloc_coherent
 #define platform_dma_free_coherent	sba_free_coherent
 #define platform_dma_map_single		sba_map_single


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWDXPEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWDXPEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWDXPEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:04:00 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:14927 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750860AbWDXPDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:03:46 -0400
Date: Mon, 24 Apr 2006 17:03:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, aherrman@de.ibm.com
Subject: [patch 5/13] s390: qdio memory allocations.
Message-ID: <20060424150348.GF15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Herrmann <aherrman@de.ibm.com>

[patch 5/13] s390: qdio memory allocations.

Avoid memory allocation with GFP_KERNEL in qdio_establish/qdio_shutdown.
Use memory pool instead. (Otherwise this can lead to an I/O stall where
qdio waits for a free page and zfcp waits for end of error recovery in low
memory situations.)

Signed-off-by: Andreas Herrmann <aherrman@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-04-24 16:47:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-04-24 16:47:22.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
 #include <linux/timer.h>
+#include <linux/mempool.h>
 
 #include <asm/ccwdev.h>
 #include <asm/io.h>
@@ -80,6 +81,8 @@ static int indicator_used[INDICATORS_PER
 static __u32 * volatile indicators;
 static __u32 volatile spare_indicator;
 static atomic_t spare_indicator_usecount;
+#define QDIO_MEMPOOL_SCSSC_ELEMENTS 2
+static mempool_t *qdio_mempool_scssc;
 
 static debug_info_t *qdio_dbf_setup;
 static debug_info_t *qdio_dbf_sbal;
@@ -2304,7 +2307,7 @@ qdio_get_ssqd_information(struct qdio_ir
 
 	QDIO_DBF_TEXT0(0,setup,"getssqd");
 	qdioac = 0;
-	ssqd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	ssqd_area = mempool_alloc(qdio_mempool_scssc, GFP_ATOMIC);
 	if (!ssqd_area) {
 	        QDIO_PRINT_WARN("Could not get memory for chsc. Using all " \
 				"SIGAs for sch x%x.\n", irq_ptr->schid.sch_no);
@@ -2364,7 +2367,7 @@ qdio_get_ssqd_information(struct qdio_ir
 out:
 	qdio_check_subchannel_qebsm(irq_ptr, qdioac,
 				    ssqd_area->sch_token);
-	free_page ((unsigned long) ssqd_area);
+	mempool_free(ssqd_area, qdio_mempool_scssc);
 	irq_ptr->qdioac = qdioac;
 }
 
@@ -2458,7 +2461,7 @@ tiqdio_set_subchannel_ind(struct qdio_ir
 			virt_to_phys((volatile void *)irq_ptr->dev_st_chg_ind);
 	}
 
-	scssc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	scssc_area = mempool_alloc(qdio_mempool_scssc, GFP_ATOMIC);
 	if (!scssc_area) {
 		QDIO_PRINT_WARN("No memory for setting indicators on " \
 				"subchannel 0.%x.%x.\n",
@@ -2514,7 +2517,7 @@ tiqdio_set_subchannel_ind(struct qdio_ir
 	QDIO_DBF_HEX2(0,setup,&real_addr_dev_st_chg_ind,sizeof(unsigned long));
 	result = 0;
 out:
-	free_page ((unsigned long) scssc_area);
+	mempool_free(scssc_area, qdio_mempool_scssc);
 	return result;
 
 }
@@ -2543,7 +2546,7 @@ tiqdio_set_delay_target(struct qdio_irq 
 	if (!irq_ptr->is_thinint_irq)
 		return -ENODEV;
 
-	scsscf_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	scsscf_area = mempool_alloc(qdio_mempool_scssc, GFP_ATOMIC);
 	if (!scsscf_area) {
 		QDIO_PRINT_WARN("No memory for setting delay target on " \
 				"subchannel 0.%x.%x.\n",
@@ -2581,7 +2584,7 @@ tiqdio_set_delay_target(struct qdio_irq 
 	QDIO_DBF_HEX2(0,trace,&delay_target,sizeof(unsigned long));
 	result = 0; /* not critical */
 out:
-	free_page ((unsigned long) scsscf_area);
+	mempool_free(scsscf_area, qdio_mempool_scssc);
 	return result;
 }
 
@@ -3780,6 +3783,16 @@ oom:
 	return -ENOMEM;
 }
 
+static void *qdio_mempool_alloc(gfp_t gfp_mask, void *size)
+{
+	return (void *) get_zeroed_page(gfp_mask|GFP_DMA);
+}
+
+static void qdio_mempool_free(void *element, void *size)
+{
+	free_page((unsigned long) element);
+}
+
 static int __init
 init_QDIO(void)
 {
@@ -3809,6 +3822,10 @@ init_QDIO(void)
 
 	qdio_add_procfs_entry();
 
+	qdio_mempool_scssc = mempool_create(QDIO_MEMPOOL_SCSSC_ELEMENTS,
+					    qdio_mempool_alloc,
+					    qdio_mempool_free, NULL);
+
 	if (tiqdio_check_chsc_availability())
 		QDIO_PRINT_ERR("Not all CHSCs supported. Continuing.\n");
 
@@ -3824,6 +3841,7 @@ cleanup_QDIO(void)
 	qdio_remove_procfs_entry();
 	qdio_release_qdio_memory();
 	qdio_unregister_dbf_views();
+	mempool_destroy(qdio_mempool_scssc);
 
   	printk("qdio: %s: module removed\n",version);
 }

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUIBKto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUIBKto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268243AbUIBKti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:49:38 -0400
Received: from ozlabs.org ([203.10.76.45]:56975 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268223AbUIBKq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:46:57 -0400
Date: Thu, 2 Sep 2004 20:41:48 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, olof@austin.ibm.com
Subject: [PATCH] [ppc64] Make use of batched IOMMU calls on pSeries LPARs
Message-ID: <20040902104148.GZ26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olof Johansson <olof@austin.ibm.com>

Implement the HCALLs to do more than one TCE setup or invalidation at
a time on pSeries LPAR. Previous implementation did one hypervisor call
per setup or teardown, resulting in significant overhead.

A simple test of "time dd if=/dev/sda of=/dev/null bs=128k" shows the
amount of system time go down by about 5% by using the multi-tce calls.

Signed-off-by: Olof Johansson <olof@austin.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/pSeries_lpar.c~tce-multi arch/ppc64/kernel/pSeries_lpar.c
--- linux-2.5/arch/ppc64/kernel/pSeries_lpar.c~tce-multi	2004-09-01 22:32:56.479947032 -0500
+++ linux-2.5-olof/arch/ppc64/kernel/pSeries_lpar.c	2004-09-01 23:24:00.589955024 -0500
@@ -112,6 +112,22 @@ long plpar_tce_put(unsigned long liobn,
 	return plpar_hcall_norets(H_PUT_TCE, liobn, ioba, tceval);
 }
 
+long plpar_tce_put_indirect(unsigned long liobn,
+	  		    unsigned long ioba,
+			    unsigned long page,
+			    unsigned long count)
+{
+	return plpar_hcall_norets(H_PUT_TCE_INDIRECT, liobn, ioba, page, count);
+}
+
+long plpar_tce_stuff(unsigned long liobn,
+		     unsigned long ioba,
+		     unsigned long tceval,
+		     unsigned long count)
+{
+	return plpar_hcall_norets(H_STUFF_TCE, liobn, ioba, tceval, count);
+}
+
 long plpar_get_term_char(unsigned long termno,
 			 unsigned long *len_ret,
 			 char *buf_ret)
@@ -161,6 +177,71 @@ static void tce_build_pSeriesLP(struct i
 	}
 }
 
+DEFINE_PER_CPU(void *, tce_page) = NULL;
+
+static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
+		long npages, unsigned long uaddr,
+		enum dma_data_direction direction)
+{
+	u64 rc;
+	union tce_entry tce, *tcep;
+	long l, limit;
+
+	if (npages == 1)
+		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
+					   direction);
+
+	tcep = __get_cpu_var(tce_page);
+
+	/* This is safe to do since interrupts are off when we're called
+	 * from iommu_alloc{,_sg}()
+	 */
+	if (!tcep) {
+		tcep = (void *)__get_free_page(GFP_ATOMIC);
+		/* If allocation fails, fall back to the loop implementation */
+		if (!tcep)
+			return tce_build_pSeriesLP(tbl, tcenum, npages,
+						   uaddr, direction);
+		__get_cpu_var(tce_page) = tcep;
+	}
+
+	tce.te_word = 0;
+	tce.te_rpn = (virt_to_abs(uaddr)) >> PAGE_SHIFT;
+	tce.te_rdwr = 1;
+	if (direction != DMA_TO_DEVICE)
+		tce.te_pciwr = 1;
+
+	/* We can map max one pageful of TCEs at a time */
+	do {
+		/*
+		 * Set up the page with TCE data, looping through and setting
+		 * the values.
+		 */
+		limit = min_t(long, npages, PAGE_SIZE/sizeof(union tce_entry));
+
+		for (l = 0; l < limit; l++) {
+			tcep[l] = tce;
+			tce.te_rpn++;
+		}
+
+		rc = plpar_tce_put_indirect((u64)tbl->it_index,
+					    (u64)tcenum << 12,
+					    (u64)virt_to_abs(tcep),
+					    limit);
+
+		npages -= limit;
+		tcenum += limit;
+	} while (npages > 0 && !rc);
+
+	if (rc && printk_ratelimit()) {
+		printk("tce_buildmulti_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
+		printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
+		printk("\tnpages  = 0x%lx\n", (u64)npages);
+		printk("\ttce[0] val = 0x%lx\n", tcep[0].te_word);
+		show_stack(current, (unsigned long *)__get_SP());
+	}
+}
+
 static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
 {
 	u64 rc;
@@ -169,23 +250,45 @@ static void tce_free_pSeriesLP(struct io
 	tce.te_word = 0;
 
 	while (npages--) {
-		rc = plpar_tce_put((u64)tbl->it_index, 
+		rc = plpar_tce_put((u64)tbl->it_index,
 				   (u64)tcenum << 12,
-				   tce.te_word );
-		
+				   tce.te_word);
+
 		if (rc && printk_ratelimit()) {
-			printk("tce_free_pSeriesLP: plpar_tce_put failed\n");
-			printk("\trc      = %ld\n", rc);
+			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
 			printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
 			printk("\ttcenum  = 0x%lx\n", (u64)tcenum);
 			printk("\ttce val = 0x%lx\n", tce.te_word );
 			show_stack(current, (unsigned long *)__get_SP());
 		}
-		
+
 		tcenum++;
 	}
 }
 
+
+static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
+{
+	u64 rc;
+	union tce_entry tce;
+
+	tce.te_word = 0;
+
+	rc = plpar_tce_stuff((u64)tbl->it_index,
+			   (u64)tcenum << 12,
+			   tce.te_word,
+			   npages);
+
+	if (rc && printk_ratelimit()) {
+		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
+		printk("\trc      = %ld\n", rc);
+		printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
+		printk("\tnpages  = 0x%lx\n", (u64)npages);
+		printk("\ttce val = 0x%lx\n", tce.te_word );
+		show_stack(current, (unsigned long *)__get_SP());
+	}
+}
+
 int vtermno;	/* virtual terminal# for udbg  */
 
 static void udbg_putcLP(unsigned char c)
@@ -315,8 +418,13 @@ void pSeriesLP_init_early(void)
 
 	tce_init_pSeries();
 
-	ppc_md.tce_build = tce_build_pSeriesLP;
-	ppc_md.tce_free	 = tce_free_pSeriesLP;
+	if (cur_cpu_spec->firmware_features & FW_FEATURE_MULTITCE) {
+		ppc_md.tce_build = tce_buildmulti_pSeriesLP;
+		ppc_md.tce_free	 = tce_freemulti_pSeriesLP;
+	} else {
+		ppc_md.tce_build = tce_build_pSeriesLP;
+		ppc_md.tce_free	 = tce_free_pSeriesLP;
+	}
 
 	pci_iommu_init();
 
@@ -461,7 +569,7 @@ static unsigned long pSeries_lpar_hpte_g
 	/* Do not need RPN to logical page translation */
 	/* No cross CEC PFT access                     */
 	flags = 0;
-	
+
 	lpar_rc = plpar_pte_read(flags, slot, &dword0, &dummy_word1);
 
 	BUG_ON(lpar_rc != H_Success);
diff -puN include/asm-ppc64/hvcall.h~tce-multi include/asm-ppc64/hvcall.h
--- linux-2.5/include/asm-ppc64/hvcall.h~tce-multi	2004-09-01 22:32:56.481946728 -0500
+++ linux-2.5-olof/include/asm-ppc64/hvcall.h	2004-09-01 22:32:56.487945816 -0500
@@ -101,10 +101,12 @@
 #define H_VIO_SIGNAL		0x104
 #define H_SEND_CRQ		0x108
 #define H_COPY_RDMA             0x110
-#define H_POLL_PENDING	        0x1D8
+#define H_STUFF_TCE		0x138
+#define H_PUT_TCE_INDIRECT	0x13C
 #define H_VTERM_PARTNER_INFO	0x150
-#define H_REGISTER_VTERM		0x154
-#define H_FREE_VTERM			0x158
+#define H_REGISTER_VTERM	0x154
+#define H_FREE_VTERM		0x158
+#define H_POLL_PENDING	        0x1D8
 
 /* plpar_hcall() -- Generic call interface using above opcodes
  *

_


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTE2P5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTE2P5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:57:09 -0400
Received: from relax.cmf.nrl.navy.mil ([134.207.10.227]:384 "EHLO
	relax.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262319AbTE2P4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:56:36 -0400
Date: Thu, 29 May 2003 12:09:54 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
Message-Id: <200305291609.h4TG9rx01188@relax.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] assorted he driver cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the three following changesets attempt to bring the he atm
driver into conformance with the accepted linux coding style,
fix some chattiness the irq handler, and address the stack
usage issue in he_init_cs_block_rcm().


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1158  -> 1.1159 
#	    drivers/atm/he.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/23	chas@relax.cmf.nrl.navy.mil	1.1159
# he coding style conformance
# --------------------------------------------
#
diff -Nru a/drivers/atm/he.c b/drivers/atm/he.c
--- a/drivers/atm/he.c	Thu May 29 11:48:40 2003
+++ b/drivers/atm/he.c	Thu May 29 11:48:40 2003
@@ -132,9 +132,9 @@
 
 #undef DEBUG
 #ifdef DEBUG
-#define HPRINTK(fmt,args...)	hprintk(fmt,args)
+#define HPRINTK(fmt,args...)	printk(KERN_DEBUG DEV_LABEL "%d: " fmt, he_dev->number , ##args)
 #else
-#define HPRINTK(fmt,args...)	do { } while(0)
+#define HPRINTK(fmt,args...)	do { } while (0)
 #endif /* DEBUG */
 
 
@@ -179,9 +179,7 @@
    phy_put:	he_phy_put,
    phy_get:	he_phy_get,
    proc_read:	he_proc_read,
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,1)
    owner:	THIS_MODULE
-#endif
 };
 
 /* see the comments in he.h about global_lock */
@@ -189,7 +187,7 @@
 #define HE_SPIN_LOCK(dev, flags)	spin_lock_irqsave(&(dev)->global_lock, flags)
 #define HE_SPIN_UNLOCK(dev, flags)	spin_unlock_irqrestore(&(dev)->global_lock, flags)
 
-#define he_writel(dev, val, reg)	do { writel(val, (dev)->membase + (reg)); wmb(); } while(0)
+#define he_writel(dev, val, reg)	do { writel(val, (dev)->membase + (reg)); wmb(); } while (0)
 #define he_readl(dev, reg)		readl((dev)->membase + (reg))
 
 /* section 2.12 connection memory access */
@@ -203,7 +201,7 @@
 	(void) he_readl(he_dev, CON_DAT);
 #endif
 	he_writel(he_dev, flags | CON_CTL_WRITE | CON_CTL_ADDR(addr), CON_CTL);
-	while(he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
+	while (he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
 }
 
 #define he_writel_rcm(dev, val, reg) 				\
@@ -219,7 +217,7 @@
 he_readl_internal(struct he_dev *he_dev, unsigned addr, unsigned flags)
 {
 	he_writel(he_dev, flags | CON_CTL_READ | CON_CTL_ADDR(addr), CON_CTL);
-	while(he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
+	while (he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
 	return he_readl(he_dev, CON_DAT);
 }
 
@@ -374,7 +372,8 @@
 
 	printk(KERN_INFO "he: %s\n", version);
 
-	if (pci_enable_device(pci_dev)) return -EIO;
+	if (pci_enable_device(pci_dev))
+		return -EIO;
 	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0) {
 		printk(KERN_WARNING "he: no suitable dma available\n");
 		err = -EIO;
@@ -407,7 +406,8 @@
 		goto init_one_failure;
 	}
 	he_dev->next = NULL;
-	if (he_devs) he_dev->next = he_devs;
+	if (he_devs)
+		he_dev->next = he_devs;
 	he_devs = he_dev;
 	return 0;
 
@@ -447,11 +447,11 @@
 
         unsigned exp = 0;
 
-        if (rate == 0) return(0);
+        if (rate == 0)
+		return(0);
 
         rate <<= 9;
-        while (rate > 0x3ff)
-        {
+        while (rate > 0x3ff) {
                 ++exp;
                 rate >>= 1;
         }
@@ -472,16 +472,14 @@
 
 	he_writel(he_dev, lbufd_index, RLBF0_H);
 
-        for (i = 0, lbuf_count = 0; i < he_dev->r0_numbuffs; ++i)
-        {
+        for (i = 0, lbuf_count = 0; i < he_dev->r0_numbuffs; ++i) {
 		lbufd_index += 2;
                 lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
 
 		he_writel_rcm(he_dev, lbuf_addr, lbm_offset);
 		he_writel_rcm(he_dev, lbufd_index, lbm_offset + 1);
 
-                if (++lbuf_count == lbufs_per_row)
-                {
+                if (++lbuf_count == lbufs_per_row) {
                         lbuf_count = 0;
                         row_offset += he_dev->bytes_per_row;
                 }
@@ -505,16 +503,14 @@
 
 	he_writel(he_dev, lbufd_index, RLBF1_H);
 
-        for (i = 0, lbuf_count = 0; i < he_dev->r1_numbuffs; ++i)
-        {
+        for (i = 0, lbuf_count = 0; i < he_dev->r1_numbuffs; ++i) {
 		lbufd_index += 2;
                 lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
 
 		he_writel_rcm(he_dev, lbuf_addr, lbm_offset);
 		he_writel_rcm(he_dev, lbufd_index, lbm_offset + 1);
 
-                if (++lbuf_count == lbufs_per_row)
-                {
+                if (++lbuf_count == lbufs_per_row) {
                         lbuf_count = 0;
                         row_offset += he_dev->bytes_per_row;
                 }
@@ -538,16 +534,14 @@
 
 	he_writel(he_dev, lbufd_index, TLBF_H);
 
-        for (i = 0, lbuf_count = 0; i < he_dev->tx_numbuffs; ++i)
-        {
+        for (i = 0, lbuf_count = 0; i < he_dev->tx_numbuffs; ++i) {
 		lbufd_index += 1;
                 lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
 
 		he_writel_rcm(he_dev, lbuf_addr, lbm_offset);
 		he_writel_rcm(he_dev, lbufd_index, lbm_offset + 1);
 
-                if (++lbuf_count == lbufs_per_row)
-                {
+                if (++lbuf_count == lbufs_per_row) {
                         lbuf_count = 0;
                         row_offset += he_dev->bytes_per_row;
                 }
@@ -562,8 +556,7 @@
 {
 	he_dev->tpdrq_base = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_TPDRQ_SIZE * sizeof(struct he_tpdrq), &he_dev->tpdrq_phys);
-	if (he_dev->tpdrq_base == NULL) 
-	{
+	if (he_dev->tpdrq_base == NULL) {
 		hprintk("failed to alloc tpdrq\n");
 		return -ENOMEM;
 	}
@@ -588,7 +581,7 @@
 
 	/* 5.1.7 cs block initialization */
 
-	for(reg = 0; reg < 0x20; ++reg)
+	for (reg = 0; reg < 0x20; ++reg)
 		he_writel_mbox(he_dev, 0x0, CS_STTIM0 + reg);
 
 	/* rate grid timer reload values */
@@ -597,8 +590,7 @@
 	rate = he_dev->atm_dev->link_rate;
 	delta = rate / 16 / 2;
 
-	for(reg = 0; reg < 0x10; ++reg)
-	{
+	for (reg = 0; reg < 0x10; ++reg) {
 		/* 2.4 internal transmit function
 		 *
 	 	 * we initialize the first row in the rate grid.
@@ -610,8 +602,7 @@
 		rate -= delta;
 	}
 
-	if (he_is622(he_dev))
-	{
+	if (he_is622(he_dev)) {
 		/* table 5.2 (4 cells per lbuf) */
 		he_writel_mbox(he_dev, 0x000800fa, CS_ERTHR0);
 		he_writel_mbox(he_dev, 0x000c33cb, CS_ERTHR1);
@@ -640,9 +631,7 @@
 		/* table 5.9 */
 		he_writel_mbox(he_dev, 0x5, CS_OTPPER);
 		he_writel_mbox(he_dev, 0x14, CS_OTWPER);
-	}
-	else
-	{
+	} else {
 		/* table 5.1 (4 cells per lbuf) */
 		he_writel_mbox(he_dev, 0x000400ea, CS_ERTHR0);
 		he_writel_mbox(he_dev, 0x00063388, CS_ERTHR1);
@@ -671,12 +660,11 @@
 		/* table 5.9 */
 		he_writel_mbox(he_dev, 0x6, CS_OTPPER);
 		he_writel_mbox(he_dev, 0x1e, CS_OTWPER);
-
 	}
 
 	he_writel_mbox(he_dev, 0x8, CS_OTTLIM);
 
-	for(reg = 0; reg < 0x8; ++reg)
+	for (reg = 0; reg < 0x8; ++reg)
 		he_writel_mbox(he_dev, 0x0, CS_HGRRT0 + reg);
 
 }
@@ -720,8 +708,7 @@
 	 * in order to construct the rate to group table below
 	 */
 
-	for (j = 0; j < 16; j++)
-	{
+	for (j = 0; j < 16; j++) {
 		rategrid[0][j] = rate;
 		rate -= delta;
 	}
@@ -742,8 +729,7 @@
 	 */
 
 	rate_atmf = 0;
-	while (rate_atmf < 0x400)
-	{
+	while (rate_atmf < 0x400) {
 		man = (rate_atmf & 0x1f) << 4;
 		exp = rate_atmf >> 5;
 
@@ -753,12 +739,12 @@
 		*/
 		rate_cps = (unsigned long long) (1 << exp) * (man + 512) >> 9;
 
-		if (rate_cps < 10) rate_cps = 10;
-				/* 2.2.1 minimum payload rate is 10 cps */
+		if (rate_cps < 10)
+			rate_cps = 10;	/* 2.2.1 minimum payload rate is 10 cps */
 
 		for (i = 255; i > 0; i--)
-			if (rategrid[i/16][i%16] >= rate_cps) break;
-				/* pick nearest rate instead? */
+			if (rategrid[i/16][i%16] >= rate_cps)
+				break;	 /* pick nearest rate instead? */
 
 		/*
 		 * each table entry is 16 bits: (rate grid index (8 bits)
@@ -773,12 +759,17 @@
 		/* this is pretty, but avoids _divdu3 and is mostly correct */
                 buf = 0;
                 mult = he_dev->atm_dev->link_rate / ATM_OC3_PCR;
-                if (rate_cps > (68 * mult)) buf = 1;
-                if (rate_cps > (136 * mult)) buf = 2;
-                if (rate_cps > (204 * mult)) buf = 3;
-                if (rate_cps > (272 * mult)) buf = 4;
+                if (rate_cps > (68 * mult))
+			buf = 1;
+                if (rate_cps > (136 * mult))
+			buf = 2;
+                if (rate_cps > (204 * mult))
+			buf = 3;
+                if (rate_cps > (272 * mult))
+			buf = 4;
 #endif
-                if (buf > buf_limit) buf = buf_limit;
+                if (buf > buf_limit)
+			buf = buf_limit;
 		reg = (reg<<16) | ((i<<8) | buf);
 
 #define RTGTBL_OFFSET 0x400
@@ -801,8 +792,7 @@
 #ifdef USE_RBPS_POOL
 	he_dev->rbps_pool = pci_pool_create("rbps", he_dev->pci_dev,
 			CONFIG_RBPS_BUFSIZE, 8, 0);
-	if (he_dev->rbps_pool == NULL)
-	{
+	if (he_dev->rbps_pool == NULL) {
 		hprintk("unable to create rbps pages\n");
 		return -ENOMEM;
 	}
@@ -817,16 +807,14 @@
 
 	he_dev->rbps_base = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_RBPS_SIZE * sizeof(struct he_rbp), &he_dev->rbps_phys);
-	if (he_dev->rbps_base == NULL)
-	{
+	if (he_dev->rbps_base == NULL) {
 		hprintk("failed to alloc rbps\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->rbps_base, 0, CONFIG_RBPS_SIZE * sizeof(struct he_rbp));
 	he_dev->rbps_virt = kmalloc(CONFIG_RBPS_SIZE * sizeof(struct he_virt), GFP_KERNEL);
 
-	for (i = 0; i < CONFIG_RBPS_SIZE; ++i)
-	{
+	for (i = 0; i < CONFIG_RBPS_SIZE; ++i) {
 		dma_addr_t dma_handle;
 		void *cpuaddr;
 
@@ -868,16 +856,14 @@
 #ifdef USE_RBPL_POOL
 	he_dev->rbpl_pool = pci_pool_create("rbpl", he_dev->pci_dev,
 			CONFIG_RBPL_BUFSIZE, 8, 0);
-	if (he_dev->rbpl_pool == NULL)
-	{
+	if (he_dev->rbpl_pool == NULL) {
 		hprintk("unable to create rbpl pool\n");
 		return -ENOMEM;
 	}
 #else /* !USE_RBPL_POOL */
 	he_dev->rbpl_pages = (void *) pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_RBPL_SIZE * CONFIG_RBPL_BUFSIZE, &he_dev->rbpl_pages_phys);
-	if (he_dev->rbpl_pages == NULL)
-	{
+	if (he_dev->rbpl_pages == NULL) {
 		hprintk("unable to create rbpl pages\n");
 		return -ENOMEM;
 	}
@@ -885,16 +871,14 @@
 
 	he_dev->rbpl_base = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_RBPL_SIZE * sizeof(struct he_rbp), &he_dev->rbpl_phys);
-	if (he_dev->rbpl_base == NULL)
-	{
+	if (he_dev->rbpl_base == NULL) {
 		hprintk("failed to alloc rbpl\n");
 		return -ENOMEM;
 	}
 	memset(he_dev->rbpl_base, 0, CONFIG_RBPL_SIZE * sizeof(struct he_rbp));
 	he_dev->rbpl_virt = kmalloc(CONFIG_RBPL_SIZE * sizeof(struct he_virt), GFP_KERNEL);
 
-	for (i = 0; i < CONFIG_RBPL_SIZE; ++i)
-	{
+	for (i = 0; i < CONFIG_RBPL_SIZE; ++i) {
 		dma_addr_t dma_handle;
 		void *cpuaddr;
 
@@ -910,7 +894,6 @@
 		he_dev->rbpl_virt[i].virt = cpuaddr;
 		he_dev->rbpl_base[i].status = RBP_LOANED | (i << RBP_INDEX_OFF);
 		he_dev->rbpl_base[i].phys = dma_handle;
-
 	}
 	he_dev->rbpl_tail = &he_dev->rbpl_base[CONFIG_RBPL_SIZE-1];
 
@@ -929,8 +912,7 @@
 
 	he_dev->rbrq_base = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_RBRQ_SIZE * sizeof(struct he_rbrq), &he_dev->rbrq_phys);
-	if (he_dev->rbrq_base == NULL)
-	{
+	if (he_dev->rbrq_base == NULL) {
 		hprintk("failed to allocate rbrq\n");
 		return -ENOMEM;
 	}
@@ -942,13 +924,11 @@
 	he_writel(he_dev,
 		RBRQ_THRESH(CONFIG_RBRQ_THRESH) | RBRQ_SIZE(CONFIG_RBRQ_SIZE-1),
 						G0_RBRQ_Q + (group * 16));
-	if (irq_coalesce)
-	{
+	if (irq_coalesce) {
 		hprintk("coalescing interrupts\n");
 		he_writel(he_dev, RBRQ_TIME(768) | RBRQ_COUNT(7),
 						G0_RBRQ_I + (group * 16));
-	}
-	else
+	} else
 		he_writel(he_dev, RBRQ_TIME(0) | RBRQ_COUNT(1),
 						G0_RBRQ_I + (group * 16));
 
@@ -956,8 +936,7 @@
 
 	he_dev->tbrq_base = pci_alloc_consistent(he_dev->pci_dev,
 		CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq), &he_dev->tbrq_phys);
-	if (he_dev->tbrq_base == NULL)
-	{
+	if (he_dev->tbrq_base == NULL) {
 		hprintk("failed to allocate tbrq\n");
 		return -ENOMEM;
 	}
@@ -983,8 +962,7 @@
 
         he_dev->irq_base = pci_alloc_consistent(he_dev->pci_dev,
 			(CONFIG_IRQ_SIZE+1) * sizeof(struct he_irq), &he_dev->irq_phys);
-	if (he_dev->irq_base == NULL)
-	{
+	if (he_dev->irq_base == NULL) {
 		hprintk("failed to allocate irq\n");
 		return -ENOMEM;
 	}
@@ -994,7 +972,7 @@
 	he_dev->irq_head = he_dev->irq_base;
 	he_dev->irq_tail = he_dev->irq_base;
 
-	for(i=0; i < CONFIG_IRQ_SIZE; ++i)
+	for (i=0; i < CONFIG_IRQ_SIZE; ++i)
 		he_dev->irq_base[i].isw = ITYPE_INVALID;
 
 	he_writel(he_dev, he_dev->irq_phys, IRQ0_BASE);
@@ -1026,8 +1004,7 @@
 	he_writel(he_dev, 0x0, GRP_54_MAP);
 	he_writel(he_dev, 0x0, GRP_76_MAP);
 
-	if (request_irq(he_dev->pci_dev->irq, he_irq_handler, SA_INTERRUPT|SA_SHIRQ, DEV_LABEL, he_dev))
-	{
+	if (request_irq(he_dev->pci_dev->irq, he_irq_handler, SA_INTERRUPT|SA_SHIRQ, DEV_LABEL, he_dev)) {
 		hprintk("irq %d already in use\n", he_dev->pci_dev->irq);
 		return -EINVAL;
         }   
@@ -1067,46 +1044,39 @@
 	 */
 
 	/* 4.3 pci bus controller-specific initialization */
-	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0)
-	{
+	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0) {
 		hprintk("can't read GEN_CNTL_0\n");
 		return -EINVAL;
 	}
 	gen_cntl_0 |= (MRL_ENB | MRM_ENB | IGNORE_TIMEOUT);
-	if (pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0) != 0)
-	{
+	if (pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0) != 0) {
 		hprintk("can't write GEN_CNTL_0.\n");
 		return -EINVAL;
 	}
 
-	if (pci_read_config_word(pci_dev, PCI_COMMAND, &command) != 0)
-	{
+	if (pci_read_config_word(pci_dev, PCI_COMMAND, &command) != 0) {
 		hprintk("can't read PCI_COMMAND.\n");
 		return -EINVAL;
 	}
 
 	command |= (PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE);
-	if (pci_write_config_word(pci_dev, PCI_COMMAND, command) != 0)
-	{
+	if (pci_write_config_word(pci_dev, PCI_COMMAND, command) != 0) {
 		hprintk("can't enable memory.\n");
 		return -EINVAL;
 	}
 
-	if (pci_read_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, &cache_size))
-	{
+	if (pci_read_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, &cache_size)) {
 		hprintk("can't read cache line size?\n");
 		return -EINVAL;
 	}
 
-	if (cache_size < 16)
-	{
+	if (cache_size < 16) {
 		cache_size = 16;
 		if (pci_write_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, cache_size))
 			hprintk("can't set cache line size to %d\n", cache_size);
 	}
 
-	if (pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER, &timer))
-	{
+	if (pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER, &timer)) {
 		hprintk("can't read latency timer?\n");
 		return -EINVAL;
 	}
@@ -1120,8 +1090,7 @@
 	 *
 	 */ 
 #define LAT_TIMER 209
-	if (timer < LAT_TIMER)
-	{
+	if (timer < LAT_TIMER) {
 		HPRINTK("latency timer was %d, setting to %d\n", timer, LAT_TIMER);
 		timer = LAT_TIMER;
 		if (pci_write_config_byte(pci_dev, PCI_LATENCY_TIMER, timer))
@@ -1139,8 +1108,7 @@
 
 	udelay(16*1000);	/* 16 ms */
 	status = he_readl(he_dev, RESET_CNTL);
-	if ((status & BOARD_RST_STATUS) == 0)
-	{
+	if ((status & BOARD_RST_STATUS) == 0) {
 		hprintk("reset failed\n");
 		return -EINVAL;
 	}
@@ -1152,23 +1120,23 @@
 	else
 		gen_cntl_0 &= ~ENBL_64;
 
-	if (disable64 == 1)
-	{
+	if (disable64 == 1) {
 		hprintk("disabling 64-bit pci bus transfers\n");
 		gen_cntl_0 &= ~ENBL_64;
 	}
 
-	if (gen_cntl_0 & ENBL_64) hprintk("64-bit transfers enabled\n");
+	if (gen_cntl_0 & ENBL_64)
+		hprintk("64-bit transfers enabled\n");
 
 	pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0);
 
 	/* 4.7 read prom contents */
-	for(i=0; i<PROD_ID_LEN; ++i)
+	for (i=0; i<PROD_ID_LEN; ++i)
 		he_dev->prod_id[i] = read_prom_byte(he_dev, PROD_ID + i);
 
 	he_dev->media = read_prom_byte(he_dev, MEDIA);
 
-	for(i=0; i<6; ++i)
+	for (i=0; i<6; ++i)
 		dev->esi[i] = read_prom_byte(he_dev, MAC_ADDR + i);
 
 	hprintk("%s%s, %x:%x:%x:%x:%x:%x\n",
@@ -1205,7 +1173,8 @@
 	he_writel(he_dev, lb_swap, LB_SWAP);
 
 	/* 4.10 initialize the interrupt queues */
-	if ((err = he_init_irq(he_dev)) != 0) return err;
+	if ((err = he_init_irq(he_dev)) != 0)
+		return err;
 
 #ifdef USE_TASKLET
 	tasklet_init(&he_dev->tasklet, he_tasklet, (unsigned long) he_dev);
@@ -1258,27 +1227,23 @@
 	he_dev->vcibits = CONFIG_DEFAULT_VCIBITS;
 	he_dev->vpibits = CONFIG_DEFAULT_VPIBITS;
 
-	if (nvpibits != -1 && nvcibits != -1 && nvpibits+nvcibits != HE_MAXCIDBITS)
-	{
+	if (nvpibits != -1 && nvcibits != -1 && nvpibits+nvcibits != HE_MAXCIDBITS) {
 		hprintk("nvpibits + nvcibits != %d\n", HE_MAXCIDBITS);
 		return -ENODEV;
 	}
 
-	if (nvpibits != -1)
-	{
+	if (nvpibits != -1) {
 		he_dev->vpibits = nvpibits;
 		he_dev->vcibits = HE_MAXCIDBITS - nvpibits;
 	}
 
-	if (nvcibits != -1)
-	{
+	if (nvcibits != -1) {
 		he_dev->vcibits = nvcibits;
 		he_dev->vpibits = HE_MAXCIDBITS - nvcibits;
 	}
 
 
-	if (he_is622(he_dev))
-	{
+	if (he_is622(he_dev)) {
 		he_dev->cells_per_row = 40;
 		he_dev->bytes_per_row = 2048;
 		he_dev->r0_numrows = 256;
@@ -1287,9 +1252,7 @@
 		he_dev->r0_startrow = 0;
 		he_dev->tx_startrow = 256;
 		he_dev->r1_startrow = 768;
-	}
-	else
-	{
+	} else {
 		he_dev->cells_per_row = 20;
 		he_dev->bytes_per_row = 1024;
 		he_dev->r0_numrows = 512;
@@ -1304,15 +1267,18 @@
 	he_dev->buffer_limit = 4;
 	he_dev->r0_numbuffs = he_dev->r0_numrows *
 				he_dev->cells_per_row / he_dev->cells_per_lbuf;
-	if (he_dev->r0_numbuffs > 2560) he_dev->r0_numbuffs = 2560;
+	if (he_dev->r0_numbuffs > 2560)
+		he_dev->r0_numbuffs = 2560;
 
 	he_dev->r1_numbuffs = he_dev->r1_numrows *
 				he_dev->cells_per_row / he_dev->cells_per_lbuf;
-	if (he_dev->r1_numbuffs > 2560) he_dev->r1_numbuffs = 2560;
+	if (he_dev->r1_numbuffs > 2560)
+		he_dev->r1_numbuffs = 2560;
 
 	he_dev->tx_numbuffs = he_dev->tx_numrows *
 				he_dev->cells_per_row / he_dev->cells_per_lbuf;
-	if (he_dev->tx_numbuffs > 5120) he_dev->tx_numbuffs = 5120;
+	if (he_dev->tx_numbuffs > 5120)
+		he_dev->tx_numbuffs = 5120;
 
 	/* 5.1.2 configure hardware dependent registers */
 
@@ -1355,10 +1321,10 @@
 
 	/* 5.1.3 initialize connection memory */
 
-	for(i=0; i < TCM_MEM_SIZE; ++i)
+	for (i=0; i < TCM_MEM_SIZE; ++i)
 		he_writel_tcm(he_dev, 0, i);
 
-	for(i=0; i < RCM_MEM_SIZE; ++i)
+	for (i=0; i < RCM_MEM_SIZE; ++i)
 		he_writel_rcm(he_dev, 0, i);
 
 	/*
@@ -1448,8 +1414,7 @@
 
 	/* 5.1.5 initialize intermediate receive queues */
 
-	if (he_is622(he_dev))
-	{
+	if (he_is622(he_dev)) {
 		he_writel(he_dev, 0x000f, G0_INMQ_S);
 		he_writel(he_dev, 0x200f, G0_INMQ_L);
 
@@ -1473,9 +1438,7 @@
 
 		he_writel(he_dev, 0x007f, G7_INMQ_S);
 		he_writel(he_dev, 0x207f, G7_INMQ_L);
-	}
-	else
-	{
+	} else {
 		he_writel(he_dev, 0x0000, G0_INMQ_S);
 		he_writel(he_dev, 0x0008, G0_INMQ_L);
 
@@ -1523,8 +1486,7 @@
 #ifdef USE_TPD_POOL
 	he_dev->tpd_pool = pci_pool_create("tpd", he_dev->pci_dev,
 		sizeof(struct he_tpd), TPD_ALIGNMENT, 0);
-	if (he_dev->tpd_pool == NULL)
-	{
+	if (he_dev->tpd_pool == NULL) {
 		hprintk("unable to create tpd pci_pool\n");
 		return -ENOMEM;         
 	}
@@ -1536,8 +1498,7 @@
 	if (!he_dev->tpd_base)
 		return -ENOMEM;
 
-	for(i = 0; i < CONFIG_NUMTPDS; ++i)
-	{
+	for (i = 0; i < CONFIG_NUMTPDS; ++i) {
 		he_dev->tpd_base[i].status = (i << TPD_ADDR_SHIFT);
 		he_dev->tpd_base[i].inuse = 0;
 	}
@@ -1549,8 +1510,7 @@
 	if (he_init_group(he_dev, 0) != 0)
 		return -ENOMEM;
 
-	for (group = 1; group < HE_NUM_GROUPS; ++group)
-	{
+	for (group = 1; group < HE_NUM_GROUPS; ++group) {
 		he_writel(he_dev, 0x0, G0_RBPS_S + (group * 32));
 		he_writel(he_dev, 0x0, G0_RBPS_T + (group * 32));
 		he_writel(he_dev, 0x0, G0_RBPS_QI + (group * 32));
@@ -1580,8 +1540,7 @@
 
 	he_dev->hsp = pci_alloc_consistent(he_dev->pci_dev,
 				sizeof(struct he_hsp), &he_dev->hsp_phys);
-	if (he_dev->hsp == NULL)
-	{
+	if (he_dev->hsp == NULL) {
 		hprintk("failed to allocate host status page\n");
 		return -ENOMEM;
 	}
@@ -1596,8 +1555,7 @@
 		he_dev->atm_dev->phy->start(he_dev->atm_dev);
 #endif /* CONFIG_ATM_HE_USE_SUNI */
 
-	if (sdh)
-	{
+	if (sdh) {
 		/* this really should be in suni.c but for now... */
 
 		int val;
@@ -1620,8 +1578,7 @@
 #ifndef USE_HE_FIND_VCC
 	he_dev->he_vcc_table = kmalloc(sizeof(struct he_vcc_table) * 
 			(1 << (he_dev->vcibits + he_dev->vpibits)), GFP_KERNEL);
-	if (he_dev->he_vcc_table == NULL)
-	{
+	if (he_dev->he_vcc_table == NULL) {
 		hprintk("failed to alloc he_vcc_table\n");
 		return -ENOMEM;
 	}
@@ -1629,8 +1586,7 @@
 				(1 << (he_dev->vcibits + he_dev->vpibits)));
 #endif
 
-	for (i = 0; i < HE_NUM_CS_STPER; ++i)
-	{
+	for (i = 0; i < HE_NUM_CS_STPER; ++i) {
 		he_dev->cs_stper[i].inuse = 0;
 		he_dev->cs_stper[i].pcr = -1;
 	}
@@ -1663,8 +1619,7 @@
 
 	/* disable interrupts */
 
-	if (he_dev->membase)
-	{
+	if (he_dev->membase) {
 		pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0);
 		gen_cntl_0 &= ~(INT_PROC_ENBL | INIT_ENB);
 		pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0);
@@ -1689,8 +1644,7 @@
 		he_dev->atm_dev->phy->stop(he_dev->atm_dev);
 #endif /* CONFIG_ATM_HE_USE_SUNI */
 
-	if (he_dev->irq)
-	{
+	if (he_dev->irq) {
 #ifdef BUS_INT_WAR
 		sn_delete_polled_interrupt(he_dev->irq);
 #endif
@@ -1705,11 +1659,9 @@
 		pci_free_consistent(he_dev->pci_dev, sizeof(struct he_hsp),
 						he_dev->hsp, he_dev->hsp_phys);
 
-	if (he_dev->rbpl_base)
-	{
+	if (he_dev->rbpl_base) {
 #ifdef USE_RBPL_POOL
-		for (i=0; i<CONFIG_RBPL_SIZE; ++i)
-		{
+		for (i=0; i<CONFIG_RBPL_SIZE; ++i) {
 			void *cpuaddr = he_dev->rbpl_virt[i].virt;
 			dma_addr_t dma_handle = he_dev->rbpl_base[i].phys;
 
@@ -1729,11 +1681,9 @@
 #endif
 
 #ifdef USE_RBPS
-	if (he_dev->rbps_base)
-	{
+	if (he_dev->rbps_base) {
 #ifdef USE_RBPS_POOL
-		for (i=0; i<CONFIG_RBPS_SIZE; ++i)
-		{
+		for (i=0; i<CONFIG_RBPS_SIZE; ++i) {
 			void *cpuaddr = he_dev->rbps_virt[i].virt;
 			dma_addr_t dma_handle = he_dev->rbps_base[i].phys;
 
@@ -1780,14 +1730,14 @@
 		kfree(he_dev->he_vcc_table);
 #endif
 
-	if (he_dev->pci_dev)
-	{
+	if (he_dev->pci_dev) {
 		pci_read_config_word(he_dev->pci_dev, PCI_COMMAND, &command);
 		command &= ~(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 		pci_write_config_word(he_dev->pci_dev, PCI_COMMAND, command);
 	}
 	
-	if (he_dev->membase) iounmap((void *) he_dev->membase);
+	if (he_dev->membase)
+		iounmap((void *) he_dev->membase);
 }
 
 static struct he_tpd *
@@ -1811,8 +1761,7 @@
 #else
 	int i;
 
-	for(i = 0; i < CONFIG_NUMTPDS; ++i)
-	{
+	for (i = 0; i < CONFIG_NUMTPDS; ++i) {
 		++he_dev->tpd_head;
 		if (he_dev->tpd_head > he_dev->tpd_end) {
 			he_dev->tpd_head = he_dev->tpd_base;
@@ -1862,8 +1811,7 @@
 	int pdus_assembled = 0;
 	int updated = 0;
 
-	while (he_dev->rbrq_head != rbrq_tail)
-	{
+	while (he_dev->rbrq_head != rbrq_tail) {
 		++updated;
 
 		HPRINTK("%p rbrq%d 0x%x len=%d cid=0x%x %s%s%s%s%s%s\n",
@@ -1895,8 +1843,7 @@
 #else
 		vcc = HE_LOOKUP_VCC(he_dev, cid);
 #endif
-		if (vcc == NULL)
-		{
+		if (vcc == NULL) {
 			hprintk("vcc == NULL  (cid 0x%x)\n", cid);
 			if (!RBRQ_HBUF_ERR(he_dev->rbrq_head))
 					rbp->status &= ~RBP_LOANED;
@@ -1905,16 +1852,14 @@
 		}
 
 		he_vcc = HE_VCC(vcc);
-		if (he_vcc == NULL)
-		{
+		if (he_vcc == NULL) {
 			hprintk("he_vcc == NULL  (cid 0x%x)\n", cid);
 			if (!RBRQ_HBUF_ERR(he_dev->rbrq_head))
 					rbp->status &= ~RBP_LOANED;
 			goto next_rbrq_entry;
 		}
 
-		if (RBRQ_HBUF_ERR(he_dev->rbrq_head))
-		{
+		if (RBRQ_HBUF_ERR(he_dev->rbrq_head)) {
 			hprintk("HBUF_ERR!  (cid 0x%x)\n", cid);
 				atomic_inc(&vcc->stats->rx_drop);
 			goto return_host_buffers;
@@ -1925,8 +1870,7 @@
 		he_vcc->pdu_len += buf_len;
 		++he_vcc->iov_tail;
 
-		if (RBRQ_CON_CLOSED(he_dev->rbrq_head))
-		{
+		if (RBRQ_CON_CLOSED(he_dev->rbrq_head)) {
 			lastcid = -1;
 			HPRINTK("wake_up rx_waitq  (cid 0x%x)\n", cid);
 			wake_up(&he_vcc->rx_waitq);
@@ -1934,17 +1878,16 @@
 		}
 
 #ifdef notdef
-		if ((he_vcc->iov_tail - he_vcc->iov_head) > HE_MAXIOV)
-		{
+		if ((he_vcc->iov_tail - he_vcc->iov_head) > HE_MAXIOV) {
 			hprintk("iovec full!  cid 0x%x\n", cid);
 			goto return_host_buffers;
 		}
 #endif
-		if (!RBRQ_END_PDU(he_dev->rbrq_head)) goto next_rbrq_entry;
+		if (!RBRQ_END_PDU(he_dev->rbrq_head))
+			goto next_rbrq_entry;
 
 		if (RBRQ_LEN_ERR(he_dev->rbrq_head)
-				|| RBRQ_CRC_ERR(he_dev->rbrq_head))
-		{
+				|| RBRQ_CRC_ERR(he_dev->rbrq_head)) {
 			HPRINTK("%s%s (%d.%d)\n",
 				RBRQ_CRC_ERR(he_dev->rbrq_head)
 							? "CRC_ERR " : "",
@@ -1957,19 +1900,18 @@
 
 		skb = atm_alloc_charge(vcc, he_vcc->pdu_len + rx_skb_reserve,
 							GFP_ATOMIC);
-		if (!skb)
-		{
+		if (!skb) {
 			HPRINTK("charge failed (%d.%d)\n", vcc->vpi, vcc->vci);
 			goto return_host_buffers;
 		}
 
-		if (rx_skb_reserve > 0) skb_reserve(skb, rx_skb_reserve);
+		if (rx_skb_reserve > 0)
+			skb_reserve(skb, rx_skb_reserve);
 
 		do_gettimeofday(&skb->stamp);
 
-		for(iov = he_vcc->iov_head;
-				iov < he_vcc->iov_tail; ++iov)
-		{
+		for (iov = he_vcc->iov_head;
+				iov < he_vcc->iov_tail; ++iov) {
 #ifdef USE_RBPS
 			if (iov->iov_base & RBP_SMALLBUF)
 				memcpy(skb_put(skb, iov->iov_len),
@@ -1980,8 +1922,7 @@
 					he_dev->rbpl_virt[RBP_INDEX(iov->iov_base)].virt, iov->iov_len);
 		}
 
-		switch(vcc->qos.aal)
-		{
+		switch (vcc->qos.aal) {
 			case ATM_AAL0:
 				/* 2.10.1.5 raw cell receive */
 				skb->len = ATM_AAL0_SDU;
@@ -1993,8 +1934,7 @@
 				skb->len = AAL5_LEN(skb->data, he_vcc->pdu_len);
 				skb->tail = skb->data + skb->len;
 #ifdef USE_CHECKSUM_HW
-				if (vcc->vpi == 0 && vcc->vci >= ATM_NOT_RSV_VCI) 
-				{
+				if (vcc->vpi == 0 && vcc->vci >= ATM_NOT_RSV_VCI) {
 					skb->ip_summed = CHECKSUM_HW;
 					skb->csum = TCP_CKSUM(skb->data,
 							he_vcc->pdu_len);
@@ -2018,9 +1958,8 @@
 return_host_buffers:
 		++pdus_assembled;
 
-		for(iov = he_vcc->iov_head;
-				iov < he_vcc->iov_tail; ++iov)
-		{
+		for (iov = he_vcc->iov_head;
+				iov < he_vcc->iov_tail; ++iov) {
 #ifdef USE_RBPS
 			if (iov->iov_base & RBP_SMALLBUF)
 				rbp = &he_dev->rbps_base[RBP_INDEX(iov->iov_base)];
@@ -2041,9 +1980,9 @@
 
 	}
 
-	if (updated)
-	{
-		if (updated > he_dev->rbrq_peak) he_dev->rbrq_peak = updated;
+	if (updated) {
+		if (updated > he_dev->rbrq_peak)
+			he_dev->rbrq_peak = updated;
 
 		he_writel(he_dev, RBRQ_MASK(he_dev->rbrq_head),
 						G0_RBRQ_H + (group * 16));
@@ -2069,8 +2008,7 @@
 
 	/* 2.1.6 transmit buffer return queue */
 
-	while (he_dev->tbrq_head != tbrq_tail)
-	{
+	while (he_dev->tbrq_head != tbrq_tail) {
 		++updated;
 
 		HPRINTK("tbrq%d 0x%x%s%s\n",
@@ -2081,19 +2019,16 @@
 #ifdef USE_TPD_POOL
 		tpd = NULL;
 		p = &he_dev->outstanding_tpds;
-		while ((p = p->next) != &he_dev->outstanding_tpds)
-		{
+		while ((p = p->next) != &he_dev->outstanding_tpds) {
 			struct he_tpd *__tpd = list_entry(p, struct he_tpd, entry);
-			if (TPD_ADDR(__tpd->status) == TBRQ_TPD(he_dev->tbrq_head))
-			{
+			if (TPD_ADDR(__tpd->status) == TBRQ_TPD(he_dev->tbrq_head)) {
 				tpd = __tpd;
 				list_del(&__tpd->entry);
 				break;
 			}
 		}
 
-		if (tpd == NULL)
-		{
+		if (tpd == NULL) {
 			hprintk("unable to locate tpd for dma buffer %x\n",
 						TBRQ_TPD(he_dev->tbrq_head));
 			goto next_tbrq_entry;
@@ -2102,8 +2037,7 @@
 		tpd = &he_dev->tpd_base[ TPD_INDEX(TBRQ_TPD(he_dev->tbrq_head)) ];
 #endif
 
-		if (TBRQ_EOS(he_dev->tbrq_head))
-		{
+		if (TBRQ_EOS(he_dev->tbrq_head)) {
 			HPRINTK("wake_up(tx_waitq) cid 0x%x\n",
 				he_mkcid(he_dev, tpd->vcc->vpi, tpd->vcc->vci));
 			if (tpd->vcc)
@@ -2112,19 +2046,18 @@
 			goto next_tbrq_entry;
 		}
 
-		for(slot = 0; slot < TPD_MAXIOV; ++slot)
-		{
+		for (slot = 0; slot < TPD_MAXIOV; ++slot) {
 			if (tpd->iovec[slot].addr)
 				pci_unmap_single(he_dev->pci_dev,
 					tpd->iovec[slot].addr,
 					tpd->iovec[slot].len & TPD_LEN_MASK,
 							PCI_DMA_TODEVICE);
-			if (tpd->iovec[slot].len & TPD_LST) break;
+			if (tpd->iovec[slot].len & TPD_LST)
+				break;
 				
 		}
 
-		if (tpd->skb)	/* && !TBRQ_MULTIPLE(he_dev->tbrq_head) */
-		{
+		if (tpd->skb) {	/* && !TBRQ_MULTIPLE(he_dev->tbrq_head) */
 			if (tpd->vcc && tpd->vcc->pop)
 				tpd->vcc->pop(tpd->vcc, tpd->skb);
 			else
@@ -2133,7 +2066,8 @@
 
 next_tbrq_entry:
 #ifdef USE_TPD_POOL
-		if (tpd) pci_pool_free(he_dev->tpd_pool, tpd, TPD_ADDR(tpd->status));
+		if (tpd)
+			pci_pool_free(he_dev->tpd_pool, tpd, TPD_ADDR(tpd->status));
 #else
 		tpd->inuse = 0;
 #endif
@@ -2142,9 +2076,9 @@
 					TBRQ_MASK(++he_dev->tbrq_head));
 	}
 
-	if (updated)
-	{
-		if (updated > he_dev->tbrq_peak) he_dev->tbrq_peak = updated;
+	if (updated) {
+		if (updated > he_dev->tbrq_peak)
+			he_dev->tbrq_peak = updated;
 
 		he_writel(he_dev, TBRQ_MASK(he_dev->tbrq_head),
 						G0_TBRQ_H + (group * 16));
@@ -2165,8 +2099,7 @@
 	rbpl_head = (struct he_rbp *) ((unsigned long)he_dev->rbpl_base |
 					RBPL_MASK(he_readl(he_dev, G0_RBPL_S)));
 
-	for(;;)
-	{
+	for (;;) {
 		newtail = (struct he_rbp *) ((unsigned long)he_dev->rbpl_base |
 						RBPL_MASK(he_dev->rbpl_tail+1));
 
@@ -2177,7 +2110,6 @@
 		newtail->status |= RBP_LOANED;
 		he_dev->rbpl_tail = newtail;
 		++moved;
-
 	} 
 
 	if (moved) {
@@ -2199,8 +2131,7 @@
 	rbps_head = (struct he_rbp *) ((unsigned long)he_dev->rbps_base |
 					RBPS_MASK(he_readl(he_dev, G0_RBPS_S)));
 
-	for(;;)
-	{
+	for (;;) {
 		newtail = (struct he_rbp *) ((unsigned long)he_dev->rbps_base |
 						RBPS_MASK(he_dev->rbps_tail+1));
 
@@ -2211,7 +2142,6 @@
 		newtail->status |= RBP_LOANED;
 		he_dev->rbps_tail = newtail;
 		++moved;
-
 	} 
 
 	if (moved) {
@@ -2236,20 +2166,17 @@
 	HE_SPIN_LOCK(he_dev, flags);
 #endif
 
-	while(he_dev->irq_head != he_dev->irq_tail)
-	{
+	while (he_dev->irq_head != he_dev->irq_tail) {
 		++updated;
 
 		type = ITYPE_TYPE(he_dev->irq_head->isw);
 		group = ITYPE_GROUP(he_dev->irq_head->isw);
 
-		switch (type)
-		{
+		switch (type) {
 			case ITYPE_RBRQ_THRESH:
 				hprintk("rbrq%d threshold\n", group);
 			case ITYPE_RBRQ_TIMER:
-				if (he_service_rbrq(he_dev, group))
-				{
+				if (he_service_rbrq(he_dev, group)) {
 					he_service_rbpl(he_dev, group);
 #ifdef USE_RBPS
 					he_service_rbps(he_dev, group);
@@ -2290,8 +2217,7 @@
 				}
 				break;
 			default:
-				if (he_dev->irq_head->isw == ITYPE_INVALID)
-				{
+				if (he_dev->irq_head->isw == ITYPE_INVALID) {
 					/* see 8.1.1 -- check all queues */
 
 					HPRINTK("isw not updated 0x%x\n",
@@ -2314,9 +2240,9 @@
 		he_dev->irq_head = (struct he_irq *) NEXT_ENTRY(he_dev->irq_base, he_dev->irq_head, IRQ_MASK);
 	}
 
-	if (updated)
-	{
-		if (updated > he_dev->irq_peak) he_dev->irq_peak = updated;
+	if (updated) {
+		if (updated > he_dev->irq_peak)
+			he_dev->irq_peak = updated;
 
 		he_writel(he_dev,
 			IRQ_SIZE(CONFIG_IRQ_SIZE) |
@@ -2344,8 +2270,7 @@
 	he_dev->irq_tail = (struct he_irq *) (((unsigned long)he_dev->irq_base) |
 						(*he_dev->irq_tailoffset << 2));
 
-	if (he_dev->irq_tail == he_dev->irq_head)
-	{
+	if (he_dev->irq_tail == he_dev->irq_head) {
 		HPRINTK("tailoffset not updated?\n");
 		he_dev->irq_tail = (struct he_irq *) ((unsigned long)he_dev->irq_base |
 			((he_readl(he_dev, IRQ0_BASE) & IRQ_MASK) << 2));
@@ -2357,8 +2282,7 @@
 		hprintk("spurious (or shared) interrupt?\n");
 #endif
 
-	if (he_dev->irq_head != he_dev->irq_tail)
-	{
+	if (he_dev->irq_head != he_dev->irq_tail) {
 		handled = 1;
 #ifdef USE_TASKLET
 		tasklet_schedule(&he_dev->tasklet);
@@ -2395,14 +2319,12 @@
 	 * head for every enqueue would be unnecessarily slow)
 	 */
 
-	if (new_tail == he_dev->tpdrq_head)
-	{
+	if (new_tail == he_dev->tpdrq_head) {
 		he_dev->tpdrq_head = (struct he_tpdrq *)
 			(((unsigned long)he_dev->tpdrq_base) |
 				TPDRQ_MASK(he_readl(he_dev, TPDRQ_B_H)));
 
-		if (new_tail == he_dev->tpdrq_head)
-		{
+		if (new_tail == he_dev->tpdrq_head) {
 			hprintk("tpdrq full (cid 0x%x)\n", cid);
 			/*
 			 * FIXME
@@ -2410,8 +2332,7 @@
 			 * after service_tbrq, service the backlog
 			 * for now, we just drop the pdu
 			 */
-			if (tpd->skb)
-			{
+			if (tpd->skb) {
 				if (tpd->vcc->pop)
 					tpd->vcc->pop(tpd->vcc, tpd->skb);
 				else
@@ -2456,12 +2377,12 @@
 	unsigned cid, rsr0, rsr1, rsr4, tsr0, tsr0_aal, tsr4, period, reg, clock;
 
 	
-	if ((err = atm_find_ci(vcc, &vpi, &vci)))
-	{
+	if ((err = atm_find_ci(vcc, &vpi, &vci))) {
 		HPRINTK("atm_find_ci err = %d\n", err);
 		return err;
 	}
-	if (vci == ATM_VCI_UNSPEC || vpi == ATM_VPI_UNSPEC) return 0;
+	if (vci == ATM_VCI_UNSPEC || vpi == ATM_VPI_UNSPEC)
+		return 0;
 	vcc->vpi = vpi;
 	vcc->vci = vci;
 
@@ -2472,8 +2393,7 @@
 	cid = he_mkcid(he_dev, vpi, vci);
 
 	he_vcc = (struct he_vcc *) kmalloc(sizeof(struct he_vcc), GFP_ATOMIC);
-	if (he_vcc == NULL)
-	{
+	if (he_vcc == NULL) {
 		hprintk("unable to allocate he_vcc during open\n");
 		return -ENOMEM;
 	}
@@ -2487,8 +2407,7 @@
 
 	HE_VCC(vcc) = he_vcc;
 
-	if (vcc->qos.txtp.traffic_class != ATM_NONE)
-	{
+	if (vcc->qos.txtp.traffic_class != ATM_NONE) {
 		int pcr_goal;
 
                 pcr_goal = atm_pcr_goal(&vcc->qos.txtp);
@@ -2499,8 +2418,7 @@
 
 		HPRINTK("open tx cid 0x%x pcr_goal %d\n", cid, pcr_goal);
 
-		switch (vcc->qos.aal)
-		{
+		switch (vcc->qos.aal) {
 			case ATM_AAL5:
 				tsr0_aal = TSR0_AAL5;
 				tsr4 = TSR4_AAL5;
@@ -2518,15 +2436,13 @@
 		tsr0 = he_readl_tsr0(he_dev, cid);
 		HE_SPIN_UNLOCK(he_dev, flags);
 
-		if (TSR0_CONN_STATE(tsr0) != 0)
-		{
+		if (TSR0_CONN_STATE(tsr0) != 0) {
 			hprintk("cid 0x%x not idle (tsr0 = 0x%x)\n", cid, tsr0);
 			err = -EBUSY;
 			goto open_failed;
 		}
 
-		switch(vcc->qos.txtp.traffic_class)
-		{
+		switch (vcc->qos.txtp.traffic_class) {
 			case ATM_UBR:
 				/* 2.3.3.1 open connection ubr */
 
@@ -2548,13 +2464,12 @@
 				HE_SPIN_LOCK(he_dev, flags);			/* also protects he_dev->cs_stper[] */
 
 				/* find an unused cs_stper register */
-				for(reg = 0; reg < HE_NUM_CS_STPER; ++reg)
+				for (reg = 0; reg < HE_NUM_CS_STPER; ++reg)
 					if (he_dev->cs_stper[reg].inuse == 0 || 
-						he_dev->cs_stper[reg].pcr == pcr_goal)
-					break;
+					    he_dev->cs_stper[reg].pcr == pcr_goal)
+							break;
 
-				if (reg == HE_NUM_CS_STPER)
-				{
+				if (reg == HE_NUM_CS_STPER) {
 					err = -EBUSY;
 					HE_SPIN_UNLOCK(he_dev, flags);
 					goto open_failed;
@@ -2610,15 +2525,13 @@
 		HE_SPIN_UNLOCK(he_dev, flags);
 	}
 
-	if (vcc->qos.rxtp.traffic_class != ATM_NONE)
-	{
+	if (vcc->qos.rxtp.traffic_class != ATM_NONE) {
 		unsigned aal;
 
 		HPRINTK("open rx cid 0x%x (rx_waitq %p)\n", cid,
 		 				&HE_VCC(vcc)->rx_waitq);
 
-		switch (vcc->qos.aal)
-		{
+		switch (vcc->qos.aal) {
 			case ATM_AAL5:
 				aal = RSR0_AAL5;
 				break;
@@ -2633,8 +2546,7 @@
 		HE_SPIN_LOCK(he_dev, flags);
 
 		rsr0 = he_readl_rsr0(he_dev, cid);
-		if (rsr0 & RSR0_OPEN_CONN)
-		{
+		if (rsr0 & RSR0_OPEN_CONN) {
 			HE_SPIN_UNLOCK(he_dev, flags);
 
 			hprintk("cid 0x%x not idle (rsr0 = 0x%x)\n", cid, rsr0);
@@ -2653,7 +2565,8 @@
 				(RSR0_EPD_ENABLE|RSR0_PPD_ENABLE) : 0;
 
 #ifdef USE_CHECKSUM_HW
-		if (vpi == 0 && vci >= ATM_NOT_RSV_VCI) rsr0 |= RSR0_TCP_CKSUM;
+		if (vpi == 0 && vci >= ATM_NOT_RSV_VCI)
+			rsr0 |= RSR0_TCP_CKSUM;
 #endif
 
 		he_writel_rsr4(he_dev, rsr4, cid);
@@ -2675,9 +2588,9 @@
 
 open_failed:
 
-	if (err)
-	{
-		if (he_vcc) kfree(he_vcc);
+	if (err) {
+		if (he_vcc)
+			kfree(he_vcc);
 		clear_bit(ATM_VF_ADDR, &vcc->flags);
 	}
 	else
@@ -2703,8 +2616,7 @@
 	clear_bit(ATM_VF_READY, &vcc->flags);
 	cid = he_mkcid(he_dev, vcc->vpi, vcc->vci);
 
-	if (vcc->qos.rxtp.traffic_class != ATM_NONE)
-	{
+	if (vcc->qos.rxtp.traffic_class != ATM_NONE) {
 		int timeout;
 
 		HPRINTK("close rx cid 0x%x\n", cid);
@@ -2714,8 +2626,7 @@
 		/* wait for previous close (if any) to finish */
 
 		HE_SPIN_LOCK(he_dev, flags);
-		while(he_readl(he_dev, RCC_STAT) & RCC_BUSY)
-		{
+		while (he_readl(he_dev, RCC_STAT) & RCC_BUSY) {
 			HPRINTK("close cid 0x%x RCC_BUSY\n", cid);
 			udelay(250);
 		}
@@ -2745,8 +2656,7 @@
 
 	}
 
-	if (vcc->qos.txtp.traffic_class != ATM_NONE)
-	{
+	if (vcc->qos.txtp.traffic_class != ATM_NONE) {
 		volatile unsigned tsr4, tsr0;
 		int timeout;
 
@@ -2761,19 +2671,19 @@
 		 * TBRQ, the host issues the close command to the adapter.
 		 */
 
-		while (((tx_inuse = atomic_read(&vcc->sk->wmem_alloc)) > 0)
-							&& (retry < MAX_RETRY))
-		{
+		while (((tx_inuse = atomic_read(&vcc->sk->wmem_alloc)) > 0) &&
+		       (retry < MAX_RETRY)) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			(void) schedule_timeout(sleep);
 			set_current_state(TASK_RUNNING);
-			if (sleep < HZ) sleep = sleep * 2;
+			if (sleep < HZ)
+				sleep = sleep * 2;
 
 			++retry;
 		}
 
-		if (tx_inuse) hprintk("close tx cid 0x%x tx_inuse = %d\n",
-								cid, tx_inuse);
+		if (tx_inuse)
+			hprintk("close tx cid 0x%x tx_inuse = %d\n", cid, tx_inuse);
 
 		/* 2.3.1.1 generic close operations with flush */
 
@@ -2784,8 +2694,7 @@
 		(void) he_readl_tsr4(he_dev, cid);
 #endif
 
-		switch(vcc->qos.txtp.traffic_class)
-		{
+		switch (vcc->qos.txtp.traffic_class) {
 			case ATM_UBR:
 				he_writel_tsr1(he_dev, 
 					TSR1_MCR(rate_to_atmf(200000))
@@ -2796,10 +2705,8 @@
 				break;
 		}
 
-
 		tpd = __alloc_tpd(he_dev);
-		if (tpd == NULL)
-		{
+		if (tpd == NULL) {
 			hprintk("close tx he_alloc_tpd failed cid 0x%x\n", cid);
 			goto close_tx_incomplete;
 		}
@@ -2818,30 +2725,25 @@
 		remove_wait_queue(&he_vcc->tx_waitq, &wait);
 		set_current_state(TASK_RUNNING);
 
-		if (timeout == 0)
-		{
+		if (timeout == 0) {
 			hprintk("close tx timeout cid 0x%x\n", cid);
 			goto close_tx_incomplete;
 		}
 
 		HE_SPIN_LOCK(he_dev, flags);
-		while (!((tsr4 = he_readl_tsr4(he_dev, cid))
-							& TSR4_SESSION_ENDED))
-		{
+		while (!((tsr4 = he_readl_tsr4(he_dev, cid)) & TSR4_SESSION_ENDED)) {
 			HPRINTK("close tx cid 0x%x !TSR4_SESSION_ENDED (tsr4 = 0x%x)\n", cid, tsr4);
 			udelay(250);
 		}
 
-		while (TSR0_CONN_STATE(tsr0 = he_readl_tsr0(he_dev, cid)) != 0)
-		{
+		while (TSR0_CONN_STATE(tsr0 = he_readl_tsr0(he_dev, cid)) != 0) {
 			HPRINTK("close tx cid 0x%x TSR0_CONN_STATE != 0 (tsr0 = 0x%x)\n", cid, tsr0);
 			udelay(250);
 		}
 
 close_tx_incomplete:
 
-		if (vcc->qos.txtp.traffic_class == ATM_CBR)
-		{
+		if (vcc->qos.txtp.traffic_class == ATM_CBR) {
 			int reg = he_vcc->rc_index;
 
 			HPRINTK("cs_stper reg = %d\n", reg);
@@ -2889,8 +2791,7 @@
 	HPRINTK("send %d.%d\n", vcc->vpi, vcc->vci);
 
 	if ((skb->len > HE_TPD_BUFSIZE) ||
-		((vcc->qos.aal == ATM_AAL0) && (skb->len != ATM_AAL0_SDU)))
-	{
+	    ((vcc->qos.aal == ATM_AAL0) && (skb->len != ATM_AAL0_SDU))) {
 		hprintk("buffer too large (or small) -- %d bytes\n", skb->len );
 		if (vcc->pop)
 			vcc->pop(vcc, skb);
@@ -2901,8 +2802,7 @@
 	}
 
 #ifndef USE_SCATTERGATHER
-	if (skb_shinfo(skb)->nr_frags)
-	{
+	if (skb_shinfo(skb)->nr_frags) {
 		hprintk("no scatter/gather support\n");
 		if (vcc->pop)
 			vcc->pop(vcc, skb);
@@ -2915,8 +2815,7 @@
 	HE_SPIN_LOCK(he_dev, flags);
 
 	tpd = __alloc_tpd(he_dev);
-	if (tpd == NULL)
-	{
+	if (tpd == NULL) {
 		if (vcc->pop)
 			vcc->pop(vcc, skb);
 		else
@@ -2928,15 +2827,15 @@
 
 	if (vcc->qos.aal == ATM_AAL5)
 		tpd->status |= TPD_CELLTYPE(TPD_USERCELL);
-	else
-	{
+	else {
 		char *pti_clp = (void *) (skb->data + 3);
 		int clp, pti;
 
 		pti = (*pti_clp & ATM_HDR_PTI_MASK) >> ATM_HDR_PTI_SHIFT; 
 		clp = (*pti_clp & ATM_HDR_CLP);
 		tpd->status |= TPD_CELLTYPE(pti);
-		if (clp) tpd->status |= TPD_CLP;
+		if (clp)
+			tpd->status |= TPD_CLP;
 
 		skb_pull(skb, ATM_AAL0_SDU - ATM_CELL_PAYLOAD);
 	}
@@ -2947,12 +2846,10 @@
 	tpd->iovec[slot].len = skb->len - skb->data_len;
 	++slot;
 
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-	{
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		if (slot == TPD_MAXIOV)		/* send tpd; start new tpd */
-		{
+		if (slot == TPD_MAXIOV) {	/* queue tpd; start new tpd */
 			tpd->vcc = vcc;
 			tpd->skb = NULL;	/* not the last fragment
 						   so dont ->push() yet */
@@ -2960,8 +2857,7 @@
 
 			__enqueue_tpd(he_dev, tpd, cid);
 			tpd = __alloc_tpd(he_dev);
-			if (tpd == NULL)
-			{
+			if (tpd == NULL) {
 				if (vcc->pop)
 					vcc->pop(vcc, skb);
 				else
@@ -3010,16 +2906,15 @@
 	struct he_ioctl_reg reg;
 	int err = 0;
 
-	switch (cmd)
-	{
+	switch (cmd) {
 		case HE_GET_REG:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
+			if (!capable(CAP_NET_ADMIN))
+				return -EPERM;
 
 			copy_from_user(&reg, (struct he_ioctl_reg *) arg,
 						sizeof(struct he_ioctl_reg));
 			HE_SPIN_LOCK(he_dev, flags);
-			switch (reg.type)
-			{
+			switch (reg.type) {
 				case HE_REGTYPE_PCI:
 					reg.val = he_readl(he_dev, reg.addr);
 					break;
@@ -3040,7 +2935,8 @@
 					break;
 			}
 			HE_SPIN_UNLOCK(he_dev, flags);
-			if (err == 0) copy_to_user((struct he_ioctl_reg *) arg, &reg,
+			if (err == 0)
+				copy_to_user((struct he_ioctl_reg *) arg, &reg,
 							sizeof(struct he_ioctl_reg));
 			break;
 		default:
@@ -3048,7 +2944,7 @@
 			if (atm_dev->phy && atm_dev->phy->ioctl)
 				err = atm_dev->phy->ioctl(atm_dev, cmd, arg);
 #else /* CONFIG_ATM_HE_USE_SUNI */
-			return -EINVAL;
+			err = -EINVAL;
 #endif /* CONFIG_ATM_HE_USE_SUNI */
 			break;
 	}
@@ -3146,7 +3042,8 @@
         rbpl_tail = RBPL_MASK(he_readl(he_dev, G0_RBPL_T));
 
 	inuse = rbpl_head - rbpl_tail;
-	if (inuse < 0) inuse += CONFIG_RBPL_SIZE * sizeof(struct he_rbp);
+	if (inuse < 0)
+		inuse += CONFIG_RBPL_SIZE * sizeof(struct he_rbp);
 	inuse /= sizeof(struct he_rbp);
 
 	if (!left--)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1160  -> 1.1161 
#	    drivers/atm/he.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/25	chas@relax.cmf.nrl.navy.mil	1.1161
# misc irq handler cleanups
# --------------------------------------------
#
diff -Nru a/drivers/atm/he.c b/drivers/atm/he.c
--- a/drivers/atm/he.c	Thu May 29 11:49:13 2003
+++ b/drivers/atm/he.c	Thu May 29 11:49:13 2003
@@ -2232,7 +2232,8 @@
 
 		switch (type) {
 			case ITYPE_RBRQ_THRESH:
-				hprintk("rbrq%d threshold\n", group);
+				HPRINTK("rbrq%d threshold\n", group);
+				/* fall through */
 			case ITYPE_RBRQ_TIMER:
 				if (he_service_rbrq(he_dev, group)) {
 					he_service_rbpl(he_dev, group);
@@ -2242,7 +2243,8 @@
 				}
 				break;
 			case ITYPE_TBRQ_THRESH:
-				hprintk("tbrq%d threshold\n", group);
+				HPRINTK("tbrq%d threshold\n", group);
+				/* fall through */
 			case ITYPE_TPD_COMPLETE:
 				he_service_tbrq(he_dev, group);
 				break;
@@ -2255,17 +2257,16 @@
 #endif /* USE_RBPS */
 				break;
 			case ITYPE_PHY:
+				HPRINTK("phy interrupt\n");
 #ifdef CONFIG_ATM_HE_USE_SUNI
 				HE_SPIN_UNLOCK(he_dev, flags);
 				if (he_dev->atm_dev->phy && he_dev->atm_dev->phy->interrupt)
 					he_dev->atm_dev->phy->interrupt(he_dev->atm_dev);
 				HE_SPIN_LOCK(he_dev, flags);
 #endif
-				HPRINTK("phy interrupt\n");
 				break;
 			case ITYPE_OTHER:
-				switch (type|group)
-				{
+				switch (type|group) {
 					case ITYPE_PARITY:
 						hprintk("parity error\n");
 						break;
@@ -2274,23 +2275,20 @@
 						break;
 				}
 				break;
-			default:
-				if (he_dev->irq_head->isw == ITYPE_INVALID) {
-					/* see 8.1.1 -- check all queues */
+			case ITYPE_TYPE(ITYPE_INVALID):
+				/* see 8.1.1 -- check all queues */
 
-					HPRINTK("isw not updated 0x%x\n",
-						he_dev->irq_head->isw);
+				HPRINTK("isw not updated 0x%x\n", he_dev->irq_head->isw);
 
-					he_service_rbrq(he_dev, 0);
-					he_service_rbpl(he_dev, 0);
+				he_service_rbrq(he_dev, 0);
+				he_service_rbpl(he_dev, 0);
 #ifdef USE_RBPS
-					he_service_rbps(he_dev, 0);
+				he_service_rbps(he_dev, 0);
 #endif /* USE_RBPS */
-					he_service_tbrq(he_dev, 0);
-				}
-				else
-					hprintk("bad isw = 0x%x?\n",
-						he_dev->irq_head->isw);
+				he_service_tbrq(he_dev, 0);
+				break;
+			default:
+				hprintk("bad isw 0x%x?\n", he_dev->irq_head->isw);
 		}
 
 		he_dev->irq_head->isw = ITYPE_INVALID;

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1161  -> 1.1162 
#	    drivers/atm/he.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/29	chas@relax.cmf.nrl.navy.mil	1.1162
# move rategrid off stack
# --------------------------------------------
#
diff -Nru a/drivers/atm/he.c b/drivers/atm/he.c
--- a/drivers/atm/he.c	Thu May 29 11:49:27 2003
+++ b/drivers/atm/he.c	Thu May 29 11:49:27 2003
@@ -672,10 +672,10 @@
 
 }
 
-static void __init
+static int __init
 he_init_cs_block_rcm(struct he_dev *he_dev)
 {
-	unsigned rategrid[16][16];
+	unsigned (*rategrid)[16][16];
 	unsigned rate, delta;
 	int i, j, reg;
 
@@ -683,6 +683,10 @@
 	unsigned long long rate_cps;
         int mult, buf, buf_limit = 4;
 
+	rategrid = kmalloc( sizeof(unsigned) * 16 * 16, GFP_KERNEL);
+	if (!rategrid)
+		return -ENOMEM;
+
 	/* initialize rate grid group table */
 
 	for (reg = 0x0; reg < 0xff; ++reg)
@@ -712,16 +716,16 @@
 	 */
 
 	for (j = 0; j < 16; j++) {
-		rategrid[0][j] = rate;
+		(*rategrid)[0][j] = rate;
 		rate -= delta;
 	}
 
 	for (i = 1; i < 16; i++)
 		for (j = 0; j < 16; j++)
 			if (i > 14)
-				rategrid[i][j] = rategrid[i - 1][j] / 4;
+				(*rategrid)[i][j] = (*rategrid)[i - 1][j] / 4;
 			else
-				rategrid[i][j] = rategrid[i - 1][j] / 2;
+				(*rategrid)[i][j] = (*rategrid)[i - 1][j] / 2;
 
 	/*
 	 * 2.4 transmit internal function
@@ -746,7 +750,7 @@
 			rate_cps = 10;	/* 2.2.1 minimum payload rate is 10 cps */
 
 		for (i = 255; i > 0; i--)
-			if (rategrid[i/16][i%16] >= rate_cps)
+			if ((*rategrid)[i/16][i%16] >= rate_cps)
 				break;	 /* pick nearest rate instead? */
 
 		/*
@@ -783,6 +787,9 @@
 
 		++rate_atmf;
 	}
+
+	kfree(rategrid);
+	return 0;
 }
 
 static int __init
@@ -1505,7 +1512,8 @@
 
 	/* 5.1.8 cs block connection memory initialization */
 	
-	he_init_cs_block_rcm(he_dev);
+	if (he_init_cs_block_rcm(he_dev) < 0)
+		return -ENOMEM;
 
 	/* 5.1.10 initialize host structures */
 

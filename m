Return-Path: <linux-kernel-owner+w=401wt.eu-S1752513AbWLSENj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbWLSENj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 23:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbWLSENB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 23:13:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4463 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752437AbWLSEM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 23:12:58 -0500
Date: Tue, 19 Dec 2006 05:12:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: chas@cmf.nrl.navy.mil
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/atm/fore200e.c: cleanups
Message-ID: <20061219041258.GC6993@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following transformations from custom functions 
to standard kernel version:
- fore200e_kmalloc() -> kzalloc()
- fore200e_kfree() -> kfree()
- fore200e_swap() -> cpu_to_be32()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/atm/fore200e.c |  166 ++++++++++++++++-------------------------
 1 file changed, 68 insertions(+), 98 deletions(-)

--- linux-2.6.20-rc1-mm1/drivers/atm/fore200e.c.old	2006-12-19 04:29:36.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/atm/fore200e.c	2006-12-19 04:34:53.000000000 +0100
@@ -172,25 +172,6 @@ fore200e_irq_itoa(int irq)
 }
 
 
-static void*
-fore200e_kmalloc(int size, gfp_t flags)
-{
-    void *chunk = kzalloc(size, flags);
-
-    if (!chunk)
-	printk(FORE200E "kmalloc() failed, requested size = %d, flags = 0x%x\n",			size, flags);
-    
-    return chunk;
-}
-
-
-static void
-fore200e_kfree(void* chunk)
-{
-    kfree(chunk);
-}
-
-
 /* allocate and align a chunk of memory intended to hold the data behing exchanged
    between the driver and the adapter (using streaming DVMA) */
 
@@ -206,7 +187,7 @@ fore200e_chunk_alloc(struct fore200e* fo
     chunk->align_size = size;
     chunk->direction  = direction;
 
-    chunk->alloc_addr = fore200e_kmalloc(chunk->alloc_size, GFP_KERNEL | GFP_DMA);
+    chunk->alloc_addr = kzalloc(chunk->alloc_size, GFP_KERNEL | GFP_DMA);
     if (chunk->alloc_addr == NULL)
 	return -ENOMEM;
 
@@ -228,7 +209,7 @@ fore200e_chunk_free(struct fore200e* for
 {
     fore200e->bus->dma_unmap(fore200e, chunk->dma_addr, chunk->dma_size, chunk->direction);
 
-    fore200e_kfree(chunk->alloc_addr);
+    kfree(chunk->alloc_addr);
 }
 
 
@@ -882,7 +863,7 @@ fore200e_sba_detect(const struct fore200
 	return NULL;
     }
 
-    fore200e = fore200e_kmalloc(sizeof(struct fore200e), GFP_KERNEL);
+    fore200e = kzalloc(sizeof(struct fore200e), GFP_KERNEL);
     if (fore200e == NULL)
 	return NULL;
 
@@ -1505,7 +1486,7 @@ fore200e_open(struct atm_vcc *vcc)
 
     spin_unlock_irqrestore(&fore200e->q_lock, flags);
 
-    fore200e_vcc = fore200e_kmalloc(sizeof(struct fore200e_vcc), GFP_ATOMIC);
+    fore200e_vcc = kzalloc(sizeof(struct fore200e_vcc), GFP_ATOMIC);
     if (fore200e_vcc == NULL) {
 	vc_map->vcc = NULL;
 	return -ENOMEM;
@@ -1526,7 +1507,7 @@ fore200e_open(struct atm_vcc *vcc)
 	if (fore200e->available_cell_rate < vcc->qos.txtp.max_pcr) {
 	    up(&fore200e->rate_sf);
 
-	    fore200e_kfree(fore200e_vcc);
+	    kfree(fore200e_vcc);
 	    vc_map->vcc = NULL;
 	    return -EAGAIN;
 	}
@@ -1554,7 +1535,7 @@ fore200e_open(struct atm_vcc *vcc)
 
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
 
-	fore200e_kfree(fore200e_vcc);
+	kfree(fore200e_vcc);
 	return -EINVAL;
     }
     
@@ -1630,7 +1611,7 @@ fore200e_close(struct atm_vcc* vcc)
     clear_bit(ATM_VF_PARTIAL,&vcc->flags);
 
     ASSERT(fore200e_vcc);
-    fore200e_kfree(fore200e_vcc);
+    kfree(fore200e_vcc);
 }
 
 
@@ -1831,7 +1812,7 @@ fore200e_getstats(struct fore200e* fore2
     u32                     stats_dma_addr;
 
     if (fore200e->stats == NULL) {
-	fore200e->stats = fore200e_kmalloc(sizeof(struct stats), GFP_KERNEL | GFP_DMA);
+	fore200e->stats = kzalloc(sizeof(struct stats), GFP_KERNEL | GFP_DMA);
 	if (fore200e->stats == NULL)
 	    return -ENOMEM;
     }
@@ -2002,17 +1983,6 @@ fore200e_setloop(struct fore200e* fore20
 }
 
 
-static inline unsigned int
-fore200e_swap(unsigned int in)
-{
-#if defined(__LITTLE_ENDIAN)
-    return swab32(in);
-#else
-    return in;
-#endif
-}
-
-
 static int
 fore200e_fetch_stats(struct fore200e* fore200e, struct sonet_stats __user *arg)
 {
@@ -2021,19 +1991,19 @@ fore200e_fetch_stats(struct fore200e* fo
     if (fore200e_getstats(fore200e) < 0)
 	return -EIO;
 
-    tmp.section_bip = fore200e_swap(fore200e->stats->oc3.section_bip8_errors);
-    tmp.line_bip    = fore200e_swap(fore200e->stats->oc3.line_bip24_errors);
-    tmp.path_bip    = fore200e_swap(fore200e->stats->oc3.path_bip8_errors);
-    tmp.line_febe   = fore200e_swap(fore200e->stats->oc3.line_febe_errors);
-    tmp.path_febe   = fore200e_swap(fore200e->stats->oc3.path_febe_errors);
-    tmp.corr_hcs    = fore200e_swap(fore200e->stats->oc3.corr_hcs_errors);
-    tmp.uncorr_hcs  = fore200e_swap(fore200e->stats->oc3.ucorr_hcs_errors);
-    tmp.tx_cells    = fore200e_swap(fore200e->stats->aal0.cells_transmitted)  +
-	              fore200e_swap(fore200e->stats->aal34.cells_transmitted) +
-	              fore200e_swap(fore200e->stats->aal5.cells_transmitted);
-    tmp.rx_cells    = fore200e_swap(fore200e->stats->aal0.cells_received)     +
-	              fore200e_swap(fore200e->stats->aal34.cells_received)    +
-	              fore200e_swap(fore200e->stats->aal5.cells_received);
+    tmp.section_bip = cpu_to_be32(fore200e->stats->oc3.section_bip8_errors);
+    tmp.line_bip    = cpu_to_be32(fore200e->stats->oc3.line_bip24_errors);
+    tmp.path_bip    = cpu_to_be32(fore200e->stats->oc3.path_bip8_errors);
+    tmp.line_febe   = cpu_to_be32(fore200e->stats->oc3.line_febe_errors);
+    tmp.path_febe   = cpu_to_be32(fore200e->stats->oc3.path_febe_errors);
+    tmp.corr_hcs    = cpu_to_be32(fore200e->stats->oc3.corr_hcs_errors);
+    tmp.uncorr_hcs  = cpu_to_be32(fore200e->stats->oc3.ucorr_hcs_errors);
+    tmp.tx_cells    = cpu_to_be32(fore200e->stats->aal0.cells_transmitted)  +
+	              cpu_to_be32(fore200e->stats->aal34.cells_transmitted) +
+	              cpu_to_be32(fore200e->stats->aal5.cells_transmitted);
+    tmp.rx_cells    = cpu_to_be32(fore200e->stats->aal0.cells_received)     +
+	              cpu_to_be32(fore200e->stats->aal34.cells_received)    +
+	              cpu_to_be32(fore200e->stats->aal5.cells_received);
 
     if (arg)
 	return copy_to_user(arg, &tmp, sizeof(struct sonet_stats)) ? -EFAULT : 0;	
@@ -2146,7 +2116,7 @@ fore200e_irq_request(struct fore200e* fo
 static int __devinit
 fore200e_get_esi(struct fore200e* fore200e)
 {
-    struct prom_data* prom = fore200e_kmalloc(sizeof(struct prom_data), GFP_KERNEL | GFP_DMA);
+    struct prom_data* prom = kzalloc(sizeof(struct prom_data), GFP_KERNEL | GFP_DMA);
     int ok, i;
 
     if (!prom)
@@ -2154,7 +2124,7 @@ fore200e_get_esi(struct fore200e* fore20
 
     ok = fore200e->bus->prom_read(fore200e, prom);
     if (ok < 0) {
-	fore200e_kfree(prom);
+	kfree(prom);
 	return -EBUSY;
     }
 	
@@ -2169,7 +2139,7 @@ fore200e_get_esi(struct fore200e* fore20
 	fore200e->esi[ i ] = fore200e->atm_dev->esi[ i ] = prom->mac_addr[ i + 2 ];
     }
     
-    fore200e_kfree(prom);
+    kfree(prom);
 
     return 0;
 }
@@ -2194,7 +2164,7 @@ fore200e_alloc_rx_buf(struct fore200e* f
 	    DPRINTK(2, "rx buffers %d / %d are being allocated\n", scheme, magn);
 
 	    /* allocate the array of receive buffers */
-	    buffer = bsq->buffer = fore200e_kmalloc(nbr * sizeof(struct buffer), GFP_KERNEL);
+	    buffer = bsq->buffer = kzalloc(nbr * sizeof(struct buffer), GFP_KERNEL);
 
 	    if (buffer == NULL)
 		return -ENOMEM;
@@ -2217,7 +2187,7 @@ fore200e_alloc_rx_buf(struct fore200e* f
 		    
 		    while (i > 0)
 			fore200e_chunk_free(fore200e, &buffer[ --i ].data);
-		    fore200e_kfree(buffer);
+		    kfree(buffer);
 		    
 		    return -ENOMEM;
 		}
@@ -2736,7 +2706,7 @@ fore200e_pca_detect(struct pci_dev *pci_
 	goto out;
     }
     
-    fore200e = fore200e_kmalloc(sizeof(struct fore200e), GFP_KERNEL);
+    fore200e = kzalloc(sizeof(struct fore200e), GFP_KERNEL);
     if (fore200e == NULL) {
 	err = -ENOMEM;
 	goto out_disable;
@@ -2999,8 +2969,8 @@ fore200e_proc_read(struct atm_dev *dev, 
 		       "  4b5b:\n"
 		       "     crc_header_errors:\t\t%10u\n"
 		       "     framing_errors:\t\t%10u\n",
-		       fore200e_swap(fore200e->stats->phy.crc_header_errors),
-		       fore200e_swap(fore200e->stats->phy.framing_errors));
+		       cpu_to_be32(fore200e->stats->phy.crc_header_errors),
+		       cpu_to_be32(fore200e->stats->phy.framing_errors));
     
     if (!left--)
 	return sprintf(page, "\n"
@@ -3012,13 +2982,13 @@ fore200e_proc_read(struct atm_dev *dev, 
 		       "     path_febe_errors:\t\t%10u\n"
 		       "     corr_hcs_errors:\t\t%10u\n"
 		       "     ucorr_hcs_errors:\t\t%10u\n",
-		       fore200e_swap(fore200e->stats->oc3.section_bip8_errors),
-		       fore200e_swap(fore200e->stats->oc3.path_bip8_errors),
-		       fore200e_swap(fore200e->stats->oc3.line_bip24_errors),
-		       fore200e_swap(fore200e->stats->oc3.line_febe_errors),
-		       fore200e_swap(fore200e->stats->oc3.path_febe_errors),
-		       fore200e_swap(fore200e->stats->oc3.corr_hcs_errors),
-		       fore200e_swap(fore200e->stats->oc3.ucorr_hcs_errors));
+		       cpu_to_be32(fore200e->stats->oc3.section_bip8_errors),
+		       cpu_to_be32(fore200e->stats->oc3.path_bip8_errors),
+		       cpu_to_be32(fore200e->stats->oc3.line_bip24_errors),
+		       cpu_to_be32(fore200e->stats->oc3.line_febe_errors),
+		       cpu_to_be32(fore200e->stats->oc3.path_febe_errors),
+		       cpu_to_be32(fore200e->stats->oc3.corr_hcs_errors),
+		       cpu_to_be32(fore200e->stats->oc3.ucorr_hcs_errors));
 
     if (!left--)
 	return sprintf(page,"\n"
@@ -3029,12 +2999,12 @@ fore200e_proc_read(struct atm_dev *dev, 
 		       "     vpi no conn:\t\t%10u\n"
 		       "     vci out of range:\t\t%10u\n"
 		       "     vci no conn:\t\t%10u\n",
-		       fore200e_swap(fore200e->stats->atm.cells_transmitted),
-		       fore200e_swap(fore200e->stats->atm.cells_received),
-		       fore200e_swap(fore200e->stats->atm.vpi_bad_range),
-		       fore200e_swap(fore200e->stats->atm.vpi_no_conn),
-		       fore200e_swap(fore200e->stats->atm.vci_bad_range),
-		       fore200e_swap(fore200e->stats->atm.vci_no_conn));
+		       cpu_to_be32(fore200e->stats->atm.cells_transmitted),
+		       cpu_to_be32(fore200e->stats->atm.cells_received),
+		       cpu_to_be32(fore200e->stats->atm.vpi_bad_range),
+		       cpu_to_be32(fore200e->stats->atm.vpi_no_conn),
+		       cpu_to_be32(fore200e->stats->atm.vci_bad_range),
+		       cpu_to_be32(fore200e->stats->atm.vci_no_conn));
     
     if (!left--)
 	return sprintf(page,"\n"
@@ -3042,9 +3012,9 @@ fore200e_proc_read(struct atm_dev *dev, 
 		       "     TX:\t\t\t%10u\n"
 		       "     RX:\t\t\t%10u\n"
 		       "     dropped:\t\t\t%10u\n",
-		       fore200e_swap(fore200e->stats->aal0.cells_transmitted),
-		       fore200e_swap(fore200e->stats->aal0.cells_received),
-		       fore200e_swap(fore200e->stats->aal0.cells_dropped));
+		       cpu_to_be32(fore200e->stats->aal0.cells_transmitted),
+		       cpu_to_be32(fore200e->stats->aal0.cells_received),
+		       cpu_to_be32(fore200e->stats->aal0.cells_dropped));
     
     if (!left--)
 	return sprintf(page,"\n"
@@ -3060,15 +3030,15 @@ fore200e_proc_read(struct atm_dev *dev, 
 		       "       RX:\t\t\t%10u\n"
 		       "       dropped:\t\t\t%10u\n"
 		       "       protocol errors:\t\t%10u\n",
-		       fore200e_swap(fore200e->stats->aal34.cells_transmitted),
-		       fore200e_swap(fore200e->stats->aal34.cells_received),
-		       fore200e_swap(fore200e->stats->aal34.cells_dropped),
-		       fore200e_swap(fore200e->stats->aal34.cells_crc_errors),
-		       fore200e_swap(fore200e->stats->aal34.cells_protocol_errors),
-		       fore200e_swap(fore200e->stats->aal34.cspdus_transmitted),
-		       fore200e_swap(fore200e->stats->aal34.cspdus_received),
-		       fore200e_swap(fore200e->stats->aal34.cspdus_dropped),
-		       fore200e_swap(fore200e->stats->aal34.cspdus_protocol_errors));
+		       cpu_to_be32(fore200e->stats->aal34.cells_transmitted),
+		       cpu_to_be32(fore200e->stats->aal34.cells_received),
+		       cpu_to_be32(fore200e->stats->aal34.cells_dropped),
+		       cpu_to_be32(fore200e->stats->aal34.cells_crc_errors),
+		       cpu_to_be32(fore200e->stats->aal34.cells_protocol_errors),
+		       cpu_to_be32(fore200e->stats->aal34.cspdus_transmitted),
+		       cpu_to_be32(fore200e->stats->aal34.cspdus_received),
+		       cpu_to_be32(fore200e->stats->aal34.cspdus_dropped),
+		       cpu_to_be32(fore200e->stats->aal34.cspdus_protocol_errors));
     
     if (!left--)
 	return sprintf(page,"\n"
@@ -3084,15 +3054,15 @@ fore200e_proc_read(struct atm_dev *dev, 
 		       "       dropped:\t\t\t%10u\n"
 		       "       CRC errors:\t\t%10u\n"
 		       "       protocol errors:\t\t%10u\n",
-		       fore200e_swap(fore200e->stats->aal5.cells_transmitted),
-		       fore200e_swap(fore200e->stats->aal5.cells_received),
-		       fore200e_swap(fore200e->stats->aal5.cells_dropped),
-		       fore200e_swap(fore200e->stats->aal5.congestion_experienced),
-		       fore200e_swap(fore200e->stats->aal5.cspdus_transmitted),
-		       fore200e_swap(fore200e->stats->aal5.cspdus_received),
-		       fore200e_swap(fore200e->stats->aal5.cspdus_dropped),
-		       fore200e_swap(fore200e->stats->aal5.cspdus_crc_errors),
-		       fore200e_swap(fore200e->stats->aal5.cspdus_protocol_errors));
+		       cpu_to_be32(fore200e->stats->aal5.cells_transmitted),
+		       cpu_to_be32(fore200e->stats->aal5.cells_received),
+		       cpu_to_be32(fore200e->stats->aal5.cells_dropped),
+		       cpu_to_be32(fore200e->stats->aal5.congestion_experienced),
+		       cpu_to_be32(fore200e->stats->aal5.cspdus_transmitted),
+		       cpu_to_be32(fore200e->stats->aal5.cspdus_received),
+		       cpu_to_be32(fore200e->stats->aal5.cspdus_dropped),
+		       cpu_to_be32(fore200e->stats->aal5.cspdus_crc_errors),
+		       cpu_to_be32(fore200e->stats->aal5.cspdus_protocol_errors));
     
     if (!left--)
 	return sprintf(page,"\n"
@@ -3103,11 +3073,11 @@ fore200e_proc_read(struct atm_dev *dev, 
 		       "     large b2:\t\t\t%10u\n"
 		       "     RX PDUs:\t\t\t%10u\n"
 		       "     TX PDUs:\t\t\t%10lu\n",
-		       fore200e_swap(fore200e->stats->aux.small_b1_failed),
-		       fore200e_swap(fore200e->stats->aux.large_b1_failed),
-		       fore200e_swap(fore200e->stats->aux.small_b2_failed),
-		       fore200e_swap(fore200e->stats->aux.large_b2_failed),
-		       fore200e_swap(fore200e->stats->aux.rpd_alloc_failed),
+		       cpu_to_be32(fore200e->stats->aux.small_b1_failed),
+		       cpu_to_be32(fore200e->stats->aux.large_b1_failed),
+		       cpu_to_be32(fore200e->stats->aux.small_b2_failed),
+		       cpu_to_be32(fore200e->stats->aux.large_b2_failed),
+		       cpu_to_be32(fore200e->stats->aux.rpd_alloc_failed),
 		       fore200e->tx_sat);
     
     if (!left--)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTLESRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbTLESRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:17:55 -0500
Received: from havoc.gtf.org ([63.247.75.124]:45789 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264265AbTLESRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:17:19 -0500
Date: Fri, 5 Dec 2003 13:16:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] libata fixes
Message-ID: <20031205181643.GA6877@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://gkernel.bkbits.net/libata-2.5

This will update the following files:

 drivers/scsi/libata-core.c  |   17 ++---
 drivers/scsi/sata_promise.c |  128 +++++++++++++++++++++++++-------------------
 2 files changed, 81 insertions(+), 64 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/12/05 1.1498)
   [libata] fix use-after-free
   
   Fixes oops some were seeing on module unload.
   
   Caught by Jon Burgess.

<grundler@parisc-linux.org> (03/11/30 1.1489.3.2)
   [libata] use sg_dma_xxx macros
   
   Fixes build on some platforms, fixes issues on others.

<jgarzik@redhat.com> (03/11/26 1.1489.3.1)
   [libata] Fix PDC20621: we only have one Host DMA engine, not one per port
   
   Whoops.  So, we need to queue HDMA transactions internally.

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Fri Dec  5 13:14:13 2003
+++ b/drivers/scsi/libata-core.c	Fri Dec  5 13:14:13 2003
@@ -1635,8 +1635,8 @@
 	if (cmd->use_sg)
 		pci_unmap_sg(ap->host_set->pdev, sg, qc->n_elem, dir);
 	else
-		pci_unmap_single(ap->host_set->pdev, sg[0].dma_address,
-				 sg[0].length, dir);
+		pci_unmap_single(ap->host_set->pdev, sg_dma_address(&sg[0]),
+				 sg_dma_len(&sg[0]), dir);
 
 	qc->flags &= ~ATA_QCFLAG_SG;
 	qc->sg = NULL;
@@ -1659,8 +1659,8 @@
 	assert(qc->n_elem > 0);
 
 	for (i = 0; i < qc->n_elem; i++) {
-		ap->prd[i].addr = cpu_to_le32(sg[i].dma_address);
-		ap->prd[i].flags_len = cpu_to_le32(sg[i].length);
+		ap->prd[i].addr = cpu_to_le32(sg_dma_address(&sg[i]));
+		ap->prd[i].flags_len = cpu_to_le32(sg_dma_len(&sg[i]));
 		VPRINTK("PRD[%u] = (0x%X, 0x%X)\n",
 			i, le32_to_cpu(ap->prd[i].addr), le32_to_cpu(ap->prd[i].flags_len));
 	}
@@ -1691,12 +1691,12 @@
 
 	sg->page = virt_to_page(cmd->request_buffer);
 	sg->offset = (unsigned long) cmd->request_buffer & ~PAGE_MASK;
-	sg->length = cmd->request_bufflen;
+	sg_dma_len(sg) = cmd->request_bufflen;
 
 	if (!have_sg)
 		return 0;
 
-	sg->dma_address = pci_map_single(ap->host_set->pdev,
+	sg_dma_address(sg) = pci_map_single(ap->host_set->pdev,
 					 cmd->request_buffer,
 					 cmd->request_bufflen, dir);
 
@@ -1917,7 +1917,7 @@
 	qc->cursg_ofs++;
 
 	if (cmd->use_sg)
-		if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg[qc->cursg].length) {
+		if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
 			qc->cursg++;
 			qc->cursg_ofs = 0;
 		}
@@ -3224,8 +3224,6 @@
 		scsi_host_put(ap->host); /* FIXME: check return val */
 	}
 
-	kfree(host_set);
-
 	pci_release_regions(pdev);
 
 	for (i = 0; i < host_set->n_ports; i++) {
@@ -3242,6 +3240,7 @@
 		}
 	}
 
+	kfree(host_set);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 }
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	Fri Dec  5 13:14:13 2003
+++ b/drivers/scsi/sata_promise.c	Fri Dec  5 13:14:13 2003
@@ -34,10 +34,8 @@
 #include <linux/libata.h>
 #include <asm/io.h>
 
-#undef DIRECT_HDMA
-
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"0.86"
+#define DRV_VERSION	"0.87"
 
 
 enum {
@@ -82,6 +80,9 @@
 
 	PDC_FLAG_20621		= (1 << 30), /* we have a 20621 */
 	PDC_HDMA_RESET		= (1 << 11), /* HDMA reset */
+
+	PDC_MAX_HDMA		= 32,
+	PDC_HDMA_Q_MASK		= (PDC_MAX_HDMA - 1),
 };
 
 
@@ -89,6 +90,15 @@
 	u8			dimm_buf[(ATA_PRD_SZ * ATA_MAX_PRD) + 512];
 	u8			*pkt;
 	dma_addr_t		pkt_dma;
+
+	unsigned int		doing_hdma;
+	unsigned int		hdma_prod;
+	unsigned int		hdma_cons;
+	struct {
+		struct ata_queued_cmd *qc;
+		unsigned int	seq;
+		unsigned long	pkt_ofs;
+	} hdma[32];
 };
 
 
@@ -256,6 +266,7 @@
 		rc = -ENOMEM;
 		goto err_out;
 	}
+	memset(pp, 0, sizeof(*pp));
 
 	pp->pkt = pci_alloc_consistent(pdev, 128, &pp->pkt_dma);
 	if (!pp->pkt) {
@@ -605,8 +616,8 @@
 	last = qc->n_elem;
 	idx = 0;
 	for (i = 0; i < last; i++) {
-		buf[idx++] = cpu_to_le32(sg[i].dma_address);
-		buf[idx++] = cpu_to_le32(sg[i].length);
+		buf[idx++] = cpu_to_le32(sg_dma_address(&sg[i]));
+		buf[idx++] = cpu_to_le32(sg_dma_len(&sg[i]));
 		total_len += sg[i].length;
 	}
 	buf[idx - 1] |= cpu_to_le32(ATA_PRD_EOT);
@@ -643,42 +654,60 @@
 	VPRINTK("ata pkt buf ofs %u, prd size %u, mmio copied\n", i, sgt_len);
 }
 
-#ifdef DIRECT_HDMA
-static void pdc20621_push_hdma(struct ata_queued_cmd *qc)
+static void __pdc20621_push_hdma(struct ata_queued_cmd *qc,
+				 unsigned int seq,
+				 u32 pkt_ofs)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_host_set *host_set = ap->host_set;
-	unsigned int port_no = ap->port_no;
 	void *mmio = host_set->mmio_base;
-	unsigned int rw = (qc->flags & ATA_QCFLAG_WRITE);
-	u32 tmp;
-
-	unsigned int host_sg = PDC_20621_DIMM_BASE +
-			       (PDC_DIMM_WINDOW_STEP * port_no) +
-			       PDC_DIMM_HOST_PRD;
-	unsigned int dimm_sg = PDC_20621_DIMM_BASE +
-			       (PDC_DIMM_WINDOW_STEP * port_no) +
-			       PDC_DIMM_HPKT_PRD;
 
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
-	tmp = readl(mmio + PDC_HDMA_CTLSTAT) & 0xffffff00;
-	tmp |= port_no + 1 + 4;		/* seq. ID */
-	if (!rw)
-		tmp |= (1 << 6);	/* hdma data direction */
-	writel(tmp, mmio + PDC_HDMA_CTLSTAT); /* note: stops DMA, if active */
-	readl(mmio + PDC_HDMA_CTLSTAT);	/* flush */
-
-	writel(host_sg, mmio + 0x108);
-	writel(dimm_sg, mmio + 0x10C);
-	writel(0, mmio + 0x128);
-
-	tmp |= (1 << 7);
-	writel(tmp, mmio + PDC_HDMA_CTLSTAT);
-	readl(mmio + PDC_HDMA_CTLSTAT);	/* flush */
+	writel(0x00000001, mmio + PDC_20621_SEQCTL + (seq * 4));
+	readl(mmio + PDC_20621_SEQCTL + (seq * 4));	/* flush */
+
+	writel(pkt_ofs, mmio + PDC_HDMA_PKT_SUBMIT);
+	readl(mmio + PDC_HDMA_PKT_SUBMIT);	/* flush */
+}
+
+static void pdc20621_push_hdma(struct ata_queued_cmd *qc,
+				unsigned int seq,
+				u32 pkt_ofs)
+{
+	struct ata_port *ap = qc->ap;
+	struct pdc_port_priv *pp = ap->private_data;
+	unsigned int idx = pp->hdma_prod & PDC_HDMA_Q_MASK;
+
+	if (!pp->doing_hdma) {
+		__pdc20621_push_hdma(qc, seq, pkt_ofs);
+		pp->doing_hdma = 1;
+		return;
+	}
+
+	pp->hdma[idx].qc = qc;
+	pp->hdma[idx].seq = seq;
+	pp->hdma[idx].pkt_ofs = pkt_ofs;
+	pp->hdma_prod++;
+}
+
+static void pdc20621_pop_hdma(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct pdc_port_priv *pp = ap->private_data;
+	unsigned int idx = pp->hdma_cons & PDC_HDMA_Q_MASK;
+
+	/* if nothing on queue, we're done */
+	if (pp->hdma_prod == pp->hdma_cons) {
+		pp->doing_hdma = 0;
+		return;
+	}
+
+	__pdc20621_push_hdma(pp->hdma[idx].qc, pp->hdma[idx].seq,
+			     pp->hdma[idx].pkt_ofs);
+	pp->hdma_cons++;
 }
-#endif
 
 #ifdef ATA_VERBOSE_DEBUG
 static void pdc20621_dump_hdma(struct ata_queued_cmd *qc)
@@ -724,23 +753,17 @@
 
 	wmb();			/* flush PRD, pkt writes */
 
-	writel(0x00000001, mmio + PDC_20621_SEQCTL + (seq * 4));
-	readl(mmio + PDC_20621_SEQCTL + (seq * 4));	/* flush */
-
 	if (doing_hdma) {
 		pdc20621_dump_hdma(qc);
-#ifdef DIRECT_HDMA
-		pdc20621_push_hdma(qc);
-#else
-		writel(port_ofs + PDC_DIMM_HOST_PKT,
-		       mmio + PDC_HDMA_PKT_SUBMIT);
-		readl(mmio + PDC_HDMA_PKT_SUBMIT);	/* flush */
-#endif
-		VPRINTK("submitted ofs 0x%x (%u), seq %u\n",
-		port_ofs + PDC_DIMM_HOST_PKT,
-		port_ofs + PDC_DIMM_HOST_PKT,
-		seq);
+		pdc20621_push_hdma(qc, seq, port_ofs + PDC_DIMM_HOST_PKT);
+		VPRINTK("queued ofs 0x%x (%u), seq %u\n",
+			port_ofs + PDC_DIMM_HOST_PKT,
+			port_ofs + PDC_DIMM_HOST_PKT,
+			seq);
 	} else {
+		writel(0x00000001, mmio + PDC_20621_SEQCTL + (seq * 4));
+		readl(mmio + PDC_20621_SEQCTL + (seq * 4));	/* flush */
+
 		writel(port_ofs + PDC_DIMM_ATA_PKT,
 		       (void *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
 		readl((void *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
@@ -771,6 +794,7 @@
 			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			pdc_dma_complete(ap, qc);
+			pdc20621_pop_hdma(qc);
 		}
 
 		/* step one - exec ATA command */
@@ -781,15 +805,8 @@
 
 			/* submit hdma pkt */
 			pdc20621_dump_hdma(qc);
-			writel(0x00000001, mmio + PDC_20621_SEQCTL + (seq * 4));
-			readl(mmio + PDC_20621_SEQCTL + (seq * 4));
-#ifdef DIRECT_HDMA
-			pdc20621_push_hdma(qc);
-#else
-			writel(port_ofs + PDC_DIMM_HOST_PKT,
-			       mmio + PDC_HDMA_PKT_SUBMIT);
-			readl(mmio + PDC_HDMA_PKT_SUBMIT);
-#endif
+			pdc20621_push_hdma(qc, seq,
+					   port_ofs + PDC_DIMM_HOST_PKT);
 		}
 		handled = 1;
 		break;
@@ -814,6 +831,7 @@
 			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			pdc_dma_complete(ap, qc);
+			pdc20621_pop_hdma(qc);
 		}
 		handled = 1;
 		break;

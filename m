Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWI2NIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWI2NIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 09:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWI2NIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 09:08:43 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:58240 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1030211AbWI2NIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 09:08:42 -0400
Subject: [PATCH] ioremap balanced with iounmap for drivers/scsi
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 18:42:01 +0530
Message-Id: <1159535521.7264.47.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only) with:
- allmodconfig
- Modifying drivers/scsi/Kconfig to make sure that the changed file is
compiling without warning

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
Forwarding to lkml as got no response from linux-scsi
---
 3w-9xxx.c       |    5 +++++
 amiga7xx.c      |    2 ++
 fdomain.c       |    6 +++++-
 ncr53c8xx.c     |    2 ++
 nsp32.c         |    5 +++++
 qlogicpti.c     |    1 +
 seagate.c       |   13 ++++++++++++-
 sun3_scsi.c     |    7 ++++++-
 sun3_scsi_vme.c |    5 ++++-
 zalon.c         |    2 ++
 10 files changed, 44 insertions(+), 4 deletions(-)
---
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/3w-9xxx.c linux-2.6.18/drivers/scsi/3w-9xxx.c
--- linux-2.6.18-orig/drivers/scsi/3w-9xxx.c	2006-09-21 10:15:38.000000000 +0530
+++ linux-2.6.18/drivers/scsi/3w-9xxx.c	2006-09-25 18:14:51.000000000 +0530
@@ -2147,6 +2147,8 @@ out_remove_host:
 	scsi_remove_host(host);
 out_release_mem_region:
 	pci_release_regions(pdev);
+	if (tw_dev->base_addr)
+		iounmap(tw_dev->base_addr);
 out_free_device_extension:
 	twa_free_device_extension(tw_dev);
 	scsi_host_put(host);
@@ -2173,6 +2175,9 @@ static void twa_remove(struct pci_dev *p
 	/* Free up the IRQ */
 	free_irq(tw_dev->tw_pci_dev->irq, tw_dev);
 
+	/* Free IO mem */
+	iounmap(tw_dev->base_addr);
+
 	/* Shutdown the card */
 	__twa_shutdown(tw_dev);
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/amiga7xx.c linux-2.6.18/drivers/scsi/amiga7xx.c
--- linux-2.6.18-orig/drivers/scsi/amiga7xx.c	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.18/drivers/scsi/amiga7xx.c	2006-09-26 10:37:34.000000000 +0530
@@ -115,6 +115,8 @@ static int amiga7xx_release(struct Scsi_
 		free_irq(shost->irq, NULL);
 	if (shost->dma_channel != 0xff)
 		free_dma(shost->dma_channel);
+	if (shost->base)
+		z_iounmap((void *)shost->base);
 	if (shost->io_port && shost->n_io_port)
 		release_region(shost->io_port, shost->n_io_port);
 	scsi_unregister(shost);
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/fdomain.c linux-2.6.18/drivers/scsi/fdomain.c
--- linux-2.6.18-orig/drivers/scsi/fdomain.c	2006-09-21 10:15:39.000000000 +0530
+++ linux-2.6.18/drivers/scsi/fdomain.c	2006-09-25 18:15:26.000000000 +0530
@@ -780,7 +780,11 @@ found:
    else      printk( " FAILURE\n" );
 #endif
 
-   if (!flag) return 0;		/* iobase not found */
+   if (!flag) {
+	  if (bios_mem)
+		 iounmap(bios_mem);
+	  return 0;		/* iobase not found */
+   }
 
    *irq    = fdomain_get_irq( base );
    *iobase = base;
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/ncr53c8xx.c linux-2.6.18/drivers/scsi/ncr53c8xx.c
--- linux-2.6.18-orig/drivers/scsi/ncr53c8xx.c	2006-09-21 10:15:40.000000000 +0530
+++ linux-2.6.18/drivers/scsi/ncr53c8xx.c	2006-09-25 18:15:26.000000000 +0530
@@ -8563,6 +8563,8 @@ struct Scsi_Host * __init ncr_attach(str
 		m_free_dma(np->script0, sizeof(struct script), "SCRIPT");
 	if (np->ccb)
 		m_free_dma(np->ccb, sizeof(struct ccb), "CCB");
+	if (!device->slot.base_v && np->vaddr)
+		iounmap(np->vaddr);
 	m_free_dma(np, sizeof(struct ncb), "NCB");
 	host_data->ncb = NULL;
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/nsp32.c linux-2.6.18/drivers/scsi/nsp32.c
--- linux-2.6.18-orig/drivers/scsi/nsp32.c	2006-09-21 10:15:40.000000000 +0530
+++ linux-2.6.18/drivers/scsi/nsp32.c	2006-09-25 18:15:26.000000000 +0530
@@ -3540,6 +3540,11 @@ static int __devinit nsp32_probe(struct 
 
 	nsp32_dbg(NSP32_DEBUG_REGISTER, "exit %d", ret);
 
+	if (ret) {
+		iounmap(data->MmioAddress);
+		data->MmioAddress = NULL;
+	}
+
 	return ret;
 }
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/qlogicpti.c linux-2.6.18/drivers/scsi/qlogicpti.c
--- linux-2.6.18-orig/drivers/scsi/qlogicpti.c	2006-09-21 10:15:40.000000000 +0530
+++ linux-2.6.18/drivers/scsi/qlogicpti.c	2006-09-25 18:15:26.000000000 +0530
@@ -699,6 +699,7 @@ static int __init qpti_map_regs(struct q
 					  "PTI Qlogic/ISP statreg");
 		if (!qpti->sreg) {
 			printk("PTI: Qlogic/ISP status register is unmappable\n");
+			sbus_iounmap(qpti->qregs, qpti->sdev->reg_addrs[0].reg_size);
 			return -1;
 		}
 	}
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/seagate.c linux-2.6.18/drivers/scsi/seagate.c
--- linux-2.6.18-orig/drivers/scsi/seagate.c	2006-09-21 10:15:40.000000000 +0530
+++ linux-2.6.18/drivers/scsi/seagate.c	2006-09-25 18:15:26.000000000 +0530
@@ -493,12 +493,19 @@ int __init seagate_st0x_detect (struct s
 	 *	if we lose our first interrupt.
 	 */
 	instance = scsi_register (tpnt, 0);
-	if (instance == NULL)
+	if (instance == NULL) {
+		iounmap(st0x_cr_sr);
+		iounmap(st0x_dr);
+		st0x_cr_sr = st0x_dr = NULL;
 		return 0;
+	}
 
 	hostno = instance->host_no;
 	if (request_irq (irq, do_seagate_reconnect_intr, IRQF_DISABLED, (controller_type == SEAGATE) ? "seagate" : "tmc-8xx", instance)) {
 		printk(KERN_ERR "scsi%d : unable to allocate IRQ%d\n", hostno, irq);
+		iounmap(st0x_cr_sr);
+		iounmap(st0x_dr);
+		st0x_cr_sr = st0x_dr = NULL;
 		return 0;
 	}
 	instance->irq = irq;
@@ -1645,6 +1652,10 @@ static int seagate_st0x_release(struct S
 {
 	if (shost->irq)
 		free_irq(shost->irq, shost);
+	if (st0x_cr_sr)
+		iounmap(st0x_cr_sr);
+	if (st0x_dr)
+		iounmap(st0x_dr);
 	release_region(shost->io_port, shost->n_io_port);
 	return 0;
 }
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/sun3_scsi.c linux-2.6.18/drivers/scsi/sun3_scsi.c
--- linux-2.6.18-orig/drivers/scsi/sun3_scsi.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/scsi/sun3_scsi.c	2006-09-25 17:39:53.000000000 +0530
@@ -240,11 +240,13 @@ int sun3scsi_detect(struct scsi_host_tem
 	if((udc_regs = dvma_malloc(sizeof(struct sun3_udc_regs)))
 	   == NULL) {
 	     printk("SUN3 Scsi couldn't allocate DVMA memory!\n");
+		 iounmap((void*)ioaddr);
 	     return 0;
 	}
 #ifdef OLDDMA
 	if((dmabuf = dvma_malloc_align(SUN3_DVMA_BUFSIZE, 0x10000)) == NULL) {
 	     printk("SUN3 Scsi couldn't allocate DVMA memory!\n");
+		 iounmap((void*)ioaddr);
 	     return 0;
 	}
 #endif
@@ -254,8 +256,10 @@ int sun3scsi_detect(struct scsi_host_tem
 #endif
 
 	instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
-	if(instance == NULL)
+	if(instance == NULL) {
+		iounmap((void*)ioaddr);
 		return 0;
+	}
 		
 	default_instance = instance;
 
@@ -277,6 +281,7 @@ int sun3scsi_detect(struct scsi_host_tem
 #else
 		printk("scsi%d: IRQ%d not free, bailing out\n",
 		       instance->host_no, instance->irq);
+		iounmap((void*)ioaddr);
 		return 0;
 #endif
 	}
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/sun3_scsi_vme.c linux-2.6.18/drivers/scsi/sun3_scsi_vme.c
--- linux-2.6.18-orig/drivers/scsi/sun3_scsi_vme.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/scsi/sun3_scsi_vme.c	2006-09-25 18:15:26.000000000 +0530
@@ -216,8 +216,10 @@ static int sun3scsi_detect(struct scsi_h
 #endif
 
 	instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
-	if(instance == NULL)
+	if(instance == NULL) {
+		iounmap((void *)ioaddr);
 		return 0;
+	}
 		
 	default_instance = instance;
 
@@ -239,6 +241,7 @@ static int sun3scsi_detect(struct scsi_h
 #else
 		printk("scsi%d: IRQ%d not free, bailing out\n",
 		       instance->host_no, instance->irq);
+		iounmap((void *)ioaddr);
 		return 0;
 #endif
 	}
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/scsi/zalon.c linux-2.6.18/drivers/scsi/zalon.c
--- linux-2.6.18-orig/drivers/scsi/zalon.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/scsi/zalon.c	2006-09-26 10:43:35.000000000 +0530
@@ -156,6 +156,8 @@ zalon_probe(struct parisc_device *dev)
  fail_free_irq:
 	free_irq(dev->irq, host);
  fail:
+	if (zalon)
+		iounmap(zalon);
 	ncr53c8xx_release(host);
 	return error;
 }





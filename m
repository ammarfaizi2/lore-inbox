Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266857AbTGGGjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 02:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266858AbTGGGjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 02:39:16 -0400
Received: from dp.samba.org ([66.70.73.150]:58022 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266857AbTGGGjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 02:39:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16137.6380.637601.228142@cargo.ozlabs.ibm.com>
Date: Mon, 7 Jul 2003 16:53:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.74] fix IDE init oops on PowerMac
In-Reply-To: <1057519727.503.72.camel@gaston>
References: <200307040016.h640GV7o018321@harpo.it.uu.se>
	<1057519727.503.72.camel@gaston>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> On Fri, 2003-07-04 at 02:16, Mikael Pettersson wrote:
> >The patch below updates drivers/ide/ppc/pmac.c to also set up the
> > hwif->ide_dma_queued_off and hwif->ide_dma_queued_on function
> > pointers, which fixes the oops. Tested on my ancient PM4400.
> 
> Patch is fine, actually, it's already in my tree though my version
> of this driver isn't merged yet as it depends on the other changes
> to the "macio" driver model that I haven't pushed upstream so far.

I have been using this patch, which includes the fix to set
ide_dma_queued_off/on and also sets ide_dma_queued_read/write/start.
It additionally changes pmac_ide_setup_dma() to take the ide_hwif_t *
instead of a device node and index, which makes it a bit cleaner and
reduces the number of references to ide_hwifs[].  The patch is against
Linus' tree (without Mikael's patch).

Paul.

diff -urN linux-2.5/drivers/ide/ppc/pmac.c pmac-2.5/drivers/ide/ppc/pmac.c
--- linux-2.5/drivers/ide/ppc/pmac.c	2003-05-26 11:23:43.000000000 +1000
+++ pmac-2.5/drivers/ide/ppc/pmac.c	2003-06-28 19:51:12.000000000 +1000
@@ -245,7 +245,7 @@
  */
 #define IDE_WAKEUP_DELAY_MS	2000
 
-static void pmac_ide_setup_dma(struct device_node *np, int ix);
+static void pmac_ide_setup_dma(ide_hwif_t *hwif);
 static int pmac_ide_build_dmatable(ide_drive_t *drive, int wr);
 static int pmac_ide_tune_chipset(ide_drive_t *drive, u8 speed);
 static void pmac_ide_tuneproc(ide_drive_t *drive, u8 pio);
@@ -909,7 +909,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 		if (np->n_addrs >= 2) {
 			/* has a DBDMA controller channel */
-			pmac_ide_setup_dma(np, i);
+			pmac_ide_setup_dma(hwif);
 		}
 		hwif->atapi_dma = 1;
 		hwif->ultra_mask = 0x1f;
@@ -1461,9 +1461,10 @@
 }
 
 static void __init 
-pmac_ide_setup_dma(struct device_node *np, int ix)
+pmac_ide_setup_dma(ide_hwif_t *hwif)
 {
-	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
+	struct pmac_ide_hwif *pmif = hwif->hwif_data;
+	struct device_node *np = pmif->node;
 
 	if (request_OF_resource(np, 1, " (mac-io IDE DMA)") == NULL) {
 		printk(KERN_ERR "ide-pmac(%s): can't request DMA resource !\n", np->name);
@@ -1479,48 +1480,57 @@
 	 * aligning the start address to a multiple of 16 bytes.
 	 */
 	pmif->dma_table_cpu = (struct dbdma_cmd*)pci_alloc_consistent(
-		ide_hwifs[ix].pci_dev,
+		hwif->pci_dev,
 		(MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
 		&pmif->dma_table_dma);
 	if (pmif->dma_table_cpu == NULL) {
 		printk(KERN_ERR "%s: unable to allocate DMA command list\n",
-		       ide_hwifs[ix].name);
+		       hwif->name);
 		return;
 	}
 
 	pmif->sg_table = kmalloc(sizeof(struct scatterlist) * MAX_DCMDS,
 				 GFP_KERNEL);
 	if (pmif->sg_table == NULL) {
-		pci_free_consistent(	ide_hwifs[ix].pci_dev,
+		pci_free_consistent(	hwif->pci_dev,
 					(MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
 				    	pmif->dma_table_cpu, pmif->dma_table_dma);
 		return;
 	}
-	ide_hwifs[ix].ide_dma_off = &__ide_dma_off;
-	ide_hwifs[ix].ide_dma_off_quietly = &__ide_dma_off_quietly;
-	ide_hwifs[ix].ide_dma_on = &__ide_dma_on;
-	ide_hwifs[ix].ide_dma_check = &pmac_ide_dma_check;
-	ide_hwifs[ix].ide_dma_read = &pmac_ide_dma_read;
-	ide_hwifs[ix].ide_dma_write = &pmac_ide_dma_write;
-	ide_hwifs[ix].ide_dma_count = &pmac_ide_dma_count;
-	ide_hwifs[ix].ide_dma_begin = &pmac_ide_dma_begin;
-	ide_hwifs[ix].ide_dma_end = &pmac_ide_dma_end;
-	ide_hwifs[ix].ide_dma_test_irq = &pmac_ide_dma_test_irq;
-	ide_hwifs[ix].ide_dma_host_off = &pmac_ide_dma_host_off;
-	ide_hwifs[ix].ide_dma_host_on = &pmac_ide_dma_host_on;
-	ide_hwifs[ix].ide_dma_good_drive = &__ide_dma_good_drive;
-	ide_hwifs[ix].ide_dma_bad_drive = &__ide_dma_bad_drive;
-	ide_hwifs[ix].ide_dma_verbose = &__ide_dma_verbose;
-	ide_hwifs[ix].ide_dma_timeout = &__ide_dma_timeout;
-	ide_hwifs[ix].ide_dma_retune = &__ide_dma_retune;
-	ide_hwifs[ix].ide_dma_lostirq = &pmac_ide_dma_lostirq;
+	hwif->ide_dma_off = &__ide_dma_off;
+	hwif->ide_dma_off_quietly = &__ide_dma_off_quietly;
+	hwif->ide_dma_host_off = &pmac_ide_dma_host_off;
+	hwif->ide_dma_on = &__ide_dma_on;
+	hwif->ide_dma_host_on = &pmac_ide_dma_host_on;
+	hwif->ide_dma_check = &pmac_ide_dma_check;
+	hwif->ide_dma_read = &pmac_ide_dma_read;
+	hwif->ide_dma_write = &pmac_ide_dma_write;
+	hwif->ide_dma_count = &pmac_ide_dma_count;
+	hwif->ide_dma_begin = &pmac_ide_dma_begin;
+	hwif->ide_dma_end = &pmac_ide_dma_end;
+	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
+	hwif->ide_dma_bad_drive = &__ide_dma_bad_drive;
+	hwif->ide_dma_good_drive = &__ide_dma_good_drive;
+	hwif->ide_dma_verbose = &__ide_dma_verbose;
+	hwif->ide_dma_timeout = &__ide_dma_timeout;
+	hwif->ide_dma_retune = &__ide_dma_retune;
+	hwif->ide_dma_lostirq = &pmac_ide_dma_lostirq;
+
+	/* dma queued ops. */
+	hwif->ide_dma_queued_on = __ide_dma_queued_on;
+	hwif->ide_dma_queued_off = __ide_dma_queued_off;
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	hwif->ide_dma_queued_read = __ide_dma_queued_read;
+	hwif->ide_dma_queued_write = __ide_dma_queued_write;
+	hwif->ide_dma_queued_start = __ide_dma_queued_start;
+#endif
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 	if (!noautodma)
-		ide_hwifs[ix].autodma = 1;
+		hwif->autodma = 1;
 #endif
-	ide_hwifs[ix].drives[0].autodma = ide_hwifs[ix].autodma;
-	ide_hwifs[ix].drives[1].autodma = ide_hwifs[ix].autodma;
+	hwif->drives[0].autodma = hwif->autodma;
+	hwif->drives[1].autodma = hwif->autodma;
 }
 
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */

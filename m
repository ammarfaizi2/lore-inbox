Return-Path: <linux-kernel-owner+w=401wt.eu-S964986AbWLTMDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWLTMDB (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWLTMCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:02:48 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1655 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964977AbWLTMCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:02:32 -0500
Date: Wed, 20 Dec 2006 12:02:27 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 10/10] dec_esp: Driver model for the PMAZ-A
Message-ID: <Pine.LNX.4.64N.0612201123520.11005@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is a set of changes that converts the PMAZ-A support to the driver
model.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 The use of the driver model required switching to the hotplug SCSI 
initialization model, which in turn required a change to the core NCR53C9x 
driver.  I decided not to break all the frontend drivers and introduced an 
additional parameter for esp_allocate() to select between the old and the 
new model.  I hope this is OK, but I would be fine with converting 
NCR53C9x to the new model unconditionally as long as I do not have to fix 
all the other frontends (OK, perhaps I could do some of them ;-) ).

 Please apply.

  Maciej

patch-2.6.20-rc1-tc-pmaz-a-5
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/NCR53C9x.c linux-2.6.20-rc1/drivers/scsi/NCR53C9x.c
--- linux-2.6.20-rc1.macro/drivers/scsi/NCR53C9x.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/NCR53C9x.c	2006-12-18 21:29:38.000000000 +0000
@@ -528,12 +528,16 @@ void esp_bootup_reset(struct NCR_ESP *es
 /* Allocate structure and insert basic data such as SCSI chip frequency
  * data and a pointer to the device
  */
-struct NCR_ESP* esp_allocate(struct scsi_host_template *tpnt, void *esp_dev)
+struct NCR_ESP* esp_allocate(struct scsi_host_template *tpnt, void *esp_dev,
+			     int hotplug)
 {
 	struct NCR_ESP *esp, *elink;
 	struct Scsi_Host *esp_host;
 
-	esp_host = scsi_register(tpnt, sizeof(struct NCR_ESP));
+	if (hotplug)
+		esp_host = scsi_host_alloc(tpnt, sizeof(struct NCR_ESP));
+	else
+		esp_host = scsi_register(tpnt, sizeof(struct NCR_ESP));
 	if(!esp_host)
 		panic("Cannot register ESP SCSI host");
 	esp = (struct NCR_ESP *) esp_host->hostdata;
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/NCR53C9x.h linux-2.6.20-rc1/drivers/scsi/NCR53C9x.h
--- linux-2.6.20-rc1.macro/drivers/scsi/NCR53C9x.h	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/NCR53C9x.h	2006-12-18 21:29:38.000000000 +0000
@@ -652,7 +652,7 @@ extern int nesps, esps_in_use, esps_runn
 
 /* External functions */
 extern void esp_bootup_reset(struct NCR_ESP *esp, struct ESP_regs *eregs);
-extern struct NCR_ESP *esp_allocate(struct scsi_host_template *, void *);
+extern struct NCR_ESP *esp_allocate(struct scsi_host_template *, void *, int);
 extern void esp_deallocate(struct NCR_ESP *);
 extern void esp_release(void);
 extern void esp_initialize(struct NCR_ESP *);
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/blz1230.c linux-2.6.20-rc1/drivers/scsi/blz1230.c
--- linux-2.6.20-rc1.macro/drivers/scsi/blz1230.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/blz1230.c	2006-12-18 21:29:38.000000000 +0000
@@ -121,7 +121,8 @@ int __init blz1230_esp_detect(struct scs
 		 */
 		address = ZTWO_VADDR(board);
 		eregs = (struct ESP_regs *)(address + REAL_BLZ1230_ESP_ADDR);
-		esp = esp_allocate(tpnt, (void *)board+REAL_BLZ1230_ESP_ADDR);
+		esp = esp_allocate(tpnt, (void *)board + REAL_BLZ1230_ESP_ADDR,
+				   0);
 
 		esp_write(eregs->esp_cfg1, (ESP_CONFIG1_PENABLE | 7));
 		udelay(5);
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/blz2060.c linux-2.6.20-rc1/drivers/scsi/blz2060.c
--- linux-2.6.20-rc1.macro/drivers/scsi/blz2060.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/blz2060.c	2006-12-18 21:29:38.000000000 +0000
@@ -100,7 +100,7 @@ int __init blz2060_esp_detect(struct scs
 	    unsigned long board = z->resource.start;
 	    if (request_mem_region(board+BLZ2060_ESP_ADDR,
 				   sizeof(struct ESP_regs), "NCR53C9x")) {
-		esp = esp_allocate(tpnt, (void *)board+BLZ2060_ESP_ADDR);
+		esp = esp_allocate(tpnt, (void *)board + BLZ2060_ESP_ADDR, 0);
 
 		/* Do command transfer with programmed I/O */
 		esp->do_pio_cmds = 1;
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/cyberstorm.c linux-2.6.20-rc1/drivers/scsi/cyberstorm.c
--- linux-2.6.20-rc1.macro/drivers/scsi/cyberstorm.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/cyberstorm.c	2006-12-18 21:29:38.000000000 +0000
@@ -126,7 +126,7 @@ int __init cyber_esp_detect(struct scsi_
 					   sizeof(struct ESP_regs));
 			return 0;
 		}
-		esp = esp_allocate(tpnt, (void *)board+CYBER_ESP_ADDR);
+		esp = esp_allocate(tpnt, (void *)board + CYBER_ESP_ADDR, 0);
 
 		/* Do command transfer with programmed I/O */
 		esp->do_pio_cmds = 1;
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/cyberstormII.c linux-2.6.20-rc1/drivers/scsi/cyberstormII.c
--- linux-2.6.20-rc1.macro/drivers/scsi/cyberstormII.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/cyberstormII.c	2006-12-18 21:29:38.000000000 +0000
@@ -98,7 +98,7 @@ int __init cyberII_esp_detect(struct scs
 		address = (unsigned long)ZTWO_VADDR(board);
 		eregs = (struct ESP_regs *)(address + CYBERII_ESP_ADDR);
 
-		esp = esp_allocate(tpnt, (void *)board+CYBERII_ESP_ADDR);
+		esp = esp_allocate(tpnt, (void *)board + CYBERII_ESP_ADDR, 0);
 
 		esp_write(eregs->esp_cfg1, (ESP_CONFIG1_PENABLE | 7));
 		udelay(5);
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/dec_esp.c linux-2.6.20-rc1/drivers/scsi/dec_esp.c
--- linux-2.6.20-rc1.macro/drivers/scsi/dec_esp.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/dec_esp.c	2006-12-18 21:29:38.000000000 +0000
@@ -18,7 +18,7 @@
  * 20001005	- Initialization fixes for 2.4.0-test9
  * 			  Florian Lohoff <flo@rfc822.org>
  *
- *	Copyright (C) 2002, 2003, 2005  Maciej W. Rozycki
+ *	Copyright (C) 2002, 2003, 2005, 2006  Maciej W. Rozycki
  */
 
 #include <linux/kernel.h>
@@ -30,6 +30,7 @@
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/stat.h>
+#include <linux/tc.h>
 
 #include <asm/dma.h>
 #include <asm/irq.h>
@@ -42,7 +43,6 @@
 #include <asm/dec/ioasic_ints.h>
 #include <asm/dec/machtype.h>
 #include <asm/dec/system.h>
-#include <asm/dec/tc.h>
 
 #define DEC_SCSI_SREG 0
 #define DEC_SCSI_DMAREG 0x40000
@@ -98,51 +98,33 @@ static irqreturn_t scsi_dma_merr_int(int
 static irqreturn_t scsi_dma_err_int(int, void *);
 static irqreturn_t scsi_dma_int(int, void *);
 
-static int dec_esp_detect(struct scsi_host_template * tpnt);
-
-static int dec_esp_release(struct Scsi_Host *shost)
-{
-	if (shost->irq)
-		free_irq(shost->irq, NULL);
-	if (shost->io_port && shost->n_io_port)
-		release_region(shost->io_port, shost->n_io_port);
-	scsi_unregister(shost);
-	return 0;
-}
-
-static struct scsi_host_template driver_template = {
-	.proc_name		= "dec_esp",
-	.proc_info		= esp_proc_info,
+static struct scsi_host_template dec_esp_template = {
+	.module			= THIS_MODULE,
 	.name			= "NCR53C94",
-	.detect			= dec_esp_detect,
-	.slave_alloc		= esp_slave_alloc,
-	.slave_destroy		= esp_slave_destroy,
-	.release		= dec_esp_release,
 	.info			= esp_info,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
 	.eh_bus_reset_handler	= esp_reset,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
+	.proc_info		= esp_proc_info,
+	.proc_name		= "dec_esp",
 	.can_queue		= 7,
-	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= 1,
 	.use_clustering		= DISABLE_CLUSTERING,
 };
 
-
-#include "scsi_module.c"
+static struct NCR_ESP *dec_esp_platform;
 
 /***************************************************************** Detection */
-static int dec_esp_detect(struct scsi_host_template * tpnt)
+static int dec_esp_platform_probe(void)
 {
 	struct NCR_ESP *esp;
-	struct ConfigDev *esp_dev;
-	int slot;
-	unsigned long mem_start;
+	int err = 0;
 
 	if (IOASIC) {
-		esp_dev = 0;
-		esp = esp_allocate(tpnt, (void *) esp_dev);
+		esp = esp_allocate(&dec_esp_template, NULL, 1);
 
 		/* Do command transfer with programmed I/O */
 		esp->do_pio_cmds = 1;
@@ -200,112 +182,175 @@ static int dec_esp_detect(struct scsi_ho
 		/* Check for differential SCSI-bus */
 		esp->diff = 0;
 
+		err = request_irq(esp->irq, esp_intr, IRQF_DISABLED,
+				  "ncr53c94", esp->ehost);
+		if (err)
+			goto err_alloc;
+		err = request_irq(dec_interrupt[DEC_IRQ_ASC_MERR],
+				  scsi_dma_merr_int, IRQF_DISABLED,
+				  "ncr53c94 error", esp->ehost);
+		if (err)
+			goto err_irq;
+		err = request_irq(dec_interrupt[DEC_IRQ_ASC_ERR],
+				  scsi_dma_err_int, IRQF_DISABLED,
+				  "ncr53c94 overrun", esp->ehost);
+		if (err)
+			goto err_irq_merr;
+		err = request_irq(dec_interrupt[DEC_IRQ_ASC_DMA], scsi_dma_int,
+				  IRQF_DISABLED, "ncr53c94 dma", esp->ehost);
+		if (err)
+			goto err_irq_err;
+
 		esp_initialize(esp);
 
-		if (request_irq(esp->irq, esp_intr, IRQF_DISABLED,
-				"ncr53c94", esp->ehost))
-			goto err_dealloc;
-		if (request_irq(dec_interrupt[DEC_IRQ_ASC_MERR],
-				scsi_dma_merr_int, IRQF_DISABLED,
-				"ncr53c94 error", esp->ehost))
-			goto err_free_irq;
-		if (request_irq(dec_interrupt[DEC_IRQ_ASC_ERR],
-				scsi_dma_err_int, IRQF_DISABLED,
-				"ncr53c94 overrun", esp->ehost))
-			goto err_free_irq_merr;
-		if (request_irq(dec_interrupt[DEC_IRQ_ASC_DMA],
-				scsi_dma_int, IRQF_DISABLED,
-				"ncr53c94 dma", esp->ehost))
-			goto err_free_irq_err;
+		err = scsi_add_host(esp->ehost, NULL);
+		if (err) {
+			printk(KERN_ERR "ESP: Unable to register adapter\n");
+			goto err_irq_dma;
+ 		}
 
-	}
+		scsi_scan_host(esp->ehost);
 
-	if (TURBOCHANNEL) {
-		while ((slot = search_tc_card("PMAZ-AA")) >= 0) {
-			claim_tc_card(slot);
-
-			esp_dev = 0;
-			esp = esp_allocate(tpnt, (void *) esp_dev);
-
-			mem_start = get_tc_base_addr(slot);
-
-			/* Store base addr into esp struct */
-			esp->slot = CPHYSADDR(mem_start);
-
-			esp->dregs = 0;
-			esp->eregs = (void *)CKSEG1ADDR(mem_start +
-							DEC_SCSI_SREG);
-			esp->do_pio_cmds = 1;
-
-			/* Set the command buffer */
-			esp->esp_command = (volatile unsigned char *) pmaz_cmd_buffer;
-
-			/* get virtual dma address for command buffer */
-			esp->esp_command_dvma = virt_to_phys(pmaz_cmd_buffer);
-
-			esp->cfreq = get_tc_speed();
-
-			esp->irq = get_tc_irq_nr(slot);
-
-			/* Required functions */
-			esp->dma_bytes_sent = &dma_bytes_sent;
-			esp->dma_can_transfer = &dma_can_transfer;
-			esp->dma_dump_state = &dma_dump_state;
-			esp->dma_init_read = &pmaz_dma_init_read;
-			esp->dma_init_write = &pmaz_dma_init_write;
-			esp->dma_ints_off = &pmaz_dma_ints_off;
-			esp->dma_ints_on = &pmaz_dma_ints_on;
-			esp->dma_irq_p = &dma_irq_p;
-			esp->dma_ports_p = &dma_ports_p;
-			esp->dma_setup = &pmaz_dma_setup;
-
-			/* Optional functions */
-			esp->dma_barrier = 0;
-			esp->dma_drain = &pmaz_dma_drain;
-			esp->dma_invalidate = 0;
-			esp->dma_irq_entry = 0;
-			esp->dma_irq_exit = 0;
-			esp->dma_poll = 0;
-			esp->dma_reset = 0;
-			esp->dma_led_off = 0;
-			esp->dma_led_on = 0;
-
-			esp->dma_mmu_get_scsi_one = pmaz_dma_mmu_get_scsi_one;
-			esp->dma_mmu_get_scsi_sgl = 0;
-			esp->dma_mmu_release_scsi_one = 0;
-			esp->dma_mmu_release_scsi_sgl = 0;
-			esp->dma_advance_sg = 0;
-
- 			if (request_irq(esp->irq, esp_intr, IRQF_DISABLED,
- 					 "PMAZ_AA", esp->ehost)) {
- 				esp_deallocate(esp);
- 				release_tc_card(slot);
- 				continue;
- 			}
-			esp->scsi_id = 7;
-			esp->diff = 0;
-			esp_initialize(esp);
-		}
+		dec_esp_platform = esp;
 	}
 
-	if(nesps) {
-		printk("ESP: Total of %d ESP hosts found, %d actually in use.\n", nesps, esps_in_use);
-		esps_running = esps_in_use;
-		return esps_in_use;
-	}
 	return 0;
 
-err_free_irq_err:
-	free_irq(dec_interrupt[DEC_IRQ_ASC_ERR], scsi_dma_err_int);
-err_free_irq_merr:
-	free_irq(dec_interrupt[DEC_IRQ_ASC_MERR], scsi_dma_merr_int);
-err_free_irq:
-	free_irq(esp->irq, esp_intr);
-err_dealloc:
+err_irq_dma:
+	free_irq(dec_interrupt[DEC_IRQ_ASC_DMA], esp->ehost);
+err_irq_err:
+	free_irq(dec_interrupt[DEC_IRQ_ASC_ERR], esp->ehost);
+err_irq_merr:
+	free_irq(dec_interrupt[DEC_IRQ_ASC_MERR], esp->ehost);
+err_irq:
+	free_irq(esp->irq, esp->ehost);
+err_alloc:
 	esp_deallocate(esp);
+	scsi_host_put(esp->ehost);
+	return err;
+}
+
+static int __init dec_esp_probe(struct device *dev)
+{
+	struct NCR_ESP *esp;
+	resource_size_t start, len;
+	int err;
+
+	esp = esp_allocate(&dec_esp_template,  NULL, 1);
+
+	dev_set_drvdata(dev, esp);
+
+	start = to_tc_dev(dev)->resource.start;
+	len = to_tc_dev(dev)->resource.end - start + 1;
+
+	if (!request_mem_region(start, len, dev->bus_id)) {
+		printk(KERN_ERR "%s: Unable to reserve MMIO resource\n",
+		       dev->bus_id);
+		err = -EBUSY;
+		goto err_alloc;
+	}
+
+	/* Store base addr into esp struct.  */
+	esp->slot = start;
+
+	esp->dregs = 0;
+	esp->eregs = (void *)CKSEG1ADDR(start + DEC_SCSI_SREG);
+	esp->do_pio_cmds = 1;
+
+	/* Set the command buffer.  */
+	esp->esp_command = (volatile unsigned char *)pmaz_cmd_buffer;
+
+	/* Get virtual dma address for command buffer.  */
+	esp->esp_command_dvma = virt_to_phys(pmaz_cmd_buffer);
+
+	esp->cfreq = tc_get_speed(to_tc_dev(dev)->bus);
+
+	esp->irq = to_tc_dev(dev)->interrupt;
+
+	/* Required functions.  */
+	esp->dma_bytes_sent = &dma_bytes_sent;
+	esp->dma_can_transfer = &dma_can_transfer;
+	esp->dma_dump_state = &dma_dump_state;
+	esp->dma_init_read = &pmaz_dma_init_read;
+	esp->dma_init_write = &pmaz_dma_init_write;
+	esp->dma_ints_off = &pmaz_dma_ints_off;
+	esp->dma_ints_on = &pmaz_dma_ints_on;
+	esp->dma_irq_p = &dma_irq_p;
+	esp->dma_ports_p = &dma_ports_p;
+	esp->dma_setup = &pmaz_dma_setup;
+
+	/* Optional functions.  */
+	esp->dma_barrier = 0;
+	esp->dma_drain = &pmaz_dma_drain;
+	esp->dma_invalidate = 0;
+	esp->dma_irq_entry = 0;
+	esp->dma_irq_exit = 0;
+	esp->dma_poll = 0;
+	esp->dma_reset = 0;
+	esp->dma_led_off = 0;
+	esp->dma_led_on = 0;
+
+	esp->dma_mmu_get_scsi_one = pmaz_dma_mmu_get_scsi_one;
+	esp->dma_mmu_get_scsi_sgl = 0;
+	esp->dma_mmu_release_scsi_one = 0;
+	esp->dma_mmu_release_scsi_sgl = 0;
+	esp->dma_advance_sg = 0;
+
+ 	err = request_irq(esp->irq, esp_intr, IRQF_DISABLED, "PMAZ_AA",
+			  esp->ehost);
+	if (err) {
+		printk(KERN_ERR "%s: Unable to get IRQ %d\n",
+		       dev->bus_id, esp->irq);
+		goto err_resource;
+ 	}
+
+	esp->scsi_id = 7;
+	esp->diff = 0;
+	esp_initialize(esp);
+
+	err = scsi_add_host(esp->ehost, dev);
+	if (err) {
+		printk(KERN_ERR "%s: Unable to register adapter\n",
+		       dev->bus_id);
+		goto err_irq;
+ 	}
+
+	scsi_scan_host(esp->ehost);
+
 	return 0;
+
+err_irq:
+	free_irq(esp->irq, esp->ehost);
+
+err_resource:
+	release_mem_region(start, len);
+
+err_alloc:
+	esp_deallocate(esp);
+	scsi_host_put(esp->ehost);
+ 	return err;
 }
 
+static void __exit dec_esp_platform_remove(void)
+{
+	struct NCR_ESP *esp = dec_esp_platform;
+
+	free_irq(esp->irq, esp->ehost);
+	esp_deallocate(esp);
+	scsi_host_put(esp->ehost);
+	dec_esp_platform = NULL;
+}
+
+static void __exit dec_esp_remove(struct device *dev)
+{
+	struct NCR_ESP *esp = dev_get_drvdata(dev);
+
+	free_irq(esp->irq, esp->ehost);
+	esp_deallocate(esp);
+	scsi_host_put(esp->ehost);
+}
+
+
 /************************************************************* DMA Functions */
 static irqreturn_t scsi_dma_merr_int(int irq, void *dev_id)
 {
@@ -576,3 +621,67 @@ static void pmaz_dma_mmu_get_scsi_one(st
 {
 	sp->SCp.ptr = (char *)virt_to_phys(sp->request_buffer);
 }
+
+
+#ifdef CONFIG_TC
+static int __init dec_esp_tc_probe(struct device *dev);
+static int __exit dec_esp_tc_remove(struct device *dev);
+
+static const struct tc_device_id dec_esp_tc_table[] = {
+        { "DEC     ", "PMAZ-AA " },
+        { }
+};
+MODULE_DEVICE_TABLE(tc, dec_esp_tc_table);
+
+static struct tc_driver dec_esp_tc_driver = {
+        .id_table       = dec_esp_tc_table,
+        .driver         = {
+                .name   = "dec_esp",
+                .bus    = &tc_bus_type,
+                .probe  = dec_esp_tc_probe,
+                .remove = __exit_p(dec_esp_tc_remove),
+        },
+};
+
+static int __init dec_esp_tc_probe(struct device *dev)
+{
+	int status = dec_esp_probe(dev);
+	if (!status)
+		get_device(dev);
+	return status;
+}
+
+static int __exit dec_esp_tc_remove(struct device *dev)
+{
+	put_device(dev);
+	dec_esp_remove(dev);
+	return 0;
+}
+#endif
+
+static int __init dec_esp_init(void)
+{
+	int status;
+
+	status = tc_register_driver(&dec_esp_tc_driver);
+	if (!status)
+		dec_esp_platform_probe();
+
+	if (nesps) {
+		pr_info("ESP: Total of %d ESP hosts found, "
+			"%d actually in use.\n", nesps, esps_in_use);
+		esps_running = esps_in_use;
+	}
+
+	return status;
+}
+
+static void __exit dec_esp_exit(void)
+{
+	dec_esp_platform_remove();
+	tc_unregister_driver(&dec_esp_tc_driver);
+}
+
+
+module_init(dec_esp_init);
+module_exit(dec_esp_exit);
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/fastlane.c linux-2.6.20-rc1/drivers/scsi/fastlane.c
--- linux-2.6.20-rc1.macro/drivers/scsi/fastlane.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/fastlane.c	2006-12-18 21:29:38.000000000 +0000
@@ -142,7 +142,7 @@ int __init fastlane_esp_detect(struct sc
 		if (board < 0x1000000) {
 			goto err_release;
 		}
-		esp = esp_allocate(tpnt, (void *)board+FASTLANE_ESP_ADDR);
+		esp = esp_allocate(tpnt, (void *)board + FASTLANE_ESP_ADDR, 0);
 
 		/* Do command transfer with programmed I/O */
 		esp->do_pio_cmds = 1;
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/jazz_esp.c linux-2.6.20-rc1/drivers/scsi/jazz_esp.c
--- linux-2.6.20-rc1.macro/drivers/scsi/jazz_esp.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/jazz_esp.c	2006-12-18 21:29:38.000000000 +0000
@@ -75,7 +75,7 @@ static int jazz_esp_detect(struct scsi_h
      */
     if (1) {
 	esp_dev = NULL;
-	esp = esp_allocate(tpnt, (void *) esp_dev);
+	esp = esp_allocate(tpnt, esp_dev, 0);
 	
 	/* Do command transfer with programmed I/O */
 	esp->do_pio_cmds = 1;
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/mac_esp.c linux-2.6.20-rc1/drivers/scsi/mac_esp.c
--- linux-2.6.20-rc1.macro/drivers/scsi/mac_esp.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/mac_esp.c	2006-12-18 21:29:38.000000000 +0000
@@ -351,7 +351,7 @@ int mac_esp_detect(struct scsi_host_temp
 	for (chipnum = 0; chipnum < chipspresent; chipnum ++) {
 		struct NCR_ESP * esp;
 
-		esp = esp_allocate(tpnt, (void *) NULL);
+		esp = esp_allocate(tpnt, NULL, 0);
 		esp->eregs = (struct ESP_regs *) get_base(chipnum);
 
 		esp->dma_irq_p = &esp_dafb_dma_irq_p;
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/mca_53c9x.c linux-2.6.20-rc1/drivers/scsi/mca_53c9x.c
--- linux-2.6.20-rc1.macro/drivers/scsi/mca_53c9x.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/mca_53c9x.c	2006-12-18 21:29:38.000000000 +0000
@@ -122,7 +122,7 @@ static int mca_esp_detect(struct scsi_ho
 		if ((slot = mca_find_adapter(*id_to_check, 0)) !=
 		  MCA_NOTFOUND) 
 		{
-			esp = esp_allocate(tpnt, (void *) NULL);
+			esp = esp_allocate(tpnt, NULL, 0);
 
 			pos[0] = mca_read_stored_pos(slot, 2);
 			pos[1] = mca_read_stored_pos(slot, 3);
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/oktagon_esp.c linux-2.6.20-rc1/drivers/scsi/oktagon_esp.c
--- linux-2.6.20-rc1.macro/drivers/scsi/oktagon_esp.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/oktagon_esp.c	2006-12-18 21:29:38.000000000 +0000
@@ -133,7 +133,7 @@ int oktagon_esp_detect(struct scsi_host_
 		eregs = (struct ESP_regs *)(address + OKTAGON_ESP_ADDR);
 
 		/* This line was 5 lines lower */
-		esp = esp_allocate(tpnt, (void *)board+OKTAGON_ESP_ADDR);
+		esp = esp_allocate(tpnt, (void *)board + OKTAGON_ESP_ADDR, 0);
 
 		/* we have to shift the registers only one bit for oktagon */
 		esp->shift = 1;
diff -up --recursive --new-file linux-2.6.20-rc1.macro/drivers/scsi/sun3x_esp.c linux-2.6.20-rc1/drivers/scsi/sun3x_esp.c
--- linux-2.6.20-rc1.macro/drivers/scsi/sun3x_esp.c	2006-12-14 01:14:23.000000000 +0000
+++ linux-2.6.20-rc1/drivers/scsi/sun3x_esp.c	2006-12-18 21:29:38.000000000 +0000
@@ -53,7 +53,7 @@ int sun3x_esp_detect(struct scsi_host_te
 	struct ConfigDev *esp_dev;
 
 	esp_dev = 0;
-	esp = esp_allocate(tpnt, (void *) esp_dev);
+	esp = esp_allocate(tpnt, esp_dev, 0);
 
 	/* Do command transfer with DMA */
 	esp->do_pio_cmds = 0;

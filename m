Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTIBSqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTIBSql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:46:41 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54977 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261253AbTIBSow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:44:52 -0400
Date: Tue, 2 Sep 2003 20:44:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org
Subject: [2.4 patch] Fix IRQ_NONE clash in SCSI drivers
Message-ID: <20030902184436.GO23729@fs.tum.de>
References: <Pine.LNX.4.55L.0308271449170.23236@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308271449170.23236@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 02:52:45PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.22 to v2.4.23-pre1
> ============================================
>...
> Arnaldo Carvalho de Melo:
>   o irqreturn_t compatibility with 2.6
>...

This change added an (empty) IRQ_NONE #define to interrupt.h.

Several scsi drivers are already using an IRQ_NONE.  Rename that to
SCSI_IRQ_NONE (a similar change was done in 2.5 by Andrew Morton several
months ago).

I've tested the compilation with 2.4.23-pre2.

Please apply
Adrian

--- linux-2.4.23-pre2-full/drivers/scsi/53c7,8xx.c.old	2003-09-02 20:27:14.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/53c7,8xx.c	2003-09-02 20:27:25.000000000 +0200
@@ -6397,7 +6397,7 @@
 	(struct NCR53c7x0_hostdata *) host->hostdata;
     struct NCR53c7x0_cmd *cmd, *tmp;
     shutdown (host);
-    if (host->irq != IRQ_NONE)
+    if (host->irq != SCSI_IRQ_NONE)
 	{
 	    int irq_count;
 	    struct Scsi_Host *tmp;
--- linux-2.4.23-pre2-full/drivers/scsi/53c7,8xx.h.old	2003-09-02 20:27:25.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/53c7,8xx.h	2003-09-02 20:27:33.000000000 +0200
@@ -1428,7 +1428,7 @@
 
 };
 
-#define IRQ_NONE	255
+#define SCSI_IRQ_NONE	255
 #define DMA_NONE	255
 #define IRQ_AUTO	254
 #define DMA_AUTO	254
--- linux-2.4.23-pre2-full/drivers/scsi/53c7xx.c.old	2003-09-02 20:27:33.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/53c7xx.c	2003-09-02 20:27:42.000000000 +0200
@@ -6081,7 +6081,7 @@
 	(struct NCR53c7x0_hostdata *) host->hostdata[0];
     struct NCR53c7x0_cmd *cmd, *tmp;
     shutdown (host);
-    if (host->irq != IRQ_NONE)
+    if (host->irq != SCSI_IRQ_NONE)
 	{
 	    int irq_count;
 	    struct Scsi_Host *tmp;
--- linux-2.4.23-pre2-full/drivers/scsi/53c7xx.h.old	2003-09-02 20:27:42.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/53c7xx.h	2003-09-02 20:27:49.000000000 +0200
@@ -1450,7 +1450,7 @@
 
 };
 
-#define IRQ_NONE	255
+#define SCSI_IRQ_NONE	255
 #define DMA_NONE	255
 #define IRQ_AUTO	254
 #define DMA_AUTO	254
--- linux-2.4.23-pre2-full/drivers/scsi/NCR5380.c.old	2003-09-02 20:27:49.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/NCR5380.c	2003-09-02 20:32:27.000000000 +0200
@@ -693,7 +693,7 @@
 			trying_irqs |= mask;
 
 	timeout = jiffies + (250 * HZ / 1000);
-	probe_irq = IRQ_NONE;
+	probe_irq = SCSI_IRQ_NONE;
 
 	/*
 	 * A interrupt is triggered whenever BSY = false, SEL = true
@@ -710,7 +710,7 @@
 	NCR5380_write(OUTPUT_DATA_REG, hostdata->id_mask);
 	NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE | ICR_ASSERT_DATA | ICR_ASSERT_SEL);
 
-	while (probe_irq == IRQ_NONE && time_before(jiffies, timeout))
+	while (probe_irq == SCSI_IRQ_NONE && time_before(jiffies, timeout))
 		barrier();
 
 	NCR5380_write(SELECT_ENABLE_REG, 0);
@@ -860,7 +860,7 @@
 
 	SPRINTF("\nBase Addr: 0x%05lX    ", (long) instance->base);
 	SPRINTF("io_port: %04x      ", (int) instance->io_port);
-	if (instance->irq == IRQ_NONE)
+	if (instance->irq == SCSI_IRQ_NONE)
 		SPRINTF("IRQ: None.\n");
 	else
 		SPRINTF("IRQ: %d.\n", instance->irq);
@@ -1706,7 +1706,7 @@
 #endif				/* def NCR_TIMEOUT */
 
 	dprintk(NDEBUG_SELECTION, ("scsi%d : target %d selected, going into MESSAGE OUT phase.\n", instance->host_no, cmd->target));
-	tmp[0] = IDENTIFY(((instance->irq == IRQ_NONE) ? 0 : 1), cmd->lun);
+	tmp[0] = IDENTIFY(((instance->irq == SCSI_IRQ_NONE) ? 0 : 1), cmd->lun);
 
 	len = 1;
 	cmd->tag = 0;
--- linux-2.4.23-pre2-full/drivers/scsi/dmx3191d.c.old	2003-09-02 20:27:59.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/dmx3191d.c	2003-09-02 20:33:02.000000000 +0200
@@ -96,7 +96,7 @@
 			printk(KERN_WARNING "dmx3191: IRQ %d not available - switching to polled mode.\n", pdev->irq);
 			/* Steam powered scsi controllers run without an IRQ
 			   anyway */
-			instance->irq = IRQ_NONE;
+			instance->irq = SCSI_IRQ_NONE;
 		}
 
 		boards++;
@@ -113,7 +113,7 @@
 int dmx3191d_release_resources(struct Scsi_Host *instance)
 {
 	release_region(instance->io_port, DMX3191D_REGION);
-	if(instance->irq!=IRQ_NONE)
+	if(instance->irq != SCSI_IRQ_NONE)
 		free_irq(instance->irq, instance);
 
 	return 0;
--- linux-2.4.23-pre2-full/drivers/scsi/dtc.c.old	2003-09-02 20:28:12.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/dtc.c	2003-09-02 20:29:03.000000000 +0200
@@ -261,24 +261,24 @@
 #ifndef DONT_USE_INTR
 		/* With interrupts enabled, it will sometimes hang when doing heavy
 		 * reads. So better not enable them until I figure it out. */
-		if (instance->irq != IRQ_NONE)
+		if (instance->irq != SCSI_IRQ_NONE)
 			if (request_irq(instance->irq, do_dtc_intr, SA_INTERRUPT, "dtc")) 
 			{
 				printk(KERN_WARNING "scsi%d : IRQ%d not free, interrupts disabled\n", instance->host_no, instance->irq);
-				instance->irq = IRQ_NONE;
+				instance->irq = SCSI_IRQ_NONE;
 			}
 
-		if (instance->irq == IRQ_NONE) {
+		if (instance->irq == SCSI_IRQ_NONE) {
 			printk(KERN_INFO "scsi%d : interrupts not enabled. for better interactive performance,\n", instance->host_no);
 			printk(KERN_INFO "scsi%d : please jumper the board for a free IRQ.\n", instance->host_no);
 		}
 #else
-		if (instance->irq != IRQ_NONE)
+		if (instance->irq != SCSI_IRQ_NONE)
 			printk(KERN_INFO "scsi%d : interrupts not used. Might as well not jumper it.\n", instance->host_no);
-		instance->irq = IRQ_NONE;
+		instance->irq = SCSI_IRQ_NONE;
 #endif
 		printk(KERN_INFO "scsi%d : at 0x%05X", instance->host_no, (int) instance->base);
-		if (instance->irq == IRQ_NONE)
+		if (instance->irq == SCSI_IRQ_NONE)
 			printk(" interrupts disabled");
 		else
 			printk(" irq %d", instance->irq);
@@ -336,7 +336,7 @@
 	i = 0;
 	NCR5380_read(RESET_PARITY_INTERRUPT_REG);
 	NCR5380_write(MODE_REG, MR_ENABLE_EOP_INTR | MR_DMA_MODE);
-	if (instance->irq == IRQ_NONE)
+	if (instance->irq == SCSI_IRQ_NONE)
 		NCR5380_write(DTC_CONTROL_REG, CSR_DIR_READ);
 	else
 		NCR5380_write(DTC_CONTROL_REG, CSR_DIR_READ | CSR_INT_BASE);
@@ -384,7 +384,7 @@
 	NCR5380_read(RESET_PARITY_INTERRUPT_REG);
 	NCR5380_write(MODE_REG, MR_ENABLE_EOP_INTR | MR_DMA_MODE);
 	/* set direction (write) */
-	if (instance->irq == IRQ_NONE)
+	if (instance->irq == SCSI_IRQ_NONE)
 		NCR5380_write(DTC_CONTROL_REG, 0);
 	else
 		NCR5380_write(DTC_CONTROL_REG, CSR_5380_INTR);
--- linux-2.4.23-pre2-full/drivers/scsi/g_NCR5380.c.old	2003-09-02 20:29:03.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/g_NCR5380.c	2003-09-02 20:33:26.000000000 +0200
@@ -333,7 +333,7 @@
 			if (dev->irq_resource[0].flags & IORESOURCE_IRQ)
 				overrides[count].irq = dev->irq_resource[0].start;
 			else
-				overrides[count].irq = IRQ_NONE;
+				overrides[count].irq = SCSI_IRQ_NONE;
 			if (dev->dma_resource[0].flags & IORESOURCE_DMA)
 				overrides[count].dma = dev->dma_resource[0].start;
 			else
@@ -430,19 +430,19 @@
 		else
 			instance->irq = NCR5380_probe_irq(instance, 0xffff);
 
-		if (instance->irq != IRQ_NONE)
+		if (instance->irq != SCSI_IRQ_NONE)
 			if (request_irq(instance->irq, do_generic_NCR5380_intr, SA_INTERRUPT, "NCR5380", NULL)) {
 				printk(KERN_WARNING "scsi%d : IRQ%d not free, interrupts disabled\n", instance->host_no, instance->irq);
-				instance->irq = IRQ_NONE;
+				instance->irq = SCSI_IRQ_NONE;
 			}
 
-		if (instance->irq == IRQ_NONE) {
+		if (instance->irq == SCSI_IRQ_NONE) {
 			printk(KERN_INFO "scsi%d : interrupts not enabled. for better interactive performance,\n", instance->host_no);
 			printk(KERN_INFO "scsi%d : please jumper the board for a free IRQ.\n", instance->host_no);
 		}
 
 		printk(KERN_INFO "scsi%d : at " STRVAL(NCR5380_map_name) " 0x%x", instance->host_no, (unsigned int) instance->NCR5380_instance_name);
-		if (instance->irq == IRQ_NONE)
+		if (instance->irq == SCSI_IRQ_NONE)
 			printk(" interrupts disabled");
 		else
 			printk(" irq %d", instance->irq);
@@ -489,7 +489,7 @@
 	release_mem_region(instance->NCR5380_instance_name, NCR5380_region_size);
 #endif
 
-	if (instance->irq != IRQ_NONE)
+	if (instance->irq != SCSI_IRQ_NONE)
 		free_irq(instance->irq, NULL);
 
 	return 0;
@@ -802,7 +802,7 @@
 	PRINTP("NO NCR53C400 driver extensions\n");
 #endif
 	PRINTP("Using %s mapping at %s 0x%lx, " ANDP STRVAL(NCR5380_map_config) ANDP STRVAL(NCR5380_map_name) ANDP scsi_ptr->NCR5380_instance_name);
-	if (scsi_ptr->irq == IRQ_NONE)
+	if (scsi_ptr->irq == SCSI_IRQ_NONE)
 		PRINTP("no interrupt\n");
 	else
 		PRINTP("on interrupt %d\n" ANDP scsi_ptr->irq);
--- linux-2.4.23-pre2-full/drivers/scsi/mac_scsi.c.old	2003-09-02 20:29:11.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/mac_scsi.c	2003-09-02 20:29:32.000000000 +0200
@@ -253,16 +253,16 @@
 
     ((struct NCR5380_hostdata *)instance->hostdata)->ctrl = 0;
 
-    if (instance->irq != IRQ_NONE)
+    if (instance->irq != SCSI_IRQ_NONE)
 	if (request_irq(instance->irq, NCR5380_intr, IRQ_FLG_SLOW, 
 		"ncr5380", NCR5380_intr)) {
 	    printk(KERN_WARNING "scsi%d: IRQ%d not free, interrupts disabled\n",
 		   instance->host_no, instance->irq);
-	    instance->irq = IRQ_NONE;
+	    instance->irq = SCSI_IRQ_NONE;
 	}
 
     printk(KERN_INFO "scsi%d: generic 5380 at port %lX irq", instance->host_no, instance->io_port);
-    if (instance->irq == IRQ_NONE)
+    if (instance->irq == SCSI_IRQ_NONE)
 	printk (KERN_INFO "s disabled");
     else
 	printk (KERN_INFO " %d", instance->irq);
@@ -277,7 +277,7 @@
 
 int macscsi_release (struct Scsi_Host *shpnt)
 {
-	if (shpnt->irq != IRQ_NONE)
+	if (shpnt->irq != SCSI_IRQ_NONE)
 		free_irq (shpnt->irq, NCR5380_intr);
 
 	return 0;
--- linux-2.4.23-pre2-full/drivers/scsi/pas16.c.old	2003-09-02 20:29:32.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/pas16.c	2003-09-02 20:30:00.000000000 +0200
@@ -99,11 +99,11 @@
  *   interrupts.  Ie, for a board at the default 0x388 base port,
  *   boot: linux pas16=0x388,255
  *
- *   IRQ_NONE (255) should be specified for no interrupt,
+ *   SCSI_IRQ_NONE (255) should be specified for no interrupt,
  *   IRQ_AUTO (254) to autoprobe for an IRQ line if overridden
  *   on the command line.
  *
- *   (IRQ_AUTO == 254, IRQ_NONE == 255 in NCR5380.h)
+ *   (IRQ_AUTO == 254, SCSI_IRQ_NONE == 255 in NCR5380.h)
  */
 
 #include <linux/module.h>
@@ -404,13 +404,13 @@
 		else
 			instance->irq = NCR5380_probe_irq(instance, PAS16_IRQS);
 
-		if (instance->irq != IRQ_NONE)
+		if (instance->irq != SCSI_IRQ_NONE)
 			if (request_irq(instance->irq, do_pas16_intr, SA_INTERRUPT, "pas16", NULL)) {
 				printk(KERN_WARNING "scsi%d : IRQ%d not free, interrupts disabled\n", instance->host_no, instance->irq);
-				instance->irq = IRQ_NONE;
+				instance->irq = SCSI_IRQ_NONE;
 			}
 
-		if (instance->irq == IRQ_NONE) {
+		if (instance->irq == SCSI_IRQ_NONE) {
 			printk(KERN_INFO "scsi%d : interrupts not enabled. for better interactive performance,\n", instance->host_no);
 			printk(KERN_INFO "scsi%d : please jumper the board for a free IRQ.\n", instance->host_no);
 			/* Disable 5380 interrupts, leave drive params the same */
@@ -420,7 +420,7 @@
 
 		printk(KERN_INFO "scsi%d : at 0x%04x", instance->host_no, (int)
 		       instance->io_port);
-		if (instance->irq == IRQ_NONE)
+		if (instance->irq == SCSI_IRQ_NONE)
 			printk(" interrupts disabled");
 		else
 			printk(" irq %d", instance->irq);
--- linux-2.4.23-pre2-full/drivers/scsi/sun3_scsi.c.old	2003-09-02 20:30:00.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/sun3_scsi.c	2003-09-02 20:30:16.000000000 +0200
@@ -267,7 +267,7 @@
 #ifndef REAL_DMA
 		printk("scsi%d: IRQ%d not free, interrupts disabled\n",
 		       instance->host_no, instance->irq);
-		instance->irq = IRQ_NONE;
+		instance->irq = SCSI_IRQ_NONE;
 #else
 		printk("scsi%d: IRQ%d not free, bailing out\n",
 		       instance->host_no, instance->irq);
@@ -276,7 +276,7 @@
 	}
 	
 	printk("scsi%d: Sun3 5380 at port %lX irq", instance->host_no, instance->io_port);
-	if (instance->irq == IRQ_NONE)
+	if (instance->irq == SCSI_IRQ_NONE)
 		printk ("s disabled");
 	else
 		printk (" %d", instance->irq);
@@ -305,7 +305,7 @@
 #ifdef MODULE
 int sun3scsi_release (struct Scsi_Host *shpnt)
 {
-	if (shpnt->irq != IRQ_NONE)
+	if (shpnt->irq != SCSI_IRQ_NONE)
 		free_irq (shpnt->irq, NULL);
 
 	iounmap((void *)sun3_scsi_regp);
--- linux-2.4.23-pre2-full/drivers/scsi/sun3_scsi_vme.c.old	2003-09-02 20:30:16.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/sun3_scsi_vme.c	2003-09-02 20:30:37.000000000 +0200
@@ -236,7 +236,7 @@
 #ifndef REAL_DMA
 		printk("scsi%d: IRQ%d not free, interrupts disabled\n",
 		       instance->host_no, instance->irq);
-		instance->irq = IRQ_NONE;
+		instance->irq = SCSI_IRQ_NONE;
 #else
 		printk("scsi%d: IRQ%d not free, bailing out\n",
 		       instance->host_no, instance->irq);
@@ -245,7 +245,7 @@
 	}
 
 	printk("scsi%d: Sun3 5380 VME at port %lX irq", instance->host_no, instance->io_port);
-	if (instance->irq == IRQ_NONE)
+	if (instance->irq == SCSI_IRQ_NONE)
 		printk ("s disabled");
 	else
 		printk (" %d", instance->irq);
@@ -281,7 +281,7 @@
 #ifdef MODULE
 int sun3scsi_release (struct Scsi_Host *shpnt)
 {
-	if (shpnt->irq != IRQ_NONE)
+	if (shpnt->irq != SCSI_IRQ_NONE)
 		free_irq (shpnt->irq, NULL);
 
 	iounmap(sun3_scsi_regp);
--- linux-2.4.23-pre2-full/drivers/scsi/t128.c.old	2003-09-02 20:30:37.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/t128.c	2003-09-02 20:30:59.000000000 +0200
@@ -237,20 +237,20 @@
 		else
 			instance->irq = NCR5380_probe_irq(instance, T128_IRQS);
 
-		if (instance->irq != IRQ_NONE)
+		if (instance->irq != SCSI_IRQ_NONE)
 			if (request_irq(instance->irq, do_t128_intr, SA_INTERRUPT, "t128", NULL)) 
 			{
 				printk(KERN_WARNING "scsi%d : IRQ%d not free, interrupts disabled\n", instance->host_no, instance->irq);
-				instance->irq = IRQ_NONE;
+				instance->irq = SCSI_IRQ_NONE;
 			}
 
-		if (instance->irq == IRQ_NONE) {
+		if (instance->irq == SCSI_IRQ_NONE) {
 			printk(KERN_INFO "scsi%d : interrupts not enabled. for better interactive performance,\n", instance->host_no);
 			printk(KERN_INFO "scsi%d : please jumper the board for a free IRQ.\n", instance->host_no);
 		}
 
 		printk(KERN_INFO "scsi%d : at 0x%08lx", instance->host_no,instance->base);
-		if (instance->irq == IRQ_NONE)
+		if (instance->irq == SCSI_IRQ_NONE)
 			printk(" interrupts disabled");
 		else
 			printk(" irq %d", instance->irq);
--- linux-2.4.23-pre2-full/drivers/scsi/tmscsim.c.old	2003-09-02 20:30:59.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/tmscsim.c	2003-09-02 20:31:05.000000000 +0200
@@ -3047,7 +3047,7 @@
     /* TO DO: We should check for outstanding commands first. */
     dc390_shutdown (host);
 
-    if (host->irq != IRQ_NONE)
+    if (host->irq != SCSI_IRQ_NONE)
     {
 	DEBUG0(printk(KERN_INFO "DC390: Free IRQ %i\n",host->irq);)
 	free_irq (host->irq, pACB);
--- linux-2.4.23-pre2-full/drivers/scsi/tmscsim.h.old	2003-09-02 20:31:05.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/scsi/tmscsim.h	2003-09-02 20:31:21.000000000 +0200
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 #include <linux/config.h>
 
-#define IRQ_NONE 255
+#define SCSI_IRQ_NONE 255
 
 #define MAX_ADAPTER_NUM 	4
 #define MAX_SG_LIST_BUF 	16	/* Not used */

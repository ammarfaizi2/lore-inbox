Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbTDXLxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTDXLxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:53:14 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:21265 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263516AbTDXLxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:53:01 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] aha1740 update
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 24 Apr 2003 14:03:32 +0200
Message-ID: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I updated the aha1740 driver to both the EISA framework, as well as
the generic DMA API (the latter was needed because isa_bus_to_virt and
isa_virt_to_bus are not available anymore on Alpha, this would leave
the Jensen on the side of the 2.5 road).

Also, because of the way EISA devices are now discovered, I had to
convert the driver to the 'hotplug' SCSI initialization model... 

The driver still lacks error handlers, due to my limited knowledge.
It's been tested on both i386 and Alpha, both build-in and
modular. I'll post my Alpha DMA patches as soon as I find some time to
clean them up (it's a bit ugly at the moment...).

I'd appreciate any comment (patch is against 2.5.68).

Thanks,

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1128  -> 1.1129 
#	drivers/scsi/aha1740.c	1.12    -> 1.15   
#	drivers/scsi/aha1740.h	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/24	maz@hina.wild-wind.fr.eu.org	1.1129
# aha1740 update :
# 
# Now uses EISA framework, generic DMA API, 
# and 'hotplug' SCSI initialization model.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
--- a/drivers/scsi/aha1740.c	Thu Apr 24 13:40:37 2003
+++ b/drivers/scsi/aha1740.c	Thu Apr 24 13:40:37 2003
@@ -23,6 +23,9 @@
  *
  * Reworked for new_eh and new locking by Alan Cox <alan@redhat.com>
  *
+ * Converted to EISA and generic DMA APIs by Marc Zyngier
+ * <maz@wild-wind.fr.eu.org>, 4/2003.
+ *
  * For the avoidance of doubt the "preferred form" of this code is one which
  * is in an open non patent encumbered format. Where cryptographic key signing
  * forms part of the process of creating an executable the information
@@ -44,6 +47,11 @@
 #include <asm/system.h>
 #include <asm/io.h>
 
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/eisa.h>
+#include <linux/dma-mapping.h>
+
 #include "scsi.h"
 #include "hosts.h"
 #include "aha1740.h"
@@ -63,18 +71,62 @@
 */
 
 struct aha1740_hostdata {
-    unsigned int slot;
+    struct eisa_device *edev;
     unsigned int translation;
     unsigned int last_ecb_used;
+    dma_addr_t ecb_dma_addr;
     struct ecb ecb[AHA1740_ECBS];
 };
 
+struct aha1740_sg {
+    struct aha1740_chain sg_chain[AHA1740_SCATTER];
+    dma_addr_t sg_dma_addr;
+    dma_addr_t buf_dma_addr;
+};
+
+/* This should really fit in driver/scsi/scsi.h, along with
+ * scsi_to_{pci,sbus}_dma_dir.... */
+#if ((SCSI_DATA_UNKNOWN == DMA_BIDIRECTIONAL) && (SCSI_DATA_WRITE == DMA_TO_DEVICE) && (SCSI_DATA_READ == DMA_FROM_DEVICE) && (SCSI_DATA_NONE == DMA_NONE))
+#define scsi_to_dma_dir(scsi_dir)   ((enum dma_data_direction)(scsi_dir))
+#else
+extern __inline__ enum dma_data_direction scsi_to_dma_dir(unsigned char scsi_dir)
+{
+        if (scsi_dir == SCSI_DATA_UNKNOWN)
+                return DMA_BIDIRECTIONAL;
+        if (scsi_dir == SCSI_DATA_WRITE)
+                return DMA_TO_DEVICE;
+        if (scsi_dir == SCSI_DATA_READ)
+                return DMA_FROM_DEVICE;
+        return DMA_NONE;
+}
+#endif
+
 #define HOSTDATA(host) ((struct aha1740_hostdata *) &host->hostdata)
 
 static spinlock_t aha1740_lock = SPIN_LOCK_UNLOCKED;
 
-/* One for each IRQ level (9-15) */
-static struct Scsi_Host * aha_host[8] = {NULL, };
+/* Eventually this will go into an include file, but this will be later */
+static Scsi_Host_Template driver_template = AHA1740;
+
+static inline void *ecb_dma_to_cpu (struct Scsi_Host *host, dma_addr_t dma)
+{
+    struct aha1740_hostdata *hdata = HOSTDATA (host);
+    dma_addr_t offset;
+
+    offset = dma - hdata->ecb_dma_addr;
+
+    return (void *)(((char *) hdata->ecb) + (unsigned int) offset);
+}
+
+static inline dma_addr_t ecb_cpu_to_dma (struct Scsi_Host *host, void *cpu)
+{
+    struct aha1740_hostdata *hdata = HOSTDATA (host);
+    dma_addr_t offset;
+    
+    offset = (char *) cpu - (char *) hdata->ecb;
+
+    return hdata->ecb_dma_addr + offset;
+}
 
 static int aha1740_proc_info(char *buffer, char **start, off_t offset,
 		      int length, int hostno, int inout)
@@ -86,16 +138,14 @@
     if (inout)
 	return-ENOSYS;
 
-    for (len = 0; len < 8; len++) {
-	shpnt = aha_host[len];
-	if (shpnt && shpnt->host_no == hostno)
-	    break;
-    }
+    if (!(shpnt = scsi_host_hn_get (hostno)))
+	return 0;
+
     host = HOSTDATA(shpnt);
 
     len = sprintf(buffer, "aha174x at IO:%lx, IRQ %d, SLOT %d.\n"
 		  "Extended translation %sabled.\n",
-		  shpnt->io_port, shpnt->irq, host->slot,
+		  shpnt->io_port, shpnt->irq, host->edev->slot,
 		  host->translation ? "en" : "dis");
 
     if (offset > len) {
@@ -189,22 +239,6 @@
 
 static int aha1740_test_port(unsigned int base)
 {
-    char name[4], tmp;
-
-    /* Okay, look for the EISA ID's */
-    name[0]= 'A' -1 + ((tmp = inb(HID0(base))) >> 2); /* First character */
-    name[1]= 'A' -1 + ((tmp & 3) << 3);
-    name[1]+= ((tmp = inb(HID1(base))) >> 5)&0x7;	/* Second Character */
-    name[2]= 'A' -1 + (tmp & 0x1f);		/* Third Character */
-    name[3]=0;
-    tmp = inb(HID2(base));
-    if ( strcmp ( name, HID_MFG ) || inb(HID2(base)) != HID_PRD )
-	return 0;   /* Not an Adaptec 174x */
-
-/*  if ( inb(HID3(base)) != HID_REV )
-	printk("aha174x: Warning; board revision of %d; expected %d\n",
-	    inb(HID3(base)),HID_REV); */
-
     if ( inb(EBCNTRL(base)) != EBCNTRL_VALUE )
     {
 	printk("aha174x: Board detected, but EBCNTRL = %x, so disabled it.\n",
@@ -220,9 +254,9 @@
 }
 
 /* A "high" level interrupt handler */
-static void aha1740_intr_handle(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t aha1740_intr_handle(int irq, void *dev_id, struct pt_regs * regs)
 {
-    struct Scsi_Host *host = aha_host[irq - 9];
+    struct Scsi_Host *host = (struct Scsi_Host *) dev_id;
     void (*my_done)(Scsi_Cmnd *);
     int errstatus, adapstat;
     int number_serviced;
@@ -230,18 +264,21 @@
     Scsi_Cmnd *SCtmp;
     unsigned int base;
     unsigned long flags;
+    struct aha1740_sg *sgptr;
+    struct eisa_device *edev;
 
     if (!host)
 	panic("aha1740.c: Irq from unknown host!\n");
     spin_lock_irqsave(host->host_lock, flags);
     base = host->io_port;
     number_serviced = 0;
+    edev = HOSTDATA(host)->edev;
 
     while(inb(G2STAT(base)) & G2STAT_INTPEND)
     {
 	DEB(printk("aha1740_intr top of loop.\n"));
 	adapstat = inb(G2INTST(base));
-	ecbptr = (struct ecb *) isa_bus_to_virt(inl(MBOXIN0(base)));
+	ecbptr = (struct ecb *) ecb_dma_to_cpu (host, inl(MBOXIN0(base)));
 	outb(G2CNTRL_IRST,G2CNTRL(base)); /* interrupt reset */
       
 	switch ( adapstat & G2INTST_MASK )
@@ -266,8 +303,26 @@
 		       inb(G2INTST(base)), number_serviced++);
 		continue;
 	    }
-	    if (SCtmp->host_scribble)
-		kfree(SCtmp->host_scribble);
+	    sgptr = (struct aha1740_sg *) SCtmp->host_scribble;
+	    if (SCtmp->use_sg) {
+		/* We used scatter-gather. Do the unmapping dance. */
+		dma_unmap_sg (&edev->dev,
+			      (struct scatterlist *) SCtmp->request_buffer,
+			      SCtmp->use_sg,
+			      scsi_to_dma_dir (SCtmp->sc_data_direction));
+	    } else {
+		dma_unmap_single (&edev->dev,
+				  sgptr->buf_dma_addr,
+				  SCtmp->request_bufflen,
+				  DMA_BIDIRECTIONAL);
+	    }
+	    
+	    /* Free the sg block */
+	    dma_free_coherent (&edev->dev,
+			       sizeof (struct aha1740_sg),
+			       SCtmp->host_scribble,
+			       sgptr->sg_dma_addr);
+	    
 	    /* Fetch the sense data, and tuck it away, in the required slot.
 	       The Adaptec automatically fetches it, and there is no
 	       guarantee that we will still have it in the cdb when we come
@@ -309,6 +364,7 @@
     }
 
     spin_unlock_irqrestore(host->host_lock, flags);
+    return IRQ_HANDLED;
 }
 
 static int aha1740_queuecommand(Scsi_Cmnd * SCpnt, void (*done)(Scsi_Cmnd *))
@@ -320,6 +376,8 @@
     unsigned long flags;
     void *buff = SCpnt->request_buffer;
     int bufflen = SCpnt->request_bufflen;
+    dma_addr_t sg_dma;
+    struct aha1740_sg *sgptr;
     int ecbno;
     DEB(int i);
 
@@ -381,29 +439,36 @@
 
     memcpy(host->ecb[ecbno].cdb, cmd, SCpnt->cmd_len);
 
+    SCpnt->host_scribble = dma_alloc_coherent (&host->edev->dev,
+					       sizeof (struct aha1740_sg),
+					       &sg_dma, GFP_ATOMIC);
+    if(SCpnt->host_scribble == NULL)
+    {
+	printk(KERN_WARNING "aha1740: out of memory in queuecommand!\n");
+	return 1;
+    }
+    sgptr = (struct aha1740_sg *) SCpnt->host_scribble;
+    sgptr->sg_dma_addr = sg_dma;
+    
     if (SCpnt->use_sg)
     {
 	struct scatterlist * sgpnt;
 	struct aha1740_chain * cptr;
-	int i;
+	int i, count;
 	DEB(unsigned char * ptr);
 
 	host->ecb[ecbno].sg = 1;  /* SCSI Initiator Command  w/scatter-gather*/
-	SCpnt->host_scribble = (unsigned char *)kmalloc(512, GFP_KERNEL);
-	if(SCpnt->host_scribble == NULL)
-	{
-		printk(KERN_WARNING "aha1740: out of memory in queuecommand!\n");
-		return 1;
-	}
 	sgpnt = (struct scatterlist *) SCpnt->request_buffer;
-	cptr = (struct aha1740_chain *) SCpnt->host_scribble; 
-	for(i=0; i<SCpnt->use_sg; i++)
+	cptr = sgptr->sg_chain;
+	count = dma_map_sg (&host->edev->dev, sgpnt, SCpnt->use_sg,
+			    scsi_to_dma_dir (SCpnt->sc_data_direction));
+	for(i=0; i < count; i++)
 	{
-	    cptr[i].datalen = sgpnt[i].length;
-	    cptr[i].dataptr = isa_virt_to_bus(page_address(sgpnt[i].page) + sgpnt[i].offset);
+	    cptr[i].datalen = sg_dma_len (sgpnt + i);
+	    cptr[i].dataptr = sg_dma_address (sgpnt + i);
 	}
-	host->ecb[ecbno].datalen = SCpnt->use_sg * sizeof(struct aha1740_chain);
-	host->ecb[ecbno].dataptr = isa_virt_to_bus(cptr);
+	host->ecb[ecbno].datalen = count * sizeof(struct aha1740_chain);
+	host->ecb[ecbno].dataptr = sg_dma;
 #ifdef DEBUG
 	printk("cptr %x: ",cptr);
 	ptr = (unsigned char *) cptr;
@@ -412,17 +477,20 @@
     }
     else
     {
-	SCpnt->host_scribble = NULL;
 	host->ecb[ecbno].datalen = bufflen;
-	host->ecb[ecbno].dataptr = isa_virt_to_bus(buff);
+	sgptr->buf_dma_addr =  dma_map_single (&host->edev->dev, buff, bufflen,
+					       DMA_BIDIRECTIONAL);
+	host->ecb[ecbno].dataptr = sgptr->buf_dma_addr;
     }
     host->ecb[ecbno].lun = SCpnt->device->lun;
     host->ecb[ecbno].ses = 1;	/* Suppress underrun errors */
     host->ecb[ecbno].dir = direction;
     host->ecb[ecbno].ars = 1;  /* Yes, get the sense on an error */
     host->ecb[ecbno].senselen = 12;
-    host->ecb[ecbno].senseptr = isa_virt_to_bus(host->ecb[ecbno].sense);
-    host->ecb[ecbno].statusptr = isa_virt_to_bus(host->ecb[ecbno].status);
+    host->ecb[ecbno].senseptr = ecb_cpu_to_dma (SCpnt->device->host,
+						host->ecb[ecbno].sense);
+    host->ecb[ecbno].statusptr = ecb_cpu_to_dma (SCpnt->device->host,
+						 host->ecb[ecbno].status);
     host->ecb[ecbno].done = done;
     host->ecb[ecbno].SCpnt = SCpnt;
 #ifdef DEBUG
@@ -461,7 +529,8 @@
 	    if (loopcnt == LOOPCNT_MAX)
 		panic("aha1740.c: mbxout busy!\n");
 	}
-	outl(isa_virt_to_bus(host->ecb + ecbno), MBOXOUT0(base));
+	outl (ecb_cpu_to_dma (SCpnt->device->host, host->ecb + ecbno),
+	      MBOXOUT0(base));
 	for (loopcnt = 0; ; loopcnt++) {
 	    if (! (inb(G2STAT(base)) & G2STAT_BUSY)) break;
 	    if (loopcnt == LOOPCNT_WARN) {
@@ -509,26 +578,24 @@
     outb(inb(INTDEF(base)) | 0x10, INTDEF(base));
 }
 
-static int aha1740_detect(Scsi_Host_Template * tpnt)
+static int aha1740_probe (struct device *dev)
 {
-    int count = 0, slot;
-
-    DEB(printk("aha1740_detect: \n"));
-
-    for ( slot=MINEISA; slot <= MAXEISA; slot++ )
-    {
 	int slotbase;
 	unsigned int irq_level, translation;
 	struct Scsi_Host *shpnt;
 	struct aha1740_hostdata *host;
-	slotbase = SLOTBASE(slot);
+	struct eisa_device *edev = to_eisa_device (dev);
+
+	DEB(printk("aha1740_probe: \n"));
+	
+	slotbase = edev->base_addr + EISA_VENDOR_ID_OFFSET;
 	/*
 	 * The ioports for eisa boards are generally beyond that used in the
 	 * check/allocate region code, but this may change at some point,
 	 * so we go through the motions.
 	 */
 	if (!request_region(slotbase, SLOTSIZE, "aha1740"))  /* See if in use */
-	    continue;
+	    return -EBUSY;
 	if (!aha1740_test_port(slotbase))
 	    goto err_release;
 	aha1740_getconfig(slotbase,&irq_level,&translation);
@@ -541,14 +608,9 @@
 	printk(KERN_INFO "Configuring aha174x at IO:%x, IRQ %d\n", slotbase, irq_level);
 	printk(KERN_INFO "aha174x: Extended translation %sabled.\n",
 	       translation ? "en" : "dis");
-	DEB(printk("aha1740_detect: enable interrupt channel %d\n",irq_level));
-	if (request_irq(irq_level,aha1740_intr_handle,0,"aha1740",NULL)) {
-	    printk("Unable to allocate IRQ for adaptec controller.\n");
-	    goto err_release;
-	}
-	shpnt = scsi_register(tpnt, sizeof(struct aha1740_hostdata));
+	shpnt = scsi_register(&driver_template, sizeof(struct aha1740_hostdata));
 	if(shpnt == NULL)
-		goto err_free_irq;
+		goto err_release;
 
 	shpnt->base = 0;
 	shpnt->io_port = slotbase;
@@ -556,18 +618,50 @@
 	shpnt->irq = irq_level;
 	shpnt->dma_channel = 0xff;
 	host = HOSTDATA(shpnt);
-	host->slot = slot;
+	host->edev = edev;
 	host->translation = translation;
-	aha_host[irq_level - 9] = shpnt;
-	count++;
-	continue;
+	host->ecb_dma_addr = dma_map_single (&edev->dev, host->ecb,
+					     sizeof (host->ecb),
+					     DMA_BIDIRECTIONAL);
+	if (!host->ecb_dma_addr) {
+	    printk (KERN_ERR "aha1740_probe: Couldn't map ECB, giving up\n");
+	    scsi_unregister (shpnt);
+	    goto err_release;
+	}
+	
+	DEB(printk("aha1740_probe: enable interrupt channel %d\n",irq_level));
+	if (request_irq(irq_level,aha1740_intr_handle,0,"aha1740",shpnt)) {
+	    printk(KERN_ERR "aha1740_probe: Unable to allocate IRQ %d.\n",
+		   irq_level);
+	    goto err_release;
+	}
+
+	eisa_set_drvdata (edev, shpnt);
+	scsi_add_host (shpnt, dev);
+	return 0;
 
-    err_free_irq:
-	free_irq(irq_level, aha1740_intr_handle);
     err_release:
 	release_region(slotbase, SLOTSIZE);
-    }
-    return count;
+
+	return -ENODEV;
+}
+
+static __devexit int aha1740_remove (struct device *dev)
+{
+	struct Scsi_Host *shpnt = dev->driver_data;
+	struct aha1740_hostdata *host = HOSTDATA (shpnt);
+
+	if (scsi_remove_host (shpnt))
+	    return -EBUSY;
+	
+	free_irq (shpnt->irq, shpnt);
+	dma_unmap_single (dev, host->ecb_dma_addr,
+			  sizeof (host->ecb), DMA_BIDIRECTIONAL);
+	release_region (shpnt->io_port, SLOTSIZE);
+
+	scsi_unregister (shpnt);
+	
+	return 0;
 }
 
 static int aha1740_biosparam(struct scsi_device *sdev, struct block_device *dev,
@@ -592,12 +686,37 @@
     return 0;
 }
 
-MODULE_LICENSE("GPL");
+static struct eisa_device_id aha1740_ids[] = {
+    { "ADP0000" },
+    { "ADP0001" },
+    { "ADP0002" },
+    { "" }
+};
 
-/* Eventually this will go into an include file, but this will be later */
-static Scsi_Host_Template driver_template = AHA1740;
+static struct eisa_driver aha1740_driver = {
+    .id_table = aha1740_ids,
+    .driver   = {
+	.name    = "aha1740",
+	.probe   = aha1740_probe,
+	.remove  = __devexit_p (aha1740_remove),
+    },
+};
 
-#include "scsi_module.c"
+static __init int aha1740_init (void)
+{
+    driver_template.module = THIS_MODULE;
+    return eisa_driver_register (&aha1740_driver);
+}
+
+static __exit void aha1740_exit (void)
+{
+    eisa_driver_unregister (&aha1740_driver);
+}
+
+module_init (aha1740_init);
+module_exit (aha1740_exit);
+
+MODULE_LICENSE("GPL");
 
 /* Okay, you made it all the way through.  As of this writing, 3/31/93, I'm
 brad@saturn.gaylord.com or brad@bradpc.gaylord.com.  I'll try to help as time
diff -Nru a/drivers/scsi/aha1740.h b/drivers/scsi/aha1740.h
--- a/drivers/scsi/aha1740.h	Thu Apr 24 13:40:37 2003
+++ b/drivers/scsi/aha1740.h	Thu Apr 24 13:40:37 2003
@@ -152,7 +152,6 @@
 #define AHA1740CMD_RINQ  0x0a	/* Read Host Adapter Inquiry Data */
 #define AHA1740CMD_TARG  0x10	/* Target SCSI Command */
 
-static int aha1740_detect(Scsi_Host_Template *);
 static int aha1740_command(Scsi_Cmnd *);
 static int aha1740_queuecommand(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
 static int aha1740_biosparam(struct scsi_device *, struct block_device *, sector_t, int *);
@@ -165,7 +164,7 @@
 #define AHA1740 {  .proc_name      = "aha1740",				\
 		   .proc_info      = aha1740_proc_info,	                \
 		   .name           = "Adaptec 174x (EISA)",		\
-		   .detect         = aha1740_detect,			\
+		   .detect         = NULL,			\
 		   .command        = aha1740_command,			\
 		   .queuecommand   = aha1740_queuecommand,		\
 		   .bios_param     = aha1740_biosparam,                   \

-- 
Places change, faces change. Life is so very strange.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290190AbSAQT1x>; Thu, 17 Jan 2002 14:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290186AbSAQT1i>; Thu, 17 Jan 2002 14:27:38 -0500
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:47439
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S290190AbSAQT1V>; Thu, 17 Jan 2002 14:27:21 -0500
Message-Id: <200201171927.g0HJR8X03357@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.2] 53c700, NCR_D700 and lasi700 SCSI updates
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-17466361920"
Date: Thu, 17 Jan 2002 14:27:08 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-17466361920
Content-Type: text/plain; charset=us-ascii

The attached patch folds in the bug fixes that were made in 2.4 and also 
updates the locking scheme again.

This is the change log:

- Alter the Main Makefile to list 53c700_d.h (a scripts generated file) rather 
than 53c700-mem.c (which is no longer produced) as removable on clean.

- change from readl/writel to __raw_readl/writel.  This is primarily for the 
parisc.

- Add in a missing size initialisation for request_bufflen on SCSI automatic 
sense requests.  This caused the pci_unmap_single to fail and led to an 
accumulation of mappings in the bus MMU.

- Changes the scripts code to explicitly clear ATN and then ACK for pre 
command messages.  This was causing a basic INQUIRY failure on a CDRW.

- adds a missing mca_set_adapter_name to the D700 driver.

- Updates the lasi700 driver to sync with the current parisc tree.

- use the host->host_lock instead of &io_request_lock

James Bottomley


--==_Exmh_-17466361920
Content-Type: text/plain ; name="ncr700-2.5.2.diff"; charset=us-ascii
Content-Description: ncr700-2.5.2.diff
Content-Disposition: attachment; filename="ncr700-2.5.2.diff"

Index: linux/2.5/Makefile
diff -u linux/2.5/Makefile:1.1.1.7 linux/2.5/Makefile:1.1.1.7.4.1
--- linux/2.5/Makefile:1.1.1.7	Wed Jan 16 12:25:12 2002
+++ linux/2.5/Makefile	Wed Jan 16 13:49:02 2002
@@ -204,7 +204,7 @@
 	drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
 	drivers/scsi/aic7xxx/aicasm/y.tab.h \
 	drivers/scsi/aic7xxx/aicasm/aicasm \
-	drivers/scsi/53c700-mem.c \
+	drivers/scsi/53c700_d.h \
 	net/khttpd/make_times_h \
 	net/khttpd/times.h \
 	submenu*
Index: linux/2.5/drivers/scsi/53c700.c
diff -u linux/2.5/drivers/scsi/53c700.c:1.1.1.2 linux/2.5/drivers/scsi/53c700.c:1.1.1.2.18.1
--- linux/2.5/drivers/scsi/53c700.c:1.1.1.2	Sun Dec  9 13:21:22 2001
+++ linux/2.5/drivers/scsi/53c700.c	Wed Jan 16 13:49:02 2002
@@ -51,6 +51,14 @@
 
 /* CHANGELOG
  *
+ * Version 2.7
+ *
+ * Fixed scripts problem which caused certain devices (notably CDRWs)
+ * to hang on initial INQUIRY.  Updated NCR_700_readl/writel to use
+ * __raw_readl/writel for parisc compatibility (Thomas
+ * Bogendoerfer). Added missing SCp->request_bufflen initialisation
+ * for sense requests (Ryan Bradetich).
+ *
  * Version 2.6
  *
  * Following test of the 64 bit parisc kernel by Richard Hirst,
@@ -96,7 +104,7 @@
  * Initial modularisation from the D700.  See NCR_D700.c for the rest of
  * the changelog.
  * */
-#define NCR_700_VERSION "2.6"
+#define NCR_700_VERSION "2.7"
 
 #include <linux/config.h>
 #include <linux/version.h>
@@ -310,7 +318,6 @@
 	hostdata->pScript = pScript;
 	NCR_700_dma_cache_wback((unsigned long)script, sizeof(SCRIPT));
 	hostdata->state = NCR_700_HOST_FREE;
-	spin_lock_init(&hostdata->lock);
 	hostdata->cmd = NULL;
 	host->max_id = 7;
 	host->max_lun = NCR_700_MAX_LUNS;
@@ -1048,6 +1055,7 @@
 						    slot->pCmd,
 						    SCp->cmd_len,
 						    PCI_DMA_TODEVICE);
+				SCp->request_bufflen = sizeof(SCp->sense_buffer);
 				slot->dma_handle = pci_map_single(hostdata->pci_dev, SCp->sense_buffer, sizeof(SCp->sense_buffer), PCI_DMA_FROMDEVICE);
 				slot->SG[0].ins = bS_to_host(SCRIPT_MOVE_DATA_IN | sizeof(SCp->sense_buffer));
 				slot->SG[0].pAddr = bS_to_host(slot->dma_handle);
@@ -1519,7 +1527,7 @@
 	 * of locking in queuecommand: 1) io_request_lock then 2)
 	 * hostdata->lock would be the reverse of taking it in this
 	 * routine */
-	spin_lock_irqsave(&io_request_lock, flags);
+	spin_lock_irqsave(host->host_lock, flags);
 	if((istat = NCR_700_readb(host, ISTAT_REG))
 	      & (SCSI_INT_PENDING | DMA_INT_PENDING)) {
 		__u32 dsps;
@@ -1764,7 +1772,7 @@
 		}
 	}
  out_unlock:
-	spin_unlock_irqrestore(&io_request_lock, flags);
+	spin_unlock_irqrestore(host->host_lock, flags);
 }
 
 /* FIXME: Need to put some proc information in and plumb it
Index: linux/2.5/drivers/scsi/53c700.h
diff -u linux/2.5/drivers/scsi/53c700.h:1.1.1.1 linux/2.5/drivers/scsi/53c700.h:1.1.1.1.20.1
--- linux/2.5/drivers/scsi/53c700.h:1.1.1.1	Sun Dec  9 12:08:58 2001
+++ linux/2.5/drivers/scsi/53c700.h	Wed Jan 16 13:49:02 2002
@@ -210,7 +210,7 @@
 struct NCR_700_Host_Parameters {
 	/* These must be filled in by the calling driver */
 	int	clock;			/* board clock speed in MHz */
-	__u32	base;			/* the base for the port (copied to host) */
+	unsigned long	base;		/* the base for the port (copied to host) */
 	struct pci_dev	*pci_dev;
 	__u32	dmode_extra;	/* adjustable bus settings */
 	__u32	differential:1;	/* if we are differential */
@@ -234,10 +234,6 @@
 	__u32	*script;		/* pointer to script location */
 	__u32	pScript;		/* physical mem addr of script */
 
-	/* This will be the host lock.  Unfortunately, we can't use it
-	 * at the moment because of the necessity of holding the
-	 * io_request_lock */
-	spinlock_t lock;
 	enum NCR_700_Host_State state; /* protected by state lock */
 	Scsi_Cmnd *cmd;
 	/* Note: pScript contains the single consistent block of
@@ -503,7 +499,7 @@
 static inline __u32
 NCR_700_readl(struct Scsi_Host *host, __u32 reg)
 {
-	__u32 value = readl(host->base + reg);
+	__u32 value = __raw_readl(host->base + reg);
 	const struct NCR_700_Host_Parameters *hostdata __attribute__((unused))
 		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
 #if 1
@@ -536,7 +532,7 @@
 		BUG();
 #endif
 
-	writel(bS_to_host(value), host->base + reg);
+	__raw_writel(bS_to_host(value), host->base + reg);
 }
 #elif defined(CONFIG_53C700_IO_MAPPED)
 static inline __u8
Index: linux/2.5/drivers/scsi/53c700.scr
diff -u linux/2.5/drivers/scsi/53c700.scr:1.1.1.1 linux/2.5/drivers/scsi/53c700.scr:1.1.1.1.20.1
--- linux/2.5/drivers/scsi/53c700.scr:1.1.1.1	Sun Dec  9 12:08:58 2001
+++ linux/2.5/drivers/scsi/53c700.scr	Wed Jan 16 13:49:02 2002
@@ -242,7 +242,7 @@
 
 SendIdentifyMsg:
 	CALL	SendMessage
-	JUMP	SendCommand
+	CLEAR	ATN
 
 IgnoreMsgBeforeCommand:
 	CLEAR	ACK
Index: linux/2.5/drivers/scsi/NCR_D700.c
diff -u linux/2.5/drivers/scsi/NCR_D700.c:1.1.1.1 linux/2.5/drivers/scsi/NCR_D700.c:1.1.1.1.20.1
--- linux/2.5/drivers/scsi/NCR_D700.c:1.1.1.1	Sun Dec  9 12:08:58 2001
+++ linux/2.5/drivers/scsi/NCR_D700.c	Wed Jan 16 13:49:02 2002
@@ -36,6 +36,10 @@
 
 /* CHANGELOG 
  *
+ * Version 2.2
+ *
+ * Added mca_set_adapter_name().
+ *
  * Version 2.1
  *
  * Modularise the driver into a Board piece (this file) and a chip
@@ -86,7 +90,7 @@
  * disconnections and reselections are being processed correctly.
  * */
 
-#define NCR_D700_VERSION "2.1"
+#define NCR_D700_VERSION "2.2"
 
 #include <linux/config.h>
 #include <linux/version.h>
@@ -299,6 +303,7 @@
 				continue;
 			}
 			found++;
+			mca_set_adapter_name(slot, "NCR D700 SCSI Adapter (version " NCR_D700_VERSION ")");
 		}
 	}
 
Index: linux/2.5/drivers/scsi/lasi700.c
diff -u linux/2.5/drivers/scsi/lasi700.c:1.1.1.1 linux/2.5/drivers/scsi/lasi700.c:1.1.1.1.20.1
--- linux/2.5/drivers/scsi/lasi700.c:1.1.1.1	Sun Dec  9 12:08:58 2001
+++ linux/2.5/drivers/scsi/lasi700.c	Wed Jan 16 13:49:02 2002
@@ -136,7 +136,6 @@
 lasi700_driver_callback(struct parisc_device *dev)
 {
 	unsigned long base = dev->hpa + LASI_SCSI_CORE_OFFSET;
-	int irq = busdevice_alloc_irq(dev);
 	char *driver_name;
 	struct Scsi_Host *host;
 	struct NCR_700_Host_Parameters *hostdata =
@@ -170,14 +169,15 @@
 		hostdata->chip710 = 1;
 		hostdata->dmode_extra = DMODE_FC2;
 	}
+	hostdata->pci_dev = ccio_get_fake(dev);
 	if((host = NCR_700_detect(host_tpnt, hostdata)) == NULL) {
 		kfree(hostdata);
 		release_mem_region(host->base, 64);
 		return 1;
 	}
-	host->irq = irq;
-	if(request_irq(irq, NCR_700_intr, SA_SHIRQ, driver_name, host)) {
-		printk(KERN_ERR "%s: irq problem, detatching\n",
+	host->irq = dev->irq;
+	if(request_irq(dev->irq, NCR_700_intr, SA_SHIRQ, driver_name, host)) {
+		printk(KERN_ERR "%s: irq problem, detaching\n",
 		       driver_name);
 		scsi_unregister(host);
 		NCR_700_release(host);
@@ -197,6 +197,7 @@
 	kfree(hostdata);
 	free_irq(host->irq, host);
 	release_mem_region(host->base, 64);
+	unregister_parisc_driver(&lasi700_driver);
 	return 1;
 }
 

--==_Exmh_-17466361920--



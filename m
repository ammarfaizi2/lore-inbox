Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288674AbSADQdN>; Fri, 4 Jan 2002 11:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287449AbSADQdF>; Fri, 4 Jan 2002 11:33:05 -0500
Received: from adsl-64-109-89-110.dsl.chcgil.ameritech.net ([64.109.89.110]:35158
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S288674AbSADQcw>; Fri, 4 Jan 2002 11:32:52 -0500
Message-Id: <200201041632.g04GW7s02196@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: [PATCH] 2.4.17 accumulated bug fixes for 53c700 SCSI drivers
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_14409246500"
Date: Fri, 04 Jan 2002 10:32:06 -0600
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_14409246500
Content-Type: text/plain; charset=us-ascii

This patch against 2.4.17 (although it should apply to virtually any 2.4.x 
kernel) represents an accumulation of bug fixes for the 53c700 drivers:

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

James Bottomley


--==_Exmh_14409246500
Content-Type: text/plain ; name="ncr700-2.7.diff"; charset=us-ascii
Content-Description: ncr700-2.7.diff
Content-Disposition: attachment; filename="ncr700-2.7.diff"

Index: linux/2.4/Makefile
diff -u linux/2.4/Makefile:1.1.1.35 linux/2.4/Makefile:1.1.1.35.4.1
--- linux/2.4/Makefile:1.1.1.35	Thu Jan  3 10:07:49 2002
+++ linux/2.4/Makefile	Thu Jan  3 13:33:48 2002
@@ -204,7 +204,7 @@
 	drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
 	drivers/scsi/aic7xxx/aicasm/y.tab.h \
 	drivers/scsi/aic7xxx/aicasm/aicasm \
-	drivers/scsi/53c700-mem.c \
+	drivers/scsi/53c700_d.h \
 	net/khttpd/make_times_h \
 	net/khttpd/times.h \
 	submenu*
Index: linux/2.4/drivers/scsi/53c700.c
diff -u linux/2.4/drivers/scsi/53c700.c:1.1.1.5 linux/2.4/drivers/scsi/53c700.c:1.1.1.5.8.2
--- linux/2.4/drivers/scsi/53c700.c:1.1.1.5	Sun Oct  7 12:29:48 2001
+++ linux/2.4/drivers/scsi/53c700.c	Thu Jan  3 16:24:25 2002
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
@@ -1049,6 +1057,7 @@
 						    slot->pCmd,
 						    SCp->cmd_len,
 						    PCI_DMA_TODEVICE);
+				SCp->request_bufflen = sizeof(SCp->sense_buffer);
 				slot->dma_handle = pci_map_single(hostdata->pci_dev, SCp->sense_buffer, sizeof(SCp->sense_buffer), PCI_DMA_FROMDEVICE);
 				slot->SG[0].ins = bS_to_host(SCRIPT_MOVE_DATA_IN | sizeof(SCp->sense_buffer));
 				slot->SG[0].pAddr = bS_to_host(slot->dma_handle);
Index: linux/2.4/drivers/scsi/53c700.h
diff -u linux/2.4/drivers/scsi/53c700.h:1.1.1.4 linux/2.4/drivers/scsi/53c700.h:1.1.1.4.8.1
--- linux/2.4/drivers/scsi/53c700.h:1.1.1.4	Sun Oct  7 12:29:48 2001
+++ linux/2.4/drivers/scsi/53c700.h	Thu Jan  3 12:33:38 2002
@@ -210,7 +210,7 @@
 struct NCR_700_Host_Parameters {
 	/* These must be filled in by the calling driver */
 	int	clock;			/* board clock speed in MHz */
-	__u32	base;			/* the base for the port (copied to host) */
+	unsigned long	base;		/* the base for the port (copied to host) */
 	struct pci_dev	*pci_dev;
 	__u32	dmode_extra;	/* adjustable bus settings */
 	__u32	differential:1;	/* if we are differential */
@@ -503,7 +503,7 @@
 static inline __u32
 NCR_700_readl(struct Scsi_Host *host, __u32 reg)
 {
-	__u32 value = readl(host->base + reg);
+	__u32 value = __raw_readl(host->base + reg);
 	const struct NCR_700_Host_Parameters *hostdata __attribute__((unused))
 		= (struct NCR_700_Host_Parameters *)host->hostdata[0];
 #if 1
@@ -536,7 +536,7 @@
 		BUG();
 #endif
 
-	writel(bS_to_host(value), host->base + reg);
+	__raw_writel(bS_to_host(value), host->base + reg);
 }
 #elif defined(CONFIG_53C700_IO_MAPPED)
 static inline __u8
Index: linux/2.4/drivers/scsi/53c700.scr
diff -u linux/2.4/drivers/scsi/53c700.scr:1.1.1.2 linux/2.4/drivers/scsi/53c700.scr:1.1.1.2.12.1
--- linux/2.4/drivers/scsi/53c700.scr:1.1.1.2	Tue Sep 25 18:58:28 2001
+++ linux/2.4/drivers/scsi/53c700.scr	Thu Jan  3 12:30:26 2002
@@ -242,7 +242,7 @@
 
 SendIdentifyMsg:
 	CALL	SendMessage
-	JUMP	SendCommand
+	CLEAR	ATN
 
 IgnoreMsgBeforeCommand:
 	CLEAR	ACK
Index: linux/2.4/drivers/scsi/NCR_D700.c
diff -u linux/2.4/drivers/scsi/NCR_D700.c:1.1.1.2 linux/2.4/drivers/scsi/NCR_D700.c:1.1.1.2.18.2
--- linux/2.4/drivers/scsi/NCR_D700.c:1.1.1.2	Fri Sep  7 20:39:47 2001
+++ linux/2.4/drivers/scsi/NCR_D700.c	Thu Jan  3 17:36:09 2002
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
 
Index: linux/2.4/drivers/scsi/lasi700.c
diff -u linux/2.4/drivers/scsi/lasi700.c:1.1.1.2 linux/2.4/drivers/scsi/lasi700.c:1.1.1.2.12.1
--- linux/2.4/drivers/scsi/lasi700.c:1.1.1.2	Tue Sep 25 18:58:29 2001
+++ linux/2.4/drivers/scsi/lasi700.c	Thu Jan  3 12:33:38 2002
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
 

--==_Exmh_14409246500--



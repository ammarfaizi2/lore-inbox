Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293044AbSB1Pfw>; Thu, 28 Feb 2002 10:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293183AbSB1Pfl>; Thu, 28 Feb 2002 10:35:41 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:20965 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S293422AbSB1PfC>; Thu, 28 Feb 2002 10:35:02 -0500
Date: Thu, 28 Feb 2002 07:34:46 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: tech@psidisk.com, linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.6-pre1/drivers/scsi/pci2000.c compilation fixes + pci device ID table
Message-ID: <20020228073446.A6541@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch is my attempt at getting
linux-2.5.6-pre1/drivers/scsi/pci2000.c to compile, and also adds
a pci_device_id table for automatic module loading.  I would
especially appreciate any input on whether I can use sg_dma_address
the way I have in this patch.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci2000.patch"

--- linux-2.5.6-pre1/drivers/scsi/pci2000.c	Tue Feb 19 18:10:55 2002
+++ linux/drivers/scsi/pci2000.c	Thu Feb 28 07:14:00 2002
@@ -53,6 +53,7 @@
 #include "hosts.h"
 #include <linux/stat.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 
 #include "pci2000.h"
 #include "psi_roy.h"
@@ -102,6 +103,18 @@
 #define HOSTDATA(host) ((PADAPTER2000)&host->hostdata)
 #define consistentLen (MAX_BUS * MAX_UNITS * (16 * sizeof (SCATGATH) + MAX_COMMAND_SIZE))
 
+#ifdef MODULE
+static struct pci_device_id pci2000_pci_tbl[] __initdata = {
+	{
+	  vendor: VENDOR_PSI,
+	  device: DEVICE_ROY_1,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, pci2000_pci_tbl);
+#endif
 
 static struct	Scsi_Host 	   *PsiHost[MAXADAPTER] = {NULL,};  // One for each adapter
 static			int				NumAdapters = 0;
@@ -337,7 +350,7 @@
 				goto irqProceed;
 			}
 		}
-	if ( SCpnt->SCp.have_data_in )
+	if ( SCpnt->SCp.have_data_in  && !SCpnt->use_sg)
 		pci_unmap_single (padapter->pdev, SCpnt->SCp.have_data_in, SCpnt->request_bufflen, scsi_to_pci_dma_dir(SCpnt->sc_data_direction));
 	else 
 		{
@@ -389,7 +402,7 @@
 	OpDone (SCpnt, DID_OK << 16);
 
 irq_return:
-    spin_unlock_irqrestore(&shost->host_lock, flags);
+    spin_unlock_irqrestore(shost->host_lock, flags);
 out:;
 }
 /****************************************************************
@@ -505,8 +518,7 @@
 			
 			if ( SCpnt->use_sg )
 				{
-				SCpnt->SCp.have_data_in = pci_map_single (padapter->pdev, ((struct scatterlist *)SCpnt->request_buffer)->address, 
-										  SCpnt->request_bufflen, scsi_to_pci_dma_dir (SCpnt->sc_data_direction));
+				SCpnt->SCp.have_data_in = sg_dma_address((struct scatterlist *)SCpnt->request_buffer);
 				}
 			else
 				{
@@ -528,8 +540,7 @@
 		case SCSIOP_READ_CAPACITY:			  	// read capacity CDB
 			if ( SCpnt->use_sg )
 				{
-				SCpnt->SCp.have_data_in = pci_map_single (padapter->pdev, ((struct scatterlist *)(SCpnt->request_buffer))->address,
-										  8, PCI_DMA_FROMDEVICE);
+				SCpnt->SCp.have_data_in = sg_dma_address((struct scatterlist *)SCpnt->request_buffer);
 				}
 			else
 				SCpnt->SCp.have_data_in = pci_map_single (padapter->pdev, SCpnt->request_buffer, 8, PCI_DMA_FROMDEVICE);

--n8g4imXOkfNTN/H1--

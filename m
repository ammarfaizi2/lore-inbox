Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSLFPhd>; Fri, 6 Dec 2002 10:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSLFPhd>; Fri, 6 Dec 2002 10:37:33 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263105AbSLFPhb>;
	Fri, 6 Dec 2002 10:37:31 -0500
Subject: [PATCH] aacraid 2.5
From: Mark Haverkamp <markh@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1039189541.6401.8.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 06 Dec 2002 07:45:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies to the bitkeeper 2.5 view.

It contains three changes.  The first removes some #defines that don't seem 
to be needed anymore.  The second fixes a problem when CONFIG_LBD is set 
and sector_t is u64. The third fixes some compile warnings setting a 
char * in the scsi_pointer struct to a dma_addr_t.  I changed the usage 
from the ptr element to the dma_handle element.

It compiles without warnings and I have run some tests on aacraid devices 
on the osdl lab machines with the CONFIG_LBD option on and off.

Mark.

- - - - 


  aachba.c  |   17 ++++++-----------
  aacraid.h |   16 ++++++++++++++++
  linit.c   |    6 ++++--
  3 files changed, 26 insertions(+), 13 deletions(-)


===== drivers/scsi/aacraid/aachba.c 1.5 vs edited =====
--- 1.5/drivers/scsi/aacraid/aachba.c	Mon Nov 11 12:32:15 2002
+++ edited/drivers/scsi/aacraid/aachba.c	Tue Dec  3 08:33:06 2002
@@ -33,18 +33,12 @@
  #include <linux/completion.h>
  #include <asm/semaphore.h>
  #include <asm/uaccess.h>
-#define MAJOR_NR SCSI_DISK0_MAJOR	/* For DEVICE_NR() */
  #include <linux/blk.h>
  #include "scsi.h"
  #include "hosts.h"

  #include "aacraid.h"

-#warning this is broken
-#define N_SD_MAJORS	8
-#define SD_MAJOR_MASK	(N_SD_MAJORS - 1)
-#define DEVICE_NR(device) (((major(device) & SD_MAJOR_MASK) << (8 - 4)) + 
(minor(device) >> 4))
-
  /*	SCSI Commands */
  /*	TODO:  dmb - use the ones defined in include/scsi/scsi.h */

@@ -567,7 +561,7 @@
  			scsicmd->use_sg,
  			scsi_to_pci_dma_dir(scsicmd->sc_data_direction));
  	else if(scsicmd->request_bufflen)
-		pci_unmap_single(dev->pdev, (dma_addr_t)(unsigned long)scsicmd->SCp.ptr,
+		pci_unmap_single(dev->pdev, scsicmd->SCp.dma_handle,
  				 scsicmd->request_bufflen,
  				 scsi_to_pci_dma_dir(scsicmd->sc_data_direction));
  	readreply = (struct aac_read_reply *)fib_data(fibptr);
@@ -611,7 +605,7 @@
  			scsicmd->use_sg,
  			scsi_to_pci_dma_dir(scsicmd->sc_data_direction));
  	else if(scsicmd->request_bufflen)
-		pci_unmap_single(dev->pdev, (dma_addr_t)(unsigned long)scsicmd->SCp.ptr,
+		pci_unmap_single(dev->pdev, scsicmd->SCp.dma_handle,
  				 scsicmd->request_bufflen,
  				 scsi_to_pci_dma_dir(scsicmd->sc_data_direction));

@@ -1225,7 +1219,8 @@
  			scsicmd->use_sg,
  			scsi_to_pci_dma_dir(scsicmd->sc_data_direction));
  	else if(scsicmd->request_bufflen)
-		pci_unmap_single(dev->pdev, (ulong)scsicmd->SCp.ptr, scsicmd->request_bufflen,
+		pci_unmap_single(dev->pdev, scsicmd->SCp.dma_handle,
+			scsicmd->request_bufflen,
  			scsi_to_pci_dma_dir(scsicmd->sc_data_direction));

  	/*
@@ -1516,7 +1511,7 @@
  		psg->count = cpu_to_le32(1);
  		psg->sg[0].addr = cpu_to_le32(addr);
  		psg->sg[0].count = cpu_to_le32(scsicmd->request_bufflen);
-		scsicmd->SCp.ptr = (void *)addr;
+		scsicmd->SCp.dma_handle = addr;
  		byte_count = scsicmd->request_bufflen;
  	}
  	return byte_count;
@@ -1577,7 +1572,7 @@
  		psg->sg[0].addr[1] = (u32)(le_addr>>32);
  		psg->sg[0].addr[0] = (u32)(le_addr & 0xffffffff);
  		psg->sg[0].count = cpu_to_le32(scsicmd->request_bufflen);
-		scsicmd->SCp.ptr = (void *)addr;
+		scsicmd->SCp.dma_handle = addr;
  		byte_count = scsicmd->request_bufflen;
  	}
  	return byte_count;
===== drivers/scsi/aacraid/aacraid.h 1.2 vs edited =====
--- 1.2/drivers/scsi/aacraid/aacraid.h	Fri Nov  1 04:28:15 2002
+++ edited/drivers/scsi/aacraid/aacraid.h	Tue Dec  3 08:15:27 2002
@@ -1369,6 +1369,22 @@
  	return (struct hw_fib *)addr;
  }

+/**
+ * 	Convert capacity to cylinders
+ *  	accounting for the fact capacity could be a 64 bit value
+ *
+ */
+static inline u32 cap_to_cyls(sector_t capacity, u32 divisor)
+{
+#ifdef CONFIG_LBD
+	do_div(capacity, divisor);
+#else
+	capacity /= divisor;
+#endif
+	return (u32) capacity;
+}
+
+
  const char *aac_driverinfo(struct Scsi_Host *);
  struct fib *fib_alloc(struct aac_dev *dev);
  int fib_setup(struct aac_dev *dev);
===== drivers/scsi/aacraid/linit.c 1.6 vs edited =====
--- 1.6/drivers/scsi/aacraid/linit.c	Thu Nov 21 21:34:44 2002
+++ edited/drivers/scsi/aacraid/linit.c	Tue Dec  3 13:22:08 2002
@@ -443,7 +443,8 @@
  		param->sectors = 32;
  	}

-	param->cylinders = capacity/(param->heads * param->sectors);
+	param->cylinders = cap_to_cyls(capacity,
+			(param->heads * param->sectors));

  	/*
  	 *	Read the partition table block
@@ -497,7 +498,8 @@
  			end_sec = first->end_sector & 0x3f;
  		}

-		param->cylinders = capacity / (param->heads * param->sectors);
+		param->cylinders = cap_to_cyls(capacity,
+				(param->heads * param->sectors));

  		if(num < 4 && end_sec == param->sectors)
  		{
-- 
Mark Haverkamp <markh@osdl.org>


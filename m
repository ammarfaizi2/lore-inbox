Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267171AbUBMSnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267173AbUBMSnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:43:37 -0500
Received: from havoc.gtf.org ([63.247.75.124]:56964 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267171AbUBMSnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:43:22 -0500
Date: Fri, 13 Feb 2004 13:43:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.6.x libata update
Message-ID: <20040213184316.GA28871@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.5

This will update the following files:

 drivers/scsi/ata_piix.c     |    6 +++---
 drivers/scsi/libata-core.c  |   40 ++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/libata-scsi.c  |    4 ++--
 drivers/scsi/libata.h       |    6 +++---
 drivers/scsi/sata_promise.c |    2 +-
 drivers/scsi/sata_via.c     |    4 ++--
 include/linux/ata.h         |    4 ++--
 include/linux/libata.h      |    4 ++--
 8 files changed, 53 insertions(+), 17 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (04/02/13 1.1635)
   Bump libata, ata_piix to version 1.0.
   
   Also update copyrights for 2004.

<jgarzik@redhat.com> (04/02/13 1.1634)
   [libata] catch, and ack, spurious DMA interrupts
   
   Hardware issue on Intel ICH5 requires an additional ack sequence
   over and above the normal IDE DMA interrupt ack requirements.  Issue
   described in post to freebsd list:
   http://www.mail-archive.com/freebsd-stable@freebsd.org/msg58421.html
   
   Since the bug workaround only requires a single additional PIO or
   MMIO read in the interrupt handler, it is applied to all chipsets
   using the standard libata interrupt handler.
   
   Credit for research the issue, creating the patch, and testing the
   patch all go to Jon Burgess.

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	Fri Feb 13 13:40:32 2004
+++ b/drivers/scsi/ata_piix.c	Fri Feb 13 13:40:32 2004
@@ -3,8 +3,8 @@
     ata_piix.c - Intel PATA/SATA controllers
 
 
-	Copyright 2003 Red Hat Inc
-	Copyright 2003 Jeff Garzik
+	Copyright 2003-2004 Red Hat Inc
+	Copyright 2003-2004 Jeff Garzik
 
 
 	Copyright header from piix.c:
@@ -28,7 +28,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"0.95"
+#define DRV_VERSION	"1.00"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Fri Feb 13 13:40:32 2004
+++ b/drivers/scsi/libata-core.c	Fri Feb 13 13:40:32 2004
@@ -1,8 +1,8 @@
 /*
    libata-core.c - helper library for ATA
 
-   Copyright 2003 Red Hat, Inc.  All rights reserved.
-   Copyright 2003 Jeff Garzik
+   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+   Copyright 2003-2004 Jeff Garzik
 
    The contents of this file are subject to the Open
    Software License version 1.1 that can be found at
@@ -2386,6 +2386,41 @@
 }
 
 /**
+ *	ata_chk_spurious_int - Check for spurious interrupts
+ *	@ap: port to which command is being issued
+ *
+ *	Examines the DMA status registers and clears
+ *      unexpected interrupts.  Created to work around
+ *	hardware bug on Intel ICH5, but is applied to all
+ *	chipsets using the standard irq handler, just for safety.
+ *	If the bug is not present, this is simply a single
+ *	PIO or MMIO read addition to the irq handler.
+ *
+ *	LOCKING:
+ */
+static inline void ata_chk_spurious_int(struct ata_port *ap) {
+	int host_stat;
+	
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	
+	if ((host_stat & (ATA_DMA_INTR | ATA_DMA_ERR | ATA_DMA_ACTIVE)) == ATA_DMA_INTR) {
+		if (ap->flags & ATA_FLAG_MMIO) {
+			void *mmio = (void *) ap->ioaddr.bmdma_addr;
+			writeb(host_stat & ~ATA_DMA_ERR, mmio + ATA_DMA_STATUS);
+		} else
+			outb(host_stat & ~ATA_DMA_ERR, ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		
+		DPRINTK("ata%u: Caught spurious interrupt, status 0x%X\n", ap->id, host_stat);
+		udelay(1);
+	}
+}
+
+
+/**
  *	ata_interrupt -
  *	@irq:
  *	@dev_instance:
@@ -2417,6 +2452,7 @@
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
 				handled += ata_host_intr(ap, qc);
+			ata_chk_spurious_int(ap);
 		}
 	}
 
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	Fri Feb 13 13:40:32 2004
+++ b/drivers/scsi/libata-scsi.c	Fri Feb 13 13:40:32 2004
@@ -1,8 +1,8 @@
 /*
    libata-scsi.c - helper library for ATA
 
-   Copyright 2003 Red Hat, Inc.  All rights reserved.
-   Copyright 2003 Jeff Garzik
+   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+   Copyright 2003-2004 Jeff Garzik
 
    The contents of this file are subject to the Open
    Software License version 1.1 that can be found at
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	Fri Feb 13 13:40:32 2004
+++ b/drivers/scsi/libata.h	Fri Feb 13 13:40:32 2004
@@ -1,8 +1,8 @@
 /*
    libata.h - helper library for ATA
 
-   Copyright 2003 Red Hat, Inc.  All rights reserved.
-   Copyright 2003 Jeff Garzik
+   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+   Copyright 2003-2004 Jeff Garzik
 
    The contents of this file are subject to the Open
    Software License version 1.1 that can be found at
@@ -26,7 +26,7 @@
 #define __LIBATA_H__
 
 #define DRV_NAME	"libata"
-#define DRV_VERSION	"0.81"	/* must be exactly four chars */
+#define DRV_VERSION	"1.00"	/* must be exactly four chars */
 
 struct ata_scsi_args {
 	struct ata_port		*ap;
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	Fri Feb 13 13:40:32 2004
+++ b/drivers/scsi/sata_promise.c	Fri Feb 13 13:40:32 2004
@@ -1,7 +1,7 @@
 /*
  *  sata_promise.c - Promise SATA
  *
- *  Copyright 2003 Red Hat, Inc.
+ *  Copyright 2003-2004 Red Hat, Inc.
  *
  *  The contents of this file are subject to the Open
  *  Software License version 1.1 that can be found at
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	Fri Feb 13 13:40:32 2004
+++ b/drivers/scsi/sata_via.c	Fri Feb 13 13:40:32 2004
@@ -1,8 +1,8 @@
 /*
    sata_via.c - VIA Serial ATA controllers
 
-   Copyright 2003 Red Hat, Inc.  All rights reserved.
-   Copyright 2003 Jeff Garzik
+   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+   Copyright 2003-2004 Jeff Garzik
 
    The contents of this file are subject to the Open
    Software License version 1.1 that can be found at
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	Fri Feb 13 13:40:32 2004
+++ b/include/linux/ata.h	Fri Feb 13 13:40:32 2004
@@ -1,7 +1,7 @@
 
 /*
-   Copyright 2003 Red Hat, Inc.  All rights reserved.
-   Copyright 2003 Jeff Garzik
+   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+   Copyright 2003-2004 Jeff Garzik
 
    The contents of this file are subject to the Open
    Software License version 1.1 that can be found at
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	Fri Feb 13 13:40:32 2004
+++ b/include/linux/libata.h	Fri Feb 13 13:40:32 2004
@@ -1,6 +1,6 @@
 /*
-   Copyright 2003 Red Hat, Inc.  All rights reserved.
-   Copyright 2003 Jeff Garzik
+   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+   Copyright 2003-2004 Jeff Garzik
 
    The contents of this file are subject to the Open
    Software License version 1.1 that can be found at

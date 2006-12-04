Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760203AbWLDBtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760203AbWLDBtZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 20:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760204AbWLDBtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 20:49:25 -0500
Received: from havoc.gtf.org ([69.61.125.42]:17795 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1760203AbWLDBtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 20:49:24 -0500
Date: Sun, 3 Dec 2006 20:49:23 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI/megaraid: fix MMIO casts
Message-ID: <20061204014923.GA7227@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


megaraid's MMIO RD*/WR* macros directly call readl() and writel() with
an 'unsigned long' argument.  This throws a warning, but is otherwise OK
because the 'unsigned long' is really the result of ioremap().  This
setup is also OK because the variable can hold an ioremap cookie /or/ a
PCI I/O port (PIO).

However, to fix the warning thrown when readl() and writel() are passed
an unsigned long cookie, I introduce 'void __iomem *mmio_base', holding
the same value as 'base'.  This will silence the warnings, and also
cause an oops whenever these MMIO-only functions are ever accidentally
passed an I/O address.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 86099fd..77d9d38 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -73,10 +73,10 @@ static unsigned short int max_mbox_busy_
 module_param(max_mbox_busy_wait, ushort, 0);
 MODULE_PARM_DESC(max_mbox_busy_wait, "Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
 
-#define RDINDOOR(adapter)		readl((adapter)->base + 0x20)
-#define RDOUTDOOR(adapter)		readl((adapter)->base + 0x2C)
-#define WRINDOOR(adapter,value)		writel(value, (adapter)->base + 0x20)
-#define WROUTDOOR(adapter,value)	writel(value, (adapter)->base + 0x2C)
+#define RDINDOOR(adapter)	readl((adapter)->mmio_base + 0x20)
+#define RDOUTDOOR(adapter)	readl((adapter)->mmio_base + 0x2C)
+#define WRINDOOR(adapter,value)	 writel(value, (adapter)->mmio_base + 0x20)
+#define WROUTDOOR(adapter,value) writel(value, (adapter)->mmio_base + 0x2C)
 
 /*
  * Global variables
@@ -1386,7 +1386,8 @@ megaraid_isr_memmapped(int irq, void *de
 
 		handled = 1;
 
-		while( RDINDOOR(adapter) & 0x02 ) cpu_relax();
+		while( RDINDOOR(adapter) & 0x02 )
+			cpu_relax();
 
 		mega_cmd_done(adapter, completed, nstatus, status);
 
@@ -4668,6 +4669,8 @@ megaraid_probe_one(struct pci_dev *pdev,
 		host->host_no, mega_baseport, irq);
 
 	adapter->base = mega_baseport;
+	if (flag & BOARD_MEMMAP)
+		adapter->mmio_base = (void __iomem *) mega_baseport;
 
 	INIT_LIST_HEAD(&adapter->free_list);
 	INIT_LIST_HEAD(&adapter->pending_list);
diff --git a/drivers/scsi/megaraid.h b/drivers/scsi/megaraid.h
index 66529f1..c6e7464 100644
--- a/drivers/scsi/megaraid.h
+++ b/drivers/scsi/megaraid.h
@@ -801,7 +801,8 @@ typedef struct {
 				   clustering is available */
 	u32	flag;
 
-	unsigned long	base;
+	unsigned long		base;
+	void __iomem		*mmio_base;
 
 	/* mbox64 with mbox not aligned on 16-byte boundry */
 	mbox64_t	*una_mbox64;


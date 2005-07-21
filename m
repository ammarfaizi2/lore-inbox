Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVGUVSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVGUVSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 17:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVGUVQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 17:16:23 -0400
Received: from ptr-64-201-187-87.ptr.terago.ca ([64.201.187.87]:50578 "HELO
	mars.net-itech.com") by vger.kernel.org with SMTP id S261878AbVGUVOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 17:14:23 -0400
Message-ID: <42E0102E.2050603@nit.ca>
Date: Thu, 21 Jul 2005 17:14:22 -0400
From: Lukasz Kosewski <lkosewsk@nit.ca>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jgarzik@pobox.com, linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Add disk hotswap support to libata
Content-Type: multipart/mixed;
 boundary="------------020500000404040803040901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020500000404040803040901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch changes the sata_promise driver in libata to correctly mask 
out hotplug interrupts.  The location of the primary hotplug registers 
in the SATA150 Tx4/Tx2 Plus controllers is correctly defined as '0x6C', 
HOWEVER, for the SATAII150 Tx4/Tx2 Plus controllers, this changes to 
'0x60'.  This patch rectifies us 'masking out interrupts' at the wrong 
location, thus not masking them out at all.

Also, the promise interrupt handler uses a 'spin_lock', I have changed 
it into a 'spin_lock_irqsave', since I observe this on most other libata 
drivers, so for consistency.

I've also set up a new callback for handling SATAII150 interrupts, which 
seemingly does nothing in this patch.  Yes, it does nothing.  Wait until 
  we get to patch 03, though.

I don't expect there to be too much contentious material in this patch.

Luke Kosewski
Human Cannonball
Net Integration Technologies

Signed-off-by:  Luke Kosewski <lkosewsk@nit.ca>

--------------020500000404040803040901
Content-Type: text/plain;
 name="01-promise_sataII150_support-2.6.13-rc3-mm1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-promise_sataII150_support-2.6.13-rc3-mm1.diff"

21.07.05  Luke Kosewski  <lkosewsk@nit.ca>

	* A patch to the sata_promise driver in libata for it to correctly mask
	  out hotplug interrupts on SATAII150 Tx4/Tx2 Plus controllers.  Also,
	  the 'spin_lock' in the interrupt handler has been changed to a
	  'spin_lock_irqsave' for consistency with other libata drivers.

Signed-off-by:  Luke Kosewski <lkosewsk@nit.ca>

--- linux-2.6.13-rc3/drivers/scsi/sata_promise.c.old	2005-07-21 13:35:43.311486155 -0400
+++ linux-2.6.13-rc3/drivers/scsi/sata_promise.c	2005-07-21 13:40:06.145261193 -0400
@@ -52,6 +52,7 @@ enum {
 	PDC_GLOBAL_CTL		= 0x48, /* Global control/status (per port) */
 	PDC_CTLSTAT		= 0x60,	/* IDE control and status (per port) */
 	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
+	PDC2_SATA_PLUG_CSR	= 0x60, /* SATAII Plug control/status reg */
 	PDC_SLEW_CTL		= 0x470, /* slew rate control reg */
 
 	PDC_ERR_MASK		= (1<<19) | (1<<20) | (1<<21) | (1<<22) |
@@ -60,8 +61,10 @@ enum {
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
 	board_20619		= 2,	/* FastTrak TX4000 */
+	board_2057x		= 3,	/* SATAII150 Tx2plus */
+	board_40518		= 4,	/* SATAII150 Tx4 */
 
-	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
+	PDC_HAS_PATA		= (1 << 1), /* PDC20375/20575 has PATA */
 
 	PDC_RESET		= (1 << 11), /* HDMA reset */
 };
@@ -76,6 +79,7 @@ static u32 pdc_sata_scr_read (struct ata
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static irqreturn_t pdc2_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
@@ -128,6 +132,26 @@ static struct ata_port_operations pdc_at
 	.host_stop		= ata_host_stop,
 };
 
+static struct ata_port_operations pdc2_ata_ops = {
+	.port_disable		= ata_port_disable,
+	.tf_load		= pdc_tf_load_mmio,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= pdc_exec_command_mmio,
+	.dev_select		= ata_std_dev_select,
+	.phy_reset		= pdc_phy_reset,
+	.qc_prep		= pdc_qc_prep,
+	.qc_issue		= pdc_qc_issue_prot,
+	.eng_timeout		= pdc_eng_timeout,
+	.irq_handler		= pdc2_interrupt,
+	.irq_clear		= pdc_irq_clear,
+	.scr_read		= pdc_sata_scr_read,
+	.scr_write		= pdc_sata_scr_write,
+	.port_start		= pdc_port_start,
+	.port_stop		= pdc_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
 static struct ata_port_info pdc_port_info[] = {
 	/* board_2037x */
 	{
@@ -161,6 +185,28 @@ static struct ata_port_info pdc_port_inf
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_ata_ops,
 	},
+
+	/* board_2057x */
+	{
+		.sht		= &pdc_ata_sht,
+		.host_flags	= /* ATA_FLAG_SATA | */ ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc2_ata_ops,
+	},
+
+	/* board_40518 */
+	{
+		.sht		= &pdc_ata_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc2_ata_ops,
+	},
 };
 
 static struct pci_device_id pdc_ata_pci_tbl[] = {
@@ -175,16 +221,16 @@ static struct pci_device_id pdc_ata_pci_
 	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3574, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
+	  board_2057x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
+	  board_2057x },
 
 	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20319 },
+	  board_40518 },
 
 	{ PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20619 },
@@ -432,39 +478,36 @@ static void pdc_irq_clear(struct ata_por
 	readl(mmio + PDC_INT_SEQMASK);
 }
 
-static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+static inline unsigned int pdc_interrupt_common(int irq, void *dev_instance, struct pt_regs *regs, unsigned int hotplug_regs)
 {
 	struct ata_host_set *host_set = dev_instance;
 	struct ata_port *ap;
-	u32 mask = 0;
-	unsigned int i, tmp;
-	unsigned int handled = 0;
 	void *mmio_base;
-
-	VPRINTK("ENTER\n");
+	u32 mask = 0;
+	unsigned int i, tmp, handled = 0;
+	unsigned long flags;
 
 	if (!host_set || !host_set->mmio_base) {
-		VPRINTK("QUICK EXIT\n");
-		return IRQ_NONE;
+		return 0;
 	}
 
 	mmio_base = host_set->mmio_base;
+	
+	spin_lock_irqsave(&host_set->lock, flags);
 
 	/* reading should also clear interrupts */
 	mask = readl(mmio_base + PDC_INT_SEQMASK);
 
 	if (mask == 0xffffffff) {
 		VPRINTK("QUICK EXIT 2\n");
-		return IRQ_NONE;
+		goto done_irq;
 	}
 	mask &= 0xffff;		/* only 16 tags possible */
 	if (!mask) {
 		VPRINTK("QUICK EXIT 3\n");
-		return IRQ_NONE;
+		goto done_irq;
 	}
 
-	spin_lock(&host_set->lock);
-
 	writel(mask, mmio_base + PDC_INT_SEQMASK);
 
 	for (i = 0; i < host_set->n_ports; i++) {
@@ -479,12 +522,20 @@ static irqreturn_t pdc_interrupt (int ir
 				handled += pdc_host_intr(ap, qc);
 		}
 	}
+       
+done_irq:
+	spin_unlock_irqrestore(&host_set->lock, flags);
+	return handled;
+}
 
-        spin_unlock(&host_set->lock);
-
-	VPRINTK("EXIT\n");
+static irqreturn_t pdc2_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	return IRQ_RETVAL(pdc_interrupt_common(irq, dev_instance, regs, PDC2_SATA_PLUG_CSR));
+}
 
-	return IRQ_RETVAL(handled);
+static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+{
+	return IRQ_RETVAL(pdc_interrupt_common(irq, dev_instance, regs, PDC_SATA_PLUG_CSR));
 }
 
 static inline void pdc_packet_start(struct ata_queued_cmd *qc)
@@ -561,6 +612,7 @@ static void pdc_ata_setup_port(struct at
 static void pdc_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
 {
 	void *mmio = pe->mmio_base;
+	void* offset;
 	u32 tmp;
 
 	/*
@@ -574,13 +626,19 @@ static void pdc_host_init(unsigned int c
 	tmp |= 0x12000;	/* bit 16 (fifo 8 dw) and 13 (bmr burst?) */
 	writel(tmp, mmio + PDC_FLASH_CTL);
 
+	offset = mmio;
+	if (chip_id >= board_2057x && chip_id <= board_40518)
+		offset += PDC2_SATA_PLUG_CSR;
+	else
+		offset += PDC_SATA_PLUG_CSR;
+	
 	/* clear plug/unplug flags for all ports */
-	tmp = readl(mmio + PDC_SATA_PLUG_CSR);
-	writel(tmp | 0xff, mmio + PDC_SATA_PLUG_CSR);
+	tmp = readl(offset);
+	writel(tmp | 0xff, offset);
 
 	/* mask plug/unplug ints */
-	tmp = readl(mmio + PDC_SATA_PLUG_CSR);
-	writel(tmp | 0xff0000, mmio + PDC_SATA_PLUG_CSR);
+	tmp = readl(offset);
+	writel(tmp | 0xff0000, offset);
 
 	/* reduce TBG clock to 133 Mhz. */
 	tmp = readl(mmio + PDC_TBG_MODE);
@@ -674,6 +732,7 @@ static int pdc_ata_init_one (struct pci_
 	/* notice 4-port boards */
 	switch (board_idx) {
 	case board_20319:
+	case board_40518:
        		probe_ent->n_ports = 4;
 
 		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
@@ -686,6 +745,7 @@ static int pdc_ata_init_one (struct pci_
 		probe_ent->port_flags[3] = ATA_FLAG_SATA;
 		break;
 	case board_2037x:
+	case board_2057x:
 		/* Some boards have also PATA port */
 		tmp = readb(mmio_base + PDC_FLASH_CTL+1);
 		if (!(tmp & 0x80))

--------------020500000404040803040901--

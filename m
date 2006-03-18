Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752278AbWCRIGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbWCRIGX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbWCRIGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:06:23 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:10657 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1752278AbWCRIGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:06:22 -0500
Date: Sat, 18 Mar 2006 03:06:18 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
Message-ID: <20060318080618.GA19929@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
References: <20060317232339.GA5674@ti64.telemetry-investments.com> <441B5AD5.5020809@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441B5AD5.5020809@garzik.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 07:56:53PM -0500, Jeff Garzik wrote:
> Could I get you to diff against the attached version?

Certainly.

I took the opportunity to modify my source file to fix a pair of typos in
the pci_device_id changes, and make cosmetic changes by switching to enums
rather than #defines, removing unnecessary braces around single statements,
and fixing whitespace.  That reduced the noise considerably, and made the
NV_ADMA_CTL_READ_NON_COHERENT difference manifest.

	-Bill

--- sata_nv.c.garzik	2006-03-18 01:50:18.518554000 -0500
+++ sata_nv.c	2006-03-18 02:53:18.000000000 -0500
@@ -29,6 +29,38 @@
  *  NV-specific details such as register offsets, SATA phy location,
  *  hotplug info, etc.
  *
+ *  0.11
+ *     - Added support for ADMA.  Disabled by default.  Use the module
+ *       option adma=on to enable it for supported chipsets.
+ *
+ *  0.10
+ *     - Fixed spurious interrupts issue seen with the Maxtor 6H500F0 500GB
+ *       drive.  Also made the check_hotplug() callbacks return whether there
+ *       was a hotplug interrupt or not.  This was not the source of the
+ *       spurious interrupts, but is the right thing to do anyway.
+ *
+ *  0.09
+ *     - Fixed bug introduced by 0.08's MCP51 and MCP55 support.
+ *
+ *  0.08
+ *     - Added support for MCP51 and MCP55.
+ *
+ *  0.07
+ *     - Added support for RAID class code.
+ *
+ *  0.06
+ *     - Added generic SATA support by using a pci_device_id that filters on
+ *       the IDE storage class code.
+ *
+ *  0.03
+ *     - Fixed a bug where the hotplug handlers for non-CK804/MCP04 were using
+ *       mmio_base, which is only set for the CK804/MCP04 case.
+ *
+ *  0.02
+ *     - Added support for CK804 SATA controller.
+ *
+ *  0.01
+ *     - Initial revision.
  */
 
 #include <linux/config.h>
@@ -47,7 +79,7 @@
 //#define DEBUG
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.8"
+#define DRV_VERSION			"0.11-alpha"
 
 enum {
 	NV_PORTS			= 2,
@@ -148,7 +180,7 @@ enum {
 	NV_ADMA_CTL_CHANNEL_RESET	= (1 << 5),
 	NV_ADMA_CTL_GO			= (1 << 7),
 	NV_ADMA_CTL_AIEN		= (1 << 8),
-	NV_ADMA_CTL_READ_NON_COHERENT	= (1 << 11),
+	NV_ADMA_CTL_READ_NON_COHERENT	= (2 << 11),
 	NV_ADMA_CTL_WRITE_NON_COHERENT	= (1 << 12),
 
 	// CPB response flag bits
@@ -186,6 +218,10 @@ enum {
 	NV_ADMA_PORT_REGISTER_MODE	= (1 << 0),
 };
 
+#ifndef min
+#define min(x,y) ((x) < (y) ? x : y)
+#endif
+
 struct nv_adma_prd {
 	u64			addr;
 	u32			len;
@@ -237,18 +273,23 @@ static irqreturn_t nv_interrupt (int irq
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void nv_host_stop (struct ata_host_set *host_set);
+static int nv_port_start(struct ata_port *ap);
+static void nv_port_stop(struct ata_port *ap);
 static int nv_adma_port_start(struct ata_port *ap);
 static void nv_adma_port_stop(struct ata_port *ap);
+static void nv_irq_clear(struct ata_port *ap);
 static void nv_adma_irq_clear(struct ata_port *ap);
 static void nv_enable_hotplug(struct ata_probe_ent *probe_ent);
 static void nv_disable_hotplug(struct ata_host_set *host_set);
-static void nv_check_hotplug(struct ata_host_set *host_set);
+static int nv_check_hotplug(struct ata_host_set *host_set);
 static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent);
 static void nv_disable_hotplug_ck804(struct ata_host_set *host_set);
-static void nv_check_hotplug_ck804(struct ata_host_set *host_set);
+static int nv_check_hotplug_ck804(struct ata_host_set *host_set);
 static void nv_enable_hotplug_adma(struct ata_probe_ent *probe_ent);
 static void nv_disable_hotplug_adma(struct ata_host_set *host_set);
-static void nv_check_hotplug_adma(struct ata_host_set *host_set);
+static int nv_check_hotplug_adma(struct ata_host_set *host_set);
+static void nv_qc_prep(struct ata_queued_cmd *qc);
+static int nv_qc_issue(struct ata_queued_cmd *qc);
 static int nv_adma_qc_issue(struct ata_queued_cmd *qc);
 static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int nv_adma_tf_to_cpb(struct ata_taskfile *tf, u16 *cpb);
@@ -256,8 +297,11 @@ static void nv_adma_fill_sg(struct ata_q
 static void nv_adma_fill_aprd(struct ata_queued_cmd *qc, struct scatterlist *sg, int idx, struct nv_adma_prd *aprd);
 static void nv_adma_register_mode(struct ata_port *ap);
 static void nv_adma_mode(struct ata_port *ap);
+static u8 nv_bmdma_status(struct ata_port *ap);
 static u8 nv_adma_bmdma_status(struct ata_port *ap);
+static void nv_bmdma_stop(struct ata_queued_cmd *qc);
 static void nv_adma_bmdma_stop(struct ata_queued_cmd *qc);
+static void nv_eng_timeout(struct ata_port *ap);
 static void nv_adma_eng_timeout(struct ata_port *ap);
 #ifdef DEBUG
 static void nv_adma_dump_cpb(struct nv_adma_cpb *cpb);
@@ -267,40 +311,40 @@ static void nv_adma_dump_port(struct ata
 static void nv_adma_dump_iomem(void __iomem *m, int len);
 #endif
 
+
+static int adma_enabled;
+
 enum nv_host_type
 {
-	GENERIC,
-	NFORCE2,
-	NFORCE3,
-	CK804,
-	MCP51,
-	MCP55,
-	ADMA
+	GENERIC = 0x0,
+	NFORCE  = 0x1,
+	CK804   = 0x2,
+	ADMA    = 0x4
 };
 
 static const struct pci_device_id nv_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE2 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE3 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE3 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ADMA },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 | ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ADMA },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 | ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ADMA },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 | ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ADMA },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 | ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
@@ -317,7 +361,7 @@ struct nv_host_desc
 	enum nv_host_type	host_type;
 	void			(*enable_hotplug)(struct ata_probe_ent *probe_ent);
 	void			(*disable_hotplug)(struct ata_host_set *host_set);
-	void			(*check_hotplug)(struct ata_host_set *host_set);
+	int			(*check_hotplug)(struct ata_host_set *host_set);
 
 };
 static struct nv_host_desc nv_device_tbl[] = {
@@ -328,13 +372,7 @@ static struct nv_host_desc nv_device_tbl
 		.check_hotplug	= NULL,
 	},
 	{
-		.host_type	= NFORCE2,
-		.enable_hotplug	= nv_enable_hotplug,
-		.disable_hotplug= nv_disable_hotplug,
-		.check_hotplug	= nv_check_hotplug,
-	},
-	{
-		.host_type	= NFORCE3,
+		.host_type	= NFORCE,
 		.enable_hotplug	= nv_enable_hotplug,
 		.disable_hotplug= nv_disable_hotplug,
 		.check_hotplug	= nv_check_hotplug,
@@ -344,16 +382,6 @@ static struct nv_host_desc nv_device_tbl
 		.disable_hotplug= nv_disable_hotplug_ck804,
 		.check_hotplug	= nv_check_hotplug_ck804,
 	},
-	{	.host_type	= MCP51,
-		.enable_hotplug	= nv_enable_hotplug,
-		.disable_hotplug= nv_disable_hotplug,
-		.check_hotplug	= nv_check_hotplug,
-	},
-	{	.host_type	= MCP55,
-		.enable_hotplug	= nv_enable_hotplug,
-		.disable_hotplug= nv_disable_hotplug,
-		.check_hotplug	= nv_check_hotplug,
-	},
 	{	.host_type	= ADMA,
 		.enable_hotplug	= nv_enable_hotplug_adma,
 		.disable_hotplug= nv_disable_hotplug_adma,
@@ -393,25 +421,6 @@ static struct scsi_host_template nv_sht 
 	.bios_param		= ata_std_bios_param,
 };
 
-static struct scsi_host_template nv_adma_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.eh_strategy_handler	= ata_scsi_error,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= NV_ADMA_SGTBL_LEN,
-	.max_sectors		= ATA_MAX_SECTORS,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.bios_param		= ata_std_bios_param,
-};
-
 static const struct ata_port_operations nv_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= ata_tf_load,
@@ -422,41 +431,17 @@ static const struct ata_port_operations 
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
-	.irq_handler		= nv_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
-	.scr_read		= nv_scr_read,
-	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= nv_host_stop,
-};
-
-static const struct ata_port_operations nv_adma_ops = {
-	.port_disable		= ata_port_disable,
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
-	.check_status		= ata_check_status,
-	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= nv_adma_bmdma_stop,
-	.bmdma_status		= nv_adma_bmdma_status,
-	.qc_prep		= nv_adma_qc_prep,
-	.qc_issue		= nv_adma_qc_issue,
-	.eng_timeout		= nv_adma_eng_timeout,
+	.bmdma_stop		= nv_bmdma_stop,
+	.bmdma_status		= nv_bmdma_status,
+	.qc_prep		= nv_qc_prep,
+	.qc_issue		= nv_qc_issue,
+	.eng_timeout		= nv_eng_timeout,
 	.irq_handler		= nv_interrupt,
-	.irq_clear		= nv_adma_irq_clear,
+	.irq_clear		= nv_irq_clear,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= nv_adma_port_start,
-	.port_stop		= nv_adma_port_stop,
+	.port_start		= nv_port_start,
+	.port_stop		= nv_port_stop,
 	.host_stop		= nv_host_stop,
 };
 
@@ -646,19 +631,6 @@ static struct ata_port_info nv_port_info
 	.port_ops	= &nv_ops,
 };
 
-static struct ata_port_info nv_adma_port_info = {
-	.sht		= &nv_adma_sht,
-	.host_flags	= ATA_FLAG_SATA |
-			  /* ATA_FLAG_SATA_RESET | */
-			  ATA_FLAG_SRST |
-			  ATA_FLAG_MMIO |
-			  ATA_FLAG_NO_LEGACY,
-	.pio_mask	= NV_PIO_MASK,
-	.mwdma_mask	= NV_MWDMA_MASK,
-	.udma_mask	= NV_UDMA_MASK,
-	.port_ops	= &nv_adma_ops,
-};
-
 MODULE_AUTHOR("NVIDIA");
 MODULE_DESCRIPTION("low-level driver for NVIDIA nForce SATA controller");
 MODULE_LICENSE("GPL");
@@ -687,19 +659,53 @@ static inline void nv_disable_adma_space
 	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
 }
 
+static void nv_irq_clear(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA)
+		nv_adma_irq_clear(ap);
+	else
+		ata_bmdma_irq_clear(ap);
+}
+
 static void nv_adma_irq_clear(struct ata_port *ap)
 {
-	/* TODO */
+	/* FIXME: TODO  */
+}
+
+static u8 nv_bmdma_status(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA)
+		return nv_adma_bmdma_status(ap);
+	else
+		return ata_bmdma_status(ap);
 }
 
 static u8 nv_adma_bmdma_status(struct ata_port *ap)
 {
+	// FIXME: This is no different than ata_bmdma_status for PIO
 	return inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 }
 
+static void nv_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_host_set *host_set = qc->ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA)
+		nv_adma_bmdma_stop(qc);
+	else
+		ata_bmdma_stop(qc);
+}
+
 static void nv_adma_bmdma_stop(struct ata_queued_cmd *qc)
 {
-	/* TODO */
+	/* FIXME: TODO */
 }
 
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
@@ -715,16 +721,18 @@ static irqreturn_t nv_interrupt (int irq
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
-		struct nv_adma_port_priv *pp = ap->private_data;
 
 		if (ap &&
 		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
-			void __iomem *mmio = nv_adma_ctl_block(ap);
 			struct ata_queued_cmd *qc;
 
-			// read notifiers
-			pp->notifier = readl(mmio + NV_ADMA_NOTIFIER);
-			pp->notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
+			if (host->host_desc->host_type == ADMA) {
+				struct nv_adma_port_priv *pp = ap->private_data;
+				void __iomem *mmio = nv_adma_ctl_block(ap);
+				// read notifiers
+				pp->notifier = readl(mmio + NV_ADMA_NOTIFIER);
+				pp->notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
+			}
 				
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
@@ -732,16 +740,21 @@ static irqreturn_t nv_interrupt (int irq
 					handled += nv_adma_host_intr(ap, qc);
 				else
 					handled += ata_host_intr(ap, qc);
+			} else {
+				// No request pending?  Clear interrupt status
+				// anyway, in case there's one pending.
+				ap->ops->check_status(ap);
 			}
 		}
 
 	}
 
 	if (host->host_desc->check_hotplug)
-		host->host_desc->check_hotplug(host_set);
+		// FIXME: do something with the return value
+		(void) host->host_desc->check_hotplug(host_set);
 
 	// clear notifier
-	if (handled) {
+	if (handled && host->host_desc->host_type == ADMA) {
 		for (i = 0; i < host_set->n_ports; i++) {
 			struct ata_port *ap = host_set->ports[i];
 			struct nv_adma_port_priv *pp = ap->private_data;
@@ -811,6 +824,28 @@ static void nv_host_stop (struct ata_hos
 		pci_iounmap(pdev, host_set->mmio_base);
 }
 
+static int nv_port_start(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA)
+		return nv_adma_port_start(ap);
+	else
+		return ata_port_start(ap);
+}
+
+static void nv_port_stop(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA)
+		nv_adma_port_stop(ap);
+	else
+		ata_port_stop(ap);
+}
+
 static int nv_adma_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -975,6 +1010,17 @@ static int nv_adma_host_init(struct ata_
 	return 0;
 }
 
+static struct nv_host_desc *nv_find_host_desc(unsigned int host_type)
+{
+	int i;
+
+	for (i = 0 ; i < (sizeof nv_device_tbl)/(sizeof nv_device_tbl[0]); i++)
+		if (nv_device_tbl[i].host_type == host_type)
+			return &nv_device_tbl[i];
+	return NULL;
+}
+
+
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
@@ -1017,18 +1063,23 @@ static int nv_init_one (struct pci_dev *
 
 	rc = -ENOMEM;
 
-	host_desc = &nv_device_tbl[ent->driver_data];
+	ppi = &nv_port_info;
+
+	if (adma_enabled && (ent->driver_data & ADMA))
+		host_desc = nv_find_host_desc(ADMA);
+	else
+		host_desc = nv_find_host_desc(ent->driver_data & ~ADMA);
 
-	/* select ADMA or legacy PCI IDE BMDMA controller operation */
 	if (host_desc->host_type == ADMA) {
+		// ADMA overrides
+		ppi->host_flags                |= ATA_FLAG_MMIO | ATA_FLAG_SATA_RESET;
 #ifdef NV_ADMA_NCQ
 		ppi->host_flags		       |= ATA_FLAG_NCQ;
-		ppi->sht->can_queue		= NV_ADMA_CAN_QUEUE;
 #endif
-
-		ppi = &nv_adma_port_info;
-	} else
-		ppi = &nv_port_info;
+		ppi->sht->can_queue		= NV_ADMA_CAN_QUEUE;
+		ppi->sht->sg_tablesize		= NV_ADMA_SGTBL_LEN;
+//		ppi->port_ops->irq_handler	= nv_adma_interrupt;
+	}
 	
 	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
@@ -1072,7 +1123,7 @@ static int nv_init_one (struct pci_dev *
 
 	pci_set_master(pdev);
 
-	if (ent->driver_data == ADMA) {
+	if (host_desc->host_type == ADMA) {
 		rc = nv_adma_host_init(probe_ent);
 		if (rc)
 			goto err_out_iounmap;
@@ -1106,6 +1157,17 @@ err_out:
 	return rc;
 }
 
+static void nv_eng_timeout(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA)
+		nv_adma_eng_timeout(ap);
+	else
+		ata_eng_timeout(ap);
+}
+
 static void nv_adma_eng_timeout(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -1149,6 +1211,17 @@ out:
 	DPRINTK("EXIT\n");
 }
 
+static void nv_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct ata_host_set *host_set = qc->ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA)
+		nv_adma_qc_prep(qc);
+	else
+		ata_qc_prep(qc);
+}
+
 static void nv_adma_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct nv_adma_port_priv *pp = qc->ap->private_data;
@@ -1259,6 +1332,17 @@ static void nv_adma_mode(struct ata_port
 	pp->flags &= ~NV_ADMA_PORT_REGISTER_MODE;
 }
 
+static int nv_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct ata_host_set *host_set = qc->ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA)
+		return nv_adma_qc_issue(qc);
+	else
+		return ata_qc_issue_prot(qc);
+}
+
 static int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 {
 #if 0
@@ -1281,9 +1365,8 @@ static int nv_adma_qc_issue(struct ata_q
 	nv_adma_dump_cpb(&pp->cpb[qc->tag]);
 	if (qc->n_elem > 5) {
 		int i;
-		for (i = 0; i < qc->n_elem - 5; i++) {
+		for (i = 0; i < qc->n_elem - 5; i++)
 			nv_adma_dump_aprd(&pp->aprd[i]);
-		}
 	}
 #endif
 
@@ -1323,7 +1406,7 @@ static void nv_disable_hotplug(struct at
 	outb(intr_mask, host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
 }
 
-static void nv_check_hotplug(struct ata_host_set *host_set)
+static int nv_check_hotplug(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
@@ -1348,7 +1431,9 @@ static void nv_check_hotplug(struct ata_
 		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
 			printk(KERN_WARNING "nv_sata: "
 				"Secondary device removed\n");
+		return 1;
 	}
+	return 0;
 }
 
 static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent)
@@ -1380,7 +1465,7 @@ static void nv_disable_hotplug_ck804(str
 	nv_disable_adma_space(pdev);
 }
 
-static void nv_check_hotplug_ck804(struct ata_host_set *host_set)
+static int nv_check_hotplug_ck804(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
@@ -1405,7 +1490,9 @@ static void nv_check_hotplug_ck804(struc
 		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
 			printk(KERN_WARNING "nv_sata: "
 				"Secondary device removed\n");
+		return 1;
 	}
+	return 0;
 }
 
 static void nv_enable_hotplug_adma(struct ata_probe_ent *probe_ent)
@@ -1439,10 +1526,11 @@ static void nv_disable_hotplug_adma(stru
 	}
 }
 
-static void nv_check_hotplug_adma(struct ata_host_set *host_set)
+static int nv_check_hotplug_adma(struct ata_host_set *host_set)
 {
 	unsigned int i;
 	u16 adma_status;
+	int hotplugged = 0;
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		void __iomem *mmio = __nv_adma_ctl_block(host_set->mmio_base, i);
@@ -1451,13 +1539,16 @@ static void nv_check_hotplug_adma(struct
 			printk(KERN_WARNING "nv_sata: "
 			       "port %d device added\n", i);
 			writew(NV_ADMA_STAT_HOTPLUG, mmio + NV_ADMA_STAT);
+			hotplugged = 1;
 		}
 		if (adma_status & NV_ADMA_STAT_HOTUNPLUG) {
 			printk(KERN_WARNING "nv_sata: "
 			       "port %d device removed\n", i);
 			writew(NV_ADMA_STAT_HOTUNPLUG, mmio + NV_ADMA_STAT);
+			hotplugged = 1;
 		}
 	}
+	return hotplugged;
 }
 
 static int __init nv_init(void)
@@ -1472,6 +1563,9 @@ static void __exit nv_exit(void)
 
 module_init(nv_init);
 module_exit(nv_exit);
+module_param_named(adma, adma_enabled, bool, 0);
+MODULE_PARM_DESC(adma, "Enable use of ADMA (Default: false)");
+
 
 #ifdef DEBUG
 static void nv_adma_dump_aprd(struct nv_adma_prd *aprd)
@@ -1525,13 +1619,11 @@ static void nv_adma_dump_cpb(struct nv_a
 	printk("tag:          0x%02x\n", cpb->tag);
 	printk("next_cpb_idx: 0x%02x\n", cpb->next_cpb_idx);
 	printk("tf:\n");
-	for (i=0; i<12; i++) {
+	for (i=0; i<12; i++)
 		nv_adma_dump_cpb_tf(cpb->tf[i]);
-	}
 	printk("aprd:\n");
-	for (i=0; i<5; i++) {
+	for (i=0; i<5; i++)
 		nv_adma_dump_aprd(&cpb->aprd[i]);
-	}
 	printk("next_aprd:    0x%016llx\n", cpb->next_aprd);
 }
 

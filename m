Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWCQXXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWCQXXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWCQXXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:23:47 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:13464 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751196AbWCQXXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:23:45 -0500
Date: Fri, 17 Mar 2006 18:23:39 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
Message-ID: <20060317232339.GA5674@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Here is an incomplete attempt to get the sata_nv ADMA code working.

I made another pass through my merge of the sata_nv driver to fix and
clean up a few things.  I've only made the minimal changes necessary
to get it into a testable state; methinks it could do with a lot of
refactoring and cleanup, instead of all the
"if (host->...host_type == ADMA)" tests.

There are several FIXMEs from the original code.

I added an "adma" boolean flag to simplify testing the different code paths.

It boots OK with ADMA enabled on the disk attached to port 0, but under
heavy I/O it will stall for tens of seconds.  Moderate I/O to ports 2 and 3
generates some timeouts:

ata3: command 0x25 timeout, stat 0x50
ata4: command 0x25 timeout, stat 0x50
ata3: command 0x25 timeout, stat 0x50
ata3: command 0x35 timeout, stat 0x50
ata3: command 0x25 timeout, stat 0x50
ata3: command 0x35 timeout, stat 0x50
ata3: command 0x35 timeout, stat 0x50
ata3: command 0x35 timeout, stat 0x50
ata3: command 0x35 timeout, stat 0x50
ata3: command 0x25 timeout, stat 0x50

I haven't yet bothered to enable debugging in the driver.

I'm currently running the merged driver with ADMA turned off; it should
have no functional changes.

Regards,

	Bill Rugolsky

 sata_nv.c | 1119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 1075 insertions(+), 44 deletions(-)

--


--- linux-2.6.16-rc6-git4/drivers/scsi/sata_nv.c~	2006-03-15 17:19:18.000000000 -0500
+++ linux-2.6.16-rc6-git4/drivers/scsi/sata_nv.c	2006-03-17 18:13:17.000000000 -0500
@@ -29,6 +29,10 @@
  *  NV-specific details such as register offsets, SATA phy location,
  *  hotplug info, etc.
  *
+ *  0.11-alpha
+ *     - Added support for ADMA.  Disabled by default.  Use the module
+ *       option adma=1 to enable it for supported chipsets.
+ *
  *  0.10
  *     - Fixed spurious interrupts issue seen with the Maxtor 6H500F0 500GB
  *       drive.  Also made the check_hotplug() callbacks return whether there
@@ -68,11 +72,14 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
+//#define DEBUG
+
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.8"
+#define DRV_VERSION			"0.11-alpha"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -121,6 +128,140 @@
 // For PCI config register 20
 #define NV_MCP_SATA_CFG_20		0x50
 #define NV_MCP_SATA_CFG_20_SATA_SPACE_EN	0x04
+#define NV_MCP_SATA_CFG_20_PORT0_EN	(1 << 17)
+#define NV_MCP_SATA_CFG_20_PORT1_EN	(1 << 16)
+#define NV_MCP_SATA_CFG_20_PORT0_PWB_EN	(1 << 14)
+#define NV_MCP_SATA_CFG_20_PORT1_PWB_EN	(1 << 12)
+
+//#define NV_ADMA_NCQ
+
+#ifdef NV_ADMA_NCQ
+#define NV_ADMA_CAN_QUEUE		ATA_MAX_QUEUE
+#else
+#define NV_ADMA_CAN_QUEUE		ATA_DEF_QUEUE
+#endif
+
+#define NV_ADMA_CPB_SZ			128
+#define NV_ADMA_APRD_SZ			16
+#define NV_ADMA_SGTBL_LEN		(1024 - NV_ADMA_CPB_SZ) / NV_ADMA_APRD_SZ
+#define NV_ADMA_SGTBL_SZ                NV_ADMA_SGTBL_LEN * NV_ADMA_APRD_SZ
+#define NV_ADMA_PORT_PRIV_DMA_SZ        NV_ADMA_CAN_QUEUE * (NV_ADMA_CPB_SZ + NV_ADMA_SGTBL_SZ)
+//#define NV_ADMA_MAX_CPBS		32
+
+// BAR5 offset to ADMA general registers
+#define NV_ADMA_GEN			0x400
+#define NV_ADMA_GEN_CTL			0x00
+#define NV_ADMA_NOTIFIER_CLEAR		0x30
+
+#define NV_ADMA_CHECK_INTR(GCTL, PORT) ((GCTL) & ( 1 << (19 + (12 * (PORT)))))
+
+// BAR5 offset to ADMA ports
+#define NV_ADMA_PORT			0x480
+
+// size of ADMA port register space 
+#define NV_ADMA_PORT_SIZE		0x100
+
+// ADMA port registers
+#define NV_ADMA_CTL			0x40
+#define NV_ADMA_CPB_COUNT		0x42
+#define NV_ADMA_NEXT_CPB_IDX		0x43
+#define NV_ADMA_STAT			0x44
+#define NV_ADMA_CPB_BASE_LOW		0x48
+#define NV_ADMA_CPB_BASE_HIGH		0x4C
+#define NV_ADMA_APPEND			0x50
+#define NV_ADMA_NOTIFIER		0x68
+#define NV_ADMA_NOTIFIER_ERROR		0x6C
+
+// NV_ADMA_CTL register bits
+#define NV_ADMA_CTL_HOTPLUG_IEN		(1 << 0)
+#define NV_ADMA_CTL_CHANNEL_RESET	(1 << 5)
+#define NV_ADMA_CTL_GO			(1 << 7)
+#define NV_ADMA_CTL_AIEN		(1 << 8)
+#define NV_ADMA_CTL_READ_NON_COHERENT	(2 << 11)
+#define NV_ADMA_CTL_WRITE_NON_COHERENT	(1 << 12)
+
+// CPB response flag bits
+#define NV_CPB_RESP_DONE		(1 << 0)
+#define NV_CPB_RESP_ATA_ERR		(1 << 3)
+#define NV_CPB_RESP_CMD_ERR		(1 << 4)
+#define NV_CPB_RESP_CPB_ERR		(1 << 7)
+
+// CPB control flag bits
+#define NV_CPB_CTL_CPB_VALID		(1 << 0)
+#define NV_CPB_CTL_QUEUE		(1 << 1)
+#define NV_CPB_CTL_APRD_VALID		(1 << 2)
+#define NV_CPB_CTL_IEN			(1 << 3)
+#define NV_CPB_CTL_FPDMA		(1 << 4)
+
+// APRD flags
+#define NV_APRD_WRITE			(1 << 1)
+#define NV_APRD_END			(1 << 2)
+#define NV_APRD_CONT			(1 << 3)
+
+// NV_ADMA_STAT flags
+#define NV_ADMA_STAT_TIMEOUT		(1 << 0)
+#define NV_ADMA_STAT_HOTUNPLUG		(1 << 1)
+#define NV_ADMA_STAT_HOTPLUG		(1 << 2)
+#define NV_ADMA_STAT_CPBERR		(1 << 4)
+#define NV_ADMA_STAT_SERROR		(1 << 5)
+#define NV_ADMA_STAT_CMD_COMPLETE	(1 << 6)
+#define NV_ADMA_STAT_IDLE		(1 << 8)
+#define NV_ADMA_STAT_LEGACY		(1 << 9)
+#define NV_ADMA_STAT_STOPPED		(1 << 10)
+#define NV_ADMA_STAT_DONE		(1 << 12)
+#define NV_ADMA_STAT_ERR		(NV_ADMA_STAT_CPBERR | NV_ADMA_STAT_TIMEOUT)
+
+// port flags
+#define NV_ADMA_PORT_REGISTER_MODE	(1 << 0)
+
+#ifndef min
+#define min(x,y) ((x) < (y) ? x : y)
+#endif
+
+struct nv_adma_prd {
+	u64			addr;
+	u32			len;
+	u8			flags;
+	u8			packet_len;
+	u16			reserved;
+};
+
+enum nv_adma_regbits {
+	CMDEND	= (1 << 15),		/* end of command list */
+	WNB	= (1 << 14),		/* wait-not-BSY */
+	IGN	= (1 << 13),		/* ignore this entry */
+	CS1n	= (1 << (4 + 8)),	/* std. PATA signals follow... */
+	DA2	= (1 << (2 + 8)),
+	DA1	= (1 << (1 + 8)),
+	DA0	= (1 << (0 + 8)),
+};
+
+struct nv_adma_cpb {
+	u8			resp_flags;    //0
+	u8			reserved1;     //1
+	u8			ctl_flags;     //2
+	// len is length of taskfile in 64 bit words
+ 	u8			len;           //3 
+	u8			tag;           //4
+	u8			next_cpb_idx;  //5
+	u16			reserved2;     //6-7
+	u16			tf[12];        //8-31
+	struct nv_adma_prd	aprd[5];       //32-111
+	u64                     next_aprd;     //112-119
+	u64                     reserved3;     //120-127
+};
+
+
+struct nv_adma_port_priv {
+	struct nv_adma_cpb	*cpb;
+  //	u8			cpb_idx;
+	u8			flags;
+	u32			notifier;
+	u32			notifier_error;
+	dma_addr_t		cpb_dma;
+	struct nv_adma_prd	*aprd;
+	dma_addr_t		aprd_dma;
+};
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
@@ -128,36 +269,70 @@ static irqreturn_t nv_interrupt (int irq
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void nv_host_stop (struct ata_host_set *host_set);
+static int nv_port_start(struct ata_port *ap);
+static void nv_port_stop(struct ata_port *ap);
+static int nv_adma_port_start(struct ata_port *ap);
+static void nv_adma_port_stop(struct ata_port *ap);
+static void nv_irq_clear(struct ata_port *ap);
+static void nv_adma_irq_clear(struct ata_port *ap);
 static void nv_enable_hotplug(struct ata_probe_ent *probe_ent);
 static void nv_disable_hotplug(struct ata_host_set *host_set);
 static int nv_check_hotplug(struct ata_host_set *host_set);
 static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent);
 static void nv_disable_hotplug_ck804(struct ata_host_set *host_set);
 static int nv_check_hotplug_ck804(struct ata_host_set *host_set);
+static void nv_enable_hotplug_adma(struct ata_probe_ent *probe_ent);
+static void nv_disable_hotplug_adma(struct ata_host_set *host_set);
+static int nv_check_hotplug_adma(struct ata_host_set *host_set);
+static void nv_qc_prep(struct ata_queued_cmd *qc);
+static int nv_qc_issue(struct ata_queued_cmd *qc);
+static int nv_adma_qc_issue(struct ata_queued_cmd *qc);
+static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
+static unsigned int nv_adma_tf_to_cpb(struct ata_taskfile *tf, u16 *cpb);
+static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb);
+static void nv_adma_fill_aprd(struct ata_queued_cmd *qc, struct scatterlist *sg, int idx, struct nv_adma_prd *aprd);
+static void nv_adma_register_mode(struct ata_port *ap);
+static void nv_adma_mode(struct ata_port *ap);
+static u8 nv_bmdma_status(struct ata_port *ap);
+static u8 nv_adma_bmdma_status(struct ata_port *ap);
+static void nv_bmdma_stop(struct ata_queued_cmd *qc);
+static void nv_adma_bmdma_stop(struct ata_queued_cmd *qc);
+static void nv_eng_timeout(struct ata_port *ap);
+static void nv_adma_eng_timeout(struct ata_port *ap);
+#ifdef DEBUG
+static void nv_adma_dump_cpb(struct nv_adma_cpb *cpb);
+static void nv_adma_dump_aprd(struct nv_adma_prd *aprd);
+static void nv_adma_dump_cpb_tf(u16 tf);
+static void nv_adma_dump_port(struct ata_port *ap);
+static void nv_adma_dump_iomem(void __iomem *m, int len);
+#endif
+
+
+static int adma_enabled;
 
 enum nv_host_type
 {
-	GENERIC,
-	NFORCE2,
-	NFORCE3,
-	CK804
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
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 | ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 | ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE | ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE | ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2,
@@ -193,13 +368,7 @@ static struct nv_host_desc nv_device_tbl
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
@@ -209,6 +378,11 @@ static struct nv_host_desc nv_device_tbl
 		.disable_hotplug= nv_disable_hotplug_ck804,
 		.check_hotplug	= nv_check_hotplug_ck804,
 	},
+	{	.host_type	= ADMA,
+		.enable_hotplug	= nv_enable_hotplug_adma,
+		.disable_hotplug= nv_disable_hotplug_adma,
+		.check_hotplug	= nv_check_hotplug_adma,
+	},
 };
 
 struct nv_host
@@ -253,20 +427,187 @@ static const struct ata_port_operations 
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
+	.bmdma_stop		= nv_bmdma_stop,
+	.bmdma_status		= nv_bmdma_status,
+	.qc_prep		= nv_qc_prep,
+	.qc_issue		= nv_qc_issue,
+	.eng_timeout		= nv_eng_timeout,
 	.irq_handler		= nv_interrupt,
-	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_clear		= nv_irq_clear,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
+	.port_start		= nv_port_start,
+	.port_stop		= nv_port_stop,
 	.host_stop		= nv_host_stop,
 };
 
+static unsigned int nv_adma_tf_to_cpb(struct ata_taskfile *tf, u16 *cpb)
+{
+	unsigned int idx = 0;
+
+	cpb[idx++] = cpu_to_le16((ATA_REG_DEVICE << 8) | tf->device | WNB);
+
+	if ((tf->flags & ATA_TFLAG_LBA48) == 0) {
+		cpb[idx++] = cpu_to_le16(IGN);
+		cpb[idx++] = cpu_to_le16(IGN);
+		cpb[idx++] = cpu_to_le16(IGN);
+		cpb[idx++] = cpu_to_le16(IGN);
+		cpb[idx++] = cpu_to_le16(IGN);
+	}
+	else {
+		cpb[idx++] = cpu_to_le16((ATA_REG_ERR   << 8) | tf->hob_feature);
+		cpb[idx++] = cpu_to_le16((ATA_REG_NSECT << 8) | tf->hob_nsect);
+		cpb[idx++] = cpu_to_le16((ATA_REG_LBAL  << 8) | tf->hob_lbal);
+		cpb[idx++] = cpu_to_le16((ATA_REG_LBAM  << 8) | tf->hob_lbam);
+		cpb[idx++] = cpu_to_le16((ATA_REG_LBAH  << 8) | tf->hob_lbah);
+	}
+	cpb[idx++] = cpu_to_le16((ATA_REG_ERR    << 8) | tf->feature);
+	cpb[idx++] = cpu_to_le16((ATA_REG_NSECT  << 8) | tf->nsect);
+	cpb[idx++] = cpu_to_le16((ATA_REG_LBAL   << 8) | tf->lbal);
+	cpb[idx++] = cpu_to_le16((ATA_REG_LBAM   << 8) | tf->lbam);
+	cpb[idx++] = cpu_to_le16((ATA_REG_LBAH   << 8) | tf->lbah);
+
+	cpb[idx++] = cpu_to_le16((ATA_REG_CMD    << 8) | tf->command | CMDEND);
+
+	return idx;
+}
+
+static inline void __iomem *__nv_adma_ctl_block(void __iomem *mmio,
+					     unsigned int port_no)
+{
+	mmio += NV_ADMA_PORT + port_no * NV_ADMA_PORT_SIZE;
+	return mmio;
+}
+
+static inline void __iomem *nv_adma_ctl_block(struct ata_port *ap)
+{
+	return __nv_adma_ctl_block(ap->host_set->mmio_base, ap->port_no);
+}
+
+static inline void __iomem *nv_adma_gen_block(struct ata_port *ap)
+{
+	return (ap->host_set->mmio_base + NV_ADMA_GEN);
+}
+
+static inline void __iomem *nv_adma_notifier_clear_block(struct ata_port *ap)
+{
+	return (nv_adma_gen_block(ap) + NV_ADMA_NOTIFIER_CLEAR + (4 * ap->port_no));
+}
+
+static inline void nv_adma_reset_channel(struct ata_port *ap)
+{
+	void __iomem *mmio = nv_adma_ctl_block(ap);
+	u16 tmp;
+
+	// clear CPB fetch count
+	writew(0, mmio + NV_ADMA_CPB_COUNT);
+
+	// clear GO
+	tmp = readw(mmio + NV_ADMA_CTL);
+	writew(tmp & ~NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
+
+	tmp = readw(mmio + NV_ADMA_CTL);
+	writew(tmp | NV_ADMA_CTL_CHANNEL_RESET, mmio + NV_ADMA_CTL);
+	udelay(1);
+	writew(tmp & ~NV_ADMA_CTL_CHANNEL_RESET, mmio + NV_ADMA_CTL);
+}
+
+static inline int nv_adma_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	void __iomem *mmio = nv_adma_ctl_block(ap);
+	struct nv_adma_port_priv *pp = ap->private_data;
+	struct nv_adma_cpb *cpb = &pp->cpb[qc->tag];
+	u16 status;
+	u32 gen_ctl;
+	u16 flags;
+	int have_err = 0;
+	int handled = 0;
+
+	status = readw(mmio + NV_ADMA_STAT);
+
+	// if in ATA register mode, use standard ata interrupt handler
+	if (pp->flags & NV_ADMA_PORT_REGISTER_MODE) {
+		VPRINTK("in ATA register mode\n");
+		return ata_host_intr(ap, qc);
+	}
+
+	gen_ctl = readl(nv_adma_gen_block(ap) + NV_ADMA_GEN_CTL);
+	if (!NV_ADMA_CHECK_INTR(gen_ctl, ap->port_no)) {
+		return 0;
+	}
+
+	if (!pp->notifier && !pp->notifier_error) {
+		if (status) {
+			VPRINTK("XXX no notifier, but status 0x%x\n", status);
+#ifdef DEBUG
+			nv_adma_dump_port(ap);
+			nv_adma_dump_cpb(cpb);
+#endif
+		} else {
+			return 0;
+		}
+	}
+	if (pp->notifier_error) {
+		have_err = 1;
+		handled = 1;
+	}
+
+	if (status & NV_ADMA_STAT_TIMEOUT) {
+		VPRINTK("timeout, stat = 0x%x\n", status);
+		have_err = 1;
+		handled = 1;
+	}
+	if (status & NV_ADMA_STAT_CPBERR) {
+		VPRINTK("CPB error, stat = 0x%x\n", status);
+		have_err = 1;
+		handled = 1;
+	}
+	if (status & NV_ADMA_STAT_STOPPED) {
+		VPRINTK("ADMA stopped, stat = 0x%x, resp_flags = 0x%x\n", status, cpb->resp_flags);
+		if (!(status & NV_ADMA_STAT_DONE)) {
+			have_err = 1;
+			handled = 1;
+		}
+	}
+	if (status & NV_ADMA_STAT_CMD_COMPLETE) {
+		VPRINTK("ADMA command complete, stat = 0x%x\n", status);
+	}
+	if (status & NV_ADMA_STAT_DONE) {
+		flags = cpb->resp_flags;
+		VPRINTK("CPB done, stat = 0x%x, flags = 0x%x\n", status, flags);
+		handled = 1;
+		if (!(status & NV_ADMA_STAT_IDLE)) {
+			VPRINTK("XXX CPB done, but not idle\n");
+		}
+		if (flags & NV_CPB_RESP_DONE) {
+			VPRINTK("CPB flags done, flags = 0x%x\n", flags);
+		}
+		if (flags & NV_CPB_RESP_ATA_ERR) {
+			VPRINTK("CPB flags ATA err, flags = 0x%x\n", flags);
+			have_err = 1;
+		}
+		if (flags & NV_CPB_RESP_CMD_ERR) {
+			VPRINTK("CPB flags CMD err, flags = 0x%x\n", flags);
+			have_err = 1;
+		}
+		if (flags & NV_CPB_RESP_CPB_ERR) {
+			VPRINTK("CPB flags CPB err, flags = 0x%x\n", flags);
+			have_err = 1;
+		}
+	}
+
+	// clear status
+	writew(status, mmio + NV_ADMA_STAT);
+
+	if (handled) {
+		u8 ata_status = readb(mmio + (ATA_REG_STATUS * 4));
+		qc->err_mask |= ac_err_mask(have_err ? (ata_status | ATA_ERR) : ata_status);
+		ata_qc_complete(qc);
+	}
+
+	return handled; /* irq handled */
+}
+
 /* FIXME: The hardware provides the necessary SATA PHY controls
  * to support ATA_FLAG_SATA_RESET.  However, it is currently
  * necessary to disable that flag, to solve misdetection problems.
@@ -275,6 +616,7 @@ static const struct ata_port_operations 
  * This problem really needs to be investigated further.  But in the
  * meantime, we avoid ATA_FLAG_SATA_RESET to get people working.
  */
+
 static struct ata_port_info nv_port_info = {
 	.sht		= &nv_sht,
 	.host_flags	= ATA_FLAG_SATA |
@@ -293,6 +635,80 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+static inline void nv_enable_adma_space (struct pci_dev *pdev)
+{
+	u8 regval;
+
+	VPRINTK("ENTER\n");
+
+	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
+	regval |= NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+}
+
+static inline void nv_disable_adma_space (struct pci_dev *pdev)
+{
+	u8 regval;
+
+	VPRINTK("ENTER\n");
+
+	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
+	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+}
+
+static void nv_irq_clear(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA) {
+		nv_adma_irq_clear(ap);
+	} else {
+		ata_bmdma_irq_clear(ap);
+	}
+}
+
+static void nv_adma_irq_clear(struct ata_port *ap)
+{
+	/* FIXME: TODO  */
+}
+
+static u8 nv_bmdma_status(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA) {
+		return nv_adma_bmdma_status(ap);
+	} else {
+		return ata_bmdma_status(ap);
+	}
+}
+
+static u8 nv_adma_bmdma_status(struct ata_port *ap)
+{
+	// FIXME: This is no different than ata_bmdma_status for PIO
+	return inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+}
+
+static void nv_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_host_set *host_set = qc->ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA) {
+		nv_adma_bmdma_stop(qc);
+	} else {
+		ata_bmdma_stop(qc);
+	}
+}
+
+static void nv_adma_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	/* FIXME: TODO */
+}
+
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
 				 struct pt_regs *regs)
 {
@@ -305,26 +721,48 @@ static irqreturn_t nv_interrupt (int irq
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap;
+		struct ata_port *ap = host_set->ports[i];
 
-		ap = host_set->ports[i];
 		if (ap &&
 		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
+			if (host->host_desc->host_type == ADMA) {
+				struct nv_adma_port_priv *pp = ap->private_data;
+				void __iomem *mmio = nv_adma_ctl_block(ap);
+				// read notifiers
+				pp->notifier = readl(mmio + NV_ADMA_NOTIFIER);
+				pp->notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
+			}
+				
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
-				handled += ata_host_intr(ap, qc);
-			else
+			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+				if (host->host_desc->host_type == ADMA)
+					handled += nv_adma_host_intr(ap, qc);
+				else
+					handled += ata_host_intr(ap, qc);
+			} else {
 				// No request pending?  Clear interrupt status
 				// anyway, in case there's one pending.
 				ap->ops->check_status(ap);
+			}
+
 		}
 
 	}
 
 	if (host->host_desc->check_hotplug)
-		handled += host->host_desc->check_hotplug(host_set);
+		(void) host->host_desc->check_hotplug(host_set);
+
+	// clear notifier
+	if (handled && host->host_desc->host_type == ADMA) {
+		for (i = 0; i < host_set->n_ports; i++) {
+			struct ata_port *ap = host_set->ports[i];
+			struct nv_adma_port_priv *pp = ap->private_data;
+			writel(pp->notifier | pp->notifier_error,
+			       nv_adma_notifier_clear_block(ap));
+		}
+	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
@@ -335,14 +773,22 @@ static u32 nv_scr_read (struct ata_port 
 {
 	struct ata_host_set *host_set = ap->host_set;
 	struct nv_host *host = host_set->private_data;
+	u32 val = 0;
+
+	VPRINTK("ENTER\n");
+
+	VPRINTK("reading SCR reg %d, got 0x%08x\n", sc_reg, val);
 
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
 	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		return readl((void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
+		val = readl((void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
 	else
-		return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+		val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+
+	VPRINTK("reading SCR reg %d, got 0x%08x\n", sc_reg, val);
+	return val;
 }
 
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
@@ -350,6 +796,9 @@ static void nv_scr_write (struct ata_por
 	struct ata_host_set *host_set = ap->host_set;
 	struct nv_host *host = host_set->private_data;
 
+	VPRINTK("ENTER\n");
+
+	VPRINTK("writing SCR reg %d with 0x%08x\n", sc_reg, val);
 	if (sc_reg > SCR_CONTROL)
 		return;
 
@@ -364,6 +813,8 @@ static void nv_host_stop (struct ata_hos
 	struct nv_host *host = host_set->private_data;
 	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 
+	VPRINTK("ENTER\n");
+
 	// Disable hotplug event interrupts.
 	if (host->host_desc->disable_hotplug)
 		host->host_desc->disable_hotplug(host_set);
@@ -374,16 +825,218 @@ static void nv_host_stop (struct ata_hos
 		pci_iounmap(pdev, host_set->mmio_base);
 }
 
+static int nv_port_start(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA) {
+		return nv_adma_port_start(ap);
+	} else {
+		return ata_port_start(ap);
+	}
+}
+
+static void nv_port_stop(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA) {
+		nv_adma_port_stop(ap);
+	} else {
+		ata_port_stop(ap);
+	}
+}
+
+static int nv_adma_port_start(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct nv_adma_port_priv *pp;
+	int rc;
+	void *mem;
+	dma_addr_t mem_dma;
+	void __iomem *mmio = nv_adma_ctl_block(ap);
+
+	VPRINTK("ENTER\n");
+
+	nv_adma_reset_channel(ap);
+
+#ifdef DEBUG
+	VPRINTK("after reset:\n");
+	nv_adma_dump_port(ap);
+#endif
+
+	rc = ata_port_start(ap);
+	if (rc)
+		return rc;
+
+	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+	memset(pp, 0, sizeof(*pp));
+
+	mem = dma_alloc_coherent(dev, NV_ADMA_PORT_PRIV_DMA_SZ,
+				 &mem_dma, GFP_KERNEL);
+	
+	VPRINTK("dma memory: vaddr = 0x%08x, paddr = 0x%08x\n", (u32)mem, (u32)mem_dma);
+	
+	if (!mem) {
+		rc = -ENOMEM;
+		goto err_out_kfree;
+	}
+	memset(mem, 0, NV_ADMA_PORT_PRIV_DMA_SZ);
+
+	/*
+	 * First item in chunk of DMA memory:
+	 * 128-byte command parameter block (CPB)
+	 * one for each command tag
+	 */
+	pp->cpb     = mem;
+	pp->cpb_dma = mem_dma;
+
+	VPRINTK("cpb = 0x%08x, cpb_dma = 0x%08x\n", (u32)pp->cpb, (u32)pp->cpb_dma);
+
+	writel(mem_dma, mmio + NV_ADMA_CPB_BASE_LOW);
+	writel(0,       mmio + NV_ADMA_CPB_BASE_HIGH);
+
+	mem     += NV_ADMA_CAN_QUEUE * NV_ADMA_CPB_SZ;
+	mem_dma += NV_ADMA_CAN_QUEUE * NV_ADMA_CPB_SZ;
+
+	/*
+	 * Second item: block of ADMA_SGTBL_LEN s/g entries
+	 */
+	pp->aprd = mem;
+	pp->aprd_dma = mem_dma;
+
+	VPRINTK("aprd = 0x%08x, aprd_dma = 0x%08x\n", (u32)pp->aprd, (u32)pp->aprd_dma);
+
+	ap->private_data = pp;
+
+	// clear any outstanding interrupt conditions
+	writew(0xffff, mmio + NV_ADMA_STAT);
+
+	// initialize port variables
+	//	pp->cpb_idx = 0;
+	pp->flags = NV_ADMA_PORT_REGISTER_MODE;
+
+	// make sure controller is in ATA register mode
+	nv_adma_register_mode(ap);
+
+	return 0;
+
+err_out_kfree:
+	kfree(pp);
+err_out:
+	ata_port_stop(ap);
+	return rc;
+}
+
+static void nv_adma_port_stop(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct nv_adma_port_priv *pp = ap->private_data;
+	void __iomem *mmio = nv_adma_ctl_block(ap);
+
+	VPRINTK("ENTER\n");
+
+	writew(0, mmio + NV_ADMA_CTL);
+
+	ap->private_data = NULL;
+	dma_free_coherent(dev, NV_ADMA_PORT_PRIV_DMA_SZ, pp->cpb, pp->cpb_dma);
+	kfree(pp);
+	ata_port_stop(ap);
+}
+
+
+static void nv_adma_setup_port(struct ata_probe_ent *probe_ent, unsigned int port)
+{
+	void __iomem *mmio = probe_ent->mmio_base;
+	struct ata_ioports *ioport = &probe_ent->port[port];
+
+	VPRINTK("ENTER\n");
+
+	mmio += NV_ADMA_PORT + port * NV_ADMA_PORT_SIZE;
+
+	ioport->cmd_addr	= (unsigned long) mmio;
+	ioport->data_addr	= (unsigned long) mmio + (ATA_REG_DATA * 4);
+	ioport->error_addr	=
+	ioport->feature_addr	= (unsigned long) mmio + (ATA_REG_ERR * 4);
+	ioport->nsect_addr	= (unsigned long) mmio + (ATA_REG_NSECT * 4);
+	ioport->lbal_addr	= (unsigned long) mmio + (ATA_REG_LBAL * 4);
+	ioport->lbam_addr	= (unsigned long) mmio + (ATA_REG_LBAM * 4);
+	ioport->lbah_addr	= (unsigned long) mmio + (ATA_REG_LBAH * 4);
+	ioport->device_addr	= (unsigned long) mmio + (ATA_REG_DEVICE * 4);
+	ioport->status_addr	=
+	ioport->command_addr	= (unsigned long) mmio + (ATA_REG_STATUS * 4);
+	ioport->altstatus_addr	=
+	ioport->ctl_addr	= (unsigned long) mmio + 0x20;
+}
+
+static int nv_adma_host_init(struct ata_probe_ent *probe_ent)
+{
+	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
+	unsigned int i;
+	u32 tmp32;
+
+	VPRINTK("ENTER\n");
+
+	probe_ent->n_ports = NV_PORTS;
+
+	nv_enable_adma_space(pdev);
+	
+	// enable ADMA on the ports
+	pci_read_config_dword(pdev, NV_MCP_SATA_CFG_20, &tmp32);
+	tmp32 |= NV_MCP_SATA_CFG_20_PORT0_EN |
+		 NV_MCP_SATA_CFG_20_PORT0_PWB_EN |
+		 NV_MCP_SATA_CFG_20_PORT1_EN |
+		 NV_MCP_SATA_CFG_20_PORT1_PWB_EN;
+
+	pci_write_config_dword(pdev, NV_MCP_SATA_CFG_20, tmp32);
+	
+	for (i = 0; i < probe_ent->n_ports; i++)
+		nv_adma_setup_port(probe_ent, i);
+
+	for (i = 0; i < probe_ent->n_ports; i++) {
+		void __iomem *mmio = __nv_adma_ctl_block(probe_ent->mmio_base, i);
+		u16 tmp;
+
+		/* enable interrupt, clear reset if not already clear */
+		tmp = readw(mmio + NV_ADMA_CTL);
+		writew(tmp | NV_ADMA_CTL_AIEN, mmio + NV_ADMA_CTL);
+	}
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+
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
 	struct nv_host *host;
 	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
+	struct nv_host_desc *host_desc;
 	int pci_dev_busy = 0;
 	int rc;
 	u32 bar;
 
+	VPRINTK("ENTER\n");
+
         // Make sure this is a SATA controller by counting the number of bars
         // (NVIDIA SATA controllers will always have six bars).  Otherwise,
         // it's an IDE controller and we ignore it.
@@ -414,6 +1067,23 @@ static int nv_init_one (struct pci_dev *
 	rc = -ENOMEM;
 
 	ppi = &nv_port_info;
+
+	if (adma_enabled && (ent->driver_data & ADMA))
+		host_desc = nv_find_host_desc(ADMA);
+	else
+		host_desc = nv_find_host_desc(ent->driver_data & ~ADMA);
+
+	if (host_desc->host_type == ADMA) {
+		// ADMA overrides
+		ppi->host_flags                |= ATA_FLAG_MMIO | ATA_FLAG_SATA_RESET;
+#ifdef NV_ADMA_NCQ
+		ppi->host_flags		       |= ATA_FLAG_NCQ;
+#endif
+		ppi->sht->can_queue		= NV_ADMA_CAN_QUEUE;
+		ppi->sht->sg_tablesize		= NV_ADMA_SGTBL_LEN;
+//		ppi->port_ops->irq_handler	= nv_adma_interrupt;
+	}
+	
 	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
 		goto err_out_regions;
@@ -423,7 +1093,7 @@ static int nv_init_one (struct pci_dev *
 		goto err_out_free_ent;
 
 	memset(host, 0, sizeof(struct nv_host));
-	host->host_desc = &nv_device_tbl[ent->driver_data];
+	host->host_desc = host_desc;
 
 	probe_ent->private_data = host;
 
@@ -440,6 +1110,7 @@ static int nv_init_one (struct pci_dev *
 		}
 
 		base = (unsigned long)probe_ent->mmio_base;
+		VPRINTK("BAR5 base is at 0x%x\n", (u32)base);
 
 		probe_ent->port[0].scr_addr =
 			base + NV_PORT0_SCR_REG_OFFSET;
@@ -455,6 +1126,12 @@ static int nv_init_one (struct pci_dev *
 
 	pci_set_master(pdev);
 
+	if (host_desc->host_type == ADMA) {
+		rc = nv_adma_host_init(probe_ent);
+		if (rc)
+			goto err_out_iounmap;
+	}
+
 	rc = ata_device_add(probe_ent);
 	if (rc != NV_PORTS)
 		goto err_out_iounmap;
@@ -483,6 +1160,239 @@ err_out:
 	return rc;
 }
 
+static void nv_eng_timeout(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA) {
+		nv_adma_eng_timeout(ap);
+	} else {
+		return ata_eng_timeout(ap);
+	}
+}
+
+static void nv_adma_eng_timeout(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	struct nv_adma_port_priv *pp = ap->private_data;
+	u8 drv_stat;
+
+	VPRINTK("ENTER\n");
+	
+	if (pp->flags & NV_ADMA_PORT_REGISTER_MODE) {
+		ata_eng_timeout(ap);
+		goto out;
+	}
+
+
+	if (!qc) {
+		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
+		       ap->id);
+		goto out;
+	}
+	
+
+//	spin_lock_irqsave(&host_set->lock, flags);
+
+	qc->scsidone = scsi_finish_command;
+
+	drv_stat = ata_chk_status(ap);
+
+	printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x\n",
+	       ap->id, qc->tf.command, drv_stat);
+
+	// reset channel
+	nv_adma_reset_channel(ap);
+
+	/* complete taskfile transaction */
+	qc->err_mask |= ac_err_mask(drv_stat);
+	ata_qc_complete(qc);
+
+//	spin_unlock_irqrestore(&host_set->lock, flags);
+
+out:
+	DPRINTK("EXIT\n");
+}
+
+static void nv_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct ata_host_set *host_set = qc->ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA) {
+		nv_adma_qc_prep(qc);
+	} else {
+		ata_qc_prep(qc);
+	}
+}
+
+static void nv_adma_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct nv_adma_port_priv *pp = qc->ap->private_data;
+	struct nv_adma_cpb *cpb = &pp->cpb[qc->tag];
+
+	VPRINTK("ENTER\n");
+
+	VPRINTK("qc->flags = 0x%x\n", (u32)qc->flags);
+
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP)) {
+		ata_qc_prep(qc);
+		return;
+	}
+
+	memset(cpb, 0, sizeof(struct nv_adma_cpb));
+	       
+	cpb->ctl_flags		= NV_CPB_CTL_CPB_VALID |
+				  NV_CPB_CTL_APRD_VALID |
+				  NV_CPB_CTL_IEN;
+	cpb->len		= 3;
+	cpb->tag		= qc->tag;
+	cpb->next_cpb_idx	= 0;
+
+#ifdef NV_ADMA_NCQ
+	// turn on NCQ flags for NCQ commands
+	if (qc->flags & ATA_QCFLAG_NCQ)
+		cpb->ctl_flags |= NV_CPB_CTL_QUEUE | NV_CPB_CTL_FPDMA;
+#endif
+
+	nv_adma_tf_to_cpb(&qc->tf, cpb->tf);
+
+	nv_adma_fill_sg(qc, cpb);
+}
+
+static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb)
+{
+	struct nv_adma_port_priv *pp = qc->ap->private_data;
+	unsigned int idx;
+	struct nv_adma_prd *aprd;
+	struct scatterlist *sg;
+
+	VPRINTK("ENTER\n");
+
+	idx = 0;
+
+	ata_for_each_sg(sg, qc) {
+		aprd = (idx < 5) ? &cpb->aprd[idx] : &pp->aprd[idx-5];
+		nv_adma_fill_aprd(qc, sg, idx, aprd);
+		idx++;
+	}
+	if (idx > 5) {
+		cpb->next_aprd = (u64)(pp->aprd_dma + NV_ADMA_APRD_SZ * qc->tag);
+	}
+}
+
+static void nv_adma_fill_aprd(struct ata_queued_cmd *qc,
+			      struct scatterlist *sg,
+			      int idx,
+			      struct nv_adma_prd *aprd)
+{
+	u32 sg_len, addr, flags;
+
+	memset(aprd, 0, sizeof(struct nv_adma_prd));
+
+	addr   = sg_dma_address(sg);
+	sg_len = sg_dma_len(sg);
+
+	flags = 0;
+	if (qc->tf.flags & ATA_TFLAG_WRITE)
+		flags |= NV_APRD_WRITE;
+	if (idx == qc->n_elem - 1) {
+		flags |= NV_APRD_END;
+	} else if (idx != 4) {
+		flags |= NV_APRD_CONT;
+	}
+
+	aprd->addr  = cpu_to_le32(addr);
+	aprd->len   = cpu_to_le32(sg_len); /* len in bytes */
+	aprd->flags = cpu_to_le32(flags);
+}
+
+static void nv_adma_register_mode(struct ata_port *ap)
+{
+	void __iomem *mmio = nv_adma_ctl_block(ap);
+	struct nv_adma_port_priv *pp = ap->private_data;
+	u16 tmp;
+
+	tmp = readw(mmio + NV_ADMA_CTL);
+	writew(tmp & ~NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
+
+	pp->flags |= NV_ADMA_PORT_REGISTER_MODE;
+}
+
+static void nv_adma_mode(struct ata_port *ap)
+{
+	void __iomem *mmio = nv_adma_ctl_block(ap);
+	struct nv_adma_port_priv *pp = ap->private_data;
+	u16 tmp;
+
+	if(!(pp->flags & NV_ADMA_PORT_REGISTER_MODE)) {
+		return;
+	}
+
+#if 0
+	nv_adma_reset_channel(ap);
+#endif
+
+	tmp = readw(mmio + NV_ADMA_CTL);
+	writew(tmp | NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);
+
+	pp->flags &= ~NV_ADMA_PORT_REGISTER_MODE;
+}
+
+static int nv_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct ata_host_set *host_set = qc->ap->host_set;
+	struct nv_host *host = host_set->private_data;
+
+	if (host->host_desc->host_type == ADMA) {
+		return nv_adma_qc_issue(qc);
+	} else {
+		return ata_qc_issue_prot(qc);
+	}
+}
+
+static int nv_adma_qc_issue(struct ata_queued_cmd *qc)
+{
+#if 0
+	struct nv_adma_port_priv *pp = qc->ap->private_data;
+#endif
+	void __iomem *mmio = nv_adma_ctl_block(qc->ap);
+
+	VPRINTK("ENTER\n");
+
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP)) {
+		VPRINTK("no dmamap, using ATA register mode: 0x%x\n", (u32)qc->flags);
+		// use ATA register mode
+		nv_adma_register_mode(qc->ap);
+		return ata_qc_issue_prot(qc);
+	} else {
+		nv_adma_mode(qc->ap);
+	}
+
+#if 0
+	nv_adma_dump_port(qc->ap);
+	nv_adma_dump_cpb(&pp->cpb[qc->tag]);
+	if (qc->n_elem > 5) {
+		int i;
+		for (i = 0; i < qc->n_elem - 5; i++) {
+			nv_adma_dump_aprd(&pp->aprd[i]);
+		}
+	}
+#endif
+
+	//
+	// write append register, command tag in lower 8 bits
+	// and (number of cpbs to append -1) in top 8 bits
+	//
+	mb();
+	writew(qc->tag, mmio + NV_ADMA_APPEND);
+	
+	VPRINTK("EXIT\n");
+
+	return 0;
+}
+
 static void nv_enable_hotplug(struct ata_probe_ent *probe_ent)
 {
 	u8 intr_mask;
@@ -543,11 +1453,8 @@ static void nv_enable_hotplug_ck804(stru
 {
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	u8 intr_mask;
-	u8 regval;
 
-	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
-	regval |= NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+	nv_enable_adma_space(pdev);
 
 	writeb(NV_INT_STATUS_HOTPLUG, probe_ent->mmio_base + NV_INT_STATUS_CK804);
 
@@ -561,7 +1468,6 @@ static void nv_disable_hotplug_ck804(str
 {
 	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 	u8 intr_mask;
-	u8 regval;
 
 	intr_mask = readb(host_set->mmio_base + NV_INT_ENABLE_CK804);
 
@@ -569,9 +1475,7 @@ static void nv_disable_hotplug_ck804(str
 
 	writeb(intr_mask, host_set->mmio_base + NV_INT_ENABLE_CK804);
 
-	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
-	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+	nv_disable_adma_space(pdev);
 }
 
 static int nv_check_hotplug_ck804(struct ata_host_set *host_set)
@@ -606,6 +1510,65 @@ static int nv_check_hotplug_ck804(struct
 	return 0;
 }
 
+static void nv_enable_hotplug_adma(struct ata_probe_ent *probe_ent)
+{
+	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
+	unsigned int i;
+	u16 tmp;
+
+	nv_enable_adma_space(pdev);
+
+	for (i = 0; i < probe_ent->n_ports; i++) {
+		void __iomem *mmio = __nv_adma_ctl_block(probe_ent->mmio_base, i);
+		writew(NV_ADMA_STAT_HOTPLUG | NV_ADMA_STAT_HOTUNPLUG,
+		       mmio + NV_ADMA_STAT);
+
+		tmp = readw(mmio + NV_ADMA_CTL);
+		writew(tmp | NV_ADMA_CTL_HOTPLUG_IEN, mmio + NV_ADMA_CTL);
+		
+	}
+}
+
+static void nv_disable_hotplug_adma(struct ata_host_set *host_set)
+{
+	unsigned int i;
+	u16 tmp;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		void __iomem *mmio = __nv_adma_ctl_block(host_set->mmio_base, i);
+
+		tmp = readw(mmio + NV_ADMA_CTL);
+		writew(tmp & ~NV_ADMA_CTL_HOTPLUG_IEN, mmio + NV_ADMA_CTL);
+		
+	}
+}
+
+static int nv_check_hotplug_adma(struct ata_host_set *host_set)
+{
+	unsigned int i;
+	u16 adma_status;
+	int hotplugged = 0;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		void __iomem *mmio = __nv_adma_ctl_block(host_set->mmio_base, i);
+		adma_status = readw(mmio + NV_ADMA_STAT);
+		if (adma_status & NV_ADMA_STAT_HOTPLUG) {
+			printk(KERN_WARNING "nv_sata: "
+			       "port %d device added\n", i);
+			writew(NV_ADMA_STAT_HOTPLUG, mmio + NV_ADMA_STAT);
+			hotplugged = 1;
+		}
+		if (adma_status & NV_ADMA_STAT_HOTUNPLUG) {
+			printk(KERN_WARNING "nv_sata: "
+			       "port %d device removed\n", i);
+			writew(NV_ADMA_STAT_HOTUNPLUG, mmio + NV_ADMA_STAT);
+			hotplugged = 1;
+		}
+	}
+
+	return hotplugged;
+}
+
 static int __init nv_init(void)
 {
 	return pci_module_init(&nv_pci_driver);
@@ -618,3 +1581,71 @@ static void __exit nv_exit(void)
 
 module_init(nv_init);
 module_exit(nv_exit);
+module_param_named(adma, adma_enabled, bool, 0);
+MODULE_PARM_DESC(adma, "Enable use of ADMA (Default: false)");
+
+
+#ifdef DEBUG
+static void nv_adma_dump_aprd(struct nv_adma_prd *aprd)
+{
+	printk("%016llx %08x %02x %s %s %s\n",
+	       aprd->addr,
+	       aprd->len,
+	       aprd->flags,
+	       (aprd->flags & NV_APRD_WRITE) ? "WRITE" : "     ",
+	       (aprd->flags & NV_APRD_END)   ? "END"   : "   ",
+	       (aprd->flags & NV_APRD_CONT)  ? "CONT"  : "    ");
+}
+static void nv_adma_dump_iomem(void __iomem *m, int len)
+{
+	int i, j;
+
+	for (i = 0; i < len/16; i++) {
+		printk(KERN_WARNING "%02x: ", 16*i);
+		for (j = 0; j < 16; j++) {
+			printk("%02x%s", (u32)readb(m + 16*i + j),
+			       (j == 7) ? "-" : " ");
+		}
+		printk("\n");
+	}
+}
+
+static void nv_adma_dump_cpb_tf(u16 tf)
+{
+	printk("0x%04x %s %s %s 0x%02x 0x%02x\n",
+	       tf,
+	       (tf & CMDEND) ? "END" : "   ",
+	       (tf & WNB) ? "WNB" : "   ",
+	       (tf & IGN) ? "IGN" : "   ",
+	       ((tf >> 8) & 0x1f),
+	       (tf & 0xff));
+}
+	
+static void nv_adma_dump_port(struct ata_port *ap)
+{
+	void __iomem *mmio = nv_adma_ctl_block(ap);
+	nv_adma_dump_iomem(mmio, NV_ADMA_PORT_SIZE);
+}
+			
+static void nv_adma_dump_cpb(struct nv_adma_cpb *cpb)
+{
+	int i;
+
+	printk("resp_flags:   0x%02x\n", cpb->resp_flags);
+	printk("ctl_flags:    0x%02x\n", cpb->ctl_flags);
+	printk("len:          0x%02x\n", cpb->len);
+	printk("tag:          0x%02x\n", cpb->tag);
+	printk("next_cpb_idx: 0x%02x\n", cpb->next_cpb_idx);
+	printk("tf:\n");
+	for (i=0; i<12; i++) {
+		nv_adma_dump_cpb_tf(cpb->tf[i]);
+	}
+	printk("aprd:\n");
+	for (i=0; i<5; i++) {
+		nv_adma_dump_aprd(&cpb->aprd[i]);
+	}
+	printk("next_aprd:    0x%016llx\n", cpb->next_aprd);
+}
+
+#endif	
+

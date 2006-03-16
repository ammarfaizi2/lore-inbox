Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWCPDPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWCPDPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWCPDPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:15:34 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:36804 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751247AbWCPDPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:15:32 -0500
Date: Wed, 15 Mar 2006 22:15:28 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060316031528.GF17817@ti64.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
	Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
	Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
	john stultz <johnstul@us.ibm.com>
References: <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu> <44189654.2080607@garzik.org> <20060315224408.GC24074@elte.hu> <44189A3D.5090202@garzik.org> <20060315231426.GD17817@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20060315231426.GD17817@ti64.telemetry-investments.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 15, 2006 at 06:14:26PM -0500, Bill Rugolsky Jr. wrote:
> On Wed, Mar 15, 2006 at 05:50:37PM -0500, Jeff Garzik wrote:
> > Alas, it is far from that simple :(
> > 
> > The code I linked to isn't in a working state.  NV contributed it 
> > largely as "it worked at one time" documentation of a 
> > previously-undocumented register interface.
> > 
> > Someone needs to debug it.
> 
> Errrr, guess that would me me.  Looks like a few interfaces have changed.
> I'll put some time in to see whether I can get it to compile and boot.
> If it's just a sata_nv issue, the easier solution is to buy a 3ware or
> Areca card ... but I'll take a shot at anyway.

Jeff,

I took a stab at it and got it to boot, but the boot hung around rc.local.
So I rebooted it with init=/bin/sh and manipulated it a bit by hand.

I have three drives in the machine:

ata1: sda: spare disk that I test Andi's RAID1 theory.
ata3: sdb: first drive of the system RAID1 pair
ata4: sdc: second drive of the system RAID1 pair.

I can write to ata1 no problem; I did the following:

	cd /
	mount /dev/sda1 /mnt
	cp -axv . /mnt/root
	sync

and that all worked.

Can't seem to write to ata4:

ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50

/proc/mdstat shows:

Personalities : [raid1] 
md2 : active raid1 sdc2[1] sdb2[0]
      1052160 blocks [2/2] [UU]
        resync=DELAYED
      
md3 : active raid1 sdc3[1] sdb3[0]
      586304 blocks [2/2] [UU]
      
md5 : active raid1 sdc5[1] sdb5[0]
      70838464 blocks [2/2] [UU]
      [>....................]  resync =  0.0% (64768/70838464) finish=127224.1min speed=9K/sec
      
md1 : active raid1 sdc1[1] sdb1[0]
      128384 blocks [2/2] [UU]
      
unused devices: <none>


I'm heading home now (it's 22:00, and I've been here 16 hours already), but
I figured that I'd post what I have thus far, and perhaps you can tell me
what the problem is.

	-Bill

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_nv-adma-incr.patch"

--- sata_nv.c.adma	2006-03-15 17:46:56.000000000 -0500
+++ sata_nv.c	2006-03-15 20:48:44.000000000 -0500
@@ -29,6 +29,14 @@
  *  NV-specific details such as register offsets, SATA phy location,
  *  hotplug info, etc.
  *
+ *  0.10
+ *     - Fixed spurious interrupts issue seen with the Maxtor 6H500F0 500GB
+ *       drive.  Also made the check_hotplug() callbacks return whether there
+ *       was a hotplug interrupt or not.  This was not the source of the
+ *       spurious interrupts, but is the right thing to do anyway.
+ *
+ *  0.09
+ *     - Fixed bug introduced by 0.08's MCP51 and MCP55 support.
  *
  *  0.08
  *     - Added support for MCP51 and MCP55.
@@ -59,6 +67,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
@@ -277,7 +286,7 @@ static int nv_adma_qc_issue(struct ata_q
 static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int nv_adma_tf_to_cpb(struct ata_taskfile *tf, u16 *cpb);
 static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb);
-static void nv_adma_fill_aprd(struct ata_queued_cmd *qc, int idx, struct nv_adma_prd *aprd);
+static void nv_adma_fill_aprd(struct ata_queued_cmd *qc, struct scatterlist *sg, int idx, struct nv_adma_prd *aprd);
 static void nv_adma_register_mode(struct ata_port *ap);
 static void nv_adma_mode(struct ata_port *ap);
 static u8 nv_bmdma_status(struct ata_port *ap);
@@ -305,7 +314,7 @@ enum nv_host_type
 	ADMA
 };
 
-static struct pci_device_id nv_pci_tbl[] = {
+static const struct pci_device_id nv_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE2 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
@@ -418,10 +427,9 @@ static struct scsi_host_template nv_sht 
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
-static struct ata_port_operations nv_ops = {
+static const struct ata_port_operations nv_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -605,7 +613,8 @@ static inline int nv_adma_host_intr(stru
 
 	if (handled) {
 		u8 ata_status = readb(mmio + (ATA_REG_STATUS * 4));
-		ata_qc_complete(qc, have_err ? (ata_status | ATA_ERR) : ata_status);
+		qc->err_mask |= ac_err_mask(have_err ? (ata_status | ATA_ERR) : ata_status);
+		ata_qc_complete(qc);
 	}
 
 	return handled; /* irq handled */
@@ -737,13 +746,11 @@ static irqreturn_t nv_interrupt (int irq
 				
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
-				if (host->host_desc->host_type == ADMA) {
+				if (host->host_desc->host_type == ADMA)
 					handled += nv_adma_host_intr(ap, qc);
-				} else {
+				else
 					handled += ata_host_intr(ap, qc);
-				}
 			}
-				
 		}
 
 	}
@@ -780,7 +787,7 @@ static u32 nv_scr_read (struct ata_port 
 		return 0xffffffffU;
 
 	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		val = readl((void*)ap->ioaddr.scr_addr + (sc_reg * 4));
+		val = readl((void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
 	else
 		val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 
@@ -800,7 +807,7 @@ static void nv_scr_write (struct ata_por
 		return;
 
 	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		writel(val, (void*)ap->ioaddr.scr_addr + (sc_reg * 4));
+		writel(val, (void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
 	else
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -1031,7 +1038,7 @@ static int nv_init_one (struct pci_dev *
 			return -ENODEV;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
 	if (rc)
@@ -1066,7 +1073,7 @@ static int nv_init_one (struct pci_dev *
 //		ppi->port_ops->irq_handler	= nv_adma_interrupt;
 	}
 	
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
+	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
 		goto err_out_regions;
 
@@ -1188,7 +1195,8 @@ static void nv_adma_eng_timeout(struct a
 	nv_adma_reset_channel(ap);
 
 	/* complete taskfile transaction */
-	ata_qc_complete(qc, drv_stat);
+	qc->err_mask |= ac_err_mask(drv_stat);
+	ata_qc_complete(qc);
 
 //	spin_unlock_irqrestore(&host_set->lock, flags);
 
@@ -1247,18 +1255,16 @@ static void nv_adma_fill_sg(struct ata_q
 	struct nv_adma_port_priv *pp = qc->ap->private_data;
 	unsigned int idx;
 	struct nv_adma_prd *aprd;
+	struct scatterlist *sg;
 
 	VPRINTK("ENTER\n");
 
 	idx = 0;
 
-	for (idx = 0; idx < qc->n_elem; idx++) {
-		if (idx < 5) {
-			aprd = &cpb->aprd[idx];
-		} else {
-			aprd = &pp->aprd[idx-5];
-		}
-		nv_adma_fill_aprd(qc, idx, aprd);
+	ata_for_each_sg(sg, qc) {
+		aprd = (idx < 5) ? &cpb->aprd[idx] : &pp->aprd[idx-5];
+		nv_adma_fill_aprd(qc, sg, idx, aprd);
+		idx++;
 	}
 	if (idx > 5) {
 		cpb->next_aprd = (u64)(pp->aprd_dma + NV_ADMA_APRD_SZ * qc->tag);
@@ -1266,6 +1272,7 @@ static void nv_adma_fill_sg(struct ata_q
 }
 
 static void nv_adma_fill_aprd(struct ata_queued_cmd *qc,
+			      struct scatterlist *sg,
 			      int idx,
 			      struct nv_adma_prd *aprd)
 {
@@ -1273,8 +1280,8 @@ static void nv_adma_fill_aprd(struct ata
 
 	memset(aprd, 0, sizeof(struct nv_adma_prd));
 
-	addr   = sg_dma_address(&qc->sg[idx]);
-	sg_len = sg_dma_len(&qc->sg[idx]);
+	addr   = sg_dma_address(sg);
+	sg_len = sg_dma_len(sg);
 
 	flags = 0;
 	if (qc->tf.flags & ATA_TFLAG_WRITE)

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.16-rc6-git4-sata_nv-adma.patch"

--- linux-2.6.16-rc6-git4/drivers/scsi/sata_nv.c	2006-03-15 17:19:18.000000000 -0500
+++ linux-2.6.16-rc6-git4/drivers/scsi/sata_nv.c	2006-03-15 20:48:44.000000000 -0500
@@ -68,9 +68,12 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
+//#define DEBUG
+
 #define DRV_NAME			"sata_nv"
 #define DRV_VERSION			"0.8"
 
@@ -121,6 +124,140 @@
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
+#define NV_ADMA_CTL_READ_NON_COHERENT	(1 << 11)
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
@@ -128,19 +265,53 @@ static irqreturn_t nv_interrupt (int irq
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
-static int nv_check_hotplug(struct ata_host_set *host_set);
+static void nv_check_hotplug(struct ata_host_set *host_set);
 static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent);
 static void nv_disable_hotplug_ck804(struct ata_host_set *host_set);
-static int nv_check_hotplug_ck804(struct ata_host_set *host_set);
+static void nv_check_hotplug_ck804(struct ata_host_set *host_set);
+static void nv_enable_hotplug_adma(struct ata_probe_ent *probe_ent);
+static void nv_disable_hotplug_adma(struct ata_host_set *host_set);
+static void nv_check_hotplug_adma(struct ata_host_set *host_set);
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
 
 enum nv_host_type
 {
 	GENERIC,
 	NFORCE2,
 	NFORCE3,
-	CK804
+	CK804,
+	MCP51,
+	MCP55,
+	ADMA
 };
 
 static const struct pci_device_id nv_pci_tbl[] = {
@@ -151,21 +322,21 @@ static const struct pci_device_id nv_pci
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE3 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ADMA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
@@ -182,7 +353,7 @@ struct nv_host_desc
 	enum nv_host_type	host_type;
 	void			(*enable_hotplug)(struct ata_probe_ent *probe_ent);
 	void			(*disable_hotplug)(struct ata_host_set *host_set);
-	int			(*check_hotplug)(struct ata_host_set *host_set);
+	void			(*check_hotplug)(struct ata_host_set *host_set);
 
 };
 static struct nv_host_desc nv_device_tbl[] = {
@@ -209,6 +380,21 @@ static struct nv_host_desc nv_device_tbl
 		.disable_hotplug= nv_disable_hotplug_ck804,
 		.check_hotplug	= nv_check_hotplug_ck804,
 	},
+	{	.host_type	= MCP51,
+		.enable_hotplug	= nv_enable_hotplug,
+		.disable_hotplug= nv_disable_hotplug,
+		.check_hotplug	= nv_check_hotplug,
+	},
+	{	.host_type	= MCP55,
+		.enable_hotplug	= nv_enable_hotplug,
+		.disable_hotplug= nv_disable_hotplug,
+		.check_hotplug	= nv_check_hotplug,
+	},
+	{	.host_type	= ADMA,
+		.enable_hotplug	= nv_enable_hotplug_adma,
+		.disable_hotplug= nv_disable_hotplug_adma,
+		.check_hotplug	= nv_check_hotplug_adma,
+	},
 };
 
 struct nv_host
@@ -253,20 +439,187 @@ static const struct ata_port_operations 
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
@@ -275,6 +628,7 @@ static const struct ata_port_operations 
  * This problem really needs to be investigated further.  But in the
  * meantime, we avoid ATA_FLAG_SATA_RESET to get people working.
  */
+
 static struct ata_port_info nv_port_info = {
 	.sht		= &nv_sht,
 	.host_flags	= ATA_FLAG_SATA |
@@ -293,6 +647,79 @@ MODULE_LICENSE("GPL");
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
+	/* TODO */
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
+	/* TODO */
+}
+
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
 				 struct pt_regs *regs)
 {
@@ -305,26 +732,41 @@ static irqreturn_t nv_interrupt (int irq
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap;
+		struct ata_port *ap = host_set->ports[i];
+		struct nv_adma_port_priv *pp = ap->private_data;
 
-		ap = host_set->ports[i];
 		if (ap &&
 		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+			void __iomem *mmio = nv_adma_ctl_block(ap);
 			struct ata_queued_cmd *qc;
 
+			// read notifiers
+			pp->notifier = readl(mmio + NV_ADMA_NOTIFIER);
+			pp->notifier_error = readl(mmio + NV_ADMA_NOTIFIER_ERROR);
+				
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
-				handled += ata_host_intr(ap, qc);
-			else
-				// No request pending?  Clear interrupt status
-				// anyway, in case there's one pending.
-				ap->ops->check_status(ap);
+			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+				if (host->host_desc->host_type == ADMA)
+					handled += nv_adma_host_intr(ap, qc);
+				else
+					handled += ata_host_intr(ap, qc);
+			}
 		}
 
 	}
 
 	if (host->host_desc->check_hotplug)
-		handled += host->host_desc->check_hotplug(host_set);
+		host->host_desc->check_hotplug(host_set);
+
+	// clear notifier
+	if (handled) {
+		for (i = 0; i < host_set->n_ports; i++) {
+			struct ata_port *ap = host_set->ports[i];
+			struct nv_adma_port_priv *pp = ap->private_data;
+			writel(pp->notifier | pp->notifier_error,
+			       nv_adma_notifier_clear_block(ap));
+		}
+	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
@@ -335,14 +777,22 @@ static u32 nv_scr_read (struct ata_port 
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
@@ -350,6 +800,9 @@ static void nv_scr_write (struct ata_por
 	struct ata_host_set *host_set = ap->host_set;
 	struct nv_host *host = host_set->private_data;
 
+	VPRINTK("ENTER\n");
+
+	VPRINTK("writing SCR reg %d with 0x%08x\n", sc_reg, val);
 	if (sc_reg > SCR_CONTROL)
 		return;
 
@@ -364,6 +817,8 @@ static void nv_host_stop (struct ata_hos
 	struct nv_host *host = host_set->private_data;
 	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 
+	VPRINTK("ENTER\n");
+
 	// Disable hotplug event interrupts.
 	if (host->host_desc->disable_hotplug)
 		host->host_desc->disable_hotplug(host_set);
@@ -374,16 +829,207 @@ static void nv_host_stop (struct ata_hos
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
@@ -414,6 +1060,19 @@ static int nv_init_one (struct pci_dev *
 	rc = -ENOMEM;
 
 	ppi = &nv_port_info;
+	
+	host_desc = &nv_device_tbl[ent->driver_data];
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
@@ -423,7 +1082,7 @@ static int nv_init_one (struct pci_dev *
 		goto err_out_free_ent;
 
 	memset(host, 0, sizeof(struct nv_host));
-	host->host_desc = &nv_device_tbl[ent->driver_data];
+	host->host_desc = host_desc;
 
 	probe_ent->private_data = host;
 
@@ -440,6 +1099,7 @@ static int nv_init_one (struct pci_dev *
 		}
 
 		base = (unsigned long)probe_ent->mmio_base;
+		VPRINTK("BAR5 base is at 0x%x\n", (u32)base);
 
 		probe_ent->port[0].scr_addr =
 			base + NV_PORT0_SCR_REG_OFFSET;
@@ -455,6 +1115,12 @@ static int nv_init_one (struct pci_dev *
 
 	pci_set_master(pdev);
 
+	if (ent->driver_data == ADMA) {
+		rc = nv_adma_host_init(probe_ent);
+		if (rc)
+			goto err_out_iounmap;
+	}
+
 	rc = ata_device_add(probe_ent);
 	if (rc != NV_PORTS)
 		goto err_out_iounmap;
@@ -483,6 +1149,239 @@ err_out:
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
@@ -507,7 +1406,7 @@ static void nv_disable_hotplug(struct at
 	outb(intr_mask, host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
 }
 
-static int nv_check_hotplug(struct ata_host_set *host_set)
+static void nv_check_hotplug(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
@@ -532,22 +1431,15 @@ static int nv_check_hotplug(struct ata_h
 		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
 			printk(KERN_WARNING "nv_sata: "
 				"Secondary device removed\n");
-
-		return 1;
 	}
-
-	return 0;
 }
 
 static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent)
 {
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	u8 intr_mask;
-	u8 regval;
 
-	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
-	regval |= NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+	nv_enable_adma_space(pdev);
 
 	writeb(NV_INT_STATUS_HOTPLUG, probe_ent->mmio_base + NV_INT_STATUS_CK804);
 
@@ -561,7 +1453,6 @@ static void nv_disable_hotplug_ck804(str
 {
 	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 	u8 intr_mask;
-	u8 regval;
 
 	intr_mask = readb(host_set->mmio_base + NV_INT_ENABLE_CK804);
 
@@ -569,12 +1460,10 @@ static void nv_disable_hotplug_ck804(str
 
 	writeb(intr_mask, host_set->mmio_base + NV_INT_ENABLE_CK804);
 
-	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
-	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+	nv_disable_adma_space(pdev);
 }
 
-static int nv_check_hotplug_ck804(struct ata_host_set *host_set)
+static void nv_check_hotplug_ck804(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
@@ -599,11 +1488,61 @@ static int nv_check_hotplug_ck804(struct
 		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
 			printk(KERN_WARNING "nv_sata: "
 				"Secondary device removed\n");
+	}
+}
+
+static void nv_enable_hotplug_adma(struct ata_probe_ent *probe_ent)
+{
+	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
+	unsigned int i;
+	u16 tmp;
 
-		return 1;
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
 	}
+}
 
-	return 0;
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
+static void nv_check_hotplug_adma(struct ata_host_set *host_set)
+{
+	unsigned int i;
+	u16 adma_status;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		void __iomem *mmio = __nv_adma_ctl_block(host_set->mmio_base, i);
+		adma_status = readw(mmio + NV_ADMA_STAT);
+		if (adma_status & NV_ADMA_STAT_HOTPLUG) {
+			printk(KERN_WARNING "nv_sata: "
+			       "port %d device added\n", i);
+			writew(NV_ADMA_STAT_HOTPLUG, mmio + NV_ADMA_STAT);
+		}
+		if (adma_status & NV_ADMA_STAT_HOTUNPLUG) {
+			printk(KERN_WARNING "nv_sata: "
+			       "port %d device removed\n", i);
+			writew(NV_ADMA_STAT_HOTUNPLUG, mmio + NV_ADMA_STAT);
+		}
+	}
 }
 
 static int __init nv_init(void)
@@ -618,3 +1557,68 @@ static void __exit nv_exit(void)
 
 module_init(nv_init);
 module_exit(nv_exit);
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

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-sata_nv-adma.txt"

Bootdata ok (command line is ro root=/dev/md2 report_lost_ticks maxcpus=1 init=/bin/sh)
Linux version 2.6.16-rc6-git4-mmio (rugolsky@ti94) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #4 SMP Wed Mar 15 20:48:51 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff10000 (usable)
 BIOS-e820: 000000007ff10000 - 000000007ff17000 (ACPI data)
 BIOS-e820: 000000007ff17000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f7920
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x000000007ff127f1
ACPI: FADT (v001 NVIDIA CK8S     0x06040000 PTL_ 0x000f4240) @ 0x000000007ff16dd8
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x000000007ff16e4c
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x000000007ff16e9c
ACPI: MCFG (v001 PTLTD    MCFG   0x06040000  LTP 0x00000000) @ 0x000000007ff16f1c
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x000000007ff16f58
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x000000007ff16fd8
ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 514672
  DMA zone: 1828 pages, LIFO batch:0
  DMA32 zone: 512844 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: 2 duplicate APIC table ignored.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xc0400000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xc0400000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xc0401000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xc0401000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Checking aperture...
CPU 0: aperture @ bc000000 size 64 MB
CPU 1: aperture @ bc000000 size 64 MB
Built 1 zonelists
Kernel command line: ro root=/dev/md2 report_lost_ticks maxcpus=1 init=/bin/sh
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2009.273 MHz processor.
Console: colour VGA+ 80x25
time.c: Lost 495 timer tick(s)! rip start_kernel+0x102/0x1cc)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2053752k/2096192k available (1985k kernel code, 41716k reserved, 1053k data, 180k init)
Calibrating delay using timer specific routine.. 4023.40 BogoMIPS (lpj=2011702)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
time.c: Lost 2 timer tick(s)! rip acpi_os_write_port+0x22/0x42)
Using local APIC timer interrupts.
result 12557972
Detected 12.557 MHz APIC timer.
time.c: Lost 49 timer tick(s)! rip setup_boot_APIC_clock+0x121/0x127)
Brought up 1 CPUs
testing NMI watchdog ... OK.
migration_cost=0
checking if image is initramfs... it is
Freeing initrd memory: 1289k freed
DMI present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Transparent bridge - 0000:00:09.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK4] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK5] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LSI1] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Root Bridge [PCI2] (0000:08)
PCI: Probing PCI hardware (bus 08)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
ACPI: PCI Root Bridge [PCI1] (0000:80)
PCI: Probing PCI hardware (bus 80)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:81:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.XVR0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
pnp: 00:02: ioport range 0x8000-0x807f could not be reserved
pnp: 00:02: ioport range 0x8080-0x80ff has been reserved
pnp: 00:02: ioport range 0x8400-0x847f has been reserved
pnp: 00:02: ioport range 0x8480-0x84ff has been reserved
pnp: 00:02: ioport range 0x8800-0x887f has been reserved
pnp: 00:02: ioport range 0x8880-0x88ff has been reserved
pnp: 00:02: ioport range 0xa000-0xa03f has been reserved
pnp: 00:02: ioport range 0xa040-0xa07f has been reserved
PCI: Bridge: 0000:00:09.0
  IO window: disabled.
  MEM window: c0100000-c01fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Bridge: 0000:80:0e.0
  IO window: 3000-3fff
  MEM window: c0900000-c09fffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:80:0e.0 to 64
Simple Boot Flag at 0x36 set to 0x1
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1142476264.041:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
time.c: Lost 202 timer tick(s)! rip __do_softirq+0x45/0xc8)
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
Allocate Port Service[0000:00:0e.0:pcie03]
PCI: Setting latency timer of device 0000:80:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:80:0e.0:pcie00]
Allocate Port Service[0000:80:0e.0:pcie03]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
isa bounce pool size: 16 pages
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0x1c00-0x1c07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c08-0x1c0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-3550A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 180k freed
SCSI subsystem initialized
libata version 1.20 loaded.
sata_nv 0000:00:07.0: version 0.8
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 23
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 23 (level, high) -> IRQ 16
PCI: Setting latency timer of device 0000:00:07.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0xFFFFC20000004480 ctl 0xFFFFC200000044A0 bmdma 0x1C10 irq 16
ata2: SATA max UDMA/133 cmd 0xFFFFC20000004580 ctl 0xFFFFC200000045A0 bmdma 0x1C18 irq 16
input: AT Translated Set 2 keyboard as /class/input/input0
ata1: SATA link up 3.0 Gbps (SStatus 123)
ata1: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469 86:3d01 87:4763 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 160836480 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: SATA link down (SStatus 0)
scsi1 : sata_nv
  Vendor: ATA       Model: HDS728080PLA380   Rev: PF2O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 22
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 22 (level, high) -> IRQ 17
PCI: Setting latency timer of device 0000:00:08.0 to 64
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0xFFFFC20000006480 ctl 0xFFFFC200000064A0 bmdma 0x1C20 irq 17
ata4: SATA max UDMA/133 cmd 0xFFFFC20000006580 ctl 0xFFFFC200000065A0 bmdma 0x1C28 irq 17
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3d43 87:4003 88:007f
ata3: dev 0 ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_nv
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3d43 87:4003 88:007f
ata4: dev 0 ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_nv
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 33.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
sd 2:0:0:0: Attached scsi disk sdb
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 33.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 145226112 512-byte hdwr sectors (74356 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 145226112 512-byte hdwr sectors (74356 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 >
sd 3:0:0:0: Attached scsi disk sdc
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
md: raid1 personality registered for level 1
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdc5 ...
md:  adding sdc5 ...
md: sdc3 has different UUID to sdc5
md: sdc2 has different UUID to sdc5
md: sdc1 has different UUID to sdc5
md:  adding sdb5 ...
md: sdb3 has different UUID to sdc5
md: sdb2 has different UUID to sdc5
md: sdb1 has different UUID to sdc5
md: created md5
md: bind<sdb5>
md: bind<sdc5>
md: running: <sdc5><sdb5>
md: md5: raid array is not clean -- starting background reconstruction
raid1: raid set md5 active with 2 out of 2 mirrors
md: considering sdc3 ...
md: syncing RAID array md5
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reconstruction.
md: using 128k window, over a total of 70838464 blocks.
md:  adding sdc3 ...
md: sdc2 has different UUID to sdc3
md: sdc1 has different UUID to sdc3
md:  adding sdb3 ...
md: sdb2 has different UUID to sdc3
md: sdb1 has different UUID to sdc3
md: created md3
md: bind<sdb3>
md: bind<sdc3>
md: running: <sdc3><sdb3>
raid1: raid set md3 active with 2 out of 2 mirrors
md: considering sdc2 ...
md:  adding sdc2 ...
md: sdc1 has different UUID to sdc2
md:  adding sdb2 ...
md: sdb1 has different UUID to sdc2
md: created md2
md: bind<sdb2>
md: bind<sdc2>
md: running: <sdc2><sdb2>
md: md2: raid array is not clean -- starting background reconstruction
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering sdc1 ...
md: delaying resync of md2 until md5 has finished resync (they share one or more physical units)
md:  adding sdc1 ...
md:  adding sdb1 ...
md: created md1
md: bind<sdb1>
md: bind<sdc1>
md: running: <sdc1><sdb1>
raid1: raid set md1 active with 2 out of 2 mirrors
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
(        events/0-5    |#0): new 5 us maximum-latency wakeup.
(        events/0-5    |#0): new 7 us maximum-latency wakeup.
(        events/0-5    |#0): new 8 us maximum-latency wakeup.
(        events/0-5    |#0): new 15 us maximum-latency wakeup.
(        events/0-5    |#0): new 16 us maximum-latency wakeup.
ata4: command 0x35 timeout, stat 0x50
(      md5_resync-677  |#0): new 34 us maximum-latency wakeup.
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
(       kblockd/0-14   |#0): new 54 us maximum-latency wakeup.
ata4: command 0x35 timeout, stat 0x50
EXT3 FS on sda1, internal journal
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50

--fdj2RfSjLxBAspz7--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422980AbWJaInt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422980AbWJaInt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422975AbWJaIns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:43:48 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:17226 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1422972AbWJaInr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:43:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Date: Tue, 31 Oct 2006 16:43:19 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C42D636@hkemmail01.nvidia.com>
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B059FE0B3@hkemmail01.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Thread-Index: AcbylPkK5Qe++8eiRNWW5sz5Z/eLIAAA6uVQAovdnfA=
From: "Peer Chen" <pchen@nvidia.com>
To: <jeff@garzik.org>, <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>
Cc: "Kuan Luo" <kluo@nvidia.com>
X-OriginalArrivalTime: 31 Oct 2006 08:43:20.0176 (UTC) FILETIME=[9E0A1F00:01C6FCC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following SGPIO patch for sata_nv.c is based on 2.6.18 kernel.
Signed-off by: Kuan Luo <kluo@nvidia.com>


--- linux-2.6.18/drivers/scsi/sata_nv.c.orig	2006-10-08
17:20:07.000000000 +0800
+++ linux-2.6.18/drivers/scsi/sata_nv.c	2006-10-13 11:12:01.000000000
+0800
@@ -80,6 +80,175 @@
 	NV_MCP_SATA_CFG_20_SATA_SPACE_EN = 0x04,
 };
 
+//sgpio
+// Sgpio defines
+// SGPIO state defines
+#define NV_SGPIO_STATE_RESET		0
+#define NV_SGPIO_STATE_OPERATIONAL	1
+#define NV_SGPIO_STATE_ERROR		2
+
+// SGPIO command opcodes
+#define NV_SGPIO_CMD_RESET		0
+#define NV_SGPIO_CMD_READ_PARAMS	1
+#define NV_SGPIO_CMD_READ_DATA		2
+#define NV_SGPIO_CMD_WRITE_DATA		3
+
+// SGPIO command status defines
+#define NV_SGPIO_CMD_OK			0
+#define NV_SGPIO_CMD_ACTIVE		1
+#define NV_SGPIO_CMD_ERR		2
+
+#define NV_SGPIO_UPDATE_TICK		90
+#define NV_SGPIO_MIN_UPDATE_DELTA	33
+#define NV_CNTRLR_SHARE_INIT		2
+#define NV_SGPIO_MAX_ACTIVITY_ON	20
+#define NV_SGPIO_MIN_FORCE_OFF		5
+#define NV_SGPIO_PCI_CSR_OFFSET		0x58
+#define NV_SGPIO_PCI_CB_OFFSET		0x5C
+#define NV_SGPIO_DFLT_CB_SIZE		256
+#define NV_ON 1
+#define NV_OFF 0
+#ifndef bool
+#define bool u8
+#endif
+
+
+#define BF_EXTRACT(v, off, bc)	\
+	((((u8)(v)) >> (off)) & ((1 << (bc)) - 1))
+
+#define BF_INS(v, ins, off, bc)				\
+	(((v) & ~((((1 << (bc)) - 1)) << (off))) |	\
+	(((u8)(ins)) << (off)))
+
+#define BF_EXTRACT_U32(v, off, bc)	\
+	((((u32)(v)) >> (off)) & ((1 << (bc)) - 1))
+
+#define BF_INS_U32(v, ins, off, bc)			\
+	(((v) & ~((((1 << (bc)) - 1)) << (off))) |	\
+	(((u32)(ins)) << (off)))
+
+#define GET_SGPIO_STATUS(v)	BF_EXTRACT(v, 0, 2)
+#define GET_CMD_STATUS(v)	BF_EXTRACT(v, 3, 2)
+#define GET_CMD(v)		BF_EXTRACT(v, 5, 3)
+#define SET_CMD(v, cmd)		BF_INS(v, cmd, 5, 3) 
+
+#define GET_ENABLE(v)		BF_EXTRACT_U32(v, 23, 1)
+#define SET_ENABLE(v)		BF_INS_U32(v, 1, 23, 1)
+
+// Needs to have a u8 bit-field insert.
+#define GET_ACTIVITY(v)		BF_EXTRACT(v, 5, 3)
+#define SET_ACTIVITY(v, on_off)	BF_INS(v, on_off, 5, 3)
+
+union nv_sgpio_nvcr 
+{
+	struct {
+		u8	init_cnt;
+		u8	cb_size;
+		u8	cbver;
+		u8	rsvd;
+	} bit;
+	u32	all;
+};
+
+union nv_sgpio_tx 
+{
+	u8	tx_port[4];
+	u32 	all;
+};
+
+struct nv_sgpio_cb 
+{
+	u64			scratch_space;
+	union nv_sgpio_nvcr	nvcr;
+	u32			cr0;
+	u32                     rsvd[4];
+	union nv_sgpio_tx       tx[2];
+};
+
+struct nv_sgpio_host_share
+{
+	spinlock_t	*plock;
+	unsigned long   *ptstamp;
+};
+
+struct nv_sgpio_host_flags
+{
+	u8	sgpio_enabled:1;
+	u8	need_update:1;
+	u8	rsvd:6;
+};
+	
+struct nv_host_sgpio
+{
+	struct nv_sgpio_host_flags	flags;
+	u8				*pcsr;
+	struct nv_sgpio_cb		*pcb;	
+	struct nv_sgpio_host_share	share;
+	struct timer_list		sgpio_timer;
+};
+
+struct nv_sgpio_port_flags
+{
+	u8	last_state:1;
+	u8	recent_activity:1;
+	u8	rsvd:6;
+};
+
+struct nv_sgpio_led 
+{
+	struct nv_sgpio_port_flags	flags;
+	u8				force_off;
+	u8      			last_cons_active;
+};
+
+struct nv_port_sgpio
+{
+	struct nv_sgpio_led	activity;
+};
+
+static spinlock_t	nv_sgpio_lock;
+static unsigned long	nv_sgpio_tstamp;
+
+static inline void nv_sgpio_set_csr(u8 csr, unsigned long pcsr)
+{
+	outb(csr, pcsr);
+}
+
+static inline u8 nv_sgpio_get_csr(unsigned long pcsr)
+{
+	return inb(pcsr);
+}
+
+static inline u8 nv_sgpio_get_func(struct ata_host_set *host_set)
+{
+	u8 devfn = (to_pci_dev(host_set->dev))->devfn;
+	return (PCI_FUNC(devfn));
+}
+
+static inline u8 nv_sgpio_tx_host_offset(struct ata_host_set *host_set)
+{
+	return (nv_sgpio_get_func(host_set)/NV_CNTRLR_SHARE_INIT);
+}
+
+static inline u8 nv_sgpio_calc_tx_offset(u8 cntrlr, u8 channel)
+{
+	return (sizeof(union nv_sgpio_tx) - (NV_CNTRLR_SHARE_INIT *
+		(cntrlr % NV_CNTRLR_SHARE_INIT)) - channel - 1);
+}
+
+static inline u8 nv_sgpio_tx_port_offset(struct ata_port *ap)
+{
+	u8 cntrlr = nv_sgpio_get_func(ap->host_set);
+	return (nv_sgpio_calc_tx_offset(cntrlr, ap->port_no));
+}
+
+static inline bool nv_sgpio_capable(const struct pci_device_id *ent)
+{
+	if (ent->device == PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2)
+		return 1;
+	else
+		return 0;
+}
 static int nv_init_one (struct pci_dev *pdev, const struct
pci_device_id *ent);
 static void nv_ck804_host_stop(struct ata_host_set *host_set);
 static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance,
@@ -90,7 +259,10 @@
 				      struct pt_regs *regs);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32
val);
-
+static void nv_host_stop (struct ata_host_set *host_set);
+static int nv_port_start(struct ata_port *ap);
+static void nv_port_stop(struct ata_port *ap);
+static int nv_qc_issue(struct ata_queued_cmd *qc);
 static void nv_nf2_freeze(struct ata_port *ap);
 static void nv_nf2_thaw(struct ata_port *ap);
 static void nv_ck804_freeze(struct ata_port *ap);
@@ -147,6 +319,27 @@
 	{ 0, } /* terminate list */
 };
 
+struct nv_host
+{
+	unsigned long		host_flags;
+	struct nv_host_sgpio	host_sgpio;
+};
+
+struct nv_port
+{
+	struct nv_port_sgpio	port_sgpio;
+};
+
+// SGPIO function prototypes
+static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host *phost);
+static void nv_sgpio_reset(u8 *pcsr);
+static void nv_sgpio_set_timer(struct timer_list *ptimer, 
+				unsigned int timeout_msec);
+static void nv_sgpio_timer_handler(unsigned long ptr);
+static void nv_sgpio_host_cleanup(struct nv_host *host);
+static bool nv_sgpio_update_led(struct nv_sgpio_led *led, bool
*on_off);
+static void nv_sgpio_clear_all_leds(struct ata_port *ap);
+static bool nv_sgpio_send_cmd(struct nv_host *host, u8 cmd);
 static struct pci_driver nv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
@@ -184,7 +377,7 @@
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.qc_issue		= nv_qc_issue,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= nv_error_handler,
@@ -194,9 +387,9 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
+	.port_start		= nv_port_start,
+	.port_stop		= nv_port_stop,
+	.host_stop		= nv_host_stop,
 };
 
 static const struct ata_port_operations nv_nf2_ops = {
@@ -211,7 +404,7 @@
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.qc_issue		= nv_qc_issue,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
 	.error_handler		= nv_error_handler,
@@ -221,9 +414,9 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
+	.port_start		= nv_port_start,
+	.port_stop		= nv_port_stop,
+	.host_stop		= nv_host_stop,
 };
 
 static const struct ata_port_operations nv_ck804_ops = {
@@ -238,7 +431,7 @@
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.qc_issue		= nv_qc_issue,
 	.freeze			= nv_ck804_freeze,
 	.thaw			= nv_ck804_thaw,
 	.error_handler		= nv_error_handler,
@@ -248,8 +441,8 @@
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
+	.port_start		= nv_port_start,
+	.port_stop		= nv_port_stop,
 	.host_stop		= nv_ck804_host_stop,
 };
 
@@ -480,10 +673,10 @@
 	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
 			   nv_hardreset, ata_std_postreset);
 }
-
 static int nv_init_one (struct pci_dev *pdev, const struct
pci_device_id *ent)
 {
 	static int printed_version = 0;
+	struct nv_host *host;
 	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
 	int pci_dev_busy = 0;
@@ -525,6 +718,13 @@
 	if (!probe_ent)
 		goto err_out_regions;
 
+	host = kmalloc(sizeof(struct nv_host), GFP_KERNEL);
+	if (!host)
+		goto err_out_free_ent;
+
+	memset(host, 0, sizeof(struct nv_host));
+
+	probe_ent->private_data = host;
 	probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
 	if (!probe_ent->mmio_base) {
 		rc = -EIO;
@@ -550,6 +750,8 @@
 	rc = ata_device_add(probe_ent);
 	if (rc != NV_PORTS)
 		goto err_out_iounmap;
+	if (nv_sgpio_capable(ent))
+		nv_sgpio_init(pdev, host);
 
 	kfree(probe_ent);
 
@@ -568,12 +770,56 @@
 	return rc;
 }
 
+static int nv_port_start(struct ata_port *ap)
+{
+	int stat;
+	struct nv_port *port;
+
+	stat = ata_port_start(ap);
+	if (stat) {
+		return stat;
+	}
+
+	port = kmalloc(sizeof(struct nv_port), GFP_KERNEL);
+	if (!port) 
+		goto err_out_no_free;
+
+	memset(port, 0, sizeof(struct nv_port));
+
+	ap->private_data = port;
+	return 0;
+
+err_out_no_free:
+	return 1;
+}
+
+static void nv_port_stop(struct ata_port *ap)
+{
+	nv_sgpio_clear_all_leds(ap);
+
+	if (ap->private_data) {
+		kfree(ap->private_data);
+		ap->private_data = NULL;
+	}
+	ata_port_stop(ap);
+}
+
+static int nv_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct nv_port *port = qc->ap->private_data;
+
+	if (port) 
+		port->port_sgpio.activity.flags.recent_activity = 1;
+	return (ata_qc_issue_prot(qc));
+}
 static void nv_ck804_host_stop(struct ata_host_set *host_set)
 {
+	struct nv_host *host = host_set->private_data;
 	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 	u8 regval;
 
 	/* disable SATA space for CK804 */
+	nv_sgpio_host_cleanup(host);
 	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
 	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
 	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
@@ -581,6 +827,277 @@
 	ata_pci_host_stop(host_set);
 }
 
+static void nv_host_stop (struct ata_host_set *host_set)
+{
+	struct nv_host *host = host_set->private_data;
+
+
+	nv_sgpio_host_cleanup(host);
+	kfree(host);
+	ata_pci_host_stop(host_set);
+
+}
+
+static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host *phost)
+{
+	u16 csr_add; 
+	u32 cb_add, temp32;
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	u8 pro=0;
+	
+	pci_read_config_word(pdev, NV_SGPIO_PCI_CSR_OFFSET, &csr_add);
+	pci_read_config_dword(pdev, NV_SGPIO_PCI_CB_OFFSET, &cb_add);
+	pci_read_config_byte(pdev, 0xA4, &pro);
+	
+	if (csr_add == 0 || cb_add == 0)
+		return;
+	
+	if (!(pro&0x40))
+		return;	
+		
+	temp32 = csr_add;
+	phost->host_sgpio.pcsr = (void *)temp32;
+	phost->host_sgpio.pcb = phys_to_virt(cb_add);
+
+	if (phost->host_sgpio.pcb->nvcr.bit.init_cnt!=0x2 ||
phost->host_sgpio.pcb->nvcr.bit.cbver!=0x0)
+		return;
+		
+	if (temp32 <=0x200 || temp32 >=0xFFFE )
+		return;
+		
+	if (cb_add<=0x80000 || cb_add>=0x9FC00)
+		return;
+	
+	if (phost->host_sgpio.pcb->scratch_space == 0) {
+		spin_lock_init(&nv_sgpio_lock);
+		phost->host_sgpio.share.plock = &nv_sgpio_lock;
+		phost->host_sgpio.share.ptstamp = &nv_sgpio_tstamp;
+		phost->host_sgpio.pcb->scratch_space = 
+			(unsigned long)&phost->host_sgpio.share;
+		spin_lock(phost->host_sgpio.share.plock);
+		nv_sgpio_reset(phost->host_sgpio.pcsr);
+		phost->host_sgpio.pcb->cr0 = 
+			SET_ENABLE(phost->host_sgpio.pcb->cr0);
+
+		spin_unlock(phost->host_sgpio.share.plock);
+	}
+
+	phost->host_sgpio.share = 
+		*(struct nv_sgpio_host_share *)(unsigned long)
+		phost->host_sgpio.pcb->scratch_space;
+	phost->host_sgpio.flags.sgpio_enabled = 1;
+
+	init_timer(&phost->host_sgpio.sgpio_timer);
+	phost->host_sgpio.sgpio_timer.data = (unsigned long)host_set;
+	nv_sgpio_set_timer(&phost->host_sgpio.sgpio_timer, 
+				NV_SGPIO_UPDATE_TICK);
+}
+
+static void nv_sgpio_set_timer(struct timer_list *ptimer, unsigned int
timeout_msec)
+{
+	if (!ptimer)
+		return;
+	ptimer->function = nv_sgpio_timer_handler;
+	ptimer->expires = msecs_to_jiffies(timeout_msec) + jiffies;
+	add_timer(ptimer);
+}
+
+static void nv_sgpio_timer_handler(unsigned long context)
+{
+
+	struct ata_host_set *host_set = (struct ata_host_set *)context;
+	struct nv_host *host;
+	u8 count, host_offset, port_offset;
+	union nv_sgpio_tx tx;
+	bool on_off;
+	unsigned long mask = 0xFFFF;
+	struct nv_port *port;
+
+	if (!host_set)
+		goto err_out;
+	else 
+		host = (struct nv_host *)host_set->private_data;
+
+	if (!host->host_sgpio.flags.sgpio_enabled)
+		goto err_out;
+
+	host_offset = nv_sgpio_tx_host_offset(host_set);
+
+	spin_lock(host->host_sgpio.share.plock);
+	tx = host->host_sgpio.pcb->tx[host_offset];
+	spin_unlock(host->host_sgpio.share.plock);
+
+	for (count = 0; count < host_set->n_ports; count++) {
+		struct ata_port *ap; 
+
+		ap = host_set->ports[count];
+	
+		if (!(ap && !(ap->flags & ATA_FLAG_DISABLED)))
+			continue;
+
+		port = (struct nv_port *)ap->private_data;
+		if (!port)
+			continue;            		
+		port_offset = nv_sgpio_tx_port_offset(ap);
+		on_off = GET_ACTIVITY(tx.tx_port[port_offset]);
+		if (nv_sgpio_update_led(&port->port_sgpio.activity,
&on_off)) {
+			tx.tx_port[port_offset] = 
+				SET_ACTIVITY(tx.tx_port[port_offset],
on_off);
+			host->host_sgpio.flags.need_update = 1;
+	       }
+	}
+
+
+	if (host->host_sgpio.flags.need_update) {
+		spin_lock(host->host_sgpio.share.plock);    
+		if (nv_sgpio_get_func(host_set) 
+			% NV_CNTRLR_SHARE_INIT == 0) {
+			host->host_sgpio.pcb->tx[host_offset].all &=
mask;
+			mask = mask << 16;
+			tx.all &= mask;
+		} else {
+			tx.all &= mask;
+			mask = mask << 16;
+			host->host_sgpio.pcb->tx[host_offset].all &=
mask;
+		}
+		host->host_sgpio.pcb->tx[host_offset].all |= tx.all;
+		spin_unlock(host->host_sgpio.share.plock);     
+ 
+		if (nv_sgpio_send_cmd(host, NV_SGPIO_CMD_WRITE_DATA)) { 
+			host->host_sgpio.flags.need_update = 0;
+			return;
+		}
+	} else {
+		nv_sgpio_set_timer(&host->host_sgpio.sgpio_timer, 
+				NV_SGPIO_UPDATE_TICK);
+	}
+err_out:
+	return;
+}
+
+static bool nv_sgpio_send_cmd(struct nv_host *host, u8 cmd)
+{
+	u8 csr;
+	unsigned long *ptstamp;
+
+	spin_lock(host->host_sgpio.share.plock);    
+	ptstamp = host->host_sgpio.share.ptstamp;
+	if (jiffies_to_msecs(jiffies - *ptstamp) >=
NV_SGPIO_MIN_UPDATE_DELTA) {
+		csr = nv_sgpio_get_csr((unsigned
long)host->host_sgpio.pcsr);
+		if ((GET_SGPIO_STATUS(csr) !=
NV_SGPIO_STATE_OPERATIONAL) ||
+			(GET_CMD_STATUS(csr) == NV_SGPIO_CMD_ACTIVE)) {
+			
+		} else {
+			host->host_sgpio.pcb->cr0 = 
+				SET_ENABLE(host->host_sgpio.pcb->cr0);
+			csr = 0;
+			csr = SET_CMD(csr, cmd);
+			nv_sgpio_set_csr(csr, 
+				(unsigned long)host->host_sgpio.pcsr);
+			*ptstamp = jiffies;
+		}
+		spin_unlock(host->host_sgpio.share.plock);
+		nv_sgpio_set_timer(&host->host_sgpio.sgpio_timer, 
+			NV_SGPIO_UPDATE_TICK);
+		return 1;
+	} else {
+		spin_unlock(host->host_sgpio.share.plock);
+		nv_sgpio_set_timer(&host->host_sgpio.sgpio_timer, 
+				(NV_SGPIO_MIN_UPDATE_DELTA - 
+				jiffies_to_msecs(jiffies - *ptstamp)));
+		return 0;
+	}
+}
+
+static bool nv_sgpio_update_led(struct nv_sgpio_led *led, bool *on_off)
+{
+	bool need_update = 0;
+
+	if (led->force_off > 0) {
+		led->force_off--;
+	} else if (led->flags.recent_activity ^ led->flags.last_state) {
+		*on_off = led->flags.recent_activity;
+		led->flags.last_state = led->flags.recent_activity;
+		need_update = 1;
+	} else if ((led->flags.recent_activity & led->flags.last_state)
&&
+		(led->last_cons_active >= NV_SGPIO_MAX_ACTIVITY_ON)) {
+		*on_off = NV_OFF;
+		led->flags.last_state = NV_OFF;
+		led->force_off = NV_SGPIO_MIN_FORCE_OFF;
+		need_update = 1;
+	}
+
+	if (*on_off) 
+		led->last_cons_active++;	
+	else
+		led->last_cons_active = 0;
+
+	led->flags.recent_activity = 0;
+	return need_update;
+}
+
+static void nv_sgpio_reset(u8  *pcsr)
+{
+	u8 csr;
+
+	csr = nv_sgpio_get_csr((unsigned long)pcsr);
+	if (GET_SGPIO_STATUS(csr) == NV_SGPIO_STATE_RESET) {
+		csr = 0;
+		csr = SET_CMD(csr, NV_SGPIO_CMD_RESET);
+		nv_sgpio_set_csr(csr, (unsigned long)pcsr);
+	}
+	csr = 0;
+	csr = SET_CMD(csr, NV_SGPIO_CMD_READ_PARAMS);
+	nv_sgpio_set_csr(csr, (unsigned long)pcsr);
+}
+
+static void nv_sgpio_host_cleanup(struct nv_host *host)
+{
+	u8 csr;
+
+	if (!host)
+		return;
+
+	if (host->host_sgpio.flags.sgpio_enabled) {
+		spin_lock(host->host_sgpio.share.plock);
+		host->host_sgpio.pcb->cr0 =
SET_ENABLE(host->host_sgpio.pcb->cr0);
+		csr = 0;
+		csr = SET_CMD(csr, NV_SGPIO_CMD_WRITE_DATA);
+		nv_sgpio_set_csr(csr,(unsigned
long)host->host_sgpio.pcsr);
+		spin_unlock(host->host_sgpio.share.plock);
+
+		if (timer_pending(&host->host_sgpio.sgpio_timer))
+			del_timer(&host->host_sgpio.sgpio_timer);
+		host->host_sgpio.flags.sgpio_enabled = 0;
+		host->host_sgpio.pcb->scratch_space = 0;
+	}
+}
+
+static void nv_sgpio_clear_all_leds(struct ata_port *ap)
+{
+	struct nv_port *port = ap->private_data;
+	struct nv_host *host;
+	u8 host_offset, port_offset;
+
+	if (!port || !ap->host_set)
+		return;
+	if (!ap->host_set->private_data)
+		return;
+
+	host = ap->host_set->private_data;
+	if (!host->host_sgpio.flags.sgpio_enabled)
+		return;
+
+	host_offset = nv_sgpio_tx_host_offset(ap->host_set);
+	port_offset = nv_sgpio_tx_port_offset(ap);
+
+	spin_lock(host->host_sgpio.share.plock);
+	host->host_sgpio.pcb->tx[host_offset].tx_port[port_offset] = 0;
+	host->host_sgpio.flags.need_update = 1;
+	spin_unlock(host->host_sgpio.share.plock);
+}
+
 static int __init nv_init(void)
 {
 	return pci_module_init(&nv_pci_driver);

Best Regards,

Kuan luo
MCP Driver - Shanghai ZPK
Tel: 86 21 61041936
kluo@nvidia.com

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

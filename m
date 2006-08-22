Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWHVBR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWHVBR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 21:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWHVBR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 21:17:28 -0400
Received: from z06.nvidia.com ([209.213.198.25]:48243 "EHLO daphne.nvidia.com")
	by vger.kernel.org with ESMTP id S1751038AbWHVBR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 21:17:27 -0400
Subject: [PATCH] Sgpio support in sata_nv
From: Prajakta Gudadhe <pgudadhe@nvidia.com>
To: jeff@garzik.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 21 Aug 2006 18:17:06 -0700
Message-Id: <1156209426.2840.15.camel@dhcp-172-16-174-114.nvidia.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
Added support for enclosure management via SGPIO to sata_nv. This patch is based off of kernel-2.6.17.9.

Signed-off by: Prajakta Gudadhe <pgudadhe@nvidia.com>


--- linux-2.6.16.18/drivers/scsi/sata_nv.c.orig	2006-01-14 02:57:09.000000000 -0500
+++ linux-2.6.16.18/drivers/scsi/sata_nv.c	2006-01-23 20:12:09.000000000 -0500
@@ -70,6 +70,7 @@
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
+#include <linux/types.h>
 
 #define DRV_NAME			"sata_nv"
 #define DRV_VERSION			"0.8"
@@ -122,12 +123,46 @@
 #define NV_MCP_SATA_CFG_20		0x50
 #define NV_MCP_SATA_CFG_20_SATA_SPACE_EN	0x04
 
+// SGPIO defines
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
+#define	NV_SGPIO_UPDATE_TICK		90
+#define NV_SGPIO_MIN_UPDATE_DELTA	33
+#define NV_CNTRLR_SHARE_INIT		2
+#define NV_SGPIO_MAX_ACTIVITY_ON	20
+#define NV_SGPIO_MIN_FORCE_OFF		5
+#define NV_SGPIO_PCI_CSR_OFFSET		0x58
+#define NV_SGPIO_PCI_CB_OFFSET		0x5C
+#define NV_SGPIO_DFLT_CB_SIZE		256
+#define NV_ON	1
+#define NV_OFF	0
+#ifndef bool
+#define bool u8
+#endif
+
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
 				 struct pt_regs *regs);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void nv_host_stop (struct ata_host_set *host_set);
+static int nv_port_start(struct ata_port *ap);
+static void nv_port_stop(struct ata_port *ap);
+static int nv_qc_issue(struct ata_queued_cmd *qc);
 static void nv_enable_hotplug(struct ata_probe_ent *probe_ent);
 static void nv_disable_hotplug(struct ata_host_set *host_set);
 static int nv_check_hotplug(struct ata_host_set *host_set);
@@ -135,6 +170,177 @@ static void nv_enable_hotplug_ck804(stru
 static void nv_disable_hotplug_ck804(struct ata_host_set *host_set);
 static int nv_check_hotplug_ck804(struct ata_host_set *host_set);
 
+union nv_sgpio_csr
+{
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		u8	sgpio_status:2;
+		u8	sgpio_seq:1;
+		u8	cmd_status:2;
+		u8	cmd:3;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		u8	cmd:3;
+		u8	cmd_status:2;
+		u8	sgpio_seq:1;
+		u8	sgpio_status:2;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	} bit;
+	u8	all;
+};
+
+union nv_sgpio_cr0
+{
+	struct {
+		u8	rsvd;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		u8	ver:4;
+		u8	rsvd1:4;
+		u8	rsvd2:7;
+		u8	enable:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		u8	enable:1;
+		u8	rsvd2:7;
+		u8	rsvd1:4;
+		u8	ver:4;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+		u8	drv_cnt;
+	} bit;
+	u32		all;
+};
+
+union nv_sgpio_tx_port
+{
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		u8	rsvd:5;
+		u8	activity:3;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		u8	activity:3;
+		u8	rsvd:5;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	} bit;
+	u8	all;
+};
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
+	struct {
+		union nv_sgpio_tx_port	tx_port[4];
+	} bit;
+	u32	all;
+};
+
+struct nv_sgpio_cb
+{
+	u64			scratch_space;
+	union nv_sgpio_nvcr	nvcr;
+	union nv_sgpio_cr0	cr0;
+	u32			rsvd[4];
+	union nv_sgpio_tx	tx[2];
+};
+
+struct nv_sgpio_host_share
+{
+	spinlock_t	*plock;
+	unsigned long	*ptstamp;
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
+	union nv_sgpio_csr		*pcsr;
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
+	u8				last_cons_active;
+};
+
+struct nv_port_sgpio
+{
+	struct nv_sgpio_led		activity;
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
+
 enum nv_host_type
 {
 	GENERIC,
@@ -215,8 +421,25 @@ struct nv_host
 {
 	struct nv_host_desc	*host_desc;
 	unsigned long		host_flags;
+	struct nv_host_sgpio	host_sgpio;
 };
 
+struct nv_port
+{
+    	struct nv_port_sgpio	port_sgpio;
+};
+
+// SGPIO function prototypes
+static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host *phost);
+static void nv_sgpio_reset(union nv_sgpio_csr *pcsr);
+static void nv_sgpio_set_timer(struct timer_list *ptimer, 
+				unsigned int timeout_msec);
+static void nv_sgpio_timer_handler(unsigned long ptr);
+static void nv_sgpio_host_cleanup(struct nv_host *host);
+static bool nv_sgpio_update_led(struct nv_sgpio_led *led, bool *on_off);
+static void nv_sgpio_clear_all_leds(struct ata_port *ap);
+static bool nv_sgpio_send_cmd(struct nv_host *host, u8 cmd);
+
 static struct pci_driver nv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
@@ -256,14 +479,14 @@ static const struct ata_port_operations 
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.qc_issue		= nv_qc_issue,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= nv_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
+	.port_start		= nv_port_start,
+	.port_stop		= nv_port_stop,
 	.host_stop		= nv_host_stop,
 };
 
@@ -368,6 +591,8 @@ static void nv_host_stop (struct ata_hos
 	if (host->host_desc->disable_hotplug)
 		host->host_desc->disable_hotplug(host_set);
 
+	nv_sgpio_host_cleanup(host);
+
 	kfree(host);
 
 	if (host_set->mmio_base)
@@ -459,6 +684,9 @@ static int nv_init_one (struct pci_dev *
 	if (rc != NV_PORTS)
 		goto err_out_iounmap;
 
+    	if (nv_sgpio_capable(ent))
+		nv_sgpio_init(pdev, host);
+
 	// Enable hotplug event interrupts.
 	if (host->host_desc->enable_hotplug)
 		host->host_desc->enable_hotplug(probe_ent);
@@ -483,6 +711,49 @@ err_out:
 	return rc;
 }
 
+static int nv_port_start(struct ata_port *ap)
+{
+	int stat;
+    	struct nv_port *port;
+
+    	stat = ata_port_start(ap);
+    	if (stat) {
+        	return stat;
+    	}
+
+    	port = kmalloc(sizeof(struct nv_port), GFP_KERNEL);
+    	if (!port) 
+		goto err_out_no_free;
+
+	memset(port, 0, sizeof(struct nv_port));
+
+    	ap->private_data = port;
+    	return 0;
+
+err_out_no_free:
+    	return 1;
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
+
 static void nv_enable_hotplug(struct ata_probe_ent *probe_ent)
 {
 	u8 intr_mask;
@@ -606,6 +877,238 @@ static int nv_check_hotplug_ck804(struct
 	return 0;
 }
 
+static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host *phost)
+{
+    	u16 csr_add; 
+	u32 cb_add, temp32;
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+
+	pci_read_config_word(pdev, NV_SGPIO_PCI_CSR_OFFSET, &csr_add);
+	pci_read_config_dword(pdev, NV_SGPIO_PCI_CB_OFFSET, &cb_add);
+    	if (csr_add == 0 || cb_add == 0) {
+        	return;
+    	}
+
+	temp32 = csr_add;
+    	phost->host_sgpio.pcsr = (union nv_sgpio_csr *)temp32;
+    	phost->host_sgpio.pcb = phys_to_virt(cb_add);
+
+    	if (phost->host_sgpio.pcb->scratch_space == 0) {
+        	spin_lock_init(&nv_sgpio_lock);
+        	phost->host_sgpio.share.plock = &nv_sgpio_lock;
+        	phost->host_sgpio.share.ptstamp = &nv_sgpio_tstamp;
+		phost->host_sgpio.pcb->scratch_space = 
+			(unsigned long)&phost->host_sgpio.share;
+        	spin_lock(phost->host_sgpio.share.plock);
+        	nv_sgpio_reset(phost->host_sgpio.pcsr);
+        	phost->host_sgpio.pcb->cr0.bit.enable = 1;
+		spin_unlock(phost->host_sgpio.share.plock);
+    	}
+
+    	phost->host_sgpio.share = 
+		*(struct nv_sgpio_host_share *)(unsigned long)
+		phost->host_sgpio.pcb->scratch_space;
+    	phost->host_sgpio.flags.sgpio_enabled = 1;
+
+    	init_timer(&phost->host_sgpio.sgpio_timer);
+    	phost->host_sgpio.sgpio_timer.data = (unsigned long)host_set;
+    	nv_sgpio_set_timer(&phost->host_sgpio.sgpio_timer, 
+				NV_SGPIO_UPDATE_TICK);
+}
+
+static void nv_sgpio_set_timer(struct timer_list *ptimer, unsigned int timeout_msec)
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
+    	struct ata_host_set *host_set = (struct ata_host_set *)context;
+    	struct nv_host *host;
+    	u8 count, host_offset, port_offset;
+    	union nv_sgpio_tx tx;
+    	bool on_off;
+    	unsigned long mask = 0xFFFF;
+	struct nv_port *port;
+
+    	if (!host_set)
+		goto err_out;
+	else 
+		host = (struct nv_host *)host_set->private_data;
+
+	if (!host->host_sgpio.flags.sgpio_enabled)
+	        goto err_out;
+
+	host_offset = nv_sgpio_tx_host_offset(host_set);
+
+    	spin_lock(host->host_sgpio.share.plock);
+    	tx = host->host_sgpio.pcb->tx[host_offset];
+    	spin_unlock(host->host_sgpio.share.plock);
+
+    	for (count = 0; count < host_set->n_ports; count++) {
+        	struct ata_port *ap; 
+
+        	ap = host_set->ports[count];
+        
+        	if (!(ap && !(ap->flags & ATA_FLAG_PORT_DISABLED)))
+			continue;
+
+            	port = (struct nv_port *)ap->private_data;
+		if (!port)
+			continue;            		
+                port_offset = nv_sgpio_tx_port_offset(ap);
+	        on_off = tx.bit.tx_port[port_offset].bit.activity;
+         	if (nv_sgpio_update_led(&port->port_sgpio.activity, &on_off)) {
+                    	tx.bit.tx_port[port_offset].bit.activity = on_off;
+                    	host->host_sgpio.flags.need_update = 1;
+                }
+    	}
+
+
+	if (host->host_sgpio.flags.need_update) {
+		spin_lock(host->host_sgpio.share.plock);    
+        	if (nv_sgpio_get_func(host_set) 
+			% NV_CNTRLR_SHARE_INIT == 0) {
+            		host->host_sgpio.pcb->tx[host_offset].all &= mask;
+            		mask = mask << 16;
+            		tx.all &= mask;
+        	} else {
+            		tx.all &= mask;
+            		mask = mask << 16;
+            		host->host_sgpio.pcb->tx[host_offset].all &= mask;
+        	}
+        	host->host_sgpio.pcb->tx[host_offset].all |= tx.all;
+		spin_unlock(host->host_sgpio.share.plock);     
+ 
+		if (nv_sgpio_send_cmd(host, NV_SGPIO_CMD_WRITE_DATA)) { 
+                	host->host_sgpio.flags.need_update = 0;
+			return;
+		}
+    	} else {
+    		nv_sgpio_set_timer(&host->host_sgpio.sgpio_timer, 
+				NV_SGPIO_UPDATE_TICK);
+	}
+err_out:
+	return;
+}
+
+static bool nv_sgpio_send_cmd(struct nv_host *host, u8 cmd)
+{
+	union nv_sgpio_csr csr;
+	unsigned long *ptstamp;
+
+	spin_lock(host->host_sgpio.share.plock);    
+	ptstamp = host->host_sgpio.share.ptstamp;
+	if (jiffies_to_msecs(jiffies - *ptstamp) >= NV_SGPIO_MIN_UPDATE_DELTA) {
+		csr.all = 
+		nv_sgpio_get_csr((unsigned long)host->host_sgpio.pcsr);
+		if ((csr.bit.sgpio_status != NV_SGPIO_STATE_OPERATIONAL) ||
+			(csr.bit.cmd_status == NV_SGPIO_CMD_ACTIVE)) {
+			//nv_sgpio_reset(host->host_sgpio.pcsr);
+		} else {
+			host->host_sgpio.pcb->cr0.bit.enable = 1;
+			csr.all = 0;
+			csr.bit.cmd = cmd;
+			nv_sgpio_set_csr(csr.all, 
+				(unsigned long)host->host_sgpio.pcsr);
+			*ptstamp = jiffies;
+		}
+		spin_unlock(host->host_sgpio.share.plock);
+		nv_sgpio_set_timer(&host->host_sgpio.sgpio_timer, 
+			NV_SGPIO_UPDATE_TICK);
+        	return 1;
+	} else {
+		spin_unlock(host->host_sgpio.share.plock);
+		nv_sgpio_set_timer(&host->host_sgpio.sgpio_timer, 
+				(NV_SGPIO_MIN_UPDATE_DELTA - 
+				jiffies_to_msecs(jiffies - *ptstamp)));
+		return 0;
+    	}
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
+	} else if ((led->flags.recent_activity & led->flags.last_state) &&
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
+static void nv_sgpio_reset(union nv_sgpio_csr *pcsr)
+{
+	union nv_sgpio_csr csr;
+
+	csr.all = nv_sgpio_get_csr((unsigned long)pcsr);
+	if (csr.bit.sgpio_status == NV_SGPIO_STATE_RESET) {
+		csr.all = 0;
+		csr.bit.cmd = NV_SGPIO_CMD_RESET;
+		nv_sgpio_set_csr(csr.all, (unsigned long)pcsr);
+	}
+	csr.all = 0;
+	csr.bit.cmd = NV_SGPIO_CMD_READ_PARAMS;
+	nv_sgpio_set_csr(csr.all, (unsigned long)pcsr);
+}
+
+static void nv_sgpio_host_cleanup(struct nv_host *host)
+{
+	if (!host)
+		return;
+
+	if (host->host_sgpio.flags.sgpio_enabled) {
+		if (timer_pending(&host->host_sgpio.sgpio_timer))
+			del_timer(&host->host_sgpio.sgpio_timer);
+		host->host_sgpio.flags.sgpio_enabled = 0;
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
+	spin_lock(host->host_sgpio.share.plock);
+	host->host_sgpio.pcb->tx[host_offset].bit.tx_port[port_offset].all = 0;
+	host->host_sgpio.flags.need_update = 1;
+	spin_unlock(host->host_sgpio.share.plock);
+}
+
 static int __init nv_init(void)
 {
 	return pci_module_init(&nv_pci_driver);



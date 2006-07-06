Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWGFDHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWGFDHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWGFDHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:07:30 -0400
Received: from havoc.gtf.org ([69.61.125.42]:55715 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965143AbWGFDH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:07:27 -0400
Date: Wed, 5 Jul 2006 23:07:25 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata update
Message-ID: <20060706030725.GA30631@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/scsi/ahci.c        |   17 +
 drivers/scsi/libata-core.c |  289 ++++++++++++++++++++------------
 drivers/scsi/libata-eh.c   |  405 +++++++++++++++++++++++++++++++++++++++------
 drivers/scsi/libata-scsi.c |  124 +++++++++++++
 drivers/scsi/sata_sil.c    |  105 +++++++----
 drivers/scsi/sata_sil24.c  |  134 +++++++++-----
 drivers/scsi/sata_vsc.c    |    2 
 include/linux/libata.h     |   85 +++++++--
 include/linux/pci_ids.h    |    7 
 9 files changed, 897 insertions(+), 271 deletions(-)

Borislav Petkov:
      libata-core.c: restore configuration boot messages in ata_dev_configure(), v2

Brian King:
      libata: Conditionally set host->max_cmd_len

Jeff Garzik:
      [PCI] Add JMicron PCI ID constants

Martin Hicks:
      sata_vsc: data_xfer should use mmio

root:
      ahci: Ensure that we don't grab both functions

Tejun Heo:
      libata: add ap->pflags and move core dynamic flags to it
      libata: fix ehc->i.action setting in ata_eh_autopsy()
      libata: replace ap_lock w/ ap->lock in ata_scsi_error()
      libata: implement ATA_EHI_RESUME_LINK
      libata: clean up debounce parameters and improve parameter selection
      libata: implement ATA_EHI_NO_AUTOPSY and QUIET
      libata: separate out __ata_ehi_hotplugged()
      libata: implement PM EH actions
      libata: reimplement per-dev PM
      libata: reimplement controller-wide PM
      sata_sil: separate out sil_init_controller()
      sata_sil: add suspend/sleep support
      sata_sil24: separate out sil24_init_controller()
      sata_sil24: add suspend/sleep support

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 15f6cd4..77e7202 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1052,7 +1052,7 @@ static void ahci_thaw(struct ata_port *a
 
 static void ahci_error_handler(struct ata_port *ap)
 {
-	if (!(ap->flags & ATA_FLAG_FROZEN)) {
+	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
 		ahci_stop_engine(ap);
 		ahci_start_engine(ap);
@@ -1323,6 +1323,17 @@ static int ahci_init_one (struct pci_dev
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* JMicron-specific fixup: make sure we're in AHCI mode */
+	/* This is protected from races with ata_jmicron by the pci probe
+	   locking */
+	if (pdev->vendor == PCI_VENDOR_ID_JMICRON) {
+		/* AHCI enable, AHCI on function 0 */
+		pci_write_config_byte(pdev, 0x41, 0xa1);
+		/* Function 1 is the PATA controller */
+		if (PCI_FUNC(pdev->devfn))
+			return -ENODEV;
+	}
+
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -1378,10 +1389,6 @@ static int ahci_init_one (struct pci_dev
 	if (have_msi)
 		hpriv->flags |= AHCI_FLAG_MSI;
 
-	/* JMicron-specific fixup: make sure we're in AHCI mode */
-	if (pdev->vendor == 0x197b)
-		pci_write_config_byte(pdev, 0x41, 0xa1);
-
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1c960ac..386e5f2 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -61,9 +61,9 @@ #include <asm/byteorder.h>
 #include "libata.h"
 
 /* debounce timing parameters in msecs { interval, duration, timeout } */
-const unsigned long sata_deb_timing_boot[]		= {   5,  100, 2000 };
-const unsigned long sata_deb_timing_eh[]		= {  25,  500, 2000 };
-const unsigned long sata_deb_timing_before_fsrst[]	= { 100, 2000, 5000 };
+const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
+const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
+const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
@@ -907,7 +907,7 @@ void ata_port_queue_task(struct ata_port
 {
 	int rc;
 
-	if (ap->flags & ATA_FLAG_FLUSH_PORT_TASK)
+	if (ap->pflags & ATA_PFLAG_FLUSH_PORT_TASK)
 		return;
 
 	PREPARE_WORK(&ap->port_task, fn, data);
@@ -938,7 +938,7 @@ void ata_port_flush_task(struct ata_port
 	DPRINTK("ENTER\n");
 
 	spin_lock_irqsave(ap->lock, flags);
-	ap->flags |= ATA_FLAG_FLUSH_PORT_TASK;
+	ap->pflags |= ATA_PFLAG_FLUSH_PORT_TASK;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	DPRINTK("flush #1\n");
@@ -957,7 +957,7 @@ void ata_port_flush_task(struct ata_port
 	}
 
 	spin_lock_irqsave(ap->lock, flags);
-	ap->flags &= ~ATA_FLAG_FLUSH_PORT_TASK;
+	ap->pflags &= ~ATA_PFLAG_FLUSH_PORT_TASK;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	if (ata_msg_ctl(ap))
@@ -1009,7 +1009,7 @@ unsigned ata_exec_internal(struct ata_de
 	spin_lock_irqsave(ap->lock, flags);
 
 	/* no internal command while frozen */
-	if (ap->flags & ATA_FLAG_FROZEN) {
+	if (ap->pflags & ATA_PFLAG_FROZEN) {
 		spin_unlock_irqrestore(ap->lock, flags);
 		return AC_ERR_SYSTEM;
 	}
@@ -1325,6 +1325,19 @@ static void ata_dev_config_ncq(struct at
 		snprintf(desc, desc_sz, "NCQ (depth %d/%d)", hdepth, ddepth);
 }
 
+static void ata_set_port_max_cmd_len(struct ata_port *ap)
+{
+	int i;
+
+	if (ap->host) {
+		ap->host->max_cmd_len = 0;
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			ap->host->max_cmd_len = max_t(unsigned int,
+						      ap->host->max_cmd_len,
+						      ap->device[i].cdb_len);
+	}
+}
+
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@dev: Target device to configure
@@ -1344,7 +1357,7 @@ int ata_dev_configure(struct ata_device 
 	struct ata_port *ap = dev->ap;
 	const u16 *id = dev->id;
 	unsigned int xfer_mask;
-	int i, rc;
+	int rc;
 
 	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
 		ata_dev_printk(dev, KERN_INFO,
@@ -1404,7 +1417,7 @@ int ata_dev_configure(struct ata_device 
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
 
 			/* print device info to dmesg */
-			if (ata_msg_info(ap))
+			if (ata_msg_drv(ap) && print_info)
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: %s %s\n",
 					ata_id_major_version(id),
@@ -1427,7 +1440,7 @@ int ata_dev_configure(struct ata_device 
 			}
 
 			/* print device info to dmesg */
-			if (ata_msg_info(ap))
+			if (ata_msg_drv(ap) && print_info)
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: CHS %u/%u/%u\n",
 					ata_id_major_version(id),
@@ -1439,7 +1452,7 @@ int ata_dev_configure(struct ata_device 
 
 		if (dev->id[59] & 0x100) {
 			dev->multi_count = dev->id[59] & 0xff;
-			if (ata_msg_info(ap))
+			if (ata_msg_drv(ap) && print_info)
 				ata_dev_printk(dev, KERN_INFO,
 					"ata%u: dev %u multi count %u\n",
 					ap->id, dev->devno, dev->multi_count);
@@ -1468,21 +1481,17 @@ int ata_dev_configure(struct ata_device 
 		}
 
 		/* print device info to dmesg */
-		if (ata_msg_info(ap))
+		if (ata_msg_drv(ap) && print_info)
 			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
 				       ata_mode_string(xfer_mask),
 				       cdb_intr_string);
 	}
 
-	ap->host->max_cmd_len = 0;
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->host->max_cmd_len = max_t(unsigned int,
-					      ap->host->max_cmd_len,
-					      ap->device[i].cdb_len);
+	ata_set_port_max_cmd_len(ap);
 
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
-		if (ata_msg_info(ap))
+		if (ata_msg_drv(ap) && print_info)
 			ata_dev_printk(dev, KERN_INFO,
 				       "applying bridge limits\n");
 		dev->udma_mask &= ATA_UDMA5;
@@ -2137,7 +2146,7 @@ int ata_set_mode(struct ata_port *ap, st
 		 * return error code and failing device on failure.
 		 */
 		for (i = 0; i < ATA_MAX_DEVICES; i++) {
-			if (ata_dev_enabled(&ap->device[i])) {
+			if (ata_dev_ready(&ap->device[i])) {
 				ap->ops->set_mode(ap);
 				break;
 			}
@@ -2203,7 +2212,8 @@ int ata_set_mode(struct ata_port *ap, st
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		dev = &ap->device[i];
 
-		if (!ata_dev_enabled(dev))
+		/* don't udpate suspended devices' xfer mode */
+		if (!ata_dev_ready(dev))
 			continue;
 
 		rc = ata_dev_set_mode(dev);
@@ -2579,7 +2589,7 @@ static void ata_wait_spinup(struct ata_p
 
 	/* first, debounce phy if SATA */
 	if (ap->cbl == ATA_CBL_SATA) {
-		rc = sata_phy_debounce(ap, sata_deb_timing_eh);
+		rc = sata_phy_debounce(ap, sata_deb_timing_hotplug);
 
 		/* if debounced successfully and offline, no need to wait */
 		if ((rc == 0 || rc == -EOPNOTSUPP) && ata_port_offline(ap))
@@ -2615,16 +2625,17 @@ static void ata_wait_spinup(struct ata_p
 int ata_std_prereset(struct ata_port *ap)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
-	const unsigned long *timing;
+	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
 
-	/* hotplug? */
-	if (ehc->i.flags & ATA_EHI_HOTPLUGGED) {
-		if (ap->flags & ATA_FLAG_HRST_TO_RESUME)
-			ehc->i.action |= ATA_EH_HARDRESET;
-		if (ap->flags & ATA_FLAG_SKIP_D2H_BSY)
-			ata_wait_spinup(ap);
-	}
+	/* handle link resume & hotplug spinup */
+	if ((ehc->i.flags & ATA_EHI_RESUME_LINK) &&
+	    (ap->flags & ATA_FLAG_HRST_TO_RESUME))
+		ehc->i.action |= ATA_EH_HARDRESET;
+
+	if ((ehc->i.flags & ATA_EHI_HOTPLUGGED) &&
+	    (ap->flags & ATA_FLAG_SKIP_D2H_BSY))
+		ata_wait_spinup(ap);
 
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
@@ -2632,11 +2643,6 @@ int ata_std_prereset(struct ata_port *ap
 
 	/* if SATA, resume phy */
 	if (ap->cbl == ATA_CBL_SATA) {
-		if (ap->flags & ATA_FLAG_LOADING)
-			timing = sata_deb_timing_boot;
-		else
-			timing = sata_deb_timing_eh;
-
 		rc = sata_phy_resume(ap, timing);
 		if (rc && rc != -EOPNOTSUPP) {
 			/* phy resume failed */
@@ -2724,6 +2730,8 @@ int ata_std_softreset(struct ata_port *a
  */
 int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 {
+	struct ata_eh_context *ehc = &ap->eh_context;
+	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	u32 scontrol;
 	int rc;
 
@@ -2761,7 +2769,7 @@ int sata_std_hardreset(struct ata_port *
 	msleep(1);
 
 	/* bring phy back */
-	sata_phy_resume(ap, sata_deb_timing_eh);
+	sata_phy_resume(ap, timing);
 
 	/* TODO: phy layer with polling, timeouts, etc. */
 	if (ata_port_offline(ap)) {
@@ -4285,7 +4293,7 @@ static struct ata_queued_cmd *ata_qc_new
 	unsigned int i;
 
 	/* no command while frozen */
-	if (unlikely(ap->flags & ATA_FLAG_FROZEN))
+	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
 		return NULL;
 
 	/* the last tag is reserved for internal command. */
@@ -4407,7 +4415,7 @@ void ata_qc_complete(struct ata_queued_c
 	 * taken care of.
 	 */
 	if (ap->ops->error_handler) {
-		WARN_ON(ap->flags & ATA_FLAG_FROZEN);
+		WARN_ON(ap->pflags & ATA_PFLAG_FROZEN);
 
 		if (unlikely(qc->err_mask))
 			qc->flags |= ATA_QCFLAG_FAILED;
@@ -5001,86 +5009,120 @@ int ata_flush_cache(struct ata_device *d
 	return 0;
 }
 
-static int ata_standby_drive(struct ata_device *dev)
+static int ata_host_set_request_pm(struct ata_host_set *host_set,
+				   pm_message_t mesg, unsigned int action,
+				   unsigned int ehi_flags, int wait)
 {
-	unsigned int err_mask;
+	unsigned long flags;
+	int i, rc;
 
-	err_mask = ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
-	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to standby drive "
-			       "(err_mask=0x%x)\n", err_mask);
-		return -EIO;
-	}
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
 
-	return 0;
-}
+		/* Previous resume operation might still be in
+		 * progress.  Wait for PM_PENDING to clear.
+		 */
+		if (ap->pflags & ATA_PFLAG_PM_PENDING) {
+			ata_port_wait_eh(ap);
+			WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
+		}
 
-static int ata_start_drive(struct ata_device *dev)
-{
-	unsigned int err_mask;
+		/* request PM ops to EH */
+		spin_lock_irqsave(ap->lock, flags);
 
-	err_mask = ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
-	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to start drive "
-			       "(err_mask=0x%x)\n", err_mask);
-		return -EIO;
+		ap->pm_mesg = mesg;
+		if (wait) {
+			rc = 0;
+			ap->pm_result = &rc;
+		}
+
+		ap->pflags |= ATA_PFLAG_PM_PENDING;
+		ap->eh_info.action |= action;
+		ap->eh_info.flags |= ehi_flags;
+
+		ata_port_schedule_eh(ap);
+
+		spin_unlock_irqrestore(ap->lock, flags);
+
+		/* wait and check result */
+		if (wait) {
+			ata_port_wait_eh(ap);
+			WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
+			if (rc)
+				return rc;
+		}
 	}
 
 	return 0;
 }
 
 /**
- *	ata_device_resume - wakeup a previously suspended devices
- *	@dev: the device to resume
+ *	ata_host_set_suspend - suspend host_set
+ *	@host_set: host_set to suspend
+ *	@mesg: PM message
  *
- *	Kick the drive back into action, by sending it an idle immediate
- *	command and making sure its transfer mode matches between drive
- *	and host.
+ *	Suspend @host_set.  Actual operation is performed by EH.  This
+ *	function requests EH to perform PM operations and waits for EH
+ *	to finish.
  *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
  */
-int ata_device_resume(struct ata_device *dev)
+int ata_host_set_suspend(struct ata_host_set *host_set, pm_message_t mesg)
 {
-	struct ata_port *ap = dev->ap;
+	int i, j, rc;
 
-	if (ap->flags & ATA_FLAG_SUSPENDED) {
-		struct ata_device *failed_dev;
+	rc = ata_host_set_request_pm(host_set, mesg, 0, ATA_EHI_QUIET, 1);
+	if (rc)
+		goto fail;
 
-		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
-		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
+	/* EH is quiescent now.  Fail if we have any ready device.
+	 * This happens if hotplug occurs between completion of device
+	 * suspension and here.
+	 */
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
 
-		ap->flags &= ~ATA_FLAG_SUSPENDED;
-		while (ata_set_mode(ap, &failed_dev))
-			ata_dev_disable(failed_dev);
+		for (j = 0; j < ATA_MAX_DEVICES; j++) {
+			struct ata_device *dev = &ap->device[j];
+
+			if (ata_dev_ready(dev)) {
+				ata_port_printk(ap, KERN_WARNING,
+						"suspend failed, device %d "
+						"still active\n", dev->devno);
+				rc = -EBUSY;
+				goto fail;
+			}
+		}
 	}
-	if (!ata_dev_enabled(dev))
-		return 0;
-	if (dev->class == ATA_DEV_ATA)
-		ata_start_drive(dev);
 
+	host_set->dev->power.power_state = mesg;
 	return 0;
+
+ fail:
+	ata_host_set_resume(host_set);
+	return rc;
 }
 
 /**
- *	ata_device_suspend - prepare a device for suspend
- *	@dev: the device to suspend
- *	@state: target power management state
+ *	ata_host_set_resume - resume host_set
+ *	@host_set: host_set to resume
+ *
+ *	Resume @host_set.  Actual operation is performed by EH.  This
+ *	function requests EH to perform PM operations and returns.
+ *	Note that all resume operations are performed parallely.
  *
- *	Flush the cache on the drive, if appropriate, then issue a
- *	standbynow command.
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
  */
-int ata_device_suspend(struct ata_device *dev, pm_message_t state)
+void ata_host_set_resume(struct ata_host_set *host_set)
 {
-	struct ata_port *ap = dev->ap;
-
-	if (!ata_dev_enabled(dev))
-		return 0;
-	if (dev->class == ATA_DEV_ATA)
-		ata_flush_cache(dev);
-
-	if (state.event != PM_EVENT_FREEZE)
-		ata_standby_drive(dev);
-	ap->flags |= ATA_FLAG_SUSPENDED;
-	return 0;
+	ata_host_set_request_pm(host_set, PMSG_ON, ATA_EH_SOFTRESET,
+				ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET, 0);
+	host_set->dev->power.power_state = PMSG_ON;
 }
 
 /**
@@ -5440,6 +5482,7 @@ int ata_device_add(const struct ata_prob
 		}
 
 		if (ap->ops->error_handler) {
+			struct ata_eh_info *ehi = &ap->eh_info;
 			unsigned long flags;
 
 			ata_port_probe(ap);
@@ -5447,10 +5490,11 @@ int ata_device_add(const struct ata_prob
 			/* kick EH for boot probing */
 			spin_lock_irqsave(ap->lock, flags);
 
-			ap->eh_info.probe_mask = (1 << ATA_MAX_DEVICES) - 1;
-			ap->eh_info.action |= ATA_EH_SOFTRESET;
+			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
+			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
-			ap->flags |= ATA_FLAG_LOADING;
+			ap->pflags |= ATA_PFLAG_LOADING;
 			ata_port_schedule_eh(ap);
 
 			spin_unlock_irqrestore(ap->lock, flags);
@@ -5518,7 +5562,7 @@ void ata_port_detach(struct ata_port *ap
 
 	/* tell EH we're leaving & flush EH */
 	spin_lock_irqsave(ap->lock, flags);
-	ap->flags |= ATA_FLAG_UNLOADING;
+	ap->pflags |= ATA_PFLAG_UNLOADING;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	ata_port_wait_eh(ap);
@@ -5723,20 +5767,55 @@ int pci_test_config_bits(struct pci_dev 
 	return (tmp == bits->val) ? 1 : 0;
 }
 
-int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
+void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
-	return 0;
+
+	if (state.event == PM_EVENT_SUSPEND) {
+		pci_disable_device(pdev);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
 }
 
-int ata_pci_device_resume(struct pci_dev *pdev)
+void ata_pci_device_do_resume(struct pci_dev *pdev)
 {
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_enable_device(pdev);
 	pci_set_master(pdev);
+}
+
+int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+	int rc = 0;
+
+	rc = ata_host_set_suspend(host_set, state);
+	if (rc)
+		return rc;
+
+	if (host_set->next) {
+		rc = ata_host_set_suspend(host_set->next, state);
+		if (rc) {
+			ata_host_set_resume(host_set);
+			return rc;
+		}
+	}
+
+	ata_pci_device_do_suspend(pdev, state);
+
+	return 0;
+}
+
+int ata_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+
+	ata_pci_device_do_resume(pdev);
+	ata_host_set_resume(host_set);
+	if (host_set->next)
+		ata_host_set_resume(host_set->next);
+
 	return 0;
 }
 #endif /* CONFIG_PCI */
@@ -5842,9 +5921,9 @@ u32 ata_wait_register(void __iomem *reg,
  * Do not depend on ABI/API stability.
  */
 
-EXPORT_SYMBOL_GPL(sata_deb_timing_boot);
-EXPORT_SYMBOL_GPL(sata_deb_timing_eh);
-EXPORT_SYMBOL_GPL(sata_deb_timing_before_fsrst);
+EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
+EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
+EXPORT_SYMBOL_GPL(sata_deb_timing_long);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
@@ -5916,6 +5995,8 @@ EXPORT_SYMBOL_GPL(sata_scr_write);
 EXPORT_SYMBOL_GPL(sata_scr_write_flush);
 EXPORT_SYMBOL_GPL(ata_port_online);
 EXPORT_SYMBOL_GPL(ata_port_offline);
+EXPORT_SYMBOL_GPL(ata_host_set_suspend);
+EXPORT_SYMBOL_GPL(ata_host_set_resume);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
@@ -5930,14 +6011,14 @@ EXPORT_SYMBOL_GPL(ata_pci_host_stop);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
+EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
+EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
-EXPORT_SYMBOL_GPL(ata_device_suspend);
-EXPORT_SYMBOL_GPL(ata_device_resume);
 EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
 EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index bf5a72a..4b6aa30 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -47,6 +47,8 @@ #include "libata.h"
 
 static void __ata_port_freeze(struct ata_port *ap);
 static void ata_eh_finish(struct ata_port *ap);
+static void ata_eh_handle_port_suspend(struct ata_port *ap);
+static void ata_eh_handle_port_resume(struct ata_port *ap);
 
 static void ata_ering_record(struct ata_ering *ering, int is_io,
 			     unsigned int err_mask)
@@ -190,7 +192,6 @@ enum scsi_eh_timer_return ata_scsi_timed
 void ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap = ata_shost_to_port(host);
-	spinlock_t *ap_lock = ap->lock;
 	int i, repeat_cnt = ATA_EH_MAX_REPEAT;
 	unsigned long flags;
 
@@ -217,7 +218,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		struct scsi_cmnd *scmd, *tmp;
 		int nr_timedout = 0;
 
-		spin_lock_irqsave(ap_lock, flags);
+		spin_lock_irqsave(ap->lock, flags);
 
 		list_for_each_entry_safe(scmd, tmp, &host->eh_cmd_q, eh_entry) {
 			struct ata_queued_cmd *qc;
@@ -256,43 +257,49 @@ void ata_scsi_error(struct Scsi_Host *ho
 		if (nr_timedout)
 			__ata_port_freeze(ap);
 
-		spin_unlock_irqrestore(ap_lock, flags);
+		spin_unlock_irqrestore(ap->lock, flags);
 	} else
-		spin_unlock_wait(ap_lock);
+		spin_unlock_wait(ap->lock);
 
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
+		/* process port resume request */
+		ata_eh_handle_port_resume(ap);
+
 		/* fetch & clear EH info */
-		spin_lock_irqsave(ap_lock, flags);
+		spin_lock_irqsave(ap->lock, flags);
 
 		memset(&ap->eh_context, 0, sizeof(ap->eh_context));
 		ap->eh_context.i = ap->eh_info;
 		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
 
-		ap->flags |= ATA_FLAG_EH_IN_PROGRESS;
-		ap->flags &= ~ATA_FLAG_EH_PENDING;
+		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
+		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
 
-		spin_unlock_irqrestore(ap_lock, flags);
+		spin_unlock_irqrestore(ap->lock, flags);
 
-		/* invoke EH.  if unloading, just finish failed qcs */
-		if (!(ap->flags & ATA_FLAG_UNLOADING))
+		/* invoke EH, skip if unloading or suspended */
+		if (!(ap->pflags & (ATA_PFLAG_UNLOADING | ATA_PFLAG_SUSPENDED)))
 			ap->ops->error_handler(ap);
 		else
 			ata_eh_finish(ap);
 
+		/* process port suspend request */
+		ata_eh_handle_port_suspend(ap);
+
 		/* Exception might have happend after ->error_handler
 		 * recovered the port but before this point.  Repeat
 		 * EH in such case.
 		 */
-		spin_lock_irqsave(ap_lock, flags);
+		spin_lock_irqsave(ap->lock, flags);
 
-		if (ap->flags & ATA_FLAG_EH_PENDING) {
+		if (ap->pflags & ATA_PFLAG_EH_PENDING) {
 			if (--repeat_cnt) {
 				ata_port_printk(ap, KERN_INFO,
 					"EH pending after completion, "
 					"repeating EH (cnt=%d)\n", repeat_cnt);
-				spin_unlock_irqrestore(ap_lock, flags);
+				spin_unlock_irqrestore(ap->lock, flags);
 				goto repeat;
 			}
 			ata_port_printk(ap, KERN_ERR, "EH pending after %d "
@@ -302,14 +309,14 @@ void ata_scsi_error(struct Scsi_Host *ho
 		/* this run is complete, make sure EH info is clear */
 		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
 
-		/* Clear host_eh_scheduled while holding ap_lock such
+		/* Clear host_eh_scheduled while holding ap->lock such
 		 * that if exception occurs after this point but
 		 * before EH completion, SCSI midlayer will
 		 * re-initiate EH.
 		 */
 		host->host_eh_scheduled = 0;
 
-		spin_unlock_irqrestore(ap_lock, flags);
+		spin_unlock_irqrestore(ap->lock, flags);
 	} else {
 		WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
 		ap->ops->eng_timeout(ap);
@@ -321,24 +328,23 @@ void ata_scsi_error(struct Scsi_Host *ho
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
 	/* clean up */
-	spin_lock_irqsave(ap_lock, flags);
+	spin_lock_irqsave(ap->lock, flags);
 
-	if (ap->flags & ATA_FLAG_LOADING) {
-		ap->flags &= ~ATA_FLAG_LOADING;
-	} else {
-		if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
-			queue_work(ata_aux_wq, &ap->hotplug_task);
-		if (ap->flags & ATA_FLAG_RECOVERED)
-			ata_port_printk(ap, KERN_INFO, "EH complete\n");
-	}
+	if (ap->pflags & ATA_PFLAG_LOADING)
+		ap->pflags &= ~ATA_PFLAG_LOADING;
+	else if (ap->pflags & ATA_PFLAG_SCSI_HOTPLUG)
+		queue_work(ata_aux_wq, &ap->hotplug_task);
+
+	if (ap->pflags & ATA_PFLAG_RECOVERED)
+		ata_port_printk(ap, KERN_INFO, "EH complete\n");
 
-	ap->flags &= ~(ATA_FLAG_SCSI_HOTPLUG | ATA_FLAG_RECOVERED);
+	ap->pflags &= ~(ATA_PFLAG_SCSI_HOTPLUG | ATA_PFLAG_RECOVERED);
 
 	/* tell wait_eh that we're done */
-	ap->flags &= ~ATA_FLAG_EH_IN_PROGRESS;
+	ap->pflags &= ~ATA_PFLAG_EH_IN_PROGRESS;
 	wake_up_all(&ap->eh_wait_q);
 
-	spin_unlock_irqrestore(ap_lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	DPRINTK("EXIT\n");
 }
@@ -360,7 +366,7 @@ void ata_port_wait_eh(struct ata_port *a
  retry:
 	spin_lock_irqsave(ap->lock, flags);
 
-	while (ap->flags & (ATA_FLAG_EH_PENDING | ATA_FLAG_EH_IN_PROGRESS)) {
+	while (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
 		prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
 		spin_unlock_irqrestore(ap->lock, flags);
 		schedule();
@@ -489,7 +495,7 @@ void ata_qc_schedule_eh(struct ata_queue
 	WARN_ON(!ap->ops->error_handler);
 
 	qc->flags |= ATA_QCFLAG_FAILED;
-	qc->ap->flags |= ATA_FLAG_EH_PENDING;
+	qc->ap->pflags |= ATA_PFLAG_EH_PENDING;
 
 	/* The following will fail if timeout has already expired.
 	 * ata_scsi_error() takes care of such scmds on EH entry.
@@ -513,7 +519,7 @@ void ata_port_schedule_eh(struct ata_por
 {
 	WARN_ON(!ap->ops->error_handler);
 
-	ap->flags |= ATA_FLAG_EH_PENDING;
+	ap->pflags |= ATA_PFLAG_EH_PENDING;
 	scsi_schedule_eh(ap->host);
 
 	DPRINTK("port EH scheduled\n");
@@ -578,7 +584,7 @@ static void __ata_port_freeze(struct ata
 	if (ap->ops->freeze)
 		ap->ops->freeze(ap);
 
-	ap->flags |= ATA_FLAG_FROZEN;
+	ap->pflags |= ATA_PFLAG_FROZEN;
 
 	DPRINTK("ata%u port frozen\n", ap->id);
 }
@@ -646,7 +652,7 @@ void ata_eh_thaw_port(struct ata_port *a
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ap->flags &= ~ATA_FLAG_FROZEN;
+	ap->pflags &= ~ATA_PFLAG_FROZEN;
 
 	if (ap->ops->thaw)
 		ap->ops->thaw(ap);
@@ -731,7 +737,7 @@ static void ata_eh_detach_dev(struct ata
 
 	if (ata_scsi_offline_dev(dev)) {
 		dev->flags |= ATA_DFLAG_DETACHED;
-		ap->flags |= ATA_FLAG_SCSI_HOTPLUG;
+		ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
 	}
 
 	/* clear per-dev EH actions */
@@ -760,8 +766,12 @@ static void ata_eh_about_to_do(struct at
 	unsigned long flags;
 
 	spin_lock_irqsave(ap->lock, flags);
+
 	ata_eh_clear_action(dev, &ap->eh_info, action);
-	ap->flags |= ATA_FLAG_RECOVERED;
+
+	if (!(ap->eh_context.i.flags & ATA_EHI_QUIET))
+		ap->pflags |= ATA_PFLAG_RECOVERED;
+
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 
@@ -1027,7 +1037,7 @@ static void ata_eh_analyze_ncq_error(str
 	int tag, rc;
 
 	/* if frozen, we can't do much */
-	if (ap->flags & ATA_FLAG_FROZEN)
+	if (ap->pflags & ATA_PFLAG_FROZEN)
 		return;
 
 	/* is it NCQ device error? */
@@ -1275,6 +1285,9 @@ static void ata_eh_autopsy(struct ata_po
 
 	DPRINTK("ENTER\n");
 
+	if (ehc->i.flags & ATA_EHI_NO_AUTOPSY)
+		return;
+
 	/* obtain and analyze SError */
 	rc = sata_scr_read(ap, SCR_ERROR, &serror);
 	if (rc == 0) {
@@ -1327,7 +1340,7 @@ static void ata_eh_autopsy(struct ata_po
 	}
 
 	/* enforce default EH actions */
-	if (ap->flags & ATA_FLAG_FROZEN ||
+	if (ap->pflags & ATA_PFLAG_FROZEN ||
 	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
 		action |= ATA_EH_SOFTRESET;
 	else if (all_err_mask)
@@ -1346,7 +1359,7 @@ static void ata_eh_autopsy(struct ata_po
 
 	/* record autopsy result */
 	ehc->i.dev = failed_dev;
-	ehc->i.action = action;
+	ehc->i.action |= action;
 
 	DPRINTK("EXIT\n");
 }
@@ -1385,7 +1398,7 @@ static void ata_eh_report(struct ata_por
 		return;
 
 	frozen = "";
-	if (ap->flags & ATA_FLAG_FROZEN)
+	if (ap->pflags & ATA_PFLAG_FROZEN)
 		frozen = " frozen";
 
 	if (ehc->i.dev) {
@@ -1465,7 +1478,7 @@ static int ata_eh_reset(struct ata_port 
 	struct ata_eh_context *ehc = &ap->eh_context;
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
-	int verbose = !(ap->flags & ATA_FLAG_LOADING);
+	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
 	unsigned int action;
 	ata_reset_fn_t reset;
 	int i, did_followup_srst, rc;
@@ -1605,7 +1618,7 @@ static int ata_eh_revalidate_and_attach(
 		dev = &ap->device[i];
 		action = ata_eh_dev_action(dev);
 
-		if (action & ATA_EH_REVALIDATE && ata_dev_enabled(dev)) {
+		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
 			if (ata_port_offline(ap)) {
 				rc = -EIO;
 				break;
@@ -1636,7 +1649,7 @@ static int ata_eh_revalidate_and_attach(
 			}
 
 			spin_lock_irqsave(ap->lock, flags);
-			ap->flags |= ATA_FLAG_SCSI_HOTPLUG;
+			ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
 			spin_unlock_irqrestore(ap->lock, flags);
 		}
 	}
@@ -1648,6 +1661,164 @@ static int ata_eh_revalidate_and_attach(
 	return rc;
 }
 
+/**
+ *	ata_eh_suspend - handle suspend EH action
+ *	@ap: target host port
+ *	@r_failed_dev: result parameter to indicate failing device
+ *
+ *	Handle suspend EH action.  Disk devices are spinned down and
+ *	other types of devices are just marked suspended.  Once
+ *	suspended, no EH action to the device is allowed until it is
+ *	resumed.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise
+ */
+static int ata_eh_suspend(struct ata_port *ap, struct ata_device **r_failed_dev)
+{
+	struct ata_device *dev;
+	int i, rc = 0;
+
+	DPRINTK("ENTER\n");
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		unsigned long flags;
+		unsigned int action, err_mask;
+
+		dev = &ap->device[i];
+		action = ata_eh_dev_action(dev);
+
+		if (!ata_dev_enabled(dev) || !(action & ATA_EH_SUSPEND))
+			continue;
+
+		WARN_ON(dev->flags & ATA_DFLAG_SUSPENDED);
+
+		ata_eh_about_to_do(ap, dev, ATA_EH_SUSPEND);
+
+		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
+			/* flush cache */
+			rc = ata_flush_cache(dev);
+			if (rc)
+				break;
+
+			/* spin down */
+			err_mask = ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
+			if (err_mask) {
+				ata_dev_printk(dev, KERN_ERR, "failed to "
+					       "spin down (err_mask=0x%x)\n",
+					       err_mask);
+				rc = -EIO;
+				break;
+			}
+		}
+
+		spin_lock_irqsave(ap->lock, flags);
+		dev->flags |= ATA_DFLAG_SUSPENDED;
+		spin_unlock_irqrestore(ap->lock, flags);
+
+		ata_eh_done(ap, dev, ATA_EH_SUSPEND);
+	}
+
+	if (rc)
+		*r_failed_dev = dev;
+
+	DPRINTK("EXIT\n");
+	return 0;
+}
+
+/**
+ *	ata_eh_prep_resume - prep for resume EH action
+ *	@ap: target host port
+ *
+ *	Clear SUSPENDED in preparation for scheduled resume actions.
+ *	This allows other parts of EH to access the devices being
+ *	resumed.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_prep_resume(struct ata_port *ap)
+{
+	struct ata_device *dev;
+	unsigned long flags;
+	int i;
+
+	DPRINTK("ENTER\n");
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		unsigned int action;
+
+		dev = &ap->device[i];
+		action = ata_eh_dev_action(dev);
+
+		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
+			continue;
+
+		spin_lock_irqsave(ap->lock, flags);
+		dev->flags &= ~ATA_DFLAG_SUSPENDED;
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+
+	DPRINTK("EXIT\n");
+}
+
+/**
+ *	ata_eh_resume - handle resume EH action
+ *	@ap: target host port
+ *	@r_failed_dev: result parameter to indicate failing device
+ *
+ *	Handle resume EH action.  Target devices are already reset and
+ *	revalidated.  Spinning up is the only operation left.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise
+ */
+static int ata_eh_resume(struct ata_port *ap, struct ata_device **r_failed_dev)
+{
+	struct ata_device *dev;
+	int i, rc = 0;
+
+	DPRINTK("ENTER\n");
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		unsigned int action, err_mask;
+
+		dev = &ap->device[i];
+		action = ata_eh_dev_action(dev);
+
+		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
+			continue;
+
+		ata_eh_about_to_do(ap, dev, ATA_EH_RESUME);
+
+		if (dev->class == ATA_DEV_ATA && !(action & ATA_EH_PM_FREEZE)) {
+			err_mask = ata_do_simple_cmd(dev,
+						     ATA_CMD_IDLEIMMEDIATE);
+			if (err_mask) {
+				ata_dev_printk(dev, KERN_ERR, "failed to "
+					       "spin up (err_mask=0x%x)\n",
+					       err_mask);
+				rc = -EIO;
+				break;
+			}
+		}
+
+		ata_eh_done(ap, dev, ATA_EH_RESUME);
+	}
+
+	if (rc)
+		*r_failed_dev = dev;
+
+	DPRINTK("EXIT\n");
+	return 0;
+}
+
 static int ata_port_nr_enabled(struct ata_port *ap)
 {
 	int i, cnt = 0;
@@ -1673,7 +1844,19 @@ static int ata_eh_skip_recovery(struct a
 	struct ata_eh_context *ehc = &ap->eh_context;
 	int i;
 
-	if (ap->flags & ATA_FLAG_FROZEN || ata_port_nr_enabled(ap))
+	/* skip if all possible devices are suspended */
+	for (i = 0; i < ata_port_max_devices(ap); i++) {
+		struct ata_device *dev = &ap->device[i];
+
+		if (ata_dev_absent(dev) || ata_dev_ready(dev))
+			break;
+	}
+
+	if (i == ata_port_max_devices(ap))
+		return 1;
+
+	/* always thaw frozen port and recover failed devices */
+	if (ap->pflags & ATA_PFLAG_FROZEN || ata_port_nr_enabled(ap))
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
@@ -1744,9 +1927,12 @@ static int ata_eh_recover(struct ata_por
 	rc = 0;
 
 	/* if UNLOADING, finish immediately */
-	if (ap->flags & ATA_FLAG_UNLOADING)
+	if (ap->pflags & ATA_PFLAG_UNLOADING)
 		goto out;
 
+	/* prep for resume */
+	ata_eh_prep_resume(ap);
+
 	/* skip EH if possible. */
 	if (ata_eh_skip_recovery(ap))
 		ehc->i.action = 0;
@@ -1774,6 +1960,11 @@ static int ata_eh_recover(struct ata_por
 	if (rc)
 		goto dev_fail;
 
+	/* resume devices */
+	rc = ata_eh_resume(ap, &dev);
+	if (rc)
+		goto dev_fail;
+
 	/* configure transfer mode if the port has been reset */
 	if (ehc->i.flags & ATA_EHI_DID_RESET) {
 		rc = ata_set_mode(ap, &dev);
@@ -1783,6 +1974,11 @@ static int ata_eh_recover(struct ata_por
 		}
 	}
 
+	/* suspend devices */
+	rc = ata_eh_suspend(ap, &dev);
+	if (rc)
+		goto dev_fail;
+
 	goto out;
 
  dev_fail:
@@ -1908,11 +2104,124 @@ void ata_do_eh(struct ata_port *ap, ata_
 	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 	       ata_postreset_fn_t postreset)
 {
-	if (!(ap->flags & ATA_FLAG_LOADING)) {
-		ata_eh_autopsy(ap);
-		ata_eh_report(ap);
-	}
-
+	ata_eh_autopsy(ap);
+	ata_eh_report(ap);
 	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
 	ata_eh_finish(ap);
 }
+
+/**
+ *	ata_eh_handle_port_suspend - perform port suspend operation
+ *	@ap: port to suspend
+ *
+ *	Suspend @ap.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_handle_port_suspend(struct ata_port *ap)
+{
+	unsigned long flags;
+	int rc = 0;
+
+	/* are we suspending? */
+	spin_lock_irqsave(ap->lock, flags);
+	if (!(ap->pflags & ATA_PFLAG_PM_PENDING) ||
+	    ap->pm_mesg.event == PM_EVENT_ON) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
+
+	/* suspend */
+	ata_eh_freeze_port(ap);
+
+	if (ap->ops->port_suspend)
+		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
+
+	/* report result */
+	spin_lock_irqsave(ap->lock, flags);
+
+	ap->pflags &= ~ATA_PFLAG_PM_PENDING;
+	if (rc == 0)
+		ap->pflags |= ATA_PFLAG_SUSPENDED;
+	else
+		ata_port_schedule_eh(ap);
+
+	if (ap->pm_result) {
+		*ap->pm_result = rc;
+		ap->pm_result = NULL;
+	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return;
+}
+
+/**
+ *	ata_eh_handle_port_resume - perform port resume operation
+ *	@ap: port to resume
+ *
+ *	Resume @ap.
+ *
+ *	This function also waits upto one second until all devices
+ *	hanging off this port requests resume EH action.  This is to
+ *	prevent invoking EH and thus reset multiple times on resume.
+ *
+ *	On DPM resume, where some of devices might not be resumed
+ *	together, this may delay port resume upto one second, but such
+ *	DPM resumes are rare and 1 sec delay isn't too bad.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_eh_handle_port_resume(struct ata_port *ap)
+{
+	unsigned long timeout;
+	unsigned long flags;
+	int i, rc = 0;
+
+	/* are we resuming? */
+	spin_lock_irqsave(ap->lock, flags);
+	if (!(ap->pflags & ATA_PFLAG_PM_PENDING) ||
+	    ap->pm_mesg.event != PM_EVENT_ON) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	/* spurious? */
+	if (!(ap->pflags & ATA_PFLAG_SUSPENDED))
+		goto done;
+
+	if (ap->ops->port_resume)
+		rc = ap->ops->port_resume(ap);
+
+	/* give devices time to request EH */
+	timeout = jiffies + HZ; /* 1s max */
+	while (1) {
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			struct ata_device *dev = &ap->device[i];
+			unsigned int action = ata_eh_dev_action(dev);
+
+			if ((dev->flags & ATA_DFLAG_SUSPENDED) &&
+			    !(action & ATA_EH_RESUME))
+				break;
+		}
+
+		if (i == ATA_MAX_DEVICES || time_after(jiffies, timeout))
+			break;
+		msleep(10);
+	}
+
+ done:
+	spin_lock_irqsave(ap->lock, flags);
+	ap->pflags &= ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
+	if (ap->pm_result) {
+		*ap->pm_result = rc;
+		ap->pm_result = NULL;
+	}
+	spin_unlock_irqrestore(ap->lock, flags);
+}
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 2915bca..7ced41e 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -397,20 +397,129 @@ void ata_dump_status(unsigned id, struct
 	}
 }
 
-int ata_scsi_device_resume(struct scsi_device *sdev)
+/**
+ *	ata_scsi_device_suspend - suspend ATA device associated with sdev
+ *	@sdev: the SCSI device to suspend
+ *	@state: target power management state
+ *
+ *	Request suspend EH action on the ATA device associated with
+ *	@sdev and wait for the operation to complete.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
+	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
+	unsigned long flags;
+	unsigned int action;
+	int rc = 0;
+
+	if (!dev)
+		goto out;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/* wait for the previous resume to complete */
+	while (dev->flags & ATA_DFLAG_SUSPENDED) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		ata_port_wait_eh(ap);
+		spin_lock_irqsave(ap->lock, flags);
+	}
+
+	/* if @sdev is already detached, nothing to do */
+	if (sdev->sdev_state == SDEV_OFFLINE ||
+	    sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL)
+		goto out_unlock;
+
+	/* request suspend */
+	action = ATA_EH_SUSPEND;
+	if (state.event != PM_EVENT_SUSPEND)
+		action |= ATA_EH_PM_FREEZE;
+	ap->eh_info.dev_action[dev->devno] |= action;
+	ap->eh_info.flags |= ATA_EHI_QUIET;
+	ata_port_schedule_eh(ap);
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	/* wait for EH to do the job */
+	ata_port_wait_eh(ap);
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/* If @sdev is still attached but the associated ATA device
+	 * isn't suspended, the operation failed.
+	 */
+	if (sdev->sdev_state != SDEV_OFFLINE &&
+	    sdev->sdev_state != SDEV_CANCEL && sdev->sdev_state != SDEV_DEL &&
+	    !(dev->flags & ATA_DFLAG_SUSPENDED))
+		rc = -EIO;
 
-	return ata_device_resume(dev);
+ out_unlock:
+	spin_unlock_irqrestore(ap->lock, flags);
+ out:
+	if (rc == 0)
+		sdev->sdev_gendev.power.power_state = state;
+	return rc;
 }
 
-int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
+/**
+ *	ata_scsi_device_resume - resume ATA device associated with sdev
+ *	@sdev: the SCSI device to resume
+ *
+ *	Request resume EH action on the ATA device associated with
+ *	@sdev and return immediately.  This enables parallel
+ *	wakeup/spinup of devices.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0.
+ */
+int ata_scsi_device_resume(struct scsi_device *sdev)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
+	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
+	struct ata_eh_info *ehi = &ap->eh_info;
+	unsigned long flags;
+	unsigned int action;
+
+	if (!dev)
+		goto out;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/* if @sdev is already detached, nothing to do */
+	if (sdev->sdev_state == SDEV_OFFLINE ||
+	    sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL)
+		goto out_unlock;
 
-	return ata_device_suspend(dev, state);
+	/* request resume */
+	action = ATA_EH_RESUME;
+	if (sdev->sdev_gendev.power.power_state.event == PM_EVENT_SUSPEND)
+		__ata_ehi_hotplugged(ehi);
+	else
+		action |= ATA_EH_PM_FREEZE | ATA_EH_SOFTRESET;
+	ehi->dev_action[dev->devno] |= action;
+
+	/* We don't want autopsy and verbose EH messages.  Disable
+	 * those if we're the only device on this link.
+	 */
+	if (ata_port_max_devices(ap) == 1)
+		ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
+
+	ata_port_schedule_eh(ap);
+
+ out_unlock:
+	spin_unlock_irqrestore(ap->lock, flags);
+ out:
+	sdev->sdev_gendev.power.power_state = PMSG_ON;
+	return 0;
 }
 
 /**
@@ -2930,7 +3039,7 @@ void ata_scsi_hotplug(void *data)
 	struct ata_port *ap = data;
 	int i;
 
-	if (ap->flags & ATA_FLAG_UNLOADING) {
+	if (ap->pflags & ATA_PFLAG_UNLOADING) {
 		DPRINTK("ENTER/EXIT - unloading\n");
 		return;
 	}
@@ -3011,6 +3120,7 @@ static int ata_scsi_user_scan(struct Scs
 		if (dev) {
 			ap->eh_info.probe_mask |= 1 << dev->devno;
 			ap->eh_info.action |= ATA_EH_SOFTRESET;
+			ap->eh_info.flags |= ATA_EHI_RESUME_LINK;
 		} else
 			rc = -EINVAL;
 	}
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 7aabb45..d0a8507 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -109,6 +109,7 @@ enum {
 };
 
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int sil_pci_device_resume(struct pci_dev *pdev);
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
@@ -160,6 +161,8 @@ static struct pci_driver sil_pci_driver 
 	.id_table		= sil_pci_tbl,
 	.probe			= sil_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= sil_pci_device_resume,
 };
 
 static struct scsi_host_template sil_sht = {
@@ -178,6 +181,8 @@ static struct scsi_host_template sil_sht
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static const struct ata_port_operations sil_ops = {
@@ -370,7 +375,7 @@ static void sil_host_intr(struct ata_por
 		 * during hardreset makes controllers with broken SIEN
 		 * repeat probing needlessly.
 		 */
-		if (!(ap->flags & ATA_FLAG_FROZEN)) {
+		if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 			ata_ehi_hotplugged(&ap->eh_info);
 			ap->eh_info.serror |= serror;
 		}
@@ -561,6 +566,52 @@ static void sil_dev_config(struct ata_po
 	}
 }
 
+static void sil_init_controller(struct pci_dev *pdev,
+				int n_ports, unsigned long host_flags,
+				void __iomem *mmio_base)
+{
+	u8 cls;
+	u32 tmp;
+	int i;
+
+	/* Initialize FIFO PCI bus arbitration */
+	cls = sil_get_device_cache_line(pdev);
+	if (cls) {
+		cls >>= 3;
+		cls++;  /* cls = (line_size/8)+1 */
+		for (i = 0; i < n_ports; i++)
+			writew(cls << 8 | cls,
+			       mmio_base + sil_port[i].fifo_cfg);
+	} else
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "cache line size not set.  Driver may not function\n");
+
+	/* Apply R_ERR on DMA activate FIS errata workaround */
+	if (host_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
+		int cnt;
+
+		for (i = 0, cnt = 0; i < n_ports; i++) {
+			tmp = readl(mmio_base + sil_port[i].sfis_cfg);
+			if ((tmp & 0x3) != 0x01)
+				continue;
+			if (!cnt)
+				dev_printk(KERN_INFO, &pdev->dev,
+					   "Applying R_ERR on DMA activate "
+					   "FIS errata fix\n");
+			writel(tmp & ~0x3, mmio_base + sil_port[i].sfis_cfg);
+			cnt++;
+		}
+	}
+
+	if (n_ports == 4) {
+		/* flip the magic "make 4 ports work" bit */
+		tmp = readl(mmio_base + sil_port[2].bmdma);
+		if ((tmp & SIL_INTR_STEERING) == 0)
+			writel(tmp | SIL_INTR_STEERING,
+			       mmio_base + sil_port[2].bmdma);
+	}
+}
+
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -570,8 +621,6 @@ static int sil_init_one (struct pci_dev 
 	int rc;
 	unsigned int i;
 	int pci_dev_busy = 0;
-	u32 tmp;
-	u8 cls;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -630,42 +679,8 @@ static int sil_init_one (struct pci_dev 
 		ata_std_ports(&probe_ent->port[i]);
 	}
 
-	/* Initialize FIFO PCI bus arbitration */
-	cls = sil_get_device_cache_line(pdev);
-	if (cls) {
-		cls >>= 3;
-		cls++;  /* cls = (line_size/8)+1 */
-		for (i = 0; i < probe_ent->n_ports; i++)
-			writew(cls << 8 | cls,
-			       mmio_base + sil_port[i].fifo_cfg);
-	} else
-		dev_printk(KERN_WARNING, &pdev->dev,
-			   "cache line size not set.  Driver may not function\n");
-
-	/* Apply R_ERR on DMA activate FIS errata workaround */
-	if (probe_ent->host_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
-		int cnt;
-
-		for (i = 0, cnt = 0; i < probe_ent->n_ports; i++) {
-			tmp = readl(mmio_base + sil_port[i].sfis_cfg);
-			if ((tmp & 0x3) != 0x01)
-				continue;
-			if (!cnt)
-				dev_printk(KERN_INFO, &pdev->dev,
-					   "Applying R_ERR on DMA activate "
-					   "FIS errata fix\n");
-			writel(tmp & ~0x3, mmio_base + sil_port[i].sfis_cfg);
-			cnt++;
-		}
-	}
-
-	if (ent->driver_data == sil_3114) {
-		/* flip the magic "make 4 ports work" bit */
-		tmp = readl(mmio_base + sil_port[2].bmdma);
-		if ((tmp & SIL_INTR_STEERING) == 0)
-			writel(tmp | SIL_INTR_STEERING,
-			       mmio_base + sil_port[2].bmdma);
-	}
+	sil_init_controller(pdev, probe_ent->n_ports, probe_ent->host_flags,
+			    mmio_base);
 
 	pci_set_master(pdev);
 
@@ -685,6 +700,18 @@ err_out:
 	return rc;
 }
 
+static int sil_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+
+	ata_pci_device_do_resume(pdev);
+	sil_init_controller(pdev, host_set->n_ports, host_set->ports[0]->flags,
+			    host_set->mmio_base);
+	ata_host_set_resume(host_set);
+
+	return 0;
+}
+
 static int __init sil_init(void)
 {
 	return pci_module_init(&sil_pci_driver);
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 07a1c6a..2e0f4a4 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -92,6 +92,7 @@ enum {
 	HOST_CTRL_STOP		= (1 << 18), /* latched PCI STOP */
 	HOST_CTRL_DEVSEL	= (1 << 19), /* latched PCI DEVSEL */
 	HOST_CTRL_REQ64		= (1 << 20), /* latched PCI REQ64 */
+	HOST_CTRL_GLOBAL_RST	= (1 << 31), /* global reset */
 
 	/*
 	 * Port registers
@@ -338,6 +339,7 @@ static int sil24_port_start(struct ata_p
 static void sil24_port_stop(struct ata_port *ap);
 static void sil24_host_stop(struct ata_host_set *host_set);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static int sil24_pci_device_resume(struct pci_dev *pdev);
 
 static const struct pci_device_id sil24_pci_tbl[] = {
 	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
@@ -353,6 +355,8 @@ static struct pci_driver sil24_pci_drive
 	.id_table		= sil24_pci_tbl,
 	.probe			= sil24_init_one,
 	.remove			= ata_pci_remove_one, /* safe? */
+	.suspend		= ata_pci_device_suspend,
+	.resume			= sil24_pci_device_resume,
 };
 
 static struct scsi_host_template sil24_sht = {
@@ -372,6 +376,8 @@ static struct scsi_host_template sil24_s
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static const struct ata_port_operations sil24_ops = {
@@ -607,7 +613,7 @@ static int sil24_hardreset(struct ata_po
 	/* SStatus oscillates between zero and valid status after
 	 * DEV_RST, debounce it.
 	 */
-	rc = sata_phy_debounce(ap, sata_deb_timing_before_fsrst);
+	rc = sata_phy_debounce(ap, sata_deb_timing_long);
 	if (rc) {
 		reason = "PHY debouncing failed";
 		goto err;
@@ -988,6 +994,64 @@ static void sil24_host_stop(struct ata_h
 	kfree(hpriv);
 }
 
+static void sil24_init_controller(struct pci_dev *pdev, int n_ports,
+				  unsigned long host_flags,
+				  void __iomem *host_base,
+				  void __iomem *port_base)
+{
+	u32 tmp;
+	int i;
+
+	/* GPIO off */
+	writel(0, host_base + HOST_FLASH_CMD);
+
+	/* clear global reset & mask interrupts during initialization */
+	writel(0, host_base + HOST_CTRL);
+
+	/* init ports */
+	for (i = 0; i < n_ports; i++) {
+		void __iomem *port = port_base + i * PORT_REGS_SIZE;
+
+		/* Initial PHY setting */
+		writel(0x20c, port + PORT_PHY_CFG);
+
+		/* Clear port RST */
+		tmp = readl(port + PORT_CTRL_STAT);
+		if (tmp & PORT_CS_PORT_RST) {
+			writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
+			tmp = ata_wait_register(port + PORT_CTRL_STAT,
+						PORT_CS_PORT_RST,
+						PORT_CS_PORT_RST, 10, 100);
+			if (tmp & PORT_CS_PORT_RST)
+				dev_printk(KERN_ERR, &pdev->dev,
+				           "failed to clear port RST\n");
+		}
+
+		/* Configure IRQ WoC */
+		if (host_flags & SIL24_FLAG_PCIX_IRQ_WOC)
+			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_STAT);
+		else
+			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
+
+		/* Zero error counters. */
+		writel(0x8000, port + PORT_DECODE_ERR_THRESH);
+		writel(0x8000, port + PORT_CRC_ERR_THRESH);
+		writel(0x8000, port + PORT_HSHK_ERR_THRESH);
+		writel(0x0000, port + PORT_DECODE_ERR_CNT);
+		writel(0x0000, port + PORT_CRC_ERR_CNT);
+		writel(0x0000, port + PORT_HSHK_ERR_CNT);
+
+		/* Always use 64bit activation */
+		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
+
+		/* Clear port multiplier enable and resume bits */
+		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
+	}
+
+	/* Turn on interrupts */
+	writel(IRQ_STAT_4PORTS, host_base + HOST_CTRL);
+}
+
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
@@ -1076,9 +1140,6 @@ static int sil24_init_one(struct pci_dev
 		}
 	}
 
-	/* GPIO off */
-	writel(0, host_base + HOST_FLASH_CMD);
-
 	/* Apply workaround for completion IRQ loss on PCI-X errata */
 	if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC) {
 		tmp = readl(host_base + HOST_CTRL);
@@ -1090,56 +1151,18 @@ static int sil24_init_one(struct pci_dev
 			probe_ent->host_flags &= ~SIL24_FLAG_PCIX_IRQ_WOC;
 	}
 
-	/* clear global reset & mask interrupts during initialization */
-	writel(0, host_base + HOST_CTRL);
-
 	for (i = 0; i < probe_ent->n_ports; i++) {
-		void __iomem *port = port_base + i * PORT_REGS_SIZE;
-		unsigned long portu = (unsigned long)port;
+		unsigned long portu =
+			(unsigned long)port_base + i * PORT_REGS_SIZE;
 
 		probe_ent->port[i].cmd_addr = portu;
 		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
 
 		ata_std_ports(&probe_ent->port[i]);
-
-		/* Initial PHY setting */
-		writel(0x20c, port + PORT_PHY_CFG);
-
-		/* Clear port RST */
-		tmp = readl(port + PORT_CTRL_STAT);
-		if (tmp & PORT_CS_PORT_RST) {
-			writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
-			tmp = ata_wait_register(port + PORT_CTRL_STAT,
-						PORT_CS_PORT_RST,
-						PORT_CS_PORT_RST, 10, 100);
-			if (tmp & PORT_CS_PORT_RST)
-				dev_printk(KERN_ERR, &pdev->dev,
-				           "failed to clear port RST\n");
-		}
-
-		/* Configure IRQ WoC */
-		if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC)
-			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_STAT);
-		else
-			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
-
-		/* Zero error counters. */
-		writel(0x8000, port + PORT_DECODE_ERR_THRESH);
-		writel(0x8000, port + PORT_CRC_ERR_THRESH);
-		writel(0x8000, port + PORT_HSHK_ERR_THRESH);
-		writel(0x0000, port + PORT_DECODE_ERR_CNT);
-		writel(0x0000, port + PORT_CRC_ERR_CNT);
-		writel(0x0000, port + PORT_HSHK_ERR_CNT);
-
-		/* Always use 64bit activation */
-		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
-
-		/* Clear port multiplier enable and resume bits */
-		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
 	}
 
-	/* Turn on interrupts */
-	writel(IRQ_STAT_4PORTS, host_base + HOST_CTRL);
+	sil24_init_controller(pdev, probe_ent->n_ports, probe_ent->host_flags,
+			      host_base, port_base);
 
 	pci_set_master(pdev);
 
@@ -1162,6 +1185,25 @@ static int sil24_init_one(struct pci_dev
 	return rc;
 }
 
+static int sil24_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+	struct sil24_host_priv *hpriv = host_set->private_data;
+
+	ata_pci_device_do_resume(pdev);
+
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
+		writel(HOST_CTRL_GLOBAL_RST, hpriv->host_base + HOST_CTRL);
+
+	sil24_init_controller(pdev, host_set->n_ports,
+			      host_set->ports[0]->flags,
+			      hpriv->host_base, hpriv->port_base);
+
+	ata_host_set_resume(host_set);
+
+	return 0;
+}
+
 static int __init sil24_init(void)
 {
 	return pci_module_init(&sil24_pci_driver);
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 916fe6f..ad37871 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -297,7 +297,7 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_pio_data_xfer,
+	.data_xfer		= ata_mmio_data_xfer,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f4284bf..6cc497a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -131,6 +131,7 @@ enum {
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
+	ATA_DFLAG_SUSPENDED	= (1 << 9), /* device suspended */
 	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 16),
@@ -160,22 +161,28 @@ enum {
 	ATA_FLAG_HRST_TO_RESUME	= (1 << 11), /* hardreset to resume phy */
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
-
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
-	ATA_FLAG_FLUSH_PORT_TASK = (1 << 14), /* flush port task */
 
-	ATA_FLAG_EH_PENDING	= (1 << 15), /* EH pending */
-	ATA_FLAG_EH_IN_PROGRESS	= (1 << 16), /* EH in progress */
-	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
-	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
-	ATA_FLAG_LOADING	= (1 << 19), /* boot/loading probe */
-	ATA_FLAG_UNLOADING	= (1 << 20), /* module is unloading */
-	ATA_FLAG_SCSI_HOTPLUG	= (1 << 21), /* SCSI hotplug scheduled */
+	/* The following flag belongs to ap->pflags but is kept in
+	 * ap->flags because it's referenced in many LLDs and will be
+	 * removed in not-too-distant future.
+	 */
+	ATA_FLAG_DISABLED	= (1 << 23), /* port is disabled, ignore it */
+
+	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
-	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
-	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
+	/* struct ata_port pflags */
+	ATA_PFLAG_EH_PENDING	= (1 << 0), /* EH pending */
+	ATA_PFLAG_EH_IN_PROGRESS = (1 << 1), /* EH in progress */
+	ATA_PFLAG_FROZEN	= (1 << 2), /* port is frozen */
+	ATA_PFLAG_RECOVERED	= (1 << 3), /* recovery action performed */
+	ATA_PFLAG_LOADING	= (1 << 4), /* boot/loading probe */
+	ATA_PFLAG_UNLOADING	= (1 << 5), /* module is unloading */
+	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
 
-	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
+	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
+	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
+	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
@@ -248,12 +255,19 @@ enum {
 	ATA_EH_REVALIDATE	= (1 << 0),
 	ATA_EH_SOFTRESET	= (1 << 1),
 	ATA_EH_HARDRESET	= (1 << 2),
+	ATA_EH_SUSPEND		= (1 << 3),
+	ATA_EH_RESUME		= (1 << 4),
+	ATA_EH_PM_FREEZE	= (1 << 5),
 
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
-	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE,
+	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE | ATA_EH_SUSPEND |
+				  ATA_EH_RESUME | ATA_EH_PM_FREEZE,
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
+	ATA_EHI_RESUME_LINK	= (1 << 1),  /* need to resume link */
+	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
+	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
 
 	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
 
@@ -486,6 +500,7 @@ struct ata_port {
 	const struct ata_port_operations *ops;
 	spinlock_t		*lock;
 	unsigned long		flags;	/* ATA_FLAG_xxx */
+	unsigned int		pflags; /* ATA_PFLAG_xxx */
 	unsigned int		id;	/* unique id req'd by scsi midlyr */
 	unsigned int		port_no; /* unique port #; from zero */
 	unsigned int		hard_port_no;	/* hardware port #; from zero */
@@ -535,6 +550,9 @@ struct ata_port {
 	struct list_head	eh_done_q;
 	wait_queue_head_t	eh_wait_q;
 
+	pm_message_t		pm_mesg;
+	int			*pm_result;
+
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
@@ -589,6 +607,9 @@ struct ata_port_operations {
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
 			   u32 val);
 
+	int (*port_suspend) (struct ata_port *ap, pm_message_t mesg);
+	int (*port_resume) (struct ata_port *ap);
+
 	int (*port_start) (struct ata_port *ap);
 	void (*port_stop) (struct ata_port *ap);
 
@@ -622,9 +643,18 @@ struct ata_timing {
 
 #define FIT(v,vmin,vmax)	max_t(short,min_t(short,v,vmax),vmin)
 
-extern const unsigned long sata_deb_timing_boot[];
-extern const unsigned long sata_deb_timing_eh[];
-extern const unsigned long sata_deb_timing_before_fsrst[];
+extern const unsigned long sata_deb_timing_normal[];
+extern const unsigned long sata_deb_timing_hotplug[];
+extern const unsigned long sata_deb_timing_long[];
+
+static inline const unsigned long *
+sata_ehc_deb_timing(struct ata_eh_context *ehc)
+{
+	if (ehc->i.flags & ATA_EHI_HOTPLUGGED)
+		return sata_deb_timing_hotplug;
+	else
+		return sata_deb_timing_normal;
+}
 
 extern void ata_port_probe(struct ata_port *);
 extern void __sata_phy_reset(struct ata_port *ap);
@@ -644,6 +674,8 @@ #ifdef CONFIG_PCI
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
+extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t state);
+extern void ata_pci_device_do_resume(struct pci_dev *pdev);
 extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
@@ -664,8 +696,9 @@ extern int ata_port_online(struct ata_po
 extern int ata_port_offline(struct ata_port *ap);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
-extern int ata_device_resume(struct ata_device *);
-extern int ata_device_suspend(struct ata_device *, pm_message_t state);
+extern int ata_host_set_suspend(struct ata_host_set *host_set,
+				pm_message_t mesg);
+extern void ata_host_set_resume(struct ata_host_set *host_set);
 extern int ata_ratelimit(void);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
@@ -825,19 +858,24 @@ #define ata_ehi_clear_desc(ehi) do { \
 	(ehi)->desc_len = 0; \
 } while (0)
 
-static inline void ata_ehi_hotplugged(struct ata_eh_info *ehi)
+static inline void __ata_ehi_hotplugged(struct ata_eh_info *ehi)
 {
 	if (ehi->flags & ATA_EHI_HOTPLUGGED)
 		return;
 
-	ehi->flags |= ATA_EHI_HOTPLUGGED;
+	ehi->flags |= ATA_EHI_HOTPLUGGED | ATA_EHI_RESUME_LINK;
 	ehi->hotplug_timestamp = jiffies;
 
-	ehi->err_mask |= AC_ERR_ATA_BUS;
 	ehi->action |= ATA_EH_SOFTRESET;
 	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
 }
 
+static inline void ata_ehi_hotplugged(struct ata_eh_info *ehi)
+{
+	__ata_ehi_hotplugged(ehi);
+	ehi->err_mask |= AC_ERR_ATA_BUS;
+}
+
 /*
  * qc helpers
  */
@@ -921,6 +959,11 @@ static inline unsigned int ata_dev_absen
 	return ata_class_absent(dev->class);
 }
 
+static inline unsigned int ata_dev_ready(const struct ata_device *dev)
+{
+	return ata_dev_enabled(dev) && !(dev->flags & ATA_DFLAG_SUSPENDED);
+}
+
 /*
  * port helpers
  */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 685081c..c09396d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2019,6 +2019,13 @@ #define PCI_VENDOR_ID_TOPSPIN		0x1867
 #define PCI_VENDOR_ID_TDI               0x192E
 #define PCI_DEVICE_ID_TDI_EHCI          0x0101
 
+#define PCI_VENDOR_ID_JMICRON		0x197B
+#define PCI_DEVICE_ID_JMICRON_JMB360	0x2360
+#define PCI_DEVICE_ID_JMICRON_JMB361	0x2361
+#define PCI_DEVICE_ID_JMICRON_JMB363	0x2363
+#define PCI_DEVICE_ID_JMICRON_JMB365	0x2365
+#define PCI_DEVICE_ID_JMICRON_JMB366	0x2366
+#define PCI_DEVICE_ID_JMICRON_JMB368	0x2368
 
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29

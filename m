Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751250AbWFER7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWFER7P (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWFER7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:59:15 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:129 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751250AbWFER7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:59:14 -0400
Date: Mon, 5 Jun 2006 11:01:30 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.16.20
Message-ID: <20060605180130.GB29676@moss.sous-sol.org>
References: <20060605180044.GA29676@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605180044.GA29676@moss.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index bf2e152..600c769 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .19
+EXTRAVERSION = .20
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 29c2946..f649750 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -456,11 +456,23 @@ static int pmac_pm_finish(suspend_state_
 	return 0;
 }
 
+static int pmac_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_DISK:
+		return 1;
+	/* can't do any other states via generic mechanism yet */
+	default:
+		return 0;
+	}
+}
+
 static struct pm_ops pmac_pm_ops = {
 	.pm_disk_mode	= PM_DISK_SHUTDOWN,
 	.prepare	= pmac_pm_prepare,
 	.enter		= pmac_pm_enter,
 	.finish		= pmac_pm_finish,
+	.valid		= pmac_pm_valid,
 };
 
 #endif /* CONFIG_SOFTWARE_SUSPEND */
diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
index ab6e44d..97583bb 100644
--- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -281,12 +281,7 @@ tracesys:			 
 	ja  1f
 	movq %r10,%rcx	/* fixup for C */
 	call *sys_call_table(,%rax,8)
-	movq %rax,RAX-ARGOFFSET(%rsp)
-1:	SAVE_REST
-	movq %rsp,%rdi
-	call syscall_trace_leave
-	RESTORE_TOP_OF_STACK %rbx
-	RESTORE_REST
+1:	movq %rax,RAX-ARGOFFSET(%rsp)
 	/* Use IRET because user could have changed frame */
 	jmp int_ret_from_sys_call
 	CFI_ENDPROC
diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index 28d50dc..a5209fd 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -30,6 +30,7 @@ #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/nmi.h>
 #include <linux/kprobes.h>
+#include <linux/kexec.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -434,6 +435,8 @@ #endif
 	printk(KERN_ALERT "RIP ");
 	printk_address(regs->rip); 
 	printk(" RSP <%016lx>\n", regs->rsp); 
+	if (kexec_should_crash(current))
+		crash_kexec(regs);
 }
 
 void die(const char * str, struct pt_regs * regs, long err)
@@ -456,6 +459,8 @@ void __kprobes die_nmi(char *str, struct
 	 */
 	printk(str, safe_smp_processor_id());
 	show_registers(regs);
+	if (kexec_should_crash(current))
+		crash_kexec(regs);
 	if (panic_on_timeout || panic_on_oops)
 		panic("nmi watchdog");
 	printk("console shuts up ...\n");
diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index b6b96fa..a9a73f7 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -2525,7 +2525,7 @@ static irqreturn_t ohci_irq_handler(int 
 			if (phys_dma) {
 				reg_write(ohci,OHCI1394_PhyReqFilterHiSet, 0xffffffff);
 				reg_write(ohci,OHCI1394_PhyReqFilterLoSet, 0xffffffff);
-				reg_write(ohci,OHCI1394_PhyUpperBound, 0xffff0000);
+				reg_write(ohci,OHCI1394_PhyUpperBound, 0x01000000);
 			} else {
 				reg_write(ohci,OHCI1394_PhyReqFilterHiSet, 0x00000000);
 				reg_write(ohci,OHCI1394_PhyReqFilterLoSet, 0x00000000);
diff --git a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
index d83248e..d02be4a 100644
--- a/drivers/ieee1394/sbp2.c
+++ b/drivers/ieee1394/sbp2.c
@@ -754,12 +754,17 @@ #endif
 
 	/* Register the status FIFO address range. We could use the same FIFO
 	 * for targets at different nodes. However we need different FIFOs per
-	 * target in order to support multi-unit devices. */
+	 * target in order to support multi-unit devices.
+	 * The FIFO is located out of the local host controller's physical range
+	 * but, if possible, within the posted write area. Status writes will
+	 * then be performed as unified transactions. This slightly reduces
+	 * bandwidth usage, and some Prolific based devices seem to require it.
+	 */
 	scsi_id->status_fifo_addr = hpsb_allocate_and_register_addrspace(
 			&sbp2_highlevel, ud->ne->host, &sbp2_ops,
 			sizeof(struct sbp2_status_block), sizeof(quadlet_t),
-			~0ULL, ~0ULL);
-	if (!scsi_id->status_fifo_addr) {
+			0x010000000000ULL, CSR1212_ALL_SPACE_END);
+	if (scsi_id->status_fifo_addr == ~0ULL) {
 		SBP2_ERR("failed to allocate status FIFO address range");
 		goto failed_alloc;
 	}
@@ -2486,9 +2491,20 @@ static int sbp2scsi_slave_alloc(struct s
 
 static int sbp2scsi_slave_configure(struct scsi_device *sdev)
 {
+	struct scsi_id_instance_data *scsi_id =
+		(struct scsi_id_instance_data *)sdev->host->hostdata[0];
+
 	blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
+
+	if ((scsi_id->sbp2_firmware_revision & 0xffff00) == 0x0a2700 &&
+	    (scsi_id->ud->model_id == 0x000021 /* gen.4 iPod */ ||
+	     scsi_id->ud->model_id == 0x000023 /* iPod mini  */ ||
+	     scsi_id->ud->model_id == 0x00007e /* iPod Photo */ )) {
+		SBP2_INFO("enabling iPod workaround: decrement disk capacity");
+		sdev->fix_capacity = 1;
+	}
 	return 0;
 }
 
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index ad62174..b2bed1a 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -300,8 +300,10 @@ static irqreturn_t psmouse_interrupt(str
  * Check if this is a new device announcement (0xAA 0x00)
  */
 	if (unlikely(psmouse->packet[0] == PSMOUSE_RET_BAT && psmouse->pktcnt <= 2)) {
-		if (psmouse->pktcnt == 1)
+		if (psmouse->pktcnt == 1) {
+			psmouse->last = jiffies;
 			goto out;
+		}
 
 		if (psmouse->packet[1] == PSMOUSE_RET_ID) {
 			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
diff --git a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
index aa6f3a4..f42e51a 100644
--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -8391,20 +8391,28 @@ static int ipw_wx_get_range(struct net_d
 
 	i = 0;
 	if (priv->ieee->mode & (IEEE_B | IEEE_G)) {
-		for (j = 0; j < geo->bg_channels && i < IW_MAX_FREQUENCIES;
-		     i++, j++) {
+		for (j = 0; j < geo->bg_channels && i < IW_MAX_FREQUENCIES; j++) {
+			if ((priv->ieee->iw_mode == IW_MODE_ADHOC) &&
+			    (geo->bg[j].flags & IEEE80211_CH_PASSIVE_ONLY))
+				continue;
+
 			range->freq[i].i = geo->bg[j].channel;
 			range->freq[i].m = geo->bg[j].freq * 100000;
 			range->freq[i].e = 1;
+			i++;
 		}
 	}
 
 	if (priv->ieee->mode & IEEE_A) {
-		for (j = 0; j < geo->a_channels && i < IW_MAX_FREQUENCIES;
-		     i++, j++) {
+		for (j = 0; j < geo->a_channels && i < IW_MAX_FREQUENCIES; j++) {
+			if ((priv->ieee->iw_mode == IW_MODE_ADHOC) &&
+			    (geo->a[j].flags & IEEE80211_CH_PASSIVE_ONLY))
+				continue;
+
 			range->freq[i].i = geo->a[j].channel;
 			range->freq[i].m = geo->a[j].freq * 100000;
 			range->freq[i].e = 1;
+			i++;
 		}
 	}
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 4f91b0d..400e9d7 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4293,6 +4293,7 @@ static int ata_start_drive(struct ata_po
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
 	}
diff --git a/drivers/sn/ioc3.c b/drivers/sn/ioc3.c
index 93449a1..4bd05a0 100644
--- a/drivers/sn/ioc3.c
+++ b/drivers/sn/ioc3.c
@@ -677,7 +677,7 @@ #endif
 	/* Track PCI-device specific data */
 	pci_set_drvdata(pdev, idd);
 	down_write(&ioc3_devices_rwsem);
-	list_add(&idd->list, &ioc3_devices);
+	list_add_tail(&idd->list, &ioc3_devices);
 	idd->id = ioc3_counter++;
 	up_write(&ioc3_devices_rwsem);
 
diff --git a/drivers/sn/ioc4.c b/drivers/sn/ioc4.c
index ea75b3d..771e868 100644
--- a/drivers/sn/ioc4.c
+++ b/drivers/sn/ioc4.c
@@ -313,7 +313,7 @@ ioc4_probe(struct pci_dev *pdev, const s
 	idd->idd_serial_data = NULL;
 	pci_set_drvdata(idd->idd_pdev, idd);
 	down_write(&ioc4_devices_rwsem);
-	list_add(&idd->idd_list, &ioc4_devices);
+	list_add_tail(&idd->idd_list, &ioc4_devices);
 	up_write(&ioc4_devices_rwsem);
 
 	/* Add this IOC4 to all submodules */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 61de222..8b3cde1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -949,7 +949,8 @@ restart:
 		alloc_flags |= ALLOC_HARDER;
 	if (gfp_mask & __GFP_HIGH)
 		alloc_flags |= ALLOC_HIGH;
-	alloc_flags |= ALLOC_CPUSET;
+	if (wait)
+		alloc_flags |= ALLOC_CPUSET;
 
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations

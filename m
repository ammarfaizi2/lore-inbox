Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWFDDlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWFDDlt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 23:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWFDDlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 23:41:49 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:54480 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751493AbWFDDli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 23:41:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=RXrRFa/Oytqy2IUyv8kuadzRGYDaHx4nyZIQDCR+paTV82RFdWHDTEgpbVk13/Gk0E12f3EhR0z6kfiJK8ZYZC8ihSptz6M/igRSeg/WH5GEzskeMCOGnnCO6G3fyOLZQbpvJOTN6E2XT2ug6to2xX0m3jMcaCGXujSiUG7OEEs=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] arm: implement flush_kernel_dcache_page()
In-Reply-To: <1149392479501-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sun, 4 Jun 2006 12:41:19 +0900
Message-Id: <1149392479281-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       rmk@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement flush_kernel_dcache_page() for arm.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 Documentation/serial/driver           |    9 +++---
 arch/arm/mach-ixp23xx/core.c          |   18 ++---------
 arch/sparc64/kernel/head.S            |   30 -------------------
 arch/sparc64/kernel/setup.c           |   23 ++++++++-------
 arch/sparc64/kernel/smp.c             |   16 ++++++++--
 block/cfq-iosched.c                   |   52 +++++++--------------------------
 drivers/message/fusion/mptbase.c      |   27 ++++-------------
 drivers/scsi/ppa.c                    |    7 ----
 drivers/scsi/scsi_devinfo.c           |    1 -
 drivers/scsi/scsi_lib.c               |    2 +
 drivers/scsi/scsi_transport_sas.c     |    4 +--
 include/asm-arm/arch-ixp23xx/memory.h |    2 +
 include/asm-arm/cacheflush.h          |    6 ++++
 include/asm-generic/pgtable.h         |   11 ++++++-
 include/asm-mips/pgtable.h            |   10 +-----
 include/asm-sparc64/pgtable.h         |   17 -----------
 mm/slab.c                             |   27 +++++++++--------
 net/ipv4/tcp_highspeed.c              |    3 +-
 18 files changed, 85 insertions(+), 180 deletions(-)

b088ab1aa777a3168b10dff2aead67fcea7118a5
diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 88ad615..df82116 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -214,13 +214,12 @@ hardware.
 	The interaction of the iflag bits is as follows (parity error
 	given as an example):
 	Parity error	INPCK	IGNPAR
-	n/a		0	n/a	character received, marked as
+	None		n/a	n/a	character received
+	Yes		n/a	0	character discarded
+	Yes		0	1	character received, marked as
 					TTY_NORMAL
-	None		1	n/a	character received, marked as
-					TTY_NORMAL
-	Yes		1	0	character received, marked as
+	Yes		1	1	character received, marked as
 					TTY_PARITY
-	Yes		1	1	character discarded
 
 	Other flags may be used (eg, xon/xoff characters) if your
 	hardware supports hardware "soft" flow control.
diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
index affd1d5..092ee12 100644
--- a/arch/arm/mach-ixp23xx/core.c
+++ b/arch/arm/mach-ixp23xx/core.c
@@ -178,12 +178,8 @@ static int ixp23xx_irq_set_type(unsigned
 
 static void ixp23xx_irq_mask(unsigned int irq)
 {
-	volatile unsigned long *intr_reg;
+	volatile unsigned long *intr_reg = IXP23XX_INTR_EN1 + (irq / 32);
 
-	if (irq >= 56)
-		irq += 8;
-
-	intr_reg = IXP23XX_INTR_EN1 + (irq / 32);
 	*intr_reg &= ~(1 << (irq % 32));
 }
 
@@ -203,25 +199,17 @@ static void ixp23xx_irq_ack(unsigned int
  */
 static void ixp23xx_irq_level_unmask(unsigned int irq)
 {
-	volatile unsigned long *intr_reg;
+	volatile unsigned long *intr_reg = IXP23XX_INTR_EN1 + (irq / 32);
 
 	ixp23xx_irq_ack(irq);
 
-	if (irq >= 56)
-		irq += 8;
-
-	intr_reg = IXP23XX_INTR_EN1 + (irq / 32);
 	*intr_reg |= (1 << (irq % 32));
 }
 
 static void ixp23xx_irq_edge_unmask(unsigned int irq)
 {
-	volatile unsigned long *intr_reg;
-
-	if (irq >= 56)
-		irq += 8;
+	volatile unsigned long *intr_reg = IXP23XX_INTR_EN1 + (irq / 32);
 
-	intr_reg = IXP23XX_INTR_EN1 + (irq / 32);
 	*intr_reg |= (1 << (irq % 32));
 }
 
diff --git a/arch/sparc64/kernel/head.S b/arch/sparc64/kernel/head.S
index 31c5892..3eadac5 100644
--- a/arch/sparc64/kernel/head.S
+++ b/arch/sparc64/kernel/head.S
@@ -10,7 +10,6 @@
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/errno.h>
-#include <linux/threads.h>
 #include <asm/thread_info.h>
 #include <asm/asi.h>
 #include <asm/pstate.h>
@@ -494,35 +493,6 @@ tlb_fixup_done:
 	call	prom_init
 	 mov	%l7, %o0			! OpenPROM cif handler
 
-	/* Initialize current_thread_info()->cpu as early as possible.
-	 * In order to do that accurately we have to patch up the get_cpuid()
-	 * assembler sequences.  And that, in turn, requires that we know
-	 * if we are on a Starfire box or not.  While we're here, patch up
-	 * the sun4v sequences as well.
-	 */
-	call	check_if_starfire
-	 nop
-	call	per_cpu_patch
-	 nop
-	call	sun4v_patch
-	 nop
-
-#ifdef CONFIG_SMP
-	call	hard_smp_processor_id
-	 nop
-	cmp	%o0, NR_CPUS
-	blu,pt	%xcc, 1f
-	 nop
-	call	boot_cpu_id_too_large
-	 nop
-	/* Not reached... */
-
-1:
-#else
-	mov	0, %o0
-#endif
-	stb	%o0, [%g6 + TI_CPU]
-
 	/* Off we go.... */
 	call	start_kernel
 	 nop
diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index 9cf1c88..005167f 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -220,7 +220,7 @@ char reboot_command[COMMAND_LINE_SIZE];
 
 static struct pt_regs fake_swapper_regs = { { 0, }, 0, 0, 0, 0 };
 
-void __init per_cpu_patch(void)
+static void __init per_cpu_patch(void)
 {
 	struct cpuid_patch_entry *p;
 	unsigned long ver;
@@ -280,7 +280,7 @@ void __init per_cpu_patch(void)
 	}
 }
 
-void __init sun4v_patch(void)
+static void __init sun4v_patch(void)
 {
 	struct sun4v_1insn_patch_entry *p1;
 	struct sun4v_2insn_patch_entry *p2;
@@ -315,15 +315,6 @@ void __init sun4v_patch(void)
 	}
 }
 
-#ifdef CONFIG_SMP
-void __init boot_cpu_id_too_large(int cpu)
-{
-	prom_printf("Serious problem, boot cpu id (%d) >= NR_CPUS (%d)\n",
-		    cpu, NR_CPUS);
-	prom_halt();
-}
-#endif
-
 void __init setup_arch(char **cmdline_p)
 {
 	/* Initialize PROM console and command line. */
@@ -341,6 +332,16 @@ #elif defined(CONFIG_PROM_CONSOLE)
 	conswitchp = &prom_con;
 #endif
 
+	/* Work out if we are starfire early on */
+	check_if_starfire();
+
+	/* Now we know enough to patch the get_cpuid sequences
+	 * used by trap code.
+	 */
+	per_cpu_patch();
+
+	sun4v_patch();
+
 	boot_flags_init(*cmdline_p);
 
 	idprom_init();
diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index 4e8cd79..90eaca3 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -1264,6 +1264,7 @@ void __init smp_tick_init(void)
 	boot_cpu_id = hard_smp_processor_id();
 	current_tick_offset = timer_tick_offset;
 
+	cpu_set(boot_cpu_id, cpu_online_map);
 	prof_counter(boot_cpu_id) = prof_multiplier(boot_cpu_id) = 1;
 }
 
@@ -1344,6 +1345,18 @@ void __init smp_setup_cpu_possible_map(v
 
 void __devinit smp_prepare_boot_cpu(void)
 {
+	int cpu = hard_smp_processor_id();
+
+	if (cpu >= NR_CPUS) {
+		prom_printf("Serious problem, boot cpu id >= NR_CPUS\n");
+		prom_halt();
+	}
+
+	current_thread_info()->cpu = cpu;
+	__local_per_cpu_offset = __per_cpu_offset(cpu);
+
+	cpu_set(smp_processor_id(), cpu_online_map);
+	cpu_set(smp_processor_id(), phys_cpu_present_map);
 }
 
 int __devinit __cpu_up(unsigned int cpu)
@@ -1420,7 +1433,4 @@ #endif
 
 	for (i = 0; i < NR_CPUS; i++, ptr += size)
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
-
-	/* Setup %g5 for the boot cpu.  */
-	__local_per_cpu_offset = __per_cpu_offset(smp_processor_id());
 }
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 8e9d848..11ce6aa 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -133,7 +133,6 @@ struct cfq_data {
 	mempool_t *crq_pool;
 
 	int rq_in_driver;
-	int hw_tag;
 
 	/*
 	 * schedule slice state info
@@ -501,13 +500,10 @@ static void cfq_resort_rr_list(struct cf
 
 	/*
 	 * if queue was preempted, just add to front to be fair. busy_rr
-	 * isn't sorted, but insert at the back for fairness.
+	 * isn't sorted.
 	 */
 	if (preempted || list == &cfqd->busy_rr) {
-		if (preempted)
-			list = list->prev;
-
-		list_add_tail(&cfqq->cfq_list, list);
+		list_add(&cfqq->cfq_list, list);
 		return;
 	}
 
@@ -668,15 +664,6 @@ static void cfq_activate_request(request
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 
 	cfqd->rq_in_driver++;
-
-	/*
-	 * If the depth is larger 1, it really could be queueing. But lets
-	 * make the mark a little higher - idling could still be good for
-	 * low queueing, and a low queueing number could also just indicate
-	 * a SCSI mid layer like behaviour where limit+1 is often seen.
-	 */
-	if (!cfqd->hw_tag && cfqd->rq_in_driver > 4)
-		cfqd->hw_tag = 1;
 }
 
 static void cfq_deactivate_request(request_queue_t *q, struct request *rq)
@@ -892,13 +879,6 @@ static struct cfq_queue *cfq_set_active_
 		cfqq = list_entry_cfqq(cfqd->cur_rr.next);
 
 	/*
-	 * If no new queues are available, check if the busy list has some
-	 * before falling back to idle io.
-	 */
-	if (!cfqq && !list_empty(&cfqd->busy_rr))
-		cfqq = list_entry_cfqq(cfqd->busy_rr.next);
-
-	/*
 	 * if we have idle queues and no rt or be queues had pending
 	 * requests, either allow immediate service if the grace period
 	 * has passed or arm the idle grace timer
@@ -1478,8 +1458,7 @@ retry:
 		 * set ->slice_left to allow preemption for a new process
 		 */
 		cfqq->slice_left = 2 * cfqd->cfq_slice_idle;
-		if (!cfqd->hw_tag)
-			cfq_mark_cfqq_idle_window(cfqq);
+		cfq_mark_cfqq_idle_window(cfqq);
 		cfq_mark_cfqq_prio_changed(cfqq);
 		cfq_init_prio_data(cfqq);
 	}
@@ -1670,7 +1649,7 @@ cfq_update_idle_window(struct cfq_data *
 {
 	int enable_idle = cfq_cfqq_idle_window(cfqq);
 
-	if (!cic->ioc->task || !cfqd->cfq_slice_idle || cfqd->hw_tag)
+	if (!cic->ioc->task || !cfqd->cfq_slice_idle)
 		enable_idle = 0;
 	else if (sample_valid(cic->ttime_samples)) {
 		if (cic->ttime_mean > cfqd->cfq_slice_idle)
@@ -1761,24 +1740,14 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
 
 	cfqq->next_crq = cfq_choose_req(cfqd, cfqq->next_crq, crq);
 
-	cic = crq->io_context;
-
 	/*
 	 * we never wait for an async request and we don't allow preemption
 	 * of an async request. so just return early
 	 */
-	if (!cfq_crq_is_sync(crq)) {
-		/*
-		 * sync process issued an async request, if it's waiting
-		 * then expire it and kick rq handling.
-		 */
-		if (cic == cfqd->active_cic &&
-		    del_timer(&cfqd->idle_slice_timer)) {
-			cfq_slice_expired(cfqd, 0);
-			cfq_start_queueing(cfqd, cfqq);
-		}
+	if (!cfq_crq_is_sync(crq))
 		return;
-	}
+
+	cic = crq->io_context;
 
 	cfq_update_io_thinktime(cfqd, cic);
 	cfq_update_io_seektime(cfqd, cic, crq);
@@ -2196,9 +2165,10 @@ static void cfq_idle_class_timer(unsigne
 	 * race with a non-idle queue, reset timer
 	 */
 	end = cfqd->last_end_request + CFQ_IDLE_GRACE;
-	if (!time_after_eq(jiffies, end))
-		mod_timer(&cfqd->idle_class_timer, end);
-	else
+	if (!time_after_eq(jiffies, end)) {
+		cfqd->idle_class_timer.expires = end;
+		add_timer(&cfqd->idle_class_timer);
+	} else
 		cfq_schedule_dispatch(cfqd);
 
 	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index a300840..9080853 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1605,21 +1605,6 @@ mpt_resume(struct pci_dev *pdev)
 }
 #endif
 
-static int
-mpt_signal_reset(int index, MPT_ADAPTER *ioc, int reset_phase)
-{
-	if ((MptDriverClass[index] == MPTSPI_DRIVER &&
-	     ioc->bus_type != SPI) ||
-	    (MptDriverClass[index] == MPTFC_DRIVER &&
-	     ioc->bus_type != FC) ||
-	    (MptDriverClass[index] == MPTSAS_DRIVER &&
-	     ioc->bus_type != SAS))
-		/* make sure we only call the relevant reset handler
-		 * for the bus */
-		return 0;
-	return (MptResetHandlers[index])(ioc, reset_phase);
-}
-
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*
  *	mpt_do_ioc_recovery - Initialize or recover MPT adapter.
@@ -1900,14 +1885,14 @@ #endif
 			if ((ret == 0) && MptResetHandlers[ii]) {
 				dprintk((MYIOC_s_INFO_FMT "Calling IOC post_reset handler #%d\n",
 						ioc->name, ii));
-				rc += mpt_signal_reset(ii, ioc, MPT_IOC_POST_RESET);
+				rc += (*(MptResetHandlers[ii]))(ioc, MPT_IOC_POST_RESET);
 				handlers++;
 			}
 
 			if (alt_ioc_ready && MptResetHandlers[ii]) {
 				drsprintk((MYIOC_s_INFO_FMT "Calling alt-%s post_reset handler #%d\n",
 						ioc->name, ioc->alt_ioc->name, ii));
-				rc += mpt_signal_reset(ii, ioc->alt_ioc, MPT_IOC_POST_RESET);
+				rc += (*(MptResetHandlers[ii]))(ioc->alt_ioc, MPT_IOC_POST_RESET);
 				handlers++;
 			}
 		}
@@ -3282,11 +3267,11 @@ #endif
 				if (MptResetHandlers[ii]) {
 					dprintk((MYIOC_s_INFO_FMT "Calling IOC pre_reset handler #%d\n",
 							ioc->name, ii));
-					r += mpt_signal_reset(ii, ioc, MPT_IOC_PRE_RESET);
+					r += (*(MptResetHandlers[ii]))(ioc, MPT_IOC_PRE_RESET);
 					if (ioc->alt_ioc) {
 						dprintk((MYIOC_s_INFO_FMT "Calling alt-%s pre_reset handler #%d\n",
 								ioc->name, ioc->alt_ioc->name, ii));
-						r += mpt_signal_reset(ii, ioc->alt_ioc, MPT_IOC_PRE_RESET);
+						r += (*(MptResetHandlers[ii]))(ioc->alt_ioc, MPT_IOC_PRE_RESET);
 					}
 				}
 			}
@@ -5721,11 +5706,11 @@ #endif
 			if (MptResetHandlers[ii]) {
 				dtmprintk((MYIOC_s_INFO_FMT "Calling IOC reset_setup handler #%d\n",
 						ioc->name, ii));
-				r += mpt_signal_reset(ii, ioc, MPT_IOC_SETUP_RESET);
+				r += (*(MptResetHandlers[ii]))(ioc, MPT_IOC_SETUP_RESET);
 				if (ioc->alt_ioc) {
 					dtmprintk((MYIOC_s_INFO_FMT "Calling alt-%s setup reset handler #%d\n",
 							ioc->name, ioc->alt_ioc->name, ii));
-					r += mpt_signal_reset(ii, ioc->alt_ioc, MPT_IOC_SETUP_RESET);
+					r += (*(MptResetHandlers[ii]))(ioc->alt_ioc, MPT_IOC_SETUP_RESET);
 				}
 			}
 		}
diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
index 108910f..fee843f 100644
--- a/drivers/scsi/ppa.c
+++ b/drivers/scsi/ppa.c
@@ -982,12 +982,6 @@ static int device_check(ppa_struct *dev)
 	return -ENODEV;
 }
 
-static int ppa_adjust_queue(struct scsi_device *device)
-{
-	blk_queue_bounce_limit(device->request_queue, BLK_BOUNCE_HIGH);
-	return 0;
-}
-
 static struct scsi_host_template ppa_template = {
 	.module			= THIS_MODULE,
 	.proc_name		= "ppa",
@@ -1003,7 +997,6 @@ static struct scsi_host_template ppa_tem
 	.cmd_per_lun		= 1,
 	.use_clustering		= ENABLE_CLUSTERING,
 	.can_queue		= 1,
-	.slave_alloc		= ppa_adjust_queue,
 };
 
 /***************************************************************************
diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 62f8cb7..941c1e1 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -165,7 +165,6 @@ static struct {
 	{"HP", "HSV100", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
 	{"HP", "C1557A", NULL, BLIST_FORCELUN},
 	{"HP", "C3323-300", "4269", BLIST_NOTQ},
-	{"HP", "C5713A", NULL, BLIST_NOREPORTLUN},
 	{"IBM", "AuSaV1S2", NULL, BLIST_FORCELUN},
 	{"IBM", "ProFibre 4000R", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"IBM", "2105", NULL, BLIST_RETRY_HWERROR},
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index faee475..764a8b3 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -367,7 +367,7 @@ static int scsi_req_map_sg(struct reques
 			   int nsegs, unsigned bufflen, gfp_t gfp)
 {
 	struct request_queue *q = rq->q;
-	int nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned int data_len = 0, len, bytes, off;
 	struct page *page;
 	struct bio *bio = NULL;
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index f3b1606..8b6d65e 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -955,8 +955,7 @@ static int sas_user_scan(struct Scsi_Hos
 	list_for_each_entry(rphy, &sas_host->rphy_list, list) {
 		struct sas_phy *parent = dev_to_phy(rphy->dev.parent);
 
-		if (rphy->identify.device_type != SAS_END_DEVICE ||
-		    rphy->scsi_target_id == -1)
+		if (rphy->scsi_target_id == -1)
 			continue;
 
 		if ((channel == SCAN_WILD_CARD || channel == parent->port_identifier) &&
@@ -978,6 +977,7 @@ static int sas_user_scan(struct Scsi_Hos
 #define SETUP_TEMPLATE(attrb, field, perm, test)				\
 	i->private_##attrb[count] = class_device_attr_##field;		\
 	i->private_##attrb[count].attr.mode = perm;			\
+	i->private_##attrb[count].store = NULL;				\
 	i->attrb[count] = &i->private_##attrb[count];			\
 	if (test)							\
 		count++
diff --git a/include/asm-arm/arch-ixp23xx/memory.h b/include/asm-arm/arch-ixp23xx/memory.h
index c85fc06..6e19f46 100644
--- a/include/asm-arm/arch-ixp23xx/memory.h
+++ b/include/asm-arm/arch-ixp23xx/memory.h
@@ -49,7 +49,7 @@ static inline int __ixp23xx_arch_is_cohe
 {
 	extern unsigned int processor_id;
 
-	if (((processor_id & 15) >= 4) || machine_is_roadrunner())
+	if (((processor_id & 15) >= 2) || machine_is_roadrunner())
 		return 1;
 
 	return 0;
diff --git a/include/asm-arm/cacheflush.h b/include/asm-arm/cacheflush.h
index 746be56..7ab6ec3 100644
--- a/include/asm-arm/cacheflush.h
+++ b/include/asm-arm/cacheflush.h
@@ -331,6 +331,12 @@ #define flush_dcache_mmap_lock(mapping) 
 #define flush_dcache_mmap_unlock(mapping) \
 	write_unlock_irq(&(mapping)->tree_lock)
 
+static inline void flush_kernel_dcache_page(struct page *page)
+{
+	__cpuc_flush_dcache_page(page_address(page));
+}
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+
 #define flush_icache_user_range(vma,page,addr,len) \
 	flush_dcache_page(page)
 
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index c2059a3..358e4d3 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -159,8 +159,17 @@ #ifndef __HAVE_ARCH_LAZY_MMU_PROT_UPDATE
 #define lazy_mmu_prot_update(pte)	do { } while (0)
 #endif
 
-#ifndef __HAVE_ARCH_MOVE_PTE
+#ifndef __HAVE_ARCH_MULTIPLE_ZERO_PAGE
 #define move_pte(pte, prot, old_addr, new_addr)	(pte)
+#else
+#define move_pte(pte, prot, old_addr, new_addr)				\
+({									\
+ 	pte_t newpte = (pte);						\
+	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
+			pte_page(pte) == ZERO_PAGE(old_addr))		\
+		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
+	newpte;								\
+})
 #endif
 
 /*
diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index f80fe75..174a3cd 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -70,15 +70,7 @@ extern unsigned long zero_page_mask;
 #define ZERO_PAGE(vaddr) \
 	(virt_to_page(empty_zero_page + (((unsigned long)(vaddr)) & zero_page_mask)))
 
-#define __HAVE_ARCH_MOVE_PTE
-#define move_pte(pte, prot, old_addr, new_addr)				\
-({									\
- 	pte_t newpte = (pte);						\
-	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
-			pte_page(pte) == ZERO_PAGE(old_addr))		\
-		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
-	newpte;								\
-})
+#define __HAVE_ARCH_MULTIPLE_ZERO_PAGE
 
 extern void paging_init(void);
 
diff --git a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
index cd464f4..c44e746 100644
--- a/include/asm-sparc64/pgtable.h
+++ b/include/asm-sparc64/pgtable.h
@@ -689,23 +689,6 @@ static inline void set_pte_at(struct mm_
 #define pte_clear(mm,addr,ptep)		\
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
 
-#ifdef DCACHE_ALIASING_POSSIBLE
-#define __HAVE_ARCH_MOVE_PTE
-#define move_pte(pte, prot, old_addr, new_addr)				\
-({									\
- 	pte_t newpte = (pte);						\
-	if (tlb_type != hypervisor && pte_present(pte)) {		\
-		unsigned long this_pfn = pte_pfn(pte);			\
-									\
-		if (pfn_valid(this_pfn) &&				\
-		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
-			flush_dcache_page_all(current->mm,		\
-					      pfn_to_page(this_pfn));	\
-	}								\
-	newpte;								\
-})
-#endif
-
 extern pgd_t swapper_pg_dir[2048];
 extern pmd_t swapper_low_pmd_dir[2048];
 
diff --git a/mm/slab.c b/mm/slab.c
index f1b644e..d31a06b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -207,6 +207,11 @@ #define BUFCTL_FREE	(((kmem_bufctl_t)(~0
 #define	BUFCTL_ACTIVE	(((kmem_bufctl_t)(~0U))-2)
 #define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-3)
 
+/* Max number of objs-per-slab for caches which use off-slab slabs.
+ * Needed to avoid a possible looping condition in cache_grow().
+ */
+static unsigned long offslab_limit;
+
 /*
  * struct slab
  *
@@ -1351,6 +1356,12 @@ void __init kmem_cache_init(void)
 					NULL, NULL);
 		}
 
+		/* Inc off-slab bufctl limit until the ceiling is hit. */
+		if (!(OFF_SLAB(sizes->cs_cachep))) {
+			offslab_limit = sizes->cs_size - sizeof(struct slab);
+			offslab_limit /= sizeof(kmem_bufctl_t);
+		}
+
 		sizes->cs_dmacachep = kmem_cache_create(names->name_dma,
 					sizes->cs_size,
 					ARCH_KMALLOC_MINALIGN,
@@ -1769,7 +1780,6 @@ static void set_up_list3s(struct kmem_ca
 static size_t calculate_slab_order(struct kmem_cache *cachep,
 			size_t size, size_t align, unsigned long flags)
 {
-	unsigned long offslab_limit;
 	size_t left_over = 0;
 	int gfporder;
 
@@ -1781,18 +1791,9 @@ static size_t calculate_slab_order(struc
 		if (!num)
 			continue;
 
-		if (flags & CFLGS_OFF_SLAB) {
-			/*
-			 * Max number of objs-per-slab for caches which
-			 * use off-slab slabs. Needed to avoid a possible
-			 * looping condition in cache_grow().
-			 */
-			offslab_limit = size - sizeof(struct slab);
-			offslab_limit /= sizeof(kmem_bufctl_t);
-
- 			if (num > offslab_limit)
-				break;
-		}
+		/* More than offslab_limit objects will cause problems */
+		if ((flags & CFLGS_OFF_SLAB) && num > offslab_limit)
+			break;
 
 		/* Found something acceptable - save it away */
 		cachep->num = num;
diff --git a/net/ipv4/tcp_highspeed.c b/net/ipv4/tcp_highspeed.c
index ba7c63c..b72fa55 100644
--- a/net/ipv4/tcp_highspeed.c
+++ b/net/ipv4/tcp_highspeed.c
@@ -135,8 +135,7 @@ static void hstcp_cong_avoid(struct sock
 
 		/* Do additive increase */
 		if (tp->snd_cwnd < tp->snd_cwnd_clamp) {
-			/* cwnd = cwnd + a(w) / cwnd */
-			tp->snd_cwnd_cnt += ca->ai + 1;
+			tp->snd_cwnd_cnt += ca->ai;
 			if (tp->snd_cwnd_cnt >= tp->snd_cwnd) {
 				tp->snd_cwnd_cnt -= tp->snd_cwnd;
 				tp->snd_cwnd++;
-- 
1.3.2



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTJBBoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 21:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTJBBn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 21:43:57 -0400
Received: from trained-monkey.org ([209.217.122.11]:37897 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S263116AbTJBBnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 21:43:50 -0400
From: Jes Sorensen <jes@wildopensource.com>
Message-ID: <16251.33499.73980.29848@trained-monkey.org>
Date: Wed, 1 Oct 2003 21:43:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Subject: [patch] qla1280 locking update
X-Mailer: VM 7.13 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resent to the mailing list - tried to send it to vger.rutgers.edu again]

Hi Linus,

This patch fixes the qla1280 driver to not try and release an unlocked
spin lock at boot time in 2.6 as well as a couple of other minor mods.
I also changed the MMIO option to be dependant on X86_VISWS as it's
really a chipset problem and not something each and every driver should
be asking for. Getting a global CONFIG_MMIO_IS_BROKEN option would
probable be a win here.

Patch against 2.6-test6.

Cheers,
Jes

--- ../new/linux-2.6.0-test6/drivers/scsi/qla1280.c	Sat Sep 27 17:51:17 2003
+++ linux/drivers/scsi/qla1280.c	Wed Oct  1 18:28:25 2003
@@ -16,10 +16,15 @@
 * General Public License for more details.
 *
 ******************************************************************************/
-#define QLA1280_VERSION      "3.23.36"
+#define QLA1280_VERSION      "3.23.37"
 /*****************************************************************************
     Revision History:
-    Rev  3.23.36 September 19, 2003, Christoph Hellwig
+    Rev  3.23.37 October 1, 2003, Jes Sorensen
+	- Make MMIO depend on CONFIG_X86_VISWS instead of yet another
+	  random CONFIG option
+	- Clean up locking in probe path
+    Rev  3.23.36 October 1, 2003, Christoph Hellwig
+	- queuecommand only ever receives new commands - clear flags
 	- Reintegrate lost fixes from Linux 2.5
     Rev  3.23.35 August 14, 2003, Jes Sorensen
 	- Build against 2.6
@@ -315,14 +320,14 @@
 
 #if LINUX_VERSION_CODE >= 0x020545
 #include <scsi/scsi_host.h>
+#include "scsi.h"
 #else
 #include <linux/blk.h>
+#include "scsi.h"
 #include "hosts.h"
 #include "sd.h"
 #endif
 
-#include "scsi.h"
-
 #if LINUX_VERSION_CODE < 0x020407
 #error "Kernels older than 2.4.7 are no longer supported"
 #endif
@@ -339,7 +344,10 @@
 #define  DEBUG_PRINT_NVRAM	0
 #define  DEBUG_QLA1280		0
 
-#ifdef	CONFIG_SCSI_QLOGIC_1280_PIO
+/*
+ * The SGI VISWS is broken and doesn't support MMIO ;-(
+ */
+#ifdef CONFIG_X86_VISWS
 #define	MEMORY_MAPPED_IO	0
 #else
 #define	MEMORY_MAPPED_IO	1
@@ -414,6 +422,11 @@
 #else
 #define HOST_LOCK			ha->host->host_lock
 #endif
+#if LINUX_VERSION_CODE < 0x020600
+#define DEV_SIMPLE_TAGS(device)		device->tagged_queue
+#else
+#define DEV_SIMPLE_TAGS(device)		device->simple_tags
+#endif
 #if defined(__ia64__) && !defined(ia64_platform_is)
 #define ia64_platform_is(foo)		(!strcmp(x, platform_name))
 #endif
@@ -647,11 +660,11 @@
 #define	PROC_BUF	&qla1280_buffer[len]
 
 #if LINUX_VERSION_CODE < 0x020600
-static int qla1280_proc_info(char *buffer, char **start, off_t offset, int length,
-		      int hostno, int inout)
+static int qla1280_proc_info(char *buffer, char **start, off_t offset,
+			     int length, int hostno, int inout)
 #else
-static int qla1280_proc_info(struct Scsi_Host *host, char *buffer, char **start,
-		      off_t offset, int length, int inout)
+static int qla1280_proc_info(struct Scsi_Host *host, char *buffer,
+			     char **start, off_t offset, int length, int inout)
 #endif
 {
 	struct scsi_qla_host *ha;
@@ -955,8 +968,8 @@
 		       host->io_port, host->io_port + 0xff);
 		goto error_free_irq;
 	}
-
 #endif
+
 	/* load the F/W, read paramaters, and init the H/W */
 	if (qla1280_initialize_adapter(ha)) {
 		printk(KERN_INFO "qla1x160: Failed to initialize adapter\n");
@@ -1598,6 +1611,7 @@
 	return IRQ_RETVAL(handled);
 }
 
+
 static int
 qla12160_set_target_parameters(struct scsi_qla_host *ha, int bus, int target)
 {
@@ -1666,9 +1680,7 @@
 	int target = device->id;
 	int status = 0;
 	struct nvram *nv;
-#if LINUX_VERSION_CODE < 0x020500
 	unsigned long flags;
-#endif
 
 	ha = (struct scsi_qla_host *)device->host->hostdata;
 	nv = &ha->nvram;
@@ -1706,17 +1718,13 @@
 			nv->bus[bus].target[target].ppr_1x160.flags.enable_ppr = 0;
 	}
 
-#if LINUX_VERSION_CODE < 0x020500
 	spin_lock_irqsave(HOST_LOCK, flags);
-#endif
 	if (nv->bus[bus].target[target].parameter.f.enable_sync) {
 		status = qla12160_set_target_parameters(ha, bus, target);
 	}
 
 	qla12160_get_target_parameters(ha, device);
-#if LINUX_VERSION_CODE < 0x020500
 	spin_unlock_irqrestore(HOST_LOCK, flags);
-#endif
 	return status;
 }
 
@@ -1995,7 +2003,7 @@
 	if (ha->request_ring)
 		pci_free_consistent(ha->pdev,
                                     ((REQUEST_ENTRY_CNT + 1) *
-                                     (sizeof(request_t))),
+				     (sizeof(request_t))),
                                     ha->request_ring, ha->request_dma);
  finish:
 	LEAVE("qla1280_mem_alloc");
@@ -2088,6 +2096,9 @@
 	struct device_reg *reg;
 	int status;
 	int bus;
+#if LINUX_VERSION_CODE > 0x020500
+	unsigned long flags;
+#endif
 
 	ENTER("qla1280_initialize_adapter");
 
@@ -2131,6 +2142,15 @@
 			"NVRAM\n");
 	}
 
+#if LINUX_VERSION_CODE >= 0x020500
+	/*
+	 * It's necessary to grab the spin here as qla1280_mailbox_command
+	 * needs to be able to drop the lock unconditionally to wait
+	 * for completion.
+	 * In 2.4 ->detect is called with the io_request_lock held.
+	 */
+	spin_lock_irqsave(HOST_LOCK, flags);
+#endif
 	/* If firmware needs to be loaded */
 	if (qla1280_isp_firmware(ha)) {
 		if (!(status = qla1280_chip_diag (ha))) {
@@ -2183,6 +2203,9 @@
 		status = 1;
 
  out:
+#if LINUX_VERSION_CODE >= 0x020500
+	spin_unlock_irqrestore(HOST_LOCK, flags);
+#endif
 	if (status)
 		dprintk(2, "qla1280_initialize_adapter: **** FAILED ****\n");
 
@@ -3208,18 +3231,14 @@
 	timer.function = qla1280_mailbox_timeout;
 	add_timer(&timer);
 
-#if LINUX_VERSION_CODE < 0x020500
 	spin_unlock_irq(HOST_LOCK);
-#endif
 	WRT_REG_WORD(&reg->host_cmd, HC_SET_HOST_INT);
 	data = qla1280_debounce_register(&reg->istatus);
 
 	wait_for_completion(&wait);
 	del_timer_sync(&timer);
 
-#if LINUX_VERSION_CODE < 0x020500
 	spin_lock_irq(HOST_LOCK);
-#endif
 
 	ha->mailbox_wait = NULL;
 
@@ -3636,7 +3655,7 @@
 		(SCSI_TCN_32(cmd) | BIT_7) : SCSI_TCN_32(cmd);
 
 	/* Enable simple tag queuing if device supports it. */
-	if (cmd->device->simple_tags)
+	if (DEV_SIMPLE_TAGS(cmd->device))
 		pkt->control_flags |= cpu_to_le16(BIT_3);
 
 	/* Load SCSI command packet. */
@@ -3936,7 +3955,7 @@
 		(SCSI_TCN_32(cmd) | BIT_7) : SCSI_TCN_32(cmd);
 
 	/* Enable simple tag queuing if device supports it. */
-	if (cmd->device->simple_tags)
+	if (DEV_SIMPLE_TAGS(cmd->device))
 		pkt->control_flags |= cpu_to_le16(BIT_3);
 
 	/* Load SCSI command packet. */
@@ -4823,6 +4842,7 @@
 	return ret;
 }
 
+
 /************************************************************************
  * qla1280_check_for_dead_scsi_bus                                      *
  *                                                                      *
@@ -4891,7 +4911,7 @@
 	} else
 		printk(" Async");
 
-	if (device->simple_tags)
+	if (DEV_SIMPLE_TAGS(device))
 		printk(", Tagged queuing: depth %d", device->queue_depth);
 	printk("\n");
 }
@@ -5105,6 +5125,7 @@
 	return ret;
 }
 
+
 static Scsi_Host_Template driver_template = {
 	.proc_info		= qla1280_proc_info,
 	.name			= "Qlogic ISP 1280/12160",
@@ -5132,6 +5153,7 @@
 
 #include "scsi_module.c"
 
+
 /*
  * Overrides for Emacs so that we almost follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
--- ../new/linux-2.6.0-test6/drivers/scsi/Kconfig	Sat Sep 27 17:50:58 2003
+++ linux/drivers/scsi/Kconfig	Wed Oct  1 18:31:53 2003
@@ -1148,16 +1235,6 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called qla1280.
 
-config SCSI_QLOGIC_1280_PIO
-	bool "Use PIO instead of MMIO" if !X86_VISWS
-	depends on SCSI_QLOGIC_1280
-	default y if X86_VISWS
-	help
-	  This instructs the driver to use programmed I/O ports (PIO) instead
-	  of PCI shared memory (MMIO).  This can possibly solve some problems
-	  in case your mainboard has memory consistency issues.  If unsure,
-	  say N.
-
 config SCSI_QLOGICPTI
 	tristate "PTI Qlogic, ISP Driver"
 	depends on SBUS && SCSI

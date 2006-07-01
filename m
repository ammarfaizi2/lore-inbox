Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWGAPBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWGAPBy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWGAO5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:44 -0400
Received: from www.osadl.org ([213.239.205.134]:28836 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751498AbWGAO47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:56:59 -0400
Message-Id: <20060701145224.258259000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:29 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, tony.luck@intel.com
Subject: [RFC][patch 09/44] IA64: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-ia64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/ia64/hp/sim/simserial.c            |    2 +-
 arch/ia64/kernel/irq_ia64.c             |    2 +-
 arch/ia64/kernel/mca.c                  |   12 ++++++------
 arch/ia64/kernel/perfmon.c              |    2 +-
 arch/ia64/kernel/time.c                 |    2 +-
 arch/ia64/sn/kernel/huberror.c          |    4 ++--
 arch/ia64/sn/kernel/xpc_channel.c       |    2 +-
 arch/ia64/sn/pci/pcibr/pcibr_provider.c |    2 +-
 arch/ia64/sn/pci/tioca_provider.c       |    2 +-
 arch/ia64/sn/pci/tioce_provider.c       |    2 +-
 include/asm-ia64/signal.h               |    4 ----
 11 files changed, 16 insertions(+), 20 deletions(-)

Index: linux-2.6.git/include/asm-ia64/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-ia64/signal.h	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/include/asm-ia64/signal.h	2006-07-01 16:51:33.000000000 +0200
@@ -56,7 +56,6 @@
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons.
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -76,7 +75,6 @@
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
@@ -114,8 +112,6 @@
 #define _NSIG_BPW	64
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
 
-#define SA_PERCPU_IRQ		0x02000000
-
 #endif /* __KERNEL__ */
 
 #include <asm-generic/signal.h>
Index: linux-2.6.git/arch/ia64/hp/sim/simserial.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/hp/sim/simserial.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/ia64/hp/sim/simserial.c	2006-07-01 16:51:33.000000000 +0200
@@ -46,7 +46,7 @@
 
 #define NR_PORTS	1	/* only one port for now */
 
-#define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? SA_SHIRQ : SA_INTERRUPT)
+#define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? IRQF_SHARED : IRQF_DISABLED)
 
 #define SSC_GETCHAR	21
 
Index: linux-2.6.git/arch/ia64/kernel/irq_ia64.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/kernel/irq_ia64.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/ia64/kernel/irq_ia64.c	2006-07-01 16:51:33.000000000 +0200
@@ -235,7 +235,7 @@ extern irqreturn_t handle_IPI (int irq, 
 
 static struct irqaction ipi_irqaction = {
 	.handler =	handle_IPI,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"IPI"
 };
 #endif
Index: linux-2.6.git/arch/ia64/kernel/mca.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/kernel/mca.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/ia64/kernel/mca.c	2006-07-01 16:51:33.000000000 +0200
@@ -1457,38 +1457,38 @@ __setup("disable_cpe_poll", ia64_mca_dis
 
 static struct irqaction cmci_irqaction = {
 	.handler =	ia64_mca_cmc_int_handler,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"cmc_hndlr"
 };
 
 static struct irqaction cmcp_irqaction = {
 	.handler =	ia64_mca_cmc_int_caller,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"cmc_poll"
 };
 
 static struct irqaction mca_rdzv_irqaction = {
 	.handler =	ia64_mca_rendez_int_handler,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"mca_rdzv"
 };
 
 static struct irqaction mca_wkup_irqaction = {
 	.handler =	ia64_mca_wakeup_int_handler,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"mca_wkup"
 };
 
 #ifdef CONFIG_ACPI
 static struct irqaction mca_cpe_irqaction = {
 	.handler =	ia64_mca_cpe_int_handler,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"cpe_hndlr"
 };
 
 static struct irqaction mca_cpep_irqaction = {
 	.handler =	ia64_mca_cpe_int_caller,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"cpe_poll"
 };
 #endif /* CONFIG_ACPI */
Index: linux-2.6.git/arch/ia64/kernel/perfmon.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/kernel/perfmon.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/ia64/kernel/perfmon.c	2006-07-01 16:51:33.000000000 +0200
@@ -6439,7 +6439,7 @@ pfm_flush_pmds(struct task_struct *task,
 
 static struct irqaction perfmon_irqaction = {
 	.handler = pfm_interrupt_handler,
-	.flags   = SA_INTERRUPT,
+	.flags   = IRQF_DISABLED,
 	.name    = "perfmon"
 };
 
Index: linux-2.6.git/arch/ia64/kernel/time.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/kernel/time.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/ia64/kernel/time.c	2006-07-01 16:51:33.000000000 +0200
@@ -231,7 +231,7 @@ ia64_init_itm (void)
 
 static struct irqaction timer_irqaction = {
 	.handler =	timer_interrupt,
-	.flags =	SA_INTERRUPT,
+	.flags =	IRQF_DISABLED,
 	.name =		"timer"
 };
 
Index: linux-2.6.git/arch/ia64/sn/kernel/huberror.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/sn/kernel/huberror.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/ia64/sn/kernel/huberror.c	2006-07-01 16:51:33.000000000 +0200
@@ -178,7 +178,7 @@ void hubiio_crb_error_handler(struct hub
  */
 void hub_error_init(struct hubdev_info *hubdev_info)
 {
-	if (request_irq(SGI_II_ERROR, (void *)hub_eint_handler, SA_SHIRQ,
+	if (request_irq(SGI_II_ERROR, (void *)hub_eint_handler, IRQF_SHARED,
 			"SN_hub_error", (void *)hubdev_info))
 		printk("hub_error_init: Failed to request_irq for 0x%p\n",
 		    hubdev_info);
@@ -196,7 +196,7 @@ void hub_error_init(struct hubdev_info *
 void ice_error_init(struct hubdev_info *hubdev_info)
 {
         if (request_irq
-            (SGI_TIO_ERROR, (void *)hub_eint_handler, SA_SHIRQ, "SN_TIO_error",
+            (SGI_TIO_ERROR, (void *)hub_eint_handler, IRQF_SHARED, "SN_TIO_error",
              (void *)hubdev_info))
                 printk("ice_error_init: request_irq() error hubdev_info 0x%p\n",
                        hubdev_info);
Index: linux-2.6.git/arch/ia64/sn/kernel/xpc_channel.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/sn/kernel/xpc_channel.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/ia64/sn/kernel/xpc_channel.c	2006-07-01 16:51:33.000000000 +0200
@@ -202,7 +202,7 @@ xpc_setup_infrastructure(struct xpc_part
 	init_waitqueue_head(&part->channel_mgr_wq);
 
 	sprintf(part->IPI_owner, "xpc%02d", partid);
-	ret = request_irq(SGI_XPC_NOTIFY, xpc_notify_IRQ_handler, SA_SHIRQ,
+	ret = request_irq(SGI_XPC_NOTIFY, xpc_notify_IRQ_handler, IRQF_SHARED,
 				part->IPI_owner, (void *) (u64) partid);
 	if (ret != 0) {
 		dev_err(xpc_chan, "can't register NOTIFY IRQ handler, "
Index: linux-2.6.git/arch/ia64/sn/pci/tioca_provider.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/sn/pci/tioca_provider.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/ia64/sn/pci/tioca_provider.c	2006-07-01 16:51:33.000000000 +0200
@@ -646,7 +646,7 @@ tioca_bus_fixup(struct pcibus_bussoft *p
 
 	if (request_irq(SGI_TIOCA_ERROR,
 			tioca_error_intr_handler,
-			SA_SHIRQ, "TIOCA error", (void *)tioca_common))
+			IRQF_SHARED, "TIOCA error", (void *)tioca_common))
 		printk(KERN_WARNING
 		       "%s:  Unable to get irq %d.  "
 		       "Error interrupts won't be routed for TIOCA bus %d\n",
Index: linux-2.6.git/arch/ia64/sn/pci/tioce_provider.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/sn/pci/tioce_provider.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/ia64/sn/pci/tioce_provider.c	2006-07-01 16:51:33.000000000 +0200
@@ -1027,7 +1027,7 @@ tioce_bus_fixup(struct pcibus_bussoft *p
 
 	if (request_irq(SGI_PCIASIC_ERROR,
 			tioce_error_intr_handler,
-			SA_SHIRQ, "TIOCE error", (void *)tioce_common))
+			IRQF_SHARED, "TIOCE error", (void *)tioce_common))
 		printk(KERN_WARNING
 		       "%s:  Unable to get irq %d.  "
 		       "Error interrupts won't be routed for "
Index: linux-2.6.git/arch/ia64/sn/pci/pcibr/pcibr_provider.c
===================================================================
--- linux-2.6.git.orig/arch/ia64/sn/pci/pcibr/pcibr_provider.c	2006-07-01 16:51:26.000000000 +0200
+++ linux-2.6.git/arch/ia64/sn/pci/pcibr/pcibr_provider.c	2006-07-01 16:51:33.000000000 +0200
@@ -139,7 +139,7 @@ pcibr_bus_fixup(struct pcibus_bussoft *p
 	 * register the bridge's error interrupt handler
 	 */
 	if (request_irq(SGI_PCIASIC_ERROR, (void *)pcibr_error_intr_handler,
-			SA_SHIRQ, "PCIBR error", (void *)(soft))) {
+			IRQF_SHARED, "PCIBR error", (void *)(soft))) {
 		printk(KERN_WARNING
 		       "pcibr cannot allocate interrupt for error handler\n");
 	}

--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVCLBuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVCLBuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 20:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVCLBuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 20:50:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:7139 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261834AbVCLBqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 20:46:08 -0500
Date: Fri, 11 Mar 2005 19:46:03 -0600
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] PCI Error Recovery
Message-ID: <20050312014603.GC2609@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm, failed to cc the kernel mailing list ...

----- Forwarded message from Linas Vepstas <linas@austin.ibm.com> -----

To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, ak@muc.de,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	long <tlnguyen@snoqualmie.dp.intel.com>
Subject: [PATCH/RFC] PCI Error Recovery
From: Linas Vepstas <linas@austin.ibm.com>


Hi,

Appended is my current draft PCI Error Recovery patch.  
Per previous conversatios, it has moved some of the ppc64-specific 
error reporting code into generic PCI structures: see changes to 
include/linux/pci.h and a new file drivers/pci/pci-error.c.  Note 
in particular the pci bus states enumerated in 
"enum pci_device_io_state"; BenH was suggesting having
more of these ... BenH do you want to propose a "final list"?

I named the generic pci error recovery routines "peh" because
my brain froze.  Better suggestions invited.

The patch includes error recovery code for the IPR scsi device 
driver that uses the new generic PCI interfaces.  There's also
some prototype symbios scsi recovery code, but I haven't had
a chance to test it due to hardware issues. Ignore the debug 
statements.

The last chunk of this patch is ppc64 specific code; it uses
the new generic interfaces where it can.

Please review, comment, criticize and suggest.  I am eager to 
get the pci-generic parts nailed down, and want to really 
start moving in a direction that would let this go into mainline.

--linas

p.s. It should apply cleanly to kernel.org 2.6.11 and will
recover from pci errors sent to IPR and ethernet on power5 boxes.
I haven't tested on power4.



--- include/linux/pci.h.linas-orig	2005-03-09 02:11:40.000000000 -0600
+++ include/linux/pci.h	2005-03-11 18:00:46.000000000 -0600
@@ -659,6 +659,63 @@ struct pci_dynids {
 	unsigned int use_driver_data:1; /* pci_driver->driver_data is used */
 };
 
+/* ---------------------------------------------------------------- */
+/** PCI error recovery state.  Whenever the PCI bus state changes,
+ *  the io_state_change() callback will be called to notify the 
+ *  device driver os state changes.
+ */
+
+enum pci_device_io_state {
+	pci_device_io_frozen = 1, /* I/O to device is blocked */
+	pci_device_io_thawed,     /* I/O te device is (re-)enabled */
+	pci_device_io_perm_failure, /* pci card is dead */
+};
+
+/**
+ * PCI Error notifier event flags.
+ */
+#define PEH_NOTIFY_ERROR 1
+
+/** PEH event -- structure holding pci controller data that describes
+ *  a change in the isolation status of a PCI slot.  A pointer
+ *  to this struct is passed as the data pointer in a notify callback.
+ */
+struct peh_event {
+	struct list_head     list;
+	struct pci_dev       *dev;  /* affected device */
+	enum pci_device_io_state  state; /* PCI bus state for the affected device */
+	int time_unavail;    /* milliseconds until device might be available */
+};
+
+/**
+ * peh_send_failure_event - generate a PCI error event
+ * @dev pci device
+ *
+ * This routine builds a PCI error event which will be delivered 
+ * to all listeners on the peh_notifier_chain.
+ * 
+ * This routine can be called within an interrupt context;
+ * the actual event will be delivered in a normal context
+ * (from a workqueue).  
+ */
+int peh_send_failure_event (struct pci_dev *dev, 
+                            enum pci_device_io_state state, 
+                            int time_unavail);
+
+/**
+ * peh_register_notifier - Register to find out about EEH events.
+ * @nb: notifier block to callback on events
+ */
+int peh_register_notifier(struct notifier_block *nb);
+
+/**
+ * peh_unregister_notifier - Unregister to an EEH event notifier.
+ * @nb: notifier block to callback on events
+ */
+int peh_unregister_notifier(struct notifier_block *nb);
+
+/* ---------------------------------------------------------------- */
+
 struct module;
 struct pci_driver {
 	struct list_head node;
@@ -670,6 +727,7 @@ struct pci_driver {
 	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
+	int  (*io_state_change) (struct pci_dev *, enum pci_device_io_state); /* state change */
 
 	struct device_driver	driver;
 	struct pci_dynids dynids;
--- drivers/pci/Makefile.linas-orig	2005-03-09 02:12:50.000000000 -0600
+++ drivers/pci/Makefile	2005-03-11 18:19:29.000000000 -0600
@@ -3,7 +3,7 @@
 #
 
 obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
-			names.o pci-driver.o search.o pci-sysfs.o \
+			names.o pci-driver.o pci-error.o search.o pci-sysfs.o \
 			rom.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
--- drivers/pci/pci-error.c.linas-orig	2005-03-11 18:21:20.000000000 -0600
+++ drivers/pci/pci-error.c	2005-03-11 18:23:47.000000000 -0600
@@ -0,0 +1,152 @@
+/*
+ * pci-error.c
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/pci.h>
+
+#undef DEBUG
+
+/** Overview:
+ *  PEH, or "PCI Error Handling" is a PCI bridge technology for
+ *  dealing with PCI bus errors that can't be dealt with within the
+ *  usual PCI framework, except by check-stopping the CPU.  Systems
+ *  that are designed for high-availability/reliability cannot afford
+ *  to crash due to a "mere" PCI error, thus the need for PEH.
+ *  An PEH-capable bridge operates by converting a detected error
+ *  into a "slot freeze", taking the PCI adapter off-line, making
+ *  the slot behave, from the OS'es point of view, as if the slot
+ *  were "empty": all reads return 0xff's and all writes are silently
+ *  ignored.  PEH slot isolation events can be triggered by parity
+ *  errors on the address or data busses (e.g. during posted writes),
+ *  which in turn might be caused by low voltage on the bus, dust, 
+ *  vibration, humidity, radioactivity or plain-old failed hardware.
+ *
+ *  Note, however, that one of the leading causes of PEH slot
+ *  freeze events are buggy device drivers, buggy device microcode,
+ *  or buggy device hardware.  This is because any attempt by the
+ *  device to bus-master data to a memory address that is not
+ *  assigned to the device will trigger a slot freeze.   (The idea
+ *  is to prevent devices-gone-wild from corrupting system memory).
+ *  Buggy hardware/drivers will have a miserable time co-existing
+ *  with PEH.
+ */
+
+/* PEH event workqueue setup. */
+static spinlock_t peh_eventlist_lock = SPIN_LOCK_UNLOCKED;
+LIST_HEAD(peh_eventlist);
+static void peh_event_handler(void *);
+DECLARE_WORK(peh_event_wq, peh_event_handler, NULL);
+
+static struct notifier_block *peh_notifier_chain;
+
+/**
+ * peh_event_handler - dispatch PEH events.  The detection of a frozen
+ * slot can occur inside an interrupt, where it can be hard to do
+ * anything about it.  The goal of this routine is to pull these
+ * detection events out of the context of the interrupt handler, and
+ * re-dispatch them for processing at a later time in a normal context.
+ *
+ * @dummy - unused
+ */
+static void peh_event_handler(void *dummy)
+{
+	unsigned long flags;
+	struct peh_event	*event;
+
+	while (1) {
+		spin_lock_irqsave(&peh_eventlist_lock, flags);
+		event = NULL;
+		if (!list_empty(&peh_eventlist)) {
+			event = list_entry(peh_eventlist.next, struct peh_event, list);
+			list_del(&event->list);
+		}
+		spin_unlock_irqrestore(&peh_eventlist_lock, flags);
+		if (event == NULL)
+			break;
+
+		printk(KERN_INFO "PEH: Detected PCI bus error on device "
+		       "%s %s\n", 
+		       pci_name(event->dev), pci_pretty_name(event->dev));
+
+		notifier_call_chain (&peh_notifier_chain,
+		           PEH_NOTIFY_ERROR, event);
+
+		pci_dev_put(event->dev);
+		kfree(event);
+	}
+}
+
+
+/**
+ * peh_send_failure_event - generate a PCI error event
+ * @dev pci device
+ *
+ * This routine builds a PCI error event which will be delivered 
+ * to all listeners on the peh_notifier_chain.
+ * 
+ * This routine can be called within an interrupt context;
+ * the actual event will be delivered in a normal context
+ * (from a workqueue).  
+ */
+int peh_send_failure_event (struct pci_dev *dev, 
+                            enum pci_device_io_state state, 
+                            int time_unavail)
+{
+	unsigned long flags;
+	struct peh_event *event;
+	
+	event = kmalloc(sizeof(*event), GFP_ATOMIC);
+	if (event == NULL) {
+		printk (KERN_ERR "PEH: out of memory, event not handled\n");
+		return 1;
+ 	}
+
+	event->dev = dev;
+	event->state = state;
+	event->time_unavail = time_unavail;
+
+	/* We may or may not be called in an interrupt context */
+	spin_lock_irqsave(&peh_eventlist_lock, flags);
+	list_add(&event->list, &peh_eventlist);
+	spin_unlock_irqrestore(&peh_eventlist_lock, flags);
+
+	schedule_work(&peh_event_wq);
+
+	return 0;
+}
+
+/**
+ * peh_register_notifier - Register to find out about EEH events.
+ * @nb: notifier block to callback on events
+ */
+int peh_register_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_register(&peh_notifier_chain, nb);
+}
+
+/**
+ * peh_unregister_notifier - Unregister to an EEH event notifier.
+ * @nb: notifier block to callback on events
+ */
+int peh_unregister_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&peh_notifier_chain, nb);
+}
+
+
--- drivers/scsi/ipr.c.linas-orig	2005-03-09 02:13:17.000000000 -0600
+++ drivers/scsi/ipr.c	2005-03-10 14:54:27.000000000 -0600
@@ -80,6 +80,8 @@
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_request.h>
+
+#define CONFIG_SCSI_IPR_EEH
 #include "ipr.h"
 
 /*
@@ -4993,6 +4995,7 @@ static int ipr_reset_start_bist(struct i
 	return rc;
 }
 
+
 /**
  * ipr_reset_allowed - Query whether or not IOA can be reset
  * @ioa_cfg:	ioa config struct
@@ -5306,6 +5309,68 @@ static void ipr_initiate_ioa_reset(struc
 				shutdown_type);
 }
 
+#ifdef CONFIG_SCSI_IPR_EEH
+
+/** If the PCI slot is frozen, hold off all i/o
+ *  activity; then, as soon as the slot is available again,
+ *  initiate an adapter reset.
+ */
+static int ipr_reset_freeze(struct ipr_cmnd *ipr_cmd)
+{
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->ioa_cfg->pending_q);
+	ipr_cmd->done = ipr_reset_ioa_job;
+	return IPR_RC_JOB_RETURN;
+}
+
+static void ipr_eeh_frozen (struct pci_dev *pdev)
+{
+	unsigned long flags = 0;
+	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(pdev);
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, flags);
+	_ipr_initiate_ioa_reset(ioa_cfg, ipr_reset_freeze, IPR_SHUTDOWN_NONE);
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, flags);
+}
+
+static void ipr_eeh_thawed (struct pci_dev *pdev)
+{
+	unsigned long flags = 0;
+	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(pdev);
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, flags);
+	_ipr_initiate_ioa_reset(ioa_cfg, ipr_reset_restore_cfg_space, 
+	                                 IPR_SHUTDOWN_NONE);
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, flags);
+}
+
+static void ipr_eeh_perm_failure (struct pci_dev *pdev)
+{
+#if 0  // XXXXXXXXXXXXXXXXXXXXXXX
+	ipr_cmd->job_step = ipr_reset_shutdown_ioa;
+	rc = IPR_RC_JOB_CONTINUE;
+#endif
+}
+
+static int ipr_io_state_change (struct pci_dev *pdev, 
+                                enum pci_device_io_state state)
+{
+	switch (state) {
+		case pci_device_io_frozen:
+			ipr_eeh_frozen (pdev);
+			break;
+		case pci_device_io_thawed:
+			ipr_eeh_thawed (pdev);
+			break;
+		case pci_device_io_perm_failure:
+			ipr_eeh_perm_failure (pdev);
+			break;
+		default:
+			break;
+	}
+	return 0;
+}
+#endif
+
 /**
  * ipr_probe_ioa_part2 - Initializes IOAs found in ipr_probe_ioa(..)
  * @ioa_cfg:	ioa cfg struct
@@ -6015,6 +6080,7 @@ static struct pci_driver ipr_driver = {
 	.id_table = ipr_pci_table,
 	.probe = ipr_probe,
 	.remove = ipr_remove,
+	.io_state_change = ipr_io_state_change,
 	.driver = {
 		.shutdown = ipr_shutdown,
 	},
--- drivers/scsi/ipr.h.linas-orig	2005-03-09 02:11:12.000000000 -0600
+++ drivers/scsi/ipr.h	2005-03-10 14:54:27.000000000 -0600
@@ -1132,9 +1132,11 @@ struct ipr_ucode_image_header {
 #define ipr_trace ipr_dbg("%s: %s: Line: %d\n",\
 	__FILE__, __FUNCTION__, __LINE__)
 
+#undef IPR_DBG_TRACE
+#define IPR_DBG_TRACE 1
 #if IPR_DBG_TRACE
-#define ENTER printk(KERN_INFO IPR_NAME": Entering %s\n", __FUNCTION__)
-#define LEAVE printk(KERN_INFO IPR_NAME": Leaving %s\n", __FUNCTION__)
+#define ENTER printk(KERN_INFO IPR_NAME": Entering %s jiffies=%lu\n", __FUNCTION__, jiffies)
+#define LEAVE printk(KERN_INFO IPR_NAME": Leaving %s jiffies=%lu\n", __FUNCTION__, jiffies)
 #else
 #define ENTER
 #define LEAVE
--- drivers/scsi/sym53c8xx_2/sym_glue.c.linas-orig	2005-03-09 02:13:09.000000000 -0600
+++ drivers/scsi/sym53c8xx_2/sym_glue.c	2005-03-11 18:54:19.000000000 -0600
@@ -770,6 +770,11 @@ static irqreturn_t sym53c8xx_intr(int ir
 	struct sym_hcb *np = (struct sym_hcb *)dev_id;
 
 	if (DEBUG_FLAGS & DEBUG_TINY) printf_debug ("[");
+#define CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+	if (np->s.io_state != pci_device_io_thawed)
+		return IRQ_HANDLED;
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
 
 	spin_lock_irqsave(np->s.host->host_lock, flags);
 	sym_interrupt(np);
@@ -844,6 +849,27 @@ static void sym_eh_done(struct scsi_cmnd
  */
 static void sym_eh_timeout(u_long p) { __sym_eh_done((struct scsi_cmnd *)p, 1); }
 
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+static void sym_eeh_timeout(u_long p) 
+{
+	struct sym_eh_wait *ep = (struct sym_eh_wait *) p;
+	if (!ep)
+		return;
+	complete(&ep->done);
+}
+
+static void sym_eeh_done(struct sym_eh_wait *ep)
+{
+	if (!ep)
+		return;
+	ep->timed_out = 0;
+	if (!del_timer(&ep->timer)) 
+		return;
+				
+	complete(&ep->done);
+}
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
+
 /*
  *  Generic method for our eh processing.
  *  The 'op' argument tells what we have to do.
@@ -905,6 +931,35 @@ prepare:
 		sts = 0;
 		break;
 	case SYM_EH_HOST_RESET:
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+printk("duuuuuude attempting symbios recovery\n");
+dump_stack();
+		int rc = eeh_slot_is_isolated (np->s.device);
+
+printk ("duude symbios is isolated ??=%d\n", rc);
+printk ("duuude the current io state is %d\n", np->s.io_state);
+		if (rc) {
+			struct sym_eh_wait eeh, *eep = &eeh;
+			np->s.io_reset_wait = eep;
+			init_completion(&eep->done);
+			init_timer(&eep->timer);
+			eep->to_do = SYM_EH_DO_WAIT;
+			eep->timer.expires = jiffies + (10*HZ);
+			eep->timer.function = sym_eeh_timeout;
+			eep->timer.data = (u_long)eep;
+			eep->timed_out = 1;	/* Be pessimistic for once :) */
+			add_timer(&eep->timer);
+			spin_unlock_irq(np->s.host->host_lock);
+			wait_for_completion(&eep->done);
+			spin_lock_irq(np->s.host->host_lock);
+			if (eep->timed_out) {
+printk ("duude symbios timed out\n");
+			} else {
+printk ("duude symbios waited for completion\n");
+			}
+			np->s.io_reset_wait = NULL;
+		}
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
 		sym_reset_scsi_bus(np, 0);
 		sym_start_up (np, 1);
 		sts = 0;
@@ -1577,6 +1632,23 @@ static int sym_setup_bus_dma_mask(struct
 	return -1;
 }
 
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+int sym2_io_state_change (struct pci_dev *pdev, enum pci_device_io_state state)
+{
+	struct sym_hcb *np = pci_get_drvdata(pdev);
+printk ("duude symbios got this state change %d jiffies=%ld\n", state, jiffies);
+
+	np->s.io_state = state;
+	if (state == pci_device_io_thawed) {
+		sym_eeh_done (np->s.io_reset_wait);
+	}
+
+	// XXX if perm frozen, then ...?
+
+	return 0;
+}
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
+	
 /*
  *  Host attach and initialisations.
  *
@@ -1625,6 +1697,8 @@ static struct Scsi_Host * __devinit sym_
 	if (!np)
 		goto attach_failed;
 	np->s.device = dev->pdev;
+	np->s.io_state = pci_device_io_thawed;
+	np->s.io_reset_wait = NULL;
 	np->bus_dmat = dev->pdev; /* Result in 1 DMA pool per HBA */
 	host_data->ncb = np;
 	np->s.host = instance;
@@ -2359,6 +2433,7 @@ static struct pci_driver sym2_driver = {
 	.id_table	= sym2_id_table,
 	.probe		= sym2_probe,
 	.remove		= __devexit_p(sym2_remove),
+	.io_state_change = sym2_io_state_change,
 };
 
 static int __init sym2_init(void)
--- drivers/scsi/sym53c8xx_2/sym_glue.h.linas-orig	2005-03-09 02:13:03.000000000 -0600
+++ drivers/scsi/sym53c8xx_2/sym_glue.h	2005-03-10 14:54:27.000000000 -0600
@@ -358,6 +358,10 @@ struct sym_shcb {
 	char		chip_name[8];
 	struct pci_dev	*device;
 
+	/* pci bus i/o state; waiter for clearing of i/o state */
+	enum pci_device_io_state io_state;
+	struct sym_eh_wait *io_reset_wait;
+
 	struct Scsi_Host *host;
 
 	void __iomem *	mmio_va;	/* MMIO kernel virtual address	*/
--- drivers/scsi/sym53c8xx_2/sym_hipd.c.linas-orig	2005-03-09 02:11:01.000000000 -0600
+++ drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-03-11 19:06:17.000000000 -0600
@@ -2836,6 +2836,7 @@ void sym_interrupt (struct sym_hcb *np)
 	u_char	istat, istatc;
 	u_char	dstat;
 	u_short	sist;
+	u_int    icnt;
 
 	/*
 	 *  interrupt on the fly ?
@@ -2877,6 +2878,7 @@ void sym_interrupt (struct sym_hcb *np)
 	sist	= 0;
 	dstat	= 0;
 	istatc	= istat;
+	icnt = 0;
 	do {
 		if (istatc & SIP)
 			sist  |= INW (nc_sist);
@@ -2884,6 +2886,14 @@ void sym_interrupt (struct sym_hcb *np)
 			dstat |= INB (nc_dstat);
 		istatc = INB (nc_istat);
 		istat |= istatc;
+		icnt ++;
+		if (100 < icnt) {
+#define CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+			if(eeh_slot_is_isolated (np->s.device))
+				return;
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
+		}
 	} while (istatc & (SIP|DIP));
 
 	if (DEBUG_FLAGS & DEBUG_TINY)
--- include/asm-ppc64/eeh.h.linas-orig	2005-03-09 02:13:21.000000000 -0600
+++ include/asm-ppc64/eeh.h	2005-03-11 18:01:19.000000000 -0600
@@ -23,6 +23,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/notifier.h>
 #include <linux/string.h>
 
 struct pci_dev;
@@ -36,6 +37,11 @@ struct notifier_block;
 #define EEH_MODE_SUPPORTED	(1<<0)
 #define EEH_MODE_NOCHECK	(1<<1)
 #define EEH_MODE_ISOLATED	(1<<2)
+#define EEH_MODE_RECOVERING	(1<<3)
+
+/* Max number of EEH freezes allowed before we consider the device
+ * to be permanently disabled. */
+#define EEH_MAX_ALLOWED_FREEZES 5
 
 void __init eeh_init(void);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
@@ -59,35 +65,82 @@ void eeh_add_device_late(struct pci_dev 
  * eeh_remove_device - undo EEH setup for the indicated pci device
  * @dev: pci device to be removed
  *
- * This routine should be when a device is removed from a running
- * system (e.g. by hotplug or dlpar).
+ * This routine should be called when a device is removed from 
+ * a running system (e.g. by hotplug or dlpar).  It unregisters 
+ * the PCI device from the EEH subsystem.  I/O errors affecting
+ * this device will no longer be detected after this call; thus,
+ * i/o errors affecting this slot may leave this device unusable.
  */
 void eeh_remove_device(struct pci_dev *);
 
-#define EEH_DISABLE		0
-#define EEH_ENABLE		1
-#define EEH_RELEASE_LOADSTORE	2
-#define EEH_RELEASE_DMA		3
+/**
+ * eeh_slot_is_isolated -- return non-zero value if slot is frozen
+ */
+int eeh_slot_is_isolated (struct pci_dev *dev);
 
 /**
- * Notifier event flags.
+ * eeh_ioaddr_is_isolated -- return non-zero value if device at 
+ * io address is frozen.
  */
-#define EEH_NOTIFY_FREEZE  1
+int eeh_ioaddr_is_isolated(const volatile void __iomem *token);
 
-/** EEH event -- structure holding pci slot data that describes
- *  a change in the isolation status of a PCI slot.  A pointer
- *  to this struct is passed as the data pointer in a notify callback.
- */
-struct eeh_event {
-	struct list_head     list;
-	struct pci_dev       *dev;
-	struct device_node   *dn;
-	int                  reset_state;
-};
-
-/** Register to find out about EEH events. */
-int eeh_register_notifier(struct notifier_block *nb);
-int eeh_unregister_notifier(struct notifier_block *nb);
+/**
+ * eeh_slot_error_detail -- record and EEH error condition to the log
+ * @severity: 1 if temporary, 2 if permanent failure.
+ *
+ * Obtains the the EEH error details from the RTAS subsystem, 
+ * and then logs these details with the RTAS error log system.
+ */
+void eeh_slot_error_detail (struct device_node *dn, int severity);
+
+/** 
+ * rtas_set_slot_reset -- unfreeze a frozen slot
+ *
+ * Clear the EEH-frozen condition on a slot.  This routine
+ * does this by asserting the PCI #RST line for 1/8th of 
+ * a second; this routine will sleep while the adapter is 
+ * being reset.
+ */
+void rtas_set_slot_reset (struct device_node *dn);
+
+/** rtas_pci_slot_reset raises/lowers the pci #RST line
+ *  state: 1/0 to raise/lower the #RST
+ *
+ * Clear the EEH-frozen condition on a slot.  This routine
+ * asserts the PCI #RST line if the 'state' argument is '1',
+ * and drops the #RST line if 'state is '0'.  This routine is 
+ * safe to call in an interrupt context.
+ *
+ */
+void rtas_pci_slot_reset(struct device_node *dn, int state);
+void eeh_pci_slot_reset(struct pci_dev *dev, int state);
+
+/** eeh_pci_slot_availability -- Indicates whether a PCI
+ *  slot is ready to be used. After a PCI reset, it may take a while 
+ *  for the PCI fabric to fully reset the comminucations path to the
+ *  given PCI card.  This routine can be used to determine how long
+ *  to wait before a PCI slot might become usable.  
+ *
+ *  This routine returns how long to wait (in milliseconds) before
+ *  the slot is expected to be usable.  A value of zero means the
+ *  slot is immediately usable. A negavitve value means that the 
+ *  slot is permanently disabled.
+ */
+int eeh_pci_slot_availability(struct pci_dev *dev);
+
+/** Restore device configuration info across device resets.
+ */
+void eeh_restore_bars(struct device_node *);
+void eeh_pci_restore_bars(struct pci_dev *dev);
+
+/**
+ * rtas_configure_bridge -- firmware initialization of pci bridge
+ * 
+ * Ask the firmware to configure any PCI bridge devices 
+ * located behind the indicated node. Required after a 
+ * pci device reset.
+ */
+void rtas_configure_bridge(struct device_node *dn);
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
--- include/asm-ppc64/prom.h.linas-orig	2005-03-09 02:13:03.000000000 -0600
+++ include/asm-ppc64/prom.h	2005-03-10 14:54:27.000000000 -0600
@@ -119,6 +119,7 @@ struct property {
  */
 struct pci_controller;
 struct iommu_table;
+struct eeh_recovery_ops;
 
 struct device_node {
 	char	*name;
@@ -137,8 +138,12 @@ struct device_node {
 	int	devfn;			/* for pci devices */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
+	int   eeh_check_count;    /* number of times device driver ignored error */
+	int	eeh_freeze_count;   /* number of times this device froze up. */
+	int   eeh_is_bridge;      /* device is pci-to-pci bridge */
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
+	u32      config_space[16]; /* saved PCI config space */
 
 	struct	property *properties;
 	struct	device_node *parent;
--- include/asm-ppc64/rtas.h.linas-orig	2005-03-09 02:13:00.000000000 -0600
+++ include/asm-ppc64/rtas.h	2005-03-10 14:54:27.000000000 -0600
@@ -243,4 +243,6 @@ extern unsigned long rtas_rmo_buf;
 
 #define GLOBAL_INTERRUPT_QUEUE 9005
 
+extern int rtas_write_config(struct device_node *dn, int where, int size, u32 val);
+
 #endif /* _PPC64_RTAS_H */
--- arch/ppc64/kernel/eeh.c.linas-orig	2005-03-09 02:12:13.000000000 -0600
+++ arch/ppc64/kernel/eeh.c	2005-03-11 18:58:50.000000000 -0600
@@ -17,16 +17,17 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#include <linux/bootmem.h>
+#include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/list.h>
-#include <linux/mm.h>
 #include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/rbtree.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
+#include <asm/atomic.h>
 #include <asm/eeh.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
@@ -49,8 +50,8 @@
  *  were "empty": all reads return 0xff's and all writes are silently
  *  ignored.  EEH slot isolation events can be triggered by parity
  *  errors on the address or data busses (e.g. during posted writes),
- *  which in turn might be caused by dust, vibration, humidity,
- *  radioactivity or plain-old failed hardware.
+ *  which in turn might be caused by low voltage on the bus, dust, 
+ *  vibration, humidity, radioactivity or plain-old failed hardware.
  *
  *  Note, however, that one of the leading causes of EEH slot
  *  freeze events are buggy device drivers, buggy device microcode,
@@ -75,22 +76,13 @@
 #define BUID_HI(buid) ((buid) >> 32)
 #define BUID_LO(buid) ((buid) & 0xffffffff)
 
-/* EEH event workqueue setup. */
-static DEFINE_SPINLOCK(eeh_eventlist_lock);
-LIST_HEAD(eeh_eventlist);
-static void eeh_event_handler(void *);
-DECLARE_WORK(eeh_event_wq, eeh_event_handler, NULL);
-
-static struct notifier_block *eeh_notifier_chain;
-
 /*
  * If a device driver keeps reading an MMIO register in an interrupt
  * handler after a slot isolation event has occurred, we assume it
  * is broken and panic.  This sets the threshold for how many read
  * attempts we allow before panicking.
  */
-#define EEH_MAX_FAILS	1000
-static atomic_t eeh_fail_count;
+#define EEH_MAX_FAILS	100000
 
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -107,6 +99,10 @@ static DEFINE_SPINLOCK(slot_errbuf_lock)
 static int eeh_error_buf_size;
 
 /* System monitoring statistics */
+static DEFINE_PER_CPU(unsigned long, no_device);
+static DEFINE_PER_CPU(unsigned long, no_dn);
+static DEFINE_PER_CPU(unsigned long, no_cfg_addr);
+static DEFINE_PER_CPU(unsigned long, ignored_check);
 static DEFINE_PER_CPU(unsigned long, total_mmio_ffs);
 static DEFINE_PER_CPU(unsigned long, false_positives);
 static DEFINE_PER_CPU(unsigned long, ignored_failures);
@@ -225,9 +221,9 @@ pci_addr_cache_insert(struct pci_dev *de
 	while (*p) {
 		parent = *p;
 		piar = rb_entry(parent, struct pci_io_addr_range, rb_node);
-		if (alo < piar->addr_lo) {
+		if (ahi < piar->addr_lo) {
 			p = &parent->rb_left;
-		} else if (ahi > piar->addr_hi) {
+		} else if (alo > piar->addr_hi) {
 			p = &parent->rb_right;
 		} else {
 			if (dev != piar->pcidev ||
@@ -245,6 +241,11 @@ pci_addr_cache_insert(struct pci_dev *de
 	piar->addr_hi = ahi;
 	piar->pcidev = dev;
 	piar->flags = flags;
+	
+#ifdef DEBUG 
+	printk (KERN_DEBUG "PIAR: insert range=[%lx:%lx] dev=%s\n", 
+	               alo, ahi, pci_name (dev));
+#endif
 
 	rb_link_node(&piar->rb_node, parent, p);
 	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
@@ -369,6 +370,7 @@ void pci_addr_cache_remove_device(struct
  */
 void __init pci_addr_cache_build(void)
 {
+	struct device_node *dn;
 	struct pci_dev *dev = NULL;
 
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
@@ -379,6 +381,17 @@ void __init pci_addr_cache_build(void)
 			continue;
 		}
 		pci_addr_cache_insert_device(dev);
+		
+		/* Save the BAR's; firmware doesn't restore these after EEH reset */
+		dn = pci_device_to_OF_node(dev);
+		if (dn) {
+			int i;
+			for (i = 0; i < 16; i++)
+				pci_read_config_dword(dev, i * 4, &dn->config_space[i]);
+
+			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+				dn->eeh_is_bridge = 1;
+		}
 	}
 
 #ifdef DEBUG
@@ -390,24 +403,32 @@ void __init pci_addr_cache_build(void)
 /* --------------------------------------------------------------- */
 /* Above lies the PCI Address Cache. Below lies the EEH event infrastructure */
 
-/**
- * eeh_register_notifier - Register to find out about EEH events.
- * @nb: notifier block to callback on events
- */
-int eeh_register_notifier(struct notifier_block *nb)
+void eeh_slot_error_detail (struct device_node *dn, int severity)
 {
-	return notifier_chain_register(&eeh_notifier_chain, nb);
-}
+	unsigned long flags;
+	int rc;
 
-/**
- * eeh_unregister_notifier - Unregister to an EEH event notifier.
- * @nb: notifier block to callback on events
- */
-int eeh_unregister_notifier(struct notifier_block *nb)
-{
-	return notifier_chain_unregister(&eeh_notifier_chain, nb);
+	if (!dn) return;
+
+	/* Log the error with the rtas logger */
+	spin_lock_irqsave(&slot_errbuf_lock, flags);
+	memset(slot_errbuf, 0, eeh_error_buf_size);
+
+	rc = rtas_call(ibm_slot_error_detail,
+	               8, 1, NULL, dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid), NULL, 0,
+	               virt_to_phys(slot_errbuf),
+	               eeh_error_buf_size,
+	               severity);
+
+	if (rc == 0)
+		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
+	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
 }
 
+EXPORT_SYMBOL(eeh_slot_error_detail);
+
 /**
  * read_slot_reset_state - Read the reset state of a device node's slot
  * @dn: device node to read
@@ -422,6 +443,7 @@ static int read_slot_reset_state(struct 
 		outputs = 4;
 	} else {
 		token = ibm_read_slot_reset_state;
+		rets[2] = 0; /* fake PE Unavailable info */
 		outputs = 3;
 	}
 
@@ -430,75 +452,8 @@ static int read_slot_reset_state(struct 
 }
 
 /**
- * eeh_panic - call panic() for an eeh event that cannot be handled.
- * The philosophy of this routine is that it is better to panic and
- * halt the OS than it is to risk possible data corruption by
- * oblivious device drivers that don't know better.
- *
- * @dev pci device that had an eeh event
- * @reset_state current reset state of the device slot
- */
-static void eeh_panic(struct pci_dev *dev, int reset_state)
-{
-	/*
-	 * XXX We should create a separate sysctl for this.
-	 *
-	 * Since the panic_on_oops sysctl is used to halt the system
-	 * in light of potential corruption, we can use it here.
-	 */
-	if (panic_on_oops)
-		panic("EEH: MMIO failure (%d) on device:%s %s\n", reset_state,
-		      pci_name(dev), pci_pretty_name(dev));
-	else {
-		__get_cpu_var(ignored_failures)++;
-		printk(KERN_INFO "EEH: Ignored MMIO failure (%d) on device:%s %s\n",
-		       reset_state, pci_name(dev), pci_pretty_name(dev));
-	}
-}
-
-/**
- * eeh_event_handler - dispatch EEH events.  The detection of a frozen
- * slot can occur inside an interrupt, where it can be hard to do
- * anything about it.  The goal of this routine is to pull these
- * detection events out of the context of the interrupt handler, and
- * re-dispatch them for processing at a later time in a normal context.
- *
- * @dummy - unused
- */
-static void eeh_event_handler(void *dummy)
-{
-	unsigned long flags;
-	struct eeh_event	*event;
-
-	while (1) {
-		spin_lock_irqsave(&eeh_eventlist_lock, flags);
-		event = NULL;
-		if (!list_empty(&eeh_eventlist)) {
-			event = list_entry(eeh_eventlist.next, struct eeh_event, list);
-			list_del(&event->list);
-		}
-		spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
-		if (event == NULL)
-			break;
-
-		printk(KERN_INFO "EEH: MMIO failure (%d), notifiying device "
-		       "%s %s\n", event->reset_state,
-		       pci_name(event->dev), pci_pretty_name(event->dev));
-
-		atomic_set(&eeh_fail_count, 0);
-		notifier_call_chain (&eeh_notifier_chain,
-				     EEH_NOTIFY_FREEZE, event);
-
-		__get_cpu_var(slot_resets)++;
-
-		pci_dev_put(event->dev);
-		kfree(event);
-	}
-}
-
-/**
- * eeh_token_to_phys - convert EEH address token to phys address
- * @token i/o token, should be address in the form 0xE....
+ * eeh_token_to_phys - convert I/O address to phys address
+ * @token i/o address, should be address in the form 0xA....
  */
 static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
@@ -513,6 +468,18 @@ static inline unsigned long eeh_token_to
 	return pa | (token & (PAGE_SIZE-1));
 }
 
+
+static inline struct pci_dev * eeh_find_pci_dev(struct device_node *dn)
+{
+	struct pci_dev *dev = NULL;
+	for_each_pci_dev(dev) {
+		if (pci_device_to_OF_node(dev) == dn)
+			return dev;
+	}
+	return NULL;
+}
+
+
 /**
  * eeh_dn_check_failure - check if all 1's data is due to EEH slot freeze
  * @dn device node
@@ -528,29 +495,33 @@ static inline unsigned long eeh_token_to
  *
  * It is safe to call this routine in an interrupt context.
  */
+extern void disable_irq_nosync(unsigned int);
+
 int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 {
 	int ret;
 	int rets[3];
-	unsigned long flags;
-	int rc, reset_state;
-	struct eeh_event  *event;
+	enum pci_device_io_state state;
 
 	__get_cpu_var(total_mmio_ffs)++;
 
 	if (!eeh_subsystem_enabled)
 		return 0;
 
-	if (!dn)
+	if (!dn) {
+		__get_cpu_var(no_dn)++;
 		return 0;
+	}
 
 	/* Access to IO BARs might get this far and still not want checking. */
 	if (!(dn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    dn->eeh_mode & EEH_MODE_NOCHECK) {
+		__get_cpu_var(ignored_check)++;
 		return 0;
 	}
 
 	if (!dn->eeh_config_addr) {
+		__get_cpu_var(no_cfg_addr)++;
 		return 0;
 	}
 
@@ -559,12 +530,18 @@ int eeh_dn_check_failure(struct device_n
 	 * slot, we know it's bad already, we don't need to check...
 	 */
 	if (dn->eeh_mode & EEH_MODE_ISOLATED) {
-		atomic_inc(&eeh_fail_count);
-		if (atomic_read(&eeh_fail_count) >= EEH_MAX_FAILS) {
+		dn->eeh_check_count ++;
+		if (dn->eeh_check_count >= EEH_MAX_FAILS) {
+			printk (KERN_ERR "EEH: Device driver ignored %d bad reads, panicing\n",
+			        dn->eeh_check_count);
+			dump_stack();
 			/* re-read the slot reset state */
 			if (read_slot_reset_state(dn, rets) != 0)
 				rets[0] = -1;	/* reset state unknown */
-			eeh_panic(dev, rets[0]);
+
+			/* If we are here, then we hit an infinite loop. Stop. */
+			panic("EEH: MMIO halt (%d) on device:%s %s\n", rets[0],
+		      pci_name(dev), pci_pretty_name(dev));
 		}
 		return 0;
 	}
@@ -577,53 +554,42 @@ int eeh_dn_check_failure(struct device_n
 	 * In any case they must share a common PHB.
 	 */
 	ret = read_slot_reset_state(dn, rets);
-	if (!(ret == 0 && rets[1] == 1 && (rets[0] == 2 || rets[0] == 4))) {
+	if (!(ret == 0 && ((rets[1] == 1 && (rets[0] == 2 || rets[0] >= 4))
+	                   || (rets[0] == 5)))) {
 		__get_cpu_var(false_positives)++;
 		return 0;
 	}
 
-	/* prevent repeated reports of this failure */
-	dn->eeh_mode |= EEH_MODE_ISOLATED;
+	/* Note that empty slots will fail; empty slots don't have children... */
+	if ((rets[0] == 5) && (dn->child == NULL)) {
+		__get_cpu_var(false_positives)++;
+		return 0;
+	}
 
-	reset_state = rets[0];
+	/* Prevent repeated reports of this failure */
+	dn->eeh_mode |= EEH_MODE_ISOLATED;
 
-	spin_lock_irqsave(&slot_errbuf_lock, flags);
-	memset(slot_errbuf, 0, eeh_error_buf_size);
+	/* Some devices go crazy if irq's are not ack'ed; disable irq now */
+	disable_irq_nosync (dev->irq);
+// get_irq_desc (dev->irq)->handler->disable (dev->irq);
+	
+	__get_cpu_var(slot_resets)++;
 
-	rc = rtas_call(ibm_slot_error_detail,
-	               8, 1, NULL, dn->eeh_config_addr,
-	               BUID_HI(dn->phb->buid),
-	               BUID_LO(dn->phb->buid), NULL, 0,
-	               virt_to_phys(slot_errbuf),
-	               eeh_error_buf_size,
-	               1 /* Temporary Error */);
+	if (!dev)
+		dev = eeh_find_pci_dev (dn);
 
-	if (rc == 0)
-		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
-	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
+	state = pci_device_io_thawed;
+	if ((rets[0] == 2) || (rets[0] == 4)) 
+		state = pci_device_io_frozen;
+	if (rets[0] == 5) 
+		state = pci_device_io_perm_failure;
 
-	printk(KERN_INFO "EEH: MMIO failure (%d) on device: %s %s\n",
-	       rets[0], dn->name, dn->full_name);
-	event = kmalloc(sizeof(*event), GFP_ATOMIC);
-	if (event == NULL) {
-		eeh_panic(dev, reset_state);
-		return 1;
- 	}
-
-	event->dev = dev;
-	event->dn = dn;
-	event->reset_state = reset_state;
-
-	/* We may or may not be called in an interrupt context */
-	spin_lock_irqsave(&eeh_eventlist_lock, flags);
-	list_add(&event->list, &eeh_eventlist);
-	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+	peh_send_failure_event (dev, state, rets[2]);
 
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out. */
-	dump_stack();
-	schedule_work(&eeh_event_wq);
+	if (rets[0] != 5) dump_stack();
 
 	return 0;
 }
@@ -635,7 +601,6 @@ EXPORT_SYMBOL(eeh_dn_check_failure);
  * @token i/o token, should be address in the form 0xA....
  * @val value, should be all 1's (XXX why do we need this arg??)
  *
- * Check for an eeh failure at the given token address.
  * Check for an EEH failure at the given token address.  Call this
  * routine if the result of a read was all 0xff's and you want to
  * find out if this is due to an EEH slot freeze event.  This routine
@@ -643,6 +608,7 @@ EXPORT_SYMBOL(eeh_dn_check_failure);
  *
  * Note this routine is safe to call in an interrupt context.
  */
+
 unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
 {
 	unsigned long addr;
@@ -652,8 +618,10 @@ unsigned long eeh_check_failure(const vo
 	/* Finding the phys addr + pci device; this is pretty quick. */
 	addr = eeh_token_to_phys((unsigned long __force) token);
 	dev = pci_get_device_by_addr(addr);
-	if (!dev)
+	if (!dev) {
+		__get_cpu_var(no_device)++;
 		return val;
+	}
 
 	dn = pci_device_to_OF_node(dev);
 	eeh_dn_check_failure (dn, dev);
@@ -664,6 +632,235 @@ unsigned long eeh_check_failure(const vo
 
 EXPORT_SYMBOL(eeh_check_failure);
 
+/* ------------------------------------------------------------- */
+/* The code below deals with error recovery */
+
+int
+eeh_slot_is_isolated(struct pci_dev *dev)
+{ 
+	struct device_node *dn;
+	dn = pci_device_to_OF_node(dev);
+	return (dn->eeh_mode & EEH_MODE_ISOLATED);
+}
+
+int
+eeh_ioaddr_is_isolated(const volatile void __iomem *token)
+{ 
+	unsigned long addr;
+	struct pci_dev *dev;
+	int rc;
+
+	addr = eeh_token_to_phys((unsigned long __force) token);
+	dev = pci_get_device_by_addr(addr);
+	if (!dev)
+		return 0;
+	rc = eeh_slot_is_isolated(dev);
+	pci_dev_put(dev);
+	return rc;
+}
+
+/** eeh_pci_slot_reset -- raises/lowers the pci #RST line
+ *  state: 1/0 to raise/lower the #RST 
+ */
+void
+eeh_pci_slot_reset(struct pci_dev *dev, int state)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	rtas_pci_slot_reset (dn, state);
+}
+
+/** Return negative value if a permanent error, else return 
+ * a number of milliseconds to wait until the PCI slot is 
+ * ready to be used.
+ */
+static int
+eeh_slot_availability(struct device_node *dn)
+{
+	int rc;
+	int rets[3];
+
+	rc = read_slot_reset_state(dn, rets);
+	if (rc) return rc;
+
+	if (rets[1] == 0) return -1;  /* EEH is not supported */
+	if (rets[0] == 0)  return 0;  /* Oll Korrect */
+	if (rets[0] == 5) {
+		if (rets[2] == 0) return -1; /* permanently unavailable */
+		return rets[2]; /* number of millisecs to wait */
+	}
+	return -1;
+}
+
+int
+eeh_pci_slot_availability(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	if (!dn) return -1;
+
+	BUG_ON (dn->phb==NULL);
+	if (dn->phb==NULL) {
+		printk (KERN_ERR "EEH, checking on slot with no phb dn=%s dev=%s:%s\n",
+		       dn->full_name, pci_name(dev), pci_pretty_name (dev));
+		return -1;
+	}
+	return eeh_slot_availability (dn);
+}
+
+void
+rtas_pci_slot_reset(struct device_node *dn, int state)
+{
+	int rc;
+
+	if (!dn)
+		return;
+	if (!dn->phb) {
+		printk (KERN_WARNING "EEH: in slot reset, device node %s has no phb\n",                    dn->full_name);
+		return;
+	}
+
+	dn->eeh_mode |= EEH_MODE_RECOVERING;
+	rc = rtas_call(ibm_set_slot_reset,4,1, NULL,
+	               dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid),
+	               state);
+	if (rc) {
+		printk (KERN_WARNING "EEH: Unable to reset the failed slot, (%d) #RST=%d\n", rc, state);
+		return;
+	}
+
+	if (state == 0)
+		dn->eeh_mode &= ~(EEH_MODE_RECOVERING|EEH_MODE_ISOLATED);
+}
+
+/** rtas_set_slot_reset -- assert the pci #RST line for 1/4 second 
+ *  dn -- device node to be reset.
+ */
+
+void
+rtas_set_slot_reset(struct device_node *dn)
+{
+	int i, rc;
+
+	rtas_pci_slot_reset (dn, 1);
+
+	/* The PCI bus requires that the reset be held high for at least
+	 * a 100 milliseconds. We wait a bit longer 'just in case'.  */
+
+#define PCI_BUS_RST_HOLD_TIME_MSEC 250
+	msleep (PCI_BUS_RST_HOLD_TIME_MSEC);
+	rtas_pci_slot_reset (dn, 0); 
+	
+	/* After a PCI slot has been reset, the PCI Express spec requires
+	 * a 1.5 second idle time for the bus to stabilize, before starting 
+	 * up traffic. */
+#define PCI_BUS_SETTLE_TIME_MSEC 1800
+	msleep (PCI_BUS_SETTLE_TIME_MSEC);
+
+	/* Now double check with the firmware to make sure the device is
+	 * ready to be used; if not, wait for recovery. */
+	for (i=0; i<10; i++) {
+		rc = eeh_slot_availability (dn);
+		if (rc <= 0) return;
+
+		msleep (rc+100);
+	}
+}
+
+EXPORT_SYMBOL(rtas_set_slot_reset);
+
+void
+rtas_configure_bridge(struct device_node *dn)
+{
+	int token = rtas_token ("ibm,configure-bridge");
+	int rc;
+
+	if (token == RTAS_UNKNOWN_SERVICE)
+		return;
+	rc = rtas_call(token,3,1, NULL,
+	               dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid));
+	if (rc) {
+		printk (KERN_WARNING "EEH: Unable to configure device bridge (%d) for %s\n", 
+		        rc, dn->full_name);
+	}
+}
+
+EXPORT_SYMBOL(rtas_configure_bridge);
+
+/* ------------------------------------------------------- */
+/** Save and restore of PCI BARs
+ *
+ * Although firmware will set up BARs during boot, it doesn't
+ * set up device BAR's after a device reset, although it will,
+ * if requested, set up bridge configuration. Thus, we need to
+ * configure the PCI devices ourselves.  Config-space setup is
+ * stored in the PCI structures which are normally deleted during
+ * device removal.  Thus, the "save" routine references the
+ * structures so that they aren't deleted.
+ */
+
+/**
+ * __restore_bars - Restore the Base Address Registers
+ * Loads the PCI configuration space base address registers,
+ * the expansion ROM base address, the latency timer, and etc.
+ * from the saved values in the device node.
+ */
+static inline void __restore_bars (struct device_node *dn)
+{
+	int i;
+
+	if (NULL==dn->phb) return;
+	for (i=4; i<10; i++) {
+		rtas_write_config(dn, i*4, 4, dn->config_space[i]);
+	}
+
+	/* 12 == Expansion ROM Address */
+	rtas_write_config(dn, 12*4, 4, dn->config_space[12]);
+	
+#define SAVED_BYTE(OFF) (((u8 *)(dn->config_space))[OFF])
+	
+	rtas_write_config (dn, PCI_CACHE_LINE_SIZE, 1,
+	            SAVED_BYTE(PCI_CACHE_LINE_SIZE));
+	
+	rtas_write_config (dn, PCI_LATENCY_TIMER, 1,
+	            SAVED_BYTE(PCI_LATENCY_TIMER));
+	
+	rtas_write_config (dn, PCI_INTERRUPT_LINE, 1,
+	            SAVED_BYTE(PCI_INTERRUPT_LINE));
+}
+
+/**
+ * eeh_restore_bars - restore the PCI config space info
+ */
+void eeh_restore_bars(struct device_node *dn)
+{
+	if (! dn->eeh_is_bridge)
+		__restore_bars (dn);
+	
+	if (dn->child)
+		eeh_restore_bars (dn->child);
+#if DO_SIBLINGS
+	if (dn->sibling)
+		eeh_restore_bars (dn->sibling);
+#endif
+}
+
+void eeh_pci_restore_bars(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	eeh_restore_bars (dn);
+}
+
+/* ------------------------------------------------------------- */
+/* The code below deals with enabling EEH for devices during  the
+ * early boot sequence.  EEH must be enabled before any PCI probing
+ * can be done.
+ */
+
+#define EEH_ENABLE 1
+
 struct eeh_early_enable_info {
 	unsigned int buid_hi;
 	unsigned int buid_lo;
@@ -682,6 +879,8 @@ static void *early_enable_eeh(struct dev
 	int enable;
 
 	dn->eeh_mode = 0;
+	dn->eeh_check_count = 0;
+	dn->eeh_freeze_count = 0;
 
 	if (status && strcmp(status, "ok") != 0)
 		return NULL;	/* ignore devices with bad status */
@@ -743,7 +942,7 @@ static void *early_enable_eeh(struct dev
 		       dn->full_name);
 	}
 
-	return NULL; 
+	return NULL;
 }
 
 /*
@@ -824,11 +1023,13 @@ void eeh_add_device_early(struct device_
 	struct pci_controller *phb;
 	struct eeh_early_enable_info info;
 
-	if (!dn || !eeh_subsystem_enabled)
+	if (!dn)
 		return;
 	phb = dn->phb;
 	if (NULL == phb || 0 == phb->buid) {
-		printk(KERN_WARNING "EEH: Expected buid but found none\n");
+		printk(KERN_WARNING "EEH: Expected buid but found none for %s\n",
+		                dn->full_name);
+		dump_stack();
 		return;
 	}
 
@@ -847,6 +1048,9 @@ EXPORT_SYMBOL(eeh_add_device_early);
  */
 void eeh_add_device_late(struct pci_dev *dev)
 {
+	int i;
+	struct device_node *dn;
+
 	if (!dev || !eeh_subsystem_enabled)
 		return;
 
@@ -856,6 +1060,14 @@ void eeh_add_device_late(struct pci_dev 
 #endif
 
 	pci_addr_cache_insert_device (dev);
+
+	/* Save the BAR's; firmware doesn't restore these after EEH reset */
+	dn = pci_device_to_OF_node(dev);
+	for (i = 0; i < 16; i++)
+		pci_read_config_dword(dev, i * 4, &dn->config_space[i]);
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		dn->eeh_is_bridge = 1;
 }
 EXPORT_SYMBOL(eeh_add_device_late);
 
@@ -885,12 +1097,17 @@ static int proc_eeh_show(struct seq_file
 	unsigned int cpu;
 	unsigned long ffs = 0, positives = 0, failures = 0;
 	unsigned long resets = 0;
+	unsigned long no_dev = 0, no_dn = 0, no_cfg = 0, no_check = 0;
 
 	for_each_cpu(cpu) {
 		ffs += per_cpu(total_mmio_ffs, cpu);
 		positives += per_cpu(false_positives, cpu);
 		failures += per_cpu(ignored_failures, cpu);
 		resets += per_cpu(slot_resets, cpu);
+		no_dev += per_cpu(no_device, cpu);
+		no_dn += per_cpu(no_dn, cpu);
+		no_cfg += per_cpu(no_cfg_addr, cpu);
+		no_check += per_cpu(ignored_check, cpu);
 	}
 
 	if (0 == eeh_subsystem_enabled) {
@@ -898,13 +1115,17 @@ static int proc_eeh_show(struct seq_file
 		seq_printf(m, "eeh_total_mmio_ffs=%ld\n", ffs);
 	} else {
 		seq_printf(m, "EEH Subsystem is enabled\n");
-		seq_printf(m, "eeh_total_mmio_ffs=%ld\n"
+		seq_printf(m, 
+				"no device=%ld\n"
+				"no device node=%ld\n"
+				"no config address=%ld\n"
+				"check not wanted=%ld\n"
+				"eeh_total_mmio_ffs=%ld\n"
 			   "eeh_false_positives=%ld\n"
 			   "eeh_ignored_failures=%ld\n"
-			   "eeh_slot_resets=%ld\n"
-				"eeh_fail_count=%d\n",
-			   ffs, positives, failures, resets,
-				eeh_fail_count.counter);
+			   "eeh_slot_resets=%ld\n",
+				no_dev, no_dn, no_cfg, no_check,
+			   ffs, positives, failures, resets);
 	}
 
 	return 0;
--- arch/ppc64/kernel/pSeries_pci.c.linas-orig	2005-03-09 02:13:08.000000000 -0600
+++ arch/ppc64/kernel/pSeries_pci.c	2005-03-10 14:54:27.000000000 -0600
@@ -101,7 +101,7 @@ static int rtas_pci_read_config(struct p
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
-static int rtas_write_config(struct device_node *dn, int where, int size, u32 val)
+int rtas_write_config(struct device_node *dn, int where, int size, u32 val)
 {
 	unsigned long buid, addr;
 	int ret;
--- drivers/pci/hotplug/rpaphp.h.linas-orig	2005-03-09 02:11:19.000000000 -0600
+++ drivers/pci/hotplug/rpaphp.h	2005-03-10 14:54:27.000000000 -0600
@@ -118,7 +118,8 @@ extern int rpaphp_enable_pci_slot(struct
 extern int register_pci_slot(struct slot *slot);
 extern int rpaphp_unconfig_pci_adapter(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
-extern struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev);
+extern void init_eeh_handler (void);
+extern void exit_eeh_handler (void);
 
 /* rpaphp_core.c */
 extern int rpaphp_add_slot(struct device_node *dn);
--- drivers/pci/hotplug/rpaphp_core.c.linas-orig	2005-03-09 02:12:58.000000000 -0600
+++ drivers/pci/hotplug/rpaphp_core.c	2005-03-10 14:54:27.000000000 -0600
@@ -460,12 +460,18 @@ static int __init rpaphp_init(void)
 {
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
+	/* Get set to handle EEH events. */
+	init_eeh_handler();
+
 	/* read all the PRA info from the system */
 	return init_rpa();
 }
 
 static void __exit rpaphp_exit(void)
 {
+	/* Let EEH know we are going away. */
+	exit_eeh_handler();
+
 	cleanup_slots();
 }
 
--- drivers/pci/hotplug/rpaphp_pci.c.linas-orig	2005-03-09 02:11:01.000000000 -0600
+++ drivers/pci/hotplug/rpaphp_pci.c	2005-03-11 18:40:28.000000000 -0600
@@ -22,8 +22,13 @@
  * Send feedback to <lxie@us.ibm.com>
  *
  */
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
 #include <linux/pci.h>
+#include <asm/eeh.h>
 #include <asm/pci-bridge.h>
+#include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/machdep.h>
 #include "../pci.h"		/* for pci_add_new_bus */
@@ -63,6 +68,7 @@ int rpaphp_claim_resource(struct pci_dev
 		    root ? "Address space collision on" :
 		    "No parent found for",
 		    resource, dtype, pci_name(dev), res->start, res->end);
+		dump_stack();
 	}
 	return err;
 }
@@ -188,6 +194,19 @@ rpaphp_fixup_new_pci_devices(struct pci_
 
 static int rpaphp_pci_config_bridge(struct pci_dev *dev);
 
+static void rpaphp_eeh_add_bus_device(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		eeh_add_device_late(dev);
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+			struct pci_bus *subbus = dev->subordinate;
+			if (bus)
+				rpaphp_eeh_add_bus_device (subbus);
+		}
+	}
+}
+
 /*****************************************************************************
  rpaphp_pci_config_slot() will  configure all devices under the 
  given slot->dn and return the the first pci_dev.
@@ -215,6 +234,8 @@ rpaphp_pci_config_slot(struct device_nod
 		}
 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) 
 			rpaphp_pci_config_bridge(dev);
+
+		rpaphp_eeh_add_bus_device(bus);
 	}
 	return dev;
 }
@@ -223,7 +244,6 @@ static int rpaphp_pci_config_bridge(stru
 {
 	u8 sec_busno;
 	struct pci_bus *child_bus;
-	struct pci_dev *child_dev;
 
 	dbg("Enter %s:  BRIDGE dev=%s\n", __FUNCTION__, pci_name(dev));
 
@@ -240,11 +260,7 @@ static int rpaphp_pci_config_bridge(stru
 	/* do pci_scan_child_bus */
 	pci_scan_child_bus(child_bus);
 
-	list_for_each_entry(child_dev, &child_bus->devices, bus_list) {
-		eeh_add_device_late(child_dev);
-	}
-
-	 /* fixup new pci devices without touching bus struct */
+	/* Fixup new pci devices without touching bus struct */
 	rpaphp_fixup_new_pci_devices(child_bus, 0);
 
 	/* Make the discovered devices available */
@@ -282,7 +298,7 @@ static void print_slot_pci_funcs(struct 
 	return;
 }
 #else
-static void print_slot_pci_funcs(struct slot *slot)
+static inline void print_slot_pci_funcs(struct slot *slot)
 {
 	return;
 }
@@ -364,7 +380,6 @@ static void rpaphp_eeh_remove_bus_device
 			if (pdev)
 				rpaphp_eeh_remove_bus_device(pdev);
 		}
-
 	}
 	return;
 }
@@ -566,36 +581,265 @@ exit:
 	return retval;
 }
 
-struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev)
+/**
+ * rpaphp_search_bus_for_dev - return 1 if device is under this bus, else 0
+ * @bus: the bus to search for this device.
+ * @dev: the pci device we are looking for.
+ */
+static int rpaphp_search_bus_for_dev (struct pci_bus *bus, struct pci_dev *dev)
+{
+	struct list_head *ln;
+
+	if (!bus) return 0;
+	
+	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
+		struct pci_dev *pdev = pci_dev_b(ln);
+		if (pdev == dev)
+			return 1;
+		if (pdev->subordinate) {
+			int rc;
+			rc = rpaphp_search_bus_for_dev (pdev->subordinate, dev);
+			if (rc)
+				return 1;
+		}
+	}
+	return 0;
+}
+
+/**
+ * rpaphp_find_slot - find and return the slot holding the device
+ * @dev: pci device for which we want the slot structure.
+ */
+static struct slot *rpaphp_find_slot(struct pci_dev *dev)
 {
-	struct list_head	*tmp, *n;
-	struct slot		*slot;
+	struct list_head *tmp, *n;
+	struct slot	*slot;
 
 	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
 		struct pci_bus *bus;
-		struct list_head *ln;
 
 		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
-		if (slot->bridge == NULL) {
-			if (slot->dev_type == PCI_DEV) {
-				printk(KERN_WARNING "PCI slot missing bridge %s %s \n", 
-				                    slot->name, slot->location);
-			}
+		
+		/* PHB's don't have bridges. */
+		if (slot->bridge == NULL)
 			continue;
-		}
+
+		/* The PCI device could be the slot itself. */
+		if (slot->bridge == dev)
+			return slot;
 
 		bus = slot->bridge->subordinate;
 		if (!bus) {
+			printk (KERN_WARNING "PCI bridge is missing bus: %s %s\n",
+			    pci_name (slot->bridge), pci_pretty_name (slot->bridge));
 			continue;  /* should never happen? */
 		}
-		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-                                struct pci_dev *pdev = pci_dev_b(ln);
-				if (pdev == dev)
-					return slot->hotplug_slot;
-		}
+
+		if (rpaphp_search_bus_for_dev (bus, dev))
+			return slot;
 	}
+	return NULL;
+}
+
+/** get_phb_of_device -- find the pci controller for the device 
+ *  @dev the pci device
+ *  This routine returns a pointer to the device node that
+ *  describes the pci controller for the indicated slot.
+ */
 
+static struct device_node *
+get_phb_of_device (struct pci_dev *dev)
+{
+	struct device_node *dn;
+	struct pci_bus *bus;
+
+	while (1) {
+		bus = dev->bus;
+		if (!bus)
+			break;
+		dn = pci_bus_to_OF_node(bus);
+
+		if (dn->phb)
+			return dn;
+	
+		dev = bus->self;
+		BUG_ON (dev==NULL);
+		if (dev == NULL)
+			return NULL;
+	}
 	return NULL;
 }
 
-EXPORT_SYMBOL_GPL(rpaphp_find_hotplug_slot);
+/* ------------------------------------------------------- */
+/**
+ * handle_eeh_events -- reset a PCI device after hard lockup.
+ *
+ * pSeries systems will isolate a PCI slot if the PCI-Host
+ * bridge detects address or data parity errors, DMA's 
+ * occuring to wild addresses (which usually happen due to
+ * bugs in device drivers or in PCI adapter firmware).
+ * Slot isolations also occur if #SERR, #PERR or other misc
+ * PCI-related errors are detected.
+ * 
+ * Recovery process consists of unplugging the device driver
+ * (which generated hotplug events to userspace), then issuing
+ * a PCI #RST to the device, then reconfiguring the PCI config 
+ * space for all bridges & devices under this slot, and then 
+ * finally restarting the device drivers (which cause a second
+ * set of hotplug events to go out to userspace).
+ */
+
+int eeh_reset_device (struct pci_dev *dev, struct device_node *dn, int reconfig)
+{
+	struct slot *frozen_slot= NULL;
+
+	if (!dev)
+		return 1;
+
+	if (reconfig)
+		frozen_slot = rpaphp_find_slot(dev);
+
+	if (reconfig && frozen_slot) rpaphp_unconfig_pci_adapter (frozen_slot);
+	
+	/* Reset the pci controller. (Asserts RST#; resets config space). 
+	 * Reconfigure bridges and devices */
+	rtas_set_slot_reset (dn->child);
+	rtas_configure_bridge(dn);
+	eeh_restore_bars(dn->child);
+	enable_irq (dev->irq);
+
+	/* Give the system 5 seconds to finish running the user-space
+	 * hotplug scripts, e.g. ifdown for ethernet.  Yes, this is a hack, 
+	 * but if we don't do this, weird things happen.
+	 */
+	if (reconfig && frozen_slot) {
+		ssleep (5);
+		rpaphp_enable_pci_slot (frozen_slot);
+	}
+	return 0;
+}
+
+/* The longest amount of time to wait for a pci device
+ * to come back on line, in seconds.
+ */
+#define MAX_WAIT_FOR_RECOVERY 15 
+
+int handle_eeh_events (struct notifier_block *self, 
+                       unsigned long reason, void *ev)
+{
+	int freeze_count=0;
+	struct device_node *frozen_device;
+	struct peh_event *event = ev;
+	struct pci_dev *dev = event->dev;
+	int perm_failure = 0;
+	int rc;
+
+	if (!dev)
+	{
+		printk ("EEH: EEH error caught, but no PCI device specified!\n");
+		return 1;
+	}
+
+	frozen_device = get_phb_of_device (dev);
+
+	if (!frozen_device)
+	{
+		printk (KERN_ERR "EEH: Cannot find PCI conroller for %s %s\n",
+				pci_name(dev), pci_pretty_name (dev));
+
+		return 1;
+	}
+
+	/* We get "permanent failure" messages on empty slots. 
+	 * These are false alarms. Empty slots have no child dn. */
+	if ((event->state == pci_device_io_perm_failure) && (frozen_device == NULL))
+		return 0;
+
+	if (frozen_device)
+		freeze_count = frozen_device->eeh_freeze_count;
+	freeze_count ++;
+	if (freeze_count > EEH_MAX_ALLOWED_FREEZES)
+		perm_failure = 1;
+	
+	/* If the reset state is a '5' and the time to reset is 0 (infinity) 
+	 * or is more then 15 seconds, then mark this as a permanent failure. 
+	 */
+	if ((event->state == pci_device_io_perm_failure) && 
+	    ((event->time_unavail <= 0) ||
+	     (event->time_unavail > MAX_WAIT_FOR_RECOVERY*1000))) 
+		perm_failure = 1;
+	
+	/* Log the error with the rtas logger. */
+	if (perm_failure) {
+		/* 
+		 * About 90% of all real-life EEH failures in the field
+		 * are due to poorly seated PCI cards. Only 10% or so are
+		 * due to actual, failed cards.
+		 */
+		printk (KERN_ERR
+		   "EEH: device %s:%s has failed %d times \n"
+			"and has been permanently disabled.  Please try reseating\n"
+		   "this device or replacing it.\n",
+			pci_name (dev),
+			pci_pretty_name (dev),
+			freeze_count);
+
+		eeh_slot_error_detail (frozen_device, 2 /* Permanent Error */);
+
+		/* Notify the device that its about to go down. */
+		/* XXX this should be a recursive walk to children for 
+		 * multi-function devices */
+		if (dev->driver->io_state_change) {
+			dev->driver->io_state_change (dev, pci_device_io_perm_failure);
+		}
+
+		/* If there's a hotplug slot, unconfigure it */
+		struct slot * frozen_slot = rpaphp_find_slot(dev);
+		rpaphp_unconfig_pci_adapter (frozen_slot);
+		return 1;
+	} else {
+		eeh_slot_error_detail (frozen_device, 1 /* Temporary Error */);
+	}
+
+	printk (KERN_WARNING
+	   "EEH: This device has failed %d times since last reboot: %s:%s\n",
+		freeze_count,
+		pci_name (dev),
+		pci_pretty_name (dev));
+
+	/* Walk the various device drivers attached to this slot through
+	 * a reset sequence, giving each an opportunity to do what it needs
+	 * to accomplish the reset */
+	/* XXX this should be a recursive walk to children for 
+	 * multi-function devices; each child should get to report
+	 * status too, if needed ... if any child can't handle the reset,
+	 * then need to hotplug it. */
+	if (dev->driver->io_state_change) {
+		dev->driver->io_state_change (dev, pci_device_io_frozen);
+		rc = eeh_reset_device (dev, frozen_device, 0);
+		dev->driver->io_state_change (dev, pci_device_io_thawed);
+	} else {
+		rc = eeh_reset_device (dev, frozen_device, 1);
+	}
+
+	/* Store the freeze count with the pci adapter, and not the slot.
+	 * This way, if the device is replaced, the count is cleared.
+	 */
+	frozen_device->eeh_freeze_count = freeze_count;
+
+	return rc;
+}
+
+static struct notifier_block eeh_block;
+
+void __init init_eeh_handler (void)
+{
+	eeh_block.notifier_call = handle_eeh_events;
+	peh_register_notifier (&eeh_block);
+}
+
+void __exit exit_eeh_handler (void)
+{
+	peh_unregister_notifier (&eeh_block);
+}
+


----- End forwarded message -----

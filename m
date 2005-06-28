Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVF2BAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVF2BAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVF2A6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:58:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9459 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262336AbVF1X7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:59:46 -0400
Date: Tue, 28 Jun 2005 18:59:33 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 8/13]: PCI Err: Event delivery utility
Message-ID: <20050628235932.GA6429@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-8-pci-err-event.patch

[RFC]

PCI Error distribution utility routine.  This patch defines 
a utility routine that hasn't yet been discussed much on 
the mailing list; I've made this architecture independent
with the idea that various architectures may find it handy, 
but its not directly required, or relevant, to the overall 
EEH error recovery mechanism. (It could be buried in 
arch-dependent code or implemented differently.)

The current design has the arch dependent code detect
a PCI bus error.  That code uses this utility to generate 
a detection event.  This event is then caught by PCI
hotplug code, which drives the slot recovery. If the 
affected device drivers have recovery callbacks, these 
are used; all other devices are hotplugged.

There are certainly other (simpler) ways to attach the 
arch-specific error detection code to the hot-plug mediated 
recovery code; this routine is rather left-over from 
earlier email discussions.  Should this stay, or not?

Signed-off-by: Linas Vepstas <linas@linas.org>

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-8-pci-err-event.patch"

--- linux-2.6.12-git10/include/linux/pci.h.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/include/linux/pci.h	2005-06-22 15:28:29.000000000 -0500
@@ -691,6 +691,51 @@ struct  pci_error_handlers
 	void (*resume)(struct pci_dev *dev);      /* Device driver may resume normal operations */
 };
 
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
+	enum pci_channel_state state; /* PCI bus state for the affected device */
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
+                            enum pci_channel_state state,
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
--- linux-2.6.12-git10/drivers/pci/Makefile.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/drivers/pci/Makefile	2005-06-22 15:28:29.000000000 -0500
@@ -3,7 +3,7 @@
 #
 
 obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
-			names.o pci-driver.o search.o pci-sysfs.o \
+			names.o pci-driver.o pci-error.o search.o pci-sysfs.o \
 			rom.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
--- linux-2.6.12-git10/drivers/pci/pci-error.c.linas-orig	2005-06-22 15:28:15.000000000 -0500
+++ linux-2.6.12-git10/drivers/pci/pci-error.c	2005-06-22 15:28:29.000000000 -0500
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
+                            enum pci_channel_state state,
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
+/********************** END OF FILE ******************************/

--zYM0uCDKw75PZbzx--

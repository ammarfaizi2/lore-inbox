Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWDGVSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWDGVSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWDGVSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:18:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:63679 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964977AbWDGVSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:18:30 -0400
Date: Fri, 7 Apr 2006 16:18:22 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pseries: clear PCI failure counter if no new failures.
Message-ID: <20060407211822.GI25225@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] powerpc/pseries: clear PCI failure counter if no new failures.

The current PCI error recovery system keeps track of the number of 
PCI card resets, and refuses to bring a card back up if this number 
is too large. The goal of doing this was to avoid an infinite loop 
of resets if a card is obviously dead.  However, if the failures are
rare, but the machine has a high uptime, this mechanism might still
be triggered; this is too harsh.

This patch will avoids this problem by decrementing the fail count 
after an hour. Thus, as long as a pci card BSOD's less than 6 times 
an hour, it will continue to be reset indefinitely. If it's failure 
rate is greater than that, it will be taken off-line permanently.

This patch is larger than it might otherwise be because it 
changes indentation by removing a pointless while-loop. The while 
loop is not needed, as the handler is invoked once fo each event 
(by schedule_work()); the loop is leftover cruft from an earlier 
implementation. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |   13 +++---
 arch/powerpc/platforms/pseries/eeh_event.c  |   60 +++++++++++++++-------------
 include/asm-powerpc/eeh_event.h             |   10 ++--
 3 files changed, 45 insertions(+), 38 deletions(-)

Index: linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-04-04 15:28:59.000000000 -0500
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_driver.c	2006-04-07 16:08:27.000000000 -0500
@@ -23,9 +23,8 @@
  *
  */
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/notifier.h>
+#include <linux/irq.h>
 #include <linux/pci.h>
 #include <asm/eeh.h>
 #include <asm/eeh_event.h>
@@ -250,7 +249,7 @@ static int eeh_reset_device (struct pci_
  */
 #define MAX_WAIT_FOR_RECOVERY 15
 
-void handle_eeh_events (struct eeh_event *event)
+struct pci_dn * handle_eeh_events (struct eeh_event *event)
 {
 	struct device_node *frozen_dn;
 	struct pci_dn *frozen_pdn;
@@ -265,7 +264,7 @@ void handle_eeh_events (struct eeh_event
 	if (!frozen_dn) {
 		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint for %s\n",
 		        pci_name(event->dev));
-		return;
+		return NULL;
 	}
 
 	/* There are two different styles for coming up with the PE.
@@ -280,7 +279,7 @@ void handle_eeh_events (struct eeh_event
 	if (!frozen_bus) {
 		printk(KERN_ERR "EEH: Cannot find PCI bus for %s\n",
 		        frozen_dn->full_name);
-		return;
+		return NULL;
 	}
 
 #if 0
@@ -355,7 +354,7 @@ void handle_eeh_events (struct eeh_event
 	/* Tell all device drivers that they can resume operations */
 	pci_walk_bus(frozen_bus, eeh_report_resume, NULL);
 
-	return;
+	return frozen_pdn;
 	
 excess_failures:
 	/*
@@ -384,6 +383,8 @@ perm_error:
 
 	/* Shut down the device drivers for good. */
 	pcibios_remove_pci_devices(frozen_bus);
+
+	return NULL;
 }
 
 /* ---------- end of file ---------- */
Index: linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_event.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh_event.c	2006-04-04 15:28:59.000000000 -0500
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_event.c	2006-04-05 09:56:38.000000000 -0500
@@ -18,6 +18,7 @@
  * Copyright (c) 2005 Linas Vepstas <linas@linas.org>
  */
 
+#include <linux/delay.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -56,38 +57,43 @@ static int eeh_event_handler(void * dumm
 {
 	unsigned long flags;
 	struct eeh_event	*event;
+	struct pci_dn *pdn;
 
 	daemonize ("eehd");
+	set_current_state(TASK_INTERRUPTIBLE);
 
-	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
+	spin_lock_irqsave(&eeh_eventlist_lock, flags);
+	event = NULL;
+
+	/* Unqueue the event, get ready to process. */
+	if (!list_empty(&eeh_eventlist)) {
+		event = list_entry(eeh_eventlist.next, struct eeh_event, list);
+		list_del(&event->list);
+	}
+	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
 
-		spin_lock_irqsave(&eeh_eventlist_lock, flags);
-		event = NULL;
+	if (event == NULL)
+		return 0;
 
-		/* Unqueue the event, get ready to process. */
-		if (!list_empty(&eeh_eventlist)) {
-			event = list_entry(eeh_eventlist.next, struct eeh_event, list);
-			list_del(&event->list);
-		}
-		spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
-
-		if (event == NULL)
-			break;
-
-		/* Serialize processing of EEH events */
-		mutex_lock(&eeh_event_mutex);
-		eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
-
-		printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
-		       pci_name(event->dev));
-
-		handle_eeh_events(event);
-
-		eeh_clear_slot(event->dn, EEH_MODE_RECOVERING);
-		pci_dev_put(event->dev);
-		kfree(event);
-		mutex_unlock(&eeh_event_mutex);
+	/* Serialize processing of EEH events */
+	mutex_lock(&eeh_event_mutex);
+	eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
+
+	printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
+	       pci_name(event->dev));
+
+	pdn = handle_eeh_events(event);
+
+	eeh_clear_slot(event->dn, EEH_MODE_RECOVERING);
+	pci_dev_put(event->dev);
+	kfree(event);
+	mutex_unlock(&eeh_event_mutex);
+
+	/* If there are no new errors after an hour, clear the counter. */
+	if (pdn && pdn->eeh_freeze_count>0) {
+		msleep_interruptible (3600*1000);
+		if (pdn->eeh_freeze_count>0)
+			pdn->eeh_freeze_count--;
 	}
 
 	return 0;
Index: linux-2.6.17-rc1/include/asm-powerpc/eeh_event.h
===================================================================
--- linux-2.6.17-rc1.orig/include/asm-powerpc/eeh_event.h	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.17-rc1/include/asm-powerpc/eeh_event.h	2006-04-04 15:37:22.000000000 -0500
@@ -18,8 +18,8 @@
  * Copyright (c) 2005 Linas Vepstas <linas@linas.org>
  */
 
-#ifndef ASM_PPC64_EEH_EVENT_H
-#define ASM_PPC64_EEH_EVENT_H
+#ifndef ASM_POWERPC_EEH_EVENT_H
+#define ASM_POWERPC_EEH_EVENT_H
 #ifdef __KERNEL__
 
 /** EEH event -- structure holding pci controller data that describes
@@ -39,7 +39,7 @@ struct eeh_event {
  * @dev pci device
  *
  * This routine builds a PCI error event which will be delivered
- * to all listeners on the peh_notifier_chain.
+ * to all listeners on the eeh_notifier_chain.
  *
  * This routine can be called within an interrupt context;
  * the actual event will be delivered in a normal context
@@ -51,7 +51,7 @@ int eeh_send_failure_event (struct devic
                             int time_unavail);
 
 /* Main recovery function */
-void handle_eeh_events (struct eeh_event *);
+struct pci_dn * handle_eeh_events (struct eeh_event *);
 
 #endif /* __KERNEL__ */
-#endif /* ASM_PPC64_EEH_EVENT_H */
+#endif /* ASM_POWERPC_EEH_EVENT_H */

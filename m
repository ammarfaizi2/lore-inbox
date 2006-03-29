Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWC2V3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWC2V3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 16:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWC2V3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 16:29:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:14745 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750920AbWC2V3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 16:29:31 -0500
Date: Wed, 29 Mar 2006 15:29:18 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org
Subject: [PATCH]: powerpc/pseries: mutex lock to serialze EEH event processing
Message-ID: <20060329212918.GJ2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,
Please review/apply/forward upstream. Seems I forgot to do this before.
--linas

[PATCH]: powerpc/pseries: mutex lock to serialze EEH event processing

This patch forces the processing of EEH PCI events to be serialized,
using a very simple mutex lock. This serialization is required to 
avoid races involving additional PCI device failures that may occur
during the recovery hase of a previous failure.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_event.c |   30 +++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

Index: linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_event.c
===================================================================
--- linux-2.6.16-git6.orig/arch/powerpc/platforms/pseries/eeh_event.c	2006-03-28 17:44:38.000000000 -0600
+++ linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_event.c	2006-03-29 14:45:42.522111515 -0600
@@ -19,7 +19,9 @@
  */
 
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/workqueue.h>
 #include <asm/eeh_event.h>
 #include <asm/ppc-pci.h>
 
@@ -37,14 +39,18 @@ LIST_HEAD(eeh_eventlist);
 static void eeh_thread_launcher(void *);
 DECLARE_WORK(eeh_event_wq, eeh_thread_launcher, NULL);
 
+/* Serialize reset sequences for a given pci device */
+DEFINE_MUTEX(eeh_event_mutex);
+
 /**
- * eeh_event_handler - dispatch EEH events.  The detection of a frozen
- * slot can occur inside an interrupt, where it can be hard to do
- * anything about it.  The goal of this routine is to pull these
- * detection events out of the context of the interrupt handler, and
- * re-dispatch them for processing at a later time in a normal context.
- *
+ * eeh_event_handler - dispatch EEH events.
  * @dummy - unused
+ *
+ * The detection of a frozen slot can occur inside an interrupt,
+ * where it can be hard to do anything about it.  The goal of this
+ * routine is to pull these detection events out of the context
+ * of the interrupt handler, and re-dispatch them for processing
+ * at a later time in a normal context.
  */
 static int eeh_event_handler(void * dummy)
 {
@@ -64,23 +70,24 @@ static int eeh_event_handler(void * dumm
 			event = list_entry(eeh_eventlist.next, struct eeh_event, list);
 			list_del(&event->list);
 		}
-		
-		if (event)
-			eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
-
 		spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+
 		if (event == NULL)
 			break;
 
+		/* Serialize processing of EEH events */
+		mutex_lock(&eeh_event_mutex);
+		eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
+
 		printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
 		       pci_name(event->dev));
 
 		handle_eeh_events(event);
 
 		eeh_clear_slot(event->dn, EEH_MODE_RECOVERING);
-
 		pci_dev_put(event->dev);
 		kfree(event);
+		mutex_unlock(&eeh_event_mutex);
 	}
 
 	return 0;
@@ -88,7 +95,6 @@ static int eeh_event_handler(void * dumm
 
 /**
  * eeh_thread_launcher
- *
  * @dummy - unused
  */
 static void eeh_thread_launcher(void *dummy)

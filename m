Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263842AbUFCTq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbUFCTq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 15:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbUFCTq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 15:46:26 -0400
Received: from unicorn.sch.bme.hu ([152.66.208.4]:39654 "EHLO
	unicorn.sch.bme.hu") by vger.kernel.org with ESMTP id S263842AbUFCTqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 15:46:21 -0400
Date: Thu, 3 Jun 2004 21:46:07 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: ACPI related hangup during boot, 2.6.6 worked ok, 2.6.7-rc2 freezes
Message-ID: <20040603194607.GA26410@unicorn.sch.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!


On an Intel D865GRH motherboard kernel 2.6.6 works fine, but 2.6.7-rc2 
(vanilla, -mm1 and -mm2 too) freezes during boot if acpi is enabled.
(using acpi=off, it boots and works)

I could not gather any useable call trace or other debug information.

I could though find the diff which causes the trouble, to revert 
2.6.7-rc2 to a working version, I have to apply:


diff -Naurd linux-bad/drivers/acpi/acpi_ksyms.c linux-good/drivers/acpi/acpi_ksyms.c
--- linux-bad/drivers/acpi/acpi_ksyms.c	2004-06-01 12:42:05.000000000 +0200
+++ linux-good/drivers/acpi/acpi_ksyms.c	2004-05-10 04:32:27.000000000 +0200
@@ -106,7 +106,7 @@
 EXPORT_SYMBOL(acpi_os_create_semaphore);
 EXPORT_SYMBOL(acpi_os_delete_semaphore);
 EXPORT_SYMBOL(acpi_os_wait_semaphore);
-EXPORT_SYMBOL(acpi_os_wait_events_complete);
+
 EXPORT_SYMBOL(acpi_os_read_pci_configuration);
 
 /* ACPI Utilities (acpi_utils.c) */
diff -Naurd linux-bad/drivers/acpi/events/evxface.c linux-good/drivers/acpi/events/evxface.c
--- linux-bad/drivers/acpi/events/evxface.c	2004-06-01 12:42:05.000000000 +0200
+++ linux-good/drivers/acpi/events/evxface.c	2004-05-10 04:32:39.000000000 +0200
@@ -406,15 +406,6 @@
 			goto unlock_and_exit;
 		}
 
-		/* Make sure all deferred tasks are completed */
-
-		(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
-		acpi_os_wait_events_complete(NULL);
-		status = acpi_ut_acquire_mutex (ACPI_MTX_NAMESPACE);
-		if (ACPI_FAILURE (status)) {
-			return_ACPI_STATUS (status);
- 		}
-
 		if (handler_type == ACPI_SYSTEM_NOTIFY) {
 			acpi_gbl_system_notify.node  = NULL;
 			acpi_gbl_system_notify.handler = NULL;
@@ -461,15 +452,6 @@
 			goto unlock_and_exit;
 		}
 
-		/* Make sure all deferred tasks are completed */
-
-		(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
-		acpi_os_wait_events_complete(NULL);
-		status = acpi_ut_acquire_mutex (ACPI_MTX_NAMESPACE);
-		if (ACPI_FAILURE (status)) {
-			return_ACPI_STATUS (status);
- 		}
-
 		/* Remove the handler */
 
 		if (handler_type == ACPI_SYSTEM_NOTIFY) {
@@ -632,15 +614,6 @@
 		goto unlock_and_exit;
 	}
 
-	/* Make sure all deferred tasks are completed */
-
-	(void) acpi_ut_release_mutex (ACPI_MTX_EVENTS);
-	acpi_os_wait_events_complete(NULL);
-	status = acpi_ut_acquire_mutex (ACPI_MTX_EVENTS);
-	if (ACPI_FAILURE (status)) {
-		return_ACPI_STATUS (status);
- 	}
-
 	/* Remove the handler */
 
 	acpi_os_acquire_lock (acpi_gbl_gpe_lock, ACPI_NOT_ISR);
diff -Naurd linux-bad/drivers/acpi/osl.c linux-good/drivers/acpi/osl.c
--- linux-bad/drivers/acpi/osl.c	2004-06-01 12:42:30.000000000 +0200
+++ linux-good/drivers/acpi/osl.c	2004-05-30 14:37:40.000000000 +0200
@@ -66,7 +66,6 @@
 static unsigned int acpi_irq_irq;
 static OSD_HANDLER acpi_irq_handler;
 static void *acpi_irq_context;
-static struct workqueue_struct *kacpid_wq;
 
 acpi_status
 acpi_os_initialize(void)
@@ -81,8 +80,6 @@
 		return AE_NULL_ENTRY;
 	}
 #endif
-	kacpid_wq = create_singlethread_workqueue("kacpid");
-	BUG_ON(!kacpid_wq);
 
 	return AE_OK;
 }
@@ -95,8 +92,6 @@
 						 acpi_irq_handler);
 	}
 
-	destroy_workqueue(kacpid_wq);
-
 	return AE_OK;
 }
 
@@ -659,8 +654,8 @@
 	task = (void *)(dpc+1);
 	INIT_WORK(task, acpi_os_execute_deferred, (void*)dpc);
 
-	if (!queue_work(kacpid_wq, task)) {
-		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Call to queue_work() failed.\n"));
+	if (!schedule_work(task)) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Call to schedule_work() failed.\n"));
 		kfree(dpc);
 		status = AE_ERROR;
 	}
@@ -668,13 +663,6 @@
 	return_ACPI_STATUS (status);
 }
 
-void
-acpi_os_wait_events_complete(
-	void *context)
-{
-	flush_workqueue(kacpid_wq);
-}
-
 /*
  * Allocate the memory for a spinlock and initialize it.
  */


Understanding why this is needed is beyond my current capabilities, but 
I hope you can find it out :)


-- 
pozsy

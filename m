Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUHXN3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUHXN3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267795AbUHXN1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:27:42 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:22426 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S267792AbUHXNZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:25:56 -0400
Date: Tue, 24 Aug 2004 15:26:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: sclp driver changes.
Message-ID: <20040824132620.GC5954@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: sclp driver changes.

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

sclp driver changes:
 - Add reboot notifier to reset the sclp send/receive masks on shutdown.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/sclp.c |   43 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 7 deletions(-)

diff -urN linux-2.6/drivers/s390/char/sclp.c linux-2.6-s390/drivers/s390/char/sclp.c
--- linux-2.6/drivers/s390/char/sclp.c	Sat Aug 14 12:55:35 2004
+++ linux-2.6-s390/drivers/s390/char/sclp.c	Tue Aug 24 15:12:43 2004
@@ -20,6 +20,7 @@
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/cpumask.h>
+#include <linux/reboot.h>
 #include <asm/s390_ext.h>
 #include <asm/processor.h>
 
@@ -60,6 +61,7 @@
 #define SCLP_INIT		0
 #define SCLP_RUNNING		1
 #define SCLP_READING		2
+#define SCLP_SHUTDOWN		3
 
 #define SCLP_INIT_POLL_INTERVAL	1
 #define SCLP_BUSY_POLL_INTERVAL	1
@@ -606,10 +608,12 @@
 	sccb->mask_length = sizeof(sccb_mask_t);
 	/* copy in the sccb mask of the registered event types */
 	spin_lock_irqsave(&sclp_lock, flags);
-	list_for_each(l, &sclp_reg_list) {
-		t = list_entry(l, struct sclp_register, list);
-		sccb->receive_mask |= t->receive_mask;
-		sccb->send_mask |= t->send_mask;
+	if (!test_bit(SCLP_SHUTDOWN, &sclp_status)) {
+		list_for_each(l, &sclp_reg_list) {
+			t = list_entry(l, struct sclp_register, list);
+			sccb->receive_mask |= t->receive_mask;
+			sccb->send_mask |= t->send_mask;
+		}
 	}
 	sccb->sclp_receive_mask = 0;
 	sccb->sclp_send_mask = 0;
@@ -647,9 +651,10 @@
 		/* WRITEMASK failed - we cannot rely on receiving a state
 		   change event, so initially, polling is the only alternative
 		   for us to ever become operational. */
-		if (!timer_pending(&retry_timer) ||
-		    !mod_timer(&retry_timer,
-			       jiffies + SCLP_INIT_POLL_INTERVAL*HZ)) {
+		if (!test_bit(SCLP_SHUTDOWN, &sclp_status) &&
+		    (!timer_pending(&retry_timer) ||
+		     !mod_timer(&retry_timer,
+			       jiffies + SCLP_INIT_POLL_INTERVAL*HZ))) {
 			retry_timer.function = sclp_init_mask_retry;
 			retry_timer.data = 0;
 			retry_timer.expires = jiffies +
@@ -671,6 +676,26 @@
 	sclp_init_mask();
 }
 
+/* Reboot event handler - reset send and receive mask to prevent pending SCLP
+ * events from interfering with rebooted system. */
+static int
+sclp_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+	unsigned long flags;
+
+	/* Note: need spinlock to maintain atomicity when accessing global
+         * variables. */
+	spin_lock_irqsave(&sclp_lock, flags);
+	set_bit(SCLP_SHUTDOWN, &sclp_status);
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	sclp_init_mask();
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sclp_reboot_notifier = {
+	.notifier_call = sclp_reboot_event
+};
+
 /*
  * sclp setup function. Called early (no kmalloc!) from sclp_console_init().
  */
@@ -691,6 +716,10 @@
 	list_add(&sclp_state_change_event.list, &sclp_reg_list);
 	list_add(&sclp_quiesce_event.list, &sclp_reg_list);
 
+	rc = register_reboot_notifier(&sclp_reboot_notifier);
+	if (rc)
+		return rc;
+
 	/*
 	 * request the 0x2401 external interrupt
 	 * The sclp driver is initialized early (before kmalloc works). We

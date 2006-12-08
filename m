Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425474AbWLHMQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425474AbWLHMQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425477AbWLHMQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:16:40 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:7529
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1425474AbWLHMQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:16:39 -0500
Message-Id: <45796600.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Fri, 08 Dec 2006 12:17:52 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <a.zummo@towertech.it>, <p_gortmaker@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] RTC driver init adjustment
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure RTC driver doesn't use its timer when it doesn't get to set it up (as
it cannot currently prevent other of its functions to be called from outside
when not built as a module - probably this should also be addressed).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19/drivers/char/rtc.c	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.19-rtc-no-irq/drivers/char/rtc.c	2006-12-08 13:03:35.000000000 +0100
@@ -958,6 +958,7 @@ static int __init rtc_init(void)
 		}
 	}
 #endif
+	rtc_has_irq = 0;
 	printk(KERN_ERR "rtc_init: no PC rtc found\n");
 	return -EIO;
 
@@ -972,6 +973,7 @@ found:
 	 * PCI Slot 2 INTA# (and some INTx# in Slot 1).
 	 */
 	if (request_irq(rtc_irq, rtc_interrupt, IRQF_SHARED, "rtc", (void *)&rtc_port)) {
+		rtc_has_irq = 0;
 		printk(KERN_ERR "rtc: cannot register IRQ %d\n", rtc_irq);
 		return -EIO;
 	}
@@ -982,6 +984,9 @@ no_irq:
 	else
 		r = request_mem_region(RTC_PORT(0), RTC_IO_EXTENT, "rtc");
 	if (!r) {
+#ifdef RTC_IRQ
+		rtc_has_irq = 0;
+#endif
 		printk(KERN_ERR "rtc: I/O resource %lx is not free.\n",
 		       (long)(RTC_PORT(0)));
 		return -EIO;
@@ -996,6 +1001,7 @@ no_irq:
 
 	if(request_irq(RTC_IRQ, rtc_int_handler_ptr, IRQF_DISABLED, "rtc", NULL)) {
 		/* Yeah right, seeing as irq 8 doesn't even hit the bus. */
+		rtc_has_irq = 0;
 		printk(KERN_ERR "rtc: IRQ %d is not free.\n", RTC_IRQ);
 		if (RTC_IOMAPPED)
 			release_region(RTC_PORT(0), RTC_IO_EXTENT);
@@ -1012,6 +1018,7 @@ no_irq:
 	if (misc_register(&rtc_dev)) {
 #ifdef RTC_IRQ
 		free_irq(RTC_IRQ, NULL);
+		rtc_has_irq = 0;
 #endif
 		release_region(RTC_PORT(0), RTC_IO_EXTENT);
 		return -ENODEV;
@@ -1021,6 +1028,7 @@ no_irq:
 	if (!ent) {
 #ifdef RTC_IRQ
 		free_irq(RTC_IRQ, NULL);
+		rtc_has_irq = 0;
 #endif
 		release_region(RTC_PORT(0), RTC_IO_EXTENT);
 		misc_deregister(&rtc_dev);



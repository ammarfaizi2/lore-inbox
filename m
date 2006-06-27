Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030679AbWF0Ejh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030679AbWF0Ejh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030682AbWF0Ej0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:26 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:24027 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030679AbWF0EjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:18 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/10] [Suspend2] Atomic copy highlevel routine.
Date: Tue, 27 Jun 2006 14:39:17 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043915.14546.4671.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
References: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This routine essentially duplicates the swsusp_suspend routine, which does
high level steps of the atomic copy. Rather than modifying that routine to
include a number of if (suspend2) else clauses, it seemed better to put a
suspend2ised copy here.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/atomic_copy.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/kernel/power/atomic_copy.c b/kernel/power/atomic_copy.c
index 75e3beb..bb5d74f 100644
--- a/kernel/power/atomic_copy.c
+++ b/kernel/power/atomic_copy.c
@@ -349,3 +349,34 @@ void suspend_copy_pageset1(void)
 	}
 }
 
+int suspend2_suspend(void)
+{
+	int error;
+
+	if ((error = arch_prepare_suspend()))
+		return error;
+	local_irq_disable();
+	/* At this point, device_suspend() has been called, but *not*
+	 * device_power_down(). We *must* device_power_down() now.
+	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
+	 * become desynchronized with the actual state of the hardware
+	 * at resume time, and evil weirdness ensues.
+	 */
+	if ((error = device_power_down(PMSG_FREEZE))) {
+		printk(KERN_ERR "Some devices failed to power down, aborting suspend\n");
+		goto enable_irqs;
+	}
+
+	save_processor_state();
+	if ((error = swsusp_arch_suspend()))
+		printk(KERN_ERR "Error %d suspending\n", error);
+	/* Restore control flow appears here */
+	restore_processor_state();
+	if (!suspend2_in_suspend)
+		copyback_high();
+	device_power_up();
+enable_irqs:
+	local_irq_enable();
+	return error;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

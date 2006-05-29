Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWE2VgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWE2VgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWE2VfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:35:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59832 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751364AbWE2V0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:07 -0400
Date: Mon, 29 May 2006 23:26:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 41/61] lock validator: special locking: genirq
Message-ID: <20060529212626.GO3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
---
 kernel/irq/handle.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux/kernel/irq/handle.c
===================================================================
--- linux.orig/kernel/irq/handle.c
+++ linux/kernel/irq/handle.c
@@ -11,6 +11,7 @@
 #include <linux/random.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/kallsyms.h>
 
 #include "internals.h"
 
@@ -193,3 +194,15 @@ out:
 	return 1;
 }
 
+/*
+ * lockdep: we want to handle all irq_desc locks as a single lock-type:
+ */
+static struct lockdep_type_key irq_desc_lock_type;
+
+void early_init_irq_lock_type(void)
+{
+	int i;
+
+	for (i = 0; i < NR_IRQS; i++)
+		spin_lock_init_key(&irq_desc[i].lock, &irq_desc_lock_type);
+}

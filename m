Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263335AbUJ2OLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUJ2OLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbUJ2OKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:10:17 -0400
Received: from mailserv.intranet.GR ([146.124.14.106]:35203 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id S263330AbUJ2OJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:09:57 -0400
Message-ID: <41824E15.4090906@intracom.gr>
Date: Fri, 29 Oct 2004 17:05:09 +0300
From: Pantelis Antoniou <panto@intracom.gr>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.7.3) Gecko/20040920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Tom Rini <trini@kernel.crashing.org>,
       Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix early request_irq
Content-Type: multipart/mixed;
 boundary="------------000609070809070304070501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000609070809070304070501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi there

The recent consolidation of the IRQ code has caused
a number of PPC embedded cpus to stop working.

The problem is that on init_IRQ these platforms call
request_irq very early, which in turn calls kmalloc
without the memory subsystem being initialized.

The following patch fixes it by keeping a small static
array of irqactions just for this purpose.

This is still not enough to get these platforms working
since I crash on the first interrupt, but at least is a
start.

Regards

Pantelis

Signed-off-by: Pantelis Antoniou <panto@intracom.gr>

---------------------------------------------------------------




--------------000609070809070304070501
Content-Type: text/x-patch;
 name="early-irq-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="early-irq-fix.patch"

--- linux-2.5/kernel/irq/manage.c	2004-10-29 16:39:08.496715752 +0300
+++ linuxppc_2.5-public/kernel/irq/manage.c	2004-10-29 16:44:13.361369280 +0300
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
+#include <linux/bitops.h>
 
 #include "internals.h"
 
@@ -144,6 +145,53 @@
 	return !action;
 }
 
+/* we must support request_irqs before mem init */
+
+#define IRQ_CACHE_ENTRIES 8	/* 8 should be enough */
+
+static spinlock_t irqa_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int irqa_cache_map = (1 << IRQ_CACHE_ENTRIES) - 1;
+static struct irqaction irqa_cache[IRQ_CACHE_ENTRIES];
+
+static struct irqaction *irqaction_alloc(int pri)
+{
+	extern int mem_init_done;
+	int i;
+	unsigned long flags;
+	struct irqaction *irqa;
+
+	if (mem_init_done)
+		return kmalloc(sizeof(struct irqaction), pri);
+
+	spin_lock_irqsave(&irqa_lock, flags);
+	i = ffs(irqa_cache_map);
+	if (i > 0 && --i < IRQ_CACHE_ENTRIES) {
+		irqa_cache_map &= ~(1 << i);
+		irqa = irqa_cache + i;
+	} else
+		irqa = NULL;
+	spin_unlock_irqrestore(&irqa_lock, flags);
+
+	return irqa;
+}
+
+static void irqaction_free(void *ptr)
+{
+	struct irqaction *irqa = ptr;
+	unsigned long flags;
+	int i;
+
+	if (irqa < irqa_cache || irqa >= irqa_cache + IRQ_CACHE_ENTRIES) {
+		kfree(ptr);
+		return;
+	}
+
+	spin_lock_irqsave(&irqa_lock, flags);
+	i = irqa_cache - irqa;
+	irqa_cache_map |= 1 << i;
+	spin_unlock_irqrestore(&irqa_lock, flags);
+}
+
 /*
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
@@ -265,7 +313,7 @@
 
 			/* Make sure it's not being used on another CPU */
 			synchronize_irq(irq);
-			kfree(action);
+			irqaction_free(action);
 			return;
 		}
 		printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
@@ -325,7 +373,7 @@
 	if (!handler)
 		return -EINVAL;
 
-	action = kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
+	action = irqaction_alloc(GFP_ATOMIC);
 	if (!action)
 		return -ENOMEM;
 
@@ -337,10 +385,12 @@
 	action->dev_id = dev_id;
 
 	retval = setup_irq(irq, action);
-	if (retval)
-		kfree(action);
+	if (retval) {
+		irqaction_free(action);
+		return retval;
+	}
 
-	return retval;
+	return 0;
 }
 
 EXPORT_SYMBOL(request_irq);

--------------000609070809070304070501--

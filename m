Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVCHJ4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVCHJ4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVCHJ4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:56:41 -0500
Received: from ozlabs.org ([203.10.76.45]:4566 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261942AbVCHJ4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:56:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16941.30431.170921.155345@cargo.ozlabs.ibm.com>
Date: Tue, 8 Mar 2005 20:56:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: ntl@pobox.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 update irq affinity mask when migrating irqs
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nathan Lynch <ntl@pobox.com>.

When offlining a cpu, any device interrupts which are bound to the cpu
have their affinity forcibly reset to all cpus (the default).
However, the value in /proc/irq/XXX/smp_affinity remains unchanged.
Since we're doing this while all the other cpus are stopped, it should
be safe to just call desc->handler->set_affinity and manually update
the irq_affinity array.


Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

 xics.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

Index: linux-2.6.11-bk2/arch/ppc64/kernel/xics.c
===================================================================
--- linux-2.6.11-bk2.orig/arch/ppc64/kernel/xics.c	2005-03-02 07:38:10.000000000 +0000
+++ linux-2.6.11-bk2/arch/ppc64/kernel/xics.c	2005-03-07 03:52:08.000000000 +0000
@@ -704,15 +704,8 @@ void xics_migrate_irqs_away(void)
 		       virq, cpu);
 
 		/* Reset affinity to all cpus */
-		xics_status[0] = default_distrib_server;
-
-		status = rtas_call(ibm_set_xive, 3, 1, NULL, irq,
-				xics_status[0], xics_status[1]);
-		if (status)
-			printk(KERN_ERR "migrate_irqs_away: irq=%d "
-					"ibm,set-xive returns %d\n",
-					virq, status);
-
+		desc->handler->set_affinity(virq, CPU_MASK_ALL);
+		irq_affinity[virq] = CPU_MASK_ALL;
 unlock:
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVAHRNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVAHRNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVAHRGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:06:00 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:21969 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261221AbVAHREQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:04:16 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050108170433.32690.82747.72350@localhost.localdomain>
In-Reply-To: <20050108170406.32690.36989.11853@localhost.localdomain>
References: <20050108170406.32690.36989.11853@localhost.localdomain>
Subject: [RESEND] [PATCH 3/7] ppc: remove cli()/sti() in arch/ppc/8xx_io/fec.c
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Sat, 8 Jan 2005 11:04:13 -0600
Date: Sat, 8 Jan 2005 11:04:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace save_flags()/resore_flags() with spin_lock_irqsave()/spin_unlock_irqrestore()
and document reasons for locking.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/8xx_io/fec.c linux-2.6.10-mm1/arch/ppc/8xx_io/fec.c
--- linux-2.6.10-mm1-original/arch/ppc/8xx_io/fec.c	2004-12-24 16:35:28.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/8xx_io/fec.c	2005-01-07 19:58:55.806516338 -0500
@@ -389,6 +389,7 @@
 	flush_dcache_range((unsigned long)skb->data,
 			   (unsigned long)skb->data + skb->len);
 
+	/* disable interrupts while triggering transmit */
 	spin_lock_irq(&fep->lock);
 
 	/* Send it on its way.  Tell FEC its ready, interrupt when done,
@@ -539,6 +540,7 @@
 	struct	sk_buff	*skb;
 
 	fep = dev->priv;
+	/* lock while transmitting */
 	spin_lock(&fep->lock);
 	bdp = fep->dirty_tx;
 
@@ -799,6 +801,7 @@
 
 	if ((mip = mii_head) != NULL) {
 		ep->fec_mii_data = mip->mii_regval;
+
 	}
 }
 
@@ -817,8 +820,8 @@
 
 	retval = 0;
 
-	save_flags(flags);
-	cli();
+	/* lock while modifying mii_list */
+	spin_lock_irqsave(&fep->lock, flags);
 
 	if ((mip = mii_free) != NULL) {
 		mii_free = mip->mii_next;
@@ -836,7 +839,7 @@
 		retval = 1;
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&fep->lock, flags);
 
 	return(retval);
 }

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWEEQri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWEEQri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWEEQow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:44:52 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:33412 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751646AbWEEQou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:44:50 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <4.420169009@selenic.com>
Subject: [PATCH 3/14] random: Make CCISS use add_disk_randomness
Date: Fri, 05 May 2006 11:42:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make CCISS use add_disk_randomness

Disk devices should use the add_disk_randomness API rather than
SA_SAMPLE_RANDOM.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/block/cciss.c
===================================================================
--- 2.6.orig/drivers/block/cciss.c	2006-05-02 17:29:26.000000000 -0500
+++ 2.6/drivers/block/cciss.c	2006-05-03 11:22:54.000000000 -0500
@@ -1221,6 +1221,7 @@ static void cciss_softirq_done(struct re
 	printk("Done with %p\n", rq);
 #endif /* CCISS_DEBUG */
 
+	add_disk_randomness(rq->rq_disk);
 	spin_lock_irqsave(&h->lock, flags);
 	end_that_request_last(rq, rq->errors);
 	cmd_free(h, cmd,1);
@@ -3152,8 +3153,7 @@ static int __devinit cciss_init_one(stru
 	/* make sure the board interrupts are off */
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_OFF);
 	if( request_irq(hba[i]->intr[SIMPLE_MODE_INT], do_cciss_intr,
-		SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
-			hba[i]->devname, hba[i])) {
+		SA_INTERRUPT | SA_SHIRQ, hba[i]->devname, hba[i])) {
 		printk(KERN_ERR "cciss: Unable to get irq %d for %s\n",
 			hba[i]->intr[SIMPLE_MODE_INT], hba[i]->devname);
 		goto clean2;

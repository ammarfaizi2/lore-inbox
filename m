Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUBEAJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUBEAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:07:52 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:24594 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S264428AbUBEAG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:06:58 -0500
Date: Wed, 4 Feb 2004 18:11:10 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [4 of 11]
Message-ID: <Pine.LNX.4.58.0402041809230.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4 of 11. Please apply in order.
This patch fixes a bug when sharing IRQs with another controller that
receives a lot of interrupts. Without this check we will panic the system
when unloading and reloading the driver. This is in 2.4.
Please consider this for inclusion. Tested against 2.6.2.
--------------------------------------------------------------------------------------
diff -burN lx261-p003/drivers/block/cciss.c lx261/drivers/block/cciss.c
--- lx261-p003/drivers/block/cciss.c	2004-01-21 16:31:59.000000000 -0600
+++ lx261/drivers/block/cciss.c	2004-01-21 17:02:06.000000000 -0600
@@ -1983,7 +1983,7 @@


 	/* Is this interrupt for us? */
-	if ( h->access.intr_pending(h) == 0)
+	if (( h->access.intr_pending(h) == 0) || (h->interrupts_enabled == 0))
 		return IRQ_NONE;

 	/*
diff -burN lx261-p003/drivers/block/cciss.h lx261/drivers/block/cciss.h
--- lx261-p003/drivers/block/cciss.h	2004-01-21 15:53:59.000000000 -0600
+++ lx261/drivers/block/cciss.h	2004-01-21 16:59:34.000000000 -0600
@@ -48,7 +48,7 @@
 	unsigned long io_mem_length;
 	CfgTable_struct *cfgtable;
 	int	intr;
-
+	int	interrupts_enabled;
 	int 	max_commands;
 	int	commands_outstanding;
 	int 	max_outstanding; /* Debug */
@@ -134,9 +134,11 @@
 {
 	if (val)
 	{ /* Turn interrupts on */
+		h->interrupts_enabled = 1;
 		writel(0, h->vaddr + SA5_REPLY_INTR_MASK_OFFSET);
 	} else /* Turn them off */
 	{
+		h->interrupts_enabled = 0;
         	writel( SA5_INTR_OFF,
 			h->vaddr + SA5_REPLY_INTR_MASK_OFFSET);
 	}
@@ -150,9 +152,11 @@
 {
         if (val)
         { /* Turn interrupts on */
+		h->interrupts_enabled = 1;
                 writel(0, h->vaddr + SA5_REPLY_INTR_MASK_OFFSET);
         } else /* Turn them off */
         {
+		h->interrupts_enabled = 0;
                 writel( SA5B_INTR_OFF,
                         h->vaddr + SA5_REPLY_INTR_MASK_OFFSET);
         }

Thanks,
mikem
mike.miller@hp.com


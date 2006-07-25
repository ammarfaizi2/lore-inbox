Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWGYWeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWGYWeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWGYWeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:34:20 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:27297 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751533AbWGYWeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:34:20 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] IRDA: Replace hard-coded dev_self[] array sizes with ARRAY_SIZE()
Date: Tue, 25 Jul 2006 16:34:13 -0600
User-Agent: KMail/1.8.3
Cc: Samuel Ortiz <samuel@sortiz.org>, irda-users@lists.sourceforge.net,
       Dag Brattli <dagb@cs.uit.no>, sda@bdit.de,
       Benjamin Kong <benjamin_kong@ali.com.tw>,
       Clear Zhang <clear_zhang@ali.com.tw>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251634.13437.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several IR drivers used "for (i = 0; i < 4; i++)" to walk their
dev_self[] table.  Better to use ARRAY_SIZE().  And fix ali-ircc
so it won't run off the end if we find too many adapters.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm2/drivers/net/irda/w83977af_ir.c
===================================================================
--- work-mm2.orig/drivers/net/irda/w83977af_ir.c	2006-07-20 16:27:36.000000000 -0600
+++ work-mm2/drivers/net/irda/w83977af_ir.c	2006-07-20 16:27:35.000000000 -0600
@@ -117,7 +117,7 @@
 
 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
 
-	for (i=0; (io[i] < 2000) && (i < 4); i++) { 
+	for (i=0; (io[i] < 2000) && (i < ARRAY_SIZE(dev_self)); i++) {
 		if (w83977af_open(i, io[i], irq[i], dma[i]) == 0)
 			return 0;
 	}
@@ -136,7 +136,7 @@
 
         IRDA_DEBUG(4, "%s()\n", __FUNCTION__ );
 
-	for (i=0; i < 4; i++) {
+	for (i=0; i < ARRAY_SIZE(dev_self); i++) {
 		if (dev_self[i])
 			w83977af_close(dev_self[i]);
 	}
Index: work-mm2/drivers/net/irda/via-ircc.c
===================================================================
--- work-mm2.orig/drivers/net/irda/via-ircc.c	2006-07-25 16:04:03.000000000 -0600
+++ work-mm2/drivers/net/irda/via-ircc.c	2006-07-25 16:04:13.000000000 -0600
@@ -279,7 +279,7 @@
 
 	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
-	for (i=0; i < 4; i++) {
+	for (i=0; i < ARRAY_SIZE(dev_self); i++) {
 		if (dev_self[i])
 			via_ircc_close(dev_self[i]);
 	}
@@ -327,6 +327,9 @@
 
 	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
+	if (i >= ARRAY_SIZE(dev_self))
+		return -ENOMEM;
+
 	/* Allocate new instance of the driver */
 	dev = alloc_irdadev(sizeof(struct via_ircc_cb));
 	if (dev == NULL) 
Index: work-mm2/drivers/net/irda/ali-ircc.c
===================================================================
--- work-mm2.orig/drivers/net/irda/ali-ircc.c	2006-07-25 16:04:03.000000000 -0600
+++ work-mm2/drivers/net/irda/ali-ircc.c	2006-07-25 16:04:30.000000000 -0600
@@ -249,7 +249,7 @@
 
 	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);	
 
-	for (i=0; i < 4; i++) {
+	for (i=0; i < ARRAY_SIZE(dev_self); i++) {
 		if (dev_self[i])
 			ali_ircc_close(dev_self[i]);
 	}
@@ -273,6 +273,12 @@
 	int err;
 			
 	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);	
+
+	if (i >= ARRAY_SIZE(dev_self)) {
+		IRDA_ERROR("%s(), maximum number of supported chips reached!\n",
+			   __FUNCTION__);
+		return -ENOMEM;
+	}
 	
 	/* Set FIR FIFO and DMA Threshold */
 	if ((ali_ircc_setup(info)) == -1)
Index: work-mm2/drivers/net/irda/irport.c
===================================================================
--- work-mm2.orig/drivers/net/irda/irport.c	2006-07-25 16:04:03.000000000 -0600
+++ work-mm2/drivers/net/irda/irport.c	2006-07-25 16:04:27.000000000 -0600
@@ -1090,7 +1090,7 @@
 {
  	int i;
 
- 	for (i=0; (io[i] < 2000) && (i < 4); i++) {
+ 	for (i=0; (io[i] < 2000) && (i < ARRAY_SIZE(dev_self)); i++) {
  		if (irport_open(i, io[i], irq[i]) != NULL)
  			return 0;
  	}
@@ -1112,7 +1112,7 @@
 
         IRDA_DEBUG( 4, "%s()\n", __FUNCTION__);
 
-	for (i=0; i < 4; i++) {
+	for (i=0; i < ARRAY_SIZE(dev_self); i++) {
  		if (dev_self[i])
  			irport_close(dev_self[i]);
  	}

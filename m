Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933372AbWFXJgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933372AbWFXJgw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 05:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933374AbWFXJgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 05:36:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:3983 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S933372AbWFXJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 05:36:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 24 Jun 2006 11:35:29 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [RFC PATCH 2.6.17-mm1 3/3] ieee1394: nodemgr: read tlabel attributes
 atomically
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.e74b06c4105348f6@s5r6.in-berlin.de>
Message-ID: <tkrat.2ff7b57397a5a37e@s5r6.in-berlin.de>
References: <449BEBFB.60302@s5r6.in-berlin.de>
 <200606230904.k5N94Al3005245@shell0.pdx.osdl.net> 
 <30866.1151072338@warthog.cambridge.redhat.com>
 <tkrat.df6845846c72176e@s5r6.in-berlin.de>
 <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de>
 <tkrat.e74b06c4105348f6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.892) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A node_entry's sysfs attributes tlabels_free, tlabels_allocations, and
tlabels_mask may theoretically be sometimes wrong if they were read
without taking the respective lock.  Although this is not very serious
since these attributes are rarely accessed and not interesting outside
of driver or application development, why not do it properly.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
applies after patch "ieee1394: nodemgr: do not peek into struct semaphore"
http://marc.theaimsgroup.com/?l=linux-mm-commits&m=115113030025655

 drivers/ieee1394/ieee1394_transactions.c |    2 -
 drivers/ieee1394/ieee1394_transactions.h |    5 +++
 drivers/ieee1394/nodemgr.c               |   31 ++++++++++++++++++-----
 3 files changed, 31 insertions(+), 7 deletions(-)

Index: linux/drivers/ieee1394/ieee1394_transactions.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_transactions.h	2006-04-24 22:20:24.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_transactions.h	2006-06-24 11:00:23.000000000 +0200
@@ -1,6 +1,11 @@
 #ifndef _IEEE1394_TRANSACTIONS_H
 #define _IEEE1394_TRANSACTIONS_H
 
+#include <linux/spinlock_types.h>
+
+/* internal to ieee1394 core */
+extern spinlock_t hpsb_tlabel_lock;
+
 #include "ieee1394_core.h"
 
 
Index: linux/drivers/ieee1394/ieee1394_transactions.c
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_transactions.c	2006-06-24 10:08:35.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_transactions.c	2006-06-24 10:30:00.000000000 +0200
@@ -31,7 +31,7 @@
         packet->header[1] = (packet->host->node_id << 16) | (addr >> 32); \
         packet->header[2] = addr & 0xffffffff
 
-static spinlock_t hpsb_tlabel_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t hpsb_tlabel_lock = SPIN_LOCK_UNLOCKED;
 
 static void fill_async_readquad(struct hpsb_packet *packet, u64 addr)
 {
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-06-23 19:10:32.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-06-24 10:43:18.000000000 +0200
@@ -327,12 +327,17 @@ static ssize_t fw_show_ne_bus_options(st
 static DEVICE_ATTR(bus_options,S_IRUGO,fw_show_ne_bus_options,NULL);
 
 
-/* tlabels_free, tlabels_allocations, tlabels_mask are read non-atomically
- * here, therefore displayed values may be occasionally wrong. */
 static ssize_t fw_show_ne_tlabels_free(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
-	return sprintf(buf, "%d\n", 64 - bitmap_weight(ne->tpool->pool, 64));
+	unsigned long flags;
+	int tf;
+
+	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
+	tf = 64 - bitmap_weight(ne->tpool->pool, 64);
+	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
+
+	return sprintf(buf, "%d\n", tf);
 }
 static DEVICE_ATTR(tlabels_free,S_IRUGO,fw_show_ne_tlabels_free,NULL);
 
@@ -340,7 +345,14 @@ static DEVICE_ATTR(tlabels_free,S_IRUGO,
 static ssize_t fw_show_ne_tlabels_allocations(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
-	return sprintf(buf, "%u\n", ne->tpool->allocations);
+	unsigned long flags;
+	int ta;
+
+	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
+	ta = ne->tpool->allocations;
+	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
+
+	return sprintf(buf, "%u\n", ta);
 }
 static DEVICE_ATTR(tlabels_allocations,S_IRUGO,fw_show_ne_tlabels_allocations,NULL);
 
@@ -348,11 +360,18 @@ static DEVICE_ATTR(tlabels_allocations,S
 static ssize_t fw_show_ne_tlabels_mask(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
+	unsigned long flags;
+	u64 tm;
+
+	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
 #if (BITS_PER_LONG <= 32)
-	return sprintf(buf, "0x%08lx%08lx\n", ne->tpool->pool[0], ne->tpool->pool[1]);
+	tm = ((u64)ne->tpool->pool[0] << 32) + ne->tpool->pool[1];
 #else
-	return sprintf(buf, "0x%016lx\n", ne->tpool->pool[0]);
+	tm = ne->tpool->pool[0];
 #endif
+	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
+
+	return sprintf(buf, "0x%016llx\n", tm);
 }
 static DEVICE_ATTR(tlabels_mask, S_IRUGO, fw_show_ne_tlabels_mask, NULL);
 



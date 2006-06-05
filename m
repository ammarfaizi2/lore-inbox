Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750980AbWFELbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWFELbB (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWFELbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:31:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:10189 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750980AbWFELbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:31:00 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 5 Jun 2006 13:28:16 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm3] ieee1394: hl_irqs_lock is taken in hardware
 interrupt context
To: linux1394-devel@lists.sourceforge.net
cc: Arjan van de Ven <arjan@linux.intel.com>, Jiri Slaby <jirislaby@gmail.com>,
        Ben Collins <bcollins@ubuntu.com>,
        Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>,
        =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@ono.com>
In-Reply-To: <1149179744.4533.205.camel@grayson>
Message-ID: <tkrat.02c63cb007e86f12@s5r6.in-berlin.de>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
 <447F0905.8020600@gmail.com>
 <1149176945.3115.70.camel@laptopd505.fenrus.org>
 <1149179744.4533.205.camel@grayson>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ohci1394 and pcilynx call highlevel_host_reset from their hardware
interrupt handler (via hpsb_selfid_complete).  Therefore all readers and
writers of hl_irqs_lock have to disable interrupts.  Reported by Jiri
Slaby and J. A. Magallon.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/highlevel.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

Index: linux/drivers/ieee1394/highlevel.c
===================================================================
--- linux.orig/drivers/ieee1394/highlevel.c	2006-06-03 14:11:58.000000000 +0200
+++ linux/drivers/ieee1394/highlevel.c	2006-06-05 11:42:07.000000000 +0200
@@ -210,6 +210,8 @@ static int highlevel_for_each_host_reg(s
 
 void hpsb_register_highlevel(struct hpsb_highlevel *hl)
 {
+	unsigned long flags;
+
         INIT_LIST_HEAD(&hl->addr_list);
 	INIT_LIST_HEAD(&hl->host_info_list);
 
@@ -219,9 +221,9 @@ void hpsb_register_highlevel(struct hpsb
         list_add_tail(&hl->hl_list, &hl_drivers);
 	up_write(&hl_drivers_sem);
 
-	write_lock(&hl_irqs_lock);
+	write_lock_irqsave(&hl_irqs_lock, flags);
 	list_add_tail(&hl->irq_list, &hl_irqs);
-	write_unlock(&hl_irqs_lock);
+	write_unlock_irqrestore(&hl_irqs_lock, flags);
 
 	if (hl->add_host)
 		nodemgr_for_each_host(hl, highlevel_for_each_host_reg);
@@ -282,9 +284,11 @@ static int highlevel_for_each_host_unreg
 
 void hpsb_unregister_highlevel(struct hpsb_highlevel *hl)
 {
-	write_lock(&hl_irqs_lock);
+	unsigned long flags;
+
+	write_lock_irqsave(&hl_irqs_lock, flags);
 	list_del(&hl->irq_list);
-	write_unlock(&hl_irqs_lock);
+	write_unlock_irqrestore(&hl_irqs_lock, flags);
 
 	down_write(&hl_drivers_sem);
         list_del(&hl->hl_list);
@@ -518,42 +522,45 @@ void highlevel_remove_host(struct hpsb_h
 
 void highlevel_host_reset(struct hpsb_host *host)
 {
+	unsigned long flags;
         struct hpsb_highlevel *hl;
 
-	read_lock(&hl_irqs_lock);
+	read_lock_irqsave(&hl_irqs_lock, flags);
 	list_for_each_entry(hl, &hl_irqs, irq_list) {
                 if (hl->host_reset)
                         hl->host_reset(host);
         }
-	read_unlock(&hl_irqs_lock);
+	read_unlock_irqrestore(&hl_irqs_lock, flags);
 }
 
 void highlevel_iso_receive(struct hpsb_host *host, void *data, size_t length)
 {
+	unsigned long flags;
         struct hpsb_highlevel *hl;
         int channel = (((quadlet_t *)data)[0] >> 8) & 0x3f;
 
-        read_lock(&hl_irqs_lock);
+        read_lock_irqsave(&hl_irqs_lock, flags);
 	list_for_each_entry(hl, &hl_irqs, irq_list) {
                 if (hl->iso_receive)
                         hl->iso_receive(host, channel, data, length);
         }
-        read_unlock(&hl_irqs_lock);
+        read_unlock_irqrestore(&hl_irqs_lock, flags);
 }
 
 void highlevel_fcp_request(struct hpsb_host *host, int nodeid, int direction,
 			   void *data, size_t length)
 {
+	unsigned long flags;
         struct hpsb_highlevel *hl;
         int cts = ((quadlet_t *)data)[0] >> 4;
 
-        read_lock(&hl_irqs_lock);
+        read_lock_irqsave(&hl_irqs_lock, flags);
 	list_for_each_entry(hl, &hl_irqs, irq_list) {
                 if (hl->fcp_request)
                         hl->fcp_request(host, nodeid, direction, cts, data,
 					length);
         }
-        read_unlock(&hl_irqs_lock);
+        read_unlock_irqrestore(&hl_irqs_lock, flags);
 }
 
 int highlevel_read(struct hpsb_host *host, int nodeid, void *data,



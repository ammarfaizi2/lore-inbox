Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWCSAMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWCSAMH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 19:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWCSAMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 19:12:07 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:35091 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750833AbWCSAMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 19:12:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Bfv8JNKiKkEfFQ+FwG1fOsMnGKV/qHFdj2Wv9dTivXCnfXtbTlCvDV5hlm2LUSwR80ZcYMAIDyeQRG9alm9Uuyp5KRwCU+/N27zB70jgV8nZ8vhX0j3H8Pykmpk4FGPso0cd+Z+lMirg/5WDq7y7xN1t3vcxC31b3h4FIp8QOT8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix a potential NULL pointer deref in znet
Date: Sun, 19 Mar 2006 01:12:31 +0100
User-Agent: KMail/1.9.1
Cc: becker@scyld.com, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603190112.31828.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The coverity checker spotted that we dereference a pointer before we check it
for NULL in drivers/net/znet.c::znet_interrupt().
This fixes the issue.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/net/znet.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc6-orig/drivers/net/znet.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc6/drivers/net/znet.c	2006-03-19 01:08:01.000000000 +0100
@@ -606,17 +606,20 @@ static int znet_send_packet(struct sk_bu
 /* The ZNET interrupt handler. */
 static irqreturn_t znet_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
-	struct net_device *dev = dev_id;
-	struct znet_private *znet = dev->priv;
+	struct net_device *dev;
+	struct znet_private *znet;
 	int ioaddr;
 	int boguscnt = 20;
 	int handled = 0;
 
-	if (dev == NULL) {
+	if (dev_id == NULL) {
 		printk(KERN_WARNING "znet_interrupt(): IRQ %d for unknown device.\n", irq);
 		return IRQ_NONE;
 	}
 
+	dev = dev_id;
+	znet = dev->priv;
+
 	spin_lock (&znet->lock);
 	
 	ioaddr = dev->base_addr;


		

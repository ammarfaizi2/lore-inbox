Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752571AbWCQJYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbWCQJYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbWCQJYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:24:49 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:432 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1752571AbWCQJYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:24:48 -0500
Message-ID: <1142587487.441a805faa348@imp1-g19.free.fr>
Date: Fri, 17 Mar 2006 10:24:47 +0100
From: l.wandrebeck@free.fr
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch 1/1] OSS ali5455 missing return check for request_region()
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 82.127.4.221
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
in sound/oss/ali5455.c, request_region() is called without checking the return
value. Here is a simple patch to fix it.
Please apply, even if OSS is aimed at /dev/null some day :-)
Patch applies cleanly on 2.6.16-rc6 and 2.6.16-rc6-git8.
Regards.

Signed-off-by: Laurent Wandrebeck <l.wandrebeck@free.fr>

--- linux-2.6.16-rc6-low/sound/oss/ali5455.c.ori        2006-03-11
23:12:55.000000000 +0100
+++ linux-2.6.16-rc6-low/sound/oss/ali5455.c    2006-03-16 23:45:27.316837000
+0100
@@ -3457,7 +3457,12 @@ static int __devinit ali_probe(struct pc
        card->channel[4].port = 0xb0;
        card->channel[4].num = 4;
        /* claim our iospace and irq */
-       request_region(card->iobase, 256, card_names[pci_id->driver_data]);
+       if (request_region(card->iobase, 256, card_names[pci_id->driver_data]) <
0) {
+               printk(KERN_ERR "ali_audio: unable to reserve region %d\n",
+                                card->iobase);
+               kfree(card);
+               return -ENODEV;
+       }
        if (request_irq(card->irq, &ali_interrupt, SA_SHIRQ,
                        card_names[pci_id->driver_data], card)) {
                printk(KERN_ERR "ali_audio: unable to allocate irq %d\n",

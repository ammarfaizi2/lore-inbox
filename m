Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWCQN3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWCQN3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWCQN3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:29:07 -0500
Received: from smtp9.wanadoo.fr ([193.252.22.22]:41329 "EHLO smtp9.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932638AbWCQN3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:29:05 -0500
X-ME-UUID: 20060317132904388.5ECE51C0015E@mwinf0908.wanadoo.fr
From: Laurent Wandrebeck <l.wandrebeck@free.fr>
To: linux-kernel@vger.kernel.org
Subject: [patch 1/1] scsi mca_53c9x missing return check for request_region()
Date: Fri, 17 Mar 2006 14:33:05 +0100
User-Agent: KMail/1.8
Cc: akpm@osdl.org, jejb@steeleye.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171433.06029.l.wandrebeck@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
in drivers/scsi/mca_53c9x.c, request_region() is called without checking the return
value. Here is a simple patch to fix it.
Patch against 2.6.16-rc6-git8.
Please CC me on replies.
Regards.

Signed-off-by: Laurent Wandrebeck <l.wandrebeck@free.fr>

--- linux-2.6.16-rc6/drivers/scsi/mca_53c9x.c.ori       2006-03-11 23:12:55.000000000 +0100
+++ linux-2.6.16-rc6/drivers/scsi/mca_53c9x.c   2006-03-17 14:20:44.000000000 +0100
@@ -195,7 +195,15 @@ static int mca_esp_detect(struct scsi_ho
                                return 0;
                        }

-                       request_region(tmp_io_addr, 32, "NCR 53c9x SCSI");
+                       if (!request_region(tmp_io_addr, 32, "NCR 53c9x SCSI")) {
+                               printk("Unable to request region %d.\n",
+                                tmp_io_addr);
+                               free_dma(esp->dma);
+                               free_irq(esp->irq, esp_intr);
+                               esp_deallocate(esp);
+                               scsi_unregister(esp->ehost);
+                               return 0;
+                       }

                        /*
                         * 86C01 handles DMA, IO mode, from address


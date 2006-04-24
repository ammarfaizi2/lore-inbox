Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWDXPEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWDXPEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWDXPEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:04:40 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:16928 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750861AbWDXPEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:04:21 -0400
Date: Mon, 24 Apr 2006 17:04:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, cborntra@de.ibm.com
Subject: [patch 7/13] s390: fix slab debugging.
Message-ID: <20060424150424.GH15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[patch 7/13] s390: fix slab debugging.

With CONFIG_SLAB_DEBUG=y networking over qeth doesn't work. The
problem is that the qib structure embedded in the qeth_irq
structure needs an alignment of 256 but kmalloc only guarantees
an alignment of 8. When using SLAB debugging the alignment of
qeth_irq is not sufficient for the embedded qib structure which
causes all users of qdio (qeth and zfcp) to stop working.
Allocate qeth_irq structure with __get_free_page. That wastes
a small amount of memory (~2500 bytes) per online adapter.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-04-24 16:47:23.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-04-24 16:47:24.000000000 +0200
@@ -1640,7 +1640,7 @@ next:
 
 	}
 	kfree(irq_ptr->qdr);
-	kfree(irq_ptr);
+	free_page((unsigned long) irq_ptr);
 }
 
 static void
@@ -2983,7 +2983,7 @@ qdio_allocate(struct qdio_initialize *in
 	qdio_allocate_do_dbf(init_data);
 
 	/* create irq */
-	irq_ptr = kzalloc(sizeof(struct qdio_irq), GFP_KERNEL | GFP_DMA);
+	irq_ptr = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 
 	QDIO_DBF_TEXT0(0,setup,"irq_ptr:");
 	QDIO_DBF_HEX0(0,setup,&irq_ptr,sizeof(void*));
@@ -2998,7 +2998,7 @@ qdio_allocate(struct qdio_initialize *in
 	/* QDR must be in DMA area since CCW data address is only 32 bit */
 	irq_ptr->qdr=kmalloc(sizeof(struct qdr), GFP_KERNEL | GFP_DMA);
   	if (!(irq_ptr->qdr)) {
-   		kfree(irq_ptr);
+   		free_page((unsigned long) irq_ptr);
     		QDIO_PRINT_ERR("kmalloc of irq_ptr->qdr failed!\n");
 		return -ENOMEM;
        	}

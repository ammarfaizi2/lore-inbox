Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTFJTkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTFJSjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:39:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38557 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264083AbTFJShj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:39 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270970425@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709703999@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1390, 2003/06/10 10:51:23-07:00, david-b@pacbell.net

[PATCH] PCI: pci pool, poison more like slab code

This adds a new poisoning mode, distinguishing memory
that's uninitialized from memory that's freed.  The
slab code has been doing this for a while now.


 drivers/pci/pool.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/pool.c b/drivers/pci/pool.c
--- a/drivers/pci/pool.c	Tue Jun 10 11:15:19 2003
+++ b/drivers/pci/pool.c	Tue Jun 10 11:15:19 2003
@@ -29,7 +29,8 @@
 };
 
 #define	POOL_TIMEOUT_JIFFIES	((100 /* msec */ * HZ) / 1000)
-#define	POOL_POISON_BYTE	0xa7
+#define	POOL_POISON_FREED	0xa7	/* !inuse */
+#define	POOL_POISON_ALLOCATED	0xa9	/* !initted */
 
 static DECLARE_MUTEX (pools_lock);
 
@@ -172,7 +173,7 @@
 	if (page->vaddr) {
 		memset (page->bitmap, 0xff, mapsize);	// bit set == free
 #ifdef	CONFIG_DEBUG_SLAB
-		memset (page->vaddr, POOL_POISON_BYTE, pool->allocation);
+		memset (page->vaddr, POOL_POISON_FREED, pool->allocation);
 #endif
 		list_add (&page->page_list, &pool->page_list);
 		page->in_use = 0;
@@ -201,7 +202,7 @@
 	dma_addr_t	dma = page->dma;
 
 #ifdef	CONFIG_DEBUG_SLAB
-	memset (page->vaddr, POOL_POISON_BYTE, pool->allocation);
+	memset (page->vaddr, POOL_POISON_FREED, pool->allocation);
 #endif
 	pci_free_consistent (pool->dev, pool->allocation, page->vaddr, dma);
 	list_del (&page->page_list);
@@ -309,6 +310,9 @@
 	page->in_use++;
 	retval = offset + page->vaddr;
 	*handle = offset + page->dma;
+#ifdef	CONFIG_DEBUG_SLAB
+	memset (retval, POOL_POISON_ALLOCATED, pool->size);
+#endif
 done:
 	spin_unlock_irqrestore (&pool->lock, flags);
 	return retval;
@@ -378,7 +382,7 @@
 			pool->name, (unsigned long long)dma);
 		return;
 	}
-	memset (vaddr, POOL_POISON_BYTE, pool->size);
+	memset (vaddr, POOL_POISON_FREED, pool->size);
 #endif
 
 	spin_lock_irqsave (&pool->lock, flags);


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265369AbUBIX6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbUBIXza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:55:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:63676 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265436AbUBIXWm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:42 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689371868@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:18 -0800
Message-Id: <10763689381685@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.6, 2004/02/02 11:29:59-08:00, greg@kroah.com

[PATCH] dmapool: use dev_err() whenever we can to get the better information in it.


 drivers/base/dmapool.c |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)


diff -Nru a/drivers/base/dmapool.c b/drivers/base/dmapool.c
--- a/drivers/base/dmapool.c	Mon Feb  9 14:59:26 2004
+++ b/drivers/base/dmapool.c	Mon Feb  9 14:59:26 2004
@@ -237,9 +237,12 @@
 		page = list_entry (pool->page_list.next,
 				struct dma_page, page_list);
 		if (is_page_busy (pool->blocks_per_page, page->bitmap)) {
-			printk (KERN_ERR "dma_pool_destroy %s/%s, %p busy\n",
-				pool->dev ? pool->dev->bus_id : NULL,
-				pool->name, page->vaddr);
+			if (pool->dev)
+				dev_err(pool->dev, "dma_pool_destroy %s, %p busy\n",
+					pool->name, page->vaddr);
+			else
+				printk (KERN_ERR "dma_pool_destroy %s, %p busy\n",
+					pool->name, page->vaddr);
 			/* leak the still-in-use consistent memory */
 			list_del (&page->page_list);
 			kfree (page);
@@ -362,9 +365,12 @@
 	int			map, block;
 
 	if ((page = pool_find_page (pool, dma)) == 0) {
-		printk (KERN_ERR "dma_pool_free %s/%s, %p/%lx (bad dma)\n",
-			pool->dev ? pool->dev->bus_id : NULL,
-			pool->name, vaddr, (unsigned long) dma);
+		if (pool->dev)
+			dev_err(pool->dev, "dma_pool_free %s, %p/%lx (bad dma)\n",
+				pool->name, vaddr, (unsigned long) dma);
+		else
+			printk (KERN_ERR "dma_pool_free %s, %p/%lx (bad dma)\n",
+				pool->name, vaddr, (unsigned long) dma);
 		return;
 	}
 
@@ -375,15 +381,21 @@
 
 #ifdef	CONFIG_DEBUG_SLAB
 	if (((dma - page->dma) + (void *)page->vaddr) != vaddr) {
-		printk (KERN_ERR "dma_pool_free %s/%s, %p (bad vaddr)/%Lx\n",
-			pool->dev ? pool->dev->bus_id : NULL,
-			pool->name, vaddr, (unsigned long long) dma);
+		if (pool->dev)
+			dev_err(pool->dev, "dma_pool_free %s, %p (bad vaddr)/%Lx\n",
+				pool->name, vaddr, (unsigned long long) dma);
+		else
+			printk (KERN_ERR "dma_pool_free %s, %p (bad vaddr)/%Lx\n",
+				pool->name, vaddr, (unsigned long long) dma);
 		return;
 	}
 	if (page->bitmap [map] & (1UL << block)) {
-		printk (KERN_ERR "dma_pool_free %s/%s, dma %Lx already free\n",
-			pool->dev ? pool->dev->bus_id : NULL,
-			pool->name, (unsigned long long)dma);
+		if (pool->dev)
+			dev_err(pool->dev, "dma_pool_free %s, dma %Lx already free\n",
+				pool->name, (unsigned long long)dma);
+		else
+			printk (KERN_ERR "dma_pool_free %s, dma %Lx already free\n",
+				pool->name, (unsigned long long)dma);
 		return;
 	}
 	memset (vaddr, POOL_POISON_FREED, pool->size);


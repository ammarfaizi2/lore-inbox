Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUBIX05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbUBIX02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:26:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:3261 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265463AbUBIXWt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:49 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689433249@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:24 -0800
Message-Id: <10763689443294@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1607, 2004/02/09 14:05:33-08:00, greg@kroah.com

dmapool: fix up list_for_each() calls to list_for_each_entry()
  
Now this should get that Rusty^Wmonkey off my back...


 drivers/base/dmapool.c |   29 +++++++++++------------------
 1 files changed, 11 insertions(+), 18 deletions(-)


diff -Nru a/drivers/base/dmapool.c b/drivers/base/dmapool.c
--- a/drivers/base/dmapool.c	Mon Feb  9 14:58:07 2004
+++ b/drivers/base/dmapool.c	Mon Feb  9 14:58:07 2004
@@ -43,9 +43,11 @@
 static ssize_t
 show_pools (struct device *dev, char *buf)
 {
-	unsigned		temp, size;
-	char			*next;
-	struct list_head	*i, *j;
+	unsigned temp;
+	unsigned size;
+	char *next;
+	struct dma_page *page;
+	struct dma_pool *pool;
 
 	next = buf;
 	size = PAGE_SIZE;
@@ -55,16 +57,11 @@
 	next += temp;
 
 	down (&pools_lock);
-	list_for_each (i, &dev->dma_pools) {
-		struct dma_pool	*pool;
-		unsigned	pages = 0, blocks = 0;
+	list_for_each_entry(pool, &dev->dma_pools, pools) {
+		unsigned pages = 0;
+		unsigned blocks = 0;
 
-		pool = list_entry (i, struct dma_pool, pools);
-
-		list_for_each (j, &pool->page_list) {
-			struct dma_page	*page;
-
-			page = list_entry (j, struct dma_page, page_list);
+		list_for_each_entry(page, &pool->page_list, page_list) {
 			pages++;
 			blocks += page->in_use;
 		}
@@ -268,7 +265,6 @@
 dma_pool_alloc (struct dma_pool *pool, int mem_flags, dma_addr_t *handle)
 {
 	unsigned long		flags;
-	struct list_head	*entry;
 	struct dma_page		*page;
 	int			map, block;
 	size_t			offset;
@@ -276,9 +272,8 @@
 
 restart:
 	spin_lock_irqsave (&pool->lock, flags);
-	list_for_each (entry, &pool->page_list) {
+	list_for_each_entry(page, &pool->page_list, page_list) {
 		int		i;
-		page = list_entry (entry, struct dma_page, page_list);
 		/* only cachable accesses here ... */
 		for (map = 0, i = 0;
 				i < pool->blocks_per_page;
@@ -330,12 +325,10 @@
 pool_find_page (struct dma_pool *pool, dma_addr_t dma)
 {
 	unsigned long		flags;
-	struct list_head	*entry;
 	struct dma_page		*page;
 
 	spin_lock_irqsave (&pool->lock, flags);
-	list_for_each (entry, &pool->page_list) {
-		page = list_entry (entry, struct dma_page, page_list);
+	list_for_each_entry(page, &pool->page_list, page_list) {
 		if (dma < page->dma)
 			continue;
 		if (dma < (page->dma + pool->allocation))


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVCHKq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVCHKq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVCHKpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:45:50 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:10731 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261967AbVCHKpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:45:15 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 11:44:37 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: video-buf update
Message-ID: <20050308104437.GA30696@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bugfix: catch pci_map_sg() failures.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/video-buf.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff -u linux-2.6.11/drivers/media/video/video-buf.c linux/drivers/media/video/video-buf.c
--- linux-2.6.11/drivers/media/video/video-buf.c	2005-03-07 10:13:55.000000000 +0100
+++ linux/drivers/media/video/video-buf.c	2005-03-07 16:38:38.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: video-buf.c,v 1.17 2004/12/10 12:33:40 kraxel Exp $
+ * $Id: video-buf.c,v 1.18 2005/02/24 13:32:30 kraxel Exp $
  *
  * generic helper functions for video4linux capture buffers, to handle
  * memory management and PCI DMA.  Right now bttv + saa7134 use it.
@@ -217,9 +217,18 @@
 		return -ENOMEM;
 	}
 
-	if (!dma->bus_addr)
+	if (!dma->bus_addr) {
 		dma->sglen = pci_map_sg(dev,dma->sglist,dma->nr_pages,
 					dma->direction);
+		if (0 == dma->sglen) {
+			printk(KERN_WARNING
+			       "%s: pci_map_sg failed\n",__FUNCTION__);
+			kfree(dma->sglist);
+			dma->sglist = NULL;
+			dma->sglen = 0;
+			return -EIO;
+		}
+	}
 	return 0;
 }
 

-- 
#define printk(args...) fprintf(stderr, ## args)

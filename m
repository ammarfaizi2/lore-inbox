Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266957AbTGKWvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267004AbTGKWvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:51:17 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:20745 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266957AbTGKWvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:51:16 -0400
Date: Sat, 12 Jul 2003 00:57:16 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] Fix error path in AD1889 driver
Message-ID: <20030712005716.C25528@electric-eye.fr.zoreil.com>
References: <200307111821.h6BILFpr017428@hraefn.swansea.linux.org.uk> <20030712004501.B25528@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030712004501.B25528@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, Jul 12, 2003 at 12:45:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Memory leak fix: the allocated areas weren't referenced any more once the
original error path returned.


 sound/oss/ad1889.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff -puN sound/oss/ad1889.c~janitor-error-path-ad1889 sound/oss/ad1889.c
--- linux-2.5.75-20030711_0808/sound/oss/ad1889.c~janitor-error-path-ad1889	Sat Jul 12 00:40:29 2003
+++ linux-2.5.75-20030711_0808-fr/sound/oss/ad1889.c	Sat Jul 12 00:40:29 2003
@@ -236,16 +236,24 @@ static ad1889_dev_t *ad1889_alloc_dev(st
 
 	for (i = 0; i < AD_MAX_STATES; i++) {
 		dmabuf = &dev->state[i].dmabuf;
-		if ((dmabuf->rawbuf = kmalloc(DMA_SIZE, GFP_KERNEL|GFP_DMA)) == NULL)
-			return NULL;
+		dmabuf->rawbuf = kmalloc(DMA_SIZE, GFP_KERNEL|GFP_DMA);
+		if (!dmabuf->rawbuf)
+			goto err_free_dmabuf;
 		dmabuf->rawbuf_size = DMA_SIZE;
 		dmabuf->dma_handle = 0;
 		dmabuf->rd_ptr = dmabuf->wr_ptr = dmabuf->dma_len = 0UL;
 		dmabuf->ready = 0;
 		dmabuf->rate = 44100;
 	}
-
+out:
 	return dev;
+
+err_free_dmabuf:
+	while (--i >= 0)
+		kfree(dev->state[i].dmabuf.rawbuf);
+	kfree(dev);
+	dev = NULL;
+	goto out;
 }
 
 static void ad1889_free_dev(ad1889_dev_t *dev)

_

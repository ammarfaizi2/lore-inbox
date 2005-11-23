Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVKWP4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVKWP4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVKWP4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:56:24 -0500
Received: from mailgate.tebibyte.org ([83.104.187.130]:23556 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S1751145AbVKWP4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:56:23 -0500
Message-ID: <43849110.2070806@tebibyte.org>
Date: Wed, 23 Nov 2005 15:56:00 +0000
From: Chris Ross <lak1646@tebibyte.org>
Organization: At home (Guildford, UK)
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg Ungerer <gerg@snapgear.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] 2.4.32 Don't panic on IDE DMA errors
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.32 and earlier can panic when trying to read a corrupted 
sector from an IDE disk.

The function ide_dma_timeout_retry can end a request early by calling 
idedisk_error, but then goes on to use the request anyway causing a 
kernel panic due to a null pointer exception. This patch fixes that.

Regards,
Chris R.


diff -urN -X dontdiff linux-2.4.32/drivers/ide/ide-io.c 
patched-linux-2.4.32/drivers/ide/ide-io.c
--- linux-2.4.32/drivers/ide/ide-io.c	2003-11-28 18:26:20.000000000 +0000
+++ patched-linux-2.4.32/drivers/ide/ide-io.c	2005-11-23 
12:33:37.000000000 +0000
@@ -899,11 +899,13 @@
  	rq = HWGROUP(drive)->rq;
  	HWGROUP(drive)->rq = NULL;

-	rq->errors = 0;
-	rq->sector = rq->bh->b_rsector;
-	rq->current_nr_sectors = rq->bh->b_size >> 9;
-	rq->hard_cur_sectors = rq->current_nr_sectors;
-	rq->buffer = rq->bh->b_data;
+	if (rq) {
+		rq->errors = 0;
+		rq->sector = rq->bh->b_rsector;
+		rq->current_nr_sectors = rq->bh->b_size >> 9;
+		rq->hard_cur_sectors = rq->current_nr_sectors;
+		rq->buffer = rq->bh->b_data;
+	}

  	return ret;
  }

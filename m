Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTI2RRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbTI2RGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:06:42 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:41399 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263800AbTI2RE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:59 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix leak in btaudio
Message-Id: <E1A41Rq-0000NM-00@hardwired>
Date: Mon, 29 Sep 2003 18:04:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/btaudio.c linux-2.5/sound/oss/btaudio.c
--- bk-linus/sound/oss/btaudio.c	2003-09-08 00:49:05.000000000 +0100
+++ linux-2.5/sound/oss/btaudio.c	2003-09-08 01:32:13.000000000 +0100
@@ -177,8 +177,11 @@ static int alloc_buffer(struct btaudio *
 		bta->risc_size = PAGE_SIZE;
 		bta->risc_cpu = pci_alloc_consistent
 			(bta->pci, bta->risc_size, &bta->risc_dma);
-		if (NULL == bta->risc_cpu)
+		if (NULL == bta->risc_cpu) {
+			pci_free_consistent(bta->pci, bta->buf_size, bta->buf_cpu, bta->dma);
+			bta->buf_cpu = NULL;
 			return -ENOMEM;
+		}
 	}
 	return 0;
 }

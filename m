Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965461AbWJ3WZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965461AbWJ3WZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965465AbWJ3WZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:25:44 -0500
Received: from mx1.cs.washington.edu ([128.208.5.52]:18155 "EHLO
	mx1.cs.washington.edu") by vger.kernel.org with ESMTP
	id S965461AbWJ3WZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:25:44 -0500
Date: Mon, 30 Oct 2006 14:19:25 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: akpm@osdl.org
cc: jgarzik@pobox.com, hch@infrared.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net s2io: return on NULL dev_alloc_skb()
In-Reply-To: <200610302117.24760.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64N.0610301415030.22754@attu2.cs.washington.edu>
References: <200610302117.24760.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Checks for NULL dev_alloc_skb() and returns on true to avoid subsequent
dereference.

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infrared.org>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 drivers/net/s2io.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index a231ab7..33569ec 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -5985,6 +5985,11 @@ static int set_rxd_buffer_pointer(nic_t 
 			((RxD3_t*)rxdp)->Buffer1_ptr = *temp1;
 		} else {
 			*skb = dev_alloc_skb(size);
+			if (!(*skb)) {
+				DBG_PRINT(ERR_DBG, "%s: dev_alloc_skb failed\n",
+					  dev->name);
+				return -ENOMEM;
+			}
 			((RxD3_t*)rxdp)->Buffer2_ptr = *temp2 =
 				pci_map_single(sp->pdev, (*skb)->data,
 					       dev->mtu + 4,
@@ -6007,7 +6012,11 @@ static int set_rxd_buffer_pointer(nic_t 
 			((RxD3_t*)rxdp)->Buffer2_ptr = *temp2;
 		} else {
 			*skb = dev_alloc_skb(size);
-
+			if (!(*skb)) {
+				DBG_PRINT(ERR_DBG, "%s: dev_alloc_skb failed\n",
+					  dev->name);
+				return -ENOMEM;
+			}
 			((RxD3_t*)rxdp)->Buffer0_ptr = *temp0 =
 				pci_map_single(sp->pdev, ba->ba_0, BUF0_LEN,
 					       PCI_DMA_FROMDEVICE);

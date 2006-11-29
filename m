Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967682AbWK2Xi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967682AbWK2Xi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967460AbWK2XiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:38:03 -0500
Received: from [198.186.3.68] ([198.186.3.68]:1960 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S967677AbWK2Xh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:37:58 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 2] IB/ipath - use memcpy_cachebypass in RDMA interrupt
	handler to reduce packet loss
X-Mercurial-Node: f9a929f40725e6b4f41fa5db5ba1a217982dc629
Message-Id: <f9a929f40725e6b4f41f.1164843309@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1164843307@eng-12.pathscale.com>
Date: Wed, 29 Nov 2006 15:35:09 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akmp@osdl.org
Cc: rdreier@cisco.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In cases where a large incoming RDMA is being received, we have to
copy data inside the interrupt handler before we can ACK each packet.
The source is DMAed to by the hardware, which means that the CPU won't
have it cached.  We only read the source this one time; using normal load
instructions pollutes the dcache with useless data, reducing performance
to the point where we can lose a significant number of packets.

We use memcpy_cachebypass to try to not fill the dcache with useless data.
Avoiding the cache refill penalty lets us keep up better with the sender,
resulting in many fewer dropped packets.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 3300b7b66f46 -r f9a929f40725 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Wed Nov 29 15:34:11 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Wed Nov 29 15:34:11 2006 -0800
@@ -167,7 +167,7 @@ void ipath_copy_sge(struct ipath_sge_sta
 		BUG_ON(len == 0);
 		if (len > length)
 			len = length;
-		memcpy(sge->vaddr, data, len);
+		memcpy_cachebypass(sge->vaddr, data, len);
 		sge->vaddr += len;
 		sge->length -= len;
 		sge->sge_length -= len;

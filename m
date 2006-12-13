Return-Path: <linux-kernel-owner+w=401wt.eu-S932589AbWLMSbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWLMSbf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWLMSbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:31:34 -0500
Received: from [198.186.3.68] ([198.186.3.68]:38743 "EHLO mx.pathscale.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932589AbWLMSbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:31:34 -0500
X-Greylist: delayed 2000 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 13:31:34 EST
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 2] IB/ipath - use memcpy_uncached_read in RDMA interrupt
	handler to reduce packet loss
X-Mercurial-Node: f25d77f769988977558100c70d4394273c3df1e7
Message-Id: <f25d77f7699889775581.1166032641@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1166032639@eng-12.pathscale.com>
Date: Wed, 13 Dec 2006 09:57:21 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In cases where a large incoming RDMA is being received, we have to
copy data inside the interrupt handler before we can ACK each packet.
The source is DMAed to by the hardware, which means that the CPU won't
have it cached.  We only read the source this one time; using normal load
instructions pollutes the dcache with useless data, reducing performance
to the point where we can lose a significant number of packets.

We use memcpy_uncached_read to try to not fill the dcache with useless data.
Avoiding the cache refill penalty lets us keep up better with the sender,
resulting in many fewer dropped packets.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r e7c3b265254b -r f25d77f76998 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Wed Dec 13 09:51:09 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Wed Dec 13 09:51:09 2006 -0800
@@ -167,7 +167,7 @@ void ipath_copy_sge(struct ipath_sge_sta
 		BUG_ON(len == 0);
 		if (len > length)
 			len = length;
-		memcpy(sge->vaddr, data, len);
+		memcpy_uncached_read(sge->vaddr, data, len);
 		sge->vaddr += len;
 		sge->length -= len;
 		sge->sge_length -= len;

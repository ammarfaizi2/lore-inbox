Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVDLOci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVDLOci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVDLLEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:04:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:31690 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262260AbVDLKdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:15 -0400
Message-Id: <200504121033.j3CAX89n005785@shell0.pdx.osdl.net>
Subject: [patch 157/198] IB: Keep MAD work completion valid
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sean.hefty@intel.com,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Sean Hefty <sean.hefty@intel.com>

Replace the *wc field in ib_mad_recv_wc from pointing to a structure on the
stack to one allocated with the received MAD buffer.  This allows a client to
access the *wc field after their receive completion handler has returned.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/core/mad.c      |    3 ++-
 25-akpm/drivers/infiniband/core/mad_priv.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/infiniband/core/mad.c~ib-keep-mad-work-completion-valid drivers/infiniband/core/mad.c
--- 25/drivers/infiniband/core/mad.c~ib-keep-mad-work-completion-valid	2005-04-12 03:21:41.108887400 -0700
+++ 25-akpm/drivers/infiniband/core/mad.c	2005-04-12 03:21:41.116886184 -0700
@@ -1600,7 +1600,8 @@ static void ib_mad_recv_done_handler(str
 			 DMA_FROM_DEVICE);
 
 	/* Setup MAD receive work completion from "normal" work completion */
-	recv->header.recv_wc.wc = wc;
+	recv->header.wc = *wc;
+	recv->header.recv_wc.wc = &recv->header.wc;
 	recv->header.recv_wc.mad_len = sizeof(struct ib_mad);
 	recv->header.recv_wc.recv_buf.mad = &recv->mad.mad;
 	recv->header.recv_wc.recv_buf.grh = &recv->grh;
diff -puN drivers/infiniband/core/mad_priv.h~ib-keep-mad-work-completion-valid drivers/infiniband/core/mad_priv.h
--- 25/drivers/infiniband/core/mad_priv.h~ib-keep-mad-work-completion-valid	2005-04-12 03:21:41.110887096 -0700
+++ 25-akpm/drivers/infiniband/core/mad_priv.h	2005-04-12 03:21:41.116886184 -0700
@@ -69,6 +69,7 @@ struct ib_mad_list_head {
 struct ib_mad_private_header {
 	struct ib_mad_list_head mad_list;
 	struct ib_mad_recv_wc recv_wc;
+	struct ib_wc wc;
 	DECLARE_PCI_UNMAP_ADDR(mapping)
 } __attribute__ ((packed));
 
_

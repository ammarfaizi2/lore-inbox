Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVDASvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVDASvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVDAS0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:26:35 -0500
Received: from webmail.topspin.com ([12.162.17.3]:34971 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262841AbVDASYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:24:54 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][1/6] IB: Keep MAD work completion valid
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 10:23:50 -0800
Message-Id: <2005411023.BIKgS4OLfFzZN9qI@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 18:23:51.0097 (UTC) FILETIME=[F41F6290:01C536E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Hefty <sean.hefty@intel.com>

Replace the *wc field in ib_mad_recv_wc from pointing to a structure
on the stack to one allocated with the received MAD buffer.  This
allows a client to access the *wc field after their receive completion
handler has returned.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/mad.c	2005-03-31 19:07:01.000000000 -0800
+++ linux-export/drivers/infiniband/core/mad.c	2005-04-01 10:08:54.939957801 -0800
@@ -1600,7 +1600,8 @@
 			 DMA_FROM_DEVICE);
 
 	/* Setup MAD receive work completion from "normal" work completion */
-	recv->header.recv_wc.wc = wc;
+	recv->header.wc = *wc;
+	recv->header.recv_wc.wc = &recv->header.wc;
 	recv->header.recv_wc.mad_len = sizeof(struct ib_mad);
 	recv->header.recv_wc.recv_buf.mad = &recv->mad.mad;
 	recv->header.recv_wc.recv_buf.grh = &recv->grh;
--- linux-export.orig/drivers/infiniband/core/mad_priv.h	2005-03-31 19:07:14.000000000 -0800
+++ linux-export/drivers/infiniband/core/mad_priv.h	2005-04-01 10:08:54.961953027 -0800
@@ -69,6 +69,7 @@
 struct ib_mad_private_header {
 	struct ib_mad_list_head mad_list;
 	struct ib_mad_recv_wc recv_wc;
+	struct ib_wc wc;
 	DECLARE_PCI_UNMAP_ADDR(mapping)
 } __attribute__ ((packed));
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVGKOTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVGKOTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVGKORA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:17:00 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:8390 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261804AbVGKOPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:15:20 -0400
Subject: [PATCH 9/27] Add ib_coalesce_recv_mad to MAD
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089106.4389.4523.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 10:07:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add implementation for ib_coalesce_recv_mad. 
Also, clear allocated MAD data buffer in ib_create_send_mad.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 8/27.

-- 
 core/mad.c       |    9 +--
 include/ib_mad.h |    3 +--
 2 files changed, 2 insertions(+), 10 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband8/core/mad.c linux-2.6.13-rc2-mm1/drivers/infiniband9/core/mad.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband8/core/mad.c	2005-07-09 16:51:21.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband9/core/mad.c	2005-07-09 17:25:36.000000000 -0400
@@ -796,9 +796,9 @@ struct ib_mad_send_buf * ib_create_send_
 	buf = kmalloc(sizeof *send_buf + buf_size, gfp_mask);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
+	memset(buf, 0, sizeof *send_buf + buf_size);
 
 	send_buf = buf + buf_size;
-	memset(send_buf, 0, sizeof *send_buf);
 	send_buf->mad = buf;
 
 	send_buf->sge.addr = dma_map_single(mad_agent->device->dma_device,
@@ -1021,13 +1021,6 @@ void ib_free_recv_mad(struct ib_mad_recv
 }
 EXPORT_SYMBOL(ib_free_recv_mad);
 
-void ib_coalesce_recv_mad(struct ib_mad_recv_wc *mad_recv_wc,
-			  void *buf)
-{
-	printk(KERN_ERR PFX "ib_coalesce_recv_mad() not implemented yet\n");
-}
-EXPORT_SYMBOL(ib_coalesce_recv_mad);
-
 struct ib_mad_agent *ib_redirect_mad_qp(struct ib_qp *qp,
 					u8 rmpp_version,
 					ib_mad_send_handler send_handler,
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband8/include/ib_mad.h linux-2.6.13-rc2-mm1/drivers/infiniband9/include/ib_mad.h
-- linux-2.6.13-rc2-mm1/drivers/infiniband8/include/ib_mad.h	2005-07-09 14:26:49.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband9/include/ib_mad.h	2005-07-09 16:59:22.000000000 -0400
@@ -365,8 +365,7 @@ int ib_post_send_mad(struct ib_mad_agent
  * This call copies a chain of received RMPP MADs into a single data buffer,
  * removing duplicated headers.
  */
-void ib_coalesce_recv_mad(struct ib_mad_recv_wc *mad_recv_wc,
-			  void *buf);
+void ib_coalesce_recv_mad(struct ib_mad_recv_wc *mad_recv_wc, void *buf);
 
 /**
  * ib_free_recv_mad - Returns data buffers used to receive a MAD to the



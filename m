Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVGKN6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVGKN6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVGKN6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:58:06 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:38597 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261697AbVGKNz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:55:58 -0400
Subject: [PATCH 3/27] Add MAD helper functions
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089079.4389.4511.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 09:48:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add new helper routines for allocating MADs for sending and formatting
a send WR.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 2/27.

-- 
 core/mad.c       |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/ib_mad.h |   60 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband2/core/mad.c linux-2.6.13-rc2-mm1/drivers/infiniband3/core/mad.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband2/core/mad.c	2005-07-09 12:58:23.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband3/core/mad.c	2005-07-09 14:31:49.000000000 -0400
@@ -763,6 +763,82 @@ out:
 	return ret;
 }
 
+static int get_buf_length(int hdr_len, int data_len)
+{
+	int seg_size, pad;
+
+	seg_size = sizeof(struct ib_mad) - hdr_len;
+	if (data_len && seg_size) {
+		pad = seg_size - data_len % seg_size;
+		if (pad == seg_size)
+			pad = 0;
+	} else
+		pad = seg_size;
+	return hdr_len + data_len + pad;
+}
+
+struct ib_mad_send_buf * ib_create_send_mad(struct ib_mad_agent *mad_agent,
+					    u32 remote_qpn, u16 pkey_index,
+					    struct ib_ah *ah,
+					    int hdr_len, int data_len,
+					    int gfp_mask)
+{
+	struct ib_mad_agent_private *mad_agent_priv;
+	struct ib_mad_send_buf *send_buf;
+	int buf_size;
+	void *buf;
+
+	mad_agent_priv = container_of(mad_agent,
+				      struct ib_mad_agent_private, agent);
+	buf_size = get_buf_length(hdr_len, data_len);
+
+	buf = kmalloc(sizeof *send_buf + buf_size, gfp_mask);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	send_buf = buf + buf_size;
+	memset(send_buf, 0, sizeof *send_buf);
+	send_buf->mad = buf;
+
+	send_buf->sge.addr = dma_map_single(mad_agent->device->dma_device,
+					    buf, buf_size, DMA_TO_DEVICE);
+	pci_unmap_addr_set(send_buf, mapping, send_buf->sge.addr);
+	send_buf->sge.length = buf_size;
+	send_buf->sge.lkey = mad_agent->mr->lkey;
+
+	send_buf->send_wr.wr_id = (unsigned long) send_buf;
+	send_buf->send_wr.sg_list = &send_buf->sge;
+	send_buf->send_wr.num_sge = 1;
+	send_buf->send_wr.opcode = IB_WR_SEND;
+	send_buf->send_wr.send_flags = IB_SEND_SIGNALED;
+	send_buf->send_wr.wr.ud.ah = ah;
+	send_buf->send_wr.wr.ud.mad_hdr = &send_buf->mad->mad_hdr;
+	send_buf->send_wr.wr.ud.remote_qpn = remote_qpn;
+	send_buf->send_wr.wr.ud.remote_qkey = IB_QP_SET_QKEY;
+	send_buf->send_wr.wr.ud.pkey_index = pkey_index;
+	send_buf->mad_agent = mad_agent;
+	atomic_inc(&mad_agent_priv->refcount);
+	return send_buf;
+}
+EXPORT_SYMBOL(ib_create_send_mad);
+
+void ib_free_send_mad(struct ib_mad_send_buf *send_buf)
+{
+	struct ib_mad_agent_private *mad_agent_priv;
+
+	mad_agent_priv = container_of(send_buf->mad_agent,
+				      struct ib_mad_agent_private, agent);
+
+	dma_unmap_single(send_buf->mad_agent->device->dma_device,
+			 pci_unmap_addr(send_buf, mapping),
+			 send_buf->sge.length, DMA_TO_DEVICE);
+	kfree(send_buf->mad);
+
+	if (atomic_dec_and_test(&mad_agent_priv->refcount))
+		wake_up(&mad_agent_priv->wait);
+}
+EXPORT_SYMBOL(ib_free_send_mad);
+
 static int ib_send_mad(struct ib_mad_agent_private *mad_agent_priv,
 		       struct ib_mad_send_wr_private *mad_send_wr)
 {
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband2/include/ib_mad.h linux-2.6.13-rc2-mm1/drivers/infiniband3/include/ib_mad.h
-- linux-2.6.13-rc2-mm1/drivers/infiniband2/include/ib_mad.h	2005-07-09 12:06:49.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband3/include/ib_mad.h	2005-07-09 14:26:49.000000000 -0400
@@ -39,6 +39,8 @@
 #if !defined( IB_MAD_H )
 #define IB_MAD_H
 
+#include <linux/pci.h>
+
 #include <ib_verbs.h>
 
 /* Management base version */
@@ -73,6 +75,7 @@
 #define IB_QP0		0
 #define IB_QP1		__constant_htonl(1)
 #define IB_QP1_QKEY	0x80010000
+#define IB_QP_SET_QKEY	0x80000000
 
 struct ib_grh {
 	u32		version_tclass_flow;
@@ -124,6 +127,30 @@ struct ib_vendor_mad {
 	u8			data[216];
 } __attribute__ ((packed));
 
+/**
+ * ib_mad_send_buf - MAD data buffer and work request for sends.
+ * @mad: References an allocated MAD data buffer.  The size of the data
+ *   buffer is specified in the @send_wr.length field.
+ * @mapping: DMA mapping information.
+ * @mad_agent: MAD agent that allocated the buffer.
+ * @context: User-controlled context fields.
+ * @send_wr: An initialized work request structure used when sending the MAD.
+ *   The wr_id field of the work request is initialized to reference this
+ *   data structure.
+ * @sge: A scatter-gather list referenced by the work request.
+ *
+ * Users are responsible for initializing the MAD buffer itself, with the
+ * exception of specifying the payload length field in any RMPP MAD.
+ */
+struct ib_mad_send_buf {
+	struct ib_mad		*mad;
+	DECLARE_PCI_UNMAP_ADDR(mapping)
+	struct ib_mad_agent	*mad_agent;
+	void			*context[2];
+	struct ib_send_wr	send_wr;
+	struct ib_sge		sge;
+};
+
 struct ib_mad_agent;
 struct ib_mad_send_wc;
 struct ib_mad_recv_wc;
@@ -402,4 +429,37 @@ struct ib_mad_agent *ib_redirect_mad_qp(
 int ib_process_mad_wc(struct ib_mad_agent *mad_agent,
 		      struct ib_wc *wc);
 
+/**
+ * ib_create_send_mad - Allocate and initialize a data buffer and work request
+ *   for sending a MAD.
+ * @mad_agent: Specifies the registered MAD service to associate with the MAD.
+ * @remote_qpn: Specifies the QPN of the receiving node.
+ * @pkey_index: Specifies which PKey the MAD will be sent using.  This field
+ *   is valid only if the remote_qpn is QP 1.
+ * @ah: References the address handle used to transfer to the remote node.
+ * @hdr_len: Indicates the size of the data header of the MAD.  This length
+ *   should include the common MAD header, RMPP header, plus any class
+ *   specific header.
+ * @data_len: Indicates the size of any user-transfered data.  The call will
+ *   automatically adjust the allocated buffer size to account for any
+ *   additional padding that may be necessary.
+ * @gfp_mask: GFP mask used for the memory allocation.
+ *
+ * This is a helper routine that may be used to allocate a MAD.  Users are
+ * not required to allocate outbound MADs using this call.  The returned
+ * MAD send buffer will reference a data buffer usable for sending a MAD, along
+ * with an intialized work request structure.
+ */
+struct ib_mad_send_buf * ib_create_send_mad(struct ib_mad_agent *mad_agent,
+					    u32 remote_qpn, u16 pkey_index,
+					    struct ib_ah *ah,
+					    int hdr_len, int data_len,
+					    int gfp_mask);
+
+/**
+ * ib_free_send_mad - Returns data buffers used to send a MAD.
+ * @send_buf: Previously allocated send data buffer.
+ */
+void ib_free_send_mad(struct ib_mad_send_buf *send_buf);
+
 #endif /* IB_MAD_H */



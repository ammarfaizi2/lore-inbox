Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbUKWRTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUKWRTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUKWRQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:16:03 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:51071 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261349AbUKWQPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:15:53 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123815.NWFV7rNrbnpqbYAH@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:15:46 -0800
Message-Id: <20041123815.Irsm0l3oz7MStqls@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][14/21] Add Mellanox HCA low-level driver (MAD)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:15:52.0396 (UTC) FILETIME=[B3F8D8C0:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAD (management datagram) code for Mellanox HCA driver.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_mad.c	2004-11-23 08:10:21.738357057 -0800
@@ -0,0 +1,321 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: mthca_mad.c 1190 2004-11-10 17:12:44Z roland $
+ */
+
+#include <ib_verbs.h>
+#include <ib_mad.h>
+
+#include "mthca_dev.h"
+#include "mthca_cmd.h"
+
+enum {
+	IB_SM_PORT_INFO        = 0x0015,
+	IB_SM_PKEY_TABLE       = 0x0016,
+	IB_SM_SM_INFO          = 0x0020,
+	IB_SM_VENDOR_START     = 0xff00
+};
+
+enum {
+	MTHCA_VENDOR_CLASS1 = 0x9,
+	MTHCA_VENDOR_CLASS2 = 0xa
+};
+
+struct mthca_trap_mad {
+	struct ib_mad *mad;
+	DECLARE_PCI_UNMAP_ADDR(mapping)
+};
+
+static void update_sm_ah(struct mthca_dev *dev,
+			 u8 port_num, u16 lid, u8 sl)
+{
+	struct ib_ah *new_ah;
+	struct ib_ah_attr ah_attr;
+	unsigned long flags;
+
+	if (!dev->send_agent[port_num - 1][0])
+		return;
+
+	memset(&ah_attr, 0, sizeof ah_attr);
+	ah_attr.dlid     = lid;
+	ah_attr.sl       = sl;
+	ah_attr.port_num = port_num;
+
+	new_ah = ib_create_ah(dev->send_agent[port_num - 1][0]->qp->pd,
+			      &ah_attr);
+	if (IS_ERR(new_ah))
+		return;
+
+	spin_lock_irqsave(&dev->sm_lock, flags);
+	if (dev->sm_ah[port_num - 1])
+		ib_destroy_ah(dev->sm_ah[port_num - 1]);
+	dev->sm_ah[port_num - 1] = new_ah;
+	spin_unlock_irqrestore(&dev->sm_lock, flags);
+}
+
+/*
+ * Snoop SM MADs for port info and P_Key table sets, so we can
+ * synthesize LID change and P_Key change events.
+ */
+static void smp_snoop(struct ib_device *ibdev,
+		      u8 port_num,
+		      struct ib_mad *mad)
+{
+	struct ib_event event;
+
+	if ((mad->mad_hdr.mgmt_class  == IB_MGMT_CLASS_SUBN_LID_ROUTED ||
+	     mad->mad_hdr.mgmt_class  == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) &&
+	    mad->mad_hdr.method     == IB_MGMT_METHOD_SET) {
+		if (mad->mad_hdr.attr_id == cpu_to_be16(IB_SM_PORT_INFO)) {
+			update_sm_ah(to_mdev(ibdev), port_num,
+				     be16_to_cpup((__be16 *) (mad->data + 58)),
+				     (*(u8 *) (mad->data + 76)) & 0xf);
+
+			event.device           = ibdev;
+			event.event            = IB_EVENT_LID_CHANGE;
+			event.element.port_num = port_num;
+			ib_dispatch_event(&event);
+		}
+
+		if (mad->mad_hdr.attr_id == cpu_to_be16(IB_SM_PKEY_TABLE)) {
+			event.device           = ibdev;
+			event.event            = IB_EVENT_PKEY_CHANGE;
+			event.element.port_num = port_num;
+			ib_dispatch_event(&event);
+		}
+	}
+}
+
+static void forward_trap(struct mthca_dev *dev,
+			 u8 port_num,
+			 struct ib_mad *mad)
+{
+	int qpn = mad->mad_hdr.mgmt_class != IB_MGMT_CLASS_SUBN_LID_ROUTED;
+	struct mthca_trap_mad *tmad;
+	struct ib_sge      gather_list;
+	struct ib_send_wr *bad_wr, wr = {
+		.opcode      = IB_WR_SEND,
+		.sg_list     = &gather_list,
+		.num_sge     = 1,
+		.send_flags  = IB_SEND_SIGNALED,
+		.wr	     = {
+			 .ud = {
+				 .remote_qpn  = qpn,
+				 .remote_qkey = qpn ? IB_QP1_QKEY : 0,
+				 .timeout_ms  = 0
+			 }
+		 }
+	};
+	struct ib_mad_agent *agent = dev->send_agent[port_num - 1][qpn];
+	int ret;
+	unsigned long flags;
+
+	if (agent) {
+		tmad = kmalloc(sizeof *tmad, GFP_KERNEL);
+		if (!tmad)
+			return;
+
+		tmad->mad = kmalloc(sizeof *tmad->mad, GFP_KERNEL);
+		if (!tmad->mad) {
+			kfree(tmad);
+			return;
+		}
+
+		memcpy(tmad->mad, mad, sizeof *mad);
+
+		wr.wr.ud.mad_hdr = &tmad->mad->mad_hdr;
+		wr.wr_id         = (unsigned long) tmad;
+
+		gather_list.addr   = dma_map_single(agent->device->dma_device,
+						    tmad->mad,
+						    sizeof *tmad->mad,
+						    DMA_TO_DEVICE);
+		gather_list.length = sizeof *tmad->mad;
+		gather_list.lkey   = to_mpd(agent->qp->pd)->ntmr.ibmr.lkey;
+		pci_unmap_addr_set(tmad, mapping, gather_list.addr);
+		
+		/*
+		 * We rely here on the fact that MLX QPs don't use the
+		 * address handle after the send is posted (this is
+		 * wrong following the IB spec strictly, but we know
+		 * it's OK for our devices).
+		 */
+		spin_lock_irqsave(&dev->sm_lock, flags);
+		wr.wr.ud.ah      = dev->sm_ah[port_num - 1];
+		if (wr.wr.ud.ah)
+			ret = ib_post_send_mad(agent, &wr, &bad_wr);
+		else
+			ret = -EINVAL;
+		spin_unlock_irqrestore(&dev->sm_lock, flags);
+
+		if (ret) {
+			dma_unmap_single(agent->device->dma_device,
+					 pci_unmap_addr(tmad, mapping),
+					 sizeof *tmad->mad,
+					 DMA_TO_DEVICE);
+			kfree(tmad->mad);
+			kfree(tmad);
+		}
+	}
+}
+
+int mthca_process_mad(struct ib_device *ibdev,
+		      int mad_flags,
+		      u8 port_num,
+		      u16 slid,
+		      struct ib_mad *in_mad,
+		      struct ib_mad *out_mad)
+{
+	int err;
+	u8 status;
+
+	/* Forward locally generated traps to the SM */
+	if (in_mad->mad_hdr.method == IB_MGMT_METHOD_TRAP &&
+	    slid == 0) {
+		forward_trap(to_mdev(ibdev), port_num, in_mad);
+		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
+	}
+
+	/*
+	 * Only handle SM gets, sets and trap represses for SM class
+	 *
+	 * Only handle PMA and Mellanox vendor-specific class gets and
+	 * sets for other classes.
+	 */
+	if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_LID_ROUTED || 
+	    in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) {
+		if (in_mad->mad_hdr.method   != IB_MGMT_METHOD_GET &&
+		    in_mad->mad_hdr.method   != IB_MGMT_METHOD_SET &&
+		    in_mad->mad_hdr.method   != IB_MGMT_METHOD_TRAP_REPRESS)
+			return IB_MAD_RESULT_SUCCESS;
+
+		/* 
+		 * Don't process SMInfo queries or vendor-specific
+		 * MADs -- the SMA can't handle them.
+		 */
+		if (be16_to_cpu(in_mad->mad_hdr.attr_id) == IB_SM_SM_INFO ||
+		    be16_to_cpu(in_mad->mad_hdr.attr_id) >= IB_SM_VENDOR_START)
+			return IB_MAD_RESULT_SUCCESS;
+	} else if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT ||
+		   in_mad->mad_hdr.mgmt_class == MTHCA_VENDOR_CLASS1     || 
+		   in_mad->mad_hdr.mgmt_class == MTHCA_VENDOR_CLASS2) {
+		if (in_mad->mad_hdr.method  != IB_MGMT_METHOD_GET &&
+		    in_mad->mad_hdr.method  != IB_MGMT_METHOD_SET)
+			return IB_MAD_RESULT_SUCCESS;
+	} else
+		return IB_MAD_RESULT_SUCCESS;
+
+	err = mthca_MAD_IFC(to_mdev(ibdev),
+			    !!(mad_flags & IB_MAD_IGNORE_MKEY),
+			    port_num, in_mad, out_mad,
+			    &status);
+	if (err) {
+		mthca_err(to_mdev(ibdev), "MAD_IFC failed\n");
+		return IB_MAD_RESULT_FAILURE;
+	}
+	if (status == MTHCA_CMD_STAT_BAD_PKT)
+		return IB_MAD_RESULT_SUCCESS;
+	if (status) {
+		mthca_err(to_mdev(ibdev), "MAD_IFC returned status %02x\n",
+			  status);
+		return IB_MAD_RESULT_FAILURE;
+	}
+
+	if (!out_mad->mad_hdr.status)
+		smp_snoop(ibdev, port_num, in_mad);
+
+	/* set return bit in status of directed route responses */
+	if (in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)
+		out_mad->mad_hdr.status |= cpu_to_be16(1 << 15);
+
+	if (in_mad->mad_hdr.method == IB_MGMT_METHOD_TRAP_REPRESS)
+		/* no response for trap repress */
+		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
+
+	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+}
+
+static void send_handler(struct ib_mad_agent *agent,
+			 struct ib_mad_send_wc *mad_send_wc)
+{
+	struct mthca_trap_mad *tmad =
+		(void *) (unsigned long) mad_send_wc->wr_id;
+
+	dma_unmap_single(agent->device->dma_device,
+			 pci_unmap_addr(tmad, mapping),
+			 sizeof *tmad->mad,
+			 DMA_TO_DEVICE);
+	kfree(tmad->mad);
+	kfree(tmad);
+}
+
+int mthca_create_agents(struct mthca_dev *dev)
+{
+	struct ib_mad_agent *agent;
+	int p, q;
+
+	spin_lock_init(&dev->sm_lock);
+
+	for (p = 0; p < dev->limits.num_ports; ++p)
+		for (q = 0; q <= 1; ++q) {
+			agent = ib_register_mad_agent(&dev->ib_dev, p + 1,
+						      q ? IB_QPT_GSI : IB_QPT_SMI,
+						      NULL, 0, send_handler,
+						      NULL, NULL);
+			if (IS_ERR(agent))
+				goto err;
+			dev->send_agent[p][q] = agent;
+		}
+
+	return 0;
+
+err:
+	for (p = 0; p < dev->limits.num_ports; ++p)
+		for (q = 0; q <= 1; ++q)
+			if (dev->send_agent[p][q])
+				ib_unregister_mad_agent(dev->send_agent[p][q]);
+
+	return PTR_ERR(agent);
+}
+
+void mthca_free_agents(struct mthca_dev *dev)
+{
+	struct ib_mad_agent *agent;
+	int p, q;
+
+	for (p = 0; p < dev->limits.num_ports; ++p) {
+		for (q = 0; q <= 1; ++q) {
+			agent = dev->send_agent[p][q];
+			dev->send_agent[p][q] = NULL;
+			ib_unregister_mad_agent(agent);
+		}
+
+		if (dev->sm_ah[p])
+			ib_destroy_ah(dev->sm_ah[p]);
+	}
+}
+
+/*
+ * Local Variables:
+ * c-file-style: "linux"
+ * indent-tabs-mode: t
+ * End:
+ */


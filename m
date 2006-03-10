Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752111AbWCJAlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbWCJAlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWCJAgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:36:13 -0500
Received: from mx.pathscale.com ([64.160.42.68]:16782 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752159AbWCJAfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:51 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 16 of 20] ipath - misc infiniband code, part 2
X-Mercurial-Node: f57c24166c5766f8faf73067a6cd9360ca0594b4
Message-Id: <f57c24166c5766f8faf7.1141950946@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:46 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Management datagram support, queue pairs, and reliable and unreliable
connections.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 44cd07539d66 -r f57c24166c57 drivers/infiniband/hw/ipath/ipath_mad.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Mar  9 16:16:51 2006 -0800
@@ -0,0 +1,1295 @@
+/*
+ * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <rdma/ib_smi.h>
+
+#include "ipath_kernel.h"
+#include "ipath_verbs.h"
+#include "ips_common.h"
+
+#define IB_SMP_UNSUP_VERSION	__constant_htons(0x0004)
+#define IB_SMP_UNSUP_METHOD	__constant_htons(0x0008)
+#define IB_SMP_UNSUP_METH_ATTR	__constant_htons(0x000C)
+#define IB_SMP_INVALID_FIELD	__constant_htons(0x001C)
+
+static int reply(struct ib_smp *smp)
+{
+	/*
+	 * The verbs framework will handle the directed/LID route
+	 * packet changes.
+	 */
+	smp->method = IB_MGMT_METHOD_GET_RESP;
+	if (smp->mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)
+		smp->status |= IB_SMP_DIRECTION;
+	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+}
+
+static inline int recv_subn_get_nodedescription(struct ib_smp *smp,
+						struct ib_device *ibdev)
+{
+	if (smp->attr_mod)
+		smp->status |= IB_SMP_INVALID_FIELD;
+
+	strncpy(smp->data, ibdev->node_desc, sizeof(smp->data));
+
+	return reply(smp);
+}
+
+struct nodeinfo {
+	u8 base_version;
+	u8 class_version;
+	u8 node_type;
+	u8 num_ports;
+	__be64 sys_guid;
+	__be64 node_guid;
+	__be64 port_guid;
+	__be16 partition_cap;
+	__be16 device_id;
+	__be32 revision;
+	u8 local_port_num;
+	u8 vendor_id[3];
+} __attribute__ ((packed));
+
+static inline int recv_subn_get_nodeinfo(struct ib_smp *smp,
+					 struct ib_device *ibdev, u8 port)
+{
+	struct nodeinfo *nip = (struct nodeinfo *)&smp->data;
+	struct ipath_devdata *dd = to_idev(ibdev)->dd;
+	u32 vendor, boardid, majrev, minrev;
+
+	if (smp->attr_mod)
+		smp->status |= IB_SMP_INVALID_FIELD;
+
+	nip->base_version = 1;
+	nip->class_version = 1;
+	nip->node_type = 1;	/* channel adapter */
+	/*
+	 * XXX The num_ports value will need a layer function to get
+	 * the value if we ever have more than one IB port on a chip.
+	 * We will also need to get the GUID for the port.
+	 */
+	nip->num_ports = ibdev->phys_port_cnt;
+	/* This is already in network order */
+	nip->sys_guid = to_idev(ibdev)->sys_image_guid;
+	nip->node_guid = ipath_layer_get_guid(dd);
+	nip->port_guid = nip->sys_guid;
+	nip->partition_cap = cpu_to_be16(ipath_layer_get_npkeys(dd));
+	nip->device_id = cpu_to_be16(ipath_layer_get_deviceid(dd));
+	ipath_layer_query_device(dd, &vendor, &boardid, &majrev, &minrev);
+	nip->revision = cpu_to_be32((majrev << 16) | minrev);
+	nip->local_port_num = port;
+	nip->vendor_id[0] = 0;
+	nip->vendor_id[1] = vendor >> 8;
+	nip->vendor_id[2] = vendor;
+
+	return reply(smp);
+}
+
+static int recv_subn_get_guidinfo(struct ib_smp *smp,
+				  struct ib_device *ibdev)
+{
+	u32 startgx = 8 * be32_to_cpu(smp->attr_mod);
+	u64 *p = (u64 *) smp->data;
+
+	/* 32 blocks of 8 64-bit GUIDs per block */
+
+	memset(smp->data, 0, sizeof(smp->data));
+
+	/*
+	 * We only support one GUID for now.  If this changes, the
+	 * portinfo.guid_cap field needs to be updated too.
+	 */
+	if (startgx == 0)
+		/* The first is a copy of the read-only HW GUID. */
+		*p = ipath_layer_get_guid(to_idev(ibdev)->dd);
+	else
+		smp->status |= IB_SMP_INVALID_FIELD;
+
+	return reply(smp);
+}
+
+struct port_info {
+	__be64 mkey;
+	__be64 gid_prefix;
+	__be16 lid;
+	__be16 sm_lid;
+	__be32 cap_mask;
+	__be16 diag_code;
+	__be16 mkey_lease_period;
+	u8 local_port_num;
+	u8 link_width_enabled;
+	u8 link_width_supported;
+	u8 link_width_active;
+	u8 linkspeed_portstate;			/* 4 bits, 4 bits */
+	u8 portphysstate_linkdown;		/* 4 bits, 4 bits */
+	u8 mkeyprot_resv_lmc;			/* 2 bits, 3, 3 */
+	u8 linkspeedactive_enabled;		/* 4 bits, 4 bits */
+	u8 neighbormtu_mastersmsl;		/* 4 bits, 4 bits */
+	u8 vlcap_inittype;			/* 4 bits, 4 bits */
+	u8 vl_high_limit;
+	u8 vl_arb_high_cap;
+	u8 vl_arb_low_cap;
+	u8 inittypereply_mtucap;		/* 4 bits, 4 bits */
+	u8 vlstallcnt_hoqlife;			/* 3 bits, 5 bits */
+	u8 operationalvl_pei_peo_fpi_fpo;	/* 4 bits, 1, 1, 1, 1 */
+	__be16 mkey_violations;
+	__be16 pkey_violations;
+	__be16 qkey_violations;
+	u8 guid_cap;
+	u8 clientrereg_resv_subnetto;		/* 1 bit, 2 bits, 5 */
+	u8 resv_resptimevalue;			/* 3 bits, 5 bits */
+	u8 localphyerrors_overrunerrors;	/* 4 bits, 4 bits */
+	__be16 max_credit_hint;
+	u8 resv;
+	u8 link_roundtrip_latency[3];
+} __attribute__ ((packed));
+
+static int recv_subn_get_portinfo(struct ib_smp *smp,
+				  struct ib_device *ibdev, u8 port)
+{
+	struct ipath_ibdev *dev;
+	struct port_info *pip = (struct port_info *)smp->data;
+	u16 lid;
+	u8 ibcstat;
+	u8 mtu;
+
+	if (be32_to_cpu(smp->attr_mod) > ibdev->phys_port_cnt) {
+		smp->status |= IB_SMP_INVALID_FIELD;
+		return reply(smp);
+	}
+
+	dev = to_idev(ibdev);
+
+	/* Clear all fields.  Only set the non-zero fields. */
+	memset(smp->data, 0, sizeof(smp->data));
+
+	/* Only return the mkey if the protection field allows it. */
+	if (smp->method == IB_MGMT_METHOD_SET || dev->mkey == smp->mkey ||
+	    (dev->mkeyprot_resv_lmc >> 6) == 0)
+		pip->mkey = dev->mkey;
+	pip->gid_prefix = dev->gid_prefix;
+	lid = ipath_layer_get_lid(dev->dd);
+	pip->lid = lid ? cpu_to_be16(lid) : IB_LID_PERMISSIVE;
+	pip->sm_lid = cpu_to_be16(dev->sm_lid);
+	pip->cap_mask = cpu_to_be32(dev->port_cap_flags);
+	/* pip->diag_code; */
+	pip->mkey_lease_period = cpu_to_be16(dev->mkey_lease_period);
+	pip->local_port_num = port;
+	pip->link_width_enabled = dev->link_width_enabled;
+	pip->link_width_supported = 3;	/* 1x or 4x */
+	pip->link_width_active = 2;	/* 4x */
+	pip->linkspeed_portstate = 0x10;	/* 2.5Gbps */
+	ibcstat = ipath_layer_get_lastibcstat(dev->dd);
+	pip->linkspeed_portstate |= ((ibcstat >> 4) & 0x3) + 1;
+	pip->portphysstate_linkdown =
+		(ipath_cvt_physportstate[ibcstat & 0xf] << 4) |
+		(ipath_layer_get_linkdowndefaultstate(dev->dd) ? 1 : 2);
+	pip->mkeyprot_resv_lmc = dev->mkeyprot_resv_lmc;
+	pip->linkspeedactive_enabled = 0x11;	/* 2.5Gbps, 2.5Gbps */
+	switch (ipath_layer_get_ibmtu(dev->dd)) {
+	case 4096:
+		mtu = IB_MTU_4096;
+		break;
+	case 2048:
+		mtu = IB_MTU_2048;
+		break;
+	case 1024:
+		mtu = IB_MTU_1024;
+		break;
+	case 512:
+		mtu = IB_MTU_512;
+		break;
+	case 256:
+		mtu = IB_MTU_256;
+		break;
+	default:		/* oops, something is wrong */
+		mtu = IB_MTU_2048;
+		break;
+	}
+	pip->neighbormtu_mastersmsl = (mtu << 4) | dev->sm_sl;
+	pip->vlcap_inittype = 0x10;	/* VLCap = VL0, InitType = 0 */
+	/* pip->vl_high_limit; // only one VL */
+	/* pip->vl_arb_high_cap; // only one VL */
+	/* pip->vl_arb_low_cap; // only one VL */
+	/* InitTypeReply = 0 */
+	pip->inittypereply_mtucap = IB_MTU_4096;
+	// HCAs ignore VLStallCount and HOQLife
+	/* pip->vlstallcnt_hoqlife; */
+	pip->operationalvl_pei_peo_fpi_fpo = 0x10;	/* OVLs = 1 */
+	pip->mkey_violations = cpu_to_be16(dev->mkey_violations);
+	/* P_KeyViolations are counted by hardware. */
+	pip->pkey_violations =
+		cpu_to_be16((ipath_layer_get_cr_errpkey(dev->dd) -
+			     dev->n_pkey_violations) & 0xFFFF);
+	pip->qkey_violations = cpu_to_be16(dev->qkey_violations);
+	/* Only the hardware GUID is supported for now */
+	pip->guid_cap = 1;
+	pip->clientrereg_resv_subnetto = dev->subnet_timeout;
+	/* 32.768 usec. response time (guessing) */
+	pip->resv_resptimevalue = 3;
+	pip->localphyerrors_overrunerrors =
+		(ipath_layer_get_phyerrthreshold(dev->dd) << 4) |
+		ipath_layer_get_overrunthreshold(dev->dd);
+	/* pip->max_credit_hint; */
+	/* pip->link_roundtrip_latency[3]; */
+
+	return reply(smp);
+}
+
+static int recv_subn_get_pkeytable(struct ib_smp *smp,
+				   struct ib_device *ibdev)
+{
+	u32 startpx = 32 * (be32_to_cpu(smp->attr_mod) & 0xffff);
+	u16 *p = (u16 *) smp->data;
+
+	/* 64 blocks of 32 16-bit P_Key entries */
+
+	memset(smp->data, 0, sizeof(smp->data));
+	if (startpx == 0) {
+		struct ipath_ibdev *dev = to_idev(ibdev);
+		unsigned i, n = ipath_layer_get_npkeys(dev->dd);
+
+		ipath_layer_get_pkeys(dev->dd, p);
+
+		for (i = 0; i < n; i++)
+			p[i] = cpu_to_be16(p[i]);
+	} else
+		smp->status |= IB_SMP_INVALID_FIELD;
+
+	return reply(smp);
+}
+
+static inline int recv_subn_set_guidinfo(struct ib_smp *smp,
+					 struct ib_device *ibdev)
+{
+	/* The only GUID we support is the first read-only entry. */
+	return recv_subn_get_guidinfo(smp, ibdev);
+}
+
+/**
+ * recv_subn_set_portinfo - set port information
+ * @smp: the incoming SM packet
+ * @ibdev: the infiniband device
+ * @port: the port on the device
+ *
+ * Set Portinfo (see ch. 14.2.5.6).
+ */
+static inline int recv_subn_set_portinfo(struct ib_smp *smp,
+					 struct ib_device *ibdev, u8 port)
+{
+	struct port_info *pip = (struct port_info *)smp->data;
+	struct ib_event event;
+	struct ipath_ibdev *dev;
+	u32 flags;
+	char clientrereg = 0;
+	u16 lid, smlid;
+	u8 lwe;
+	u8 lse;
+	u8 state;
+	u16 lstate;
+	u32 mtu;
+	int ret;
+
+	if (be32_to_cpu(smp->attr_mod) > ibdev->phys_port_cnt)
+		goto err;
+
+	dev = to_idev(ibdev);
+	event.device = ibdev;
+	event.element.port_num = port;
+
+	dev->mkey = pip->mkey;
+	dev->gid_prefix = pip->gid_prefix;
+	dev->mkey_lease_period = be16_to_cpu(pip->mkey_lease_period);
+
+	lid = be16_to_cpu(pip->lid);
+	if (lid != ipath_layer_get_lid(dev->dd)) {
+		/* Must be a valid unicast LID address. */
+		if (lid == 0 || lid >= IPS_MULTICAST_LID_BASE)
+			goto err;
+		ipath_set_sps_lid(dev->dd, lid, pip->mkeyprot_resv_lmc & 7);
+		event.event = IB_EVENT_LID_CHANGE;
+		ib_dispatch_event(&event);
+	}
+
+	smlid = be16_to_cpu(pip->sm_lid);
+	if (smlid != dev->sm_lid) {
+		/* Must be a valid unicast LID address. */
+		if (smlid == 0 || smlid >= IPS_MULTICAST_LID_BASE)
+			goto err;
+		dev->sm_lid = smlid;
+		event.event = IB_EVENT_SM_CHANGE;
+		ib_dispatch_event(&event);
+	}
+
+	/* Only 4x supported but allow 1x or 4x to be set (see 14.2.6.6). */
+	lwe = pip->link_width_enabled;
+	if ((lwe >= 4 && lwe <= 8) || (lwe >= 0xC && lwe <= 0xFE))
+		goto err;
+	if (lwe == 0xFF)
+		dev->link_width_enabled = 3;	/* 1x or 4x */
+	else if (lwe)
+		dev->link_width_enabled = lwe;
+
+	/* Only 2.5 Gbs supported. */
+	lse = pip->linkspeedactive_enabled & 0xF;
+	if (lse >= 2 && lse <= 0xE)
+		goto err;
+
+	/* Set link down default state. */
+	switch (pip->portphysstate_linkdown & 0xF) {
+	case 0: /* NOP */
+		break;
+	case 1: /* SLEEP */
+		if (ipath_layer_set_linkdowndefaultstate(dev->dd, 1))
+			goto err;
+		break;
+	case 2: /* POLL */
+		if (ipath_layer_set_linkdowndefaultstate(dev->dd, 0))
+			goto err;
+		break;
+	default:
+		goto err;
+	}
+
+	dev->mkeyprot_resv_lmc = pip->mkeyprot_resv_lmc;
+
+	switch ((pip->neighbormtu_mastersmsl >> 4) & 0xF) {
+	case IB_MTU_256:
+		mtu = 256;
+		break;
+	case IB_MTU_512:
+		mtu = 512;
+		break;
+	case IB_MTU_1024:
+		mtu = 1024;
+		break;
+	case IB_MTU_2048:
+		mtu = 2048;
+		break;
+	case IB_MTU_4096:
+		mtu = 4096;
+		break;
+	default:
+		/* XXX We have already partially updated our state! */
+		goto err;
+	}
+	ipath_layer_set_mtu(dev->dd, mtu);
+
+	dev->sm_sl = pip->neighbormtu_mastersmsl & 0xF;
+
+	/* We only support VL0 */
+	if (((pip->operationalvl_pei_peo_fpi_fpo >> 4) & 0xF) > 1)
+		goto err;
+
+	if (pip->mkey_violations == 0)
+		dev->mkey_violations = 0;
+
+	/*
+	 * Hardware counter can't be reset so snapshot and subtract
+	 * later.
+	 */
+	if (pip->pkey_violations == 0)
+		dev->n_pkey_violations =
+			ipath_layer_get_cr_errpkey(dev->dd);
+
+	if (pip->qkey_violations == 0)
+		dev->qkey_violations = 0;
+
+	if (ipath_layer_set_phyerrthreshold(
+		    dev->dd,
+		    (pip->localphyerrors_overrunerrors >> 4) & 0xF))
+		goto err;
+
+	if (ipath_layer_set_overrunthreshold(
+		    dev->dd,
+		    (pip->localphyerrors_overrunerrors & 0xF)))
+		goto err;
+
+	dev->subnet_timeout = pip->clientrereg_resv_subnetto & 0x1F;
+
+	if (pip->clientrereg_resv_subnetto & 0x80) {
+		clientrereg = 1;
+		event.event = IB_EVENT_LID_CHANGE;
+		ib_dispatch_event(&event);
+	}
+
+	/*
+	 * Do the port state change now that the other link parameters
+	 * have been set.
+	 * Changing the port physical state only makes sense if the link
+	 * is down or is being set to down.
+	 */
+	state = pip->linkspeed_portstate & 0xF;
+	flags = ipath_layer_get_flags(dev->dd);
+	lstate = (pip->portphysstate_linkdown >> 4) & 0xF;
+	if (lstate && !(state == IB_PORT_DOWN || state == IB_PORT_NOP))
+		goto err;
+
+	/*
+	 * Only state changes of DOWN, ARM, and ACTIVE are valid
+	 * and must be in the correct state to take effect (see 7.2.6).
+	 */
+	switch (state) {
+	case IB_PORT_NOP:
+		if (lstate == 0)
+			break;
+		/* FALLTHROUGH */
+	case IB_PORT_DOWN:
+		if (lstate == 0)
+			if (ipath_layer_get_linkdowndefaultstate(dev->dd))
+				lstate = IPATH_IB_LINKDOWN_SLEEP;
+			else
+				lstate = IPATH_IB_LINKDOWN;
+		else if (lstate == 1)
+			lstate = IPATH_IB_LINKDOWN_SLEEP;
+		else if (lstate == 2)
+			lstate = IPATH_IB_LINKDOWN;
+		else if (lstate == 3)
+			lstate = IPATH_IB_LINKDOWN_DISABLE;
+		else
+			goto err;
+		ipath_layer_set_linkstate(dev->dd, lstate);
+		if (flags & IPATH_LINKACTIVE) {
+			event.event = IB_EVENT_PORT_ERR;
+			ib_dispatch_event(&event);
+		}
+		break;
+	case IB_PORT_ARMED:
+		if (!(flags & (IPATH_LINKINIT | IPATH_LINKACTIVE)))
+			break;
+		ipath_layer_set_linkstate(dev->dd, IPATH_IB_LINKARM);
+		if (flags & IPATH_LINKACTIVE) {
+			event.event = IB_EVENT_PORT_ERR;
+			ib_dispatch_event(&event);
+		}
+		break;
+	case IB_PORT_ACTIVE:
+		if (!(flags & IPATH_LINKARMED))
+			break;
+		ipath_layer_set_linkstate(dev->dd, IPATH_IB_LINKACTIVE);
+		event.event = IB_EVENT_PORT_ACTIVE;
+		ib_dispatch_event(&event);
+		break;
+	default:
+		/* XXX We have already partially updated our state! */
+		goto err;
+	}
+
+	ret = recv_subn_get_portinfo(smp, ibdev, port);
+
+	if (clientrereg)
+		pip->clientrereg_resv_subnetto |= 0x80;
+
+	return ret;
+
+err:
+	smp->status |= IB_SMP_INVALID_FIELD;
+	return recv_subn_get_portinfo(smp, ibdev, port);
+}
+
+static inline int recv_subn_set_pkeytable(struct ib_smp *smp,
+					  struct ib_device *ibdev)
+{
+	u32 startpx = 32 * (be32_to_cpu(smp->attr_mod) & 0xffff);
+	u16 *p = (u16 *) smp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	unsigned i, n = ipath_layer_get_npkeys(dev->dd);
+
+	for (i = 0; i < n; i++)
+		p[i] = be16_to_cpu(p[i]);
+
+	if (startpx != 0 ||
+	    ipath_layer_set_pkeys(dev->dd, p) != 0)
+		smp->status |= IB_SMP_INVALID_FIELD;
+
+	return recv_subn_get_pkeytable(smp, ibdev);
+}
+
+#define IB_PMA_CLASS_PORT_INFO		__constant_htons(0x0001)
+#define IB_PMA_PORT_SAMPLES_CONTROL	__constant_htons(0x0010)
+#define IB_PMA_PORT_SAMPLES_RESULT	__constant_htons(0x0011)
+#define IB_PMA_PORT_COUNTERS		__constant_htons(0x0012)
+#define IB_PMA_PORT_COUNTERS_EXT	__constant_htons(0x001D)
+#define IB_PMA_PORT_SAMPLES_RESULT_EXT	__constant_htons(0x001E)
+
+struct ib_perf {
+	u8 base_version;
+	u8 mgmt_class;
+	u8 class_version;
+	u8 method;
+	__be16 status;
+	__be16 unused;
+	__be64 tid;
+	__be16 attr_id;
+	__be16 resv;
+	__be32 attr_mod;
+	u8 reserved[40];
+	u8 data[192];
+} __attribute__ ((packed));
+
+struct ib_pma_classportinfo {
+	u8 base_version;
+	u8 class_version;
+	__be16 cap_mask;
+	u8 reserved[3];
+	u8 resp_time_value;	/* only lower 5 bits */
+	union ib_gid redirect_gid;
+	__be32 redirect_tc_sl_fl;	/* 8, 4, 20 bits respectively */
+	__be16 redirect_lid;
+	__be16 redirect_pkey;
+	__be32 redirect_qp;	/* only lower 24 bits */
+	__be32 redirect_qkey;
+	union ib_gid trap_gid;
+	__be32 trap_tc_sl_fl;	/* 8, 4, 20 bits respectively */
+	__be16 trap_lid;
+	__be16 trap_pkey;
+	__be32 trap_hl_qp;	/* 8, 24 bits respectively */
+	__be32 trap_qkey;
+} __attribute__ ((packed));
+
+struct ib_pma_portsamplescontrol {
+	u8 opcode;
+	u8 port_select;
+	u8 tick;
+	u8 counter_width;	/* only lower 3 bits */
+	__be32 counter_mask0_9;	/* 2, 10 * 3, bits */
+	__be16 counter_mask10_14;	/* 1, 5 * 3, bits */
+	u8 sample_mechanisms;
+	u8 sample_status;	/* only lower 2 bits */
+	__be64 option_mask;
+	__be64 vendor_mask;
+	__be32 sample_start;
+	__be32 sample_interval;
+	__be16 tag;
+	__be16 counter_select[15];
+} __attribute__ ((packed));
+
+struct ib_pma_portsamplesresult {
+	__be16 tag;
+	__be16 sample_status;	/* only lower 2 bits */
+	__be32 counter[15];
+} __attribute__ ((packed));
+
+struct ib_pma_portsamplesresult_ext {
+	__be16 tag;
+	__be16 sample_status;	/* only lower 2 bits */
+	__be32 extended_width;	/* only upper 2 bits */
+	__be64 counter[15];
+} __attribute__ ((packed));
+
+struct ib_pma_portcounters {
+	u8 reserved;
+	u8 port_select;
+	__be16 counter_select;
+	__be16 symbol_error_counter;
+	u8 link_error_recovery_counter;
+	u8 link_downed_counter;
+	__be16 port_rcv_errors;
+	__be16 port_rcv_remphys_errors;
+	__be16 port_rcv_switch_relay_errors;
+	__be16 port_xmit_discards;
+	u8 port_xmit_constraint_errors;
+	u8 port_rcv_constraint_errors;
+	u8 reserved1;
+	u8 lli_ebor_errors;	/* 4, 4, bits */
+	__be16 reserved2;
+	__be16 vl15_dropped;
+	__be32 port_xmit_data;
+	__be32 port_rcv_data;
+	__be32 port_xmit_packets;
+	__be32 port_rcv_packets;
+} __attribute__ ((packed));
+
+#define IB_PMA_SEL_SYMBOL_ERROR			__constant_htons(0x0001)
+#define IB_PMA_SEL_LINK_ERROR_RECOVERY		__constant_htons(0x0002)
+#define IB_PMA_SEL_LINK_DOWNED			__constant_htons(0x0004)
+#define IB_PMA_SEL_PORT_RCV_ERRORS		__constant_htons(0x0008)
+#define IB_PMA_SEL_PORT_RCV_REMPHYS_ERRORS	__constant_htons(0x0010)
+#define IB_PMA_SEL_PORT_XMIT_DISCARDS		__constant_htons(0x0040)
+#define IB_PMA_SEL_PORT_XMIT_DATA		__constant_htons(0x1000)
+#define IB_PMA_SEL_PORT_RCV_DATA		__constant_htons(0x2000)
+#define IB_PMA_SEL_PORT_XMIT_PACKETS		__constant_htons(0x4000)
+#define IB_PMA_SEL_PORT_RCV_PACKETS		__constant_htons(0x8000)
+
+struct ib_pma_portcounters_ext {
+	u8 reserved;
+	u8 port_select;
+	__be16 counter_select;
+	__be32 reserved1;
+	__be64 port_xmit_data;
+	__be64 port_rcv_data;
+	__be64 port_xmit_packets;
+	__be64 port_rcv_packets;
+	__be64 port_unicast_xmit_packets;
+	__be64 port_unicast_rcv_packets;
+	__be64 port_multicast_xmit_packets;
+	__be64 port_multicast_rcv_packets;
+} __attribute__ ((packed));
+
+#define IB_PMA_SELX_PORT_XMIT_DATA		__constant_htons(0x0001)
+#define IB_PMA_SELX_PORT_RCV_DATA		__constant_htons(0x0002)
+#define IB_PMA_SELX_PORT_XMIT_PACKETS		__constant_htons(0x0004)
+#define IB_PMA_SELX_PORT_RCV_PACKETS		__constant_htons(0x0008)
+#define IB_PMA_SELX_PORT_UNI_XMIT_PACKETS	__constant_htons(0x0010)
+#define IB_PMA_SELX_PORT_UNI_RCV_PACKETS	__constant_htons(0x0020)
+#define IB_PMA_SELX_PORT_MULTI_XMIT_PACKETS	__constant_htons(0x0040)
+#define IB_PMA_SELX_PORT_MULTI_RCV_PACKETS	__constant_htons(0x0080)
+
+static int recv_pma_get_classportinfo(struct ib_perf *pmp)
+{
+	struct ib_pma_classportinfo *p =
+		(struct ib_pma_classportinfo *)pmp->data;
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+
+	if (pmp->attr_mod != 0)
+		pmp->status |= IB_SMP_INVALID_FIELD;
+
+	/* Indicate AllPortSelect is valid (only one port anyway) */
+	p->cap_mask = cpu_to_be16(1 << 8);
+	p->base_version = 1;
+	p->class_version = 1;
+	/*
+	 * Expected response time is 4.096 usec. * 2^18 == 1.073741824
+	 * sec.
+	 */
+	p->resp_time_value = 18;
+
+	return reply((struct ib_smp *) pmp);
+}
+
+/*
+ * The PortSamplesControl.CounterMasks field is an array of 3 bit fields
+ * which specify the N'th counter's capabilities. See ch. 16.1.3.2.
+ * We support 5 counters which only count the mandatory quantities.
+ */
+#define COUNTER_MASK(q, n) (q << ((9 - n) * 3))
+#define COUNTER_MASK0_9 \
+	__constant_cpu_to_be32(COUNTER_MASK(1, 0) | \
+			       COUNTER_MASK(1, 1) | \
+			       COUNTER_MASK(1, 2) | \
+			       COUNTER_MASK(1, 3) | \
+			       COUNTER_MASK(1, 4))
+
+static int recv_pma_get_portsamplescontrol(struct ib_perf *pmp,
+					   struct ib_device *ibdev, u8 port)
+{
+	struct ib_pma_portsamplescontrol *p =
+		(struct ib_pma_portsamplescontrol *)pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	unsigned long flags;
+	u8 port_select = p->port_select;
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+
+	p->port_select = port_select;
+	if (pmp->attr_mod != 0 ||
+	    (port_select != port && port_select != 0xFF))
+		pmp->status |= IB_SMP_INVALID_FIELD;
+	/*
+	 * Ticks are 10x the link transfer period which for 2.5Gbs is 4
+	 * nsec.  0 == 4 nsec., 1 == 8 nsec., ..., 255 == 1020 nsec.  Sample
+	 * intervals are counted in ticks.  Since we use Linux timers, that
+	 * count in jiffies, we can't sample for less than 1000 ticks if HZ
+	 * == 1000 (4000 ticks if HZ is 250).
+	 */
+	/* XXX This is WRONG. */
+	p->tick = 250;		/* 1 usec. */
+	p->counter_width = 4;	/* 32 bit counters */
+	p->counter_mask0_9 = COUNTER_MASK0_9;
+	spin_lock_irqsave(&dev->pending_lock, flags);
+	p->sample_status = dev->pma_sample_status;
+	p->sample_start = cpu_to_be32(dev->pma_sample_start);
+	p->sample_interval = cpu_to_be32(dev->pma_sample_interval);
+	p->tag = cpu_to_be16(dev->pma_tag);
+	p->counter_select[0] = dev->pma_counter_select[0];
+	p->counter_select[1] = dev->pma_counter_select[1];
+	p->counter_select[2] = dev->pma_counter_select[2];
+	p->counter_select[3] = dev->pma_counter_select[3];
+	p->counter_select[4] = dev->pma_counter_select[4];
+	spin_unlock_irqrestore(&dev->pending_lock, flags);
+
+	return reply((struct ib_smp *) pmp);
+}
+
+static int recv_pma_set_portsamplescontrol(struct ib_perf *pmp,
+					   struct ib_device *ibdev, u8 port)
+{
+	struct ib_pma_portsamplescontrol *p =
+		(struct ib_pma_portsamplescontrol *)pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	unsigned long flags;
+	u32 start;
+
+	if (pmp->attr_mod != 0 ||
+	    (p->port_select != port && p->port_select != 0xFF)) {
+		pmp->status |= IB_SMP_INVALID_FIELD;
+		return reply((struct ib_smp *) pmp);
+	}
+
+	start = be32_to_cpu(p->sample_start);
+	if (start != 0) {
+		spin_lock_irqsave(&dev->pending_lock, flags);
+		if (dev->pma_sample_status == IB_PMA_SAMPLE_STATUS_DONE) {
+			dev->pma_sample_status = IB_PMA_SAMPLE_STATUS_STARTED;
+			dev->pma_sample_start = start;
+			dev->pma_sample_interval =
+				be32_to_cpu(p->sample_interval);
+			dev->pma_tag = be16_to_cpu(p->tag);
+			if (p->counter_select[0])
+				dev->pma_counter_select[0] =
+					p->counter_select[0];
+			if (p->counter_select[1])
+				dev->pma_counter_select[1] =
+					p->counter_select[1];
+			if (p->counter_select[2])
+				dev->pma_counter_select[2] =
+					p->counter_select[2];
+			if (p->counter_select[3])
+				dev->pma_counter_select[3] =
+					p->counter_select[3];
+			if (p->counter_select[4])
+				dev->pma_counter_select[4] =
+					p->counter_select[4];
+		}
+		spin_unlock_irqrestore(&dev->pending_lock, flags);
+	}
+	return recv_pma_get_portsamplescontrol(pmp, ibdev, port);
+}
+
+static u64 get_counter(struct ipath_ibdev *dev, __be16 sel)
+{
+	switch (sel) {
+	case IB_PMA_PORT_XMIT_DATA:
+		return dev->ipath_sword;
+	case IB_PMA_PORT_RCV_DATA:
+		return dev->ipath_rword;
+	case IB_PMA_PORT_XMIT_PKTS:
+		return dev->ipath_spkts;
+	case IB_PMA_PORT_RCV_PKTS:
+		return dev->ipath_rpkts;
+	case IB_PMA_PORT_XMIT_WAIT:
+		return dev->ipath_xmit_wait;
+	default:
+		return 0;
+	}
+}
+
+static int recv_pma_get_portsamplesresult(struct ib_perf *pmp,
+					  struct ib_device *ibdev)
+{
+	struct ib_pma_portsamplesresult *p =
+		(struct ib_pma_portsamplesresult *)pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	int i;
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+	p->tag = cpu_to_be16(dev->pma_tag);
+	p->sample_status = cpu_to_be16(dev->pma_sample_status);
+	for (i = 0; i < ARRAY_SIZE(dev->pma_counter_select); i++)
+		p->counter[i] = cpu_to_be32(
+			get_counter(dev, dev->pma_counter_select[i]));
+
+	return reply((struct ib_smp *) pmp);
+}
+
+static int recv_pma_get_portsamplesresult_ext(struct ib_perf *pmp,
+					      struct ib_device *ibdev)
+{
+	struct ib_pma_portsamplesresult_ext *p =
+		(struct ib_pma_portsamplesresult_ext *)pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	int i;
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+	p->tag = cpu_to_be16(dev->pma_tag);
+	p->sample_status = cpu_to_be16(dev->pma_sample_status);
+	/* 64 bits */
+	p->extended_width = __constant_cpu_to_be32(0x80000000);
+	for (i = 0; i < ARRAY_SIZE(dev->pma_counter_select); i++)
+		p->counter[i] = cpu_to_be64(
+			get_counter(dev, dev->pma_counter_select[i]));
+
+	return reply((struct ib_smp *) pmp);
+}
+
+static int recv_pma_get_portcounters(struct ib_perf *pmp,
+				     struct ib_device *ibdev, u8 port)
+{
+	struct ib_pma_portcounters *p = (struct ib_pma_portcounters *)
+		pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	struct ipath_layer_counters cntrs;
+	u8 port_select = p->port_select;
+
+	ipath_layer_get_counters(dev->dd, &cntrs);
+
+	/* Adjust counters for any resets done. */
+	cntrs.symbol_error_counter -= dev->n_symbol_error_counter;
+	cntrs.link_error_recovery_counter -=
+		dev->n_link_error_recovery_counter;
+	cntrs.link_downed_counter -= dev->n_link_downed_counter;
+	cntrs.port_rcv_errors += dev->rcv_errors;
+	cntrs.port_rcv_errors -= dev->n_port_rcv_errors;
+	cntrs.port_rcv_remphys_errors -= dev->n_port_rcv_remphys_errors;
+	cntrs.port_xmit_discards -= dev->n_port_xmit_discards;
+	cntrs.port_xmit_data -= dev->n_port_xmit_data;
+	cntrs.port_rcv_data -= dev->n_port_rcv_data;
+	cntrs.port_xmit_packets -= dev->n_port_xmit_packets;
+	cntrs.port_rcv_packets -= dev->n_port_rcv_packets;
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+
+	p->port_select = port_select;
+	if (pmp->attr_mod != 0 ||
+	    (port_select != port && port_select != 0xFF))
+		pmp->status |= IB_SMP_INVALID_FIELD;
+
+	if (cntrs.symbol_error_counter > 0xFFFFUL)
+		p->symbol_error_counter = 0xFFFF;
+	else
+		p->symbol_error_counter =
+			cpu_to_be16((u16)cntrs.symbol_error_counter);
+	if (cntrs.link_error_recovery_counter > 0xFFUL)
+		p->link_error_recovery_counter = 0xFF;
+	else
+		p->link_error_recovery_counter =
+			(u8)cntrs.link_error_recovery_counter;
+	if (cntrs.link_downed_counter > 0xFFUL)
+		p->link_downed_counter = 0xFF;
+	else
+		p->link_downed_counter = (u8)cntrs.link_downed_counter;
+	if (cntrs.port_rcv_errors > 0xFFFFUL)
+		p->port_rcv_errors = 0xFFFF;
+	else
+		p->port_rcv_errors =
+			cpu_to_be16((u16) cntrs.port_rcv_errors);
+	if (cntrs.port_rcv_remphys_errors > 0xFFFFUL)
+		p->port_rcv_remphys_errors = 0xFFFF;
+	else
+		p->port_rcv_remphys_errors =
+			cpu_to_be16((u16)cntrs.port_rcv_remphys_errors);
+	if (cntrs.port_xmit_discards > 0xFFFFUL)
+		p->port_xmit_discards = 0xFFFF;
+	else
+		p->port_xmit_discards =
+			cpu_to_be16((u16)cntrs.port_xmit_discards);
+	if (cntrs.port_xmit_data > 0xFFFFFFFFUL)
+		p->port_xmit_data = 0xFFFFFFFF;
+	else
+		p->port_xmit_data = cpu_to_be32((u32)cntrs.port_xmit_data);
+	if (cntrs.port_rcv_data > 0xFFFFFFFFUL)
+		p->port_rcv_data = 0xFFFFFFFF;
+	else
+		p->port_rcv_data = cpu_to_be32((u32)cntrs.port_rcv_data);
+	if (cntrs.port_xmit_packets > 0xFFFFFFFFUL)
+		p->port_xmit_packets = 0xFFFFFFFF;
+	else
+		p->port_xmit_packets =
+			cpu_to_be32((u32)cntrs.port_xmit_packets);
+	if (cntrs.port_rcv_packets > 0xFFFFFFFFUL)
+		p->port_rcv_packets = 0xFFFFFFFF;
+	else
+		p->port_rcv_packets =
+			cpu_to_be32((u32) cntrs.port_rcv_packets);
+
+	return reply((struct ib_smp *) pmp);
+}
+
+static int recv_pma_get_portcounters_ext(struct ib_perf *pmp,
+					 struct ib_device *ibdev, u8 port)
+{
+	struct ib_pma_portcounters_ext *p =
+		(struct ib_pma_portcounters_ext *)pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	u64 swords, rwords, spkts, rpkts, xwait;
+	u8 port_select = p->port_select;
+
+	ipath_layer_snapshot_counters(dev->dd, &swords, &rwords, &spkts,
+				      &rpkts, &xwait);
+
+	/* Adjust counters for any resets done. */
+	swords -= dev->n_port_xmit_data;
+	rwords -= dev->n_port_rcv_data;
+	spkts -= dev->n_port_xmit_packets;
+	rpkts -= dev->n_port_rcv_packets;
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+
+	p->port_select = port_select;
+	if (pmp->attr_mod != 0 ||
+	    (port_select != port && port_select != 0xFF))
+		pmp->status |= IB_SMP_INVALID_FIELD;
+
+	p->port_xmit_data = cpu_to_be64(swords);
+	p->port_rcv_data = cpu_to_be64(rwords);
+	p->port_xmit_packets = cpu_to_be64(spkts);
+	p->port_rcv_packets = cpu_to_be64(rpkts);
+	p->port_unicast_xmit_packets = cpu_to_be64(dev->n_unicast_xmit);
+	p->port_unicast_rcv_packets = cpu_to_be64(dev->n_unicast_rcv);
+	p->port_multicast_xmit_packets = cpu_to_be64(dev->n_multicast_xmit);
+	p->port_multicast_rcv_packets = cpu_to_be64(dev->n_multicast_rcv);
+
+	return reply((struct ib_smp *) pmp);
+}
+
+static int recv_pma_set_portcounters(struct ib_perf *pmp,
+				     struct ib_device *ibdev, u8 port)
+{
+	struct ib_pma_portcounters *p = (struct ib_pma_portcounters *)
+		pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	struct ipath_layer_counters cntrs;
+
+	/*
+	 * Since the HW doesn't support clearing counters, we save the
+	 * current count and subtract it from future responses.
+	 */
+	ipath_layer_get_counters(dev->dd, &cntrs);
+
+	if (p->counter_select & IB_PMA_SEL_SYMBOL_ERROR)
+		dev->n_symbol_error_counter = cntrs.symbol_error_counter;
+
+	if (p->counter_select & IB_PMA_SEL_LINK_ERROR_RECOVERY)
+		dev->n_link_error_recovery_counter =
+			cntrs.link_error_recovery_counter;
+
+	if (p->counter_select & IB_PMA_SEL_LINK_DOWNED)
+		dev->n_link_downed_counter = cntrs.link_downed_counter;
+
+	if (p->counter_select & IB_PMA_SEL_PORT_RCV_ERRORS)
+		dev->n_port_rcv_errors =
+			cntrs.port_rcv_errors + dev->rcv_errors;
+
+	if (p->counter_select & IB_PMA_SEL_PORT_RCV_REMPHYS_ERRORS)
+		dev->n_port_rcv_remphys_errors =
+			cntrs.port_rcv_remphys_errors;
+
+	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_DISCARDS)
+		dev->n_port_xmit_discards = cntrs.port_xmit_discards;
+
+	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_DATA)
+		dev->n_port_xmit_data = cntrs.port_xmit_data;
+
+	if (p->counter_select & IB_PMA_SEL_PORT_RCV_DATA)
+		dev->n_port_rcv_data = cntrs.port_rcv_data;
+
+	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_PACKETS)
+		dev->n_port_xmit_packets = cntrs.port_xmit_packets;
+
+	if (p->counter_select & IB_PMA_SEL_PORT_RCV_PACKETS)
+		dev->n_port_rcv_packets = cntrs.port_rcv_packets;
+
+	return recv_pma_get_portcounters(pmp, ibdev, port);
+}
+
+static int recv_pma_set_portcounters_ext(struct ib_perf *pmp,
+					 struct ib_device *ibdev, u8 port)
+{
+	struct ib_pma_portcounters *p = (struct ib_pma_portcounters *)
+		pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	u64 swords, rwords, spkts, rpkts, xwait;
+
+	ipath_layer_snapshot_counters(dev->dd, &swords, &rwords, &spkts,
+				      &rpkts, &xwait);
+
+	if (p->counter_select & IB_PMA_SELX_PORT_XMIT_DATA)
+		dev->n_port_xmit_data = swords;
+
+	if (p->counter_select & IB_PMA_SELX_PORT_RCV_DATA)
+		dev->n_port_rcv_data = rwords;
+
+	if (p->counter_select & IB_PMA_SELX_PORT_XMIT_PACKETS)
+		dev->n_port_xmit_packets = spkts;
+
+	if (p->counter_select & IB_PMA_SELX_PORT_RCV_PACKETS)
+		dev->n_port_rcv_packets = rpkts;
+
+	if (p->counter_select & IB_PMA_SELX_PORT_UNI_XMIT_PACKETS)
+		dev->n_unicast_xmit = 0;
+
+	if (p->counter_select & IB_PMA_SELX_PORT_UNI_RCV_PACKETS)
+		dev->n_unicast_rcv = 0;
+
+	if (p->counter_select & IB_PMA_SELX_PORT_MULTI_XMIT_PACKETS)
+		dev->n_multicast_xmit = 0;
+
+	if (p->counter_select & IB_PMA_SELX_PORT_MULTI_RCV_PACKETS)
+		dev->n_multicast_rcv = 0;
+
+	return recv_pma_get_portcounters_ext(pmp, ibdev, port);
+}
+
+static inline int process_subn(struct ib_device *ibdev, int mad_flags,
+			       u8 port_num, struct ib_mad *in_mad,
+			       struct ib_mad *out_mad)
+{
+	struct ib_smp *smp = (struct ib_smp *)out_mad;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+
+	*out_mad = *in_mad;
+	if (smp->class_version != 1) {
+		smp->status |= IB_SMP_UNSUP_VERSION;
+		return reply(smp);
+	}
+
+	/* Is the mkey in the process of expiring? */
+	if (dev->mkey_lease_timeout && jiffies >= dev->mkey_lease_timeout) {
+		/* Clear timeout and mkey protection field. */
+		dev->mkey_lease_timeout = 0;
+		dev->mkeyprot_resv_lmc &= 0x3F;
+	}
+
+	/*
+	 * M_Key checking depends on
+	 * Portinfo:M_Key_protect_bits
+	 */
+	if ((mad_flags & IB_MAD_IGNORE_MKEY) == 0 && dev->mkey != 0 &&
+	    dev->mkey != smp->mkey &&
+	    (smp->method == IB_MGMT_METHOD_SET ||
+	     (smp->method == IB_MGMT_METHOD_GET &&
+	      (dev->mkeyprot_resv_lmc >> 7) != 0))) {
+		if (dev->mkey_violations != 0xFFFF)
+			++dev->mkey_violations;
+		if (dev->mkey_lease_timeout || dev->mkey_lease_period == 0)
+			return IB_MAD_RESULT_SUCCESS |
+				IB_MAD_RESULT_CONSUMED;
+		dev->mkey_lease_timeout = jiffies +
+			dev->mkey_lease_period * HZ;
+		/* Future: Generate a trap notice. */
+		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
+	} else if (dev->mkey_lease_timeout)
+		dev->mkey_lease_timeout = 0;
+
+	switch (smp->method) {
+	case IB_MGMT_METHOD_GET:
+		switch (smp->attr_id) {
+		case IB_SMP_ATTR_NODE_DESC:
+			return recv_subn_get_nodedescription(smp, ibdev);
+
+		case IB_SMP_ATTR_NODE_INFO:
+			return recv_subn_get_nodeinfo(smp, ibdev, port_num);
+
+		case IB_SMP_ATTR_GUID_INFO:
+			return recv_subn_get_guidinfo(smp, ibdev);
+
+		case IB_SMP_ATTR_PORT_INFO:
+			return recv_subn_get_portinfo(smp, ibdev, port_num);
+
+		case IB_SMP_ATTR_PKEY_TABLE:
+			return recv_subn_get_pkeytable(smp, ibdev);
+
+		case IB_SMP_ATTR_SM_INFO:
+			if (dev->port_cap_flags & IB_PORT_SM_DISABLED)
+				return IB_MAD_RESULT_SUCCESS |
+					IB_MAD_RESULT_CONSUMED;
+			if (dev->port_cap_flags & IB_PORT_SM)
+				return IB_MAD_RESULT_SUCCESS;
+			/* FALLTHROUGH */
+		default:
+			smp->status |= IB_SMP_UNSUP_METH_ATTR;
+			return reply(smp);
+		}
+
+	case IB_MGMT_METHOD_SET:
+		switch (smp->attr_id) {
+		case IB_SMP_ATTR_GUID_INFO:
+			return recv_subn_set_guidinfo(smp, ibdev);
+
+		case IB_SMP_ATTR_PORT_INFO:
+			return recv_subn_set_portinfo(smp, ibdev, port_num);
+
+		case IB_SMP_ATTR_PKEY_TABLE:
+			return recv_subn_set_pkeytable(smp, ibdev);
+
+		case IB_SMP_ATTR_SM_INFO:
+			if (dev->port_cap_flags & IB_PORT_SM_DISABLED)
+				return IB_MAD_RESULT_SUCCESS |
+					IB_MAD_RESULT_CONSUMED;
+			if (dev->port_cap_flags & IB_PORT_SM)
+				return IB_MAD_RESULT_SUCCESS;
+			/* FALLTHROUGH */
+		default:
+			smp->status |= IB_SMP_UNSUP_METH_ATTR;
+			return reply(smp);
+		}
+
+	case IB_MGMT_METHOD_GET_RESP:
+		/*
+		 * The ib_mad module will call us to process responses
+		 * before checking for other consumers.
+		 * Just tell the caller to process it normally.
+		 */
+		return IB_MAD_RESULT_FAILURE;
+
+	default:
+		smp->status |= IB_SMP_UNSUP_METHOD;
+		return reply(smp);
+	}
+}
+
+static inline int process_perf(struct ib_device *ibdev, u8 port_num,
+			       struct ib_mad *in_mad,
+			       struct ib_mad *out_mad)
+{
+	struct ib_perf *pmp = (struct ib_perf *)out_mad;
+
+	*out_mad = *in_mad;
+	if (pmp->class_version != 1) {
+		pmp->status |= IB_SMP_UNSUP_VERSION;
+		return reply((struct ib_smp *) pmp);
+	}
+
+	switch (pmp->method) {
+	case IB_MGMT_METHOD_GET:
+		switch (pmp->attr_id) {
+		case IB_PMA_CLASS_PORT_INFO:
+			return recv_pma_get_classportinfo(pmp);
+
+		case IB_PMA_PORT_SAMPLES_CONTROL:
+			return recv_pma_get_portsamplescontrol(pmp, ibdev,
+							       port_num);
+
+		case IB_PMA_PORT_SAMPLES_RESULT:
+			return recv_pma_get_portsamplesresult(pmp, ibdev);
+
+		case IB_PMA_PORT_SAMPLES_RESULT_EXT:
+			return recv_pma_get_portsamplesresult_ext(pmp,
+								  ibdev);
+
+		case IB_PMA_PORT_COUNTERS:
+			return recv_pma_get_portcounters(pmp, ibdev,
+							 port_num);
+
+		case IB_PMA_PORT_COUNTERS_EXT:
+			return recv_pma_get_portcounters_ext(pmp, ibdev,
+							     port_num);
+
+		default:
+			pmp->status |= IB_SMP_UNSUP_METH_ATTR;
+			return reply((struct ib_smp *) pmp);
+		}
+
+	case IB_MGMT_METHOD_SET:
+		switch (pmp->attr_id) {
+		case IB_PMA_PORT_SAMPLES_CONTROL:
+			return recv_pma_set_portsamplescontrol(pmp, ibdev,
+							       port_num);
+
+		case IB_PMA_PORT_COUNTERS:
+			return recv_pma_set_portcounters(pmp, ibdev,
+							 port_num);
+
+		case IB_PMA_PORT_COUNTERS_EXT:
+			return recv_pma_set_portcounters_ext(pmp, ibdev,
+							     port_num);
+
+		default:
+			pmp->status |= IB_SMP_UNSUP_METH_ATTR;
+			return reply((struct ib_smp *) pmp);
+		}
+
+	case IB_MGMT_METHOD_GET_RESP:
+		/*
+		 * The ib_mad module will call us to process responses
+		 * before checking for other consumers.
+		 * Just tell the caller to process it normally.
+		 */
+		return IB_MAD_RESULT_FAILURE;
+
+	default:
+		pmp->status |= IB_SMP_UNSUP_METHOD;
+		return reply((struct ib_smp *) pmp);
+	}
+}
+
+/**
+ * ipath_process_mad - process an incoming MAD packet
+ * @ibdev: the infiniband device this packet came in on
+ * @mad_flags: MAD flags
+ * @port_num: the port number this packet came in on
+ * @in_wc: the work completion entry for this packet
+ * @in_grh: the global route header for this packet
+ * @in_mad: the incoming MAD
+ * @out_mad: any outgoing MAD reply
+ *
+ * Returns IB_MAD_RESULT_SUCCESS if this is a MAD that we are not
+ * interested in processing.
+ *
+ * Note that the verbs framework has already done the MAD sanity checks,
+ * and hop count/pointer updating for IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE
+ * MADs.
+ *
+ * This is called by the ib_mad module.
+ */
+int ipath_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
+		      struct ib_wc *in_wc, struct ib_grh *in_grh,
+		      struct ib_mad *in_mad, struct ib_mad *out_mad)
+{
+	struct ipath_ibdev *dev = to_idev(ibdev);
+
+	/*
+	 * Snapshot current HW counters to "clear" them.
+	 * This should be done when the driver is loaded except that for
+	 * some reason we get a zillion errors when brining up the link.
+	 */
+	if (dev->rcv_errors == 0) {
+		struct ipath_layer_counters cntrs;
+
+		ipath_layer_get_counters(to_idev(ibdev)->dd, &cntrs);
+		dev->rcv_errors++;
+		dev->n_symbol_error_counter = cntrs.symbol_error_counter;
+		dev->n_link_error_recovery_counter =
+			cntrs.link_error_recovery_counter;
+		dev->n_link_downed_counter = cntrs.link_downed_counter;
+		dev->n_port_rcv_errors = cntrs.port_rcv_errors + 1;
+		dev->n_port_rcv_remphys_errors = cntrs.port_rcv_remphys_errors;
+		dev->n_port_xmit_discards = cntrs.port_xmit_discards;
+		dev->n_port_xmit_data = cntrs.port_xmit_data;
+		dev->n_port_rcv_data = cntrs.port_rcv_data;
+		dev->n_port_xmit_packets = cntrs.port_xmit_packets;
+		dev->n_port_rcv_packets = cntrs.port_rcv_packets;
+	}
+	switch (in_mad->mad_hdr.mgmt_class) {
+	case IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE:
+	case IB_MGMT_CLASS_SUBN_LID_ROUTED:
+		return process_subn(ibdev, mad_flags, port_num,
+				    in_mad, out_mad);
+
+	case IB_MGMT_CLASS_PERF_MGMT:
+		return process_perf(ibdev, port_num, in_mad, out_mad);
+
+	default:
+		return IB_MAD_RESULT_SUCCESS;
+	}
+}
diff -r 44cd07539d66 -r f57c24166c57 drivers/infiniband/hw/ipath/ipath_qp.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Mar  9 16:16:51 2006 -0800
@@ -0,0 +1,876 @@
+/*
+ * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/err.h>
+#include <linux/vmalloc.h>
+
+#include "ipath_verbs.h"
+#include "ips_common.h"
+
+#define BITS_PER_PAGE		(PAGE_SIZE*BITS_PER_BYTE)
+#define BITS_PER_PAGE_MASK	(BITS_PER_PAGE-1)
+#define mk_qpn(qpt, map, off)	(((map) - (qpt)->map) * BITS_PER_PAGE + \
+				 (off))
+#define find_next_offset(map, off) find_next_zero_bit((map)->page, \
+						      BITS_PER_PAGE, off)
+
+#define TRANS_INVALID	0
+#define TRANS_ANY2RST	1
+#define TRANS_RST2INIT	2
+#define TRANS_INIT2INIT	3
+#define TRANS_INIT2RTR	4
+#define TRANS_RTR2RTS	5
+#define TRANS_RTS2RTS	6
+#define TRANS_SQERR2RTS	7
+#define TRANS_ANY2ERR	8
+#define TRANS_RTS2SQD	9  /* XXX Wait for expected ACKs & signal event */
+#define TRANS_SQD2SQD	10 /* error if not drained & parameter change */
+#define TRANS_SQD2RTS	11 /* error if not drained */
+
+/*
+ * Convert the AETH credit code into the number of credits.
+ */
+static u32 credit_table[31] = {
+	0,			/* 0 */
+	1,			/* 1 */
+	2,			/* 2 */
+	3,			/* 3 */
+	4,			/* 4 */
+	6,			/* 5 */
+	8,			/* 6 */
+	12,			/* 7 */
+	16,			/* 8 */
+	24,			/* 9 */
+	32,			/* A */
+	48,			/* B */
+	64,			/* C */
+	96,			/* D */
+	128,			/* E */
+	192,			/* F */
+	256,			/* 10 */
+	384,			/* 11 */
+	512,			/* 12 */
+	768,			/* 13 */
+	1024,			/* 14 */
+	1536,			/* 15 */
+	2048,			/* 16 */
+	3072,			/* 17 */
+	4096,			/* 18 */
+	6144,			/* 19 */
+	8192,			/* 1A */
+	12288,			/* 1B */
+	16384,			/* 1C */
+	24576,			/* 1D */
+	32768			/* 1E */
+};
+
+static inline u32 alloc_qpn(struct ipath_qp_table *qpt)
+{
+	u32 i, offset, max_scan, qpn;
+	struct qpn_map *map;
+
+	qpn = qpt->last + 1;
+	if (qpn >= QPN_MAX)
+		qpn = 2;
+	offset = qpn & BITS_PER_PAGE_MASK;
+	map = &qpt->map[qpn / BITS_PER_PAGE];
+	max_scan = qpt->nmaps - !offset;
+	for (i = 0;;) {
+		if (unlikely(!map->page)) {
+			unsigned long page = get_zeroed_page(GFP_KERNEL);
+			unsigned long flags;
+
+			/*
+			 * Free the page if someone raced with us
+			 * installing it:
+			 */
+			spin_lock_irqsave(&qpt->lock, flags);
+			if (map->page)
+				free_page(page);
+			else
+				map->page = (void *)page;
+			spin_unlock_irqrestore(&qpt->lock, flags);
+			if (unlikely(!map->page))
+				break;
+		}
+		if (likely(atomic_read(&map->n_free))) {
+			do {
+				if (!test_and_set_bit(offset, map->page)) {
+					atomic_dec(&map->n_free);
+					qpt->last = qpn;
+					return qpn;
+				}
+				offset = find_next_offset(map, offset);
+				qpn = mk_qpn(qpt, map, offset);
+				/*
+				 * This test differs from alloc_pidmap().
+				 * If find_next_offset() does find a zero
+				 * bit, we don't need to check for QPN
+				 * wrapping around past our starting QPN.
+				 * We just need to be sure we don't loop
+				 * forever.
+				 */
+			} while (offset < BITS_PER_PAGE && qpn < QPN_MAX);
+		}
+		/*
+		 * In order to keep the number of pages allocated to a
+		 * minimum, we scan the all existing pages before increasing
+		 * the size of the bitmap table.
+		 */
+		if (++i > max_scan) {
+			if (qpt->nmaps == QPNMAP_ENTRIES)
+				break;
+			map = &qpt->map[qpt->nmaps++];
+			offset = 0;
+		} else if (map < &qpt->map[qpt->nmaps]) {
+			++map;
+			offset = 0;
+		} else {
+			map = &qpt->map[0];
+			offset = 2;
+		}
+		qpn = mk_qpn(qpt, map, offset);
+	}
+	return 0;
+}
+
+static inline void free_qpn(struct ipath_qp_table *qpt, u32 qpn)
+{
+	struct qpn_map *map;
+
+	map = qpt->map + qpn / BITS_PER_PAGE;
+	if (map->page)
+		clear_bit(qpn & BITS_PER_PAGE_MASK, map->page);
+	atomic_inc(&map->n_free);
+}
+
+/**
+ * ipath_alloc_qpn - allocate a QP number
+ * @qpt: the QP table
+ * @qp: the QP
+ * @type: the QP type (IB_QPT_SMI and IB_QPT_GSI are special)
+ *
+ * Allocate the next available QPN and put the QP into the hash table.
+ * The hash table holds a reference to the QP.
+ */
+int ipath_alloc_qpn(struct ipath_qp_table *qpt, struct ipath_qp *qp,
+		    enum ib_qp_type type)
+{
+	unsigned long flags;
+	u32 qpn;
+
+	if (type == IB_QPT_SMI)
+		qpn = 0;
+	else if (type == IB_QPT_GSI)
+		qpn = 1;
+	else {
+		/* Allocate the next available QPN */
+		qpn = alloc_qpn(qpt);
+		if (qpn == 0)
+			return -ENOMEM;
+	}
+	qp->ibqp.qp_num = qpn;
+
+	/* Add the QP to the hash table. */
+	spin_lock_irqsave(&qpt->lock, flags);
+
+	qpn %= qpt->max;
+	qp->next = qpt->table[qpn];
+	qpt->table[qpn] = qp;
+	atomic_inc(&qp->refcount);
+
+	spin_unlock_irqrestore(&qpt->lock, flags);
+	return 0;
+}
+
+/**
+ * ipath_free_qp - remove a QP from the QP table
+ * @qpt: the QP table
+ * @qp: the QP to remove
+ *
+ * Remove the QP from the table so it can't be found asynchronously by
+ * the receive interrupt routine.
+ */
+void ipath_free_qp(struct ipath_qp_table *qpt, struct ipath_qp *qp)
+{
+	struct ipath_qp *q, **qpp;
+	unsigned long flags;
+	int fnd = 0;
+
+	spin_lock_irqsave(&qpt->lock, flags);
+
+	/* Remove QP from the hash table. */
+	qpp = &qpt->table[qp->ibqp.qp_num % qpt->max];
+	for (; (q = *qpp) != NULL; qpp = &q->next) {
+		if (q == qp) {
+			*qpp = qp->next;
+			qp->next = NULL;
+			atomic_dec(&qp->refcount);
+			fnd = 1;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&qpt->lock, flags);
+
+	if (!fnd)
+		return;
+
+	/* If QPN is not reserved, mark QPN free in the bitmap. */
+	if (qp->ibqp.qp_num > 1)
+		free_qpn(qpt, qp->ibqp.qp_num);
+
+	wait_event(qp->wait, !atomic_read(&qp->refcount));
+}
+
+/**
+ * ipath_free_all_qps - remove all QPs from the table
+ * @qpt: the QP table to empty
+ */
+void ipath_free_all_qps(struct ipath_qp_table *qpt)
+{
+	unsigned long flags;
+	struct ipath_qp *qp, *nqp;
+	u32 n;
+
+	for (n = 0; n < qpt->max; n++) {
+		spin_lock_irqsave(&qpt->lock, flags);
+		qp = qpt->table[n];
+		qpt->table[n] = NULL;
+		spin_unlock_irqrestore(&qpt->lock, flags);
+
+		while (qp) {
+			nqp = qp->next;
+			if (qp->ibqp.qp_num > 1)
+				free_qpn(qpt, qp->ibqp.qp_num);
+			if (!atomic_dec_and_test(&qp->refcount) ||
+			    !ipath_destroy_qp(&qp->ibqp))
+				_VERBS_INFO("QP memory leak!\n");
+			qp = nqp;
+		}
+	}
+
+	for (n = 0; n < ARRAY_SIZE(qpt->map); n++) {
+		if (qpt->map[n].page)
+			free_page((unsigned long)qpt->map[n].page);
+	}
+}
+
+/**
+ * ipath_lookup_qpn - return the QP with the given QPN
+ * @qpt: the QP table
+ * @qpn: the QP number to look up
+ *
+ * The caller is responsible for decrementing the QP reference count
+ * when done.
+ */
+struct ipath_qp *ipath_lookup_qpn(struct ipath_qp_table *qpt, u32 qpn)
+{
+	unsigned long flags;
+	struct ipath_qp *qp;
+
+	spin_lock_irqsave(&qpt->lock, flags);
+
+	for (qp = qpt->table[qpn % qpt->max]; qp; qp = qp->next) {
+		if (qp->ibqp.qp_num == qpn) {
+			atomic_inc(&qp->refcount);
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&qpt->lock, flags);
+	return qp;
+}
+
+/**
+ * ipath_reset_qp - initialize the QP state to the reset state
+ * @qp: the QP to reset
+ */
+static void ipath_reset_qp(struct ipath_qp *qp)
+{
+	qp->remote_qpn = 0;
+	qp->qkey = 0;
+	qp->qp_access_flags = 0;
+	qp->s_hdrwords = 0;
+	qp->s_psn = 0;
+	qp->r_psn = 0;
+	atomic_set(&qp->msn, 0);
+	if (qp->ibqp.qp_type == IB_QPT_RC) {
+		qp->s_state = IB_OPCODE_RC_SEND_LAST;
+		qp->r_state = IB_OPCODE_RC_SEND_LAST;
+	} else {
+		qp->s_state = IB_OPCODE_UC_SEND_LAST;
+		qp->r_state = IB_OPCODE_UC_SEND_LAST;
+	}
+	qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
+	qp->s_nak_state = 0;
+	qp->s_rnr_timeout = 0;
+	qp->s_head = 0;
+	qp->s_tail = 0;
+	qp->s_cur = 0;
+	qp->s_last = 0;
+	qp->s_ssn = 1;
+	qp->s_lsn = 0;
+	qp->r_rq.head = 0;
+	qp->r_rq.tail = 0;
+	qp->r_reuse_sge = 0;
+}
+
+/**
+ * ipath_modify_qp - modify the attributes of a queue pair
+ * @ibqp: the queue pair who's attributes we're modifying
+ * @attr: the new attributes
+ * @attr_mask: the mask of attributes to modify
+ *
+ * Returns 0 on success, otherwise returns an errno.
+ */
+int ipath_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+		    int attr_mask)
+{
+	struct ipath_qp *qp = to_iqp(ibqp);
+	enum ib_qp_state cur_state, new_state;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qp->r_rq.lock, flags);
+	spin_lock(&qp->s_lock);
+
+	cur_state = attr_mask & IB_QP_CUR_STATE ?
+		attr->cur_qp_state : qp->state;
+	new_state = attr_mask & IB_QP_STATE ? attr->qp_state : cur_state;
+
+	if (!ib_modify_qp_is_ok(cur_state, new_state, ibqp->qp_type,
+				attr_mask))
+		goto inval;
+
+	switch (new_state) {
+	case IB_QPS_RESET:
+		ipath_reset_qp(qp);
+		break;
+
+	case IB_QPS_ERR:
+		ipath_error_qp(qp);
+		break;
+
+	default:
+		break;
+
+	}
+
+	if (attr_mask & IB_QP_PKEY_INDEX) {
+		struct ipath_ibdev *dev = to_idev(ibqp->device);
+
+		if (attr->pkey_index >= ipath_layer_get_npkeys(dev->dd))
+			goto inval;
+		qp->s_pkey_index = attr->pkey_index;
+	}
+
+	if (attr_mask & IB_QP_DEST_QPN)
+		qp->remote_qpn = attr->dest_qp_num;
+
+	if (attr_mask & IB_QP_SQ_PSN) {
+		qp->s_next_psn = attr->sq_psn;
+		qp->s_last_psn = qp->s_next_psn - 1;
+	}
+
+	if (attr_mask & IB_QP_RQ_PSN)
+		qp->r_psn = attr->rq_psn;
+
+	if (attr_mask & IB_QP_ACCESS_FLAGS)
+		qp->qp_access_flags = attr->qp_access_flags;
+
+	if (attr_mask & IB_QP_AV) {
+		if (attr->ah_attr.dlid == 0 ||
+		    attr->ah_attr.dlid >= IPS_MULTICAST_LID_BASE)
+			goto inval;
+		qp->remote_ah_attr = attr->ah_attr;
+	}
+
+	if (attr_mask & IB_QP_PATH_MTU)
+		qp->path_mtu = attr->path_mtu;
+
+	if (attr_mask & IB_QP_RETRY_CNT)
+		qp->s_retry = qp->s_retry_cnt = attr->retry_cnt;
+
+	if (attr_mask & IB_QP_RNR_RETRY) {
+		qp->s_rnr_retry = attr->rnr_retry;
+		if (qp->s_rnr_retry > 7)
+			qp->s_rnr_retry = 7;
+		qp->s_rnr_retry_cnt = qp->s_rnr_retry;
+	}
+
+	if (attr_mask & IB_QP_MIN_RNR_TIMER) {
+		if (attr->min_rnr_timer > 31)
+			goto inval;
+		qp->s_min_rnr_timer = attr->min_rnr_timer;
+	}
+
+	if (attr_mask & IB_QP_QKEY)
+		qp->qkey = attr->qkey;
+
+	if (attr_mask & IB_QP_PKEY_INDEX)
+		qp->s_pkey_index = attr->pkey_index;
+
+	qp->state = new_state;
+	spin_unlock(&qp->s_lock);
+	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+
+	/*
+	 * If QP1 changed to the RTS state, try to move to the link to INIT
+	 * even if it was ACTIVE so the SM will reinitialize the SMA's
+	 * state.
+	 */
+	if (qp->ibqp.qp_num == 1 && new_state == IB_QPS_RTS) {
+		struct ipath_ibdev *dev = to_idev(ibqp->device);
+
+		ipath_layer_set_linkstate(dev->dd, IPATH_IB_LINKDOWN);
+	}
+	return 0;
+
+inval:
+	spin_unlock(&qp->s_lock);
+	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+	return -EINVAL;
+}
+
+int ipath_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
+                   struct ib_qp_init_attr *init_attr)
+{
+	struct ipath_qp *qp = to_iqp(ibqp);
+
+	attr->qp_state = qp->state;
+	attr->cur_qp_state = attr->qp_state;
+	attr->path_mtu = qp->path_mtu;
+	attr->path_mig_state = 0;
+	attr->qkey = qp->qkey;
+	attr->rq_psn = qp->r_psn;
+	attr->sq_psn = qp->s_next_psn;
+	attr->dest_qp_num = qp->remote_qpn;
+	attr->qp_access_flags = qp->qp_access_flags;
+	attr->cap.max_send_wr = qp->s_size - 1;
+	attr->cap.max_recv_wr = qp->r_rq.size - 1;
+	attr->cap.max_send_sge = qp->s_max_sge;
+	attr->cap.max_recv_sge = qp->r_rq.max_sge;
+	attr->cap.max_inline_data = 0;
+	attr->ah_attr = qp->remote_ah_attr;
+	memset(&attr->alt_ah_attr, 0, sizeof(attr->alt_ah_attr));
+	attr->pkey_index = qp->s_pkey_index;
+	attr->alt_pkey_index = 0;
+	attr->en_sqd_async_notify = 0;
+	attr->sq_draining = 0;
+	attr->max_rd_atomic = 1;
+	attr->max_dest_rd_atomic = 1;
+	attr->min_rnr_timer = qp->s_min_rnr_timer;
+	attr->port_num = 1;
+	attr->timeout = 0;
+	attr->retry_cnt = qp->s_retry_cnt;
+	attr->rnr_retry = qp->s_rnr_retry;
+	attr->alt_port_num = 0;
+	attr->alt_timeout = 0;
+
+	init_attr->event_handler = qp->ibqp.event_handler;
+	init_attr->qp_context = qp->ibqp.qp_context;
+	init_attr->send_cq = qp->ibqp.send_cq;
+	init_attr->recv_cq = qp->ibqp.recv_cq;
+	init_attr->srq = qp->ibqp.srq;
+	init_attr->cap = attr->cap;
+	init_attr->sq_sig_type = (qp->s_flags & (1 << IPATH_S_SIGNAL_REQ_WR)) ?
+		IB_SIGNAL_REQ_WR : 0;
+	init_attr->qp_type = qp->ibqp.qp_type;
+	init_attr->port_num = 1;
+	return 0;
+}
+
+/**
+ * ipath_compute_aeth - compute the AETH (syndrome + MSN)
+ * @qp: the queue pair to compute the AETH for
+ *
+ * Returns the AETH.
+ *
+ * The QP s_lock should be held.
+ */
+u32 ipath_compute_aeth(struct ipath_qp *qp)
+{
+	u32 aeth = atomic_read(&qp->msn) & IPS_MSN_MASK;
+
+	if (qp->s_nak_state) {
+		aeth |= qp->s_nak_state << IPS_AETH_CREDIT_SHIFT;
+	} else if (qp->ibqp.srq) {
+		/*
+		 * Shared receive queues don't generate credits.
+		 * Set the credit field to the invalid value.
+		 */
+		aeth |= IPS_AETH_CREDIT_INVAL << IPS_AETH_CREDIT_SHIFT;
+	} else {
+		u32 min, max, x;
+		u32 credits;
+
+		/*
+		 * Compute the number of credits available (RWQEs).
+		 * XXX Not holding the r_rq.lock here so there is a small
+		 * chance that the pair of reads are not atomic.
+		 */
+		credits = qp->r_rq.head - qp->r_rq.tail;
+		if ((int)credits < 0)
+			credits += qp->r_rq.size;
+		/*
+		 * Binary search the credit table to find the code to
+		 * use.
+		 */
+		min = 0;
+		max = 31;
+		for (;;) {
+			x = (min + max) / 2;
+			if (credit_table[x] == credits)
+				break;
+			if (credit_table[x] > credits)
+				max = x;
+			else if (min == x)
+				break;
+			else
+				min = x;
+		}
+		aeth |= x << IPS_AETH_CREDIT_SHIFT;
+	}
+	return cpu_to_be32(aeth);
+}
+
+/**
+ * ipath_create_qp - create a queue pair for a device
+ * @ibpd: the protection domain who's device we create the queue pair for
+ * @init_attr: the attributes of the queue pair
+ * @udata: unused by InfiniPath
+ *
+ * Returns the queue pair on success, otherwise returns an errno.
+ *
+ * Called by the ib_create_qp() core verbs function.
+ */
+struct ib_qp *ipath_create_qp(struct ib_pd *ibpd,
+			      struct ib_qp_init_attr *init_attr,
+			      struct ib_udata *udata)
+{
+	struct ipath_qp *qp;
+	int err;
+	struct ipath_swqe *swq = NULL;
+	struct ipath_ibdev *dev;
+	size_t sz;
+
+	if (init_attr->cap.max_send_sge > 255 ||
+	    init_attr->cap.max_recv_sge > 255)
+		return ERR_PTR(-ENOMEM);
+
+	switch (init_attr->qp_type) {
+	case IB_QPT_UC:
+	case IB_QPT_RC:
+		sz = sizeof(struct ipath_sge) *
+			init_attr->cap.max_send_sge +
+			sizeof(struct ipath_swqe);
+		swq = vmalloc((init_attr->cap.max_send_wr + 1) * sz);
+		if (swq == NULL)
+			return ERR_PTR(-ENOMEM);
+		/* FALLTHROUGH */
+	case IB_QPT_UD:
+	case IB_QPT_SMI:
+	case IB_QPT_GSI:
+		qp = kmalloc(sizeof(*qp), GFP_KERNEL);
+		if (!qp)
+			return ERR_PTR(-ENOMEM);
+		qp->r_rq.size = init_attr->cap.max_recv_wr + 1;
+		sz = sizeof(struct ipath_sge) *
+			init_attr->cap.max_recv_sge +
+			sizeof(struct ipath_rwqe);
+		qp->r_rq.wq = vmalloc(qp->r_rq.size * sz);
+		if (!qp->r_rq.wq) {
+			kfree(qp);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		/*
+		 * ib_create_qp() will initialize qp->ibqp
+		 * except for qp->ibqp.qp_num.
+		 */
+		spin_lock_init(&qp->s_lock);
+		spin_lock_init(&qp->r_rq.lock);
+		atomic_set(&qp->refcount, 0);
+		init_waitqueue_head(&qp->wait);
+		tasklet_init(&qp->s_task,
+			     init_attr->qp_type == IB_QPT_RC ?
+			     ipath_do_rc_send : ipath_do_uc_send,
+			     (unsigned long)qp);
+		qp->piowait.next = LIST_POISON1;
+		qp->piowait.prev = LIST_POISON2;
+		qp->timerwait.next = LIST_POISON1;
+		qp->timerwait.prev = LIST_POISON2;
+		qp->state = IB_QPS_RESET;
+		qp->s_wq = swq;
+		qp->s_size = init_attr->cap.max_send_wr + 1;
+		qp->s_max_sge = init_attr->cap.max_send_sge;
+		qp->r_rq.max_sge = init_attr->cap.max_recv_sge;
+		qp->s_flags = init_attr->sq_sig_type == IB_SIGNAL_REQ_WR ?
+			1 << IPATH_S_SIGNAL_REQ_WR : 0;
+		dev = to_idev(ibpd->device);
+		err = ipath_alloc_qpn(&dev->qp_table, qp,
+				      init_attr->qp_type);
+		if (err) {
+			vfree(swq);
+			vfree(qp->r_rq.wq);
+			kfree(qp);
+			return ERR_PTR(err);
+		}
+		ipath_reset_qp(qp);
+
+		/* Tell the core driver that the kernel SMA is present. */
+		if (qp->ibqp.qp_type == IB_QPT_SMI)
+			ipath_layer_set_verbs_flags(dev->dd,
+						    IPATH_VERBS_KERNEL_SMA);
+		break;
+
+	default:
+		/* Don't support raw QPs */
+		return ERR_PTR(-ENOSYS);
+	}
+
+	init_attr->cap.max_inline_data = 0;
+
+	return &qp->ibqp;
+}
+
+/**
+ * ipath_destroy_qp - destroy a queue pair
+ * @ibqp: the queue pair to destroy
+ *
+ * Returns 0 on success.
+ *
+ * Note that this can be called while the QP is actively sending or
+ * receiving!
+ */
+int ipath_destroy_qp(struct ib_qp *ibqp)
+{
+	struct ipath_qp *qp = to_iqp(ibqp);
+	struct ipath_ibdev *dev = to_idev(ibqp->device);
+	unsigned long flags;
+
+	/* Tell the core driver that the kernel SMA is gone. */
+	if (qp->ibqp.qp_type == IB_QPT_SMI)
+		ipath_layer_set_verbs_flags(dev->dd, 0);
+
+	spin_lock_irqsave(&qp->r_rq.lock, flags);
+	spin_lock(&qp->s_lock);
+	qp->state = IB_QPS_ERR;
+	spin_unlock(&qp->s_lock);
+	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+
+	/* Stop the sending tasklet. */
+	tasklet_kill(&qp->s_task);
+
+	/* Make sure the QP isn't on the timeout list. */
+	spin_lock_irqsave(&dev->pending_lock, flags);
+	if (qp->timerwait.next != LIST_POISON1)
+		list_del(&qp->timerwait);
+	if (qp->piowait.next != LIST_POISON1)
+		list_del(&qp->piowait);
+	spin_unlock_irqrestore(&dev->pending_lock, flags);
+
+	/*
+	 * Make sure that the QP is not in the QPN table so receive
+	 * interrupts will discard packets for this QP.  XXX Also remove QP
+	 * from multicast table.
+	 */
+	if (atomic_read(&qp->refcount) != 0)
+		ipath_free_qp(&dev->qp_table, qp);
+
+	vfree(qp->s_wq);
+	vfree(qp->r_rq.wq);
+	kfree(qp);
+	return 0;
+}
+
+/**
+ * ipath_init_qp_table - initialize the QP table for a device
+ * @idev: the device who's QP table we're initializing
+ * @size: the size of the QP table
+ *
+ * Returns 0 on success, otherwise returns an errno.
+ */
+int ipath_init_qp_table(struct ipath_ibdev *idev, int size)
+{
+	int i;
+
+	idev->qp_table.last = 1;	/* QPN 0 and 1 are special. */
+	idev->qp_table.max = size;
+	idev->qp_table.nmaps = 1;
+	idev->qp_table.table = kzalloc(size * sizeof(*idev->qp_table.table),
+				       GFP_KERNEL);
+	if (idev->qp_table.table == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(idev->qp_table.map); i++) {
+		atomic_set(&idev->qp_table.map[i].n_free, BITS_PER_PAGE);
+		idev->qp_table.map[i].page = NULL;
+	}
+
+	return 0;
+}
+
+/**
+ * ipath_sqerror_qp - put a QP's send queue into an error state
+ * @qp: QP who's send queue will be put into an error state
+ * @wc: the WC responsible for putting the QP in this state
+ *
+ * Flushes the send work queue.
+ * The QP s_lock should be held.
+ */
+
+void ipath_sqerror_qp(struct ipath_qp *qp, struct ib_wc *wc)
+{
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
+
+	_VERBS_INFO("Send queue error on QP%d/%d: err: %d\n",
+		    qp->ibqp.qp_num, qp->remote_qpn, wc->status);
+
+	spin_lock(&dev->pending_lock);
+	/* XXX What if its already removed by the timeout code? */
+	if (qp->timerwait.next != LIST_POISON1)
+		list_del(&qp->timerwait);
+	if (qp->piowait.next != LIST_POISON1)
+		list_del(&qp->piowait);
+	spin_unlock(&dev->pending_lock);
+
+	ipath_cq_enter(to_icq(qp->ibqp.send_cq), wc, 1);
+	if (++qp->s_last >= qp->s_size)
+		qp->s_last = 0;
+
+	wc->status = IB_WC_WR_FLUSH_ERR;
+
+	while (qp->s_last != qp->s_head) {
+		wc->wr_id = wqe->wr.wr_id;
+		wc->opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
+		ipath_cq_enter(to_icq(qp->ibqp.send_cq), wc, 1);
+		if (++qp->s_last >= qp->s_size)
+			qp->s_last = 0;
+		wqe = get_swqe_ptr(qp, qp->s_last);
+	}
+	qp->s_cur = qp->s_tail = qp->s_head;
+	qp->state = IB_QPS_SQE;
+}
+
+/**
+ * ipath_error_qp - put a QP into an error state
+ * @qp: the QP to put into an error state
+ *
+ * Flushes both send and receive work queues.
+ * QP r_rq.lock and s_lock should be held.
+ */
+
+void ipath_error_qp(struct ipath_qp *qp)
+{
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	struct ib_wc wc;
+
+	_VERBS_INFO("QP%d/%d in error state\n",
+		    qp->ibqp.qp_num, qp->remote_qpn);
+
+	spin_lock(&dev->pending_lock);
+	/* XXX What if its already removed by the timeout code? */
+	if (qp->timerwait.next != LIST_POISON1)
+		list_del(&qp->timerwait);
+	if (qp->piowait.next != LIST_POISON1)
+		list_del(&qp->piowait);
+	spin_unlock(&dev->pending_lock);
+
+	wc.status = IB_WC_WR_FLUSH_ERR;
+	wc.vendor_err = 0;
+	wc.byte_len = 0;
+	wc.imm_data = 0;
+	wc.qp_num = qp->ibqp.qp_num;
+	wc.src_qp = 0;
+	wc.wc_flags = 0;
+	wc.pkey_index = 0;
+	wc.slid = 0;
+	wc.sl = 0;
+	wc.dlid_path_bits = 0;
+	wc.port_num = 0;
+
+	while (qp->s_last != qp->s_head) {
+		struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
+
+		wc.wr_id = wqe->wr.wr_id;
+		wc.opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
+		if (++qp->s_last >= qp->s_size)
+			qp->s_last = 0;
+		ipath_cq_enter(to_icq(qp->ibqp.send_cq), &wc, 1);
+	}
+	qp->s_cur = qp->s_tail = qp->s_head;
+	qp->s_hdrwords = 0;
+	qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
+
+	wc.opcode = IB_WC_RECV;
+	while (qp->r_rq.tail != qp->r_rq.head) {
+		wc.wr_id = get_rwqe_ptr(&qp->r_rq, qp->r_rq.tail)->wr_id;
+		if (++qp->r_rq.tail >= qp->r_rq.size)
+			qp->r_rq.tail = 0;
+		ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc, 1);
+	}
+}
+
+/**
+ * ipath_get_credit - flush the send work queue of a QP
+ * @qp: the qp who's send work queue to flush
+ * @aeth: the Acknowledge Extended Transport Header
+ *
+ * The QP s_lock should be held.
+ */
+void ipath_get_credit(struct ipath_qp *qp, u32 aeth)
+{
+	u32 credit = (aeth >> IPS_AETH_CREDIT_SHIFT) & IPS_AETH_CREDIT_MASK;
+
+	/*
+	 * If the credit is invalid, we can send
+	 * as many packets as we like.  Otherwise, we have to
+	 * honor the credit field.
+	 */
+	if (credit == IPS_AETH_CREDIT_INVAL) {
+		qp->s_lsn = (u32) -1;
+	} else if (qp->s_lsn != (u32) -1) {
+		/* Compute new LSN (i.e., MSN + credit) */
+		credit = (aeth + credit_table[credit]) & IPS_MSN_MASK;
+		if (ipath_cmp24(credit, qp->s_lsn) > 0)
+			qp->s_lsn = credit;
+	}
+
+	/* Restart sending if it was blocked due to lack of credits. */
+	if (qp->s_cur != qp->s_head &&
+	    (qp->s_lsn == (u32) -1 ||
+	     ipath_cmp24(get_swqe_ptr(qp, qp->s_cur)->ssn,
+			 qp->s_lsn + 1) <= 0))
+		tasklet_hi_schedule(&qp->s_task);
+}
diff -r 44cd07539d66 -r f57c24166c57 drivers/infiniband/hw/ipath/ipath_ruc.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Mar  9 16:16:51 2006 -0800
@@ -0,0 +1,530 @@
+/*
+ * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include "ipath_verbs.h"
+
+/*
+ * Convert the AETH RNR timeout code into the number of milliseconds.
+ */
+const u32 ib_ipath_rnr_table[32] = {
+	656,			/* 0 */
+	1,			/* 1 */
+	1,			/* 2 */
+	1,			/* 3 */
+	1,			/* 4 */
+	1,			/* 5 */
+	1,			/* 6 */
+	1,			/* 7 */
+	1,			/* 8 */
+	1,			/* 9 */
+	1,			/* A */
+	1,			/* B */
+	1,			/* C */
+	1,			/* D */
+	2,			/* E */
+	2,			/* F */
+	3,			/* 10 */
+	4,			/* 11 */
+	6,			/* 12 */
+	8,			/* 13 */
+	11,			/* 14 */
+	16,			/* 15 */
+	21,			/* 16 */
+	31,			/* 17 */
+	41,			/* 18 */
+	62,			/* 19 */
+	82,			/* 1A */
+	123,			/* 1B */
+	164,			/* 1C */
+	246,			/* 1D */
+	328,			/* 1E */
+	492			/* 1F */
+};
+
+/**
+ * ipath_insert_rnr_queue - put this QP on the RNR timeout list for the device
+ * @qp: the QP
+ *
+ * XXX Use a simple list for now.  We might need a priority
+ * queue if we have lots of QPs waiting for RNR timeouts
+ * but that should be rare.
+ */
+void ipath_insert_rnr_queue(struct ipath_qp *qp)
+{
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->pending_lock, flags);
+	if (list_empty(&dev->rnrwait))
+		list_add(&qp->timerwait, &dev->rnrwait);
+	else {
+		struct list_head *l = &dev->rnrwait;
+		struct ipath_qp *nqp = list_entry(l->next, struct ipath_qp,
+						  timerwait);
+
+		while (qp->s_rnr_timeout >= nqp->s_rnr_timeout) {
+			qp->s_rnr_timeout -= nqp->s_rnr_timeout;
+			l = l->next;
+			if (l->next == &dev->rnrwait)
+				break;
+			nqp = list_entry(l->next, struct ipath_qp,
+					 timerwait);
+		}
+		list_add(&qp->timerwait, l);
+	}
+	spin_unlock_irqrestore(&dev->pending_lock, flags);
+}
+
+/**
+ * ipath_get_rwqe - copy the next RWQE into the QP's RWQE
+ * @qp: the QP
+ * @wr_id_only: update wr_id only, not SGEs
+ *
+ * Return 0 if no RWQE is available, otherwise return 1.
+ *
+ * Called at interrupt level with the QP r_rq.lock held.
+ */
+int ipath_get_rwqe(struct ipath_qp *qp, int wr_id_only)
+{
+	struct ipath_rq *rq;
+	struct ipath_srq *srq;
+	struct ipath_rwqe *wqe;
+
+	if (!qp->ibqp.srq) {
+		rq = &qp->r_rq;
+		if (unlikely(rq->tail == rq->head))
+			return 0;
+		wqe = get_rwqe_ptr(rq, rq->tail);
+		qp->r_wr_id = wqe->wr_id;
+		if (!wr_id_only) {
+			qp->r_sge.sge = wqe->sg_list[0];
+			qp->r_sge.sg_list = wqe->sg_list + 1;
+			qp->r_sge.num_sge = wqe->num_sge;
+			qp->r_len = wqe->length;
+		}
+		if (++rq->tail >= rq->size)
+			rq->tail = 0;
+		return 1;
+	}
+
+	srq = to_isrq(qp->ibqp.srq);
+	rq = &srq->rq;
+	spin_lock(&rq->lock);
+	if (unlikely(rq->tail == rq->head)) {
+		spin_unlock(&rq->lock);
+		return 0;
+	}
+	wqe = get_rwqe_ptr(rq, rq->tail);
+	qp->r_wr_id = wqe->wr_id;
+	if (!wr_id_only) {
+		qp->r_sge.sge = wqe->sg_list[0];
+		qp->r_sge.sg_list = wqe->sg_list + 1;
+		qp->r_sge.num_sge = wqe->num_sge;
+		qp->r_len = wqe->length;
+	}
+	if (++rq->tail >= rq->size)
+		rq->tail = 0;
+	if (srq->ibsrq.event_handler) {
+		struct ib_event ev;
+		u32 n;
+
+		if (rq->head < rq->tail)
+			n = rq->size + rq->head - rq->tail;
+		else
+			n = rq->head - rq->tail;
+		if (n < srq->limit) {
+			srq->limit = 0;
+			spin_unlock(&rq->lock);
+			ev.device = qp->ibqp.device;
+			ev.element.srq = qp->ibqp.srq;
+			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
+			srq->ibsrq.event_handler(&ev,
+						 srq->ibsrq.srq_context);
+		} else
+			spin_unlock(&rq->lock);
+	} else
+		spin_unlock(&rq->lock);
+	return 1;
+}
+
+/**
+ * ipath_ruc_loopback - handle UC and RC lookback requests
+ * @sqp: the loopback QP
+ * @wc: the work completion entry
+ *
+ * This is called from ipath_do_uc_send() or ipath_do_rc_send() to
+ * forward a WQE addressed to the same HCA.
+ * Note that although we are single threaded due to the tasklet, we still
+ * have to protect against post_send().  We don't have to worry about
+ * receive interrupts since this is a connected protocol and all packets
+ * will pass through here.
+ */
+void ipath_ruc_loopback(struct ipath_qp *sqp, struct ib_wc *wc)
+{
+	struct ipath_ibdev *dev = to_idev(sqp->ibqp.device);
+	struct ipath_qp *qp;
+	struct ipath_swqe *wqe;
+	struct ipath_sge *sge;
+	unsigned long flags;
+	u64 sdata;
+
+	qp = ipath_lookup_qpn(&dev->qp_table, sqp->remote_qpn);
+	if (!qp) {
+		dev->n_pkt_drops++;
+		return;
+	}
+
+again:
+	spin_lock_irqsave(&sqp->s_lock, flags);
+
+	if (!(ib_ipath_state_ops[sqp->state] & IPATH_PROCESS_SEND_OK)) {
+		spin_unlock_irqrestore(&sqp->s_lock, flags);
+		goto done;
+	}
+
+	/* Get the next send request. */
+	if (sqp->s_last == sqp->s_head) {
+		/* Send work queue is empty. */
+		spin_unlock_irqrestore(&sqp->s_lock, flags);
+		goto done;
+	}
+
+	/*
+	 * We can rely on the entry not changing without the s_lock
+	 * being held until we update s_last.
+	 */
+	wqe = get_swqe_ptr(sqp, sqp->s_last);
+	spin_unlock_irqrestore(&sqp->s_lock, flags);
+
+	wc->wc_flags = 0;
+	wc->imm_data = 0;
+
+	sqp->s_sge.sge = wqe->sg_list[0];
+	sqp->s_sge.sg_list = wqe->sg_list + 1;
+	sqp->s_sge.num_sge = wqe->wr.num_sge;
+	sqp->s_len = wqe->length;
+	switch (wqe->wr.opcode) {
+	case IB_WR_SEND_WITH_IMM:
+		wc->wc_flags = IB_WC_WITH_IMM;
+		wc->imm_data = wqe->wr.imm_data;
+		/* FALLTHROUGH */
+	case IB_WR_SEND:
+		spin_lock_irqsave(&qp->r_rq.lock, flags);
+		if (!ipath_get_rwqe(qp, 0)) {
+		rnr_nak:
+			spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+			/* Handle RNR NAK */
+			if (qp->ibqp.qp_type == IB_QPT_UC)
+				goto send_comp;
+			if (sqp->s_rnr_retry == 0) {
+				wc->status = IB_WC_RNR_RETRY_EXC_ERR;
+				goto err;
+			}
+			if (sqp->s_rnr_retry_cnt < 7)
+				sqp->s_rnr_retry--;
+			dev->n_rnr_naks++;
+			sqp->s_rnr_timeout =
+				ib_ipath_rnr_table[sqp->s_min_rnr_timer];
+			ipath_insert_rnr_queue(sqp);
+			goto done;
+		}
+		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+		break;
+
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		wc->wc_flags = IB_WC_WITH_IMM;
+		wc->imm_data = wqe->wr.imm_data;
+		spin_lock_irqsave(&qp->r_rq.lock, flags);
+		if (!ipath_get_rwqe(qp, 1))
+			goto rnr_nak;
+		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+		/* FALLTHROUGH */
+	case IB_WR_RDMA_WRITE:
+		if (wqe->length == 0)
+			break;
+		if (unlikely(!ipath_rkey_ok(dev, &qp->r_sge, wqe->length,
+					    wqe->wr.wr.rdma.remote_addr,
+					    wqe->wr.wr.rdma.rkey,
+					    IB_ACCESS_REMOTE_WRITE))) {
+		acc_err:
+			wc->status = IB_WC_REM_ACCESS_ERR;
+		err:
+			wc->wr_id = wqe->wr.wr_id;
+			wc->opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
+			wc->vendor_err = 0;
+			wc->byte_len = 0;
+			wc->qp_num = sqp->ibqp.qp_num;
+			wc->src_qp = sqp->remote_qpn;
+			wc->pkey_index = 0;
+			wc->slid = sqp->remote_ah_attr.dlid;
+			wc->sl = sqp->remote_ah_attr.sl;
+			wc->dlid_path_bits = 0;
+			wc->port_num = 0;
+			ipath_sqerror_qp(sqp, wc);
+			goto done;
+		}
+		break;
+
+	case IB_WR_RDMA_READ:
+		if (unlikely(!ipath_rkey_ok(dev, &sqp->s_sge, wqe->length,
+					    wqe->wr.wr.rdma.remote_addr,
+					    wqe->wr.wr.rdma.rkey,
+					    IB_ACCESS_REMOTE_READ)))
+			goto acc_err;
+		if (unlikely(!(qp->qp_access_flags &
+			       IB_ACCESS_REMOTE_READ)))
+			goto acc_err;
+		qp->r_sge.sge = wqe->sg_list[0];
+		qp->r_sge.sg_list = wqe->sg_list + 1;
+		qp->r_sge.num_sge = wqe->wr.num_sge;
+		break;
+
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		if (unlikely(!ipath_rkey_ok(dev, &qp->r_sge, sizeof(u64),
+					    wqe->wr.wr.rdma.remote_addr,
+					    wqe->wr.wr.rdma.rkey,
+					    IB_ACCESS_REMOTE_ATOMIC)))
+			goto acc_err;
+		/* Perform atomic OP and save result. */
+		sdata = wqe->wr.wr.atomic.swap;
+		spin_lock_irqsave(&dev->pending_lock, flags);
+		qp->r_atomic_data = *(u64 *) qp->r_sge.sge.vaddr;
+		if (wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
+			*(u64 *) qp->r_sge.sge.vaddr =
+				qp->r_atomic_data + sdata;
+		else if (qp->r_atomic_data == wqe->wr.wr.atomic.compare_add)
+			*(u64 *) qp->r_sge.sge.vaddr = sdata;
+		spin_unlock_irqrestore(&dev->pending_lock, flags);
+		*(u64 *) sqp->s_sge.sge.vaddr = qp->r_atomic_data;
+		goto send_comp;
+
+	default:
+		goto done;
+	}
+
+	sge = &sqp->s_sge.sge;
+	while (sqp->s_len) {
+		u32 len = sqp->s_len;
+
+		if (len > sge->length)
+			len = sge->length;
+		BUG_ON(len == 0);
+		ipath_copy_sge(&qp->r_sge, sge->vaddr, len);
+		sge->vaddr += len;
+		sge->length -= len;
+		sge->sge_length -= len;
+		if (sge->sge_length == 0) {
+			if (--sqp->s_sge.num_sge)
+				*sge = *sqp->s_sge.sg_list++;
+		} else if (sge->length == 0 && sge->mr != NULL) {
+			if (++sge->n >= IPATH_SEGSZ) {
+				if (++sge->m >= sge->mr->mapsz)
+					break;
+				sge->n = 0;
+			}
+			sge->vaddr =
+				sge->mr->map[sge->m]->segs[sge->n].vaddr;
+			sge->length =
+				sge->mr->map[sge->m]->segs[sge->n].length;
+		}
+		sqp->s_len -= len;
+	}
+
+	if (wqe->wr.opcode == IB_WR_RDMA_WRITE ||
+	    wqe->wr.opcode == IB_WR_RDMA_READ)
+		goto send_comp;
+
+	if (wqe->wr.opcode == IB_WR_RDMA_WRITE_WITH_IMM)
+		wc->opcode = IB_WC_RECV_RDMA_WITH_IMM;
+	else
+		wc->opcode = IB_WC_RECV;
+	wc->wr_id = qp->r_wr_id;
+	wc->status = IB_WC_SUCCESS;
+	wc->vendor_err = 0;
+	wc->byte_len = wqe->length;
+	wc->qp_num = qp->ibqp.qp_num;
+	wc->src_qp = qp->remote_qpn;
+	/* XXX do we know which pkey matched? Only needed for GSI. */
+	wc->pkey_index = 0;
+	wc->slid = qp->remote_ah_attr.dlid;
+	wc->sl = qp->remote_ah_attr.sl;
+	wc->dlid_path_bits = 0;
+	/* Signal completion event if the solicited bit is set. */
+	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), wc,
+		       wqe->wr.send_flags & IB_SEND_SOLICITED);
+
+send_comp:
+	sqp->s_rnr_retry = sqp->s_rnr_retry_cnt;
+
+	if (!test_bit(IPATH_S_SIGNAL_REQ_WR, &sqp->s_flags) ||
+	    (wqe->wr.send_flags & IB_SEND_SIGNALED)) {
+		wc->wr_id = wqe->wr.wr_id;
+		wc->status = IB_WC_SUCCESS;
+		wc->opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
+		wc->vendor_err = 0;
+		wc->byte_len = wqe->length;
+		wc->qp_num = sqp->ibqp.qp_num;
+		wc->src_qp = 0;
+		wc->pkey_index = 0;
+		wc->slid = 0;
+		wc->sl = 0;
+		wc->dlid_path_bits = 0;
+		wc->port_num = 0;
+		ipath_cq_enter(to_icq(sqp->ibqp.send_cq), wc, 0);
+	}
+
+	/* Update s_last now that we are finished with the SWQE */
+	spin_lock_irqsave(&sqp->s_lock, flags);
+	if (++sqp->s_last >= sqp->s_size)
+		sqp->s_last = 0;
+	spin_unlock_irqrestore(&sqp->s_lock, flags);
+	goto again;
+
+done:
+	if (atomic_dec_and_test(&qp->refcount))
+		wake_up(&qp->wait);
+}
+
+/**
+ * ipath_no_bufs_available - tell the layer driver we need buffers
+ * @qp: the QP that caused the problem
+ * @dev: the device we ran out of buffers on
+ *
+ * Called when we run out of PIO buffers.
+ */
+void ipath_no_bufs_available(struct ipath_qp *qp, struct ipath_ibdev *dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->pending_lock, flags);
+	if (qp->piowait.next == LIST_POISON1)
+		list_add_tail(&qp->piowait, &dev->piowait);
+	spin_unlock_irqrestore(&dev->pending_lock, flags);
+	/*
+	 * Note that as soon as ipath_layer_want_buffer() is called and
+	 * possibly before it returns, ipath_ib_piobufavail()
+	 * could be called.  If we are still in the tasklet function,
+	 * tasklet_hi_schedule() will not call us until the next time
+	 * tasklet_hi_schedule() is called.
+	 * We clear the tasklet flag now since we are committing to return
+	 * from the tasklet function.
+	 */
+	clear_bit(IPATH_S_BUSY, &qp->s_flags);
+	tasklet_unlock(&qp->s_task);
+	ipath_layer_want_buffer(dev->dd);
+	dev->n_piowait++;
+}
+
+/**
+ * ipath_post_rc_send - post RC and UC sends
+ * @qp: the QP to post on
+ * @wr: the work request to send
+ */
+int ipath_post_rc_send(struct ipath_qp *qp, struct ib_send_wr *wr)
+{
+	struct ipath_swqe *wqe;
+	unsigned long flags;
+	u32 next;
+	int i, j;
+	int acc;
+
+	/*
+	 * Don't allow RDMA reads or atomic operations on UC or
+	 * undefined operations.
+	 * Make sure buffer is large enough to hold the result for atomics.
+	 */
+	if (qp->ibqp.qp_type == IB_QPT_UC) {
+		if ((unsigned) wr->opcode >= IB_WR_RDMA_READ)
+			return -EINVAL;
+	} else if ((unsigned) wr->opcode > IB_WR_ATOMIC_FETCH_AND_ADD)
+		return -EINVAL;
+	else if (wr->opcode >= IB_WR_ATOMIC_CMP_AND_SWP &&
+		 (wr->num_sge == 0 || wr->sg_list[0].length < sizeof(u64) ||
+		  wr->sg_list[0].addr & (sizeof(u64) - 1)))
+		return -EINVAL;
+
+	/* IB spec says that num_sge == 0 is OK. */
+	if (wr->num_sge > qp->s_max_sge)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	next = qp->s_head + 1;
+	if (next >= qp->s_size)
+		next = 0;
+	if (next == qp->s_last) {
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		return -EINVAL;
+	}
+
+	wqe = get_swqe_ptr(qp, qp->s_head);
+	wqe->wr = *wr;
+	wqe->ssn = qp->s_ssn++;
+	wqe->sg_list[0].mr = NULL;
+	wqe->sg_list[0].vaddr = NULL;
+	wqe->sg_list[0].length = 0;
+	wqe->sg_list[0].sge_length = 0;
+	wqe->length = 0;
+	acc = wr->opcode >= IB_WR_RDMA_READ ? IB_ACCESS_LOCAL_WRITE : 0;
+	for (i = 0, j = 0; i < wr->num_sge; i++) {
+		if (to_ipd(qp->ibqp.pd)->user && wr->sg_list[i].lkey == 0) {
+			spin_unlock_irqrestore(&qp->s_lock, flags);
+			return -EINVAL;
+		}
+		if (wr->sg_list[i].length == 0)
+			continue;
+		if (!ipath_lkey_ok(&to_idev(qp->ibqp.device)->lk_table,
+				   &wqe->sg_list[j], &wr->sg_list[i],
+				   acc)) {
+			spin_unlock_irqrestore(&qp->s_lock, flags);
+			return -EINVAL;
+		}
+		wqe->length += wr->sg_list[i].length;
+		j++;
+	}
+	wqe->wr.num_sge = j;
+	qp->s_head = next;
+	/*
+	 * Wake up the send tasklet if the QP is not waiting
+	 * for an RNR timeout.
+	 */
+	next = qp->s_rnr_timeout;
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+
+	if (next == 0) {
+		if (qp->ibqp.qp_type == IB_QPT_UC)
+			ipath_do_uc_send((unsigned long) qp);
+		else
+			ipath_do_rc_send((unsigned long) qp);
+	}
+	return 0;
+}

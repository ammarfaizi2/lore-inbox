Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVLPXtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVLPXtk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVLPXti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:49:38 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:23836 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S964834AbVLPXt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:49:27 -0500
Subject: [PATCH 12/13]  [RFC] ipath verbs MAD handling
In-Reply-To: <200512161548.mhIvDiba3wkjPaMc@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 16 Dec 2005 15:48:55 -0800
Message-Id: <200512161548.MdcxE8ZQTy1yj4v1@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 23:48:57.0667 (UTC) FILETIME=[47EF0130:01C6029B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAD handling for ipath verbs driver

---

 drivers/infiniband/hw/ipath/ipath_mad.c | 1020 +++++++++++++++++++++++++++++++
 1 files changed, 1020 insertions(+), 0 deletions(-)
 create mode 100644 drivers/infiniband/hw/ipath/ipath_mad.c

21556dcebce3886215a02ff1b730a60beea53125
diff --git a/drivers/infiniband/hw/ipath/ipath_mad.c b/drivers/infiniband/hw/ipath/ipath_mad.c
new file mode 100644
index 0000000..361c7fb
--- /dev/null
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c
@@ -0,0 +1,1020 @@
+/*
+ * Copyright (c) 2005. PathScale, Inc. All rights reserved.
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
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ *
+ * $Id: ipath_mad.c 4491 2005-12-15 22:20:31Z rjwalsh $
+ */
+
+#include <linux/version.h>
+#include <rdma/ib_smi.h>
+
+#include "ips_common.h"
+#include "ipath_verbs.h"
+#include "ipath_layer.h"
+
+
+#define IB_SMP_INVALID_FIELD	__constant_htons(0x001C)
+
+static int reply(struct ib_smp *smp, int line)
+{
+
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
+static inline int recv_subn_get_nodedescription(struct ib_smp *smp)
+{
+
+	strncpy(smp->data, "Infinipath", sizeof(smp->data));
+
+	return reply(smp, __LINE__);
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
+/*
+ * XXX The num_ports value will need a layer function to get the value
+ * if we ever have more than one IB port on a chip.
+ * We will also need to get the GUID for the port.
+ */
+static inline int recv_subn_get_nodeinfo(struct ib_smp *smp,
+					 struct ib_device *ibdev, u8 port)
+{
+	struct nodeinfo *nip = (struct nodeinfo *)&smp->data;
+	ipath_type t = to_idev(ibdev)->ib_unit;
+	uint32_t vendor, boardid, majrev, minrev;
+
+	nip->base_version = 1;
+	nip->class_version = 1;
+	nip->node_type = 1;	/* channel adapter */
+	nip->num_ports = 1;
+	/* This is already in network order */
+	nip->sys_guid = to_idev(ibdev)->sys_image_guid;
+	nip->node_guid = ipath_layer_get_guid(t);
+	nip->port_guid = nip->sys_guid;
+	nip->partition_cap = cpu_to_be16(ipath_layer_get_npkeys(t));
+	nip->device_id = cpu_to_be16(ipath_layer_get_deviceid(t));
+	ipath_layer_query_device(t, &vendor, &boardid, &majrev, &minrev);
+	nip->revision = cpu_to_be32((majrev << 16) | minrev);
+	nip->local_port_num = port;
+	nip->vendor_id[0] = 0;
+	nip->vendor_id[1] = vendor >> 8;
+	nip->vendor_id[2] = vendor;
+
+	return reply(smp, __LINE__);
+}
+
+static int recv_subn_get_guidinfo(struct ib_smp *smp, struct ib_device *ibdev)
+{
+	uint32_t t = to_idev(ibdev)->ib_unit;
+	u32 startgx = 8 * be32_to_cpu(smp->attr_mod);
+	u64 *p = (u64 *) smp->data;
+
+	/* 32 blocks of 8 64-bit GUIDs per block */
+
+	memset(smp->data, 0, sizeof(smp->data));
+
+	/*
+	 * We only support one GUID for now.
+	 * If this changes, the portinfo.guid_cap field needs to be updated too.
+	 */
+	if (startgx == 0) {
+		/* The first is a copy of the read-only HW GUID. */
+		*p = ipath_layer_get_guid(t);
+	}
+
+	return reply(smp, __LINE__);
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
+	u8 mkeyprot_resv_lmc;			/* 2 bits, 3 bits, 3 bits */
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
+	u8 clientrereg_resv_subnetto;		/* 1 bit, 2 bits, 5 bits */
+	u8 resv_resptimevalue;			/* 3 bits, 5 bits */
+	u8 localphyerrors_overrunerrors;	/* 4 bits, 4 bits */
+	__be16 max_credit_hint;
+	u8 resv;
+	u8 link_roundtrip_latency[3];
+} __attribute__ ((packed));
+
+static int recv_subn_get_portinfo(struct ib_smp *smp, struct ib_device *ibdev,
+				  u8 port)
+{
+	u32 lportnum = be32_to_cpu(smp->attr_mod);
+	struct ipath_ibdev *dev;
+	struct port_info *pip = (struct port_info *)smp->data;
+	u32 tmp, tmp2;
+
+	if (lportnum == 0) {
+		lportnum = port;
+		smp->attr_mod = cpu_to_be32(lportnum);
+	}
+
+	if (lportnum < 1 || lportnum > ibdev->phys_port_cnt)
+		return IB_MAD_RESULT_FAILURE;
+
+	dev = to_idev(ibdev);
+
+	/* Clear all fields.  Only set the non-zero fields. */
+	memset(smp->data, 0, sizeof(smp->data));
+
+	/* Only return the mkey if the protection field allows it. */
+	if ((dev->mkeyprot_resv_lmc >> 6) == 0)
+		pip->mkey = dev->mkey;
+	else
+		pip->mkey = 0;
+	pip->gid_prefix = dev->gid_prefix;
+	tmp = ipath_layer_get_lid(dev->ib_unit);
+	pip->lid = tmp ? cpu_to_be16(tmp) : IB_LID_PERMISSIVE;
+	pip->sm_lid = cpu_to_be16(dev->sm_lid);
+	pip->cap_mask = cpu_to_be32(dev->port_cap_flags);
+	/* pip->diag_code; */
+	pip->mkey_lease_period = cpu_to_be16(dev->mkey_lease_period);
+	pip->local_port_num = port;
+	pip->link_width_enabled = 2;	/* 4x */
+	pip->link_width_supported = 3;	/* 1x or 4x */
+	pip->link_width_active = 2;	/* 4x */
+	pip->linkspeed_portstate = 0x10;	/* 2.5Gbps */
+	tmp = ipath_layer_get_lastibcstat(dev->ib_unit) & 0xff;
+	tmp2 = 5;		/* link up */
+	if (tmp == 0x11)
+		pip->linkspeed_portstate |= 2;	/* initialize */
+	else if (tmp == 0x21)
+		pip->linkspeed_portstate |= 3;	/* armed */
+	else if (tmp == 0x31)
+		pip->linkspeed_portstate |= 4;	/* active */
+	else {
+		pip->linkspeed_portstate |= 1;	/* down */
+		tmp2 = tmp & 0xf;
+	}
+	/* default state is polling */
+	pip->portphysstate_linkdown = (tmp2 << 4) | 2;
+	pip->mkeyprot_resv_lmc = dev->mkeyprot_resv_lmc;
+	pip->linkspeedactive_enabled = 0x11;	/* 2.5Gbps, 2.5Gbps */
+	switch (ipath_layer_get_ibmtu(dev->ib_unit)) {
+	case 4096:
+		tmp = IB_MTU_4096;
+		break;
+	case 2048:
+		tmp = IB_MTU_2048;
+		break;
+	case 1024:
+		tmp = IB_MTU_1024;
+		break;
+	case 512:
+		tmp = IB_MTU_512;
+		break;
+	case 256:
+		tmp = IB_MTU_256;
+		break;
+	default:		/* oops, something is wrong */
+		tmp = IB_MTU_2048;
+		break;
+	}
+	pip->neighbormtu_mastersmsl = (tmp << 4) | dev->sm_sl;
+	pip->vlcap_inittype = 0x10;	/* VLCap = VL0, InitType = 0 */
+	/* pip->vl_high_limit; // only one VL */
+	/* pip->vl_arb_high_cap; // only one VL */
+	/* pip->vl_arb_low_cap; // only one VL */
+	pip->inittypereply_mtucap = IB_MTU_4096;	/* InitTypeReply = 0 */
+	/* pip->vlstallcnt_hoqlife; // HCAs ignore VLStallCount and HOQLife */
+	pip->operationalvl_pei_peo_fpi_fpo = 0x18;	/* OVLs = 1, PEI = 1 */
+	pip->mkey_violations = cpu_to_be16(dev->mkey_violations);
+	/* P_KeyViolations are counted by hardware. */
+	tmp = ipath_layer_get_cr_errpkey(dev->ib_unit) & 0xFFFF;
+	pip->pkey_violations = cpu_to_be16(tmp);
+	pip->qkey_violations = cpu_to_be16(dev->qkey_violations);
+	/* Only the hardware GUID is supported for now */
+	pip->guid_cap = 1;
+	pip->clientrereg_resv_subnetto = dev->subnet_timeout;
+	/* 32.768 usec. response time (guessing) */
+	pip->resv_resptimevalue = 3;
+	/* LocalPhyErrors=max, OverRunErrors=max */
+	pip->localphyerrors_overrunerrors = 0xFF;
+	/* pip->max_credit_hint; */
+	/* pip->link_roundtrip_latency[3]; */
+
+	return reply(smp, __LINE__);
+}
+
+static int recv_subn_get_pkeytable(struct ib_smp *smp, struct ib_device *ibdev)
+{
+	u32 startpx = 32 * (be32_to_cpu(smp->attr_mod) & 0xffff);
+	u16 *p = (u16 *) smp->data;
+
+	/* 64 blocks of 32 16-bit P_Key entries */
+
+	memset(smp->data, 0, sizeof(smp->data));
+	if (startpx == 0)
+		ipath_layer_get_pkeys(to_idev(ibdev)->ib_unit, p);
+	else
+		smp->status |= IB_SMP_INVALID_FIELD;
+
+	return reply(smp, __LINE__);
+}
+
+static inline int recv_subn_set_guidinfo(struct ib_smp *smp,
+					 struct ib_device *ibdev)
+{
+	/* The only GUID we support is the first read-only entry. */
+	return recv_subn_get_guidinfo(smp, ibdev);
+}
+
+static inline int recv_subn_set_portinfo(struct ib_smp *smp,
+					 struct ib_device *ibdev, u8 port)
+{
+	struct port_info *pip = (struct port_info *)smp->data;
+	uint32_t lportnum = be32_to_cpu(smp->attr_mod);
+	struct ib_event event;
+	struct ipath_ibdev *dev;
+	uint32_t flags;
+	char clientrereg = 0;
+	u32 tmp;
+	u32 tmp2;
+	int ret;
+
+	if (lportnum == 0) {
+		lportnum = port;
+		smp->attr_mod = cpu_to_be32(lportnum);
+	}
+
+	if (lportnum < 1 || lportnum > ibdev->phys_port_cnt)
+		return IB_MAD_RESULT_FAILURE;
+
+	dev = to_idev(ibdev);
+	event.device = ibdev;
+	event.element.port_num = port;
+
+	if (dev->mkey != pip->mkey)
+		dev->mkey = pip->mkey;
+
+	if (pip->gid_prefix != dev->gid_prefix)
+		dev->gid_prefix = pip->gid_prefix;
+
+	tmp = be16_to_cpu(pip->lid);
+	if (tmp != ipath_layer_get_lid(dev->ib_unit)) {
+		ipath_set_sps_lid(dev->ib_unit, tmp);
+		event.event = IB_EVENT_LID_CHANGE;
+		ib_dispatch_event(&event);
+	}
+
+	tmp = be16_to_cpu(pip->sm_lid);
+	if (tmp != dev->sm_lid) {
+		dev->sm_lid = tmp;
+		event.event = IB_EVENT_SM_CHANGE;
+		ib_dispatch_event(&event);
+	}
+
+	dev->mkey_lease_period = be16_to_cpu(pip->mkey_lease_period);
+
+#if 0
+	tmp = pip->link_width_enabled;
+	if (tmp && (tmp != lpp->linkwidthenabled)) {
+		lpp->linkwidthenabled = tmp;
+		/* JAG - notify driver here */
+	}
+#endif
+
+	tmp = pip->linkspeed_portstate & 0xF;
+	flags = ipath_layer_get_flags(dev->ib_unit);
+	if (flags & IPATH_LINKDOWN)
+		tmp2 = IB_PORT_DOWN;
+	else if (flags & IPATH_LINKINIT)
+		tmp2 = IB_PORT_INIT;
+	else if (flags & IPATH_LINKARMED)
+		tmp2 = IB_PORT_ARMED;
+	else if (flags & IPATH_LINKACTIVE)
+		tmp2 = IB_PORT_ACTIVE;
+	else
+		tmp2 = IB_PORT_NOP;
+	if (tmp && tmp != tmp2) {
+		switch (tmp) {
+		case IB_PORT_DOWN:
+		case IB_PORT_INIT:
+			ipath_kset_linkstate(dev->ib_unit << 16 |
+					     IPATH_IB_LINKDOWN);
+			if (tmp2 == IB_PORT_ACTIVE) {
+				event.event = IB_EVENT_PORT_ERR;
+				ib_dispatch_event(&event);
+			}
+			break;
+
+		case IB_PORT_ARMED:
+			ipath_kset_linkstate(dev->ib_unit << 16 |
+					     IPATH_IB_LINKARM);
+			if (tmp2 == IB_PORT_ACTIVE) {
+				event.event = IB_EVENT_PORT_ERR;
+				ib_dispatch_event(&event);
+			}
+			break;
+
+		case IB_PORT_ACTIVE:
+			ipath_kset_linkstate(dev->ib_unit << 16 |
+					     IPATH_IB_LINKACTIVE);
+			event.event = IB_EVENT_PORT_ACTIVE;
+			ib_dispatch_event(&event);
+			break;
+
+		default:
+			/* XXX We have already partially updated our state! */
+			return IB_MAD_RESULT_FAILURE;
+		}
+	}
+#if 0
+	tmp = BF_GET(g.madp, iba_Subn_PortInfo, FIELD_PortPhysicalState);
+	if (tmp && (tmp != lpp->portphysicalstate)) {
+		lpp->portphysicalstate = tmp;
+		/* JAG - notify driver here */
+	}
+
+	tmp = BF_GET(g.madp, iba_Subn_PortInfo, FIELD_LinkDownDefaultState);
+	if (tmp && (tmp != lpp->linkdowndefaultstate)) {
+		lpp->linkdowndefaultstate = tmp;
+		/* JAG - notify driver here */
+	}
+#endif
+
+	dev->mkeyprot_resv_lmc = pip->mkeyprot_resv_lmc;
+
+#if 0
+	tmp = BF_GET(g.madp, iba_Subn_PortInfo, FIELD_LinkSpeedEnabled);
+	if (tmp && (tmp != lpp->linkspeedenabled)) {
+		lpp->linkspeedenabled = tmp;
+		/* JAG - notify driver here */
+	}
+#endif
+
+	tmp = (pip->neighbormtu_mastersmsl >> 4) & 0xF;
+	if (tmp) {
+		switch (tmp) {
+		case IB_MTU_256:
+			tmp2 = 256;
+			break;
+		case IB_MTU_512:
+			tmp2 = 512;
+			break;
+		case IB_MTU_1024:
+			tmp2 = 1024;
+			break;
+		case IB_MTU_2048:
+			tmp2 = 2048;
+			break;
+		case IB_MTU_4096:
+			tmp2 = 4096;
+			break;
+		default:
+			/* XXX We have already partially updated our state! */
+			return IB_MAD_RESULT_FAILURE;
+		}
+
+		ipath_kset_mtu(dev->ib_unit << 16 | tmp2);
+	}
+
+	dev->sm_sl = pip->neighbormtu_mastersmsl & 0xF;
+
+#if 0
+	tmp = BF_GET(g.madp, iba_Subn_PortInfo, FIELD_VLHighLimit);
+	if (tmp != lpp->vlhighlimit) {
+		lpp->vlhighlimit = tmp;
+		/* JAG - notify driver here */
+	}
+
+	lpp->inittypereply =
+	    BF_GET(g.madp, iba_Subn_PortInfo, FIELD_InitTypeReply);
+
+	tmp = BF_GET(g.madp, iba_Subn_PortInfo, FIELD_OperationalVLs);
+	if (tmp && (tmp != lpp->operationalvls)) {
+		lpp->operationalvls = tmp;
+		/* JAG - notify driver here */
+	}
+#endif
+
+	if (pip->mkey_violations != 0)
+		dev->mkey_violations = 0;
+#if 0
+	/* XXX Hardware counter can't be reset. */
+	if (pip->pkey_violations != 0)
+		dev->pkey_violations = 0;
+#endif
+
+	if (pip->qkey_violations != 0)
+		dev->qkey_violations = 0;
+
+#if 0
+	tmp = BF_GET(g.madp, iba_Subn_PortInfo, FIELD_LocalPhyErrors);
+	if (tmp != lpp->localphyerrors) {
+		lpp->localphyerrors = tmp;
+		/* JAG - notify driver here */
+	}
+
+	tmp = BF_GET(g.madp, iba_Subn_PortInfo, FIELD_OverrunErrors);
+	if (tmp != lpp->overrunerrors) {
+		lpp->overrunerrors = tmp;
+		/* JAG - notify driver here */
+	}
+#endif
+
+	dev->subnet_timeout = pip->clientrereg_resv_subnetto & 0x1F;
+
+	if (pip->clientrereg_resv_subnetto & 0x80) {
+		clientrereg = 1;
+		event.event = IB_EVENT_LID_CHANGE;
+		ib_dispatch_event(&event);
+	}
+
+	ret = recv_subn_get_portinfo(smp, ibdev, port);
+
+	if (clientrereg)
+		pip->clientrereg_resv_subnetto |= 0x80;
+
+	return ret;
+}
+
+static inline int recv_subn_set_pkeytable(struct ib_smp *smp,
+					  struct ib_device *ibdev)
+{
+	u32 startpx = 32 * (be32_to_cpu(smp->attr_mod) & 0xffff);
+	u16 *p = (u16 *) smp->data;
+
+	if (startpx != 0 ||
+	    ipath_layer_set_pkeys(to_idev(ibdev)->ib_unit, p) != 0)
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
+static int recv_pma_get_classportinfo(struct ib_perf *pmp)
+{
+	/*
+	   struct ib_pma_classportinfo *p =
+	   (struct ib_pma_classportinfo *)pmp->data;
+	 */
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+
+	return reply((struct ib_smp *)pmp, __LINE__);
+}
+
+static int recv_pma_get_portsamplescontrol(struct ib_perf *pmp,
+					   struct ib_device *ibdev, u8 port)
+{
+	struct ib_pma_portsamplescontrol *p =
+	    (struct ib_pma_portsamplescontrol *)pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	unsigned long flags;
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+
+	p->port_select = port;
+	p->tick = 0xFA;		/* 1 ms. */
+	p->counter_width = 4;	/* 32 bit counters */
+	p->counter_mask0_9 = __constant_htonl(0x09248000); /* counters 0-4 */
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
+	return reply((struct ib_smp *)pmp, __LINE__);
+}
+
+static int recv_pma_set_portsamplescontrol(struct ib_perf *pmp,
+					   struct ib_device *ibdev, u8 port)
+{
+	struct ib_pma_portsamplescontrol *p =
+	    (struct ib_pma_portsamplescontrol *)pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	unsigned long flags;
+	u32 start = be32_to_cpu(p->sample_start);
+
+	if (pmp->attr_mod == 0 && p->port_select == port && start != 0) {
+		spin_lock_irqsave(&dev->pending_lock, flags);
+		if (dev->pma_sample_status == IB_PMA_SAMPLE_STATUS_DONE) {
+			dev->pma_sample_status = IB_PMA_SAMPLE_STATUS_STARTED;
+			dev->pma_sample_start = start;
+			dev->pma_sample_interval =
+			    be32_to_cpu(p->sample_interval);
+			dev->pma_tag = be16_to_cpu(p->tag);
+			if (p->counter_select[0])
+				dev->pma_counter_select[0] =
+				    p->counter_select[0];
+			if (p->counter_select[1])
+				dev->pma_counter_select[1] =
+				    p->counter_select[1];
+			if (p->counter_select[2])
+				dev->pma_counter_select[2] =
+				    p->counter_select[2];
+			if (p->counter_select[3])
+				dev->pma_counter_select[3] =
+				    p->counter_select[3];
+			if (p->counter_select[4])
+				dev->pma_counter_select[4] =
+				    p->counter_select[4];
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
+	default:
+		return 0;
+	}
+}
+
+static int recv_pma_get_portsamplesresult(struct ib_perf *pmp,
+					  struct ib_device *ibdev)
+{
+	struct ib_pma_portsamplesresult *p =
+	    (struct ib_pma_portsamplesresult *)pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	int i;
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+	p->tag = cpu_to_be16(dev->pma_tag);
+	p->sample_status = cpu_to_be16(dev->pma_sample_status);
+	for (i = 0; i < ARRAY_SIZE(dev->pma_counter_select); i++)
+		p->counter[i] =
+		    cpu_to_be32(get_counter(dev, dev->pma_counter_select[i]));
+
+	return reply((struct ib_smp *)pmp, __LINE__);
+}
+
+static int recv_pma_get_portsamplesresult_ext(struct ib_perf *pmp,
+					      struct ib_device *ibdev)
+{
+	struct ib_pma_portsamplesresult_ext *p =
+	    (struct ib_pma_portsamplesresult_ext *)pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	int i;
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+	p->tag = cpu_to_be16(dev->pma_tag);
+	p->sample_status = cpu_to_be16(dev->pma_sample_status);
+	p->extended_width = __constant_cpu_to_be16(0x80000000); /* 64 bits */
+	for (i = 0; i < ARRAY_SIZE(dev->pma_counter_select); i++)
+		p->counter[i] =
+		    cpu_to_be64(get_counter(dev, dev->pma_counter_select[i]));
+
+	return reply((struct ib_smp *)pmp, __LINE__);
+}
+
+static int recv_pma_get_portcounters(struct ib_perf *pmp,
+				     struct ib_device *ibdev, u8 port)
+{
+	struct ib_pma_portcounters *p = (struct ib_pma_portcounters *)pmp->data;
+	struct ipath_layer_counters cntrs;
+
+	ipath_layer_get_counters(to_idev(ibdev)->ib_unit, &cntrs);
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+	p->port_select = port;
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
+		p->port_rcv_errors = cpu_to_be16((u16)cntrs.port_rcv_errors);
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
+		p->port_rcv_packets = cpu_to_be32((u32)cntrs.port_rcv_packets);
+
+	return reply((struct ib_smp *)pmp, __LINE__);
+}
+
+static int recv_pma_get_portcounters_ext(struct ib_perf *pmp,
+					 struct ib_device *ibdev, u8 port)
+{
+	struct ib_pma_portcounters_ext *p =
+		(struct ib_pma_portcounters_ext *)pmp->data;
+	struct ipath_ibdev *dev = to_idev(ibdev);
+	u64 swords, rwords, spkts, rpkts;
+
+	ipath_layer_snapshot_counters(to_idev(ibdev)->ib_unit,
+				      &swords, &rwords, &spkts, &rpkts);
+
+	memset(pmp->data, 0, sizeof(pmp->data));
+	p->port_select = port;
+	p->port_xmit_data = cpu_to_be64(swords);
+	p->port_rcv_data = cpu_to_be64(rwords);
+	p->port_xmit_packets = cpu_to_be64(spkts);
+	p->port_rcv_packets = cpu_to_be64(rpkts);
+	p->port_unicast_xmit_packets =
+		cpu_to_be64(spkts - dev->n_multicast_xmit);
+	p->port_unicast_rcv_packets =
+		cpu_to_be64(rpkts - dev->n_multicast_rcv);
+	p->port_multicast_xmit_packets = cpu_to_be64(dev->n_multicast_xmit);
+	p->port_multicast_rcv_packets = cpu_to_be64(dev->n_multicast_rcv);
+
+	return reply((struct ib_smp *)pmp, __LINE__);
+}
+
+static int recv_pma_set_portcounters(struct ib_perf *pmp,
+				     struct ib_device *ibdev, u8 port)
+{
+	/* XXX HW counters can't be cleared. */
+	return recv_pma_get_portcounters(pmp, ibdev, port);
+}
+
+static int recv_pma_set_portcounters_ext(struct ib_perf *pmp,
+					 struct ib_device *ibdev, u8 port)
+{
+	/* XXX HW counters can't be cleared. */
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
+	/* Is the mkey in the process of expiring? */
+	if (dev->mkey_lease_timeout && jiffies >= dev->mkey_lease_timeout) {
+		dev->mkey_lease_timeout = 0;
+		dev->mkeyprot_resv_lmc &= 0x3F;
+	}
+
+	/*
+	 * M_Key checking depends on
+	 * Portinfo:M_Key_protect_bits
+	 */
+	if ((mad_flags & IB_MAD_IGNORE_MKEY) == 0 && dev->mkey != 0 &&
+	    dev->mkey != smp->mkey && (smp->method != IB_MGMT_METHOD_GET ||
+	     (dev->mkeyprot_resv_lmc >> 7) != 0)) {
+		if (dev->mkey_violations != 0xFFFF)
+			++dev->mkey_violations;
+		if (dev->mkey_lease_timeout || dev->mkey_lease_period == 0)
+			return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
+		dev->mkey_lease_timeout = jiffies + dev->mkey_lease_period * HZ;
+		/* Future: Generate a trap notice. */
+		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
+	}
+
+	*out_mad = *in_mad;
+	switch (smp->method) {
+	case IB_MGMT_METHOD_GET:
+		switch (smp->attr_id) {
+		case IB_SMP_ATTR_NODE_DESC:
+			return recv_subn_get_nodedescription(smp);
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
+		default:
+			break;
+		}
+		break;
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
+		default:
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+	return IB_MAD_RESULT_FAILURE;
+}
+
+static inline int process_perf(struct ib_device *ibdev, u8 port_num,
+			       struct ib_mad *in_mad, struct ib_mad *out_mad)
+{
+	struct ib_perf *pmp = (struct ib_perf *)out_mad;
+
+	*out_mad = *in_mad;
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
+			return recv_pma_get_portsamplesresult_ext(pmp, ibdev);
+
+		case IB_PMA_PORT_COUNTERS:
+			return recv_pma_get_portcounters(pmp, ibdev, port_num);
+
+		case IB_PMA_PORT_COUNTERS_EXT:
+			return recv_pma_get_portcounters_ext(pmp, ibdev,
+							     port_num);
+
+		default:
+			break;
+		}
+		break;
+
+	case IB_MGMT_METHOD_SET:
+		switch (pmp->attr_id) {
+		case IB_PMA_PORT_SAMPLES_CONTROL:
+			return recv_pma_set_portsamplescontrol(pmp, ibdev,
+							       port_num);
+
+		case IB_PMA_PORT_COUNTERS:
+			return recv_pma_set_portcounters(pmp, ibdev, port_num);
+
+		case IB_PMA_PORT_COUNTERS_EXT:
+			return recv_pma_set_portcounters_ext(pmp, ibdev,
+							     port_num);
+
+		default:
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+	return IB_MAD_RESULT_FAILURE;
+}
+
+/*
+ * Note that the verbs framework has already done the MAD sanity checks,
+ * and hop count/pointer updating for IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE MADs.
+ *
+ * Return IB_MAD_RESULT_SUCCESS if this is a MAD that we are not interested
+ * in processing.
+ */
+int ipath_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
+		      struct ib_wc *in_wc, struct ib_grh *in_grh,
+		      struct ib_mad *in_mad, struct ib_mad *out_mad)
+{
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
-- 
0.99.9n

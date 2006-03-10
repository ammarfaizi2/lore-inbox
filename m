Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWCJAjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWCJAjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbWCJAg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:36:59 -0500
Received: from mx.pathscale.com ([64.160.42.68]:13454 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752148AbWCJAfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:46 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 8 of 20] ipath - sysfs support for core driver
X-Mercurial-Node: 1123028ac13ac1de2457b3d2a6f349e2d2b573dc
Message-Id: <1123028ac13ac1de2457.1141950938@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:38 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r a9ed49ad489c -r 1123028ac13a drivers/infiniband/hw/ipath/ipath_sysfs.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Mar  9 16:15:57 2006 -0800
@@ -0,0 +1,950 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
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
+#include <linux/ctype.h>
+#include <linux/pci.h>
+
+#include "ipath_kernel.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+/**
+ * ipath_parse_ushort - parse an unsigned short value in an arbitrary base
+ * @str: the string containing the number
+ * @valp: where to put the result
+ *
+ * returns the number of bytes consumed, or negative value on error
+ */
+int ipath_parse_ushort(const char *str, unsigned short *valp)
+{
+	unsigned long val;
+	char *end;
+	int ret;
+
+	if (!isdigit(str[0]))
+		return -EINVAL;
+
+	val = simple_strtoul(str, &end, 0);
+
+	if (val > 0xffff)
+		return -EINVAL;
+
+	*valp = val;
+
+	ret = end + 1 - str;
+	if (ret == 0)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static ssize_t show_version(struct device_driver *dev, char *buf)
+{
+	/* The string printed here is already newline-terminated. */
+	return scnprintf(buf, PAGE_SIZE, "%s", ipath_core_version);
+}
+
+static ssize_t show_num_units(struct device_driver *dev, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 ipath_count_units(NULL, NULL, NULL));
+}
+
+#define DRIVER_STAT(name, attr) \
+	static ssize_t show_stat_##name(struct device_driver *dev, \
+					char *buf) \
+	{ \
+		return scnprintf( \
+			buf, PAGE_SIZE, "%llu\n", \
+			(unsigned long long) ipath_stats.sps_ ##attr); \
+	} \
+	static DRIVER_ATTR(name, S_IRUGO, show_stat_##name, NULL)
+
+DRIVER_STAT(intrs, ints);
+DRIVER_STAT(err_intrs, errints);
+DRIVER_STAT(errs, errs);
+DRIVER_STAT(pkt_errs, pkterrs);
+DRIVER_STAT(crc_errs, crcerrs);
+DRIVER_STAT(hw_errs, hwerrs);
+DRIVER_STAT(ib_link, iblink);
+DRIVER_STAT(port0_pkts, port0pkts);
+DRIVER_STAT(ether_spkts, ether_spkts);
+DRIVER_STAT(ether_rpkts, ether_rpkts);
+DRIVER_STAT(sma_spkts, sma_spkts);
+DRIVER_STAT(sma_rpkts, sma_rpkts);
+DRIVER_STAT(hdrq_full, hdrqfull);
+DRIVER_STAT(etid_full, etidfull);
+DRIVER_STAT(no_piobufs, nopiobufs);
+DRIVER_STAT(ports, ports);
+DRIVER_STAT(pkey0, pkeys[0]);
+DRIVER_STAT(pkey1, pkeys[1]);
+DRIVER_STAT(pkey2, pkeys[2]);
+DRIVER_STAT(pkey3, pkeys[3]);
+/* XXX fix the following when dynamic table of devices used */
+DRIVER_STAT(lid0, lid[0]);
+DRIVER_STAT(lid1, lid[1]);
+DRIVER_STAT(lid2, lid[2]);
+DRIVER_STAT(lid3, lid[3]);
+
+DRIVER_STAT(nports, nports);
+DRIVER_STAT(null_intr, nullintr);
+DRIVER_STAT(max_pkts_call, maxpkts_call);
+DRIVER_STAT(avg_pkts_call, avgpkts_call);
+DRIVER_STAT(page_locks, pagelocks);
+DRIVER_STAT(page_unlocks, pageunlocks);
+DRIVER_STAT(krdrops, krdrops);
+/* XXX fix the following when dynamic table of devices used */
+DRIVER_STAT(mlid0, mlid[0]);
+DRIVER_STAT(mlid1, mlid[1]);
+DRIVER_STAT(mlid2, mlid[2]);
+DRIVER_STAT(mlid3, mlid[3]);
+
+static struct attribute *driver_stat_attributes[] = {
+	&driver_attr_intrs.attr,
+	&driver_attr_err_intrs.attr,
+	&driver_attr_errs.attr,
+	&driver_attr_pkt_errs.attr,
+	&driver_attr_crc_errs.attr,
+	&driver_attr_hw_errs.attr,
+	&driver_attr_ib_link.attr,
+	&driver_attr_port0_pkts.attr,
+	&driver_attr_ether_spkts.attr,
+	&driver_attr_ether_rpkts.attr,
+	&driver_attr_sma_spkts.attr,
+	&driver_attr_sma_rpkts.attr,
+	&driver_attr_hdrq_full.attr,
+	&driver_attr_etid_full.attr,
+	&driver_attr_no_piobufs.attr,
+	&driver_attr_ports.attr,
+	&driver_attr_pkey0.attr,
+	&driver_attr_pkey1.attr,
+	&driver_attr_pkey2.attr,
+	&driver_attr_pkey3.attr,
+	&driver_attr_lid0.attr,
+	&driver_attr_lid1.attr,
+	&driver_attr_lid2.attr,
+	&driver_attr_lid3.attr,
+	&driver_attr_nports.attr,
+	&driver_attr_null_intr.attr,
+	&driver_attr_max_pkts_call.attr,
+	&driver_attr_avg_pkts_call.attr,
+	&driver_attr_page_locks.attr,
+	&driver_attr_page_unlocks.attr,
+	&driver_attr_krdrops.attr,
+	&driver_attr_mlid0.attr,
+	&driver_attr_mlid1.attr,
+	&driver_attr_mlid2.attr,
+	&driver_attr_mlid3.attr,
+	NULL
+};
+
+static struct attribute_group driver_stat_attr_group = {
+	.name = "stats",
+	.attrs = driver_stat_attributes
+};
+
+static ssize_t show_atomic_stats(struct device_driver *dev, char *buf)
+{
+	memcpy(buf, &ipath_stats, sizeof(ipath_stats));
+
+	return sizeof(ipath_stats);
+}
+
+static ssize_t show_status(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	if (!dd->ipath_statusp)
+		return -EINVAL;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%llx\n",
+			 (unsigned long long) *(dd->ipath_statusp));
+}
+
+static const char *ipath_status_str[] = {
+	"Initted",
+	"Disabled",
+	"4",			/* unused */
+	"OIB_SMA",
+	"SMA",
+	"Present",
+	"IB_link_up",
+	"IB_configured",
+	"NoIBcable",
+	"Fatal_Hardware_Error",
+	NULL,
+};
+
+static ssize_t show_status_str(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	int i, any;
+	u64 s;
+
+	if (!dd->ipath_statusp)
+		return -EINVAL;
+
+	s = *(dd->ipath_statusp);
+	*buf = '\0';
+	for (any = i = 0; s && ipath_status_str[i]; i++) {
+		if (s & 1) {
+			if (any && strlcat(buf, " ", PAGE_SIZE) >=
+			    PAGE_SIZE)
+				/* overflow */
+				break;
+			if (strlcat(buf, ipath_status_str[i],
+				    PAGE_SIZE) >= PAGE_SIZE)
+				break;
+			any = 1;
+		}
+		s >>= 1;
+	}
+	if (any)
+		strlcat(buf, "\n", PAGE_SIZE);
+
+	return strlen(buf);
+}
+
+static ssize_t show_boardversion(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	/* The string printed here is already newline-terminated. */
+	return scnprintf(buf, PAGE_SIZE, "%s", dd->ipath_boardversion);
+}
+
+static ssize_t show_node_info(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	static const size_t count = 10;
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	u32 *nodeinfo;
+	int ret;
+
+	if (!dd->ipath_statusp) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	nodeinfo = (u32 *) buf;
+
+	/* so we only initialize non-zero fields. */
+	memset(nodeinfo, 0, count * sizeof(u32));
+
+	nodeinfo[0] =		/* BaseVersion is SMA */
+		/* ClassVersion is SMA */
+		(1 << 8)		/* NodeType  */
+		|(1 << 0);		/* NumPorts */
+	nodeinfo[1] = (u32) (dd->ipath_guid >> 32);
+	nodeinfo[2] = (u32) (dd->ipath_guid & 0xffffffff);
+	/* PortGUID == SystemImageGUID for us */
+	nodeinfo[3] = nodeinfo[1];
+	/* PortGUID == SystemImageGUID for us */
+	nodeinfo[4] = nodeinfo[2];
+	/* PortGUID == NodeGUID for us */
+	nodeinfo[5] = nodeinfo[3];
+	/* PortGUID == NodeGUID for us */
+	nodeinfo[6] = nodeinfo[4];
+	nodeinfo[7] = (4 << 16)	/* we support 4 pkeys */
+		|(dd->ipath_deviceid << 0);
+	/* our chip version as 16 bits major, 16 bits minor */
+	nodeinfo[8] = dd->ipath_minrev | (dd->ipath_majrev << 16);
+	nodeinfo[9] = (dd->ipath_unit << 24) | (dd->ipath_vendorid << 0);
+
+	ret = count * sizeof(u32);
+bail:
+	return ret;
+}
+
+static ssize_t show_port_info(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	static const size_t count = 13;
+	int ret;
+	u32 tmp, tmp2;
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	u32 *portinfo;
+
+	if (!dd->ipath_statusp) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	portinfo = (u32 *) buf;
+
+	/* so we only initialize non-zero fields. */
+	memset(portinfo, 0, count * sizeof portinfo);
+
+	/*
+	 * Notimpl yet M_Key (64)
+	 * Notimpl yet GID (64)
+	 */
+
+	portinfo[4] = (dd->ipath_lid << 16);
+
+	/*
+	 * Notimpl yet SMLID (should we store this in the driver, in case
+	 * SMA dies?)  CapabilityMask is 0, we don't support any of these
+	 * DiagCode is 0; we don't store any diag info for now Notimpl yet
+	 * M_KeyLeasePeriod (we don't support M_Key)
+	 */
+
+	/* LocalPortNum is whichever port number they ask for */
+	portinfo[7] = (dd->ipath_unit << 24)
+		/* LinkWidthEnabled */
+		| (2 << 16)
+		/* LinkWidthSupported (really 2, but not IB valid) */
+		| (3 << 8)
+		/* LinkWidthActive */
+		| (2 << 0);
+	tmp = dd->ipath_lastibcstat & IPATH_IBSTATE_MASK;
+	tmp2 = 5;
+	if (tmp == IPATH_IBSTATE_INIT)
+		tmp = 2;
+	else if (tmp == IPATH_IBSTATE_ARM)
+		tmp = 3;
+	else if (tmp == IPATH_IBSTATE_ACTIVE)
+		tmp = 4;
+	else {
+		tmp = 0;	/* down */
+		tmp2 = tmp & 0xf;
+	}
+
+	portinfo[8] = (1 << 28)	/* LinkSpeedSupported */
+		|(tmp << 24)	/* PortState */
+		|(tmp2 << 20)	/* PortPhysicalState */
+		|(2 << 16)
+
+		/* LinkDownDefaultState */
+		/* M_KeyProtectBits == 0 */
+		/* NotImpl yet LMC == 0 (we can support all values) */
+		| (1 << 4)		/* LinkSpeedActive */
+		|(1 << 0);		/* LinkSpeedEnabled */
+	switch (dd->ipath_ibmtu) {
+	case 4096:
+		tmp = 5;
+		break;
+	case 2048:
+		tmp = 4;
+		break;
+	case 1024:
+		tmp = 3;
+		break;
+	case 512:
+		tmp = 2;
+		break;
+	case 256:
+		tmp = 1;
+		break;
+	default:		/* oops, something is wrong */
+		ipath_dbg("Problem, ipath_ibmtu 0x%x not a valid IB MTU, "
+			  "treat as 2048\n", dd->ipath_ibmtu);
+		tmp = 4;
+		break;
+	}
+	portinfo[9] = (tmp << 28)
+		/* NeighborMTU */
+		/* Notimpl MasterSMSL */
+		| (1 << 20)
+
+		/* VLCap */
+		/* Notimpl InitType (actually, an SMA decision) */
+		/* VLHighLimit is 0 (only one VL) */
+		; /* VLArbitrationHighCap is 0 (only one VL) */
+	portinfo[10] =		/* VLArbitrationLowCap is 0 (only one VL) */
+		/* InitTypeReply is SMA decision */
+		(5 << 16)		/* MTUCap 4096 */
+		|(7 << 13)		/* VLStallCount */
+		|(0x1f << 8)	/* HOQLife */
+		|(1 << 4)
+
+		/* OperationalVLs 0 */
+		/* PartitionEnforcementInbound */
+		/* PartitionEnforcementOutbound not enforced */
+		/* FilterRawinbound not enforced */
+		;			/* FilterRawOutbound not enforced */
+	/* M_KeyViolations are not counted by hardware, SMA can count */
+	tmp = ipath_read_creg32(dd, dd->ipath_cregs->cr_errpkey);
+	/* P_KeyViolations are counted by hardware. */
+	portinfo[11] = ((tmp & 0xffff) << 0);
+	portinfo[12] =
+		/* Q_KeyViolations are not counted by hardware */
+		(1 << 8)
+
+		/* GUIDCap */
+		/* SubnetTimeOut handled by SMA */
+		/* RespTimeValue handled by SMA */
+		;
+	/* LocalPhyErrors are programmed to max */
+	portinfo[12] |= (0xf << 20)
+		| (0xf << 16)	/* OverRunErrors are programmed to max */
+		;
+
+	ret = count * sizeof(u32);
+bail:
+	return ret;
+}
+
+static ssize_t show_lid(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", dd->ipath_lid);
+}
+
+static ssize_t store_lid(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	u16 lid;
+	int ret;
+
+	ret = ipath_parse_ushort(buf, &lid);
+	if (ret < 0)
+		goto invalid;
+
+	if (lid == 0 || lid >= 0xc000) {
+		ret = -EINVAL;
+		goto invalid;
+	}
+
+	ipath_set_sps_lid(dd, lid, 0);
+
+	goto bail;
+invalid:
+	dev_err(dev, "attempt to set invalid LID\n");
+bail:
+	return ret;
+}
+
+static ssize_t show_mlid(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", dd->ipath_mlid);
+}
+
+static ssize_t store_mlid(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	int unit;
+	u16 mlid;
+	int ret;
+
+	ret = ipath_parse_ushort(buf, &mlid);
+	if (ret < 0)
+		goto invalid;
+
+	unit = dd->ipath_unit;
+
+	dd->ipath_mlid = mlid;
+	ipath_stats.sps_mlid[unit] = mlid;
+	if (dd->ipath_layer.l_intr)
+		dd->ipath_layer.l_intr(unit, IPATH_LAYER_INT_BCAST);
+
+	goto bail;
+invalid:
+	dev_err(dev, "attempt to set invalid MLID\n");
+bail:
+	return ret;
+}
+
+static ssize_t show_guid(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	u8 *guid;
+
+	guid = (u8 *) & (dd->ipath_guid);
+
+	return scnprintf(buf, PAGE_SIZE,
+			 "%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+			 guid[0], guid[1], guid[2], guid[3],
+			 guid[4], guid[5], guid[6], guid[7]);
+}
+
+static ssize_t store_guid(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	ssize_t ret;
+	unsigned short guid[8];
+	u64 nguid;
+	u8 *ng;
+	int i;
+
+	if (sscanf(buf, "%hx:%hx:%hx:%hx:%hx:%hx:%hx:%hx",
+		   &guid[0], &guid[1], &guid[2], &guid[3],
+		   &guid[4], &guid[5], &guid[6], &guid[7]) != 8)
+		goto invalid;
+
+	ng = (u8 *) &nguid;
+
+	for (i = 0; i < 8; i++) {
+		if (guid[i] > 0xff)
+			goto invalid;
+		ng[i] = guid[i];
+	}
+
+	dd->ipath_guid = nguid;
+	dd->ipath_nguid = 1;
+
+	ret = strlen(buf);
+	goto bail;
+
+invalid:
+	dev_err(dev, "attempt to set invalid GUID\n");
+	ret = -EINVAL;
+
+bail:
+	return ret;
+}
+
+static ssize_t show_nguid(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_nguid);
+}
+
+static ssize_t show_serial(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	buf[sizeof dd->ipath_serial] = '\0';
+	memcpy(buf, dd->ipath_serial, sizeof dd->ipath_serial);
+	strcat(buf, "\n");
+	return strlen(buf);
+}
+
+static ssize_t show_unit(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_unit);
+}
+
+static ssize_t show_atomic_counters(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	u64 *ubuf = (u64 *) buf;
+	u64 val;
+	u16 i;
+
+	for (i = 0; i < sizeof(struct infinipath_counters) /
+		     sizeof(val); i++)
+		ubuf[i] = ipath_snap_cntr(dd, i);
+
+	return i * sizeof(val);
+}
+
+#define DEVICE_COUNTER(name, attr) \
+	static ssize_t show_counter_##name(struct device *dev, \
+					   struct device_attribute *attr, \
+					   char *buf) \
+	{ \
+		struct ipath_devdata *dd = dev_get_drvdata(dev); \
+		return scnprintf(\
+			buf, PAGE_SIZE, "%llu\n", (unsigned long long) \
+			ipath_snap_cntr( \
+				dd, offsetof(struct infinipath_counters, \
+					     attr) / sizeof(u64)));	\
+	} \
+	static DEVICE_ATTR(name, S_IRUGO, show_counter_##name, NULL);
+
+DEVICE_COUNTER(ib_link_downeds, IBLinkDownedCnt);
+DEVICE_COUNTER(ib_link_err_recoveries, IBLinkErrRecoveryCnt);
+DEVICE_COUNTER(ib_status_changes, IBStatusChangeCnt);
+DEVICE_COUNTER(ib_symbol_errs, IBSymbolErrCnt);
+DEVICE_COUNTER(lb_flow_stalls, LBFlowStallCnt);
+DEVICE_COUNTER(lb_ints, LBIntCnt);
+DEVICE_COUNTER(rx_bad_formats, RxBadFormatCnt);
+DEVICE_COUNTER(rx_buf_ovfls, RxBufOvflCnt);
+DEVICE_COUNTER(rx_data_pkts, RxDataPktCnt);
+DEVICE_COUNTER(rx_dropped_pkts, RxDroppedPktCnt);
+DEVICE_COUNTER(rx_dwords, RxDwordCnt);
+DEVICE_COUNTER(rx_ebps, RxEBPCnt);
+DEVICE_COUNTER(rx_flow_ctrl_errs, RxFlowCtrlErrCnt);
+DEVICE_COUNTER(rx_flow_pkts, RxFlowPktCnt);
+DEVICE_COUNTER(rx_icrc_errs, RxICRCErrCnt);
+DEVICE_COUNTER(rx_len_errs, RxLenErrCnt);
+DEVICE_COUNTER(rx_link_problems, RxLinkProblemCnt);
+DEVICE_COUNTER(rx_lpcrc_errs, RxLPCRCErrCnt);
+DEVICE_COUNTER(rx_max_min_len_errs, RxMaxMinLenErrCnt);
+DEVICE_COUNTER(rx_p0_hdr_egr_ovfls, RxP0HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p1_hdr_egr_ovfls, RxP1HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p2_hdr_egr_ovfls, RxP2HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p3_hdr_egr_ovfls, RxP3HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p4_hdr_egr_ovfls, RxP4HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p5_hdr_egr_ovfls, RxP5HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p6_hdr_egr_ovfls, RxP6HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p7_hdr_egr_ovfls, RxP7HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p8_hdr_egr_ovfls, RxP8HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_pkey_mismatches, RxPKeyMismatchCnt);
+DEVICE_COUNTER(rx_tid_full_errs, RxTIDFullErrCnt);
+DEVICE_COUNTER(rx_tid_valid_errs, RxTIDValidErrCnt);
+DEVICE_COUNTER(rx_vcrc_errs, RxVCRCErrCnt);
+DEVICE_COUNTER(tx_data_pkts, TxDataPktCnt);
+DEVICE_COUNTER(tx_dropped_pkts, TxDroppedPktCnt);
+DEVICE_COUNTER(tx_dwords, TxDwordCnt);
+DEVICE_COUNTER(tx_flow_pkts, TxFlowPktCnt);
+DEVICE_COUNTER(tx_flow_stalls, TxFlowStallCnt);
+DEVICE_COUNTER(tx_len_errs, TxLenErrCnt);
+DEVICE_COUNTER(tx_max_min_len_errs, TxMaxMinLenErrCnt);
+DEVICE_COUNTER(tx_underruns, TxUnderrunCnt);
+DEVICE_COUNTER(tx_unsup_vl_errs, TxUnsupVLErrCnt);
+
+static struct attribute *dev_counter_attributes[] = {
+	&dev_attr_ib_link_downeds.attr,
+	&dev_attr_ib_link_err_recoveries.attr,
+	&dev_attr_ib_status_changes.attr,
+	&dev_attr_ib_symbol_errs.attr,
+	&dev_attr_lb_flow_stalls.attr,
+	&dev_attr_lb_ints.attr,
+	&dev_attr_rx_bad_formats.attr,
+	&dev_attr_rx_buf_ovfls.attr,
+	&dev_attr_rx_data_pkts.attr,
+	&dev_attr_rx_dropped_pkts.attr,
+	&dev_attr_rx_dwords.attr,
+	&dev_attr_rx_ebps.attr,
+	&dev_attr_rx_flow_ctrl_errs.attr,
+	&dev_attr_rx_flow_pkts.attr,
+	&dev_attr_rx_icrc_errs.attr,
+	&dev_attr_rx_len_errs.attr,
+	&dev_attr_rx_link_problems.attr,
+	&dev_attr_rx_lpcrc_errs.attr,
+	&dev_attr_rx_max_min_len_errs.attr,
+	&dev_attr_rx_p0_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p1_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p2_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p3_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p4_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p5_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p6_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p7_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p8_hdr_egr_ovfls.attr,
+	&dev_attr_rx_pkey_mismatches.attr,
+	&dev_attr_rx_tid_full_errs.attr,
+	&dev_attr_rx_tid_valid_errs.attr,
+	&dev_attr_rx_vcrc_errs.attr,
+	&dev_attr_tx_data_pkts.attr,
+	&dev_attr_tx_dropped_pkts.attr,
+	&dev_attr_tx_dwords.attr,
+	&dev_attr_tx_flow_pkts.attr,
+	&dev_attr_tx_flow_stalls.attr,
+	&dev_attr_tx_len_errs.attr,
+	&dev_attr_tx_max_min_len_errs.attr,
+	&dev_attr_tx_underruns.attr,
+	&dev_attr_tx_unsup_vl_errs.attr,
+	NULL
+};
+
+static struct attribute_group dev_counter_attr_group = {
+	.name = "counters",
+	.attrs = dev_counter_attributes
+};
+
+static ssize_t store_reset(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	int ret;
+
+	if (count < 5 || memcmp(buf, "reset", 5)) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	ret = ipath_reset_device(dd->ipath_unit);
+bail:
+	return ret<0 ? ret : count;
+}
+
+static ssize_t store_link_state(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	int ret, r;
+	u16 state;
+
+	ret = ipath_parse_ushort(buf, &state);
+	if (ret < 0)
+		goto invalid;
+
+	r = ipath_layer_set_linkstate(dd, state);
+	if (r < 0) {
+		ret = r;
+		goto bail;
+	}
+
+	goto bail;
+invalid:
+	dev_err(dev, "attempt to set invalid link state\n");
+bail:
+	return ret;
+}
+
+static ssize_t show_flash(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	if (ipath_eeprom_read(dd, 0, buf, sizeof(struct ipath_flash))) {
+		ret = -ENXIO;
+		dev_err(dev, "failed to read from flash\n");
+		goto bail;
+	}
+
+	ret = sizeof(struct ipath_flash);
+bail:
+	return ret;
+}
+
+static ssize_t store_flash(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	if (count != sizeof(struct ipath_flash)) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	if (ipath_eeprom_write(dd, 0, buf, count)) {
+		ret = -ENXIO;
+		dev_err(dev, "failed to write to flash\n");
+		goto bail;
+	}
+
+	ret = count;
+bail:
+	return ret;
+}
+
+static ssize_t show_mtu(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_ibmtu);
+}
+
+static ssize_t store_mtu(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	ssize_t ret;
+	u16 mtu = 0;
+	int r;
+
+	ret = ipath_parse_ushort(buf, &mtu);
+	if (ret < 0)
+		goto invalid;
+
+	r = ipath_layer_set_mtu(dd, mtu);
+	if (r < 0)
+		ret = r;
+
+	goto bail;
+invalid:
+	dev_err(dev, "attempt to set invalid MTU\n");
+bail:
+	return ret;
+}
+
+static DRIVER_ATTR(atomic_stats, S_IRUGO, show_atomic_stats, NULL);
+static DRIVER_ATTR(num_units, S_IRUGO, show_num_units, NULL);
+static DRIVER_ATTR(version, S_IRUGO, show_version, NULL);
+
+static struct attribute *driver_attributes[] = {
+	&driver_attr_atomic_stats.attr,
+	&driver_attr_num_units.attr,
+	&driver_attr_version.attr,
+	NULL
+};
+
+static struct attribute_group driver_attr_group = {
+	.attrs = driver_attributes
+};
+
+static DEVICE_ATTR(atomic_counters, S_IRUGO, show_atomic_counters, NULL);
+static DEVICE_ATTR(flash, S_IWUSR | S_IRUGO, show_flash, store_flash);
+static DEVICE_ATTR(guid, S_IWUSR | S_IRUGO, show_guid, store_guid);
+static DEVICE_ATTR(lid, S_IWUSR | S_IRUGO, show_lid, store_lid);
+static DEVICE_ATTR(link_state, S_IWUSR, NULL, store_link_state);
+static DEVICE_ATTR(mlid, S_IWUSR | S_IRUGO, show_mlid, store_mlid);
+static DEVICE_ATTR(mtu, S_IWUSR | S_IRUGO, show_mtu, store_mtu);
+static DEVICE_ATTR(nguid, S_IRUGO, show_nguid, NULL);
+static DEVICE_ATTR(node_info, S_IRUGO, show_node_info, NULL);
+static DEVICE_ATTR(port_info, S_IRUGO, show_port_info, NULL);
+static DEVICE_ATTR(reset, S_IWUSR, NULL, store_reset);
+static DEVICE_ATTR(serial, S_IRUGO, show_serial, NULL);
+static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
+static DEVICE_ATTR(status_str, S_IRUGO, show_status_str, NULL);
+static DEVICE_ATTR(boardversion, S_IRUGO, show_boardversion, NULL);
+static DEVICE_ATTR(unit, S_IRUGO, show_unit, NULL);
+
+static struct attribute *dev_attributes[] = {
+	&dev_attr_atomic_counters.attr,
+	&dev_attr_flash.attr,
+	&dev_attr_guid.attr,
+	&dev_attr_lid.attr,
+	&dev_attr_link_state.attr,
+	&dev_attr_mlid.attr,
+	&dev_attr_mtu.attr,
+	&dev_attr_nguid.attr,
+	&dev_attr_node_info.attr,
+	&dev_attr_port_info.attr,
+	&dev_attr_serial.attr,
+	&dev_attr_status.attr,
+	&dev_attr_status_str.attr,
+	&dev_attr_boardversion.attr,
+	&dev_attr_unit.attr,
+	NULL
+};
+
+static struct attribute_group dev_attr_group = {
+	.attrs = dev_attributes
+};
+
+/**
+ * ipath_expose_reset - create a device reset file
+ * @dev: the device structure
+ *
+ * Only expose a file that lets us reset the device after someone
+ * enters diag mode.  A device reset is quite likely to crash the
+ * machine entirely, so we don't want to normally make it
+ * available.
+ */
+int ipath_expose_reset(struct device *dev)
+{
+	return device_create_file(dev, &dev_attr_reset);
+}
+
+int ipath_driver_create_group(struct device_driver *drv)
+{
+	int ret;
+
+	if (!drv->kobj.dentry) {
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	ret = sysfs_create_group(&drv->kobj, &driver_attr_group);
+	if (ret)
+		goto bail;
+
+	ret = sysfs_create_group(&drv->kobj, &driver_stat_attr_group);
+	if (ret)
+		sysfs_remove_group(&drv->kobj, &driver_attr_group);
+
+bail:
+	return ret;
+}
+
+void ipath_driver_remove_group(struct device_driver *drv)
+{
+	if (drv->kobj.dentry) {
+		sysfs_remove_group(&drv->kobj, &driver_stat_attr_group);
+		sysfs_remove_group(&drv->kobj, &driver_attr_group);
+	}
+}
+
+int ipath_device_create_group(struct device *dev, struct ipath_devdata *dd)
+{
+	int ret;
+	char unit[5];
+
+	ret = sysfs_create_group(&dev->kobj, &dev_attr_group);
+	if (ret)
+		goto bail;
+
+	ret = sysfs_create_group(&dev->kobj, &dev_counter_attr_group);
+	if (ret)
+		goto bail;
+
+	snprintf(unit, sizeof(unit), "%02u", (unsigned) dd->ipath_unit);
+	ret = sysfs_create_link(&dev->driver->kobj, &dev->kobj, unit);
+bail:
+	return ret;
+}
+
+void ipath_device_remove_group(struct device *dev, struct ipath_devdata *dd)
+{
+	char unit[5];
+
+	snprintf(unit, sizeof(unit), "%02u", (unsigned) dd->ipath_unit);
+	sysfs_remove_link(&dev->driver->kobj, unit);
+
+	sysfs_remove_group(&dev->kobj, &dev_counter_attr_group);
+	sysfs_remove_group(&dev->kobj, &dev_attr_group);
+
+	device_remove_file(dev, &dev_attr_reset);
+}

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVLPXvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVLPXvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVLPXt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:49:59 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:39021 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964822AbVLPXtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:49:16 -0500
Subject: [PATCH 08/13]  [RFC] ipath core last bit
In-Reply-To: <200512161548.3fqe3fMerrheBMdX@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 16 Dec 2005 15:48:55 -0800
Message-Id: <200512161548.y9KRuNtfMzpZjwni@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 23:48:57.0260 (UTC) FILETIME=[47B0E6C0:01C6029B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last piece of ipath LLD

---

 drivers/infiniband/hw/ipath/ipath_layer.c | 1155 +++++++++++++++++++++++++++++
 1 files changed, 1155 insertions(+), 0 deletions(-)
 create mode 100644 drivers/infiniband/hw/ipath/ipath_layer.c

978ded82c9b5a4bca4e55f36d20ef4a585c50f38
diff --git a/drivers/infiniband/hw/ipath/ipath_layer.c b/drivers/infiniband/hw/ipath/ipath_layer.c
new file mode 100644
index 0000000..6a60851
--- /dev/null
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c
@@ -0,0 +1,1155 @@
+/*
+ * Copyright (c) 2003, 2004, 2005. PathScale, Inc. All rights reserved.
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
+ * $Id: ipath_layer.c 4365 2005-12-10 00:04:16Z rjwalsh $
+ */
+
+/*
+ * These are the routines used by layered drivers, currently just the
+ * layered ethernet driver and verbs layer.
+ */
+
+#include <linux/pci.h>
+
+#include "ipath_kernel.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+/* unit number is already validated in ipath_ioctl() */
+int ipath_kset_linkstate(uint32_t arg)
+{
+	ipath_type unit = 0xffff & (arg >> 16);
+	uint32_t lstate;
+	ipath_devdata *dd;
+
+	if (unit >= infinipath_max ||
+	    !(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", unit);
+		return -ENODEV;
+	}
+
+	dd = &devdata[unit];
+	arg &= 0xffff;
+	if (arg != IPATH_IB_LINKDOWN && arg != IPATH_IB_LINKARM &&
+	    arg != IPATH_IB_LINKACTIVE) {
+		_IPATH_DBG("Unknown linkstate 0x%x requested\n", arg);
+		return -EINVAL;
+	}
+	if (arg == IPATH_IB_LINKDOWN) {
+		ipath_down_link(unit);	/* really moving it to idle */
+		lstate = IPATH_LINKDOWN | IPATH_LINK_SLEEPING;
+	} else if (arg == IPATH_IB_LINKARM) {
+		if (!(dd->ipath_flags &
+		      (IPATH_LINKINIT | IPATH_LINKARMED | IPATH_LINKDOWN |
+		       IPATH_LINK_SLEEPING | IPATH_LINKACTIVE)))
+			_IPATH_DBG
+			    ("don't know current state (flags 0x%x), try anyway\n",
+			     dd->ipath_flags);
+		ipath_set_ib_lstate(unit, INFINIPATH_IBCC_LINKCMD_ARMED);
+		lstate = IPATH_LINKARMED;
+	} else {
+		int tryarmed = 0;
+		/*
+		 * because we sometimes go to ARMED, but then back to 0x11
+		 * (initialized) before the SMA asks us to move to ACTIVE,
+		 * we will try to advance state to ARMED here, if necessary
+		 */
+		if (!(dd->ipath_flags &
+		      (IPATH_LINKINIT | IPATH_LINKARMED | IPATH_LINKDOWN |
+		       IPATH_LINK_SLEEPING | IPATH_LINKACTIVE))) {
+			/* this one is just paranoia */
+			_IPATH_DBG
+			    ("don't know current state (flags 0x%x), try anyway\n",
+			     dd->ipath_flags);
+			tryarmed = 1;
+
+		}
+		if (!(dd->ipath_flags & (IPATH_LINKARMED | IPATH_LINKACTIVE)))
+			tryarmed = 1;
+		if (tryarmed) {
+			ipath_set_ib_lstate(unit,
+					    INFINIPATH_IBCC_LINKCMD_ARMED);
+			/*
+			 * give it up to 2 seconds to get to ARMED or
+			 * ACTIVE; continue afterwards even if we fail
+			 */
+			if (ipath_wait_linkstate
+			    (unit, IPATH_LINKARMED | IPATH_LINKACTIVE, 2000))
+				_IPATH_VDBG
+				    ("try for active, even though didn't get to ARMED\n");
+		}
+
+		ipath_set_ib_lstate(unit, INFINIPATH_IBCC_LINKCMD_ACTIVE);
+		lstate = IPATH_LINKACTIVE;
+	}
+	return ipath_wait_linkstate(unit, lstate, 5000);
+}
+
+/*
+ * we can handle "any" incoming size, the issue here is whether we
+ * need to restrict our outgoing size.   For now, we don't do any
+ * sanity checking on this, and we don't deal with what happens to
+ * programs that are already running when the size changes.
+ * unit number is already validated in ipath_ioctl()
+ * NOTE: changing the MTU will usually cause the IBC to go back to
+ * link initialize (0x11) state...
+ */
+int ipath_kset_mtu(uint32_t arg)
+{
+	unsigned unit = (arg >> 16) & 0xffff;
+	uint32_t piosize;
+	int changed = 0;
+
+	if (unit >= infinipath_max ||
+	    !(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", unit);
+		return -ENODEV;
+	}
+
+	arg &= 0xffff;
+	/*
+	 * mtu is IB data payload max.  It's the largest power of 2 less
+	 * than piosize (or even larger, since it only really controls the
+	 * largest we can receive; we can send the max of the mtu and piosize).
+	 * We check that it's one of the valid IB sizes.
+	 */
+	if (arg != 256 && arg != 512 && arg != 1024 && arg != 2048 &&
+	    arg != 4096) {
+		_IPATH_DBG("Trying to set invalid mtu %u, failing\n", arg);
+		return -EINVAL;
+	}
+	if (devdata[unit].ipath_ibmtu == arg) {
+		return 0;	/* same as current */
+	}
+
+	piosize = devdata[unit].ipath_ibmaxlen;
+	devdata[unit].ipath_ibmtu = arg;
+
+	/*
+	 * the 128 is the max IB header size allowed for in our pio send buffers
+	 * If we are reducing the MTU below that, this doesn't completely make
+	 * sense, but it's OK.
+	 */
+	if (arg >= (piosize - 128)) {
+		/* hasn't been changed */
+		if (piosize == devdata[unit].ipath_init_ibmaxlen)
+			_IPATH_VDBG
+			    ("mtu 0x%x >= ibmaxlen hardware max, nothing to do\n",
+			     arg);
+		else {
+			_IPATH_VDBG
+			    ("mtu 0x%x restores ibmaxlen to full amount 0x%x\n",
+			     arg, piosize);
+			devdata[unit].ipath_ibmaxlen = piosize;
+			changed = 1;
+		}
+	} else if ((arg + 128) == devdata[unit].ipath_ibmaxlen)
+		_IPATH_VDBG("ibmaxlen %x same as current, no change\n", arg);
+	else {
+		piosize = arg + 128;
+		_IPATH_VDBG("ibmaxlen was 0x%x, setting to 0x%x (mtu 0x%x)\n",
+			    devdata[unit].ipath_ibmaxlen, piosize, arg);
+		devdata[unit].ipath_ibmaxlen = piosize;
+		changed = 1;
+	}
+
+	if (changed) {
+		/*
+		 * set the IBC maxpktlength to the size of our pio
+		 * buffers in words
+		 */
+		uint64_t ibc = devdata[unit].ipath_ibcctrl;
+		ibc &= ~(INFINIPATH_IBCC_MAXPKTLEN_MASK <<
+			 INFINIPATH_IBCC_MAXPKTLEN_SHIFT);
+
+		piosize = piosize - 2 * sizeof(uint32_t);	/* ignore pbc */
+		devdata[unit].ipath_ibmaxlen = piosize;
+		piosize /= sizeof(uint32_t);	/* in words */
+		/*
+		 * for ICRC, which we only send in diag test pkt mode, and we
+		 * don't need to worry about that for mtu
+		 */
+		piosize += 1;
+
+		ibc |= piosize << INFINIPATH_IBCC_MAXPKTLEN_SHIFT;
+		devdata[unit].ipath_ibcctrl = ibc;
+		ipath_kput_kreg(unit, kr_ibcctrl, devdata[unit].ipath_ibcctrl);
+	}
+	return 0;
+}
+
+void ipath_set_sps_lid(const ipath_type unit, uint32_t arg)
+{
+	if (unit >= infinipath_max ||
+	    !(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", unit);
+		return;
+	}
+
+	ipath_stats.sps_lid[unit] = devdata[unit].ipath_lid = arg;
+	if (devdata[unit].ipath_layer.l_intr)
+		devdata[unit].ipath_layer.l_intr(unit, IPATH_LAYER_INT_LID);
+}
+
+/* XXX - need to inform anyone who cares this just happened. */
+int ipath_layer_set_guid(const ipath_type device, uint64_t guid)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return -ENODEV;
+	}
+	devdata[device].ipath_guid = guid;
+	return 0;
+}
+
+uint64_t ipath_layer_get_guid(const ipath_type device)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+	return devdata[device].ipath_guid;
+}
+
+uint32_t ipath_layer_get_nguid(const ipath_type device)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+	return devdata[device].ipath_nguid;
+}
+
+int ipath_layer_query_device(const ipath_type device, uint32_t * vendor,
+			     uint32_t * boardrev, uint32_t * majrev,
+			     uint32_t * minrev)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return -ENODEV;
+	}
+
+	*vendor = devdata[device].ipath_vendorid;
+	*boardrev = devdata[device].ipath_boardrev;
+	*majrev = devdata[device].ipath_majrev;
+	*minrev = devdata[device].ipath_minrev;
+
+	return 0;
+}
+
+uint32_t ipath_layer_get_flags(const ipath_type device)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+
+	return devdata[device].ipath_flags;
+}
+
+struct device *ipath_layer_get_pcidev(const ipath_type device)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return NULL;
+	}
+
+	return &(devdata[device].pcidev->dev);
+}
+
+uint16_t ipath_layer_get_deviceid(const ipath_type device)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+
+	return devdata[device].ipath_deviceid;
+}
+
+uint64_t ipath_layer_get_lastibcstat(const ipath_type device)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+
+	return devdata[device].ipath_lastibcstat;
+}
+
+uint32_t ipath_layer_get_ibmtu(const ipath_type device)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+
+	return devdata[device].ipath_ibmtu;
+}
+
+int ipath_layer_register(const ipath_type device,
+			 int (*l_intr) (const ipath_type, uint32_t),
+			 int (*l_rcv) (const ipath_type, void *,
+				       struct sk_buff *), uint16_t l_rcv_opcode,
+			 int (*l_rcv_lid) (const ipath_type, void *),
+			 uint16_t l_rcv_lid_opcode)
+{
+	int ret = 0;
+
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 1;
+	}
+	if (!(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_VDBG("%s not yet initialized, failing\n",
+			    ipath_get_unit_name(device));
+		return 1;
+	}
+
+	_IPATH_VDBG("intr %p rx %p, rx_lid %p\n", l_intr, l_rcv, l_rcv_lid);
+	if (devdata[device].ipath_layer.l_intr
+	    || devdata[device].ipath_layer.l_rcv) {
+		_IPATH_DBG
+		    ("Layered device already registered on unit %u, failing\n",
+		     device);
+		return 1;
+	}
+
+	if(!(*devdata[device].ipath_statusp & IPATH_STATUS_SMA))
+		*devdata[device].ipath_statusp |= IPATH_STATUS_OIB_SMA;
+	devdata[device].ipath_layer.l_intr = l_intr;
+	devdata[device].ipath_layer.l_rcv = l_rcv;
+	devdata[device].ipath_layer.l_rcv_lid = l_rcv_lid;
+	devdata[device].ipath_layer.l_rcv_opcode = l_rcv_opcode;
+	devdata[device].ipath_layer.l_rcv_lid_opcode = l_rcv_lid_opcode;
+
+	return ret;
+}
+
+static void ipath_verbs_timer(unsigned long t)
+{
+	/*
+	 * If port 0 receive packet interrupts are not availabile,
+	 * check the receive queue.
+	 */
+	if (!(devdata[t].ipath_flags & IPATH_GPIO_INTR))
+		ipath_kreceive(t);
+
+	/* Handle verbs layer timeouts. */
+	if (devdata[t].verbs_layer.l_timer_cb)
+		devdata[t].verbs_layer.l_timer_cb(t);
+
+	mod_timer(&devdata[t].verbs_layer.l_timer, jiffies + 1);
+}
+
+/* Verbs layer registration. */
+int ipath_verbs_register(const ipath_type device,
+			  int (*l_piobufavail) (const ipath_type device),
+			  void (*l_rcv) (const ipath_type device, void *rhdr,
+					 void *data, u32 tlen),
+			  void (*l_timer_cb) (const ipath_type device))
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+	if (!(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_VDBG("%s not yet initialized, failing\n",
+			    ipath_get_unit_name(device));
+		return 0;
+	}
+
+	_IPATH_VDBG("piobufavail %p rx %p\n", l_piobufavail, l_rcv);
+	if (devdata[device].verbs_layer.l_piobufavail ||
+	    devdata[device].verbs_layer.l_rcv) {
+		_IPATH_DBG("Verbs layer already registered on unit %u, "
+			   "failing\n", device);
+		return 0;
+	}
+
+	devdata[device].verbs_layer.l_piobufavail = l_piobufavail;
+	devdata[device].verbs_layer.l_rcv = l_rcv;
+	devdata[device].verbs_layer.l_timer_cb = l_timer_cb;
+	devdata[device].verbs_layer.l_flags = 0;
+
+	return 1;
+}
+
+void ipath_verbs_unregister(const ipath_type device)
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return;
+	}
+	if (!(devdata[device].ipath_flags & IPATH_INITTED)) {
+		_IPATH_VDBG("%s not yet initialized, failing\n",
+			    ipath_get_unit_name(device));
+		return;
+	}
+
+	*devdata[device].ipath_statusp &= ~IPATH_STATUS_OIB_SMA;
+	devdata[device].verbs_layer.l_piobufavail = NULL;
+	devdata[device].verbs_layer.l_rcv = NULL;
+	devdata[device].verbs_layer.l_timer_cb = NULL;
+	devdata[device].verbs_layer.l_flags = 0;
+}
+
+int ipath_layer_open(const ipath_type device, uint32_t * pktmax)
+{
+	int ret = 0;
+	uint32_t intval = 0;
+
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 1;
+	}
+	if (!devdata[device].ipath_layer.l_intr
+	    || !devdata[device].ipath_layer.l_rcv) {
+		_IPATH_DBG("layer not registered, failing\n");
+		return 1;
+	}
+
+	if ((ret =
+	     ipath_setrcvhdrsize(device, NUM_OF_EKSTRA_WORDS_IN_HEADER_QUEUE)))
+		return ret;
+
+	*pktmax = devdata[device].ipath_ibmaxlen;
+
+	if (*devdata[device].ipath_statusp & IPATH_STATUS_IB_READY)
+		intval |= IPATH_LAYER_INT_IF_UP;
+	if (ipath_stats.sps_lid[device])
+		intval |= IPATH_LAYER_INT_LID;
+	if (ipath_stats.sps_mlid[device])
+		intval |= IPATH_LAYER_INT_BCAST;
+	/*
+	 * do this on open, in case low level is already up and
+	 * just layered driver was reloaded, etc.
+	 */
+	if (intval)
+		devdata[device].ipath_layer.l_intr(device, intval);
+
+	return ret;
+}
+
+int16_t ipath_layer_get_lid(const ipath_type device)
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+
+	_IPATH_VDBG("returning mylid 0x%x for layered dev %d\n",
+		    devdata[device].ipath_lid, device);
+	return devdata[device].ipath_lid;
+}
+
+/*
+ * get the MAC address.  This is the EUID-64 OUI octets (top 3), then
+ * skip the next 2 (which should both be zero or 0xff).
+ * The returned MAC is in network order
+ * mac points to at least 6 bytes of buffer
+ * returns 0 on error (to be consistent with get_lid and get_bcast
+ * return 1 on success
+ * We assume that by the time the LID is set, that the GUID is as valid
+ * as it's ever going to be, rather than adding yet another status bit.
+ */
+
+int ipath_layer_get_mac(const ipath_type device, uint8_t * mac)
+{
+	uint8_t *guid;
+
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u, failing\n", device);
+		return 0;
+	}
+	guid = (uint8_t *) & devdata[device].ipath_guid;
+
+	mac[0] = guid[0];
+	mac[1] = guid[1];
+	mac[2] = guid[2];
+	mac[3] = guid[5];
+	mac[4] = guid[6];
+	mac[5] = guid[7];
+	if((guid[3] || guid[4]) && !(guid[3] == 0xff && guid[4] == 0xff))
+		_IPATH_DBG("Warning, guid bytes 3 and 4 not 0 or 0xffff: %x %x\n",
+			guid[3], guid[4]);
+	_IPATH_VDBG("Returning %x:%x:%x:%x:%x:%x\n",
+		    mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+	return 1;
+}
+
+int16_t ipath_layer_get_bcast(const ipath_type device)
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u, failing\n", device);
+		return 0;
+	}
+
+	_IPATH_VDBG("returning broadcast LID 0x%x for unit %u\n",
+		    devdata[device].ipath_mlid, device);
+	return devdata[device].ipath_mlid;
+}
+
+int ipath_layer_get_num_of_dev(void)
+{
+	return infinipath_max;
+}
+
+int ipath_layer_get_cr_errpkey(const ipath_type device)
+{
+	return ipath_kget_creg32(device, cr_errpkey);
+}
+
+void ipath_layer_close(const ipath_type device)
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return;
+	}
+	if (!devdata[device].ipath_layer.l_intr
+	    || !devdata[device].ipath_layer.l_rcv) {
+		/* normal if not all chips are present */
+		_IPATH_VDBG("layer close without open\n");
+	} else {
+		devdata[device].ipath_layer.l_intr = NULL;
+		devdata[device].ipath_layer.l_rcv = NULL;
+		devdata[device].ipath_layer.l_rcv_lid = NULL;
+		devdata[device].ipath_layer.l_rcv_opcode = 0;
+		devdata[device].ipath_layer.l_rcv_lid_opcode = 0;
+	}
+}
+
+static inline void copy_aligned(uint32_t *piobuf, struct ipath_sge_state *ss,
+				uint32_t length)
+{
+	struct ipath_sge *sge = &ss->sge;
+
+	while (length) {
+		u32 len = sge->length;
+		u32 w;
+
+		BUG_ON(len == 0);
+		if (len > length)
+			len = length;
+		/* Need to round up for the last dword in the packet. */
+		w = (len + 3) >> 2;
+		ipath_dwordcpy(piobuf, sge->vaddr, w);
+		piobuf += w;
+		sge->vaddr += len;
+		sge->length -= len;
+		sge->sge_length -= len;
+		if (sge->sge_length == 0) {
+			if (--ss->num_sge)
+				*sge = *ss->sg_list++;
+		} else if (sge->length == 0 && sge->mr != NULL) {
+			if (++sge->n >= IPATH_SEGSZ) {
+				if (++sge->m >= sge->mr->mapsz)
+					break;
+				sge->n = 0;
+			}
+			sge->vaddr = sge->mr->map[sge->m]->segs[sge->n].vaddr;
+			sge->length = sge->mr->map[sge->m]->segs[sge->n].length;
+		}
+		length -= len;
+	}
+}
+
+static inline void copy_unaligned(uint32_t *piobuf, struct ipath_sge_state *ss,
+				  uint32_t length)
+{
+	struct ipath_sge *sge = &ss->sge;
+	union {
+		u8 wbuf[4];
+		u32 w;
+	} u;
+	int extra = 0;
+
+	while (length) {
+		u32 len = sge->length;
+
+		BUG_ON(len == 0);
+		if (len > length)
+			len = length;
+		length -= len;
+		while (len) {
+			u.wbuf[extra++] = *(u8 *) sge->vaddr;
+			sge->vaddr++;
+			sge->length--;
+			sge->sge_length--;
+			if (extra >= 4) {
+				*piobuf++ = u.w;
+				extra = 0;
+			}
+			len--;
+		}
+		if (sge->sge_length == 0) {
+			if (--ss->num_sge)
+				*sge = *ss->sg_list++;
+		} else if (sge->length == 0) {
+			if (++sge->n >= IPATH_SEGSZ) {
+				if (++sge->m >= sge->mr->mapsz)
+					break;
+				sge->n = 0;
+			}
+			sge->vaddr = sge->mr->map[sge->m]->segs[sge->n].vaddr;
+			sge->length = sge->mr->map[sge->m]->segs[sge->n].length;
+		}
+	}
+	if (extra) {
+		while (extra < 4)
+			u.wbuf[extra++] = 0;
+		*piobuf = u.w;
+	}
+}
+
+/*
+ * This is like ipath_send_smapkt() in that we need to be able to send
+ * packets after the chip is initialized (MADs) but also like
+ * ipath_layer_send() since its used by the verbs layer.
+ */
+int ipath_verbs_send(const ipath_type device, uint32_t hdrwords,
+		     uint32_t *hdr, uint32_t len, struct ipath_sge_state *ss)
+{
+	ipath_devdata *dd = &devdata[device];
+	int whichpb;
+	uint32_t *piobuf, plen;
+	uint64_t pboff;
+
+	if (device >= infinipath_max ||
+	    !(dd->ipath_flags & IPATH_PRESENT) || !dd->ipath_kregbase) {
+		_IPATH_DBG("illegal unit %u\n", device);
+		return -ENODEV;
+	}
+	if (!(dd->ipath_flags & IPATH_INITTED)) {
+		/* no hardware, freeze, etc. */
+		_IPATH_DBG("unit %u not usable\n", device);
+		return -ENODEV;
+	}
+	/* +1 is for the qword padding of pbc */
+	plen = hdrwords + ((len + 3) >> 2) + 1;
+	if ((plen << 2) > dd->ipath_ibmaxlen) {
+		_IPATH_DBG("packet len 0x%x too long, failing\n", plen);
+		return -EINVAL;
+	}
+
+	/* Get a PIO buffer to use. */
+	if ((whichpb = ipath_getpiobuf(device)) < 0)
+		return whichpb;
+
+	pboff = dd->ipath_piobufbase;
+	piobuf = (uint32_t *) (((char *)(dd->ipath_kregbase)) + pboff
+			       + whichpb * dd->ipath_palign);
+	_IPATH_EPDBG("0x%x+1w pio%d\n", plen - 1, whichpb);
+
+	/* Write len to control qword, no flags. */
+	*((uint64_t *) piobuf) = (uint64_t) plen;
+	piobuf += 2;
+	ipath_dwordcpy(piobuf, hdr, hdrwords);
+	if (len == 0)
+		return 0;
+	piobuf += hdrwords;
+	/*
+	 * If we really wanted to check everything, we would have to
+	 * check that each segment starts on a dword boundary and is
+	 * a dword multiple in length.
+	 * Since there can be lots of segments, we only check for a simple
+	 * common case where the amount to copy is contained in one segment.
+	 */
+	if (ss->sge.length == len)
+		copy_aligned(piobuf, ss, len);
+	else
+		copy_unaligned(piobuf, ss, len);
+	return 0;
+}
+
+void ipath_layer_snapshot_counters(const ipath_type device, u64 * swords,
+				   u64 * rwords, u64 * spkts, u64 * rpkts)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_PRESENT)) {
+		_IPATH_DBG("illegal unit %u\n", device);
+		return;
+	}
+	if (!(devdata[device].ipath_flags & IPATH_INITTED)) {
+		/* no hardware, freeze, etc. */
+		_IPATH_DBG("unit %u not usable\n", device);
+		return;
+	}
+	*swords = ipath_snap_cntr(device, cr_wordsendcnt);
+	*rwords = ipath_snap_cntr(device, cr_wordrcvcnt);
+	*spkts = ipath_snap_cntr(device, cr_pktsendcnt);
+	*rpkts = ipath_snap_cntr(device, cr_pktrcvcnt);
+}
+
+/*
+ * Return the counters needed by recv_pma_get_portcounters().
+ */
+void ipath_layer_get_counters(const ipath_type device,
+			      struct ipath_layer_counters *cntrs)
+{
+	if (device >= infinipath_max ||
+	    !(devdata[device].ipath_flags & IPATH_PRESENT)) {
+		_IPATH_DBG("illegal unit %u\n", device);
+		return;
+	}
+	if (!(devdata[device].ipath_flags & IPATH_INITTED)) {
+		/* no hardware, freeze, etc. */
+		_IPATH_DBG("unit %u not usable\n", device);
+		return;
+	}
+	cntrs->symbol_error_counter =
+		ipath_snap_cntr(device, cr_ibsymbolerrcnt);
+	cntrs->link_error_recovery_counter =
+		ipath_snap_cntr(device, cr_iblinkerrrecovcnt);
+	cntrs->link_downed_counter = ipath_snap_cntr(device, cr_iblinkdowncnt);
+	cntrs->port_rcv_errors = ipath_snap_cntr(device, cr_err_rlencnt) +
+		ipath_snap_cntr(device, cr_invalidrlencnt) +
+		ipath_snap_cntr(device, cr_erricrccnt) +
+		ipath_snap_cntr(device, cr_errvcrccnt) +
+		ipath_snap_cntr(device, cr_badformatcnt);
+	cntrs->port_rcv_remphys_errors = ipath_snap_cntr(device, cr_rcvebpcnt);
+	cntrs->port_xmit_discards = ipath_snap_cntr(device, cr_unsupvlcnt);
+	cntrs->port_xmit_data = ipath_snap_cntr(device, cr_wordsendcnt);
+	cntrs->port_rcv_data = ipath_snap_cntr(device, cr_wordrcvcnt);
+	cntrs->port_xmit_packets = ipath_snap_cntr(device, cr_pktsendcnt);
+	cntrs->port_rcv_packets = ipath_snap_cntr(device, cr_pktrcvcnt);
+}
+
+void ipath_layer_want_buffer(const ipath_type device)
+{
+	atomic_set_mask(INFINIPATH_S_PIOINTBUFAVAIL,
+			&devdata[device].ipath_sendctrl);
+	ipath_kput_kreg(device, kr_sendctrl, devdata[device].ipath_sendctrl);
+}
+
+int ipath_layer_send(const ipath_type device, void *hdr, void *data,
+		     uint32_t datawords)
+{
+	int ret = 0, whichpb;
+	uint32_t *piobuf, plen;
+	uint16_t vlsllnh;
+	uint64_t pboff;
+
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u, failing\n", device);
+		return -EINVAL;
+	}
+	if (!(devdata[device].ipath_flags & IPATH_RCVHDRSZ_SET)) {
+		_IPATH_DBG("send while not open\n");
+		ret = -EINVAL;
+	} else
+	    if ((devdata[device].ipath_flags & (IPATH_LINKUNK | IPATH_LINKDOWN))
+		|| devdata[device].ipath_lid == 0) {
+		/* lid check is for when sma hasn't yet configured */
+		ret = -ENETDOWN;
+		_IPATH_VDBG("send while not ready, mylid=%u, flags=0x%x\n",
+			    devdata[device].ipath_lid,
+			    devdata[device].ipath_flags);
+	}
+	/* +1 is for the qword padding of pbc */
+	plen = (sizeof(ips_message_header_typ) >> 2) + datawords + 1;
+	if (plen > (devdata[device].ipath_ibmaxlen >> 2)) {
+		_IPATH_DBG("packet len 0x%x too long, failing\n", plen);
+		ret = -EINVAL;
+	}
+	vlsllnh = *((uint16_t *) hdr);
+	if (vlsllnh != htons(IPS_LRH_BTH)) {
+		_IPATH_DBG("Warning: lrh[0] wrong (%x, not %x); not sending\n",
+			   vlsllnh, htons(IPS_LRH_BTH));
+		ret = -EINVAL;
+	}
+	if (ret)
+		goto done;
+
+	/* Get a PIO buffer to use. */
+	if ((whichpb = ipath_getpiobuf(device)) < 0) {
+		ret = whichpb;
+		goto done;
+	}
+
+	pboff = devdata[device].ipath_piobufbase;
+	piobuf =
+	    (uint32_t *) (((char *)(devdata[device].ipath_kregbase)) + pboff +
+			  whichpb * devdata[device].ipath_palign);
+	_IPATH_EPDBG("0x%x+1w pio%d\n", plen - 1, whichpb);
+
+	/* len to control qword, no flags */
+	*((uint64_t *) piobuf) = (uint64_t) plen;
+	piobuf += 2;
+	ipath_dwordcpy(piobuf, hdr, (sizeof(ips_message_header_typ) >> 2));
+	piobuf += (sizeof(ips_message_header_typ) >> 2);
+	ipath_dwordcpy(piobuf, data, datawords);
+
+	ipath_stats.sps_ether_spkts++;	/* another ether packet sent */
+
+done:
+	return ret;
+}
+
+void ipath_layer_set_piointbufavail_int(const ipath_type device)
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return;
+	}
+
+	atomic_set_mask(INFINIPATH_S_PIOINTBUFAVAIL,
+			&devdata[device].ipath_sendctrl);
+
+	ipath_kput_kreg(device, kr_sendctrl, devdata[device].ipath_sendctrl);
+}
+
+void ipath_layer_enable_timer(const ipath_type device)
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return;
+	}
+
+	/*
+	 * HT-400 has a design flaw where the chip and kernel idea
+	 * of the tail register don't always agree, and therefore we won't
+	 * get an interrupt on the next packet received.
+	 * If the board supports per packet receive interrupts, use it.
+	 * Otherwise, the timer function periodically checks for packets
+	 * to cover this case.
+	 * Either way, the timer is needed for verbs layer related
+	 * processing.
+	 */
+	if (devdata[device].ipath_flags & IPATH_GPIO_INTR) {
+		ipath_kput_kreg(device, kr_debugportselect, 0x2074076542310UL);
+		/* Enable GPIO bit 2 interrupt */
+		ipath_kput_kreg(device, kr_gpio_mask, (uint64_t)(1 << 2));
+	}
+
+	init_timer(&devdata[device].verbs_layer.l_timer);
+	devdata[device].verbs_layer.l_timer.function = ipath_verbs_timer;
+	devdata[device].verbs_layer.l_timer.data = (unsigned long)device;
+	devdata[device].verbs_layer.l_timer.expires = jiffies + 1;
+	add_timer(&devdata[device].verbs_layer.l_timer);
+}
+
+void ipath_layer_disable_timer(const ipath_type device)
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return;
+	}
+
+	/* Disable GPIO bit 2 interrupt */
+	if (devdata[device].ipath_flags & IPATH_GPIO_INTR)
+		ipath_kput_kreg(device, kr_gpio_mask, 0);
+
+	del_timer_sync(&devdata[device].verbs_layer.l_timer);
+}
+
+/*
+ * Get the verbs layer flags.
+ */
+unsigned ipath_verbs_get_flags(const ipath_type device)
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+
+	return devdata[device].verbs_layer.l_flags;
+}
+
+/*
+ * Set the verbs layer flags.
+ */
+void ipath_verbs_set_flags(const ipath_type device, unsigned flags)
+{
+	ipath_type s;
+
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return;
+	}
+
+	devdata[device].verbs_layer.l_flags = flags;
+
+	for (s = 0; s < infinipath_max; s++) {
+		if (!(devdata[s].ipath_flags & IPATH_INITTED))
+			continue;
+		if ((flags & IPATH_VERBS_KERNEL_SMA) &&
+		    !(*devdata[s].ipath_statusp & IPATH_STATUS_SMA)) {
+			*devdata[s].ipath_statusp |= IPATH_STATUS_OIB_SMA;
+		} else {
+			*devdata[s].ipath_statusp &= ~IPATH_STATUS_OIB_SMA;
+		}
+	}
+}
+
+/*
+ * Return the size of the PKEY table for port 0.
+ */
+unsigned ipath_layer_get_npkeys(const ipath_type device)
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+
+	return ARRAY_SIZE(devdata[device].ipath_pd[0]->port_pkeys);
+}
+
+/*
+ * Return the indexed PKEY from the port 0 PKEY table.
+ */
+unsigned ipath_layer_get_pkey(const ipath_type device, unsigned index)
+{
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return 0;
+	}
+	if (index >= ARRAY_SIZE(devdata[device].ipath_pd[0]->port_pkeys))
+		return 0;
+
+	return devdata[device].ipath_pd[0]->port_pkeys[index];
+}
+
+/*
+ * Return the PKEY table for port 0.
+ */
+void ipath_layer_get_pkeys(const ipath_type device, uint16_t *pkeys)
+{
+	struct _ipath_portdata *pd;
+
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return;
+	}
+
+	pd = devdata[device].ipath_pd[0];
+	memcpy(pkeys, pd->port_pkeys, sizeof(pd->port_pkeys));
+}
+
+/*
+ * Decrecment the reference count for the given PKEY.
+ * Return true if this was the last reference and the hardware table entry
+ * needs to be changed.
+ */
+static inline int rm_pkey(ipath_devdata *dd, uint16_t key)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
+		if (dd->ipath_pkeys[i] != key)
+			continue;
+		if (atomic_dec_and_test(&dd->ipath_pkeyrefs[i])) {
+			dd->ipath_pkeys[i] = 0;
+			return 1;
+		}
+		break;
+	}
+	return 0;
+}
+
+/*
+ * Add the given PKEY to the hardware table.
+ * Return an error code if unable to add the entry, zero if no change,
+ * or 1 if the hardware PKEY register needs to be updated.
+ */
+static inline int add_pkey(ipath_devdata *dd, uint16_t key)
+{
+	int i;
+	uint16_t lkey = key & 0x7FFF;
+	int any = 0;
+
+	for (i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
+		if (!dd->ipath_pkeys[i]) {
+			any++;
+			continue;
+		}
+		/* If it matches exactly, try to increment the ref count */
+		if (dd->ipath_pkeys[i] == key) {
+			if (atomic_inc_return(&dd->ipath_pkeyrefs[i]) > 1)
+				return 0;
+			/* Lost the race. Look for an empty slot below. */
+			atomic_dec(&dd->ipath_pkeyrefs[i]);
+			any++;
+		}
+		/*
+		 * It makes no sense to have both the limited and unlimited
+		 * PKEY set at the same time since the unlimited one will
+		 * disable the limited one.
+		 */
+		if ((dd->ipath_pkeys[i] & 0x7FFF) == lkey)
+			return -EEXIST;
+	}
+	if (!any)
+		return -EBUSY;
+	for (i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
+		if (!dd->ipath_pkeys[i] &&
+		    atomic_inc_return(&dd->ipath_pkeyrefs[i]) == 1) {
+			/* for ipathstats, etc. */
+			ipath_stats.sps_pkeys[i] = lkey;
+			dd->ipath_pkeys[i] = key;
+			return 1;
+		}
+	}
+	return -EBUSY;
+}
+
+/*
+ * Set the PKEY table for port 0.
+ */
+int ipath_layer_set_pkeys(const ipath_type device, uint16_t *pkeys)
+{
+	ipath_portdata *pd;
+	ipath_devdata *dd;
+	int i;
+	int changed = 0;
+
+	if (device >= infinipath_max) {
+		_IPATH_DBG("Invalid unit %u\n", device);
+		return -EINVAL;
+	}
+
+	dd = &devdata[device];
+	pd = dd->ipath_pd[0];
+
+	for (i = 0; i > ARRAY_SIZE(pd->port_pkeys); i++) {
+		uint16_t key = pkeys[i];
+		uint16_t okey = pd->port_pkeys[i];
+
+		if (key == okey)
+			continue;
+		/*
+		 * The value of this PKEY table entry is changing.
+		 * Remove the old entry in the hardware's array of PKEYs.
+		 */
+		if (okey & 0x7FFF)
+			changed |= rm_pkey(dd, okey);
+		if (key & 0x7FFF) {
+			int ret = add_pkey(dd, key);
+
+			if (ret < 0)
+				key = 0;
+			else
+				changed |= ret;
+		}
+		pd->port_pkeys[i] = key;
+	}
+	if (changed) {
+		uint64_t pkey;
+
+		pkey = (uint64_t) dd->ipath_pkeys[0] |
+		    ((uint64_t) dd->ipath_pkeys[1] << 16) |
+		    ((uint64_t) dd->ipath_pkeys[2] << 32) |
+		    ((uint64_t) dd->ipath_pkeys[3] << 48);
+		_IPATH_VDBG("p0 new pkey reg %llx\n", pkey);
+		ipath_kput_kreg(pd->port_unit, kr_partitionkey, pkey);
+	}
+	return 0;
+}
+
+/*
+ * Registers that vary with the chip implementation constants (port)
+ * use this routine.
+ */
+uint64_t ipath_kget_kreg64_port(const ipath_type stype, ipath_kreg regno,
+				unsigned port)
+{
+	ipath_kreg tmp =
+	    (port < devdata[stype].ipath_portcnt && regno == kr_rcvhdraddr) ?
+	    regno + port :
+	    ((port < devdata[stype].ipath_portcnt
+	      && regno == kr_rcvhdrtailaddr) ? regno + port : __kr_invalid);
+	return ipath_kget_kreg64(stype, tmp);
+}
+
+/*
+ * Registers that vary with the chip implementation constants (port)
+ * use this routine.
+ */
+void ipath_kput_kreg_port(const ipath_type stype, ipath_kreg regno,
+			  unsigned port, uint64_t value)
+{
+	ipath_kreg tmp =
+	    (port < devdata[stype].ipath_portcnt && regno == kr_rcvhdraddr) ?
+	    regno + port :
+	    ((port < devdata[stype].ipath_portcnt
+	      && regno == kr_rcvhdrtailaddr) ? regno + port : __kr_invalid);
+	ipath_kput_kreg(stype, tmp, value);
+}
+
+EXPORT_SYMBOL(ipath_kset_linkstate);
+EXPORT_SYMBOL(ipath_kset_mtu);
+EXPORT_SYMBOL(ipath_layer_close);
+EXPORT_SYMBOL(ipath_layer_get_bcast);
+EXPORT_SYMBOL(ipath_layer_get_cr_errpkey);
+EXPORT_SYMBOL(ipath_layer_get_deviceid);
+EXPORT_SYMBOL(ipath_layer_get_flags);
+EXPORT_SYMBOL(ipath_layer_get_guid);
+EXPORT_SYMBOL(ipath_layer_get_ibmtu);
+EXPORT_SYMBOL(ipath_layer_get_lastibcstat);
+EXPORT_SYMBOL(ipath_layer_get_lid);
+EXPORT_SYMBOL(ipath_layer_get_mac);
+EXPORT_SYMBOL(ipath_layer_get_nguid);
+EXPORT_SYMBOL(ipath_layer_get_num_of_dev);
+EXPORT_SYMBOL(ipath_layer_get_pcidev);
+EXPORT_SYMBOL(ipath_layer_open);
+EXPORT_SYMBOL(ipath_layer_query_device);
+EXPORT_SYMBOL(ipath_layer_register);
+EXPORT_SYMBOL(ipath_layer_send);
+EXPORT_SYMBOL(ipath_layer_set_guid);
+EXPORT_SYMBOL(ipath_layer_set_piointbufavail_int);
+EXPORT_SYMBOL(ipath_layer_snapshot_counters);
+EXPORT_SYMBOL(ipath_layer_get_counters);
+EXPORT_SYMBOL(ipath_layer_want_buffer);
+EXPORT_SYMBOL(ipath_verbs_register);
+EXPORT_SYMBOL(ipath_verbs_send);
+EXPORT_SYMBOL(ipath_verbs_unregister);
+EXPORT_SYMBOL(ipath_set_sps_lid);
+EXPORT_SYMBOL(ipath_layer_enable_timer);
+EXPORT_SYMBOL(ipath_layer_disable_timer);
+EXPORT_SYMBOL(ipath_verbs_get_flags);
+EXPORT_SYMBOL(ipath_verbs_set_flags);
+EXPORT_SYMBOL(ipath_layer_get_npkeys);
+EXPORT_SYMBOL(ipath_layer_get_pkey);
+EXPORT_SYMBOL(ipath_layer_get_pkeys);
+EXPORT_SYMBOL(ipath_layer_set_pkeys);
-- 
0.99.9n

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVL2Aou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVL2Aou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVL2Aoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:44:44 -0500
Received: from mx.pathscale.com ([64.160.42.68]:51176 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932575AbVL2AjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:10 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 9 of 20] ipath - core driver, part 2 of 4
X-Mercurial-Node: dad2e87e21f4c9afebcfbd4bf94b9613420b2c41
Message-Id: <dad2e87e21f4c9afebcf.1135816288@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:28 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r ddd21709e12c -r dad2e87e21f4 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Dec 28 14:19:42 2005 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Dec 28 14:19:42 2005 -0800
@@ -1877,3 +1877,2004 @@
 
 	return ret;
 }
+
+/*
+ * cancel a range of PIO buffers, used when they might be armed, but
+ * not triggered.  Used at init to ensure buffer state, and also user
+ * process close, in case it died while writing to a PIO buffer
+ */
+
+static void ipath_disarm_piobufs(const ipath_type t, unsigned first,
+				 unsigned cnt)
+{
+	unsigned i, last = first + cnt;
+	uint64_t sendctrl;
+	for (i = first; i < last; i++) {
+		sendctrl = devdata[t].ipath_sendctrl | INFINIPATH_S_DISARM |
+		    (i << INFINIPATH_S_DISARMPIOBUF_SHIFT);
+		ipath_kput_kreg(t, kr_sendctrl, sendctrl);
+	}
+}
+
+static void ipath_clean_partkey(struct ipath_portdata * pd,
+				struct ipath_devdata * dd)
+{
+	int i, j, pchanged = 0;
+	uint64_t oldpkey;
+
+	/* for debugging only */
+	oldpkey =
+	    (uint64_t) dd->ipath_pkeys[0] | ((uint64_t) dd->
+					     ipath_pkeys[1] << 16)
+	    | ((uint64_t) dd->ipath_pkeys[2] << 32)
+	    | ((uint64_t) dd->ipath_pkeys[3] << 48);
+
+	for (i = 0; i < (sizeof(pd->port_pkeys) / sizeof(pd->port_pkeys[0]));
+	     i++) {
+		if (!pd->port_pkeys[i])
+			continue;
+		_IPATH_VDBG("look for key[%d] %hx in pkeys\n", i,
+			    pd->port_pkeys[i]);
+		for (j = 0;
+		     j < (sizeof(dd->ipath_pkeys) / sizeof(dd->ipath_pkeys[0]));
+		     j++) {
+			/* check for match independent of the global bit */
+			if ((dd->ipath_pkeys[j] & 0x7fff) ==
+			    (pd->port_pkeys[i] & 0x7fff)) {
+				if (atomic_dec_and_test(&dd->ipath_pkeyrefs[j])) {
+					_IPATH_VDBG
+					    ("p%u clear key %x matches #%d\n",
+					     pd->port_port, pd->port_pkeys[i],
+					     j);
+					ipath_stats.sps_pkeys[j] =
+					    dd->ipath_pkeys[j] = 0;
+					pchanged++;
+				} else
+					_IPATH_VDBG
+					    ("p%u key %x matches #%d, but ref still %d\n",
+					     pd->port_port, pd->port_pkeys[i],
+					     j,
+					     atomic_read(&dd->
+							 ipath_pkeyrefs[j]));
+				break;
+			}
+		}
+		pd->port_pkeys[i] = 0;
+	}
+	if (pchanged) {
+		uint64_t pkey;
+		pkey =
+		    (uint64_t) dd->ipath_pkeys[0] | ((uint64_t) dd->
+						     ipath_pkeys[1] << 16)
+		    | ((uint64_t) dd->ipath_pkeys[2] << 32)
+		    | ((uint64_t) dd->ipath_pkeys[3] << 48);
+		_IPATH_VDBG("p%u old pkey reg %llx, new pkey reg %llx\n",
+			    pd->port_port, oldpkey, pkey);
+		ipath_kput_kreg(pd->port_unit, kr_partitionkey, pkey);
+	}
+}
+
+static unsigned int ipath_poll(struct file *fp, struct poll_table_struct *pt)
+{
+	int ret;
+	struct ipath_portdata *pd;
+
+	pd = port_fp(fp);
+	/* nothing for select/poll in this driver, at least for now */
+	ret = 0;
+
+	return ret;
+}
+
+/*
+ * wait up to msecs milliseconds for IB link state change to occur
+ * for now, take the easy polling route.  Currently used only by
+ * the SMA ioctls.  Returns 0 if state reached, otherwise -ETIMEDOUT
+ * state can have multiple states set, for any of several transitions.
+ */
+
+int ipath_wait_linkstate(const ipath_type t, uint32_t state, int msecs)
+{
+	devdata[t].ipath_sma_state_wanted = state;
+	wait_event_interruptible_timeout(ipath_sma_state_wait,
+					 (devdata[t].ipath_flags & state),
+					 msecs_to_jiffies(msecs));
+	devdata[t].ipath_sma_state_wanted = 0;
+
+	if (!(devdata[t].ipath_flags & state))
+		_IPATH_DBG
+		    ("Didn't reach linkstate %s within %u ms (ibcc %llx %s)\n",
+		     /* test INIT ahead of DOWN, both can be set */
+		     (state & IPATH_LINKINIT) ? "INIT" :
+		     ((state & IPATH_LINKDOWN) ? "DOWN" :
+		      ((state & IPATH_LINKARMED) ? "ARM" : "ACTIVE")),
+		     msecs, ipath_kget_kreg64(t, kr_ibcctrl),
+		     ipath_ibcstatus_str[ipath_kget_kreg64(t, kr_ibcstatus) &
+					 0xf]);
+	return (devdata[t].ipath_flags & state) ? 0 : -ETIMEDOUT;
+}
+
+/* unit number is already validated in ipath_ioctl() */
+static int ipath_kset_lid(uint32_t arg)
+{
+	unsigned unit = (arg >> 16) & 0xffff;
+
+	if (unit >= infinipath_max
+	    || !(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", unit);
+		return -ENODEV;
+	}
+
+	arg &= 0xffff;
+	_IPATH_SMADBG("Unit %u setting lid to 0x%x, was 0x%x\n", unit, arg,
+		      devdata[unit].ipath_lid);
+	ipath_set_sps_lid(unit, arg);
+	return 0;
+}
+
+static int ipath_kset_mlid(uint32_t arg)
+{
+	unsigned unit = (arg >> 16) & 0xffff;
+
+	if (unit >= infinipath_max
+	    || !(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", unit);
+		return -ENODEV;
+	}
+
+	arg &= 0xffff;
+	_IPATH_SMADBG("Unit %u setting mlid to 0x%x, was 0x%x\n", unit, arg,
+		      devdata[unit].ipath_mlid);
+	ipath_stats.sps_mlid[unit] = devdata[unit].ipath_mlid = arg;
+	if (devdata[unit].ipath_layer.l_intr)
+		devdata[unit].ipath_layer.l_intr(unit, IPATH_LAYER_INT_BCAST);
+	return 0;
+}
+
+/* unit number is in incoming, overwritten on return with data */
+
+static int ipath_get_devstatus(uint64_t __user *a)
+{
+	int ret;
+	uint64_t unit64;
+	uint32_t unit;
+	uint64_t devstatus;
+
+	if ((ret = copy_from_user(&unit64, a, sizeof unit64))) {
+		_IPATH_DBG("Failed to copy in unit: %d\n", ret);
+		return -EFAULT;
+	}
+	unit = unit64;
+	if (unit >= infinipath_max
+	    || !(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", unit);
+		return -ENODEV;
+	}
+
+	devstatus = *devdata[unit].ipath_statusp;
+
+	if ((ret = copy_to_user(a, &devstatus, sizeof devstatus))) {
+		_IPATH_DBG("Failed to copy out device status: %d\n", ret);
+		ret = -EFAULT;
+	}
+	return ret;
+}
+
+/* unit number is in incoming, overwritten on return with data */
+
+static int ipath_get_mlid(uint32_t __user *a)
+{
+	int ret;
+	uint32_t unit;
+	uint32_t mlid;
+
+	if ((ret = copy_from_user(&unit, a, sizeof unit))) {
+		_IPATH_DBG("Failed to copy in mlid: %d\n", ret);
+		return -EFAULT;
+	}
+	if (unit >= infinipath_max
+	    || !(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", unit);
+		return -ENODEV;
+	}
+
+	mlid = devdata[unit].ipath_mlid;
+
+	if ((ret = copy_to_user(a, &mlid, sizeof mlid))) {
+		_IPATH_DBG("Failed to copy out MLID: %d\n", ret);
+		ret = -EFAULT;
+	}
+	return ret;
+}
+
+static int ipath_kset_guid(struct ipath_setguid __user *a)
+{
+	struct ipath_setguid setguid;
+	int ret;
+
+	if ((ret = copy_from_user(&setguid, a, sizeof setguid))) {
+		_IPATH_DBG("Failed to copy in guid info: %d\n", ret);
+		return -EFAULT;
+	}
+	if (setguid.sunit >= infinipath_max ||
+	    !(devdata[setguid.sunit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %llu\n", setguid.sunit);
+		return -ENODEV;
+	}
+	if (setguid.sguid == 0ULL || setguid.sguid == -1LL) {
+		/*
+		 * use INFO, not DBG, because ipath_mux doesn't yet
+		 * complain about errors on this
+		 */
+
+		_IPATH_INFO("Ignoring attempt to set invalid GUID %llx\n",
+			    setguid.sguid);
+		return -EINVAL;
+	}
+	devdata[setguid.sunit].ipath_guid = setguid.sguid;
+	devdata[setguid.sunit].ipath_nguid = 1;
+	_IPATH_DBG("SMA set hardware GUID unit %llu to %llx (network order)\n",
+		   setguid.sunit, devdata[setguid.sunit].ipath_guid);
+	return 0;
+}
+
+/*
+ * receive an IB packet with QP 0 or 1.  For now, we have no timeout implemented
+ * We put the actual received count into the iov on return, and the unit we
+ * received from goes into the lower 16 bits of sps_flags.
+ * This receives from all/any of the active chips, and we currently do not
+ * allow specifying just one (we could, by filling in unit in the library
+ * before the syscall, and checking here).
+ */
+
+static int ipath_rcvsma_pkt(struct ipath_sendpkt __user *p)
+{
+	struct ipath_sendpkt rpkt;
+	int i, any, ret;
+	unsigned long flags;
+
+	if ((ret = copy_from_user(&rpkt, p, sizeof rpkt))) {
+		_IPATH_DBG("Failed to copy in pkt struct (%d)\n", ret);
+		return -EFAULT;
+	}
+	if (!ipath_sma_data_spare) {
+		_IPATH_DBG("can't do receive, sma not initialized\n");
+		return -ENETDOWN;
+	}
+
+	for (any = i = 0; i < infinipath_max; i++)
+		if (devdata[i].ipath_flags & IPATH_INITTED)
+			any++;
+	if (!any) {		/* no hardware, freeze, etc. */
+		_IPATH_SMADBG("Didn't find any initialized and usable chips\n");
+		return -ENODEV;
+	}
+
+	wait_event_interruptible(ipath_sma_wait,
+				 ipath_sma_data[ipath_sma_first].len);
+
+	spin_lock_irqsave(&ipath_sma_lock, flags);
+	if (ipath_sma_data[ipath_sma_first].len) {
+		int len;
+		uint32_t slen;
+		uint8_t *sdata;
+		struct _ipath_sma_rpkt *smpkt =
+		    &ipath_sma_data[ipath_sma_first];
+
+		/*
+		 * we swap out the buffer we are going to use with the
+		 * spare buffer and set spare to that buffer.  This code
+		 * is the only code that ever manipulates spare, other
+		 * than the initialization code.  This code should never
+		 * be entered by more than one process at a time, and
+		 * if it is, the user  code doing so deserves what it gets;
+		 * it won't break anything in the driver by doing so.
+		 * We do it this way to avoid holding a lock across the
+		 * copy_to_user, which could fault, or delay a long time
+		 * while paging occurs; ditto for printks
+		 */
+
+		slen = smpkt->len;
+		sdata = smpkt->buf;
+		rpkt.sps_flags = smpkt->unit;
+		smpkt->buf = ipath_sma_data_spare;
+		ipath_sma_data_spare = sdata;
+		smpkt->len = 0;	/* it's available again */
+		if (++ipath_sma_first >= IPATH_NUM_SMAPKTS)
+			ipath_sma_first = 0;
+		spin_unlock_irqrestore(&ipath_sma_lock, flags);
+
+		len = min((uint32_t) rpkt.sps_iov[0].iov_len, slen);
+		ret = copy_to_user((void __user *) rpkt.sps_iov[0].iov_base,
+				   sdata, len);
+		_IPATH_VDBG("SMA packet (index=%d), len %d (actual %d) "
+			    "buf %p, ubuf %llx\n", ipath_sma_first, slen,
+			    len, sdata, rpkt.sps_iov[0].iov_base);
+		if (!ret) {
+			/* actual length read. */
+			rpkt.sps_iov[0].iov_len = len;
+			rpkt.sps_cnt = 1;	/* received one packet */
+			if ((ret = copy_to_user(p, &rpkt, sizeof rpkt))) {
+				_IPATH_DBG("Failed to copy out pkt struct "
+					   "(%d)\n", ret);
+				ret = -EFAULT;
+			}
+		} else {
+			_IPATH_DBG("copyout failed: %d\n", ret);
+			ret = -EFAULT;
+		}
+	} else {
+		/* usually means SMA process received a signal */
+		spin_unlock_irqrestore(&ipath_sma_lock, flags);
+		return -EAGAIN;
+	}
+
+	return ret;
+}
+
+/* unit number is in first word incoming, overwritten on return with data */
+static int ipath_get_portinfo(uint32_t __user *a)
+{
+	int ret;
+	uint32_t unit, tmp, tmp2;
+	struct ipath_devdata *dd;
+	uint32_t portinfo[13];	/* just the data for Portinfo, in host horder */
+
+	if ((ret = copy_from_user(&unit, a, sizeof unit))) {
+		_IPATH_DBG("Failed to copy in portinfo: %d\n", ret);
+		return -EFAULT;
+	}
+	if (unit >= infinipath_max
+	    || !(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG("Invalid unit %u\n", unit);
+		return -ENODEV;
+	}
+	dd = &devdata[unit];
+	/* so we only initialize non-zero fields. */
+	memset(portinfo, 0, sizeof portinfo);
+
+	/*
+	 * Notimpl yet M_Key (64)
+	 * Notimpl yet GID (64)
+	 */
+
+	portinfo[4] = (dd->ipath_lid << 16);
+
+	/*
+	 * Notimpl yet SMLID (should we store this in the driver, in
+	 * case SMA dies?)
+	 * CapabilityMask is 0, we don't support any of these
+	 * DiagCode is 0; we don't store any diag info for now
+	 * Notimpl yet M_KeyLeasePeriod (we don't support M_Key)
+	 */
+
+	/* LocalPortNum is whichever port number they ask for */
+	portinfo[7] = (unit << 24)
+	    /* LinkWidthEnabled */
+	    |(2 << 16)
+	    /* LinkWidthSupported (really 2, but that's not IB valid...) */
+	    |(3 << 8)
+	    /* LinkWidthActive */
+	    |(2 << 0);
+	tmp = dd->ipath_lastibcstat & 0xff;
+	tmp2 = 5;
+	if (tmp == 0x11)
+		tmp = 2;
+	else if (tmp == 0x21)
+		tmp = 3;
+	else if (tmp == 0x31)
+		tmp = 4;
+	else {
+		tmp = 0;	/* down */
+		tmp2 = tmp & 0xf;
+	}
+	portinfo[8] = (1 << 28)	/* LinkSpeedSupported */
+	    |(tmp << 24)	/* PortState */
+	    |(tmp2 << 20)	/* PortPhysicalState */
+	    |(2 << 16)
+
+	    /* LinkDownDefaultState */
+	    /* M_KeyProtectBits == 0 */
+	    /* NotImpl yet LMC == 0 (we can support all values) */
+	    |(1 << 4)		/* LinkSpeedActive */
+	    |(1 << 0);		/* LinkSpeedEnabled */
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
+		_IPATH_DBG
+		    ("Problem, ipath_ibmtu 0x%x not a valid IB MTU, treat as 2048\n",
+		     dd->ipath_ibmtu);
+		tmp = 4;
+		break;
+	}
+	portinfo[9] = (tmp << 28)
+	    /* NeighborMTU */
+	    /* Notimpl MasterSMSL */
+	    |(1 << 20)
+
+	    /* VLCap */
+	    /* Notimpl InitType (actually, an SMA decision) */
+	    /* VLHighLimit is 0 (only one VL) */
+	    ;			/* VLArbitrationHighCap is 0 (only one VL) */
+	portinfo[10] =		/* VLArbitrationLowCap is 0 (only one VL) */
+	    /* InitTypeReply is SMA decision */
+	    (5 << 16)		/* MTUCap 4096 */
+	    |(7 << 13)		/* VLStallCount */
+	    |(0x1f << 8)	/* HOQLife */
+	    |(1 << 4)		/* OperationalVLs 0 */
+
+	    /* PartitionEnforcementInbound */
+	    /* PartitionEnforcementOutbound not enforced */
+	    /* FilterRawinbound not enforced */
+	    ;			/* FilterRawOutbound not enforced */
+	/* M_KeyViolations are not counted by hardware, SMA can count */
+	tmp = ipath_kget_creg32(unit, cr_errpkey);
+	/* P_KeyViolations are counted by hardware. */
+	portinfo[11] = ((tmp & 0xffff) << 0);
+	portinfo[12] =
+	    /* Q_KeyViolations are not counted by hardware */
+	    (1 << 8)
+
+	    /* GUIDCap */
+	    /* SubnetTimeOut handled by SMA */
+	    /* RespTimeValue handled by SMA */
+	    ;
+	/* LocalPhyErrors are programmed to max */
+	portinfo[12] |= (0xf << 20)
+	    |(0xf << 16)	/* OverRunErrors are programmed to max */
+	    ;
+
+	if ((ret = copy_to_user(a, portinfo, sizeof portinfo))) {
+		_IPATH_DBG("Failed to copy out portinfo: %d\n", ret);
+		ret = -EFAULT;
+	}
+	return ret;
+}
+
+/* unit number is in first word incoming, overwritten on return with data */
+static int ipath_get_nodeinfo(uint32_t __user *a)
+{
+	int ret;
+	uint32_t unit;		/*, tmp, tmp2; */
+	struct ipath_devdata *dd;
+	uint32_t nodeinfo[10];	/* just the data for Nodeinfo, in host horder */
+
+	if ((ret = copy_from_user(&unit, a, sizeof unit))) {
+		_IPATH_DBG("Failed to copy in nodeinfo: %d\n", ret);
+		return -EFAULT;
+	}
+	if (unit >= infinipath_max
+	    || !(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		/* VDBG because sma normally probes for all possible units */
+		_IPATH_VDBG("Invalid unit %u\n", unit);
+		return -ENODEV;
+	}
+	dd = &devdata[unit];
+
+	/* so we only initialize non-zero fields. */
+	memset(nodeinfo, 0, sizeof nodeinfo);
+
+	nodeinfo[0] =		/* BaseVersion is SMA */
+	    /* ClassVersion is SMA */
+	    (1 << 8)		/* NodeType  */
+	    |(1 << 0);		/* NumPorts */
+	nodeinfo[1] = (uint32_t) (dd->ipath_guid >> 32);
+	nodeinfo[2] = (uint32_t) (dd->ipath_guid & 0xffffffff);
+	nodeinfo[3] = nodeinfo[1];	/* PortGUID == SystemImageGUID for us */
+	nodeinfo[4] = nodeinfo[2];	/* PortGUID == SystemImageGUID for us */
+	nodeinfo[5] = nodeinfo[3];	/* PortGUID == NodeGUID for us */
+	nodeinfo[6] = nodeinfo[4];	/* PortGUID == NodeGUID for us */
+	nodeinfo[7] = (4 << 16)	/* we support 4 pkeys */
+	    |(dd->ipath_deviceid << 0);
+	/* our chip version as 16 bits major, 16 bits minor */
+	nodeinfo[8] = dd->ipath_minrev | (dd->ipath_majrev << 16);
+	nodeinfo[9] = (unit << 24) | (dd->ipath_vendorid << 0);
+
+	if ((ret = copy_to_user(a, nodeinfo, sizeof nodeinfo))) {
+		_IPATH_DBG("Failed to copy out nodeinfo: %d\n", ret);
+		ret = -EFAULT;
+	}
+	return ret;
+}
+
+static int ipath_sma_ioctl(struct file *fp, unsigned int cmd, unsigned long a)
+{
+	int ret = 0;
+	switch (cmd) {
+	case IPATH_SEND_SMA_PKT:	/* send SMA packet */
+		if (!(ret = ipath_send_smapkt((struct ipath_sendpkt __user *) a)))
+			/* another SMA packet sent */
+			ipath_stats.sps_sma_spkts++;
+		break;
+	case IPATH_RCV_SMA_PKT:	/* recieve an SMA or MAD packet */
+		ret = ipath_rcvsma_pkt((struct ipath_sendpkt __user *) a);
+		break;
+	case IPATH_SET_LID:	/* set our lid, (SMA) */
+		ret = ipath_kset_lid((uint32_t) a);
+		break;
+	case IPATH_SET_MTU:	/* set the IB mtu (not maxpktlen) (SMA) */
+		ret = ipath_kset_mtu((uint32_t) a);
+		break;
+	case IPATH_SET_LINKSTATE:
+		/* walk through the linkstate states (SMA) */
+		ret = ipath_kset_linkstate((uint32_t) a);
+		break;
+	case IPATH_GET_PORTINFO:	/* get the SMA portinfo */
+		ret = ipath_get_portinfo((uint32_t __user *) a);
+		break;
+	case IPATH_GET_NODEINFO:	/* get the SMA nodeinfo */
+		ret = ipath_get_nodeinfo((uint32_t __user *) a);
+		break;
+	case IPATH_SET_GUID:
+		/*
+		 * set our guid, (SMA).  This is not normally
+		 * used, but provides a way to set the GUID when the i2c flash
+		 * has a problem, or for special testing.
+		 */
+		ret = ipath_kset_guid((struct ipath_setguid __user *) a);
+		break;
+	case IPATH_SET_MLID:	/* set multicast LID for ipath broadcast */
+		ret = ipath_kset_mlid((uint32_t) a);
+		break;
+	case IPATH_GET_MLID:	/* get multicast LID for ipath broadcast */
+		ret = ipath_get_mlid((uint32_t __user *) a);
+		break;
+	case IPATH_GET_DEVSTATUS:	/* get device status */
+		ret = ipath_get_devstatus((uint64_t __user *) a);
+		break;
+	default:
+		_IPATH_DBG("%x not a valid SMA ioctl for infinipath\n", cmd);
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int ipath_get_unit_counters(struct infinipath_getunitcounters __user *a)
+{
+	struct infinipath_getunitcounters c;
+
+	if (copy_from_user(&c, a, sizeof c))
+		return -EFAULT;
+
+	if (c.unit >= infinipath_max ||
+	   !(devdata[c.unit].ipath_flags & IPATH_PRESENT))
+		return -ENODEV;
+
+	return ipath_get_counters(c.unit,
+				  (struct infinipath_counters __user *) c.data);
+}
+
+/*
+ * ioctls for the control device, which is useful when you don't want
+ * to open the main device and use up a port.
+ */
+
+static int ipath_ctrl_ioctl(struct file *fp, unsigned int cmd, unsigned long a)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case IPATH_GETSTATS:		/* return driver stats */
+		ret = ipath_get_stats((struct infinipath_stats __user *) a);
+		break;
+	case IPATH_GETUNITCOUNTERS:	/* return chip counters */
+		ret = ipath_get_unit_counters((struct infinipath_getunitcounters __user *) a);
+		break;
+	default:
+		_IPATH_DBG("%x not a valid CTRL ioctl for infinipath\n", cmd);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+long ipath_ioctl(struct file *fp, unsigned int cmd, unsigned long a)
+{
+	int ret = 0;
+	struct ipath_portdata *pd;
+	ipath_type unit;
+	uint32_t tmp, i, nactive = 0;
+
+	if (cmd == IPATH_GETUNITS) {
+		/*
+		 * Return number of units supported.  This is called
+		 * here as this ioctl is needed via both the normal and
+		 * diags interface, and it does not need the device to
+		 * be opened.
+		 */
+		return ipath_get_units();
+	}
+
+	pd = port_fp(fp);
+	if (!pd) {
+		if (IPATH_SMA == (unsigned long)fp->private_data)
+			/* sma separate; no pd */
+			return (long)ipath_sma_ioctl(fp, cmd, a);
+#ifdef IPATH_DIAG
+		else if (IPATH_DIAG == (unsigned long)fp->private_data)
+			/* diags separate; no pd */
+			return (long)ipath_diags_ioctl(fp, cmd, a);
+#endif
+		else if (IPATH_CTRL == (unsigned long)fp->private_data)
+			/* ctrl separate; no pd */
+			return (long)ipath_ctrl_ioctl(fp, cmd, a);
+		else {
+			_IPATH_DBG("NULL pd from fp (%p), cmd=%x\n", fp, cmd);
+			return -ENODEV;	/* bad; shouldn't ever happen */
+		}
+	}
+
+	unit = pd->port_unit;
+
+	if ((devdata[unit].ipath_flags & IPATH_PRESENT)
+	    && (cmd == IPATH_GETCOUNTERS || cmd == IPATH_GETSTATS
+		|| cmd == IPATH_READ_EEPROM || cmd == IPATH_WRITE_EEPROM)) {
+		/* allowed to do these, as long as chip is accessible */
+	} else if (!(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG
+		    ("%s not initialized (flags=0x%x), failing ioctl #%u\n",
+		     ipath_get_unit_name(unit), devdata[unit].ipath_flags,
+		     _IOC_NR(cmd));
+		ret = -ENODEV;
+	} else
+	    if ((devdata[unit].
+		 ipath_flags & (IPATH_LINKDOWN | IPATH_LINKUNK))) {
+		_IPATH_DBG("%s link is down, failing ioctl #%u\n",
+			   ipath_get_unit_name(unit), _IOC_NR(cmd));
+		ret = -ENETDOWN;
+	}
+
+	if (ret)
+		return ret;
+
+	switch (cmd) {
+	case IPATH_USERINIT:
+		/* real application is starting on a port */
+		ret = ipath_do_user_init(pd, (struct ipath_user_info __user *) a);
+		break;
+	case IPATH_BASEINFO:
+		/* it's done the init, now return the info it needs */
+		ret = ipath_get_baseinfo(pd, (struct ipath_base_info __user *) a);
+		break;
+	case IPATH_GETPORT:
+		/*
+		 * just return the unit:port that we were assigned,
+		 * and the number of active chips.  This is is used for
+		 * doing sched_setaffinity() before initialization.
+		 */
+		for (i = 0; i < infinipath_max; i++)
+			if ((devdata[i].ipath_flags & IPATH_PRESENT)
+			    && devdata[i].ipath_kregbase
+			    && devdata[i].ipath_lid
+			    && !(devdata[i].ipath_flags &
+				 (IPATH_LINKDOWN | IPATH_LINKUNK)))
+				nactive++;
+		tmp = (nactive << 24) | (unit << 16) | pd->port_port;
+		if (copy_to_user((void __user *) a, &tmp, sizeof(tmp)))
+			ret = EFAULT;
+		break;
+	case IPATH_GETLID:
+		/* get LID for given unit # */
+		ret = ipath_layer_get_lid(a);
+		break;
+	case IPATH_UPDM_TID:	/* update expected TID entries */
+		ret = ipath_tid_update(pd, (struct _tidupd __user *) a);
+		break;
+	case IPATH_FREE_TID:	/* free expected TID entries */
+		ret = ipath_tid_free(pd, (struct _tidupd __user *) a);
+		break;
+	case IPATH_GETCOUNTERS:	/* return chip counters */
+		ret = ipath_get_counters(unit, (struct infinipath_counters __user *) a);
+		break;
+	case IPATH_GETSTATS:	/* return driver stats */
+		ret = ipath_get_stats((struct infinipath_stats __user *) a);
+		break;
+	case IPATH_GETUNITCOUNTERS:	/* return chip counters */
+		ret = ipath_get_unit_counters(
+			(struct infinipath_getunitcounters __user *) a);
+		break;
+	case IPATH_SET_PKEY:	/* set a partition key */
+		ret = ipath_set_partkey(pd, (uint16_t) a);
+		break;
+	case IPATH_RCVCTRL:	/* error handling to manage the rcvq */
+		ret = ipath_manage_rcvq(pd, (uint16_t) a);
+		break;
+	case IPATH_WRITE_EEPROM:
+		/* write the eeprom (for GUID) */
+		ret = ipath_wr_eeprom(pd,
+				      (struct ipath_eeprom_req __user *) a);
+		break;
+	case IPATH_READ_EEPROM:	/* read the eeprom (for GUID) */
+		ret = ipath_rd_eeprom(pd->port_unit,
+				      (struct ipath_eeprom_req __user *) a);
+		break;
+	case IPATH_WAIT:
+		/*
+		 * wait for a receive intr for this port, or PIO avail
+		 */
+		ret = ipath_wait_intr(pd, (uint32_t) a);
+		break;
+
+	default:
+		_IPATH_DBG("cmd %x (%c,%u) not a valid ioctl\n", cmd,
+			   _IOC_TYPE(cmd), _IOC_NR(cmd));
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static loff_t ipath_llseek(struct file *fp, loff_t off, int whence)
+{
+	loff_t ret;
+
+	/* range checking is done where offset is used, not here. */
+	down(&fp->f_dentry->d_inode->i_sem);
+	if (!whence)
+		ret = fp->f_pos = off;
+	else if (whence == 1) {
+		fp->f_pos += off;
+		ret = fp->f_pos;
+	} else
+		ret = -EINVAL;
+	up(&fp->f_dentry->d_inode->i_sem);
+	_IPATH_DBG("New offset %llx from seek %llx whence=%d\n", fp->f_pos, off,
+		   whence);
+
+	return ret;
+}
+
+/*
+ * We use this to have a shared buffer between the kernel and the user
+ * code for the rcvhdr queue, egr buffers, and the per-port user regs and pio
+ * buffers in the chip.  We have the open and close entries so we can bump
+ * the ref count and keep the driver from being unloaded while still mapped.
+ */
+
+static struct vm_operations_struct ipath_vmops = {
+	.nopage = ipath_nopage,
+};
+
+static int ipath_mmap(struct file *fp, struct vm_area_struct *vm)
+{
+	int setlen = 0, ret = -EINVAL;
+	struct ipath_portdata *pd;
+
+	if (fp->private_data && 255UL < (unsigned long)fp->private_data) {
+		pd = port_fp(fp);
+		{
+			/*
+			 * This is the ipath_do_user_init() code,
+			 * mapping the shared buffers into the user
+			 * process. The address referred to by vm_pgoff
+			 * is the virtual, not physical, address; we only
+			 * do one mmap for each space mapped.
+			 */
+			uint64_t pgaddr, ureg;
+
+			pgaddr = vm->vm_pgoff << PAGE_SHIFT;
+
+			/*
+			 * note that ureg does *NOT* have the kregvirt
+			 * as part of it, to be sure that for 32 bit
+			 * programs, we don't end up trying to map
+			 * a > 44 address.  Has to match ipath_get_baseinfo()
+			 * code that sets __spi_uregbase
+			 */
+
+			ureg = devdata[pd->port_unit].ipath_uregbase +
+			    devdata[pd->port_unit].ipath_palign * pd->port_port;
+
+			_IPATH_MMDBG
+			    ("ushare: pgaddr %llx vm_start=%lx, vmlen %lx\n",
+			     pgaddr, vm->vm_start, vm->vm_end - vm->vm_start);
+
+			if (pgaddr == ureg) {
+				/* it's the real hardware, so io_remap works */
+				unsigned long phys;
+				if ((vm->vm_end - vm->vm_start) > PAGE_SIZE) {
+					_IPATH_INFO
+					    ("FAIL mmap userreg: reqlen %lx > PAGE\n",
+					     vm->vm_end - vm->vm_start);
+					ret = -EFAULT;
+				} else {
+					phys =
+					    devdata[pd->port_unit].
+					    ipath_physaddr + ureg;
+					vm->vm_page_prot =
+					    pgprot_noncached(vm->vm_page_prot);
+
+					vm->vm_flags |=
+					    VM_DONTCOPY | VM_DONTEXPAND | VM_IO
+					    | VM_SHM | VM_LOCKED;
+					ret =
+			io_remap_pfn_range(vm, vm->vm_start, phys >> PAGE_SHIFT,
+					   vm->vm_end - vm->vm_start,
+					   vm->vm_page_prot);
+				}
+			} else if (pgaddr == pd->port_piobufs) {
+				/*
+				 * We use io_remap, so there is not a
+				 * nopage handler for this case!
+				 * when we map the PIO buffers, we want
+				 * to map them as writeonly, no read possible.
+				 */
+
+				unsigned long phys;
+				if ((vm->vm_end - vm->vm_start) >
+				    (devdata[pd->port_unit].ipath_pbufsport *
+				     devdata[pd->port_unit].ipath_palign)) {
+					_IPATH_INFO
+					    ("FAIL mmap piobufs: reqlen %lx > PAGE\n",
+					     vm->vm_end - vm->vm_start);
+					ret = -EFAULT;
+				} else {
+					phys =
+					    devdata[pd->port_unit].
+					    ipath_physaddr + pd->port_piobufs;
+					/*
+					 * Do *NOT* mark this as
+					 * non-cached (PWT bit), or we
+					 * don't get the write combining
+					 * behavior we want on the
+					 * PIO buffers!
+					 * vm->vm_page_prot = pgprot_noncached(vm->vm_page_prot);
+					 */
+
+#if defined (pgprot_writecombine) && defined(_PAGE_MA_WC)
+					/* Enable WC */
+					vm->vm_page_prot =
+					    pgprot_writecombine(vm->
+								vm_page_prot);
+#endif
+
+					if (vm->vm_flags & VM_READ) {
+						_IPATH_INFO
+						    ("Can't map piobufs as readable (flags=%lx)\n",
+						     vm->vm_flags);
+						ret = -EPERM;
+					} else {
+						/*
+						 * don't allow them to
+						 * later change to readable
+						 * with mprotect
+						 */
+
+						vm->vm_flags &= ~VM_MAYWRITE;
+
+						vm->vm_flags |=
+						    VM_DONTCOPY | VM_DONTEXPAND
+						    | VM_IO | VM_SHM |
+						    VM_LOCKED;
+						ret =
+			io_remap_pfn_range(vm, vm->vm_start, phys >> PAGE_SHIFT,
+					   vm->vm_end - vm->vm_start,
+					   vm->vm_page_prot);
+					}
+				}
+			} else if (pgaddr == (uint64_t) pd->port_rcvegr_phys) {
+				if (!pd->port_rcvegrbuf_virt)
+					return -EFAULT;
+				/*
+				 * page_alloc'ed egr memory, not
+				 * physically contiguous
+				 * *BUT* to work around the 32 bit mmap64
+				 * only handling 44 bits, we have remapped
+				 * the first page to kernel virtual, so
+				 * we have to do the conversion here to
+				 * get back to the original virtual
+				 * address (not contig pages) so we have
+				 * to mark this for special handling.
+				 */
+
+				/*
+				 * not egrbufs * egrsize since they are
+				 * no longer virtually contiguous.
+				 */
+				setlen = pd->port_rcvegrbuf_chunks * PAGE_SIZE *
+				    (1 << pd->port_rcvegrbuf_order);
+				if ((vm->vm_end - vm->vm_start) > setlen) {
+					_IPATH_INFO
+					    ("FAIL on egr bufs: reqlen %lx > actual %x\n",
+					     vm->vm_end - vm->vm_start, setlen);
+					ret = -EFAULT;
+				} else {
+					vm->vm_ops = &ipath_vmops;
+					vm->vm_private_data =
+					    (void *)(3 | (uint64_t) pd);
+					if (vm->vm_flags & VM_WRITE) {
+						_IPATH_INFO
+						    ("Can't map eager buffers as writable (flags=%lx)\n",
+						     vm->vm_flags);
+						ret = -EPERM;
+					} else {
+						/*
+						 * don't allow them to
+						 * later change to writeable
+						 * with mprotect
+						 */
+
+						vm->vm_flags &= ~VM_MAYWRITE;
+						_IPATH_MMDBG
+						    ("egrbufs, set private to %p, not %llx\n",
+						     vm->vm_private_data,
+						     pgaddr);
+						ret = 0;
+					}
+				}
+			} else if (pgaddr == (uint64_t) pd->port_rcvhdrq_phys) {
+				/*
+				 * kmalloc'ed memory, physically
+				 * contiguous; this is from
+				 * spi_rcvhdr_base; we allow user to
+				 * map read-write so they can write
+				 * hdrq entries to allow protocol code
+				 * to directly poll whether a hdrq entry
+				 * has been written.
+				 */
+				setlen = ALIGN(devdata[pd->port_unit].ipath_rcvhdrcnt * devdata[pd->port_unit].ipath_rcvhdrentsize * sizeof(uint32_t), PAGE_SIZE);
+				if ((vm->vm_end - vm->vm_start) > setlen) {
+					_IPATH_INFO
+					    ("FAIL on rcvhdrq: reqlen %lx > actual %x\n",
+					     vm->vm_end - vm->vm_start, setlen);
+					ret = -EFAULT;
+				} else {
+					vm->vm_ops = &ipath_vmops;
+					vm->vm_private_data =
+					    (void *)(pgaddr | 1);
+					ret = 0;
+				}
+			}
+			/*
+			 * when we map the PIO bufferavail registers,
+			 * we want to map them as readonly, no read
+			 * possible.
+			 */
+			else if (pgaddr == devdata[pd->port_unit].ipath_pioavailregs_phys) {
+				/*
+				 * kmalloc'ed memory, physically
+				 * contiguous, one page only, readonly
+				 */
+				setlen = PAGE_SIZE;
+				if ((vm->vm_end - vm->vm_start) > setlen) {
+					_IPATH_INFO
+					    ("FAIL on pioavailregs_dma: reqlen %lx > actual %x\n",
+					     vm->vm_end - vm->vm_start, setlen);
+					ret = -EFAULT;
+				} else if (vm->vm_flags & VM_WRITE) {
+					_IPATH_INFO
+					    ("Can't map pioavailregs as writable (flags=%lx)\n",
+					     vm->vm_flags);
+					ret = -EPERM;
+				} else {
+					/*
+					 * don't allow them to later
+					 * change with mprotect
+					 */
+					vm->vm_flags &= ~VM_MAYWRITE;
+					vm->vm_ops = &ipath_vmops;
+					vm->vm_private_data =
+					    (void *)(pgaddr | 2);
+					ret = 0;
+				}
+			}
+			if (!ret && setlen) {
+				/* keep page(s) from being swapped, etc. */
+				vm->vm_flags |=
+				    VM_DONTEXPAND | VM_DONTCOPY | VM_RESERVED |
+				    VM_IO | VM_SHM;
+			} else {
+				/* failure, or io_remap case */
+				vm->vm_private_data = NULL;
+				if (ret)
+					_IPATH_INFO
+					    ("Failure %d, setlen %d, on addr %lx, off %lx\n",
+					     ret, setlen, vm->vm_start,
+					     vm->vm_pgoff);
+			}
+		}
+	} else			/* something very wrong */
+		_IPATH_INFO("fp_private wasn't set, no mmaping\n");
+
+	return ret;
+}
+
+/* page fault handler.  For each page that is first faulted in from the
+ * mmap'ed shared address buffer, this routine is called.
+ * It's always for a single page.
+ * We use the low bits of the private_data field to tell us which case
+ * we are dealing with.
+ */
+
+static struct page *ipath_nopage(struct vm_area_struct *vma, unsigned long addr,
+				 int *type)
+{
+	unsigned long avirt,	/* the original [kv]malloc virtual address */
+	 paddr,			/* physical address */
+	 off;			/* calculated page offset */
+	uint32_t which, chunk;
+	void *vaddr = NULL;
+	struct ipath_portdata *pd;
+	struct page *vpage = NOPAGE_SIGBUS;
+
+	if (!(avirt = (unsigned long)vma->vm_private_data)) {
+		_IPATH_DBG("NULL private_data, vm_pgoff %lx\n", vma->vm_pgoff);
+		which = 0;	/* quiet incorrect gcc warning */
+		goto done;
+	}
+	which = avirt & 3;
+	avirt &= ~3ULL;
+
+	if (addr > vma->vm_end) {
+		_IPATH_DBG("trying to fault in addr %lx past end\n", addr);
+		goto done;
+	}
+
+	/*
+	 * most of our memory is vmalloc'ed, but rcvhdr Q is physically
+	 * contiguous, either from kmalloc or alloc_pages()
+	 * pgoff is virtual.
+	 */
+	switch (which) {
+	case 1:		/* rcvhdrq_phys */
+		/* should always be 0 */
+		off = vma->vm_pgoff - (avirt >> PAGE_SHIFT);
+		paddr = addr - vma->vm_start + (off << PAGE_SHIFT) + avirt;
+		_IPATH_MMDBG("hdrq %lx (u=%lx)\n", paddr, addr);
+		vpage = pfn_to_page(paddr >> PAGE_SHIFT);
+		break;
+	case 2:		/* PIO buffer avail regs */
+		/* should always be 0 */
+		off = vma->vm_pgoff - (avirt >> PAGE_SHIFT);
+		paddr = (addr - vma->vm_start + (off << PAGE_SHIFT) + avirt);
+		_IPATH_MMDBG("pioav %lx\n", paddr);
+		vpage = pfn_to_page(paddr >> PAGE_SHIFT);
+		break;
+	case 3:
+		/*
+		 * rcvegrbufs; page_alloc()'ed like rcvhdrq, but we
+		 * have to pick out which page_alloc()'ed chunk it is.
+		 */
+		pd = (struct ipath_portdata *) avirt;
+		/* this should always be 0 */
+		off =
+		    vma->vm_pgoff -
+		    ((unsigned long)pd->port_rcvegr_phys >> PAGE_SHIFT);
+		off = (addr - vma->vm_start + (off << PAGE_SHIFT));
+
+		chunk = off / (PAGE_SIZE * (1 << pd->port_rcvegrbuf_order));
+		if (chunk > pd->port_rcvegrbuf_chunks)
+			_IPATH_DBG("Bad egrbuf chunk %u (max %u); off = %lx\n",
+				   chunk, pd->port_rcvegrbuf_chunks, off);
+		vaddr = pd->port_rcvegrbuf_virt[chunk] +
+		    off % (PAGE_SIZE * (1 << pd->port_rcvegrbuf_order));
+		paddr = virt_to_phys(vaddr);
+		vpage = pfn_to_page(paddr >> PAGE_SHIFT);
+		_IPATH_MMDBG("egrb %p,%lx\n", vaddr, paddr);
+		break;
+	default:
+		_IPATH_DBG
+		    ("trying to fault in mmap addr %lx (avirt %lx) that isn't known (case %u)\n",
+		     addr, avirt, which);
+	}
+
+done:
+	if (vpage != NOPAGE_SIGBUS && vpage != NOPAGE_OOM) {
+		if (which == 2)
+			/*
+			 * media/video/video-buf.c doesn't do get_page() for
+			 * buffer from alloc_page().  Hmmm.
+			 *
+			 * keep it from being swapped, complaints if
+			 * process exits before we [vf]free it, etc,
+			 * and keep shared page counts correct, etc.
+			 */
+			get_page(vpage);
+		mark_page_accessed(vpage);
+		if (type)
+			*type = VM_FAULT_MINOR;
+	} else
+		_IPATH_DBG("faultin of addr %lx vaddr %p avirt %lx failed\n",
+			   addr, vaddr, avirt);
+
+	return vpage;
+}
+
+/* this is separate to allow for better optimization of ipath_intr() */
+
+static void ipath_bad_intr(const ipath_type t, uint32_t * unexpectp)
+{
+	struct ipath_devdata *dd = &devdata[t];
+
+	/*
+	 * sometimes happen during driver init and unload, don't want
+	 * to process any interrupts at that point
+	 */
+
+	/* this is just a bandaid, not a fix, if something goes badly wrong */
+	if (++*unexpectp > 100) {
+		if (++*unexpectp > 105) {
+			/*
+			 * ok, we must be taking somebody else's interrupts,
+			 * due to a messed up mptable and/or PIRQ table, so
+			 * unregister the interrupt.  We've seen this
+			 * during linuxbios development work, and it
+			 * may happen in the future again.
+			 */
+			if (dd->pcidev && dd->pcidev->irq) {
+				_IPATH_UNIT_ERROR(t,
+						  "Now %u unexpected interrupts, unregistering interrupt handler\n",
+						  *unexpectp);
+				_IPATH_DBG("free_irq of irq %x\n",
+					   dd->pcidev->irq);
+				free_irq(dd->pcidev->irq, dd);
+				dd->pcidev->irq = 0;
+			}
+		}
+		if (ipath_kget_kreg32(t, kr_intmask)) {
+			_IPATH_UNIT_ERROR(t,
+					  "%u unexpected interrupts, disabling interrupts completely\n",
+					  *unexpectp);
+			/* disable all interrupts, something is very wrong */
+			ipath_kput_kreg(t, kr_intmask, 0ULL);
+		}
+	} else if (*unexpectp > 1)
+		_IPATH_DBG
+		    ("Interrupt when not ready, should not happen, ignoring\n");
+}
+
+/* separate routine, for better optimization of ipath_intr() */
+
+static void ipath_bad_regread(const ipath_type t)
+{
+	static int allbits;
+	struct ipath_devdata *dd = &devdata[t];
+
+	/*
+	 * We print the message and disable interrupts, in hope of
+	 * having a better chance of debugging the problem.
+	 */
+	_IPATH_UNIT_ERROR(t,
+			  "Read of interrupt status failed (all bits set)\n");
+	if (allbits++) {
+		/* disable all interrupts, something is very wrong */
+		ipath_kput_kreg(t, kr_intmask, 0ULL);
+		if (allbits == 2) {
+			_IPATH_UNIT_ERROR(t,
+					  "Still bad interrupt status, unregistering interrupt\n");
+			free_irq(dd->pcidev->irq, dd);
+			dd->pcidev->irq = 0;
+		} else if (allbits > 2) {
+			if ((allbits % 10000) == 0)
+				printk(".");
+		} else
+			_IPATH_UNIT_ERROR(t,
+					  "Disabling interrupts, multiple errors\n");
+	}
+}
+
+static irqreturn_t ipath_intr(int irq, void *data, struct pt_regs *regs)
+{
+	struct ipath_devdata *dd = data;
+	const ipath_type t = IPATH_UNIT(dd);
+	uint32_t istat = ipath_kget_kreg32(t, kr_intstatus);
+	uint64_t estat = 0;
+	static unsigned unexpected = 0;
+
+	if (unlikely(!istat)) {
+		ipath_stats.sps_nullintr++;
+		/* not our interrupt, or already handled */
+		return IRQ_NONE;
+	}
+	if (unlikely(istat == -1)) {
+		ipath_bad_regread(t);
+		/* don't know if it was our interrupt or not */
+		return IRQ_NONE;
+	}
+
+	ipath_stats.sps_ints++;
+
+	/*
+	 * this needs to be flags&initted, not statusp, so we keep
+	 * taking interrupts even after link goes down, etc.
+	 * Also, we *must* clear the interrupt at some point, or we won't
+	 * take it again, which can be real bad for errors, etc...
+	 */
+
+	if (!(dd->ipath_flags & IPATH_INITTED)) {
+		ipath_bad_intr(t, &unexpected);
+		return IRQ_NONE;
+	}
+	if (unexpected)
+		unexpected = 0;
+
+	if (istat & ~infinipath_i_bitsextant)
+		_IPATH_UNIT_ERROR(t,
+				  "interrupt with unknown interrupts %x set\n",
+				  istat & (uint32_t) ~ infinipath_i_bitsextant);
+
+	if (istat & INFINIPATH_I_ERROR) {
+		ipath_stats.sps_errints++;
+		estat = ipath_kget_kreg64(t, kr_errorstatus);
+		if (!estat)
+			_IPATH_INFO
+			    ("error interrupt (%x), but no error bits set!\n",
+			     istat);
+		else if (estat == -1LL)
+			/*
+			 * should we try clearing all, or hope next read
+			 * works?
+			 */
+			_IPATH_UNIT_ERROR(t,
+					  "Read of error status failed (all bits set); ignoring\n");
+		else
+			ipath_handle_errors(t, estat);
+	}
+
+	if (istat & INFINIPATH_I_GPIO) {
+		/* Clear GPIO status bit 2 */
+		ipath_kput_kreg(t, kr_gpio_clear, (uint64_t)(1 << 2));
+
+		/*
+		 * Packets are available in the port 0 receive queue.
+		 * Eventually this needs to be generalized to check
+		 * IPATH_GPIO_INTR, and the specific GPIO bit, when
+		 * GPIO interrupts start being used for other things.
+		 * We skip that now to improve performance.
+		 */
+		ipath_kreceive(t);
+	}
+
+	/*
+	 * clear the ones we will deal with on this round
+	 * We clear it early, mostly for receive interrupts, so we
+	 * know the chip will have seen this by the time we process
+	 * the queue, and will re-interrupt if necessary.  The processor
+	 * itself won't take the interrupt again until we return.
+	 */
+	ipath_kput_kreg(t, kr_intclear, istat);
+
+	if (istat & INFINIPATH_I_SPIOBUFAVAIL) {
+		atomic_clear_mask(INFINIPATH_S_PIOINTBUFAVAIL,
+				  &dd->ipath_sendctrl);
+		ipath_kput_kreg(t, kr_sendctrl, dd->ipath_sendctrl);
+
+		if (dd->ipath_portpiowait) {
+			uint32_t i;
+			/*
+			 * start from port 1, since for now port 0  is
+			 * never using wait_event for PIO
+			 */
+			for (i = 1;
+			     dd->ipath_portpiowait && i < dd->ipath_cfgports;
+			     i++) {
+				if (dd->ipath_pd[i]
+				    && dd->ipath_portpiowait & (1U << i)) {
+					atomic_clear_mask(1U << i,
+							  &dd->
+							  ipath_portpiowait);
+					if (dd->ipath_pd[i]->
+					    port_flag & IPATH_PORT_WAITING_PIO)
+					{
+						dd->ipath_pd[i]->port_flag &=
+						    ~IPATH_PORT_WAITING_PIO;
+						wake_up_interruptible(&dd->
+								      ipath_pd
+								      [i]->
+								      port_wait);
+					}
+				}
+			}
+		}
+
+		if (dd->ipath_layer.l_intr) {
+			if (dd->ipath_layer.l_intr(t,
+				IPATH_LAYER_INT_SEND_CONTINUE)) {
+				atomic_set_mask(INFINIPATH_S_PIOINTBUFAVAIL,
+						&dd->ipath_sendctrl);
+				ipath_kput_kreg(t, kr_sendctrl,
+						dd->ipath_sendctrl);
+			}
+		}
+
+		if (dd->verbs_layer.l_piobufavail) {
+			if (!dd->verbs_layer.l_piobufavail(t)) {
+				atomic_set_mask(INFINIPATH_S_PIOINTBUFAVAIL,
+						&dd->ipath_sendctrl);
+				ipath_kput_kreg(t, kr_sendctrl,
+						dd->ipath_sendctrl);
+			}
+		}
+	}
+
+	/*
+	 * we check for both transition from empty to non-empty, and urgent
+	 * packets (those with the interrupt bit set in the header)
+	 */
+
+	if (istat & ((infinipath_i_rcvavail_mask << INFINIPATH_I_RCVAVAIL_SHIFT)
+		     | (infinipath_i_rcvurg_mask << INFINIPATH_I_RCVURG_SHIFT))) {
+		uint64_t portr;
+		int i;
+		uint32_t rcvdint = 0;
+
+		portr = ((istat >> INFINIPATH_I_RCVAVAIL_SHIFT) &
+			 infinipath_i_rcvavail_mask)
+		    | ((istat >> INFINIPATH_I_RCVURG_SHIFT) &
+		       infinipath_i_rcvurg_mask);
+		for (i = 0; i < dd->ipath_cfgports; i++) {
+			if (portr & (1 << i) && dd->ipath_pd[i]) {
+				if (i == 0)
+					ipath_kreceive(t);
+				else if (dd->ipath_pd[i]->
+					 port_flag & IPATH_PORT_WAITING_RCV) {
+					atomic_clear_mask
+					    (IPATH_PORT_WAITING_RCV,
+					     &dd->ipath_pd[i]->port_flag);
+					wake_up_interruptible(&dd->ipath_pd[i]->
+							      port_wait);
+					rcvdint |= 1U << i;
+				}
+			}
+		}
+		if (rcvdint) {
+			/*
+			 * only want to take one interrupt, so turn off
+			 * the rcv interrupt for all the ports that we
+			 * did the wakeup on (but never for kernel port)
+			 */
+			atomic_clear_mask(rcvdint <<
+					  INFINIPATH_R_INTRAVAIL_SHIFT,
+					  &dd->ipath_rcvctrl);
+			ipath_kput_kreg(t, kr_rcvctrl, dd->ipath_rcvctrl);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void ipath_decode_err(char *buf, size_t blen, uint64_t err)
+{
+	*buf = '\0';
+	if (err & INFINIPATH_E_RHDRLEN)
+		strlcat(buf, "rhdrlen ", blen);
+	if (err & INFINIPATH_E_RBADTID)
+		strlcat(buf, "rbadtid ", blen);
+	if (err & INFINIPATH_E_RBADVERSION)
+		strlcat(buf, "rbadversion ", blen);
+	if (err & INFINIPATH_E_RHDR)
+		strlcat(buf, "rhdr ", blen);
+	if (err & INFINIPATH_E_RLONGPKTLEN)
+		strlcat(buf, "rlongpktlen ", blen);
+	if (err & INFINIPATH_E_RSHORTPKTLEN)
+		strlcat(buf, "rshortpktlen ", blen);
+	if (err & INFINIPATH_E_RMAXPKTLEN)
+		strlcat(buf, "rmaxpktlen ", blen);
+	if (err & INFINIPATH_E_RMINPKTLEN)
+		strlcat(buf, "rminpktlen ", blen);
+	if (err & INFINIPATH_E_RFORMATERR)
+		strlcat(buf, "rformaterr ", blen);
+	if (err & INFINIPATH_E_RUNSUPVL)
+		strlcat(buf, "runsupvl ", blen);
+	if (err & INFINIPATH_E_RUNEXPCHAR)
+		strlcat(buf, "runexpchar ", blen);
+	if (err & INFINIPATH_E_RIBFLOW)
+		strlcat(buf, "ribflow ", blen);
+	if (err & INFINIPATH_E_REBP)
+		strlcat(buf, "EBP ", blen);
+	if (err & INFINIPATH_E_SUNDERRUN)
+		strlcat(buf, "sunderrun ", blen);
+	if (err & INFINIPATH_E_SPIOARMLAUNCH)
+		strlcat(buf, "spioarmlaunch ", blen);
+	if (err & INFINIPATH_E_SUNEXPERRPKTNUM)
+		strlcat(buf, "sunexperrpktnum ", blen);
+	if (err & INFINIPATH_E_SDROPPEDDATAPKT)
+		strlcat(buf, "sdroppeddatapkt ", blen);
+	if (err & INFINIPATH_E_SDROPPEDSMPPKT)
+		strlcat(buf, "sdroppedsmppkt ", blen);
+	if (err & INFINIPATH_E_SMAXPKTLEN)
+		strlcat(buf, "smaxpktlen ", blen);
+	if (err & INFINIPATH_E_SMINPKTLEN)
+		strlcat(buf, "sminpktlen ", blen);
+	if (err & INFINIPATH_E_SUNSUPVL)
+		strlcat(buf, "sunsupVL ", blen);
+	if (err & INFINIPATH_E_SPKTLEN)
+		strlcat(buf, "spktlen ", blen);
+	if (err & INFINIPATH_E_INVALIDADDR)
+		strlcat(buf, "invalidaddr ", blen);
+	if (err & INFINIPATH_E_RICRC)
+		strlcat(buf, "CRC ", blen);
+	if (err & INFINIPATH_E_RVCRC)
+		strlcat(buf, "VCRC ", blen);
+	if (err & INFINIPATH_E_RRCVEGRFULL)
+		strlcat(buf, "rcvegrfull ", blen);
+	if (err & INFINIPATH_E_RRCVHDRFULL)
+		strlcat(buf, "rcvhdrfull ", blen);
+	if (err & INFINIPATH_E_IBSTATUSCHANGED)
+		strlcat(buf, "ibcstatuschg ", blen);
+	if (err & INFINIPATH_E_RIBLOSTLINK)
+		strlcat(buf, "riblostlink ", blen);
+	if (err & INFINIPATH_E_HARDWARE)
+		strlcat(buf, "hardware ", blen);
+	if (err & INFINIPATH_E_RESET)
+		strlcat(buf, "reset ", blen);
+}
+
+/* decode RHF errors; only used one place now, may want more later */
+static void get_rhf_errstring(uint32_t err, char *msg, size_t len)
+{
+	/* if no errors, and so don't need to check what's first */
+	*msg = '\0';
+
+	if (err & INFINIPATH_RHF_H_ICRCERR)
+		strlcat(msg, "icrcerr ", len);
+	if (err & INFINIPATH_RHF_H_VCRCERR)
+		strlcat(msg, "vcrcerr ", len);
+	if (err & INFINIPATH_RHF_H_PARITYERR)
+		strlcat(msg, "parityerr ", len);
+	if (err & INFINIPATH_RHF_H_LENERR)
+		strlcat(msg, "lenerr ", len);
+	if (err & INFINIPATH_RHF_H_MTUERR)
+		strlcat(msg, "mtuerr ", len);
+	if (err & INFINIPATH_RHF_H_IHDRERR)
+		/* infinipath hdr checksum error */
+		strlcat(msg, "ipathhdrerr ", len);
+	if (err & INFINIPATH_RHF_H_TIDERR)
+		strlcat(msg, "tiderr ", len);
+	if (err & INFINIPATH_RHF_H_MKERR)
+		/* bad port, offset, etc. */
+		strlcat(msg, "invalid ipathhdr ", len);
+	if (err & INFINIPATH_RHF_H_IBERR)
+		strlcat(msg, "iberr ", len);
+	if (err & INFINIPATH_RHF_L_SWA)
+		strlcat(msg, "swA ", len);
+	if (err & INFINIPATH_RHF_L_SWB)
+		strlcat(msg, "swB ", len);
+}
+
+static void ipath_handle_errors(const ipath_type t, uint64_t errs)
+{
+	char msg[512];
+	uint32_t piobcnt;
+	uint64_t sbuf[4], ignore_this_time = 0;
+	int i;
+	int chkerrpkts = 0, noprint = 0;
+	cycles_t nc;
+	static cycles_t nextmsg_time;
+	static unsigned nmsgs, supp_msgs;
+	struct ipath_devdata *dd = &devdata[t];
+
+#define E_SUM_PKTERRS (INFINIPATH_E_RHDRLEN | INFINIPATH_E_RBADTID \
+     | INFINIPATH_E_RBADVERSION \
+     | INFINIPATH_E_RHDR | INFINIPATH_E_RLONGPKTLEN | INFINIPATH_E_RSHORTPKTLEN \
+     | INFINIPATH_E_RMAXPKTLEN | INFINIPATH_E_RMINPKTLEN \
+     | INFINIPATH_E_RFORMATERR | INFINIPATH_E_RUNSUPVL | INFINIPATH_E_RUNEXPCHAR \
+     | INFINIPATH_E_REBP)
+
+#define E_SUM_ERRS ( INFINIPATH_E_SPIOARMLAUNCH \
+    | INFINIPATH_E_SUNEXPERRPKTNUM | INFINIPATH_E_SDROPPEDDATAPKT \
+    | INFINIPATH_E_SDROPPEDSMPPKT | INFINIPATH_E_SMAXPKTLEN \
+    | INFINIPATH_E_SUNSUPVL | INFINIPATH_E_SMINPKTLEN | INFINIPATH_E_SPKTLEN \
+    | INFINIPATH_E_INVALIDADDR)
+
+	/*
+	 * throttle back "fast" messages to no more than 10 per 5 seconds
+	 * (1.4-2GHz clock).  This isn't perfect, but it's a reasonable
+	 * heuristic
+	 * If we get more than 10, give a 5x longer delay
+	 */
+	nc = get_cycles();
+	if (nmsgs > 10) {
+		if (nc < nextmsg_time) {
+			noprint = 1;
+			if (!supp_msgs++)
+				nextmsg_time = nc + 50000000000ULL;
+		} else if (supp_msgs) {
+			/*
+			 * Print the message unless it's ibc status
+			 * change only, which happens so often we never
+			 * want to count it.
+			 */
+			if (dd->ipath_lasterror & ~INFINIPATH_E_IBSTATUSCHANGED) {
+				ipath_decode_err(msg, sizeof msg,
+						 dd->
+						 ipath_lasterror &
+						 ~INFINIPATH_E_IBSTATUSCHANGED);
+				if (dd->
+				    ipath_lasterror & ~(INFINIPATH_E_RRCVEGRFULL
+							|
+							INFINIPATH_E_RRCVHDRFULL))
+					_IPATH_UNIT_ERROR(t,
+							  "Suppressed %u messages for fast-repeating errors (%s) (%llx)\n",
+							  supp_msgs, msg,
+							  dd->ipath_lasterror);
+				else {
+					/*
+					 * rcvegrfull and rcvhdrqfull are
+					 * "normal", for some types of
+					 * processes (mostly benchmarks)
+					 * that send huge numbers of
+					 * messages, while not processing
+					 * them.  So only complain about
+					 * these at debug level.
+					 */
+					_IPATH_DBG
+					    ("Suppressed %u messages for %s\n",
+					     supp_msgs, msg);
+				}
+			}
+			supp_msgs = 0;
+			nmsgs = 0;
+		}
+	} else if (!nmsgs++ || nc > nextmsg_time)	/* start timer */
+		nextmsg_time = nc + 10000000000ULL;
+
+	/*
+	 * don't report errors that are masked (includes those always
+	 * ignored)
+	 */
+	errs &= ~dd->ipath_maskederrs;
+
+	/* do these first, they are most important */
+	if (errs & INFINIPATH_E_HARDWARE) {
+		/* reuse same msg buf */
+		ipath_handle_hwerrors(t, msg, sizeof msg);
+	}
+
+	if (!noprint && (errs & ~infinipath_e_bitsextant))
+		_IPATH_UNIT_ERROR(t,
+				  "error interrupt with unknown errors %llx set\n",
+				  errs & ~infinipath_e_bitsextant);
+
+	if (errs & E_SUM_ERRS) {
+		/* if possible that sendbuffererror could be valid */
+		piobcnt = dd->ipath_piobcnt;
+		/* read these before writing errorclear */
+		sbuf[0] = ipath_kget_kreg64(t, kr_sendbuffererror);
+		sbuf[1] = ipath_kget_kreg64(t, kr_sendbuffererror + 1);
+		if (piobcnt > 128) {
+			sbuf[2] = ipath_kget_kreg64(t, kr_sendbuffererror + 2);
+			sbuf[3] = ipath_kget_kreg64(t, kr_sendbuffererror + 3);
+		}
+
+		if (sbuf[0] || sbuf[1]
+		    || (piobcnt > 128 && (sbuf[2] || sbuf[3]))) {
+			_IPATH_PDBG("SendbufErrs %llx %llx ", sbuf[0], sbuf[1]);
+			if (infinipath_debug & __IPATH_PKTDBG && piobcnt > 128)
+				printk("%llx %llx ", sbuf[2], sbuf[3]);
+			for (i = 0; i < piobcnt; i++) {
+				if (test_bit(i, sbuf)) {
+					uint32_t sendctrl;
+					if (infinipath_debug & __IPATH_PKTDBG)
+						printk("%u ", i);
+					sendctrl =
+					    dd->
+					    ipath_sendctrl | INFINIPATH_S_DISARM
+					    | (i <<
+					       INFINIPATH_S_DISARMPIOBUF_SHIFT);
+					ipath_kput_kreg(t, kr_sendctrl,
+							sendctrl);
+				}
+			}
+			if (infinipath_debug & __IPATH_PKTDBG)
+				printk("\n");
+		}
+		if ((errs &
+		     (INFINIPATH_E_SDROPPEDDATAPKT | INFINIPATH_E_SDROPPEDSMPPKT
+		      | INFINIPATH_E_SMINPKTLEN))
+		    && !(dd->ipath_flags & IPATH_LINKACTIVE)) {
+			/*
+			 * This can happen when SMA is trying to bring
+			 * the link up, but the IB link changes state
+			 * at the "wrong" time.  The IB logic then
+			 * complains that the packet isn't valid.
+			 * We don't want to confuse people, so we just
+			 * don't print them, except at debug
+			 */
+			_IPATH_DBG
+			    ("Ignoring pktsend errors %llx, because not yet active\n",
+			     errs);
+			ignore_this_time |=
+			    INFINIPATH_E_SDROPPEDDATAPKT |
+			    INFINIPATH_E_SDROPPEDSMPPKT |
+			    INFINIPATH_E_SMINPKTLEN;
+		}
+	}
+
+	if (supp_msgs == 250000) {
+		/*
+		 * It's not entirely reasonable assuming that the errors
+		 * set in the last clear period are all responsible for
+		 * the problem, but the alternative is to assume it's the only
+		 * ones on this particular interrupt, which also isn't great
+		 */
+		dd->ipath_maskederrs |= dd->ipath_lasterror | errs;
+		ipath_kput_kreg(t, kr_errormask, ~dd->ipath_maskederrs);
+		ipath_decode_err(msg, sizeof msg,
+				 (dd->ipath_maskederrs & ~dd->
+				  ipath_ignorederrs));
+
+		if ((dd->ipath_maskederrs & ~dd->ipath_ignorederrs)
+		    & ~(INFINIPATH_E_RRCVEGRFULL | INFINIPATH_E_RRCVHDRFULL))
+			_IPATH_UNIT_ERROR(t,
+					  "Disabling error(s) %llx because occuring too frequently (%s)\n",
+					  (dd->ipath_maskederrs & ~dd->
+					   ipath_ignorederrs), msg);
+		else {
+			/*
+			 * rcvegrfull and rcvhdrqfull are "normal",
+			 * for some types of processes (mostly benchmarks)
+			 * that send huge numbers of messages, while not
+			 * processing them.  So only complain about
+			 * these at debug level.
+			 */
+			_IPATH_DBG
+			    ("Disabling frequent queue full errors (%s)\n",
+			     msg);
+		}
+
+		/*
+		 * re-enable the masked errors after around 3 minutes.
+		 * in ipath_get_faststats().  If we have a series of
+		 * fast repeating but different errors, the interval will keep
+		 * stretching out, but that's OK, as that's pretty catastrophic.
+		 */
+		dd->ipath_unmasktime = nc + 400000000000ULL;
+	}
+
+	ipath_kput_kreg(t, kr_errorclear, errs);
+	if (ignore_this_time)
+		errs &= ~ignore_this_time;
+	if (errs & ~dd->ipath_lasterror) {
+		errs &= ~dd->ipath_lasterror;
+		/* never suppress duplicate hwerrors or ibstatuschange */
+		dd->ipath_lasterror |= errs &
+		    ~(INFINIPATH_E_HARDWARE | INFINIPATH_E_IBSTATUSCHANGED);
+	}
+	if (!errs)
+		return;
+
+	if (!noprint)
+		/* the ones we mask off are handled specially below or above */
+		ipath_decode_err(msg, sizeof msg,
+				 errs & ~(INFINIPATH_E_IBSTATUSCHANGED |
+					  INFINIPATH_E_RRCVEGRFULL |
+					  INFINIPATH_E_RRCVHDRFULL |
+					  INFINIPATH_E_HARDWARE));
+	else
+		/* so we don't need if (!noprint) at strlcat's below */
+		*msg = 0;
+
+	if (errs & E_SUM_PKTERRS) {
+		ipath_stats.sps_pkterrs++;
+		chkerrpkts = 1;
+	}
+	if (errs & E_SUM_ERRS)
+		ipath_stats.sps_errs++;
+
+	if (errs & (INFINIPATH_E_RICRC | INFINIPATH_E_RVCRC)) {
+		ipath_stats.sps_crcerrs++;
+		chkerrpkts = 1;
+	}
+
+	/*
+	 * We don't want to print these two as they happen, or we can make
+	 * the situation even worse, because it takes so long to print messages.
+	 * to serial consoles.  kernel ports get printed from fast_stats, no
+	 * more than every 5 seconds, user ports get printed on close
+	 */
+	if (errs & INFINIPATH_E_RRCVHDRFULL) {
+		int any;
+		uint32_t hd, tl;
+		ipath_stats.sps_hdrqfull++;
+		for (any = i = 0; i < dd->ipath_cfgports; i++) {
+			if (i == 0) {
+				hd = dd->ipath_port0head;
+				tl = *dd->ipath_hdrqtailptr;
+			} else if (dd->ipath_pd[i] &&
+				   dd->ipath_pd[i]->port_rcvhdrtail_kvaddr) {
+				/*
+				 * don't report same point multiple times,
+				 * except kernel
+				 */
+				tl = (uint32_t) *
+				    dd->ipath_pd[i]->port_rcvhdrtail_kvaddr;
+				if (tl == dd->ipath_lastrcvhdrqtails[i])
+					continue;
+				hd = ipath_kget_ureg32(t, ur_rcvhdrhead, i);
+			} else
+				continue;
+			if (hd == (tl + 1) || (!hd && tl == dd->ipath_hdrqlast)) {
+				dd->ipath_lastrcvhdrqtails[i] = tl;
+				dd->ipath_pd[i]->port_hdrqfull++;
+				if (i == 0)
+					chkerrpkts = 1;
+			}
+		}
+	}
+	if (errs & INFINIPATH_E_RRCVEGRFULL) {
+		/*
+		 * since this is of less importance and not likely to
+		 * happen without also getting hdrfull, only count
+		 * occurrences; don't check each port (or even the kernel
+		 * vs user)
+		 */
+		ipath_stats.sps_etidfull++;
+		if (dd->ipath_port0head != *dd->ipath_hdrqtailptr)
+			chkerrpkts = 1;
+	}
+
+	/*
+	 * do this before IBSTATUSCHANGED, in case both bits set in a single
+	 * interrupt; we want the STATUSCHANGE to "win", so we do our
+	 * internal copy of state machine correctly
+	 */
+	if (errs & INFINIPATH_E_RIBLOSTLINK) {
+		/* force through block below */
+		errs |= INFINIPATH_E_IBSTATUSCHANGED;
+		ipath_stats.sps_iblink++;
+		dd->ipath_flags |= IPATH_LINKDOWN;
+		dd->ipath_flags &= ~(IPATH_LINKUNK | IPATH_LINKINIT
+				     | IPATH_LINKARMED | IPATH_LINKACTIVE);
+		if (!noprint)
+			_IPATH_DBG("Lost link, link now down (%s)\n",
+				   ipath_ibcstatus_str[ipath_kget_kreg64
+						       (t,
+							kr_ibcstatus) & 0xf]);
+	}
+
+	if ((errs & INFINIPATH_E_IBSTATUSCHANGED) && (!ipath_diags_enabled)) {
+		uint64_t val;
+		uint32_t ltstate;
+
+		val = ipath_kget_kreg64(t, kr_ibcstatus);
+		ltstate = val & 0xff;
+		if (ltstate == 0x11 || ltstate == 0x21 || ltstate == 0x31)
+			_IPATH_DBG("Link state changed unit %u to 0x%x, last was 0x%llx\n",
+				t, ltstate, dd->ipath_lastibcstat);
+		else {
+			ltstate = dd->ipath_lastibcstat & 0xff;
+			if (ltstate == 0x11 || ltstate == 0x21 || ltstate == 0x31)
+				_IPATH_DBG("Link state unit %u changed to down state 0x%llx, last was 0x%llx\n",
+					t, val, dd->ipath_lastibcstat);
+			else
+				_IPATH_VDBG("Link state unit %u changed to 0x%llx from one of down states\n",
+					t, val);
+		}
+		ltstate = (val >> INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) &
+		    INFINIPATH_IBCS_LINKTRAININGSTATE_MASK;
+
+		if (ltstate == 2 || ltstate == 3) {
+			uint32_t last_ltstate;
+
+			/*
+			 * ignore cycling back and forth from states 2 to 3
+			 * while waiting for other end of link to come up
+			 * except that if it keeps happening, we switch between
+			 * linkinitstate SLEEP and POLL.  While we cycle
+			 * back and forth between them, we aren't seeing
+			 * any other device, either no cable plugged in,
+			 * other device powered off, other device is
+			 * switch that hasn't yet polled us, etc.
+			 */
+			last_ltstate = (dd->ipath_lastibcstat >>
+					INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT)
+			    & INFINIPATH_IBCS_LINKTRAININGSTATE_MASK;
+			if (last_ltstate == 2 || last_ltstate == 3) {
+				if (++dd->ipath_ibpollcnt > 4) {
+					uint64_t ibc;
+					dd->ipath_flags |=
+					    IPATH_LINK_SLEEPING | IPATH_NOCABLE;
+					*dd->ipath_statusp |=
+					    IPATH_STATUS_IB_NOCABLE;
+					_IPATH_VDBG
+					    ("linkinitcmd POLL, move to SLEEP\n");
+					ibc = dd->ipath_ibcctrl;
+					ibc |= INFINIPATH_IBCC_LINKINITCMD_SLEEP
+					    <<
+					    INFINIPATH_IBCC_LINKINITCMD_SHIFT;
+					/*
+					 * don't put linkinitcmd in
+					 * ipath_ibcctrl, want that to
+					 * stay a NOP
+					 */
+					ipath_kput_kreg(t, kr_ibcctrl, ibc);
+					dd->ipath_ibpollcnt = 0;
+				}
+				goto skip_ibchange;
+			}
+		}
+		/* some state other than 2 or 3 */
+		dd->ipath_ibpollcnt = 0;
+		ipath_stats.sps_iblink++;
+		/*
+		 * Note:  We try to match the Mellanox HCA LED behavior
+		 * as best we can.  That changed around Oct 2003.
+		 * Green indicates link state (something is plugged in,
+		 * and we can train).  Amber indicates the link is
+		 * logically up (ACTIVE).  Mellanox further blinks the
+		 * amber LED to indicate data packet activity, but we
+		 * have no hardware support for that, so it would require
+		 * waking up every 10-20 msecs and checking the counters
+		 * on the chip, and then turning the LED off if
+		 * appropriate.  That's visible overhead, so not something
+		 * we will do.
+		 */
+		if (ltstate != 1 || ((dd->ipath_lastibcstat & 0x30) == 0x30 &&
+				     (val & 0x30) != 0x30)) {
+			dd->ipath_flags |= IPATH_LINKDOWN;
+			dd->ipath_flags &= ~(IPATH_LINKUNK | IPATH_LINKINIT
+					     | IPATH_LINKACTIVE |
+					     IPATH_LINKARMED);
+			*dd->ipath_statusp &= ~IPATH_STATUS_IB_READY;
+			if (!noprint) {
+				if ((dd->ipath_lastibcstat & 0x30) == 0x30)
+					/* if from up to down be more vocal */
+					_IPATH_DBG("Link unit %u is now down (%s)\n",
+						   t, ipath_ibcstatus_str
+						   [ltstate]);
+				else
+					_IPATH_VDBG("Link unit %u is down (%s)\n",
+						    t, ipath_ibcstatus_str
+						    [ltstate]);
+			}
+
+			if (val & 0x30) {
+				/* leave just green on, 0x11 and 0x21 */
+				dd->ipath_extctrl &=
+				    ~INFINIPATH_EXTC_LEDPRIPORTYELLOWON;
+				dd->ipath_extctrl |=
+				    INFINIPATH_EXTC_LEDPRIPORTGREENON;
+			} else	/* not up at all, so turn the leds off */
+				dd->ipath_extctrl &=
+				    ~(INFINIPATH_EXTC_LEDPRIPORTGREENON |
+				      INFINIPATH_EXTC_LEDPRIPORTYELLOWON);
+			ipath_kput_kreg(t, kr_extctrl,
+					(uint64_t) dd->ipath_extctrl);
+			if (ltstate == 1
+			    && (dd->
+				ipath_flags & (IPATH_LINK_TOARMED |
+					       IPATH_LINK_TOACTIVE))) {
+				ipath_set_ib_lstate(t,
+						    INFINIPATH_IBCC_LINKCMD_INIT);
+			}
+		} else if ((val & 0x31) == 0x31) {
+			if (!noprint)
+				_IPATH_DBG("Link unit %u is now in active state\n", t);
+			dd->ipath_flags |= IPATH_LINKACTIVE;
+			dd->ipath_flags &=
+			    ~(IPATH_LINKUNK | IPATH_LINKINIT | IPATH_LINKDOWN |
+			      IPATH_LINKARMED | IPATH_NOCABLE |
+			      IPATH_LINK_TOACTIVE | IPATH_LINK_SLEEPING);
+			*dd->ipath_statusp &= ~IPATH_STATUS_IB_NOCABLE;
+			*dd->ipath_statusp |=
+			    IPATH_STATUS_IB_READY | IPATH_STATUS_IB_CONF;
+			/* set the externally visible LEDs to indicate state */
+			dd->ipath_extctrl |= INFINIPATH_EXTC_LEDPRIPORTGREENON
+			    | INFINIPATH_EXTC_LEDPRIPORTYELLOWON;
+			ipath_kput_kreg(t, kr_extctrl,
+					(uint64_t) dd->ipath_extctrl);
+
+			/*
+			 * since we are now active, set the linkinitcmd
+			 * to NOP (0) it was probably either POLL or SLEEP
+			 */
+			dd->ipath_ibcctrl &=
+			    ~(INFINIPATH_IBCC_LINKINITCMD_MASK <<
+			      INFINIPATH_IBCC_LINKINITCMD_SHIFT);
+			ipath_kput_kreg(t, kr_ibcctrl, dd->ipath_ibcctrl);
+
+			if (devdata[t].ipath_layer.l_intr)
+				devdata[t].ipath_layer.l_intr(t,
+							      IPATH_LAYER_INT_IF_UP);
+		} else if ((val & 0x31) == 0x11) {
+			/*
+			 * set set INIT and DOWN.  Down is checked by
+			 * most of the other code, but INIT is useful
+			 * to know in a few places.
+			 */
+			dd->ipath_flags |= IPATH_LINKINIT | IPATH_LINKDOWN;
+			dd->ipath_flags &=
+			    ~(IPATH_LINKUNK | IPATH_LINKACTIVE | IPATH_LINKARMED
+			      | IPATH_NOCABLE | IPATH_LINK_SLEEPING);
+			*dd->ipath_statusp &= ~(IPATH_STATUS_IB_NOCABLE
+				| IPATH_STATUS_IB_READY);
+
+			/* set the externally visible LEDs to indicate state */
+			dd->ipath_extctrl &=
+			    ~INFINIPATH_EXTC_LEDPRIPORTYELLOWON;
+			dd->ipath_extctrl |= INFINIPATH_EXTC_LEDPRIPORTGREENON;
+			ipath_kput_kreg(t, kr_extctrl,
+					(uint64_t) dd->ipath_extctrl);
+			if (dd->
+			    ipath_flags & (IPATH_LINK_TOARMED |
+					   IPATH_LINK_TOACTIVE)) {
+				/*
+				 * if we got here while trying to bring
+				 * the link up, try again, but only once more!
+				 */
+				ipath_set_ib_lstate(t,
+						    INFINIPATH_IBCC_LINKCMD_ARMED);
+				dd->ipath_flags &=
+				    ~(IPATH_LINK_TOARMED | IPATH_LINK_TOACTIVE);
+			}
+		} else if ((val & 0x31) == 0x21) {
+			dd->ipath_flags |= IPATH_LINKARMED;
+			dd->ipath_flags &=
+			    ~(IPATH_LINKUNK | IPATH_LINKDOWN | IPATH_LINKINIT |
+			      IPATH_LINKACTIVE | IPATH_NOCABLE |
+			      IPATH_LINK_TOARMED | IPATH_LINK_SLEEPING);
+			*dd->ipath_statusp &= ~(IPATH_STATUS_IB_NOCABLE
+				| IPATH_STATUS_IB_READY);
+			/*
+			 * set the externally visible LEDs to indicate
+			 * state (same as 0x11)
+			 */
+			dd->ipath_extctrl &=
+			    ~INFINIPATH_EXTC_LEDPRIPORTYELLOWON;
+			dd->ipath_extctrl |= INFINIPATH_EXTC_LEDPRIPORTGREENON;
+			ipath_kput_kreg(t, kr_extctrl,
+					(uint64_t) dd->ipath_extctrl);
+			if (dd->ipath_flags & IPATH_LINK_TOACTIVE) {
+				/*
+				 * if we got here while trying to bring
+				 * the link up, try again, but only once more!
+				 */
+				ipath_set_ib_lstate(t,
+						    INFINIPATH_IBCC_LINKCMD_ACTIVE);
+				dd->ipath_flags &= ~IPATH_LINK_TOACTIVE;
+			}
+		} else {
+			if (dd->
+			    ipath_flags & (IPATH_LINK_TOARMED |
+					   IPATH_LINK_TOACTIVE))
+				ipath_set_ib_lstate(t,
+						    INFINIPATH_IBCC_LINKCMD_INIT);
+			else if (!noprint)
+				_IPATH_DBG("IBstatuschange unit %u: %s\n",
+					  t, ipath_ibcstatus_str[ltstate]);
+		}
+		dd->ipath_lastibcstat = val;
+	}
+
+skip_ibchange:
+
+	if (errs & INFINIPATH_E_RESET) {
+		if (!noprint)
+			_IPATH_UNIT_ERROR(t,
+					  "Got reset, requires re-initialization (unload and reload driver)\n");
+		dd->ipath_flags &= ~IPATH_INITTED;	/* needs re-init */
+		/* mark as having had error */
+		*dd->ipath_statusp |= IPATH_STATUS_HWERROR;
+		*dd->ipath_statusp &= ~IPATH_STATUS_IB_CONF;
+	}
+
+	if (!noprint && *msg)
+		_IPATH_UNIT_ERROR(t, "%s error\n", msg);
+	if (dd->ipath_sma_state_wanted & dd->ipath_flags) {
+		_IPATH_VDBG("sma wanted state %x, iflags now %x, waking\n",
+			    dd->ipath_sma_state_wanted, dd->ipath_flags);
+		wake_up_interruptible(&ipath_sma_state_wait);
+	}
+
+	if (chkerrpkts)
+		/* process possible error packets in hdrq */
+		ipath_kreceive(t);
+}

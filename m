Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWCJBL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWCJBL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbWCJBL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:11:27 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:42412
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750931AbWCJBL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:11:26 -0500
Date: Thu, 9 Mar 2006 17:11:06 -0800
From: Greg KH <gregkh@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 8 of 20] ipath - sysfs support for core driver
Message-ID: <20060310011106.GD9945@suse.de>
References: <patchbomb.1141950930@eng-12.pathscale.com> <1123028ac13ac1de2457.1141950938@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123028ac13ac1de2457.1141950938@eng-12.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 04:35:38PM -0800, Bryan O'Sullivan wrote:
> +static ssize_t show_node_info(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	static const size_t count = 10;
> +	struct ipath_devdata *dd = dev_get_drvdata(dev);
> +	u32 *nodeinfo;
> +	int ret;
> +
> +	if (!dd->ipath_statusp) {
> +		ret = -EINVAL;
> +		goto bail;
> +	}
> +
> +	nodeinfo = (u32 *) buf;
> +
> +	/* so we only initialize non-zero fields. */
> +	memset(nodeinfo, 0, count * sizeof(u32));
> +
> +	nodeinfo[0] =		/* BaseVersion is SMA */
> +		/* ClassVersion is SMA */
> +		(1 << 8)		/* NodeType  */
> +		|(1 << 0);		/* NumPorts */
> +	nodeinfo[1] = (u32) (dd->ipath_guid >> 32);
> +	nodeinfo[2] = (u32) (dd->ipath_guid & 0xffffffff);
> +	/* PortGUID == SystemImageGUID for us */
> +	nodeinfo[3] = nodeinfo[1];
> +	/* PortGUID == SystemImageGUID for us */
> +	nodeinfo[4] = nodeinfo[2];
> +	/* PortGUID == NodeGUID for us */
> +	nodeinfo[5] = nodeinfo[3];
> +	/* PortGUID == NodeGUID for us */
> +	nodeinfo[6] = nodeinfo[4];
> +	nodeinfo[7] = (4 << 16)	/* we support 4 pkeys */
> +		|(dd->ipath_deviceid << 0);
> +	/* our chip version as 16 bits major, 16 bits minor */
> +	nodeinfo[8] = dd->ipath_minrev | (dd->ipath_majrev << 16);
> +	nodeinfo[9] = (dd->ipath_unit << 24) | (dd->ipath_vendorid << 0);
> +
> +	ret = count * sizeof(u32);
> +bail:
> +	return ret;
> +}
> +
> +static ssize_t show_port_info(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	static const size_t count = 13;
> +	int ret;
> +	u32 tmp, tmp2;
> +	struct ipath_devdata *dd = dev_get_drvdata(dev);
> +	u32 *portinfo;
> +
> +	if (!dd->ipath_statusp) {
> +		ret = -EINVAL;
> +		goto bail;
> +	}
> +
> +	portinfo = (u32 *) buf;
> +
> +	/* so we only initialize non-zero fields. */
> +	memset(portinfo, 0, count * sizeof portinfo);
> +
> +	/*
> +	 * Notimpl yet M_Key (64)
> +	 * Notimpl yet GID (64)
> +	 */
> +
> +	portinfo[4] = (dd->ipath_lid << 16);
> +
> +	/*
> +	 * Notimpl yet SMLID (should we store this in the driver, in case
> +	 * SMA dies?)  CapabilityMask is 0, we don't support any of these
> +	 * DiagCode is 0; we don't store any diag info for now Notimpl yet
> +	 * M_KeyLeasePeriod (we don't support M_Key)
> +	 */
> +
> +	/* LocalPortNum is whichever port number they ask for */
> +	portinfo[7] = (dd->ipath_unit << 24)
> +		/* LinkWidthEnabled */
> +		| (2 << 16)
> +		/* LinkWidthSupported (really 2, but not IB valid) */
> +		| (3 << 8)
> +		/* LinkWidthActive */
> +		| (2 << 0);
> +	tmp = dd->ipath_lastibcstat & IPATH_IBSTATE_MASK;
> +	tmp2 = 5;
> +	if (tmp == IPATH_IBSTATE_INIT)
> +		tmp = 2;
> +	else if (tmp == IPATH_IBSTATE_ARM)
> +		tmp = 3;
> +	else if (tmp == IPATH_IBSTATE_ACTIVE)
> +		tmp = 4;
> +	else {
> +		tmp = 0;	/* down */
> +		tmp2 = tmp & 0xf;
> +	}
> +
> +	portinfo[8] = (1 << 28)	/* LinkSpeedSupported */
> +		|(tmp << 24)	/* PortState */
> +		|(tmp2 << 20)	/* PortPhysicalState */
> +		|(2 << 16)
> +
> +		/* LinkDownDefaultState */
> +		/* M_KeyProtectBits == 0 */
> +		/* NotImpl yet LMC == 0 (we can support all values) */
> +		| (1 << 4)		/* LinkSpeedActive */
> +		|(1 << 0);		/* LinkSpeedEnabled */
> +	switch (dd->ipath_ibmtu) {
> +	case 4096:
> +		tmp = 5;
> +		break;
> +	case 2048:
> +		tmp = 4;
> +		break;
> +	case 1024:
> +		tmp = 3;
> +		break;
> +	case 512:
> +		tmp = 2;
> +		break;
> +	case 256:
> +		tmp = 1;
> +		break;
> +	default:		/* oops, something is wrong */
> +		ipath_dbg("Problem, ipath_ibmtu 0x%x not a valid IB MTU, "
> +			  "treat as 2048\n", dd->ipath_ibmtu);
> +		tmp = 4;
> +		break;
> +	}
> +	portinfo[9] = (tmp << 28)
> +		/* NeighborMTU */
> +		/* Notimpl MasterSMSL */
> +		| (1 << 20)
> +
> +		/* VLCap */
> +		/* Notimpl InitType (actually, an SMA decision) */
> +		/* VLHighLimit is 0 (only one VL) */
> +		; /* VLArbitrationHighCap is 0 (only one VL) */
> +	portinfo[10] =		/* VLArbitrationLowCap is 0 (only one VL) */
> +		/* InitTypeReply is SMA decision */
> +		(5 << 16)		/* MTUCap 4096 */
> +		|(7 << 13)		/* VLStallCount */
> +		|(0x1f << 8)	/* HOQLife */
> +		|(1 << 4)
> +
> +		/* OperationalVLs 0 */
> +		/* PartitionEnforcementInbound */
> +		/* PartitionEnforcementOutbound not enforced */
> +		/* FilterRawinbound not enforced */
> +		;			/* FilterRawOutbound not enforced */
> +	/* M_KeyViolations are not counted by hardware, SMA can count */
> +	tmp = ipath_read_creg32(dd, dd->ipath_cregs->cr_errpkey);
> +	/* P_KeyViolations are counted by hardware. */
> +	portinfo[11] = ((tmp & 0xffff) << 0);
> +	portinfo[12] =
> +		/* Q_KeyViolations are not counted by hardware */
> +		(1 << 8)
> +
> +		/* GUIDCap */
> +		/* SubnetTimeOut handled by SMA */
> +		/* RespTimeValue handled by SMA */
> +		;
> +	/* LocalPhyErrors are programmed to max */
> +	portinfo[12] |= (0xf << 20)
> +		| (0xf << 16)	/* OverRunErrors are programmed to max */
> +		;
> +
> +	ret = count * sizeof(u32);
> +bail:
> +	return ret;
> +}

These two files sure do show a lot of different stuff, all in a
predefined structure for a single file.  Please break them up into the
different individual files please.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWCWGaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWCWGaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 01:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWCWGaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 01:30:01 -0500
Received: from [194.90.237.34] ([194.90.237.34]:20966 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932095AbWCWGaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 01:30:00 -0500
Date: Thu, 23 Mar 2006 08:30:49 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com,
       openib-general@openib.org
Subject: Re: [PATCH 8 of 18] ipath - sysfs and ipathfs support for core driver
Message-ID: <20060323063049.GB9841@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <patchbomb.1143072293@eng-12.pathscale.com> <03375633b9c13068de17.1143072301@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03375633b9c13068de17.1143072301@eng-12.pathscale.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 23 Mar 2006 06:32:41.0734 (UTC) FILETIME=[96424A60:01C64E43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Bryan O'Sullivan <bos@pathscale.com>:
> Subject: [PATCH 8 of 18] ipath - sysfs and ipathfs support for core driver
> 
> The ipathfs filesystem contains files that are not appropriate for
> sysfs, because they contain binary data.  The hierarchy is simple; the
> top-level directory contains driver-wide attribute files, while numbered
> subdirectories contain per-device attribute files.
> 
> Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>


.....

> +static ssize_t atomic_node_info_read(struct file *file, char __user *buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	u32 nodeinfo[10];
> +	struct ipath_devdata *dd;
> +
> +	dd = file->f_dentry->d_inode->u.generic_ip;
> +
> +	nodeinfo[0] =			/* BaseVersion is SMA */
> +		/* ClassVersion is SMA */
> +		(1 << 8)		/* NodeType  */
> +		| (1 << 0);		/* NumPorts */
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
> +	nodeinfo[7] = (4 << 16) /* we support 4 pkeys */
> +		| (dd->ipath_deviceid << 0);
> +	/* our chip version as 16 bits major, 16 bits minor */
> +	nodeinfo[8] = dd->ipath_minrev | (dd->ipath_majrev << 16);
> +	nodeinfo[9] = (dd->ipath_unit << 24) | (dd->ipath_vendorid << 0);
> +
> +	return simple_read_from_buffer(buf, count, ppos, nodeinfo,
> +				       sizeof nodeinfo);

InfiniBand core already exposes these attributes to userspace, see
drivers/infiniband/core/sysfs.c

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies

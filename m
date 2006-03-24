Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422968AbWCXB1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422968AbWCXB1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422970AbWCXB1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:27:08 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:56952 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1422968AbWCXB1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:27:07 -0500
X-IronPort-AV: i="4.03,124,1141632000"; 
   d="scan'208"; a="419743590:sNHT32499732"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       greg@kroah.com, openib-general@openib.org
Subject: Re: [PATCH 9 of 18] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1143072293@eng-12.pathscale.com>
	<dffa0687112e4fdcf7d0.1143072302@eng-12.pathscale.com>
	<20060323064113.GC9841@mellanox.co.il>
	<1143103701.6411.21.camel@camp4.serpentine.com>
	<adaacbhvujm.fsf@cisco.com>
	<1143158332.11449.33.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 23 Mar 2006 17:27:02 -0800
In-Reply-To: <1143158332.11449.33.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 23 Mar 2006 15:58:52 -0800")
Message-ID: <adaodzwvdi1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Mar 2006 01:27:03.0359 (UTC) FILETIME=[0E2614F0:01C64EE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> I'm a bit confused by your question.  We only have one SMA
    Bryan> implementation, which is in userspace.  The stuff that's in
    Bryan> our core driver is purely for supporting it.  That same
    Bryan> code is also used during diags, too, to let userspace send
    Bryan> and receive low-level packets.

We seem to be having a problem with the definition of an SMA.  I'm
talking about all the kernel code like the following (and similar
stuff for guidinfo, nodedescription, portinfo, pkeytable).

You must have nearly identical code in your userspace SMA, since it
also has to respond to the same SM queries, right?

I'm trying to understand why you can't get down to one implementation
of these functions.

 > +struct nodeinfo {
 > +	u8 base_version;
 > +	u8 class_version;
 > +	u8 node_type;
 > +	u8 num_ports;
 > +	__be64 sys_guid;
 > +	__be64 node_guid;
 > +	__be64 port_guid;
 > +	__be16 partition_cap;
 > +	__be16 device_id;
 > +	__be32 revision;
 > +	u8 local_port_num;
 > +	u8 vendor_id[3];
 > +} __attribute__ ((packed));
 > +
 > +static inline int recv_subn_get_nodeinfo(struct ib_smp *smp,
 > +					 struct ib_device *ibdev, u8 port)
 > +{
 > +	struct nodeinfo *nip = (struct nodeinfo *)&smp->data;
 > +	struct ipath_devdata *dd = to_idev(ibdev)->dd;
 > +	u32 vendor, boardid, majrev, minrev;
 > +
 > +	if (smp->attr_mod)
 > +		smp->status |= IB_SMP_INVALID_FIELD;
 > +
 > +	nip->base_version = 1;
 > +	nip->class_version = 1;
 > +	nip->node_type = 1;	/* channel adapter */
 > +	/*
 > +	 * XXX The num_ports value will need a layer function to get
 > +	 * the value if we ever have more than one IB port on a chip.
 > +	 * We will also need to get the GUID for the port.
 > +	 */
 > +	nip->num_ports = ibdev->phys_port_cnt;
 > +	/* This is already in network order */
 > +	nip->sys_guid = to_idev(ibdev)->sys_image_guid;
 > +	nip->node_guid = ipath_layer_get_guid(dd);
 > +	nip->port_guid = nip->sys_guid;
 > +	nip->partition_cap = cpu_to_be16(ipath_layer_get_npkeys(dd));
 > +	nip->device_id = cpu_to_be16(ipath_layer_get_deviceid(dd));
 > +	ipath_layer_query_device(dd, &vendor, &boardid, &majrev, &minrev);
 > +	nip->revision = cpu_to_be32((majrev << 16) | minrev);
 > +	nip->local_port_num = port;
 > +	nip->vendor_id[0] = 0;
 > +	nip->vendor_id[1] = vendor >> 8;
 > +	nip->vendor_id[2] = vendor;
 > +
 > +	return reply(smp);
 > +}

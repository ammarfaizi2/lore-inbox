Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752065AbWCIXox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbWCIXox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbWCIXox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:44:53 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:56080 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1752065AbWCIXow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:44:52 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="414166712:sNHT47815146194"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 17 of 20] ipath - infiniband verbs support
X-Message-Flag: Warning: May contain useful information
References: <0bb312984cbad507f1bd.1141922830@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:44:32 -0800
In-Reply-To: <0bb312984cbad507f1bd.1141922830@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:47:10 -0800")
Message-ID: <adar75bdvz3.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:44:33.0634 (UTC) FILETIME=[6AD80420:01C643D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +	/*
 > +	 * We don't need to register a MAD agent, we just need to create
 > +	 * a linker dependency on ib_mad so the module is loaded before
 > +	 * this module is initialized.  The call to ib_register_device()
 > +	 * above will then cause ib_mad to create QP 0 & 1.
 > +	 */
 > +	(void) ib_register_mad_agent(dev, 1, (enum ib_qp_type) 2,
 > +				     NULL, 0, NULL, NULL, NULL);

This looks shady to me.  Can this be solved in userspace by just
making sure that modprobe loads ib_mad before this module?

As it stands you're leaking a mad agent at the very least, not to
mention the hard-coded 2 in there.

 > +	number_of_devices = ipath_layer_get_num_of_dev();
 > +	i = number_of_devices * sizeof(struct ipath_ibdev *);
 > +	ipath_devices = kmalloc(i, GFP_ATOMIC);
 > +	if (ipath_devices == NULL)
 > +		return -ENOMEM;
 > +
 > +	for (i = 0; i < number_of_devices; i++) {
 > +		struct ipath_devdata *dd;
 > +		int ret = ipath_verbs_register(i, ipath_ib_piobufavail,
 > +					       ipath_ib_rcv, ipath_ib_timer,
 > +					       &dd);

What happens if a device is hot plugged or unplugged after you call
ipath_layer_get_num_of_dev() but before you call ipath_verbs_register()?

For that matter, what happens if a device is hot plugged after this
module loads?

 - R.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbWCJFzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWCJFzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 00:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbWCJFzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 00:55:06 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:32854 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751972AbWCJFzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 00:55:05 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="313218886:sNHT33277508"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <gregkh@suse.de>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	<ada8xrjfbd8.fsf@cisco.com>
	<1141948367.10693.53.camel@serpentine.pathscale.com>
	<20060310004505.GB17050@suse.de>
	<1141951725.10693.88.camel@serpentine.pathscale.com>
	<20060310010403.GC9945@suse.de>
	<1141965696.14517.4.camel@camp4.serpentine.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 21:55:02 -0800
In-Reply-To: <1141965696.14517.4.camel@camp4.serpentine.com> (Bryan O'Sullivan's message of "Thu, 09 Mar 2006 20:41:36 -0800")
Message-ID: <ada7j72detl.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Mar 2006 05:55:03.0237 (UTC) FILETIME=[2CB83F50:01C64407]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> I *assumed* that there was something more that we would
    Bryan> need to do in order to support real hotplug of actual
    Bryan> physical cards, but now that I look more closely, it
    Bryan> doesn't appear that there is.  At least, there's nothing in
    Bryan> Documentation/pci.txt or LDD3 that indicates to me that we
    Bryan> ought to be doing more.

    Bryan> Am I missing something?

No, the only problems are with the way the various pieces of your
drivers refer to devices by index.  There are obvious races such as

 > +int __init ipath_verbs_init(void)
 > +{
 > +	int i;
 > +
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

suppose number_of_devices gets set to 5 but by the time you call
ipath_verbs_register(5,...), the 5th device has been unplugged?

Also you only do this when the module is loaded, so you won't handle
devices that are hot-plugged later.  And I don't see anything that
would handle hot unplug either.

Pretty much any use of ipath_max is probably broken by hot plug.

 - R.

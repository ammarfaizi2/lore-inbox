Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWCJRIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWCJRIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWCJRIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:08:31 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:30120 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751333AbWCJRIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:08:30 -0500
X-IronPort-AV: i="4.02,181,1139212800"; 
   d="scan'208"; a="414424319:sNHT33018148"
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
	<ada7j72detl.fsf@cisco.com>
	<1141998230.28926.4.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 10 Mar 2006 09:08:16 -0800
In-Reply-To: <1141998230.28926.4.camel@localhost.localdomain> (Bryan O'Sullivan's message of "Fri, 10 Mar 2006 05:43:50 -0800")
Message-ID: <ada1wxab533.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Mar 2006 17:08:17.0622 (UTC) FILETIME=[39A63F60:01C64465]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> OK.  What's a safe way to iterate over the devices in the
    Bryan> presence of hotplug, then?  I assume it's
    Bryan> list_for_each_mumble; I just don't know what mumble is :-)

You need something that takes a reference to each device while you're
looking at it, like for_each_pci_dev().  But in general iterating
through devices is usually the wrong thing to do, because devices can
come and go in the middle of your loop.  It's better to be driven by
the add and remove callbacks.

    Bryan> No, ipath_max is updated any time a probe routine is
    Bryan> called.

Yes, that's true.  (BTW, what does making ipath_max an atomic_t get
you?  The updates are protected by a lock anyway).  But I was talking
about the code in ipath_verbs_init(), which is the only place you call
ipath_verbs_register() that I could find.  You make one pass through
the devices that are present when ipath_verbs_init() is called at
module load time, and any devices that get added later are missed.

Similarly, if a device is unplugged while the verbs module is loaded,
there's no notification from the core driver of that, and you'll go
ahead and do ipath_verbs_unregister() on a device that is long gone
when you get to ipath_verbs_cleanup().

 - R.


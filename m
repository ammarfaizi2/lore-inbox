Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751957AbWCJRci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbWCJRci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWCJRci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:32:38 -0500
Received: from mx.pathscale.com ([64.160.42.68]:14298 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751957AbWCJRch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:32:37 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <gregkh@suse.de>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <ada1wxab533.fsf@cisco.com>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <ada8xrjfbd8.fsf@cisco.com>
	 <1141948367.10693.53.camel@serpentine.pathscale.com>
	 <20060310004505.GB17050@suse.de>
	 <1141951725.10693.88.camel@serpentine.pathscale.com>
	 <20060310010403.GC9945@suse.de>
	 <1141965696.14517.4.camel@camp4.serpentine.com> <ada7j72detl.fsf@cisco.com>
	 <1141998230.28926.4.camel@localhost.localdomain>
	 <ada1wxab533.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 10 Mar 2006 09:32:32 -0800
Message-Id: <1142011952.29925.54.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 09:08 -0800, Roland Dreier wrote:
>     Bryan> OK.  What's a safe way to iterate over the devices in the
>     Bryan> presence of hotplug, then?  I assume it's
>     Bryan> list_for_each_mumble; I just don't know what mumble is :-)
> 
> You need something that takes a reference to each device while you're
> looking at it, like for_each_pci_dev().

OK, thanks.

It seems like the thing to do to be fully safe might be to have
ipath_get() (just rename ipath_lookup) and ipath_put() functions.  Embed
a kref inside ipath_devdata, and have ipath_dev_get increment the ref
count on both the ipath_devdata and the pci_dev.

Is that sane, or am I way off base?

>   But in general iterating
> through devices is usually the wrong thing to do, because devices can
> come and go in the middle of your loop.

I understand that.  In practice, though, I think this is not a good
approach in many of the cases we're dealing with.  Every use of
ipath_max iterates over all devices for a reason.

For example, the diag open routine wants to find at least one device
that's up.  We could maintain a separate list of devices that are in the
state that it needs, so that it can just get the first entry off that
list or fail if the list is empty, but that's more complex than simply
iterating over every device and checking each one.

> (BTW, what does making ipath_max an atomic_t get
> you?  The updates are protected by a lock anyway).

Probably not much.  The motivation was to ensure that if it got
incremented during an iteration, whoever was iterating would see the
update in a timely fashion.

>   But I was talking
> about the code in ipath_verbs_init(), which is the only place you call
> ipath_verbs_register() that I could find.  You make one pass through
> the devices that are present when ipath_verbs_init() is called at
> module load time, and any devices that get added later are missed.

Yes, that code ought to be restructured.

Thanks for the helpful feedback.

	<b


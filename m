Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbTCJQNd>; Mon, 10 Mar 2003 11:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261341AbTCJQNd>; Mon, 10 Mar 2003 11:13:33 -0500
Received: from air-2.osdl.org ([65.172.181.6]:25733 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261340AbTCJQNc>;
	Mon, 10 Mar 2003 11:13:32 -0500
Date: Mon, 10 Mar 2003 09:59:42 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Ben Collins <bcollins@debian.org>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Device removal callback
In-Reply-To: <20030310010232.GB16134@phunnypharm.org>
Message-ID: <Pine.LNX.4.33.0303100949490.1002-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Instead I now do this, with the patch.
> 
> void ieee1394_remove_node(struct device *dev)
> {
> 	list_for_each(..., &ne->device.children) {
> 		device_unregister(list_to_dev(lh));
> 	}
> }
> 
> ...
> 	/* Where the dev is created */
> 	...
> 	ne->device.remove = ieee1394_remove_node;
> 	device_register(&ne->device);
> 
> Now, no matter where it's called from, doing...
> 
> 	device_unregister(&ne->device);
> 
> ...will make sure my remove callback is executed, so the children
> devices get unregistered aswell. I extend this to the host device
> and I have a recursive remocal scheme that is safe no matter where my
> devices get unregistered. Whole lot simpler that adding in a lot of
> failsafe's and checks.

But, you can do exactly the same with just a few added lines in the 
ieee1394 core - just have a wrapper that calls ->remove() (in the 1394 
device structure), then calls device_unregister() for the device.

Your ->remove() can do anything you like, including removing all the 
children, much as I assume it does now. So, behavior is exactly as you 
want, and it keeps it out of the core for now. 

I much prefer this, as I would like to see it eventually, but I'd rather
see the implications worked out before it's generalized.

Thanks,


	-pat


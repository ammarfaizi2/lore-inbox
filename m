Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVI1Q4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVI1Q4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVI1Q43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:56:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37613 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751085AbVI1Q43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:56:29 -0400
Date: Wed, 28 Sep 2005 12:56:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-usb-storage@lists.one-eyed-alien.net>
Subject: Re: [linux-usb-devel] RFC drivers/usb/storage/libusual
In-Reply-To: <20050927205559.078ba9ed.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.44L0.0509281248570.4491-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005, Pete Zaitcev wrote:

> In my tree, I always use the following patchlet, which deconflicts
> ub and usb-storage:

...

> This makes hotplug to function in a deterministic way, which is a good
> thing. The patch is not in Linus' tree. It was there at one point,
> but Adrian Bunk removed it.
> 
> Why? Because he could not be bothered to understand how the hotplug
> works. Before we say "how stupid", observe that he was very far from
> being alone. A few other users also enabled UB (despite all the
> warnings in Kconfig) and then did not know what to do when something
> did not work for them. And people involved were not morons at all.
> I had to explain how this was supposed to work to Doug Gilbert
> and Randy Dunlap, who had considerable experience. This tells me that
> the mechanisms I used here were unreasonably intricate (to put it
> mildly).
> 
> Simply put, if it's not obvious, it's wrong.
> 
> So, I came up with a solution to the problem, which, I hope, is better.
> It has the following features:
>  - The usb_device_id table is now shared between ub and usb-storage.
>  - The table is located physically in a neutral driver, libusual.
>  - There is only one table. It is not split in any way.
>  - Userland tricks are not used (not necesserily a good thing).
>  - Devices can be marked for use by ub or usb-storage without rebuilding
>    or rebooting.
>  - The scheme can be useful for sharing of devices between
>    HID, Wacom, and Apitek, if we like how it works for the storage.
>  - Even with every kernel option enabled, the assignment defaults to
>    usb-storage. Users have to add an explicit option to /etc/modprobe.conf
>    before the ub gets hotplugged. Thus, the system addresses the Adrian's
>    original problem.
> 
> Patch is attached. I would like someone to look it over and challenge it.
> The thing looks too complex to me, but I see no other way. Anyone?

Future plans for usb-storage include the possibility of taking out all its 
"subdrivers" -- the code to handle devices that don't use the standard 
transport protocols -- and putting them into separate modules.  Those 
subdrivers are responsible for many of the entries in unusual_devs.h, and 
clearly each module would need its own device table.

This raises a few questions:

	Can your scheme accomodate these "subdriver" modules?

	Will the hotplug system work with them?  I'm not sure, but it's
	possible that in some cases the device descriptors will match
	the generic usb-storage or ub driver as well as the more
	specialized "subdriver".  Will the hotplug system choose the
	most specific match?  Even if it's not currently loaded in
	memory and the less specific driver is?

Alan Stern


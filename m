Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVI1Iwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVI1Iwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 04:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVI1Iwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 04:52:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:65253 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030222AbVI1Iwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 04:52:37 -0400
Date: Wed, 28 Sep 2005 01:52:00 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-usb-storage@lists.one-eyed-alien.net
Subject: Re: [linux-usb-devel] RFC drivers/usb/storage/libusual
Message-ID: <20050928085159.GA11862@kroah.com>
References: <20050927205559.078ba9ed.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927205559.078ba9ed.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 08:55:59PM -0700, Pete Zaitcev wrote:
> This makes hotplug to function in a deterministic way, which is a good
> thing. The patch is not in Linus' tree. It was there at one point,
> but Adrian Bunk removed it.

I also did not like that patch.

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

Ok, fair enough, but it is nice at times to mix ub and usb-storage
device controlled devices.

> So, I came up with a solution to the problem, which, I hope, is better.
> It has the following features:
>  - The usb_device_id table is now shared between ub and usb-storage.

Nice.

>  - The table is located physically in a neutral driver, libusual.

Also nice.  But you might want to rename it to show that this is only
for usb storage type devices.  And no, I can't think of a better name
right now :)

>  - There is only one table. It is not split in any way.

Nice.

>  - Userland tricks are not used (not necesserily a good thing).

Hm...  more on this below...

>  - Devices can be marked for use by ub or usb-storage without rebuilding
>    or rebooting.

How?  I missed this in the patch somewhere.

>  - The scheme can be useful for sharing of devices between
>    HID, Wacom, and Apitek, if we like how it works for the storage.

Fair enough, so we should rename it :)

>  - Even with every kernel option enabled, the assignment defaults to
>    usb-storage. Users have to add an explicit option to /etc/modprobe.conf
>    before the ub gets hotplugged. Thus, the system addresses the Adrian's
>    original problem.

Yes, that works better.  Kind of.  But this seems like a lot of work
just to get a "preference".  Although the kernel thread hack is fun.

Your patch mixes a few things in that you probably don't need to show
how libusual works which bloat the patch.  The unusual_devs.h rework
comes to mind.

Just to verify that I read this code correct, is this how it all works?

	- kernel finds usb device and calls out to hotplug with the
	  device id stuff.
	- hotplug scripts load libusual as that is where the mod info is
	  pointing to.
	- libusual's probe function gets called.
	- kernel thread is spawned and probe fails
	- module for "preferred" driver is loaded with a call to
	  request_module
	- requested module is loaded.
	- requested module's probe is called by core and device is bound
	  to it.

Did I get that correct?

If so, a few comments.
  - This only covers the "which module to load" question.  Once the
    module is loaded, it still always grabs the storage devices, even if
    another module is loaded later on.  Isn't that still the same issue
    we have today?  Can't we fix this too?
  - request_module() is icky.  I keep wanting to get rid of that
    function, and really don't want to see any further users get added.
    But that's just my feeling, if there's no other way to do this, I
    don't mind.
    
thanks,

greg k-h

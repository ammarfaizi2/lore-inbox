Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265286AbTLLQSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbTLLQSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:18:24 -0500
Received: from ida.rowland.org ([192.131.102.52]:8196 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265286AbTLLQST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:18:19 -0500
Date: Fri, 12 Dec 2003 11:18:19 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312112229.04256.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312121047590.1297-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Duncan Sands wrote:

> From what Dave says, usb_reset_device shouldn't take dev->serialize (but
> accidentally does via usb_set_configuration).  That seems strange to me:
> I thought the point of usbfs taking dev->serialize is to protect against the
> device settings changing, but now we have usb_reset_device that doesn't
> take dev->serialize at all - and surely it changes the device settings!
> 
> With much confusion,

Maybe it will help if I explain how usb_reset_device will work in the 
future.

First of all, as David has said, it does and will grab dev->serialize.  
The alternate entry point (...physical...) will require the caller to 
hold it already.

The routine will:

	1. issue the port reset
	2. make sure the device is still attached
	3. assign it the same address as it had before
	4. read the device and configuration descriptors
	5. make sure they are equal to the old descriptor values
	6. install the old configuration (if the old state was CONFIGURED) 
	7. select the old altsettings for each interface

If anything goes wrong with step 1, the routine simply returns an error.

If something goes wrong in steps 2-6, the routine will set a flag in the
usb_device indicating STATE_CHANGE_PENDING.  Several other routines will
have to be modified to check this flag before doing anything else
(set_config, set_interface, and so on).  The khubd thread will be woken up
to handle the pending state change.

If the problem arose in steps 2-4, the device will be marked for a pending
port-disable and disconnect.  If it arose in step 5, the device will be
marked as changed -- a sort of logical disconnect followed by connect,
requiring enumeration and all the other usual stuff.  A problem in step 6 
will end up leaving the device back in the ADDRESS state.

If a problem arises in step 7, I'm not sure what to do.  The driver bound
to the malfunctioning interface should be forcibly unbound.  However that
might be the driver which called reset_device, so it can't be unbound
right away.  Regardless, the reset_device routine will return success.

With this approach, a large part of the work in the "device changed"  
pathway is pushed off to khubd.  Running in a different process context,
it will be able to acquire the serialize lock, the bus rwsem, and whatever
else is needed.

In fact, I'd like to do the actual work not in khubd itself but in a
different process.  Maybe a work queue, maybe just a temporary kernel
thread spawned each time it's needed by khubd.  That's true for regular
connect and disconnect processing as well.  The advantage of this is that
khubd itself will no longer be blocked by badly behaved drivers waiting
(or hung) in their probe/disconnect routines, so it will better be able to
concentrate on its main job of managing hubs.

I've been waiting for the code freeze to end before doing any of the real 
work.  Now that Greg is accepting and applying patches again, I'll get 
going on this.

Alan Stern


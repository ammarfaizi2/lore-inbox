Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWFVT51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWFVT51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbWFVT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:57:27 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:62727 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161228AbWFVT50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:57:26 -0400
Date: Thu, 22 Jun 2006 15:57:24 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <pavel@suse.cz>, <linux-pm@osdl.org>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
In-Reply-To: <20060622184649.GA6768@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0606221505030.5772-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Greg KH wrote:

> > There are several possible ways to fix this.  One is to add suspend and 
> > resume routines to the endpoint-device driver.  Another is to change the 
> > code that checks for the children being suspended, to make it check only 
> > for child USB devices and not child endpoints.
> 
> I think it needs to check for _USB_ devices, not just any old device
> that could possibly be attached to the main USB device (as this one is.)
> What's to stop any other struct device to bind here and cause the same
> problem?

In my upcoming patches for USB core suspend improvements, one of the 
changes affects this very piece of code.  Instead of looping over all 
child devices in the driver-model sense, it loops over all interfaces in 
the active configuration, which is all we care about right here.

> Ok, the problem is in verify_suspended(), we are not detecting what type
> of device this is.
> 
> Alan, what are you trying to check for here?  What "bogus requests" were
> you seeing from sysfs that you are trying to filter out?

I didn't write that routine, Dave Brownell did.  It has been there for
ages.  The "bogus requests" are attempts by the user to suspend a USB
device (by writing to /sys/devices/.../power/state) without first
suspending all its children and interfaces.

(This can't happen when doing a global suspend because the PM core 
iterates through the entire device tree.  It matters only for "runtime" or 
"selective" suspend.)

The two easiest ways to fix the problem are:

	Change the code to look through the interfaces in the active
	configuration instead of using device_for_each_child;

or

	Revert your "endpoints are devices" patch until my upcoming
	changes are in place.

Alan Stern


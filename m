Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUCaPyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 10:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUCaPyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 10:54:20 -0500
Received: from ida.rowland.org ([192.131.102.52]:11012 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262027AbUCaPyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 10:54:18 -0500
Date: Wed, 31 Mar 2004 10:54:17 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, <maneesh@in.ibm.com>, <david-b@pacbell.net>,
       <viro@math.psu.edu>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Unregistering interfaces
In-Reply-To: <20040331003327.GB10262@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0403311035130.1752-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Greg KH wrote:

> On Tue, Mar 30, 2004 at 06:56:27PM -0500, Alan Stern wrote:
> > 
> > There are two problems to consider:
> > 
> >     (1) sysfs retains pointers to kobjects long after they have been
> > 	unregistered because of the negative dentrys.
> 
> That is now taken care of with the patch I just sent to Linus by taking
> out this patch.

Yes, and Maneesh is working to replace it with a more suitable approach.

> >     (2) khubd blocks when removing configurations.
> 
> That was fixed by the patch from you, undoing your previous patch which
> blocked.
> 
> So everyone is happy now, right?  :)

That change was just a temporary fix, never intended as a permanent 
solution.

Here's a suggestion for a correct solution.  It's a little bit awkward,
but less so than other ideas I've heard.

Define struct usb_interface_cache to be a subset of struct usb_interface.  
All it needs to contain is the altsetting pointer and num_altsetting.  
Within the usb_host_configuration structure add an array of 
usb_interface_cache pointers in addition to the existing array of 
usb_interface pointers.

When config.c parses the configuration descriptors, it will create the 
usb_interface_cache structures instead of creating the usb_interfaces.  
Things like configuration selection and /proc/bus/usb/devices can get all 
the information they need from this.

When a configuration is installed, usb_set_configuration() will
dynamically perform a deep copy of the usb_interface_cache array and store
the entries in the usb_interface array.  These will be "live" entries,
containing the struct device and everything else for use by drivers 
(exactly the same as they do now).

When a configuration is uninstalled, the usb_interface array can be erased
and the usual kobject cleanup mechanism will delete the deep-copy
array elements whenever it wants to.  There will be no problems with
reinstalling the configuration because when that happens, new interfaces
will be allocated dynamically.  Hence there will be no need for khubd to
block, no need for changes to sysfs, and then everyone really will be 
happy! :-)

Although there is extra overhead in doing all the copying, it only happens 
when configurations are changed.  Furthermore, since we will know in 
advance the sizes of all the structures to be copied, we will be able to 
allocate a single memory region to hold all the altsetting and endpoint 
structures for each interface.

If you think this sounds good, I will start working on it.

Alan Stern


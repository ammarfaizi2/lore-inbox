Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTLSPmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 10:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTLSPmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 10:42:21 -0500
Received: from ida.rowland.org ([192.131.102.52]:7684 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263435AbTLSPmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 10:42:19 -0500
Date: Fri, 19 Dec 2003 10:42:18 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-kernel] Driver model: releasing parents before children
Message-ID: <Pine.LNX.4.44L0.0312191008380.805-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

The more I think about your recent change to sysfs (to prevent parent 
kobjects from being deleted before their children) the more problems I 
see with it.

There's already the classic problem of having duplicate ->parent pointers
in struct device and struct device->kobj.  The difficulties this can cause
are well known...  If the two parent pointers disagree, which one is
right?  But if they always agree, what reason is there for having two of
them?  And if they're meant to always agree, what if you miss one spot in
the code which changes one of the pointers but not the other?

But let's leave that aside.  This is really about problems caused 
specifically by your patch.

There's a regrettable lack of symmetry now.  In a struct device's embedded
kobject, the parent pointer is set (and kobject_get() is called on the
parent) when the kobject is _registered_.  But the pointer and the
reference aren't dropped until the kobject is _cleaned up_ (as opposed to
_unregistered_).  This means that if a struct device is registered, then
unregistered, then registered again, there will be a dangling reference to
the original parent's kobject.

Another problem can occur if kobject_add() fails, say because of an error
during create_dir().  Although the reference to the parent is not
retained, kobj->parent remains set.  Consequently when the kobject is
eventually cleaned up, it will try to release a non-existent reference to
the parent.  This problem crops up whenever a kobject's parent pointer is
set without getting a reference to the parent.


It's not at all clear to me what the reason was for your patch in the
first place.  I guess you an across some situation where freeing a parent
before freeing its child would cause an error.  Normally this wouldn't be
a problem, since once the child was unregistered it would lose both the
reference and the pointer to its parent.  In your situation, the child
kobject must have been embedded in a larger structure that _did_ retain a
pointer to the parent even after the child was unregistered.  Maybe that
larger structure actually contained the parent kobject as well as the
child.

There are other ways of dealing with this situation that don't involve 
changing the driver model core.  Here are two possible approaches:

	When the driver initializes the child kobject, have it do 
	kobject_get() on the parent.  In the child's release routine 
	do kobject_put().

	When you unregister or release the parent, wait until each
	child has been released.

Neither of these would cause the problems that your patch raises.

Hoping I'm not totally out of line...

Alan Stern


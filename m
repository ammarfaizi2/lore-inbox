Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbWBTUjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbWBTUjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbWBTUjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:39:47 -0500
Received: from mx1.rowland.org ([192.131.102.7]:33036 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1161168AbWBTUjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:39:46 -0500
Date: Mon, 20 Feb 2006 15:39:45 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Driver core: race between remove device and register driver
Message-ID: <Pine.LNX.4.44L0.0602201456170.28136-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat, James, and Greg:

There's an obvious race in the driver core when a device is removed at the
same time a new driver is registered.  The core has to guarantee that the
device isn't somehow bound to the driver when the device_del() call
returns.

Right now we handle it by making bus_remove_device() call klist_remove(),
which doesn't return until the device's entry is completely gone from the
bus's klist of all registered devices.  This works okay, but it's contrary
to the principles of the reference-counting approach.  I'm sure that James 
at least would much prefer to have the code avoid waiting for the 
klist_node's refcount to go to 0.

The problem is that we have no way of telling when a struct device has
been unregistered other than to check whether it is still on the bus's
klist.  Adding a single "is_registered" bitflag to struct device would
solve the problem and allow us to get rid of one of the few callers of
klist_remove().  The other callers can be removed in similar ways,
allowing us eventually to get rid of klist_remove() altogether -- and
thereby also get rid of the struct completion embedded in every
klist_node.

Does this seems like a good way to go?

By the way, there's also the converse race: adding a new device while
unregistering a driver.  This race is also solved by waiting, but here it
doesn't matter so much.  Unregistering a driver necessarily involves
waiting, since the driver's code can't be unloaded until no more threads 
are executing it.

Alan Stern

P.S.: James, klist_del() and klist_next() both call klist_dec_and_del() 
(which does a kref_put()) while holding a spinlock.  This may be a good 
place to use execute_in_process_context().


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUAZPvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUAZPvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:51:17 -0500
Received: from ida.rowland.org ([192.131.102.52]:3844 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264930AbUAZPvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:51:15 -0500
Date: Mon, 26 Jan 2004 10:51:14 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Greg KH <greg@kroah.com>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
In-Reply-To: <20040126165035.2fda1b3e.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44L0.0401261016530.822-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jan 2004, Rusty Russell wrote:

> If you want to safely remove parts of the kernel, you have to maintain
> reference counts.  At least with any sane scheme I've seen.
> 
> I know, I should go read the code...
> Rusty.

The problem I raised originally is that in many cases the reference count
can't be maintained properly without preventing the module from ever
exiting at all.  The difficulty is that the reference count won't go
down to 0 until the module code deregisters itself from some list.  But
the deregistration only happens within the module's exit routine!

A two-step exit process, like that used for kobjects, would avoid this 
difficulty.  During the first step the module would deregister itself.  
The second step, unloading from memory, would occur when the reference 
count was 0.

Contrary what Linus said, in many modules it's not necessary to update the 
module's reference count with every single transaction (packet or 
whatever) that goes through.  Usually a single registration event, or just 
a small handful, is critical for unloading.

A good case in point is the one that led to the start of this thread.  A
USB host controller driver registers a USB bus that it will manage, and
from then on it handles lots of USB packets.  It's not necessary to update
the driver module's reference count with every packet; all that matters is
that the module has to wait for the bus to be released before it can be
unloaded from memory.  (That's because existing mechanisms cause each
packet to hold a reference to a USB device and the device holds a
reference to the bus.)  For lack of any other way to avoid exiting early
we simply have to wait for the bus's release callback to finish -- not
waiting will cause a kernel panic if the module unloads before the release
method runs.

Furthermore, in other cases where it _is_ necessary to update a reference
count with every packet, it's not necessary that doing so involve a lot of
additional overhead such as acquiring a lock of some sort.  If some
driver, like a network interface driver, is managing lots of packets then
it must _already_ be using a lock to keep track of things like the total
number of outstanding packets.  Any extra work could be done under the
protection of this pre-existing lock and would involve minimal overhead.


One aspect of what Linus wrote is absolutely right, however: Getting this 
to work right, for all the loadable kernel modules, would be quite 
difficult.  Here's one way to attack that, an incremental approach.

Create a new module entry point, the module_unreg routine.  For all
existing modules this entry point would be undefined and hence not used.  
The module_unreg routine is called to start the deregistration process,
invoked say by some special flag to rmmod.  The module_exit routine would
then be called when an unregistered module's reference count dropped to 0.  
Existing modules would experience exactly the same sequence of events as
they do now, and newly-written modules could take advantage of the extra
mechanism.

Admittedly, this is just a theoretical exercise.  Linus said that module 
unloading should basically be unsupported.  I have no doubt that making it 
even more complicated, like this, is not something he would approve of.

Alan Stern


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263773AbSJHUoV>; Tue, 8 Oct 2002 16:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbSJHUnF>; Tue, 8 Oct 2002 16:43:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7070 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263291AbSJHUmN>;
	Tue, 8 Oct 2002 16:42:13 -0400
Date: Tue, 8 Oct 2002 16:47:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Patrick Mochel <mochel@osdl.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: [RFC] embedded struct device Re: [patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210081005320.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.GSO.4.21.0210081616120.5897-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Oct 2002, Patrick Mochel wrote:

> The driver core is not controlling the lifetime of the objects. It's 
> managing the reference counts on the shared objects. It's still the 
> allocator that frees the device. It just can't do it whenever it wants, 
> because it's shared and may be accessed by other entities. The release() 
> method is the notification that it's kosher to do so. 

Its reference counts mean squat if they are not seen by the code that
allocates/frees the object struct device is embedded into.
 
> [ Note that I'm not trying to be a smart ass. I know you have much more 
> experience with this stuff; I'm just trying to grasp all the angles. ]
> 
> > but I'll believe it when I see it.  Notice that ->release() has nothing
> > to any possible solution - the problem happens when we _don't_ call it
> > for too long (== retain reference after driver had dropped its own).
> 
> The only timing issue is when the device structures are reused. And, it 
> seems that that is inherently racy anyway with hotpluggable devices. 

BS.  Neither SCSI, nor USB nor PCI are reusing the structures in question.
They are, however, freeing them.

Again, USB disconnect when you are holding a reference to struct device
will leave you with pointer to kfree'd area.

> I don't see how dynamically allocating the device structures is
> necessarily going to help. It seems that it would be a step backwards from
> what we currently have. We'll still need reference counting on the
> bus-specific objects, and separate handlers for them, to decide when its
> ok to free them (since someone could independently be holding a reference
> to a bus object when the device goes away). 
> 
> struct device was an attempt to consolidate the constructs and methods to
> deal with them. The easiest way to do this is to embed the generic object
> in the bus-specific object. Do you see anyway to make this work?

I don't.  Notice that in case of inodes (which is what you seem to be
imitating) logics is very different - there final decision to destroy
composite object is made by holder of pointer to shared object (i.e.
VFS code); filesystem provides the method for freeing these guys, but
that's it.  That's the only reason why we can get away with refcounting
on struct inode.

With drivers decision to destroy the object is made by driver, not by
holder of shared objects.  IOW, driverfs refcount doesn't protect
anything.  Moreover, ->release() is guaranteed to be called not earlier
than driver makes such decision - until then driverfs object is pinned
down.

Look - we can't afford the following situation: driver destroys some of
its structures while driverfs accesses these structures.  Agreed?

So we need to make sure that driver will not proceed to destroy these
data structures until driverfs code is out of critical areas.

So we need either leave _all_ work on destruction (which can be damn
nontrivial) to ->release() and leave driver to do only one thing - drop
its reference to driverfs object and let driverfs call the rest, _or_
we need to protect critical areas with something other than driverfs
refcount and let driver block until driverfs is out of said areas,
mark node as dead (to prevent later access to them) and proceed with
destroying stuff.

Now, the former is a very massive rewrite of drivers.  The latter suffers
from obvious problems if critical areas are too large.  If struct device
is embedded, it's all code that dereferences it and we also get a lovely
problem with blocking safely.  If we make struct device separately allocated,
we can shrink these areas to stuff that really accesses driver objects.
Which can be made _way_ more narrow.

I don't see any simple way to do it - any path will require massive changes.
Notice that leaving destruction of driver structures to ->release() is
going to be _very_ messy - look at USB or PCI code, not to mention SCSI one.

I have a very strong gut feeling that embedding struct device was a mistake.

Linus, your opinion?


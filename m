Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSKRJoW>; Mon, 18 Nov 2002 04:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSKRJoW>; Mon, 18 Nov 2002 04:44:22 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:6613 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261868AbSKRJoT>;
	Mon, 18 Nov 2002 04:44:19 -0500
Date: Mon, 18 Nov 2002 04:51:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Doug Ledford <dledford@redhat.com>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-Reply-To: <20021118085928.82D7F2C30D@lists.samba.org>
Message-ID: <Pine.GSO.4.21.0211180403440.23400-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Nov 2002, Rusty Russell wrote:

> Unfortunately, this does complicate code slightly if you other paths
> which *do* need the try_module_get().  But the existence of this
> interface is no accident: I know Al Viro wants to split every register
> interface to "reserve" and "use", and make all modules use them
> correctly, but I chose to avoid forcing such changes on all module
> authors and all interface authors for good reason.

No.  I want to get the things into "don't bloody export it until you
can handle it" land.
 
> [ Mainly to Al ]:
> 
> I know what a PITA it is, because I implemented it a year ago.  So
> first the interface had to be changed to two-stage init, *then* the
> module had to be changed to use it.  If a module uses 5 interfaces,
> that's a series of five patches, each one interlocked with the
> corresponding interface.  And implementing it showed me that authors
> were unlikely to correctly use any interface more complex than the
> current one 8(

> And it *still* means you need two paths for your code: one for "I know
> it's not actually "active" yet, but I'm doing init and I need to
> access it anyway".  So every interface gains significant complexity by
> effectively implementing their own "live" flag...

Not really.  For case in question (block devices) there is only one path
and I'd rather keep it that way, thank you very much.

Again, by the time when add_disk() got to reading partition table, device
is _there_.  That's it - we had set it up completely, it's ready for IO,
whatever.  At that point we want generic code to do some work with that
device.  And there is no magic path for that - it's normal open/read/close.

There is no "live" flag - you had shown it, you'd better be ready to have
it used.  Doesn't cause any problems.

It's simpler than old interface - there you indeed had to pull off all sorts
of tricks.  Current rule is trivial - "nobody touches it until they see it;
register when you are 100% ready to deal with users".

And no, I don't buy arguments about poor interface-writers.  You do some
infrastructure intended to be used by driver-writers - you are supposed
to have a clue.  'Cause having rabid monkeys on crack on *both* sides of
an interface is a recipe for disaster and on the driver side you are
guaranteed to have a bunch of them.

We need to have interfaces cleaned up.  No silver bullets there.  There's
maybe a dozen of interfaces that cover 99% of all drivers out there.  Remaining
1% can and should fend for itself - you do something really tricky, you
are responsible for getting it right.

And yes, we need clued people for that cleanup.  Forget the modules;
if use of an API requires magic, it will lead to fuckups.  Lots of them.
If API doesn't make sense for users of that API - ditto.

Papering over the races in driver init is OK, as long as it doesn't hurt
drivers with clean init.  Your logics with ->live on init side *does* hurt
such drivers - it forces them to do magic just to neutralize your band-aids.


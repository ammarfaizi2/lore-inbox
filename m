Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSKRIw3>; Mon, 18 Nov 2002 03:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSKRIw3>; Mon, 18 Nov 2002 03:52:29 -0500
Received: from dp.samba.org ([66.70.73.150]:38280 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261669AbSKRIw1>;
	Mon, 18 Nov 2002 03:52:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Doug Ledford <dledford@redhat.com>
Cc: Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-reply-to: Your message of "Sun, 17 Nov 2002 14:52:58 CDT."
             <20021117195258.GC3280@redhat.com> 
Date: Mon, 18 Nov 2002 19:52:54 +1100
Message-Id: <20021118085928.82D7F2C30D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021117195258.GC3280@redhat.com> you write:
> Because module loading of any incestious, cross-locking modules is horked 
> :-P
> 
> NOTE: I suspect the same bug applies to IDE devices as well, but you 
> wouldn't see it unless you compile your IDE drivers as modules and use 
> initrd or equivelant to load the modules.
> 
> Longer answer:
> 
> Device scans happen almost exclusively at either host module init time or
> device module init time.  At that point in time, either the host the
> device is on or the high level driver accessing the device will still be
> in it's init_module() routine.  That, of course, implies that either
> host->hostt->module->live is 0 or that *_template->module->live is 0 (and
> consequently so is fops->owner->live == 0).

Yes, it's an interesting corner case.  As I implied before, if a
module is register an interface, you do not need to try_module_get().
Why?  Because *someone* already has a reference by definition (either
the module itself is calling you, or someone else with whom the module
registered).

Unfortunately, this does complicate code slightly if you other paths
which *do* need the try_module_get().  But the existence of this
interface is no accident: I know Al Viro wants to split every register
interface to "reserve" and "use", and make all modules use them
correctly, but I chose to avoid forcing such changes on all module
authors and all interface authors for good reason.

[ Mainly to Al ]:

I know what a PITA it is, because I implemented it a year ago.  So
first the interface had to be changed to two-stage init, *then* the
module had to be changed to use it.  If a module uses 5 interfaces,
that's a series of five patches, each one interlocked with the
corresponding interface.  And implementing it showed me that authors
were unlikely to correctly use any interface more complex than the
current one 8(

And it *still* means you need two paths for your code: one for "I know
it's not actually "active" yet, but I'm doing init and I need to
access it anyway".  So every interface gains significant complexity by
effectively implementing their own "live" flag...

> Suggestions Rusty?

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

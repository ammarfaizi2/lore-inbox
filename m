Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbUC2XRd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbUC2XRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:17:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:35985 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263172AbUC2XQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:16:52 -0500
Date: Mon, 29 Mar 2004 15:16:04 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: stern@rowland.harvard.edu, david-b@pacbell.net, viro@math.psu.edu,
       maneesh@in.ibm.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-ID: <20040329231604.GA29494@kroah.com>
References: <20040328063711.GA6387@kroah.com> <Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org> <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com> <20040329132551.23e12144.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329132551.23e12144.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 01:25:51PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > On Sun, Mar 28, 2004 at 12:38:57PM -0800, Andrew Morton wrote:
> > > Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > >  However, a very noticeable and IMO unacceptable delay occurs when there's
> > > >  a reference to a kobject caused by a negative dentry that won't get
> > > >  recycled until the system decides it's good and ready.  That's the real
> > > >  problem I wanted to call to people's attention.
> > > 
> > > Have you verified that this actually happens?
> > 
> > Yes, I've verified this, and it looks like Maneesh also agrees with
> > this.
> > 
> > > If so, what are its effects?  rmmod hangs for half an hour?  Cannot reload
> > > the module?
> > 
> > Well, before the patch that I submitted for the USB core, we would hang
> > waiting for the release function to return as there was still a
> > reference to the kobject pending.
> > 
> > For other subsystems (and USB), this might cause nasty oopses when the
> > kobject is finally released and yet the module has been unloaded already
> > (as the owner of the reference did not cause the module reference count
> > to increment.)  This is bad.
> > 
> 
> The module should remain in memory, "unhashed", until the final kobject
> reference falls to zero.  Destruction of that kobject causes the refcount
> on the module to fall to zero which causes the entire module to be
> released.
> 
> (hmm, the existence of a kobject doesn't appear to contribute to its
> module's refcount.  Why not?)

It does, if a file for that kobject is opened.  In this case, there was
no file opened, so the module refcount isn't incremented.

> But the module system is that smart, so what we do instead is to block
> rmmod until the module refcount falls to zero, and rmmod then does the
> final destruction.  We could have punted the module destruction up to some
> reaper thread but for some reason did not do so.

Well, as the module refcount was never incremented, it does not do this.
I just verified this (accidentally) by removing my lp modules and then
doing a bk pull.  kswapd forced the stale dentry out, which decremented
the kobject reference count, which then tried to call the release
function in the (now gone) lp module.  My machine then spit up a lovely
oops, and was reduced to a unusable sludge as there was no more kswapd
running :(

> So as far as I can tell, the only problem we have is that rmmod will hang
> around until memory pressure, yes?

Nope, oopses will happen.  You can verify this yourself by doing much of
what I just did.

This needs to get fixed, as it's not just a USB issue (so I've added
lkml on the cc list.)

> Maybe a shrink_dcache_parent(dentry) on entry to simple_rmdir() would
> suffice?

Will that get rid of the references properly nwhen we remove the
kobject?

thanks,

greg k-h

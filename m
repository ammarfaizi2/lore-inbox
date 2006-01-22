Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWAVWNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWAVWNX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWAVWNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:13:22 -0500
Received: from mx1.rowland.org ([192.131.102.7]:1541 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751377AbWAVWNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:13:22 -0500
Date: Sun, 22 Jan 2006 17:13:17 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: remove unneeded klist methods
In-Reply-To: <1137947405.4058.10.camel@mulgrave>
Message-ID: <Pine.LNX.4.44L0.0601221704370.7173-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006, James Bottomley wrote:

> On Fri, 2006-01-20 at 23:37 -0500, Alan Stern wrote:
> > The problem is that put_device must not be called while holding a
> > spinlock.  This has always been true, but we only started noticing it
> > recently when Greg added a might_sleep.  Your klist method would call
> > put_device while holding the klist's spinlock.
> 
> Right, but we currently have this problem everywhere throughout the
> code.  Avoiding it by not taking references doesn't look to be the right
> way to go because then we have to dismantle the whole refcounting
> infrastructure.
> 
> > Not so.  A device structure can't be freed before device_del returns, and
> > the patch makes device_del call klist_remove instead of klist_del.  The
> > difference between the two is that klist_remove blocks until all iterators
> > have finished using the klist node.  New iterators can't start using it
> > because the routine removes the node from the klist.
> 
> Sorry ... forgot to mention that part ... the change from _del to
> _remove ties us up with a wait for the list to actually remove.  This is
> potentially dangerous because you're waiting on events you don't
> control.  Additionally, next_child isn't refcounted, so it could
> potentially disappear out from under you.

In this case we're only waiting for other iterators to move past our 
struct device.  The fact that next_child isn't refcounted doesn't matter, 
because (thanks to the new klist_remove) it won't go away until we're done 
with it.

I suppose a different approach to fixing this would be to make klist_del
and klist_remove check the value returned by klist_dec_and_del, and have
_them_ call the put method (after the spinlock has been released) instead
of having it called from klist_release.  Would you prefer me to change it
that way instead?

Alan Stern


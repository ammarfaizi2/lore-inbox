Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161238AbWAUEhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWAUEhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 23:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWAUEhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 23:37:31 -0500
Received: from mx1.rowland.org ([192.131.102.7]:28426 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1161238AbWAUEha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 23:37:30 -0500
Date: Fri, 20 Jan 2006 23:37:28 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: remove unneeded klist methods
In-Reply-To: <1137784787.3442.7.camel@mulgrave>
Message-ID: <Pine.LNX.4.44L0.0601202321430.14739-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, James Bottomley wrote:

> On Fri, 2006-01-20 at 11:39 -0500, Alan Stern wrote:
> > This patch (as641) removes unneeded klist methods from the driver core and
> > changes a klist_del call to klist_remove in device_del.
> > 
> > The _get and _put methods have no effect, because the klist nodes are
> > deleted by calling klist_remove, which waits until they are unreferenced
> > by any klist iterators.  Furthermore, the _puts cause problems because
> > they occur while the iterator is holding a spinlock.
> 
> Could you just elaborate on the actual problem that you're trying to
> solve here?

The problem is that put_device must not be called while holding a
spinlock.  This has always been true, but we only started noticing it
recently when Greg added a might_sleep.  Your klist method would call
put_device while holding the klist's spinlock.

> Iterators of volatile lists are ipso facto just "best guess", so moving
> the location of the iterator piece is OK.

Good, I thought so.

>  However, your assumption that
> only the routine called by the iterator is always going to do the final
> put on the object is fundamentally flawed.

That was not my assumption.  My assumption was that the routine called by
the iterator will _sometimes_ do the final put on the object.  I don't
know if that actually ever happens, but the possibility certainly exists.  
For example, there are places where a device_for_each_child iteration is
used for calling device_unregister on all the children.

>  The list is volatile because
> references to the object are being acquired and released all the time.
> Additionally, the list nodes are embedded in the object, so by removing
> the object get and put calls, you remove the ability for the object
> refcounting to see the fact that the list is using the object.

Agreed.  Note, however, that the patch doesn't do this for all objects -- 
only for struct device.

>  This
> will lead to the situation where the object could be freed while the
> iterator is acting on it.  You cannot remove the object get/put calls
> from the klist references otherwise the list refcounting will be totally
> divorced from the object refcounting.

Not so.  A device structure can't be freed before device_del returns, and
the patch makes device_del call klist_remove instead of klist_del.  The
difference between the two is that klist_remove blocks until all iterators
have finished using the klist node.  New iterators can't start using it
because the routine removes the node from the klist.

So by the time device_del returns, we are guaranteed that the embedded 
klist node is not in use and will never be used.  Thus releasing the 
device structure is safe.

Alan Stern


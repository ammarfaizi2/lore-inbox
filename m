Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUDNRzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUDNRzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:55:35 -0400
Received: from ida.rowland.org ([192.131.102.52]:1284 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261474AbUDNRzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:55:33 -0400
Date: Wed, 14 Apr 2004 13:55:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sf.net>,
       <linux-kernel@vger.kernel.org>, Frederic Detienne <fd@cisco.com>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs
 only on the disconnected interface
In-Reply-To: <200404141909.29810.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0404141341030.609-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Duncan Sands wrote:

> > Quite apart from the stylistic questions about sanity tests and so on,
> > this code contains a bug.  It wasn't introduced by your patch; it was
> > there from before and I should have caught it earlier, along with a few
> > others.
> 
> Hi Alan, it was introduced after your last devio.c fixes by the patch
> "fix xsane breakage, hangs on device scan at launch" by someone
> who will remain nameless :)

Okay, that's a relief.  Of course there's still the other two places.  I 
did check for such things a while back, but apparently I forgot to look at 
all occurrences of "ifclaimed".


> > Similarly, there's a typo in proc_releaseinterface(); the second argument
> > it passes to releaseintf() should be ret, not intf.
> >
> > And in proc_submiturb(), the value stored in as->intf is an index when it
> > should be an interface number.  Or possibly it could remain an index, but
> > then the value passed to destroy_async_on_interface() by
> > proc_releaseinterface() should be the index and not the number.
> 
> Good catch!  I guess the index and the interface differ because interfaces are
> not always consecutively numbered.  Is that right?  When can it happen?

Yes.  Actually I spoke too strongly before; these aren't bugs, just things 
that need to be changed.

Right now the configuration parsing code doesn't allow devices to have
interfaces that aren't numbered consecutively starting from 0, so there's
no problem.  But I'm trying to update all the USB drivers to eliminate
such assumptions about device sanity.  When that's done we will accept
funny interface numbers.  There's a surprisingly large number of devices
that number their interfaces starting from 1, and we should be able to
handle them correctly.

Anyway, if you would like to fix these issues, my suggestion is to adopt a 
variable-name scheme that makes it clear which things are interface 
numbers and which are interface indices.  (I don't want to go so far as to 
advocate Hungarian notation, but the concept of using part of a variable's 
name to indicate its type goes back at least to early Fortran with its 
"names starting with letters from I-N are integers" convention.)

Alan Stern


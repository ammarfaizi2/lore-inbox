Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVILO3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVILO3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVILO3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:29:04 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:24722 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751024AbVILO3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:29:03 -0400
Date: Mon, 12 Sep 2005 10:29:01 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Elimination of klists
In-Reply-To: <1126475059.4831.44.camel@mulgrave>
Message-ID: <Pine.LNX.4.44L0.0509121014220.5309-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2005, James Bottomley wrote:

> On Sun, 2005-09-11 at 15:35 -0400, Alan Stern wrote:
> > I noticed that you recently posted some updates to the klist code, 
> > although I haven't looked to see how you are using the klists.
> 
> Yes, that was mainly to tie their reference counting model back to the
> objects they actually embed.  It was just fixing a thinko in the
> implementation rather than changing anything fundamental about them.

I'm not sure it was really a thinko.  Pat Mochel was well aware of the 
problem and just decided not to do anything about it.

> > What do you think about eliminating klists entirely, and instead using 
> > regular lists protected by either a mutex or an rwsem?  It would remove a 
> > good deal of overhead, and I think it wouldn't be hard to convert the 
> > driver core.  Would this be feasible for the things you're doing?
> 
> Actually, the concept of a klist is quite nice, and the beauty is that
> all the locking is internal to them, so users can't actually get it
> wrong (I like interfaces like this).

It's possible to make the locking internal to normal lists as well, if 
anyone wanted to do it.

> Originally the driver model did precisely use an ordinary list and a
> mutex.  The problem was that we entangled the mutex in the actions taken
> by things like device_for_each_child() which caused deadlocks ... most
> noticeably in the transport classes; klists got us out of this.

There's a big difference.  Originally the driver model used a _single_
rwsem that covered everything in a subsystem: all the devices, all the
drivers, and all the lists.  What I'm suggesting is using lots of rwsems
or mutexes, one for each list.  (The driver core has already added a
semaphore for each device.)  Being much finer-grained, it would not lead
to deadlock.


On Sun, 11 Sep 2005, Andrew Morton wrote:

> You're a bit screwed if you want to use them from interrupts..

Actually, in their original form klists could indeed be used in interrupt
contexts, since they involved only spinlocks.  That's not quite true any 
more.

And certainly replacing them with rwsem-protected lists won't make them 
any more interrupt-friendly.  On the other hand, as far as I know nobody 
wants to use them in interrupt contexts.

Alan Stern


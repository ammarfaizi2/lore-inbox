Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUIVTi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUIVTi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUIVTiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:38:55 -0400
Received: from peabody.ximian.com ([130.57.169.10]:43658 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266798AbUIVTiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:38:51 -0400
Subject: [patch] inotify: locking
From: Robert Love <rml@novell.com>
To: ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 22 Sep 2004 15:37:41 -0400
Message-Id: <1095881861.5090.59.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, John.

I went over the locking in drivers/char/inotify.c  Looks right.

I made two major changes:

	- In a couple places you used irq-safe locks, but in most places
	  you did not.  It has to be all or never.  We do not currently
	  need protection from interrupts, so I changed the few
	  irq-safe locks on dev->lock to normal spin_lock/spin_unlock
	  calls.

	- dev->event_count was an atomic_t, but it was never accessed
	  outside of dev->lock.  I also did not see why ->event_count
	  was atomic but not ->nr_watches.  So I made event_count an
	  unsigned int and removed the atomic operations.

The rest of the (admittedly a bit large) patch is documenting the
locking rules.  I tried to put the locking assumptions in comments at
the top of each function.  I made some coding style cleanups as I went
along, too, but not too many (those come next).

I do have one remaining concern: create_watcher() is called without the
lock on dev, but it later obtains the lock, before it touches dev.  So
it is safe in that regard, but what if dev is deallocated before it
grabs the lock?  dev is passed in, so, for example, dev could be freed
(or otherwise manipulated) and then the dereference of dev->lock would
oops.  A couple other functions do this.  We probably need proper ref
counting on dev. BUT, are all of these call chains off of VFS functions
on the device?  Perhaps so long as the device is open it is pinned?

Attached patch is against your latest, plus the previous postings.

Thanks,

	Robert Love



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUIVWqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUIVWqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268074AbUIVWqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:46:39 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:29430 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S268072AbUIVWqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:46:36 -0400
Subject: Re: [patch] inotify: locking
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1095881861.5090.59.camel@betsy.boston.ximian.com>
References: <1095881861.5090.59.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095895360.29226.17.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 19:22:40 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.22.3
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 15:37, Robert Love wrote:
> Hey, John.
> 
> I went over the locking in drivers/char/inotify.c  Looks right.
> 
> I made two major changes:
> 
> 	- In a couple places you used irq-safe locks, but in most places
> 	  you did not.  It has to be all or never.  We do not currently
> 	  need protection from interrupts, so I changed the few
> 	  irq-safe locks on dev->lock to normal spin_lock/spin_unlock
> 	  calls.
> 
> 	- dev->event_count was an atomic_t, but it was never accessed
> 	  outside of dev->lock.  I also did not see why ->event_count
> 	  was atomic but not ->nr_watches.  So I made event_count an
> 	  unsigned int and removed the atomic operations.
> 

Okay, this is my first kernel project so I didn't know/follow all of the
rules, I admit it is a bit of a mishmash.

> The rest of the (admittedly a bit large) patch is documenting the
> locking rules.  I tried to put the locking assumptions in comments at
> the top of each function.  I made some coding style cleanups as I went
> along, too, but not too many (those come next).
> 

The patch and your previous patches look excellent. I have applied them
to my tree and I will be making a new release this evening.

> I do have one remaining concern: create_watcher() is called without the
> lock on dev, but it later obtains the lock, before it touches dev.  So
> it is safe in that regard, but what if dev is deallocated before it
> grabs the lock?  dev is passed in, so, for example, dev could be freed
> (or otherwise manipulated) and then the dereference of dev->lock would
> oops.  A couple other functions do this.  We probably need proper ref
> counting on dev. BUT, are all of these call chains off of VFS functions
> on the device?  Perhaps so long as the device is open it is pinned?
> 

Yes, AFAIK the only places where we rely on the dev not going away are
when we are handling a request from user space. As long as VFS
operations are serialized I don't think we have to worry about that.

John

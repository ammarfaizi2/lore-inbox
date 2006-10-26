Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422778AbWJZJJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWJZJJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWJZJJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:09:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:46811 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752124AbWJZJJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:09:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Thu, 26 Oct 2006 11:08:22 +0200
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
References: <1161576735.3466.7.camel@nigel.suspend2.net> <20061026073022.GG8394166@melbourne.sgi.com> <1161850709.17293.23.camel@nigel.suspend2.net>
In-Reply-To: <1161850709.17293.23.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610261108.23390.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 26 October 2006 10:18, Nigel Cunningham wrote:
> Hi Dave.
> 
> On Thu, 2006-10-26 at 17:30 +1000, David Chinner wrote:
> > On Wed, Oct 25, 2006 at 09:05:56PM +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, 25 October 2006 15:23, Nigel Cunningham wrote:
> > > > > 
> > > > > Well, my impression is that this is exactly what happens here: Something
> > > > > in the XFS code causes metadata to be written to disk _after_ the atomic
> > > > > snapshot.
> > > > > 
> > > > > That's why I asked if the dirty XFS metadata were flushed by a kernel thread.
> > > > 
> > > > When I first added bdev freezing it was because there was an XFS timer
> > > > doing writes.
> > > 
> > > Yes, I noticed you said that, but I'd like someone from the XFS team to either
> > > confirm or deny it.
> > 
> > We have daemons running in the background that can definitely do stuff
> > after a sync. hmm - one does try_to_freeze() after a wakeup, the
> > other does:
> > 
> >                 if (unlikely(freezing(current))) {
> >                         set_bit(XBT_FORCE_SLEEP, &target->bt_flags);
> >                         refrigerator();
> >                 } else {
> >                         clear_bit(XBT_FORCE_SLEEP, &target->bt_flags);
> >                 }
> > 
> > before it goes to sleep. So that one (xfsbufd - metadata buffer flushing)
> > can definitely wake up after the sync and do work, and the other could if
> > the kernel thread freeze occurs after the sync.
> > 
> > Another good question at this point - exactly how should we be putting
> > these thread to to sleep? Are both these valid methods for freezing them?
> > And should we be freezing when we wake up instead of before we go to
> > sleep? i.e. what are teh rules we are supposed to be following?
> 
> As you have them at the moment, the threads seem to be freezing fine.
> The issue I've seen in the past related not to threads but to timer
> based activity. Admittedly it was 2.6.14 when I last looked at it, but
> there used to be a possibility for XFS to submit I/O from a timer when
> the threads are frozen but the bdev isn't frozen.

Also there may be a problem if a workqueue is used for that, because
worker_threads run with PF_NOFREEZE set.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

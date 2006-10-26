Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752118AbWJZI6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbWJZI6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 04:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbWJZI6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 04:58:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30635 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752118AbWJZI6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 04:58:14 -0400
Date: Thu, 26 Oct 2006 18:57:00 +1000
From: David Chinner <dgc@sgi.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: David Chinner <dgc@sgi.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061026085700.GI8394166@melbourne.sgi.com>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610251432.41958.rjw@sisk.pl> <1161782620.3638.0.camel@nigel.suspend2.net> <200610252105.56862.rjw@sisk.pl> <20061026073022.GG8394166@melbourne.sgi.com> <1161850709.17293.23.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161850709.17293.23.camel@nigel.suspend2.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

On Thu, Oct 26, 2006 at 06:18:29PM +1000, Nigel Cunningham wrote:
> On Thu, 2006-10-26 at 17:30 +1000, David Chinner wrote:
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
> the threads are frozen but the bdev isn't frozen. Has that changed?

I didn't think we've ever done that - periodic or delayed operations
are passed off to the kernel threads to execute. A stack trace
(if you still have it) would be really help here.

Hmmm - we have a couple of per-cpu work queues as well that are
used on I/O completion and that can, in some circumstances,
trigger new transactions. If we are only flush metadata, then
I don't think that any more I/o will be issued, but I could be
wrong (maze of twisty passages).

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

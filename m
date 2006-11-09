Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424218AbWKIXMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424218AbWKIXMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424241AbWKIXMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:12:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3299 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1424218AbWKIXME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:12:04 -0500
Date: Fri, 10 Nov 2006 00:11:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061109231146.GD2616@elf.ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611092218.58970.rjw@sisk.pl> <20061109214159.GB2616@elf.ucw.cz> <200611092321.47728.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611092321.47728.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > This is from a work queue, so in fact from a process context, but from
> > > > > a process that is running with PF_NOFREEZE.
> > > > 
> > > > Why not simply &~ PF_NOFREEZE on that particular process? Filesystems
> > > > are free to use threads/work queues/whatever, but refrigerator should
> > > > mean "no writes to filesystem" for them...
> > > 
> > > But how we differentiate worker_threads used by filesystems from the
> > > other ones?
> > 
> > I'd expect filesystems to do &~ PF_NOFREEZE by hand.
> > 
> > > BTW, I think that worker_threads run with PF_NOFREEZE for a reason,
> > > but what exactly is it?
> > 
> > I do not think we had particulary good reasons...
> 
> Well, it looks like quite a lot of drivers depend on them, including libata.
> 
> I think we can add a flag to __create_workqueue() that will indicate if
> this one is to be running with PF_NOFREEZE and a corresponding macro like
> create_freezable_workqueue() to be used wherever we want the worker thread
> to freeze (in which case it should be calling try_to_freeze() somewhere).
> Then, we can teach filesystems to use this macro instead of
> create_workqueue().

Works for me.

> Having done that we'd be able to drop the freezing of bdevs patch and forget
> about the dm-related complexity.

yes.

> [Still I wonder if the sys_sync() in freeze_processes() is actually safe if
> there's a suspended dm device somewhere in the stack, because in the other
> case the freezing of bdevs would be no more dangerous than the thing
> that we're already doing.]

? Not sure if I quite understand, but if dm breaks sync... something
is teribly wrong with dm. And we do simple sys_sync()... so I do not
think we have a problem.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

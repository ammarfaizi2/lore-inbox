Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317378AbSFCLgJ>; Mon, 3 Jun 2002 07:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317377AbSFCLgJ>; Mon, 3 Jun 2002 07:36:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14793 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317378AbSFCLgH>;
	Mon, 3 Jun 2002 07:36:07 -0400
Date: Mon, 3 Jun 2002 13:35:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend.c: This is broken, fixme
Message-ID: <20020603113548.GB21035@suse.de>
In-Reply-To: <20020603095507.GA3030@elf.ucw.cz> <20020603110816.GI820@suse.de> <20020603113221.GA17228@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03 2002, Pavel Machek wrote:
> Hi!
> 
> > > @@ -300,7 +301,8 @@
> > >  static void do_suspend_sync(void)
> > >  {
> > >         while (1) {
> > > -               run_task_queue(&tq_disk);
> > > +               blk_run_queues();
> > > +#error this is broken, FIXME
> > >                 if (!TQ_ACTIVE(tq_disk))
> > >                         break;
> > > 
> > > . Why is it broken?
> > 
> > Hey, I even cc'ed you on the patch when it went to Linus... Lets
> > look at
> 
> Okay; I thought I corrected it in the meantime, that's why I got confused.
> 
> > what happened before: run tq_disk, then check if it is active. What
> > prevents tq_disk from being active right after you issue the TQ_ACTIVE
> > check? Nothing. And I'm not sure exactly what semantics you think
> > running tq_disk has. I suspect you are looking for a 'start any pending
> > i/o and return when it has completed', which is far from what happens.
> > Running tq_disk will _try_ to start _some_ I/O, and eventually, in time,
> > the currently pending requests will have completed. In the mean time,
> > more I/O could have been added though.
> 
> I'm alone at the system at that point. All user tasks are stopped and
> I'm only thread running. There's noone that could submit requests at
> that point.

Ok, then at least the very last point I made can be disregarded.
However... ->

> In such case, killing #error is right solution, right?

Not at all. The tq_disk/blk_run_queues() semantics are the same, they
will only start i/o (which may not even be right when you run it) and
that is it. When all i/o is completed is not known.

-- 
Jens Axboe


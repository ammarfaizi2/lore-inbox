Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVGTC3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVGTC3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 22:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVGTC3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 22:29:44 -0400
Received: from [216.208.38.107] ([216.208.38.107]:64645 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261186AbVGTC3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 22:29:43 -0400
Subject: Re: [PATCH] Convert refrigerator() to try_to_freeze()
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050719135425.GA2410@elf.ucw.cz>
References: <1121659148.13493.58.camel@localhost>
	 <20050719135425.GA2410@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121826645.2322.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 20 Jul 2005 12:31:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-07-19 at 23:54, Pavel Machek wrote:
> Hi!
> 
> > This patch removes the few remaining direct invocations of the
> > refrigerator in 2.6.13-rc3. In drivers/media/video/msp3400.c, it also
> > shifts the call to after the remove_wait_queue; this seems to be the
> > more appropriate place.
> 
> 
> > diff -ruNp 230-refrigerator-to-try_to_freeze.patch-old/fs/jbd/journal.c 230-refrigerator-to-try_to_freeze.patch-new/fs/jbd/journal.c
> > --- 230-refrigerator-to-try_to_freeze.patch-old/fs/jbd/journal.c	2005-07-18 06:36:59.000000000 +1000
> > +++ 230-refrigerator-to-try_to_freeze.patch-new/fs/jbd/journal.c	2005-07-18 13:54:47.000000000 +1000
> > @@ -175,7 +175,7 @@ loop:
> >  		 */
> >  		jbd_debug(1, "Now suspending kjournald\n");
> >  		spin_unlock(&journal->j_state_lock);
> > -		refrigerator();
> > +		try_to_freeze();
> >  		spin_lock(&journal->j_state_lock);
> >  	} else {
> >  		/*
> 
> They probably tested it before, why test again?
> 
> > diff -ruNp 230-refrigerator-to-try_to_freeze.patch-old/fs/jfs/jfs_logmgr.c 230-refrigerator-to-try_to_freeze.patch-new/fs/jfs/jfs_logmgr.c
> > --- 230-refrigerator-to-try_to_freeze.patch-old/fs/jfs/jfs_logmgr.c	2005-07-18 06:36:59.000000000 +1000
> > +++ 230-refrigerator-to-try_to_freeze.patch-new/fs/jfs/jfs_logmgr.c	2005-07-18 13:54:47.000000000 +1000
> > @@ -2361,7 +2361,7 @@ int jfsIOWait(void *arg)
> >  		}
> >  		if (freezing(current)) {
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  			spin_unlock_irq(&log_redrive_lock);
> > -			refrigerator();
> > +			try_to_freeze();
> >  		} else {
> >  			add_wait_queue(&jfs_IO_thread_wait, &wq);
> >  			set_current_state(TASK_INTERRUPTIBLE);
> 
> See? You are needlessly testing condition twice.

True. I was just concerned that things are messy and inconsistent as
they stand (sometimes we use try_to_freeze and implicitly call
refrigerator(), sometimes we call freezing() and refrigerator). *shrug*

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


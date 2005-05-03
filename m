Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVECG2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVECG2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 02:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVECG2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 02:28:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:41701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261413AbVECG1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 02:27:55 -0400
Date: Mon, 2 May 2005 23:27:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty races
Message-Id: <20050502232721.19dde63d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504260922001.26392@dhcp83-105.boston.redhat.com>
References: <Pine.LNX.4.61.0504201227370.13902@dhcp83-105.boston.redhat.com>
	<20050425232251.6ffac97c.akpm@osdl.org>
	<Pine.LNX.4.61.0504260922001.26392@dhcp83-105.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baron <jbaron@redhat.com> wrote:
>
> 
> On Mon, 25 Apr 2005, Andrew Morton wrote:
> 
> > Jason Baron <jbaron@redhat.com> wrote:
> > >
> > > There are a couple of tty race conditions, which lead to inconsistent tty 
> > >  reference counting and tty layer oopses.
> > > 
> > >  The first is a tty_open vs. tty_close race in drivers/char/tty.io.c. 
> > >  Basically, from the time that the tty->count is deemed to be 1 and that we 
> > >  are going to free it to the time that TTY_CLOSING bit is set, needs to be 
> > >  atomic with respect to the manipulation of tty->count in init_dev(). This 
> > >  atomicity was previously guarded by the BKL. However, this is no longer 
> > >  true with the addition of a down() call in the middle of the 
> > >  release_dev()'s atomic path. So either the down() needs to be moved 
> > >  outside the atomic patch or dropped. I would vote for simply dropping it 
> > >  as i don't see why it is necessary.
> > 
> > The release_dev() changes looks very fishy to me.  It _removes_ locking. 
> > If that fixes the testcase then one of two things is happening:
> > 
> > a) we have lock_kernel() coverage and the down()'s sleeping breaks the
> >    lock_kenrel() coverage or
> > 
> > b) we don't have lock_kernel() coverage, but removing the down() just
> >    alters the timing and makes the race less probable.
> > 
> > I think it's b).  lock_kernel() coverage in there is very incomplete on the
> > open() side.
> > 
> 
> The patch was written for case a. Indeed lock_kernel() may appear 
> incomplete on the open side, but it protects paths where we don't sleep. 
> So, the 'fast_track' path in 'init_dev', is protected against the 
> release_dev path from setting the 'tty_closing' local variable to the 
> setting of the TTY_CLOSING flag. Thus, i believe the dropping of the 
> down() is correct. 

I don't see anywhere which takes lock_kernel() on the tty_open() path.

The normal release_dev() path takes lock_kernel(), but two error-path
callers of lock_kernel() also appear to not take lock_kernel().

> This was the previous locking model for open vs. close afaict, before the 
> down() was introduced in the release_dev path that was supposed to be 
> atomic with respect to init_dev().

We want to move away from lock_kernel()-based locking.

> 
> > I think it would be better to _increase_ the tty_sem coverage in
> > release_dev() and to make sure that all callers of init_dev() are using
> > tty_sem (they are).
> > 
> > One approach would be to require that all callers of release_dev() hold
> > tty_sem, and make release_dev() drop and reacquire tty_sem in those cases
> > where release_dev() needs to go to sleep when waiting for other threads of
> > control to reelase the tty's resources.
> > 
> 
> Indeed, the situation would be improved if it was held around the 
> driver->close() routine. This routine does sometimes look at tty->count 
> value, see con_close(), where in fact the tty_sem is added to avoid just 
> this problem. However, it is incorrect as one can see in release_dev() the 
> schedule(), can cause the tty->count to change via tty_open(). However, i 
> think this is an extremely rare corner case, b/c con_close() keys off 
> tty->count of 1, which implies that this is the last close() and thus the 
> schedule for 'write_wait' would seem impossible, although AL Viro has 
> said that it is possible in this case. Thus, dropping the tty_sem and 
> reacquiring it, probably isn't good, b/c the driver->close() routines can 
> free resources based upon tty->count==1. 

Maybe we can just hold tty_sem across that schedule() in release_dev().

If not, then maybe retest ->count and take avoiding action if it looks like
some other thread is trying to resurrect the tty.  Obviously this is a much
poorer approach.

> The patch was written as the least invasive and low risk way to fix a 
> nasty race condition, which has the potential to corrupt data. The oops in 
> vt_ioctl has also been seen on system boots with some frequency. The patch 
> imo, returns the the tty_open vs. tty_close paths to their original 
> locking assumptions which have been well tested.
> 

I don't think it does, and the original lock_kernel-based locking is
obsolete.

Please, let's do this properly, with real locks.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262539AbSJBTQl>; Wed, 2 Oct 2002 15:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262545AbSJBTQl>; Wed, 2 Oct 2002 15:16:41 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:54796
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262539AbSJBTQk>; Wed, 2 Oct 2002 15:16:40 -0400
Subject: Re: flock(fd, LOCK_UN) taking 500ms+ ?
From: Robert Love <rml@tech9.net>
To: Matthew Wilcox <willy@debian.org>
Cc: Andrew Morton <akpm@digeo.com>, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021002193052.B28586@parcelfarce.linux.theplanet.co.uk>
References: <20021002023901.GA91171@compsoc.man.ac.uk>
	 <20021002032327.GA91947@compsoc.man.ac.uk>
	 <20021002141435.A18377@parcelfarce.linux.theplanet.co.uk>
	 <3D9B2734.D983E835@digeo.com>
	 <20021002193052.B28586@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1033586465.24108.77.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 02 Oct 2002 15:21:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 14:30, Matthew Wilcox wrote:

> Heh, you're so focused on perf tuning, Andrew!  It's not a matter of
> locking, it's a matter of semantics.  Here's the comment:
> 
>  *  FL_FLOCK locks never deadlock, an existing lock is always removed before
>  *  upgrading from shared to exclusive (or vice versa). When this happens
>  *  any processes blocked by the current lock are woken up and allowed to
>  *  run before the new lock is applied.
>  *  Andy Walker (andy@lysaker.kvaerner.no), June 09, 1995

Oh, I understand now.  In this case, you actually do need to call
yield() as gross as it is.

You have four options:

- call schedule().  This will result in the highest priority task
running again which may be you.  You will certainly end up running again
in the near future and there may be processes blocked by the current
lock which will not run before you continue.

- call cond_resched().  Same as above but avoid the superfluous
reschedule back to yourself, since if need_resched is unset we won't
call schedule().

- call yield().  You are put at the end of the runqueue and thus all
runnable tasks should run before you get to run again.

- do nothing.  Always my choice :)

So yield() is the only way to guarantee that all lock holders run before
you do (it does not even do that, however: it is possible for you to get
reinserted into the active array and thus it only guarantees that all
lock holders at or above your priority get to run before you). 
cond_resched() will guarantee all higher priority tasks run before you.

If you REALLY want to assure you do not run at all until all the other
lock holders ran, you would need to down() a semaphore and not wake up
until all of them have run again (I have no idea how the flock code
looks, if this is even feasible...). 

> > If there really is a solid need to hand the CPU over to some now-runnable
> > higher-priority process then a cond_resched() will suffice.
> 
> I think that's the right thing to do.  If I understand right, we'll
> check needs_resched at syscall exit, so we don't need to do it for
> unlocks, right?

Right.  On return to user-space need_resched will be checked and
schedule() called if it is set.

However, it is only set if the newly woken up tasks have a higher
priority than you.  Otherwise, schedule() would just select you again.

	Robert Love


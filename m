Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262531AbSJBSZ0>; Wed, 2 Oct 2002 14:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbSJBSZ0>; Wed, 2 Oct 2002 14:25:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31246 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262531AbSJBSZY>;
	Wed, 2 Oct 2002 14:25:24 -0400
Date: Wed, 2 Oct 2002 19:30:52 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Matthew Wilcox <willy@debian.org>, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: flock(fd, LOCK_UN) taking 500ms+ ?
Message-ID: <20021002193052.B28586@parcelfarce.linux.theplanet.co.uk>
References: <20021002023901.GA91171@compsoc.man.ac.uk> <20021002032327.GA91947@compsoc.man.ac.uk> <20021002141435.A18377@parcelfarce.linux.theplanet.co.uk> <3D9B2734.D983E835@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9B2734.D983E835@digeo.com>; from akpm@digeo.com on Wed, Oct 02, 2002 at 10:04:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 10:04:52AM -0700, Andrew Morton wrote:
> sched_yield() sementics changed a lot.  It used to mean "take a quick
> nap", but it now means "go to the back of the runqueue and stay there
> for absolutely ages".  The latter is a closer interpretation of the spec,
> but it has broken stuff which was tuned to the old behaviour.

*nod*.  This code has been around for many many years ;-)

> It's not really clear why that yield is in there at all?  Unless that
> code is really, really slow (milliseconds) then probably it should just
> be deleted.

Heh, you're so focused on perf tuning, Andrew!  It's not a matter of
locking, it's a matter of semantics.  Here's the comment:

 *  FL_FLOCK locks never deadlock, an existing lock is always removed before
 *  upgrading from shared to exclusive (or vice versa). When this happens
 *  any processes blocked by the current lock are woken up and allowed to
 *  run before the new lock is applied.
 *  Andy Walker (andy@lysaker.kvaerner.no), June 09, 1995

> If there really is a solid need to hand the CPU over to some now-runnable
> higher-priority process then a cond_resched() will suffice.

I think that's the right thing to do.  If I understand right, we'll
check needs_resched at syscall exit, so we don't need to do it for
unlocks, right?

-- 
Revolutions do not require corporate support.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262557AbSJBTVJ>; Wed, 2 Oct 2002 15:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262558AbSJBTVJ>; Wed, 2 Oct 2002 15:21:09 -0400
Received: from packet.digeo.com ([12.110.80.53]:46991 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262557AbSJBTVH>;
	Wed, 2 Oct 2002 15:21:07 -0400
Message-ID: <3D9B4797.8399682@digeo.com>
Date: Wed, 02 Oct 2002 12:23:03 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: flock(fd, LOCK_UN) taking 500ms+ ?
References: <20021002023901.GA91171@compsoc.man.ac.uk> <20021002032327.GA91947@compsoc.man.ac.uk> <20021002141435.A18377@parcelfarce.linux.theplanet.co.uk> <3D9B2734.D983E835@digeo.com> <20021002193052.B28586@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2002 19:23:06.0631 (UTC) FILETIME=[22A6D170:01C26A49]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> 
> ...
>  *  FL_FLOCK locks never deadlock, an existing lock is always removed before
>  *  upgrading from shared to exclusive (or vice versa). When this happens
>  *  any processes blocked by the current lock are woken up and allowed to
>  *  run before the new lock is applied.
>  *  Andy Walker (andy@lysaker.kvaerner.no), June 09, 1995

hm.  This is a tricky thing to guarantee.  If this process is
high-priority or SCHED_RR or whatever, we want to ensure that
any current holder of the lock gets a CPU slice?

Seems a strange thing to want to do, and if we really want to
implement these semantics then there's quite a bit of stuff
to do - making *all* blocked processes get some CPU will involve
scheduler work, or funny games with semaphores.

Now if we interpret "allowed to run" as meaning "made runnable" then
no probs.  Just wake them up.
 
> > If there really is a solid need to hand the CPU over to some now-runnable
> > higher-priority process then a cond_resched() will suffice.
> 
> I think that's the right thing to do.  If I understand right, we'll
> check needs_resched at syscall exit, so we don't need to do it for
> unlocks, right?

Sure.  Sounds to me like we just want to delete the code ;)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbSJBT7k>; Wed, 2 Oct 2002 15:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262565AbSJBT7k>; Wed, 2 Oct 2002 15:59:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37391 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262564AbSJBT7k>;
	Wed, 2 Oct 2002 15:59:40 -0400
Date: Wed, 2 Oct 2002 21:05:08 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Matthew Wilcox <willy@debian.org>, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: flock(fd, LOCK_UN) taking 500ms+ ?
Message-ID: <20021002210508.C28586@parcelfarce.linux.theplanet.co.uk>
References: <20021002023901.GA91171@compsoc.man.ac.uk> <20021002032327.GA91947@compsoc.man.ac.uk> <20021002141435.A18377@parcelfarce.linux.theplanet.co.uk> <3D9B2734.D983E835@digeo.com> <20021002193052.B28586@parcelfarce.linux.theplanet.co.uk> <3D9B4797.8399682@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9B4797.8399682@digeo.com>; from akpm@digeo.com on Wed, Oct 02, 2002 at 12:23:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 12:23:03PM -0700, Andrew Morton wrote:
> hm.  This is a tricky thing to guarantee.  If this process is
> high-priority or SCHED_RR or whatever, we want to ensure that
> any current holder of the lock gets a CPU slice?
> 
> Seems a strange thing to want to do, and if we really want to
> implement these semantics then there's quite a bit of stuff
> to do - making *all* blocked processes get some CPU will involve
> scheduler work, or funny games with semaphores.
> 
> Now if we interpret "allowed to run" as meaning "made runnable" then
> no probs.  Just wake them up.

Yeah, I think the original author was a little imprecise in his description
of the semantics.  The freebsd flock(2) manpage says:

     A shared lock may be upgraded to an exclusive lock, and vice versa, sim­
     ply by specifying the appropriate lock type; this results in the previous
     lock being released and the new lock applied (possibly after other pro­
     cesses have gained and released the lock).

So I think what they're trying to say is that changing the lock type is
exactly equivalent to removing the existing lock and then applying the
new lock; it just happens to be one syscall.  Using cond_resched() looks
like the right approach.

-- 
Revolutions do not require corporate support.

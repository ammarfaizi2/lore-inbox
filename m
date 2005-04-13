Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVDMAd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVDMAd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVDMAbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:31:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40944 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262931AbVDMA17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 20:27:59 -0400
Subject: RE: FUSYN and RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Esben Nielsen <simlo@phys.au.dk>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113352069.6388.39.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Apr 2005 17:27:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a great big snag in my assumptions. It's possible for a process
to hold a fusyn lock, then block on an RT lock. In that situation you
could have a high priority user space process be scheduled then block on
the same fusyn lock but the PI wouldn't be fully transitive , plus there
will be problems when the RT mutex tries to restore the priority. 

We could add simple hooks to force the RT mutex to fix up it's PI, but
it's not a long term solution.

Daniel


On Tue, 2005-04-12 at 16:11, Esben Nielsen wrote:
> I think we (at least) got a bit confused here. What (I think) the thread
> started out with was a clear layering of the mutexes. I.e. the code obeys
> the grammar
> 
>  VALID_LOCK_CODE   = LOCK_FUSYN VALID_LOCK_CODE UNLOCK_FUSYN 
>                    | VALID_LOCK_CODE VALID_LOCK_CODE
>                    | VALID_RTLOCK_CODE
>  VALID_RTLOCK      = LOCK_RTLOCK VALID_RTLOCK_CODE UNLOCK_RTLOCK
>                    | VALID_RTLOCK_CODE VALID_RTLOCK_CODE
>                    | VALID_SPINLOCK_CODE
>                    | (code with no locks at all)
>  VALID_SPINLOCK_CODE = ... :-)
> 
> In that context the case is simple: Fusyn's and RT-locks can easily
> co-exist. One only need an extra level akin to static_prio to fall back to
> when the last fusyn is unlocked. The API's should be _different_, but
> fusyn_setprio() should both update static_prio and call mutex_setprio().
> There will never be deadlocks involving both types of locks, as Daniel
> said because the lock nesting is sorted out. Furtheremore, unbalanced
> (incorrect) code like
>        LOCK_FUSYN VALID_RTLOCK_CODE (no unlock)
> will never hit the RT-level. So assuming the RT-lock based code is
> debugged the error must be in Fusyn based code.
> 
> Esben
> 
> On Tue, 12 Apr 2005, Perez-Gonzalez, Inaky wrote:
> 
> > >From: Esben Nielsen [mailto:simlo@phys.au.dk]
> > >On 12 Apr 2005, Daniel Walker wrote:
> > >
> > >>
> > >>
> > >> At least, both mutexes will need to use the same API to raise and
> > lower
> > >> priorities.
> > >
> > >You basicly need 3 priorities:
> > >1) Actual: task->prio
> > >2) Base prio with no RT locks taken: task->static_prio
> > >3) Base prio with no Fusyn locks taken: task->??
> > >
> > >So no, you will not need the same API, at all :-) Fusyn manipulates
> > >task->static_prio and only task->prio when no RT lock is taken. When
> > the
> > >first RT-lock is taken/released it manipulates task->prio only. A
> > release
> > >of a Fusyn will manipulate task->static_prio as well as task->prio.
> > 
> > Yes you do. You took care of the simple case. Things get funnier
> > when you own more than one PI lock, or you need to promote a
> > task that is blocked on other PI locks whose owners are blocked
> > on PI locks (transitivity), or when you mix PI and PP (priority
> > protection/ priority ceiling).
> > 
> > In that case not having a sim{pl,g}e API for doing it is nuts.
> > 
> > >> The next question is deadlocks. Because one mutex is only in the
> > kernel,
> > >> and the other is only in user space, it seems that deadlocks will
> > only
> > >> occur when a process holds locks that are all the same type.
> > >
> > >Yes.
> > >All these things assumes a clear lock nesting: Fusyns are on the outer
> > >level, RT locks on the inner level. What happens if there is a bug in
> > RT
> > >locking code will be unclear. On the other hand errors in Fusyn locking
> > >(user space) should not give problems in the kernel.
> > 
> > Wrong. Fusyns are kernel locks that are exposed to user space (much as
> > a file descriptor is a kernel object exposed to user space through
> > a system call). Of course if the user does something mean with them
> > they will cause an error, but should not have undesired consequences
> > in the kernel. But BUGS in the code will be as unclear as in RT mutexes.
> > 
> > >it is is bad maintainance to have to maintain two seperate systems. The
> > >best way ought to be to try to only have one PI system. The kernel is
> > big
> > >and confusing enough as it is!
> > 
> > Ayeh for the big...it is not that confusing :)
> > 
> > -- Inaky
> > 
> 
> 


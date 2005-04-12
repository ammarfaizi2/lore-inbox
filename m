Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbVDMAIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVDMAIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVDMAF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:05:57 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:31657 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262123AbVDLUaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:30:15 -0400
Date: Tue, 12 Apr 2005 22:29:36 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, inaky.perez-gonzalez@intel.com,
       mingo@elte.hu
Subject: Re: FUSYN and RT
In-Reply-To: <1113329702.23407.148.camel@dhcp153.mvista.com>
Message-Id: <Pine.OSF.4.05.10504122206230.6111-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Apr 2005, Daniel Walker wrote:

> 
> I just wanted to discuss the problem a little more. From all the
> conversations that I've had it seem that everyone is worried about
> having PI in Fusyn, and PI in the RT mutex. 
> 
> It seems like these two locks are going to interact on a very limited
> basis. Fusyn will be the user space mutex, and the RT mutex is only in
> the kernel. You can't lock an RT mutex and hold it, then lock a Fusyn
> mutex (anyone disagree?). That is assuming Fusyn stays in user space.
> 
> The RT mutex will never lower a tasks priority lower than the priority
> given to it by locking a Fusyn lock.

I have not seen the Fusyn code. Where is the before-any-lock priority
stored? Ingo's code sets the prio back to what is given by static_prio.
So, if Fusyn sets static_prio it will work as you say. It it will then be
up to Fusyn to restore static_prio to what it was before the first Fusyn
lock.

> 
> At least, both mutexes will need to use the same API to raise and lower
> priorities.

You basicly need 3 priorities:
1) Actual: task->prio
2) Base prio with no RT locks taken: task->static_prio
3) Base prio with no Fusyn locks taken: task->??

So no, you will not need the same API, at all :-) Fusyn manipulates
task->static_prio and only task->prio when no RT lock is taken. When the
first RT-lock is taken/released it manipulates task->prio only. A release
of a Fusyn will manipulate task->static_prio as well as task->prio.

> 
> The next question is deadlocks. Because one mutex is only in the kernel,
> and the other is only in user space, it seems that deadlocks will only
> occur when a process holds locks that are all the same type.

Yes.
All these things assumes a clear lock nesting: Fusyns are on the outer
level, RT locks on the inner level. What happens if there is a bug in RT
locking code will be unclear. On the other hand errors in Fusyn locking
(user space) should not give problems in the kernel.

> 
> 
> Daniel
> 

I think that it might be a fast track to get things done to have a double
PI-locking system, one for the kernel and one for userspace. But I think
it is is bad maintainance to have to maintain two seperate systems. The
best way ought to be to try to only have one PI system. The kernel is big
and confusing enough as it is!

Esben


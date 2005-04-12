Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263054AbVDLXoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbVDLXoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVDLXmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:42:33 -0400
Received: from fmr20.intel.com ([134.134.136.19]:44772 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262970AbVDLXhq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:37:46 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FUSYN and RT
Date: Tue, 12 Apr 2005 16:36:42 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02FD47B8@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FUSYN and RT
Thread-Index: AcU/tOxcZ3y1egFETqCn7twAr961FQAAUiqg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Esben Nielsen" <simlo@phys.au.dk>
Cc: "Daniel Walker" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>
X-OriginalArrivalTime: 12 Apr 2005 23:36:44.0531 (UTC) FILETIME=[7C815430:01C53FB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Esben Nielsen [mailto:simlo@phys.au.dk]
>
>I think we (at least) got a bit confused here. What (I think) the
thread
>started out with was a clear layering of the mutexes. I.e. the code
obeys
>the grammar
>
> VALID_LOCK_CODE   = LOCK_FUSYN VALID_LOCK_CODE UNLOCK_FUSYN
>                   | VALID_LOCK_CODE VALID_LOCK_CODE
>                   | VALID_RTLOCK_CODE
> VALID_RTLOCK      = LOCK_RTLOCK VALID_RTLOCK_CODE UNLOCK_RTLOCK
>                   | VALID_RTLOCK_CODE VALID_RTLOCK_CODE
>                   | VALID_SPINLOCK_CODE
>                   | (code with no locks at all)
> VALID_SPINLOCK_CODE = ... :-)

Errrr...sorry, /me no comprende but I get the idea :)

Going back to the API problem I guess it'd be possible to code 
an equivalent of __prio_boost [your fusyn_setprio()], 
but it still does not answer another underlying problem. 

mutex_setprio() won't take into account the case where a task
(1) takes a mutex, (2) it is boosted for that, (3) it (or somebody 
else) changes its priority and then (4) it is deboosted. 

[4] will deboost it to the prio (static or RT) it had before 
boosting (at [1]), not the new one set at [3] (am I right, Ingo? I
didn't see any hooks in sched_setscheduler() and friends).

Now, this would be easy to solve: do a hook up in any function that
is going to touch the priority, and then for every owned mutex,
go updating the mutex->owner_prio. 

And now the underlying problem: this is where it gets plenty of 
complex when you have to implement PI transitivity--suddenly whenever
I boost an owner I have to walk all the mutexes that it potentially
owns. This becomes O(fugly) the minute you have an ownership chain
deeper than two or three levels with each owner owning more than a
couple of mutexes.

So that's why I chose to put it in the task struct, it becomes O(1)
at the expense (granted) of having to calc a min each time we compute
the dynamic priority.

But these are implementation details

> ...
>will never hit the RT-level. So assuming the RT-lock based code is
>debugged the error must be in Fusyn based code.

Naaah :)

-- Inaky


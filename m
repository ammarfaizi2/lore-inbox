Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161141AbWBQAn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbWBQAn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbWBQAn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:43:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:32156 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161141AbWBQAn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:43:58 -0500
Date: Fri, 17 Feb 2006 01:42:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Arjan van de Ven <arjan@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
Message-ID: <20060217004212.GC12143@elte.hu>
References: <20060216233952.GB12143@elte.hu> <Pine.OSF.4.05.10602170111450.22107-100000@da410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10602170111450.22107-100000@da410>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > > > this is racy - we cannot know whether the PID wrapped around.
> > > >
> > > What about adding more bits to check on? The PID to lookup the task_t 
> > > and then some extra bits to uniquely identify the actual task.
> > 
> > which would just be a fancy name for a wider PID space, and would thus 
> > still not protect against PID reuse :-)
> > 
>
> Can it really be correct there is no way to uniquely identify a thread 
> in the uptime of the system? It could be done with BigIntegers :-)

well, that's how PIDs work. I'd have no problem with 64-bit PIDs/TIDs in 
theory, but besides a _massive_ ABI break (which makes the whole thing a 
non-starter), users would probably resist 'ps' output like:

 917239487098712349  tty8     Ss+    0:00 -bash
 1844674407370955161 tty9     Ss+    0:00 -bash
 1356415698798712343 tty10    Ss+    0:00 -bash

:-| Another problem is that futexes are fundamentally 32-bit, so there's 
no space in them for 64-bit TIDs ...

> > i'm not sure i follow - what list is this and how would it be 
> > maintained?
> 
> At the FUTEX_WAIT operation add the waiter to a list of waiters on the 
> owner's task_t. At FUTEX_WAKE remove the waiter. At task exit wake up 
> the waiters.

well, but even in this case the kernel has no idea (currently) about the 
owner - it is the waiters that have kernel state in this case. So extra 
code would have to be added to look up the TID, make sure the lookup is 
secure: check that the task looked up is really mapping that vma, and to 
queue waiters to the owner. Quite clumsy ... and this is still only the 
easy case, when the kernel is involved in the futex use.

> > > I admit your solution is a good one. The only drawback - besides being 
> > > untraditional - is that memory corruption can leave futexes locked at 
> > > exit.
> > 
> > so? Memory corruption can overwrite the futex value anyway, and can thus 
> > cause the wrong owner to be identified - causing a locked futex. This 
> > patch does not protect against bad effects of memory corruption - 
> > there's really no way to keep userspace from breaking itself.
> > 
> 
> At least you could wake up those who are already blocked in the 
> kernel...

which would be of little use if the wrong TID is in the futex. There's 
really no protection against userspace breaking itself.

	Ingo

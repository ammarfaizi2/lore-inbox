Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWBPXlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWBPXlo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 18:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWBPXlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 18:41:44 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:8079 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932520AbWBPXln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 18:41:43 -0500
Date: Fri, 17 Feb 2006 00:39:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Arjan van de Ven <arjan@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
Message-ID: <20060216233952.GB12143@elte.hu>
References: <20060216223618.GA8182@elte.hu> <Pine.OSF.4.05.10602170003380.22107-100000@da410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10602170003380.22107-100000@da410>
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

> > this is racy - we cannot know whether the PID wrapped around.
> >
> What about adding more bits to check on? The PID to lookup the task_t 
> and then some extra bits to uniquely identify the actual task.

which would just be a fancy name for a wider PID space, and would thus 
still not protect against PID reuse :-)

> > nor does this method offer any solution for the case where there are 
> > already waiters pending: they might be hung forever. 
>
> It was for this case I suggested maintaining a list of waiters within 
> the kernel on each task_t. The adding has to be done FUTEX_WAIT so the 
> adding operation needs to be protected.

i'm not sure i follow - what list is this and how would it be 
maintained?

> > With our solution 
> > one of those waiters gets woken up and notice that the lock is dead. 
> > (and in the unlikely even of that thread dying too while trying to 
> > recover the data, the kernel will do yet another wakeup, of the next 
> > waiter.)
> > 
> I admit your solution is a good one. The only drawback - besides being 
> untraditional - is that memory corruption can leave futexes locked at 
> exit.

so? Memory corruption can overwrite the futex value anyway, and can thus 
cause the wrong owner to be identified - causing a locked futex. This 
patch does not protect against bad effects of memory corruption - 
there's really no way to keep userspace from breaking itself.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTD3X3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTD3X3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:29:34 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:26894
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262567AbTD3X3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:29:31 -0400
Subject: Re: must-fix list for 2.6.0
From: Robert Love <rml@tech9.net>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org, frankeh@us.ibm.com
In-Reply-To: <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
References: <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1051746092.17629.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 30 Apr 2003 19:41:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-30 at 19:11, Rick Lindsley wrote:

>    OLD: when sched_yield() is called the task moves to expired,
> 	every other task in the active queue will run first before the
> 	yielding task will run again.

I really think this is the right way.

>    NEW: move the yielding task to the end of its current priority level,
> 	but keeps it active not expired.

This takes us back to the problem we saw in earlier sched_yield()
implementations.  A group of yielding threads just round-robin between
themselves, yielding over and over.  Worse, even a single task alone in
a priorty level will show up as a CPU hog if it keeps calling
sched_yield() in a loop.

It goes on.  Assume we have two runnable tasks, one that does whatever
it wants (hopefully something useful), and the other which does:

	while(1)
		sched_yield();

With the current sched_yield(), the second will receive much less
processor time than the first (nearly none vs. most of the processor). 
With the sched_yield() mentioned above, they will receive identical
amounts of processor time.  That does not seem sane to me.

I think it is important that sched_yield() give processor time to all
tasks, and not just between multiple yielding tasks.

The current implementation does this.  If an application (*cough* Open
Office *cough*) calls sched_yield() over and over, what does it expect?

Now that we have futexes, sched_yield() no longer needs to be used as a
poor replacement for blocking, and it can have sane semantics, such as
_really_ yielding the processor.

> 	What else could be done?
> 	(a) drop the effective priority of the yielding task by a percentile,
> 	    but don't reduce the time slice!

This works, too.  We used to do this..

There are a couple bits that need to be added, though, to deal with
threads that call sched_yield() over and over (which are the ones where
we have problems).  We need to drop the task a priority level every time
it calls sched_yield().  Eventually it will reach the lowest priority
(or some earlier threshold we want to check for) and then we need to put
it on the expired list, like the current behavior.

So for the big offenders, I think this ends up being the same, no?

Also, this approach does not work for real-time tasks, for whom we must
not change their priority... so we end up just requeing them, too.

Just my thoughts...

	Robert Love


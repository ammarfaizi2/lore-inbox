Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWA2Nyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWA2Nyl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 08:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWA2Nyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 08:54:41 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63418 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750997AbWA2Nyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 08:54:40 -0500
Date: Sun, 29 Jan 2006 14:55:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch, lock validator] fix uidhash_lock <-> RCU deadlock
Message-ID: <20060129135508.GA31156@elte.hu>
References: <20060125142307.GA5427@elte.hu> <1138208378.3992.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138208378.3992.7.camel@localhost.localdomain>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> On Wed, 2006-01-25 at 15:23 +0100, Ingo Molnar wrote:
> > RCU task-struct freeing can call free_uid(), which is taking 
> > uidhash_lock - while other users of uidhash_lock are softirq-unsafe.
> > 
> > This bug was found by the lock validator i'm working on:
> 
> What is it doing exactly ?

the lock validator is building a runtime graph of lock dependencies, as 
they occur. The granularity is not per lock instance, but per lock 
"type" - making it easier (and more likely) to find deadlocks, without 
having those deadlocks to trigger. So it's a proactive thing, not a 
reactive thing like the current mutex deadlock detection code.

the type granularity also has the positive effect that locking 
dependencies between two locks have only be mapped once per bootup, for 
any arbitrary object or task that makes use of that lock.

the directed graph is constantly kept valid: when a new dependency is 
added then it's checked for circular dependencies.

the validator is also tracking the usage characteristics of locks: 
whether they are used in hardirq context, softirq context, whether they 
are held with hardirqs enabled, softirqs enabled.

then when a lock is taken in an irq context, or is taken with interrupts 
enabled, or interrupts are enabled with the lock held, the validator 
immediately transitions that lock (type) to the new usage state - and 
validates all the ripple effects within the graph. [i.e. it validates 
all locks dependending on this lock, and validates all locks this lock 
is depending on.]

the end-result is that this validator gets very close to being able to 
prove the theoretical code-correctness of lock usage within Linux, for 
all codepaths that occur at least once per bootup. This it can do even 
on a uniprocessor system.

i'll release the code soon. I wrote it as a debugging extension to 
mutexes, but now it covers spinlocks and rwlocks too.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVEZVAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVEZVAE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEZUsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:48:36 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:47883 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261759AbVEZUr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:47:57 -0400
Date: Thu, 26 May 2005 13:52:27 -0700
To: Andi Kleen <ak@muc.de>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050526205227.GA3776@nietzsche.lynx.com>
References: <1116981913.19926.58.camel@dhcp153.mvista.com> <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526193230.GY86087@muc.de>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 09:32:30PM +0200, Andi Kleen wrote:
> I understand that you have some real improvements that are measurable.
> What I objected to was the claim that it actually made any difference
> to interactive users.

At first, no. It's a complicated problem and kernel preemptibility is
only a part of it. It's a critical part of it since it's got to
eventually feed to a scheduler of some sort. Feeding large temporal
chunks, high latency, to a scheduler defeats how priority in the system
is expressed in relation to other threads in the system.

> What I dislike with RT mutexes is that they convert all locks.
> It doesnt make much sense to me to have a complex lock that
> only protects a few lines of code (and a lot of the spinlock
> code is like this). That is just a waste of cycles.

Yeah, but really this is can only seriously be taken if you have numbers
showing that there's more contention on these paths. Until that happens
the actual scenario is unknown. But I strongly suspect that it doesn't
really make a difference mainly because of all of the SMP work that's
been done to Linux over the years. It's fundamentally about a contention
problem.

> But I always though we should have a new lock type that is between
> spinlocks and semaphores and is less heavyweight than a semaphore
> (which tends to be quite slow due to its many context switches). Something
> like a spinaphore, although it probably doesnt need full semaphore
> semantics (rarely any code in the kernel uses that anyways). It could
> spin for a short time and then sleep. Then convert some selected
> locks over. e.g. the mm_sem and the i_sem would be primary users of this.
> And maybe some of the heavier spinlocks.

Adaptiving spinning is a difficult thing to do since you have to snoop
for the active "current" on other processors to determine if you have to
sleep or not. FreeBSD 5.x uses this stuff and the locking code is very
complicated. In the future, it maybe desirable to incorporate parts of
this functionality into another RT mutex implementation. The current one
is overloaded enough with functionality as is .

> If you drop irq threads then you cannot convert all locks
> anymore or have to add ugly in_interrupt()checks. So any conversion like
> that requires converting locks.

That's reversed. Interrupt threads are an isolated change itself and can
be submitted upstream if so desired with no associated lock changes.
But that paragraph above is rather vague, so I can only guess at what you're
talking about. There are ways of doing context stealing with irq-threads to
minimize overhead and the FreeBSD folks have partially implemented this from
my memory.

bill


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVF1HCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVF1HCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVF1Ggl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:36:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17317 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261633AbVF1G12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:27:28 -0400
Date: Mon, 27 Jun 2005 23:27:11 -0700
Message-Id: <200506280627.j5S6RBSd027251@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: eliminate unneccessary sighand locking
In-Reply-To: Oleg Nesterov's message of  Tuesday, 28 June 2005 10:17:46 +0400 <42C0EB8A.4F6F1336@tv-sign.ru>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think this would be a bug. If some another process can spin for
> ourtask->sighand->siglock without holding tasklist_lock it can
> read ourtask->sighand == oldsighand and spin for oldsighand->siglock.
> 
> Then de_thread frees oldsighand:
> 	if (atomic_dec_and_test(&oldsighand->count))
> 		kmem_cache_free(sighand_cachep, oldsighand);
> 
> And we have use after free.

That is not the scenario.  Something else must hold tasklist_lock while
acquiring ourtask->sighand->siglock, but need not hold tasklist_lock
throughout.  Someone can be holding oldsighand->lock but not not
tasklist_lock, at the time we lock tasklist_lock.  So like I said, we need
to hold oldsighand->siglock until the switch has been done.

It's possible that no such scenarios exist, but I'd really have to check on
that.  My recollection is that there might be some.

> So I strongly believe we do not need to lock newsighand->siglock
> at least.

The only reason to hold newsighand->siglock there is for the call to
recalc_sigpending.  

> And what about recalc_sigpending() ? Do you think it is needed?

I don't think the need for it has anything to do with switching
current->sighand.  That is, either it's needed in both cases or not at all.
I suspect it lingers from past revisions of this code and related signals
code that previously needed it.  I believe the redistribution of pending
signals done at the top of exit_notify covers all the need, and that will
have run in all the thread dying before we get to the end of de_thread.

So I would tentatively conclude that recalc_sigpending is not needed here.
(Of course, that call is always harmless.  So there isn't a pressing need
to take it out.)

> Just for my education, could you please point me to the existed example?

It would require some auditing to hunt down whether they exist or don't.
To make the change you suggest would require complete confidence none exist.


Thanks,
Roland

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVF1I40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVF1I40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVF1Izu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:55:50 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:8676 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261610AbVF1GIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:08:44 -0400
Message-ID: <42C0EB8A.4F6F1336@tv-sign.ru>
Date: Tue, 28 Jun 2005 10:17:46 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: eliminate unneccessary sighand locking
References: <200506280150.j5S1oZ6V004866@magilla.sf.frob.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:
>
> > while switching current->sighand de_thread does:
> >
> > 	write_lock_irq(&tasklist_lock);
> > 	spin_lock(&oldsighand->siglock);
> > 	spin_lock(&newsighand->siglock);
> >
> > 	current->sighand = newsighand;
> > 	recalc_sigpending();
> >
> > Is these 2 sighand locks are really needed?
>
> Yes.  Other processes can do spin_lock_irq(&ourtask->sighand->siglock);
> without holding tasklist_lock.  If someone just did that, they hold
> oldsighand->siglock but no newsighand->siglock, and may then be about to
> look at ourtask->sighand.  By holding oldsighand->siglock, we ensure that
> we can't be colliding with anything like that.

I think this would be a bug. If some another process can spin for
ourtask->sighand->siglock without holding tasklist_lock it can
read ourtask->sighand == oldsighand and spin for oldsighand->siglock.

Then de_thread frees oldsighand:
	if (atomic_dec_and_test(&oldsighand->count))
		kmem_cache_free(sighand_cachep, oldsighand);

And we have use after free.

So I strongly believe we do not need to lock newsighand->siglock
at least.

And what about recalc_sigpending() ? Do you think it is needed?

> > The only possibility that I can imagine is that some process
> > does:
> > 	read_lock(tasklist_lock);
> > 	task = find_task();
> > 	spin_lock(task->sighand->siglock);
> > 	read_unlock(tasklist_lock);
> > 	play with task->signal
> >
> > Is this possible/allowed?
>
> Yes.

Just for my education, could you please point me to the existed
example?

Oleg.

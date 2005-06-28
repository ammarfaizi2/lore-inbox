Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVF1BvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVF1BvH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 21:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVF1BvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 21:51:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48024 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262370AbVF1Bu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 21:50:58 -0400
Date: Mon, 27 Jun 2005 18:50:35 -0700
Message-Id: <200506280150.j5S1oZ6V004866@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: eliminate unneccessary sighand locking
In-Reply-To: Oleg Nesterov's message of  Sunday, 19 June 2005 20:13:06 +0400 <42B59992.3EFD4C73@tv-sign.ru>
Emacs: you'll understand when you're older, dear.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> while switching current->sighand de_thread does:
> 
> 	write_lock_irq(&tasklist_lock);
> 	spin_lock(&oldsighand->siglock);
> 	spin_lock(&newsighand->siglock);
> 
> 	current->sighand = newsighand;
> 	recalc_sigpending();
> 
> Is these 2 sighand locks are really needed?

Yes.  Other processes can do spin_lock_irq(&ourtask->sighand->siglock);
without holding tasklist_lock.  If someone just did that, they hold
oldsighand->siglock but no newsighand->siglock, and may then be about to
look at ourtask->sighand.  By holding oldsighand->siglock, we ensure that
we can't be colliding with anything like that.  

> The only possibility that I can imagine is that some process
> does:
> 	read_lock(tasklist_lock);
> 	task = find_task();
> 	spin_lock(task->sighand->siglock);
> 	read_unlock(tasklist_lock);
> 	play with task->signal
> 
> Is this possible/allowed?

Yes.

> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

NAK from me.


Thanks,
Roland

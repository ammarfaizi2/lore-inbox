Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTIPBEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 21:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbTIPBDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 21:03:23 -0400
Received: from dp.samba.org ([66.70.73.150]:21948 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261724AbTIPBDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 21:03:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jamie Lokier <jamie@shareable.org>,
       Felipe W Damasio <felipewd@terra.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/futex.c: Uneeded memory barrier 
In-reply-to: Your message of "Mon, 15 Sep 2003 10:23:06 +0100."
             <20030915102306.A22451@flint.arm.linux.org.uk> 
Date: Tue, 16 Sep 2003 02:32:24 +1000
Message-Id: <20030916010313.EE0812C799@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030915102306.A22451@flint.arm.linux.org.uk> you write:
> On Mon, Sep 15, 2003 at 01:41:30PM +1000, Rusty Russell wrote:
> > ....hiding the subtlety in wrapper functions is the wrong approach.  We
> > have excellent wait_event, wait_event_interruptible and
> > wait_event_interruptible_timeout macros in wait.h which these drivers
> > should be using, which would make them simpler, less buggy and
> > smaller.
> 
> "smaller and simpler" hmm.  And _more_ buggy.  Let's take this case:
> 
> 	add_wait_queue(&wq, &wait);
> 	for (;;) {
> 		set_current_state(TASK_INTERRUPTIBLE);
> 		if (condition)
> 			break;
> 		if (file->f_flags & O_NONBLOCK) {
> 			ret = -EAGAIN;
> 			break;
> 		}
> 		if (signal_pending(current)) {
> 			ret = -ERESTARTSYS;
> 			break;
> 		}
> 		schedule();
> 	}
> 	__set_current_state(TASK_RUNNING);
> 	remove_wait_queue(&wq, &wait);
> 
> There are cases like the above which make the wait_event*() macros
> inappropriate:

There are, sure, but I'm not sure this is really one:

	ret = 0;
	if (file->f_flags & O_NONBLOCK) {
		if (!condition)
			ret = -EAGAIN;
	} else
		wait_event_interruptible(&wq, condition, &ret);

AFAICT this is equivalent, and clearer?

> - needing to atomically dequeue some data

Definitely: the futex code is a good example of this.  But the
presence of spinlocks actually makes the barrier issue vanish anyway.

> I've yet to see anyone using wait_event*() in these circumstances -
> they're great for your simple "did something happen" case which the
> majority of drivers use, but there are use cases where wait_event*()
> is not appropriate.

I don't mind someone doing something weird and needing to use lower
primitives, but I still feel the wait_event* family are badly
underused.  Perhaps it's just lack of publicity...

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

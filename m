Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUGZX7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUGZX7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUGZX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:59:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:34467 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265691AbUGZX71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:59:27 -0400
Date: Mon, 26 Jul 2004 16:57:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC][2.6.8-rc1-mm1] perfctr inheritance locking issue
Message-Id: <20040726165754.1a4eda43.akpm@osdl.org>
In-Reply-To: <200407201122.i6KBMbPR021614@harpo.it.uu.se>
References: <200407201122.i6KBMbPR021614@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> Andrew,
> 
> There is another locking problem with the per-process
> performance counter inheritance changes I sent you.
> 
> I currently use task_lock(tsk) to synchronise accesses
> to tsk->thread.perfctr, when that pointer could change.
> 
> The write_lock_irq(&tasklist_lock) in release_task() is
> needed to prevent ->parent from changing while releasing the
> child, but the parent's ->thread.perfctr must also be locked.
> However, sched.h explicitly forbids holding task_lock()
> simultaneously with write_lock_irq(&tasklist_lock). Ouch.

That's ghastly.

 * Nests both inside and outside of read_lock(&tasklist_lock).
 * It must not be nested with write_lock_irq(&tasklist_lock),
 * neither inside nor outside.

Manfred, where did you discover the offending code?

> My options seem to boil down to one of the following:
> 1. Forget task_lock(), always take the tasklist_lock.
>    This should work but would lock the task list briefly at
>    operations like set_cpus_allowed(), and creating/deleting
>    a task's perfctr state object. I don't like that.
> 2. Add a 'spinlock_t perfctr_lock;' to the thread_struct,
>    next to the perfctr state pointer. This is much cleaner,
>    but increases the size of the thread struct slightly.
> 
> I think I prefer option #2. Any objections to that?

Would be better to just sort out the locking, then take task_lock() inside
tasklist_lock.  That was allegedly the rule in 2.4.

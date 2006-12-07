Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032407AbWLGQzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032407AbWLGQzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032411AbWLGQzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:55:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43555 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032407AbWLGQzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:55:09 -0500
Date: Thu, 7 Dec 2006 08:54:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davem@davemloft.com, wli@holomorphy.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] WorkStruct: Use direct assignment rather than
 cmpxchg()
Message-Id: <20061207085409.228016a2.akpm@osdl.org>
In-Reply-To: <20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com>
References: <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com>
	<20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 15:31:43 +0000
David Howells <dhowells@redhat.com> wrote:

> Use direct assignment rather than cmpxchg() as the latter is unavailable and
> unimplementable on some platforms and is actually unnecessary.
> 
> The use of cmpxchg() was to guard against two possibilities, neither of which
> can actually occur:
> 
>  (1) The pending flag may have been unset or may be cleared.  However, given
>      where it's called, the pending flag is _always_ set.  I don't think it
>      can be unset whilst we're in set_wq_data().
> 
>      Once the work is enqueued to be actually run, the only way off the queue
>      is for it to be actually run.
> 
>      If it's a delayed work item, then the bit can't be cleared by the timer
>      because we haven't started the timer yet.  Also, the pending bit can't be
>      cleared by cancelling the delayed work _until_ the work item has had its
>      timer started.
> 
>  (2) The workqueue pointer might change.  This can only happen in two cases:
> 
>      (a) The work item has just been queued to actually run, and so we're
>          protected by the appropriate workqueue spinlock.
> 
>      (b) A delayed work item is being queued, and so the timer hasn't been
>      	 started yet, and so no one else knows about the work item or can
>      	 access it (the pending bit protects us).
> 
>      Besides, set_wq_data() _sets_ the workqueue pointer unconditionally, so
>      it can be assigned instead.
> 
> So, replacing the set_wq_data() with a straight assignment would be okay in
> most cases.  The problem is where we end up tangling with test_and_set_bit()
> emulated using spinlocks, and even then it's not a problem _provided_
> test_and_set_bit() doesn't attempt to modify the word if the bit was set.
> 
> If that's a problem, then a bitops-proofed assignment will be required -
> equivalent to atomic_set() vs other atomic_xxx() ops.
> 

I don't understand, as usual.

afacit in all (but one) cases we do

	if (!test_and_set_bit(WORK_STRUCT_PENDING, &work->management)) {
		...
		set_wq_data(work, wq);
		...
		<now do stuff which makes it possible for run_workqueue()
		 to get a look at the new work>
	}

cancel_delayed_work() looks OK too.

The possible exception is schedule_on_each_cpu() which is being lazy, but
looks fixable.


So...  afaict in all the places where there can be a concurrent
set_wq_data() and test_and_set_bit(), WORK_STRUCT_PENDING is reliably set,
and we can assume (and ensure) that a failing test_and_set_bit() will not
write to the affected word at all.

What am I missing?

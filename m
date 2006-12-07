Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032058AbWLGL3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032058AbWLGL3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032059AbWLGL3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:29:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45963 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032058AbWLGL3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:29:32 -0500
Date: Thu, 7 Dec 2006 03:28:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: David Miller <davem@davemloft.net>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: cmpxchg() in kernel/workqueue.c breaks things
Message-Id: <20061207032817.e9e587bd.akpm@osdl.org>
In-Reply-To: <10380.1165489429@redhat.com>
References: <20061207.000950.28414823.davem@davemloft.net>
	<10380.1165489429@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 11:03:49 +0000
David Howells <dhowells@redhat.com> wrote:

> David Miller <davem@davemloft.net> wrote:
> 
> > David, you have to fix the locking scheme used in kernel/workqueue.c,
> > you absolutely cannot assume that cmpxchg() is available on all
> > platforms.  This breaks the build on the platforms that don't
> > have such an instruction, and no it cannot emulated.
> 
> Yeah, I've figured that one out.  Also, having considered things last night, I
> think the use of cmpxchg() is unnecessary.
> 
> I was trying to handle against two possibilities:
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
> So, I think replacing the set_wq_data() with a straight assignment would be
> okay in most cases.  The problem is where we end up tangling with
> test_and_set_bit() emulated using spinlocks, and even then it's not a problem
> _provided_ test_and_set_bit() doesn't attempt to modify the word if the bit
> was set.
> 

I don't see why the 2.6.19 logic needed changing.

a) Nobody should be freeing the work_struct itself without running
   flush_scheduled_work() and

b) even if the work_struct _did_ get freed, the callback function won't
   care, because there's nothing in that work_struct which it's interested
   in.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032028AbWLGLEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032028AbWLGLEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032029AbWLGLEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:04:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55256 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032028AbWLGLEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:04:43 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061207.000950.28414823.davem@davemloft.net> 
References: <20061207.000950.28414823.davem@davemloft.net> 
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: cmpxchg() in kernel/workqueue.c breaks things 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Dec 2006 11:03:49 +0000
Message-ID: <10380.1165489429@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:

> David, you have to fix the locking scheme used in kernel/workqueue.c,
> you absolutely cannot assume that cmpxchg() is available on all
> platforms.  This breaks the build on the platforms that don't
> have such an instruction, and no it cannot emulated.

Yeah, I've figured that one out.  Also, having considered things last night, I
think the use of cmpxchg() is unnecessary.

I was trying to handle against two possibilities:

 (1) The pending flag may have been unset or may be cleared.  However, given
     where it's called, the pending flag is _always_ set.  I don't think it
     can be unset whilst we're in set_wq_data().

     Once the work is enqueued to be actually run, the only way off the queue
     is for it to be actually run.

     If it's a delayed work item, then the bit can't be cleared by the timer
     because we haven't started the timer yet.  Also, the pending bit can't be
     cleared by cancelling the delayed work _until_ the work item has had its
     timer started.

 (2) The workqueue pointer might change.  This can only happen in two cases:

     (a) The work item has just been queued to actually run, and so we're
         protected by the appropriate workqueue spinlock.

     (b) A delayed work item is being queued, and so the timer hasn't been
     	 started yet, and so no one else knows about the work item or can
     	 access it (the pending bit protects us).

     Besides, set_wq_data() _sets_ the workqueue pointer unconditionally, so
     it can be assigned instead.

So, I think replacing the set_wq_data() with a straight assignment would be
okay in most cases.  The problem is where we end up tangling with
test_and_set_bit() emulated using spinlocks, and even then it's not a problem
_provided_ test_and_set_bit() doesn't attempt to modify the word if the bit
was set.

David

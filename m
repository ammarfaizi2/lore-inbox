Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbUA0Tqk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUA0Tqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:46:40 -0500
Received: from mail.ccur.com ([208.248.32.212]:45585 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265755AbUA0Tnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:43:51 -0500
Date: Tue, 27 Jan 2004 14:43:43 -0500
From: Joe Korty <joe.korty@ccur.com>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] volatile may be needed in rwsem
Message-ID: <20040127194343.GA12763@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040127191155.GA12128@tsunami.ccur.com> <23376.1075231180@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23376.1075231180@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 07:19:40PM +0000, David Howells wrote:
>> 'flags' should be declared volatile as rwsem_down_failed_common() spins
>> waiting for this to change.  Untested.
> 
> Is it though? Does this fix an error?
> 
> The thing is, we make a function call inside of the loop:
> 
> 	/* wait to be given the lock */
> 	for (;;) {
> 		if (!waiter->flags)
> 			break;
> 		schedule();
> 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> 	}
> 
> Which might preclude that need. I'm not entirely sure, though... it's one of
> those compiler black magic things.
> 
> I suppose it can't hurt...
> 
> David

Hi David,
I misspoke.  The potentially failing spin is in __down_write and
__down_read in lib/rwsem-spinlock.c, not in rwsem_down_failed_common.

The problem is is that 'flags' is on the callee's stack and is thus
subject to be optimized out of the loop if the compiler is smart enough
to discover that it is on the stack.  Apparently gcc is not yet smart
enough but that doesn't mean it won't be so soon.

Joe

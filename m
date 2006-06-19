Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWFSIdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWFSIdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWFSIdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:33:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932325AbWFSIdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:33:09 -0400
Date: Mon, 19 Jun 2006 01:32:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts from 1 sec to
 1 min
Message-Id: <20060619013238.6d19570f.akpm@osdl.org>
In-Reply-To: <20060619081252.GA13176@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com>
	<20060617100710.ec05131f.akpm@osdl.org>
	<20060619070229.GA8293@elte.hu>
	<20060619005955.b05840e8.akpm@osdl.org>
	<20060619081252.GA13176@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 10:12:52 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Mon, 19 Jun 2006 09:02:29 +0200
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > Subject: increase spinlock-debug looping timeouts from 1 sec to 1 
> > > min
> > 
> > But it's broken.  In the non-debug case we subtract RW_LOCK_BIAS so we 
> > know that the writer will get the lock when all readers vacate.  But 
> > in the CONFIG_DEBUG_SPINLOCK case we don't do that, with the result 
> > that taking a write_lock can take over a second.
> > 
> > A much, much better fix (which involves visiting all architectures) 
> > would be to subtract RW_LOCK_BIAS and _then_ wait for a second.
> 
> no. Write-locks are unfair too, and there's no guarantee that writes are 
> listened to. That's why nested read_lock() is valid, while nested 
> down_read() is invalid.
> 
> Take a look at arch/i386/kernel/semaphore.c, __write_lock_failed() just 
> adds back the RW_LOCK_BIAS and retries in a loop. There's no difference 
> to an open-coded write_trylock loop - unless i'm missing something 
> fundamental.

OK.  That sucks.  A sufficiently large machine with the right mix of
latencies will get hit by the NMI watchdog in write_lock_irq().

But presumably the situation is much worse with CONFIG_DEBUG_SPINLOCK
because of that __delay().

So how about we remove the __delay() (which is wrong anyway, because
loops_per_jiffy isn't calculated with a write_trylock() in the loop (which
means we're getting scarily close to the NMI watchdog at present)).

Instead, calculate a custom loops_per_jiffy for this purpose in
lib/spinlock_debug.c?

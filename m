Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWFSIRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWFSIRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWFSIRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:17:52 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47775 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932301AbWFSIRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:17:51 -0400
Date: Mon, 19 Jun 2006 10:12:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts from 1 sec to 1 min
Message-ID: <20060619081252.GA13176@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com> <20060617100710.ec05131f.akpm@osdl.org> <20060619070229.GA8293@elte.hu> <20060619005955.b05840e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619005955.b05840e8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=AWL,BAYES_60,UPPERCASE_25_50 autolearn=no SpamAssassin version=3.0.3
	1.0 BAYES_60               BODY: Bayesian spam probability is 60 to 80%
	[score: 0.6047]
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
	-0.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 19 Jun 2006 09:02:29 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > Subject: increase spinlock-debug looping timeouts from 1 sec to 1 
> > min
> 
> But it's broken.  In the non-debug case we subtract RW_LOCK_BIAS so we 
> know that the writer will get the lock when all readers vacate.  But 
> in the CONFIG_DEBUG_SPINLOCK case we don't do that, with the result 
> that taking a write_lock can take over a second.
> 
> A much, much better fix (which involves visiting all architectures) 
> would be to subtract RW_LOCK_BIAS and _then_ wait for a second.

no. Write-locks are unfair too, and there's no guarantee that writes are 
listened to. That's why nested read_lock() is valid, while nested 
down_read() is invalid.

Take a look at arch/i386/kernel/semaphore.c, __write_lock_failed() just 
adds back the RW_LOCK_BIAS and retries in a loop. There's no difference 
to an open-coded write_trylock loop - unless i'm missing something 
fundamental.

> OK, it's only debug code.  But RH (for one) have decided to ship 
> zillions of kernels with this debug code turned on.

yes - Fedora enables most of the transparent kernel debugging options 
(slab, lock debugging) in rawhide. The current list is:

 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_SLAB_LEAK=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_DEBUG_HIGHMEM=y
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_RODATA=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y

	Ingo

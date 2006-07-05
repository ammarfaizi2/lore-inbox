Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWGEUOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWGEUOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWGEUOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:14:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62339 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965015AbWGEUOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:14:54 -0400
Date: Wed, 5 Jul 2006 13:18:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-Id: <20060705131824.52fa20ec.akpm@osdl.org>
In-Reply-To: <20060705193551.GA13070@elte.hu>
References: <20060705084914.GA8798@elte.hu>
	<20060705023120.2b70add6.akpm@osdl.org>
	<20060705093259.GA11237@elte.hu>
	<20060705025349.eb88b237.akpm@osdl.org>
	<20060705102633.GA17975@elte.hu>
	<20060705113054.GA30919@elte.hu>
	<20060705114630.GA3134@elte.hu>
	<20060705101059.66a762bf.akpm@osdl.org>
	<20060705193551.GA13070@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> > > i also tried a config with the best size settings (disabling 
> > > FRAME_POINTER, enabling CC_OPTIMIZE_FOR_SIZE), and this gives:
> > > 
> > >   text            data    bss     dec         filename
> > >   20777768        6076042 3081864 29935674    vmlinux.x32.size.before
> > >   20748140        6076178 3081864 29906182    vmlinux.x32.size.after
> > > 
> > > or a 34.8 bytes win per callsite (29K total).
> > > 
> > 
> > With gcc-4.1.0 on i686, uninlining those three functions as per the 
> > below patch _increases_ the allnoconfig vmlinux's .text from 833456 
> > bytes to 833728.
> 
> that's just the effect of CONFIG_REGPARM and CONFIG_CC_OPTIMIZE_FOR_SIZE 
> not being set in an allnoconfig. Once i set them the text size evens 
> out:
> 
>  431348   60666   27276  519290   7ec7a vmlinux.x32.mini.before
>  431359   60666   27276  519301   7ec85 vmlinux.x32.mini.after
> 
> compiling without CONFIG_REGPARM on i686 (if you care about text size) 
> makes little sense. It penalizes function calls artificially.

OK, but what happened to the 35-bytes-per-callsite saving?

Sorry to keep going on about this, but your numbers seem just too big to
me, and the above confirms that, and I don't know what's happening.

It doesn't seem right that uninlining something like this:

static inline void init_waitqueue_func_entry(wait_queue_t *q,
					wait_queue_func_t func)
{
	q->flags = 0;
	q->private = NULL;
	q->func = func;
}

is going to gain us much code size benefit at all.  Let alone
runtime/codegen benefit.

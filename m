Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWGEKbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWGEKbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 06:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWGEKbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 06:31:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7837 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964790AbWGEKbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 06:31:11 -0400
Date: Wed, 5 Jul 2006 12:26:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705102633.GA17975@elte.hu>
References: <20060705084914.GA8798@elte.hu> <20060705023120.2b70add6.akpm@osdl.org> <20060705093259.GA11237@elte.hu> <20060705025349.eb88b237.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705025349.eb88b237.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > shrinks fs/select.o by eight bytes.  (More than I expected).  So 
> > > it does appear to be a space win, but a pretty slim one.
> > 
> > there are 855 calls to these functions in the allyesconfig vmlinux i 
> > did, and i measured a combined size reduction of 34791 bytes. That 
> > averages to a 40 bytes win per call site. (on i386.)
> > 
> 
> Yes, but that lumps all three together.  init_waitqueue_head() is 
> obviously the porky one.  And it's porkier with CONFIG_DEBUG_SPINLOCK 
> and CONFIG_LOCKDEP, which isn't the case to optimise for.

true. I redid my tests with both lockdep and debug-spinlocks turned off:

  text            data    bss     dec             filename
  21172153        6077270 3081864 30331287        vmlinux.x32.after
  21198222        6077106 3081864 30357192        vmlinux.x32.before

with 851 callsites that's a 30.6 bytes win per call site (total 26K) - 
still not bad at all.

it's a win even on 64-bit:

  text            data    bss     dec             filename
  21237025        6997266 3327600 31561891        vmlinux.x64.after
  21252773        6997090 3327600 31577463        vmlinux.x64.before

with 755 callsites that's still a 20.8 bytes win per call site (total 
15K).

> With the debug options turned off, even init_waitqueue_head() becomes 
> just three assignments, similar to init_waitqueue_entry() and 
> init_waitqueue_func_entry().  All pretty marginal.

but three assignments could mean 3 offsets embedded in the instructions. 
(for init_waitqueue_entry we also embedd the address of 
default_wake_function) Even 3 assignments can add up to a footprint that 
is far from marginal.

The rough rule of thumb for inlining is that anything that is larger 
than one C statement is probably too large for inlining. (but even 
1-line statements might be too fat at times)

	Ingo

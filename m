Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269744AbUIRXrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269744AbUIRXrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269692AbUIRXrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:47:41 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:23789 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269758AbUIRXnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:43:12 -0400
Date: Sun, 19 Sep 2004 01:36:19 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040918233619.GF15426@dualathlon.random>
References: <20040915151815.GA30138@elte.hu> <20040917103945.GA19861@elte.hu> <20040917125334.GA4954@elte.hu> <20040917205639.GB15426@dualathlon.random> <20040918080214.GC31899@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040918080214.GC31899@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 10:02:14AM +0200, Ingo Molnar wrote:
> what do you mean? If something does lock_kernel() within spin_lock()
> then the might_sleep() check in down() catches it and will print a
> warning. [..]

I didn't see any patch that removed the CONFIG_DEBUG_SPINLOCK_SLEEP
config option and avoided might_sleep to be defined to noop. If we apply
your patch that's something we need IMHO, and that's what I meant with
"it still doesn't track the lock_kernel usage inside a spinlock", I
didn't specify "_always_ track the lock_kernel usage inside a spinlock",
but I thought the "always" was implicitly, clearly it was not, sorry for
not clarifying this.

> [..] In any case it's very likely a _bug_ so we want to know!)

wanting to know is fine with me, what's not fine with me is deadlocking
a production box after that, when it could be a legitimate usage. It's
not about the printk, it's about the following crash. As said this thing
spreads all over the place, especially in possibly bogus drivers out of
the tree, and I don't think it provides any significant benefit (Ok I'm
biased since I tend to think about PREEMPT=n where a semaphore won't
provide any benefit, and if there's any latency issue with the BKL that
can be fixed without risks with cond_resched_bkl as pointed out
earlier and it definitely doesn't need this patch). And as Linus
mentioned the risk of overscheduling is also possible with the semaphore
but that's the minor issue in this IMHO.

So in short if you change your patch to only add checks that leads into
printk that's very much fine with me (basically you would have to change
lock_kernel() to add an unconditional might_sleep in there, and the
other stuff for the smp_processor_id). I'm not against wanting to know.

Overall I still don't see any benefit. The thing to fix is the
lock_kernel global lock concept that doesn't scale and doesn't
self-document what is being locked against what. IMHO changing the
lock_kernel internal details in a way that changes the semantics in a
subtle manner cannot bring any long term benefit and it can only hurt
the short term due the potentail breakage it introduces.

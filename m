Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWFSI0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWFSI0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWFSI0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:26:50 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51927 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932322AbWFSI0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:26:49 -0400
Date: Mon, 19 Jun 2006 10:21:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts from 1 sec to 1 min
Message-ID: <20060619082150.GA13905@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com> <20060617100710.ec05131f.akpm@osdl.org> <20060619070229.GA8293@elte.hu> <20060619005955.b05840e8.akpm@osdl.org> <20060619081252.GA13176@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619081252.GA13176@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=AWL,BAYES_80 autolearn=no SpamAssassin version=3.0.3
	2.0 BAYES_80               BODY: Bayesian spam probability is 80 to 95%
	[score: 0.8448]
	-1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> no. Write-locks are unfair too, and there's no guarantee that writes 
> are listened to. That's why nested read_lock() is valid, while nested 
> down_read() is invalid.
> 
> Take a look at arch/i386/kernel/semaphore.c, __write_lock_failed() 
> just adds back the RW_LOCK_BIAS and retries in a loop. There's no 
> difference to an open-coded write_trylock loop - unless i'm missing 
> something fundamental.

did i ever mention that i find rwlocks evil, inefficient and bug-prone, 
and that we should get rid of them? :-)

(Most rwlock users can be converted to straight spinlocks just fine, but 
there are a couple of places that rely on read-lock nesting. The 
hardest-to-fix offenders are nested rcu_read_locks() in the netfilter 
code. I gave up converting them to saner locking, PREEMPT_RCU works it 
around in the -rt tree, by not being rwlock based.)

	Ingo

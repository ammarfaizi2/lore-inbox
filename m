Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWFSIkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWFSIkT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWFSIkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:40:18 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:39857 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751216AbWFSIkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:40:17 -0400
Date: Mon, 19 Jun 2006 10:35:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts from 1 sec to 1 min
Message-ID: <20060619083518.GA14265@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com> <20060617100710.ec05131f.akpm@osdl.org> <20060619070229.GA8293@elte.hu> <20060619005955.b05840e8.akpm@osdl.org> <20060619081252.GA13176@elte.hu> <20060619013238.6d19570f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619013238.6d19570f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=AWL,BAYES_60 autolearn=no SpamAssassin version=3.0.3
	1.0 BAYES_60               BODY: Bayesian spam probability is 60 to 80%
	[score: 0.7425]
	-0.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> OK.  That sucks.  A sufficiently large machine with the right mix of 
> latencies will get hit by the NMI watchdog in write_lock_irq().
> 
> But presumably the situation is much worse with CONFIG_DEBUG_SPINLOCK 
> because of that __delay().
> 
> So how about we remove the __delay() (which is wrong anyway, because 
> loops_per_jiffy isn't calculated with a write_trylock() in the loop 
> (which means we're getting scarily close to the NMI watchdog at 
> present)).
> 
> Instead, calculate a custom loops_per_jiffy for this purpose in 
> lib/spinlock_debug.c?

hm, that would be yet another calibration loop with the potential to be 
wrong (and which would slow down the bootup process). If loops_per_jiffy 
is wrong then our timings are toast anyway.

I think increasing the timeout to 60 secs ought to be enough - 1 sec was 
a bit too close to valid delays and i can imagine really high loads 
causing 1 sec delays (especially if something like SysRq-T is holding 
the tasklist_lock for long).

The write_trylock + __delay in the loop is not a problem or a bug, as 
the trylock will at most _increase_ the delay - and our goal is to not 
have a false positive, not to be absolutely accurate about the 
measurement here.

	Ingo

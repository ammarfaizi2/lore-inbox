Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWI3NSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWI3NSU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 09:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWI3NSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 09:18:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:23747 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750934AbWI3NST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 09:18:19 -0400
Date: Sat, 30 Sep 2006 15:09:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 08/23] dynticks: prepare the RCU code
Message-ID: <20060930130958.GA12021@elte.hu>
References: <20060929234435.330586000@cruncher.tec.linutronix.de> <20060929234439.721237000@cruncher.tec.linutronix.de> <20060930013641.263a1cc3.akpm@osdl.org> <20060930122514.GC8763@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930122514.GC8763@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dipankar Sarma <dipankar@in.ibm.com> wrote:

> It is duplicating code. That can be easily fixed, but we need to 
> figure out what we really want from RCU when we are about to switch 
> off the ticks. It is hard if you want to finish off all the pending 
> RCUs and go to nohz state. Can you live with backing out if there are 
> pending RCUs ?

the thing is that when we go idle we /want/ to process whatever delayed 
work there might be - rate limited or not. Do you agree with that 
approach? I consider this a performance feature as well: this way we can 
utilize otherwise lost idle time. It is not a problem that we dont 
'batch' this processing: we are really idle and we've got free cycles to 
burn. We could even do an RCU processing loop that immediately breaks 
out if need_resched() gets set [by an IRQ or by another CPU].

secondly, i think i saw functionality problems when RCU was not 
completed before going idle - for example synchronize_rcu() on another 
CPU would hang.

what approach would you suggest to achieve these goals?

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758398AbWK3G6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758398AbWK3G6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 01:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758399AbWK3G6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 01:58:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33460 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1758394AbWK3G6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 01:58:40 -0500
Date: Thu, 30 Nov 2006 07:56:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Miller <davem@davemloft.net>
Cc: wenji@fnal.gov, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061130065627.GE2003@elte.hu>
References: <2f14bf623344.456de60a@fnal.gov> <20061129.181950.31643130.davem@davemloft.net> <20061130061758.GA2003@elte.hu> <20061129.223055.05159325.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129.223055.05159325.davem@davemloft.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Miller <davem@davemloft.net> wrote:

> This is why my suggestion is to preempt_disable() as soon as we grab 
> the socket lock, [...]

independently of the issue at hand, in general the explicit use of 
preempt_disable() in non-infrastructure code is quite a heavy tool. Its 
effects are heavy and global: it disables /all/ preemption (even on 
PREEMPT_RT). Furthermore, when preempt_disable() is used for per-CPU 
data structures then [unlike for example to a spin-lock] the connection 
between the 'data' and the 'lock' is not explicit - causing all kinds of 
grief when trying to convert such code to a different preemption model. 
(such as PREEMPT_RT :-)

So my plan is to remove all "open-coded" use of preempt_disable() [and 
raw use of local_irq_save/restore] from the kernel and replace it with 
some facility that connects data and lock. (Note that this will not 
result in any actual changes on the instruction level because internally 
every such facility still maps to preempt_disable() on non-PREEMPT_RT 
kernels, so on non-PREEMPT_RT kernels such code will still be the same 
as before.)

	Ingo

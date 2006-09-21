Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWIUNHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWIUNHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 09:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWIUNHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 09:07:46 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42674 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751190AbWIUNHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 09:07:45 -0400
Date: Thu, 21 Sep 2006 14:56:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <nielsen.esben@gogglemail.com>
Cc: Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921125611.GA1742@elte.hu>
References: <20060921065624.GA9841@gnuppy.monkey.org> <20060921065402.GA22089@elte.hu> <20060921071838.GA10337@gnuppy.monkey.org> <20060921071624.GA25281@elte.hu> <20060921073222.GC10337@gnuppy.monkey.org> <20060921072908.GA27280@elte.hu> <20060921074805.GA11644@gnuppy.monkey.org> <20060921075633.GA30343@elte.hu> <20060921081333.GC11644@gnuppy.monkey.org> <Pine.LNX.4.64.0609211417470.8638@frodo.shire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609211417470.8638@frodo.shire>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <nielsen.esben@gogglemail.com> wrote:

> The whole point is to defer those frees to a task. In -rt call_rcu() 
> is abused to do that in the case of put_task_struct(). But it is abuse 
> since call_rcu() is much more resourcefull than simply defering to a 
> task.

nah, it's not nearly as "resourceful" as having a separate thread for 
each teardown type ... It is also the easiest to maintain way of tearing 
down stuff, so i'm quite happy with it. If then i'll move the mm_struct 
teardown to RCU too. (Later on we can do some 'fastpath RCU' thing 
perhaps, to force an RCU batch of work through quiescent state)

but this is quite likely a side-issue that probably has no connection to 
the crash Bill was seeing. Whether separate teardown thread or 
softirq-rcu, it's a separate thread already.

	Ingo

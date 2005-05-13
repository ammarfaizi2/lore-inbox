Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVEMIFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVEMIFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVEMIFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:05:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61154 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262293AbVEMIEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:04:45 -0400
Date: Fri, 13 May 2005 10:04:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: vatsa@in.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       george@mvista.com, jdike@addtoit.com,
       Jesse Barnes <jesse.barnes@intel.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050513080424.GA31206@elte.hu>
References: <20050512171251.GA21656@in.ibm.com> <OF86BA5D99.FE159896-ONC1256FFF.0062E865-C1256FFF.0063A681@de.ibm.com> <20050513062330.GD23705@in.ibm.com> <42845456.3080908@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42845456.3080908@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > From all the discussions we have been having, I think a watchdog
> > implementation makes more sense. Nick/Ingo, what do you think
> > should be our final decision on this?
> 
> Well the complex solution won't go in until it is shown that the
> simple version has fundamental failure cases - but I don't think we
> need to make a final decision yet do we?

there's no need to make a final decision yet. But the more complex 
watchdog solution does have the advantage of putting idle CPUs to sleep 
immediately and perpetually.

the power equation is really easy: the implicit cost of a deep CPU sleep 
is say 1-2 msecs. (that's how long it takes to shut the CPU and the bus 
down, etc.) If we do an exponential backoff we periodically re-wake the 
CPU fully up again - wasting 1-2msec (or more) more power. With the 
watchdog solution we have more overhead on the busy CPU but it takes 
_much_ less power for a truly idle CPU to be turned off. [the true 
'effective cost' all depends on the scheduling pattern as well, but the 
calculation before is still valid.] Whatever the algorithmic overhead of 
the watchdog code, it's dwarved by the power overhead caused by false 
idle-wakeups of CPUs under exponential backoff.

the watchdog solution - despite being more complex - is also more 
orthogonal in that it does not change the balancing decisions at all - 
they just get offloaded to another CPU. The exponential backoff OTOH 
materially changes how we do SMP balancing - which might or might not 
matter much, but it will always depend on circumstances. So in the long 
run the watchdog solution is probably easier to control. (because it's 
just an algorithm offload, not a material scheduling feature.)

so unless there are strong implementational arguments against the 
watchdog solution, i definitely think it's the higher quality solution, 
both in terms of power savings, and in terms of impact.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVDGPLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVDGPLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVDGPLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:11:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2270 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262485AbVDGPLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:11:11 -0400
Date: Thu, 7 Apr 2005 17:10:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: george@mvista.com, nickpiggin@yahoo.com.au,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: VST and Sched Load Balance
Message-ID: <20050407151024.GA6565@elte.hu>
References: <20050407124629.GA17268@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407124629.GA17268@in.ibm.com>
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


* Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> Hi,
> 	VST patch (http://lwn.net/Articles/118693/) attempts to avoid useless 
> regular (local) timer ticks when a CPU is idle.
> 
> I think a potential area which VST may need to address is scheduler 
> load balance. If idle CPUs stop taking local timer ticks for some 
> time, then during that period it could cause the various runqueues to 
> go out of balance, since the idle CPUs will no longer pull tasks from 
> non-idle CPUs.
> 
> Do we care about this imbalance? Especially considering that most 
> implementations will let the idle CPUs sleep only for some max 
> duration (~900 ms in case of x86).

yeah, we care about this imbalance, it would materially change the 
scheduling logic, which side-effect we dont want. Interaction with VST 
is not a big issue right now because this only matters on SMP boxes 
which is a rare (but not unprecedented) target for embedded platforms.  

One solution would be to add an exponential backoff would be ok (as Nick 
suggested too), not an unconditional 'we wont fire a timer interrupt for 
the next 10 seconds' logic. It still impacts scheduling though.

Another, more effective, less intrusive but also more complex approach 
would be to make a distinction between 'totally idle' and 'partially 
idle or busy' system states. When all CPUs are idle then all timer irqs 
may be stopped and full VST logic applies. When at least one CPU is 
busy, all the other CPUs may still be put to sleep completely and 
immediately, but the busy CPU(s) have to take over a 'watchdog' role, 
and need to run the 'do the idle CPUs need new tasks' balancing 
functions. I.e. the scheduling function of other CPUs is migrated to 
busy CPUs. If there are no busy CPUs then there's no work, so this ought 
to be simple on the VST side. This needs some reorganization on the 
scheduler side but ought to be doable as well.

	Ingo

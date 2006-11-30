Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758258AbWK3GuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758258AbWK3GuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 01:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758255AbWK3GuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 01:50:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49821 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1758001AbWK3GuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 01:50:11 -0500
Date: Thu, 30 Nov 2006 07:47:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Miller <davem@davemloft.net>
Cc: wenji@fnal.gov, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061130064758.GD2003@elte.hu>
References: <2f14bf623344.456de60a@fnal.gov> <20061129.181950.31643130.davem@davemloft.net> <20061130061758.GA2003@elte.hu> <20061129.223055.05159325.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129.223055.05159325.davem@davemloft.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Miller <davem@davemloft.net> wrote:

> > yeah, i like this one. If the problem is "too long locked section", 
> > then the most natural solution is to "break up the lock", not to 
> > "boost the priority of the lock-holding task" (which is what the 
> > proposed patch does).
> 
> Ingo you're mis-read the problem :-)

yeah, the problem isnt too long locked section but "too much time spent 
holding a lock" and hence opening up ourselves to possible negative 
side-effects of the scheduler's fairness algorithm when it forces a 
preemption of that process context with that lock held (and forcing all 
subsequent packets to be backlogged).

but please read my last mail - i think i'm slowly starting to wake up 
;-) I dont think there is any real problem: a tweak to the scheduler 
that in essence gives TCP-using tasks a preference changes the balance 
of workloads. Such an explicit tweak is possible already.

furthermore, the tweak allows the shifting of processing from a 
prioritized process context into a highest-priority softirq context. 
(it's not proven that there is any significant /net win/ of performance: 
all that was proven is that if we shift TCP processing from process 
context into softirq context then TCP throughput of that otherwise 
penalized process context increases.)

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVLaBPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVLaBPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVLaBPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:15:44 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53694 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932073AbVLaBPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:15:34 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
	 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu>
	 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe>
	 <20051229202848.GC29546@elte.hu> <1135908980.4568.10.camel@mindpipe>
	 <20051230080032.GA26152@elte.hu> <1135990270.31111.46.camel@mindpipe>
	 <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 20:15:31 -0500
Message-Id: <1135991732.31111.57.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 17:02 -0800, Linus Torvalds wrote:
> 
> On Fri, 30 Dec 2005, Lee Revell wrote:
> > 
> > It seems that the networking code's use of RCU can cause 10ms+
> > latencies:
> 
> Hmm. Is there a big jump at the 10ms mark? Do you have a 100Hz timer 
> source? 
> 
> A latency jump at 10ms would tend to indicate a missed wakeup that 
> was "picked up" by the next timer tick.

No there are no large jumps, it really seems that this was the network
code causing an RCU callback to drop ~2K routes at once.  Specifically
RCU invokes dst_rcu_free 2085 times in a single batch
(call_rcu_bh(&rt->u.dst.rcu_head, dst_rcu_free) is only called from
rt_free() and rt_drop()).

I have found that many of the paths in the network stack that can cause
high latencies can be tuned via sysctls (for example
net.ipv4.route.gc_thresh); this one may be the same.

Lee


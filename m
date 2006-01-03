Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWACLLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWACLLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWACLLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:11:31 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43958 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751370AbWACLLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:11:30 -0500
Date: Tue, 3 Jan 2006 16:42:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, paulmck@us.ibm.com,
       Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>, vatsa@in.ibm.com
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20060103111211.GA5075@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1135990270.31111.46.camel@mindpipe> <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org> <1135991732.31111.57.camel@mindpipe> <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org> <1136001615.3050.5.camel@mindpipe> <20051231042902.GA3428@us.ibm.com> <1136004855.3050.8.camel@mindpipe> <20051231201426.GD5124@us.ibm.com> <1136094372.7005.19.camel@mindpipe> <Pine.LNX.4.64.0601011047320.3668@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601011047320.3668@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 10:56:25AM -0800, Linus Torvalds wrote:
> 
> > Linus, would you accept CONFIG_PREEMPT_SOFTIRQS to always run softirqs
> > in threads (default N of course, it certainly has a slight throughput
> > cost) for mainline if Ingo were to submit it?
> 
> Actually, I think there's a better solution.
> 
> Try just setting maxbatch back to 10 in kernel/rcupdate.c.
> 
> The thing is, "maxbatch" doesn't actually _work_ because what happens is 
> that the tasklet will continually re-schedule itself, and the caller will 
> keep calling it. So maxbatch is actually broken.

Not really. maxbatch limits the number of RCU callbacks in a
batch inside RCU subsystem, it doesn't assure that total number
of RCU callbacks invoked in that instance of softirq would
be maxbatch. The idea was to give the control back to softirq
subsystem after maxbatch RCUs are processed and let the softirq
latency logic take over.

> However, what happens is that after kernel/softirq.c has called the 
> tasklet ten times, and it is still pending, it will do the softirq in a 
> thread (see the "max_restart" logic).
> 
> Which happens to do the right thing, although I'm pretty convinced that it 
> was by mistake (or if on purpose, it depends way too closely on silly 
> magic implementation issues).

It was intentional. I wanted to keep the RCU throttling separate
and let softirq handling do its own thing. Softirqs, once delegated
to ksoftirqd were managable from the latency perspective, but
not a very long RCU batch.

I do agree that the two layers of batching really makes things
subtle. I think the best we can do is to figure out some way of
automatic throttling in RCU and forced quiescent state under extreme
conditions. That way we will have less dependency on softirq
throttling.

Thanks
Dipankar

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTANPEQ>; Tue, 14 Jan 2003 10:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbTANPEQ>; Tue, 14 Jan 2003 10:04:16 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:31626 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S263039AbTANPEP> convert rfc822-to-8bit; Tue, 14 Jan 2003 10:04:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Andrew Theurer" <habanero@us.ibm.com>,
       "Michael Hohnbaum" <michael@hbaum.com>
Subject: Re: [Lse-tech] Re: NUMA scheduler 2nd approach
Date: Tue, 14 Jan 2003 16:13:27 +0100
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, "Robert Love" <rml@tech9.net>,
       "Ingo Molnar" <mingo@elte.hu>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "lse-tech" <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <1042523478.30434.164.camel@kenai> <001a01c2bbed$600f64a0$29060e09@andrewhcsltgw8>
In-Reply-To: <001a01c2bbed$600f64a0$29060e09@andrewhcsltgw8>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301141613.27521.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 January 2003 17:52, Andrew Theurer wrote:
> > I suppose I should not have been so dang lazy and cut-n-pasted
> > the line I changed.  The change was (((5*4*this_load)/4) + 4)
> > which should be the same as your second choice.
> >
> > > We def need some constant to avoid low load ping pong, right?
> >
> > Yep.  Without the constant, one could have 6 processes on node
> > A and 4 on node B, and node B would end up stealing.  While making
> > a perfect balance, the expense of the off-node traffic does not
> > justify it.  At least on the NUMAQ box.  It might be justified
> > for a different NUMA architecture, which is why I propose putting
> > this check in a macro that can be defined in topology.h for each
> > architecture.
>
> Yes, I was also concerned about one task in one node and none in the
> others. Without some sort of constant we will ping pong the task on every
> node endlessly, since there is no % threshold that could make any
> difference when the original load value is 0..  Your +4 gets rid of the 1
> task case.

That won't happen because:
 - find_busiest_queue() won't detect a sufficient imbalance
 (imbalance == 0),
 - load_balance() won't be able to steal the task, as it will be
 running (the rq->curr task)

So the worst thing that happens is that load_balance() finds out that
it cannot steal the only task running on the runqueue and
returns. But we won't get there because find_busiest_queue() returns
NULL. It happens even in the bad case:
   node#0 : 0 tasks
   node#1 : 4 tasks (each on its own CPU)
where we would desire to distribute the tasks equally among the
nodes. At least on our IA64 platform...

Regards,
Erich




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbUDAGoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 01:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUDAGoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 01:44:02 -0500
Received: from [194.67.69.111] ([194.67.69.111]:37771 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S262742AbUDAGn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 01:43:59 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200404010643.KAA08190@yakov.inr.ac.ru>
Subject: Re: route cache DoS testing and softirqs
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 1 Apr 2004 10:43:45 +0400 (MSD)
Cc: Robert.Olsson@data.slu.se (Robert Olsson),
       dipankar@in.ibm.com (Dipankar Sarma),
       davem@redhat.com (David S. Miller), kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       akpm@osdl.org
In-Reply-To: <20040331225259.GT2143@dualathlon.random> from "Andrea Arcangeli" at Apr 01, 2004 12:52:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I didn't focus much on the irq count, but now that I look at it, it
> looks like the biggest source of softirq in irq context is the timer
> irq, not the network irq. That explains the problem and why NAPI
> couldn't avoid the softirq load in irq context, NAPI avoids the network
> irqs, but the softirqs keeps running in irq context.
> 
> So lowering HZ to 100 should mitigate the problem significantly.

Plus local_bh_enable(), which was actually the first source discovered
by Robert year ago. It does not contribute now, but Robert could turn it on
starting some non-trivial process context workload.

We have lots of places where we do local_bh_disable/enable() several times
in row and each of them triggers full do_softirq() run without schedule()
in between. See?

The thing which I want to say is: source of do_softirq() does not matter.
All of them happening outside of ksoftirqd are equally bad, unaccountable,
uncontrollable and will show up in some situation.

What's about some accounting do_softirq() in some way as a starting point?
F.e. one way is to account all timer ticks happened while do_softirq()
to ksoftirqd instead of current process (I am not sure that this is even
possible without race conditions). Or something like that.

Alexey

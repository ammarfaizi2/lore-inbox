Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVBPSCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVBPSCY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 13:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVBPSCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 13:02:23 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:2990 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262016AbVBPSCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 13:02:15 -0500
Date: Wed, 16 Feb 2005 13:02:04 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@kihontech.com
To: "David S. Miller" <davem@davemloft.net>
cc: Ingo Molnar <mingo@elte.hu>, mgross@linux.intel.com,
       linux-kernel@vger.kernel.org, Mark_H_Johnson@raytheon.com
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
In-Reply-To: <20050216081143.50d0a9d6.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0502161242180.14526@localhost.localdomain>
References: <200502141240.14355.mgross@linux.intel.com>
 <200502141429.11587.mgross@linux.intel.com> <20050215104153.GB19866@elte.hu>
 <200502151006.44809.mgross@linux.intel.com> <20050216051645.GB15197@elte.hu>
 <20050216081143.50d0a9d6.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005, David S. Miller wrote:
> On Wed, 16 Feb 2005 06:16:45 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> > Maybe the networking
> > stack would break if we allowed the TIMER softirq (thread) to preempt
> > the NET softirq (threads) (and vice versa)?
> The major assumption is that softirq's run indivisibly per-cpu.
> Otherwise the per-cpu queues of RX and TX packet work would
> get corrupted.
>
> See net/core/dev.c:softnet_data
>

How about a design to put softirq's into domains. That way you can group
together the threads that should not preempt each other (ie TX and RX) but
still allow prioritizing of different softirq threads. That way you don't
have one softirq thread preempting another thread on the same cpu that are
in the same group. I'm sure that the TX and RX is more of the exception
than the rule.

I guess you can have one implementation of this by having one thread per
group.  Of course there would have to be an API developed to group
tasklets. Also it would be a little trickier to keep individual tasklets
within a group from running on two CPUs at once, and not sacrifice TX and
RX from running together on two different CPUS. But this is all feasible.

-- Steve


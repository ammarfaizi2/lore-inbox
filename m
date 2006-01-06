Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752543AbWAFUZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbWAFUZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbWAFUZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:25:58 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:14814 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752540AbWAFUZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:25:56 -0500
Date: Fri, 6 Jan 2006 12:26:26 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
Message-ID: <20060106202626.GA5677@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060105235845.967478000@sorel.sous-sol.org> <20060106004555.GD25207@sorel.sous-sol.org> <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org> <43BE43B6.3010105@cosmosbay.com> <1136554632.30498.7.camel@localhost.localdomain> <20060106164702.GA5087@us.ibm.com> <43BEA693.5010509@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43BEA693.5010509@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 06:19:15PM +0100, Eric Dumazet wrote:
> Paul E. McKenney a écrit :
> >On Fri, Jan 06, 2006 at 01:37:12PM +0000, Alan Cox wrote:
> >>On Gwe, 2006-01-06 at 11:17 +0100, Eric Dumazet wrote:
> >>>I assume that if a CPU queued 10.000 items in its RCU queue, then the 
> >>>oldest entry cannot still be in use by another CPU. This might sounds as 
> >>>a violation of RCU rules, (I'm not an RCU expert) but seems quite 
> >>>reasonable.
> >>Fixing the real problem in the routing code would be the real fix. 
> >>
> >>The underlying problem of RCU and memory usage could be solved more
> >>safely by making sure that the sleeping memory allocator path always
> >>waits until at least one RCU cleanup has occurred after it fails an
> >>allocation before it starts trying harder. That ought to also naturally
> >>throttle memory consumers more in the situation which is the right
> >>behaviour.
> >
> >A quick look at rt_garbage_collect() leads me to believe that although
> >the IP route cache does try to limit its use of memory, it does not
> >fully account for memory that it has released to RCU, but that RCU has
> >not yet freed due to a grace period not having elapsed.
> >
> >The following appears to be possible:
> >
> >1.	rt_garbage_collect() sees that there are too many entries,
> >	and sets "goal" to the number to free up, based on a
> >	computed "equilibrium" value.
> >
> >2.	The number of entries is (correctly) decremented only when
> >	the corresponding RCU callback is invoked, which actually
> >	frees the entry.
> >
> >3.	Between the time that rt_garbage_collect() is invoked the
> >	first time and when the RCU grace period ends, rt_garbage_collect()
> >	is invoked again.  It still sees too many entries (since
> >	RCU has not yet freed the ones released by the earlier
> >	invocation in step (1) above), so frees a bunch more.
> >
> >4.	Packets routed now miss the route cache, because the corresponding
> >	entries are waiting for a grace period, slowing the system down.
> >	Therefore, even more entries are freed to make room for new
> >	entries corresponding to the new packets.
> >
> >If my (likely quite naive) reading of the IP route cache code is correct,
> >it would be possible to end up in a steady state with most of the entries
> >always being in RCU rather than in the route cache.
> >
> >Eric, could this be what is happening to your system?
> >
> >If it is, one straightforward fix would be to keep a count of the number
> >of route-cache entries waiting on RCU, and for rt_garbage_collect()
> >to subtract this number of entries from its goal.  Does this make sense?
> >
> 
> Hi Paul
> 
> Thanks for reviewing route code :)
> 
> As I said, the problem comes from 'route flush cache', that is periodically 
> done by rt_run_flush(), triggered by rt_flush_timer.
> 
> The 10% of LOWMEM ram that was used by route-cache entries are pushed into 
> rcu queues (with call_rcu_bh()) and network continue to receive
> packets from *many* sources that want their route-cache entry.

Hello, Eric,

The rt_run_flush() function could indeed be suffering from the same
problem.  Dipankar's recent patch should help RCU grace periods proceed
more quickly, does that help?

If not, it may be worthwhile to limit the number of times that
rt_run_flush() runs per RCU grace period.

						Thanx, Paul

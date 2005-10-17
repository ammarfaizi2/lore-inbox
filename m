Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVJQTBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVJQTBA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVJQTBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:01:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32938 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932239AbVJQTBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:01:00 -0400
Date: Mon, 17 Oct 2005 12:00:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Eric Dumazet <dada1@cosmosbay.com>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <20051017183124.GF13665@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0510171147110.3369@g5.osdl.org>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
 <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com>
 <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com>
 <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com>
 <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com>
 <4353E6F1.8030206@cosmosbay.com> <20051017183124.GF13665@in.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-2034643218-1129575607=:3369"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-2034643218-1129575607=:3369
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 18 Oct 2005, Dipankar Sarma wrote:

> On Mon, Oct 17, 2005 at 08:01:21PM +0200, Eric Dumazet wrote:
> > Dipankar Sarma a écrit :
> > >On Mon, Oct 17, 2005 at 09:16:25AM -0700, Linus Torvalds wrote:
> > >
> > 
> > <lazy_mode=ON>
> > Do we really need a TIF_RCUUPDATE flag, or could we just ask for a resched ?
> > </lazy_mode>
> 
> I think the theory was that we have to process the callbacks,
> not just force the grace period by setting need_resched.
> That is what TIF_RCUUPDATE indicates - rcus to process.

I'm having second thoughts about that, since the problem (in SMP) is that 
even if the currently active process tries to more proactively handle RCU 
events rather than just setting the grace period, in order to do that 
you'd still need to wait for the other CPU's to have their quiescent 
phase.

So the RCU queues can grow long, if only because the other CPU's won't 
necessarily do the same.

So we probably cannot throttle RCU queues down, and they will inevitably 
have to be able to grow pretty long. 

> Hmm.. I am supprised that maxbatch=10 still allowed you keep up
> with a continuously queueing cpu. OK, I will look at this.

I think it's just because it ends up rescheduling a lot, and thus waking 
up softirqd.

The RCU thing is done as a tasklet, which means that
 - it starts out as a "synchronous" softirq event, at which point it gets 
   called at most X times (MAX_SOFTIRQ_RESTART, defaults to 10)
 - after that, we end up saying "uhhuh, this is using too much softirq 
   time" and instead just run the softirq as a kernel thread.
 - setting TIF_NEEDRESCHED whenever the rcu lists are long will keep on 
   rescheduling to the softirq thread much more aggressively.

See __do_softirq() for some of this softirq (and thus tasklet) handling.

I suspect it's _very_ inefficient, but maybe the bad case triggers so 
seldom that we don't really need to care. 

		Linus
--21872808-2034643218-1129575607=:3369--

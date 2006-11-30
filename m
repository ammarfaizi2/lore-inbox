Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757852AbWK3Ga5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757852AbWK3Ga5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 01:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757831AbWK3Ga5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 01:30:57 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:17340
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1757486AbWK3Ga4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 01:30:56 -0500
Date: Wed, 29 Nov 2006 22:30:55 -0800 (PST)
Message-Id: <20061129.223055.05159325.davem@davemloft.net>
To: mingo@elte.hu
Cc: wenji@fnal.gov, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061130061758.GA2003@elte.hu>
References: <2f14bf623344.456de60a@fnal.gov>
	<20061129.181950.31643130.davem@davemloft.net>
	<20061130061758.GA2003@elte.hu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 30 Nov 2006 07:17:58 +0100

> 
> * David Miller <davem@davemloft.net> wrote:
> 
> > We can make explicitl preemption checks in the main loop of 
> > tcp_recvmsg(), and release the socket and run the backlog if 
> > need_resched() is TRUE.
> > 
> > This is the simplest and most elegant solution to this problem.
> 
> yeah, i like this one. If the problem is "too long locked section", then
> the most natural solution is to "break up the lock", not to "boost the 
> priority of the lock-holding task" (which is what the proposed patch 
> does).

Ingo you're mis-read the problem :-)

The issue is that we actually don't hold any locks that prevent
preemption, so we can take preemption points which the TCP code
wasn't designed with in-mind.

Normally, we control the sleep point very carefully in the TCP
sendmsg/recvmsg code, such that when we sleep we drop the socket
lock and process the backlog packets that accumulated while the
socket was locked.

With pre-emption we can't control that properly.

The problem is that we really do need to run the backlog any time
we give up the cpu in the sendmsg/recvmsg path, or things get real
erratic.  ACKs don't go out as early as we'd like them to, etc.

It isn't easy to do generically, perhaps, because we can only
drop the socket lock at certain points and we need to do that to
run the backlog.

This is why my suggestion is to preempt_disable() as soon as we
grab the socket lock, and explicitly test need_resched() at places
where it is absolutely safe, like this:

	if (need_resched()) {
		/* Run packet backlog... */
		release_sock(sk);
		schedule();
		lock_sock(sk);
	}

The socket lock is just a by-hand binary semaphore, so it doesn't
block pre-emption.  We have to be able to sleep while holding it.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268257AbTCFSTs>; Thu, 6 Mar 2003 13:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268266AbTCFSSy>; Thu, 6 Mar 2003 13:18:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37315 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268257AbTCFSSn>;
	Thu, 6 Mar 2003 13:18:43 -0500
Date: Thu, 06 Mar 2003 10:10:55 -0800 (PST)
Message-Id: <20030306.101055.25273500.davem@redhat.com>
To: torvalds@transmeta.com
Cc: mingo@elte.hu, levon@movementarian.org, akpm@digeo.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0303061016460.7720-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303061914250.16561-100000@localhost.localdomain>
	<Pine.LNX.4.44.0303061016460.7720-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Thu, 6 Mar 2003 10:20:42 -0800 (PST)

   Note that "in_interrupt()" will also trigger for callers that call from
   bh-atomic regions as well as actual BH handlers. Which is correct - they 
   are both "interrupt contexts" as far as most users should be concerned.
   
   The unix domain case may well be bh-atomic, I haven't looked at the code. 
   I'm pretty much certain that the TCP case _will_ be BH-atomic, even for 
   loopback.
   
   David?

Unix sockets use non-BH locks, there are no software interrupts
involved in AF_UNIX processing so no need to protect against them.

The actual wakeup comes from the socket callbacks, we use the
default data_ready() which is:

void sock_def_readable(struct sock *sk, int len)
{
        read_lock(&sk->callback_lock);
        if (sk->sleep && waitqueue_active(sk->sleep))
		wake_up_interruptible(sk->sleep);
	sk_wake_async(sk,1,POLL_IN);
	read_unlock(&sk->callback_lock);
}

And for write wakeups Unix uses it's own, which is:

static void unix_write_space(struct sock *sk)
{
        read_lock(&sk->callback_lock);
        if (unix_writable(sk)) {
		if (sk->sleep && waitqueue_active(sk->sleep))
                        wake_up_interruptible(sk->sleep);
                sk_wake_async(sk, 2, POLL_OUT);
        }
        read_unlock(&sk->callback_lock);
}

So, to reiterate, no BH locking is used by AF_UNIX.

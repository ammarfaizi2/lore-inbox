Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758829AbWLCWMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758829AbWLCWMn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 17:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758919AbWLCWMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 17:12:43 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:13726 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1758829AbWLCWMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 17:12:42 -0500
Date: Mon, 4 Dec 2006 01:12:27 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? rcu_do_batch: fix a pure theoretical memory ordering race
Message-ID: <20061203221227.GA468@oleg>
References: <20061202212517.GA1199@oleg> <45730AAD.1050006@cosmosbay.com> <20061203200153.GA107@oleg> <457334C4.8010604@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457334C4.8010604@cosmosbay.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03, Eric Dumazet wrote:
>
> Oleg Nesterov a ?crit :
> 
> Yes, but how is it related to RCU ?
> I mean, rcu_do_batch() is just a loop like others in kernel.
> The loop itself is not buggy, but can call a buggy function, you are right.

	int start_me_again;

	struct rcu_head rcu_head;

	void rcu_func(struct rcu_head *rcu)
	{
		start_me_again = 1;
	}

	// could be called on arbitrary CPU
	void check_start_me_again(void)
	{
		static spinlock_t lock;

		spin_lock(lock);
		if (start_me_again) {
			start_me_again = 0;
			call_rcu(&rcu_head, rcu_func);
		}
		spin_unlock(lock);
	}

I'd say this code is not buggy.

In case it was not clear. I do not claim we need this patch (I don't know).
And yes, I very much doubt we can hit this problem in practice (even if I am
right).

What I don't agree with is that it is callback which should take care of this
problem.

> A smp_rmb() wont avoid all possible bugs...

For example?

Oleg.


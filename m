Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVJFUXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVJFUXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 16:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVJFUXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 16:23:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5786
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751350AbVJFUXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 16:23:37 -0400
Date: Thu, 06 Oct 2005 13:23:22 -0700 (PDT)
Message-Id: <20051006.132322.85672611.davem@davemloft.net>
To: torvalds@osdl.org
Cc: jsmith@drexel.edu, linux-kernel@vger.kernel.org
Subject: Re: Instability in kernel version 2.6.12.5
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0510061110170.31407@g5.osdl.org>
References: <43455F33.7020102@drexel.edu>
	<Pine.LNX.4.64.0510061110170.31407@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 6 Oct 2005 11:24:25 -0700 (PDT)

> For example, maybe some networking timer just changes its "expires" field 
> _while_ a timer is active directly rather than using "mod_timer()", which 
> can screw up the sorting - and that can affect other timers.

We actually investigated a possible case of this recently.

It was thought that perhaps it was possible for the ARP
generic neighbour cache to double-add a timer, so we added
a guard by converting it to mod_timer() from add_timer()
and making sure it always returns "0" (timer not active).

static inline void neigh_add_timer(struct neighbour *n, unsigned long when)
{
	if (unlikely(mod_timer(&n->timer, when))) {
		printk("NEIGH: BUG, double timer add, state is %x\n",
		       n->nud_state);
	}
}

But this new debugging hasn't triggered for anyone yet :-)

In general the networking tends to use mod_timer() exclusively, for
the simple reason that this makes refcounting on the object so much
simpler.  For example, all of the socket timer helpers do stuff like
this:

void sk_reset_timer(struct sock *sk, struct timer_list* timer,
		    unsigned long expires)
{
	if (!mod_timer(timer, expires))
		sock_hold(sk);
}

void sk_stop_timer(struct sock *sk, struct timer_list* timer)
{
	if (timer_pending(timer) && del_timer(timer))
		__sock_put(sk);
}

I have no idea what the situation is in the netfilter bits, but
something similar is likely.

This brings me to a topic I'd like addressed.  add_timer() no longer
checks whether it is adding a timer twice or not.

This debugging functionality got lost when add_timer() was changed
to be implemented in terms of __mod_timer().  I really think adding
back a "BUG_ON(timer_pending(timer)" would be a very good idea.
I believe Andrew Morton even added this bug check into his -mm tree
last time I brought this issue up.

Finally, it could be argued that add_timer() is not really a necessary
interface and that one can do whatever they need to purely using
mod_timer().  mod_timer() is kind of like a NAND gate I suppose :-)

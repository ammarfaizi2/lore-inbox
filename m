Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUC3WzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUC3Wxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:53:36 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:17373
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261648AbUC3WtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:49:08 -0500
Date: Wed, 31 Mar 2004 00:49:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Robert.Olsson@data.slu.se, paulmck@us.ibm.com,
       akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040330224902.GM3808@dualathlon.random>
References: <20040329222926.GF3808@dualathlon.random> <200403302005.AAA00466@yakov.inr.ac.ru> <20040330211450.GI3808@dualathlon.random> <20040330133000.098761e2.davem@redhat.com> <20040330213742.GL3808@dualathlon.random> <20040330142210.080dbe38.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330142210.080dbe38.davem@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 02:22:10PM -0800, David S. Miller wrote:
> Otherwise, keep in mind what I said, and also as Robert mentioned every
> single local_bh_enable() is going to call do_softirq() if the count falls
> to zero.

I was less concerned about the do_sofitrq in local_bh_enable, since that
runs in a scheduler-aware context, so at least the timeslice is
definitely accounted for and it'll schedule at some point (unlike with
an hardirq flood). Actually the length of the default timeslice matters
too here, lowering the max timeslice to 10msec would certainly reduce
the effect.

call_rcu_bh will fix the local_bh_enable too. The only problem with
call_rcu_bh is how to queue the tasklets in every cpu (an IPI sounds
overkill at high frequency, because effectively here we're running the rcu
callbacks in a potential fast path).  OTOH if we've to add a spinlock to
queue the tasklet, then we might as well take a spinlock in the routing
cache in the first place (at least for this workload).

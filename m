Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272962AbTG3PXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272947AbTG3PW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:22:29 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:20928 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S272927AbTG3PUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:20:43 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: habanero@us.ibm.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
Date: Wed, 30 Jul 2003 17:23:55 +0200
User-Agent: KMail/1.5.1
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
References: <200307280548.53976.efocht@gmx.net> <200307291208.30332.efocht@hpce.nec.com> <200307290833.05216.habanero@us.ibm.com>
In-Reply-To: <200307290833.05216.habanero@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301723.55148.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 July 2003 15:33, Andrew Theurer wrote:
> > The fact that global rebalances are done only in the timer interrupt
> > is simply bad!
>
> Even with this patch it still seems that most balances are still timer
> based, because we still call load_balance in rebalance_tick.  Granted, we
> may inter-node balance more often, well, maybe less often since
> node_busy_rebalance_tick was busy_rebalance_tick*2.  I do see the advantage
> of doing this at idle, but idle only, that's why I'd would be more inclined
> a only a much more aggressive idle rebalance.

Without this patch the probability to globally balance when going idle
is 0. Now it is 1/global_balance_rate(cpus_in_this_node) . This is
tunable and we can make this probability depending on the node load
imbalance. I'll try that in the next version, it sounds like a good
idea. Also changing this probability by some factor could give us a
way to handle the differences between the platforms.

Balancing globally only when idle isn't a good idea as long as we
don't have multiple steals per balance attempt. Even then, tasks don't
live all the same time, so you easilly end up with one node overloaded
and others just busy and not able to steal from the busiest node.

> > It complicates rebalance_tick() and wastes the
> > opportunity to get feedback from the failed local balance attempts.
>
> What does "failed" really mean?  To me, when *busiest=null, that means we
> passed, the node itself is probably balanced, and there's nothing to do. 
> It gives no indication at all of the global load [im]balance.  Shouldn't
> the thing we are looking for is the imbalance among node_nr_running[]? 
> Would it make sense to go forward with a global balance based on that only?

I'll try to include the node imbalance in the global balance rate
calculation, let's see how it works. Just wanted to fix one issue with
my patch, now it looks like it provides some simple ways to solve
other issues as well... Thanks for the idea!

Regards,
Erich





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264805AbTE1RA3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 13:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbTE1RA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 13:00:29 -0400
Received: from franka.aracnet.com ([216.99.193.44]:44190 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264805AbTE1RA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 13:00:26 -0400
Date: Wed, 28 May 2003 10:13:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>
cc: Andi Kleen <ak@suse.de>, LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Message-ID: <26980000.1054142004@[10.10.2.4]>
In-Reply-To: <200305281902.35511.efocht@hpce.nec.com>
References: <200305271031.55554.efocht@hpce.nec.com> <200305272328.27269.efocht@hpce.nec.com> <2640000.1054072312@[10.10.2.4]> <200305281902.35511.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And is this restricted to just clones? Doesn't
>> seem to be, unless that's implicit in homenode_unset?
> 
> Hmmm... That's actually the difficult issue with fork vs. clone and
> migrating or not. When you clone a small task, you'd usually like to
> keep it on the same node. If it's a big task and fault-in a lot of
> memory, it could make sense to let it migrate to another node. For
> forked tasks it's the same, you mighthave some more COW memory
> movement but after that you'll usually be happy if the child went away
> from the parent's node if it is a long-running child. Not so for a
> short running child. 

Can you define what you mean by big vs small? I presume you mean RSS?
There are several factors that come into play here, at least:

1. RSS (and which bits of this lie on which node)
2. CPU utilisation of the task
3. Task duration
4. Cache warmth
5. the current balance situation.

I'm not convinced there's anything we can do about 3, since it's mostly
unpredicatable, and I don't have crystal_ball.o ... we can kind of predict
2, at least for running tasks (not sure it makes much sense over fork).
For 1, we can kind of use that over a fork, though as we have no idea
whether it'll exec or not, I'm not sure it's much use *unless* we're
cloning. 

> The current compromise:
> - start children (no matter whether forked or cloned) on the same CPU
> - allow other CPUs to steal freshly forked children by reducing the
> cache affinity until the first steal/migration
> - ok with chidren who exec soon, they might exec before anyone can
> steal them, drop all the pages and find anew life on the optimal node
> 
> This way exec'd tasks get properly baklanced, forked/cloned ones get a
> better start than in the current scheduler. I'll post a patch on top
> of the node affine scheduler doing this in 1-2 days.

Turning on child-runs-first would instinctively be good as well, though
I have no benchmarks to prove it ... would be nice to get the load
balance situation fixed asap by running the exec. That's not on right
now, IIRC.

M.

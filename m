Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTLHSVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTLHSVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:21:48 -0500
Received: from mx1.elte.hu ([157.181.1.137]:156 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261311AbTLHSVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:21:46 -0500
Date: Mon, 8 Dec 2003 19:21:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
In-Reply-To: <20031208175622.GY19856@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312081859100.8707@earth>
References: <20031117021511.GA5682@averell> <Pine.LNX.4.56.0311231300290.16152@earth>
 <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth>
 <20031208175622.GY19856@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Dec 2003, William Lee Irwin III wrote:

> This appears to either leak migration threads or not set
> rq->cpu[x].migration_thread basically ever for x > 0. Or if they are
> shut down, how? Also, what makes sure cpu_idx is initialized before they
> wake? They'll all spin on cpu_rq(0)->lock, no?

yep, it just leaks migration threads. Not a big problem right now, but for
hotplug CPU support this needs to be fixed.

> Furthermore, sched_map_runqueue() is performed after all the idle
> threads are running and all the notifiers have kicked the migration
> threads, but does no locking whatsoever.

yep - at this point nothing else is really supposed to run but you are
right it must be locked properly.

> Also, does init_idle() need to move into rest_init()? It should be
> equivalent to its current placement.

this is a leftover of a change that went into 2.6 already. I've removed
this change.

> Why not per_cpu for __rq_idx[] and __cpu_idx[]? This would have the
> advantage of residing on node-local memory for sane architectures (and
> perhaps in the future, some insane ones).

agreed, i've changed them to be per-cpu.

new patch with all your suggestions included is at:

  redhat.com/~mingo/O(1)-scheduler/sched-SMT-2.6.0-test11-C1

it also includes the bounce-to-cpu1 fix from/for Anton.

	Ingo

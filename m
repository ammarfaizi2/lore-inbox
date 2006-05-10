Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWEJKJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWEJKJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWEJKJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:09:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58053 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964839AbWEJKJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:09:07 -0400
Date: Wed, 10 May 2006 12:08:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT 0/2] futex priority based wakeup
Message-ID: <20060510100858.GA31504@elte.hu>
References: <20060510112651.24a36e7b@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060510112651.24a36e7b@frecb000686>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sébastien Dugué <sebastien.dugue@bull.net> wrote:

>   in the current futex implementation, tasks are woken up in FIFO 
> order, (i.e. in the order they were put to sleep). For realtime 
> systems needing system wide strict realtime priority scheduling, tasks 
> should be woken up in priority order.
> 
>   This patchset achieves this by changing the futex hash bucket list 
> into a plist. Tasks waiting on a futex are enqueued in this plist 
> based on their priority so that they can be woken up in priority 
> order.

hm, i dont think this is enough. Basically, waking up in priority order 
is just the (easier) half of the story - what you want is to also 
propagate priorities when you block. We provided a complete solution via 
the PI-futex patchset (currently included in -mm).

In other words: as long as locking primitives go, i dont think real-time 
applications should use wakeup-priority-ordered futexes, they should use 
the real thing, PI futexes.

There is one exception: when a normal futex is used as a waitqueue 
without any contention properties. (for example a waitqueue for worker 
threads) But those are both rare, and typically dont muster tasks with 
different priorities - i.e. FIFO is good enough.

Also, there's a performance cost to this. Could you try to measure the 
impact to SCHED_OTHER tasks via some pthread locking benchmark?

	Ingo

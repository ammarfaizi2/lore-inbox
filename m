Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTLaItb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 03:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTLaIta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 03:49:30 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:19926 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263107AbTLaIr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 03:47:56 -0500
Subject: Re: [PATCH 1/2] kthread_create
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3FF26DFF.3040909@pobox.com>
References: <20031231053032.255202C08B@lists.samba.org>
	 <3FF26DFF.3040909@pobox.com>
Content-Type: text/plain
Message-Id: <1072860438.716.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Dec 2003 19:47:19 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-31 at 17:34, Jeff Garzik wrote:
> Rusty Russell wrote:
> > For #2, if you really can't wait for keventd, perhaps your own
> > workqueue is in order?
> 
> Way too wasteful, and doing so is working around a fundamental failing 
> of workqueues:  keventd gives no guarantee that your scheduled work will 
> be executed this week, this month, or this year :)
> 
> keventd is used by two competing classes of users:  those who want 
> low-latency, quick execution in task context (Tux-ish), and those who 
> just want to run something in task context, where they might sleep 
> (perhaps for a long time).

That why those ones could be replaced by short-lived threads... I use
a short lived thread for ADB probing and I'm considering doing so for
things like ethernet NIC reset etc... which is definitely scheduling
way too long in keventd

> So it would be nice to have thread pool semantics occasionally found in 
> userspace:  if thread pool is full when new work is queued, 
> _temporarily_ increase the pool size (or create a one-shot kthread). 
> Sure you have kthread creation overhead, but at least you have a 
> reasonable guarantee that your work won't wait 5-30 seconds or more 
> before being performed.

The overhead isn't big (and even lower with kthread I suppose due to
not doing daemonize() & reparent_to_init()) so for occasional
long-sleeping crap, short lived kthreads seem to be the solution. If
those end up not using keventd any more (except for actual creation
of the short lived thread), there is probably no need for a thread pool
thing, only low latency stuffs will still use work_queue.

Ben.



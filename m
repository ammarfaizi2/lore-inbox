Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVDIWmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVDIWmK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 18:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVDIWmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 18:42:10 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:39917 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261396AbVDIWmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 18:42:06 -0400
Date: Sun, 10 Apr 2005 00:39:46 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, antonb@au1.ibm.com, davej@codemonkey.org.uk,
       hpa@zytor.com, len.brown@intel.com, andmike@us.ibm.com, rth@twiddle.net,
       rusty@au1.ibm.com, schwidefsky@de.ibm.com, jgarzik@pobox.com
Subject: Re: [RFC,PATCH 3/4] Change synchronize_kernel to _rcu and _sched
Message-ID: <20050409223946.GA11809@electric-eye.fr.zoreil.com>
References: <20050409122045.GA6073@electric-eye.fr.zoreil.com> <Pine.LNX.4.44.0504092039280.20335-100000@dbl.q-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0504092039280.20335-100000@dbl.q-ag.de>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> :
[...]
> I always thought that all callers of dev->hard_start_xmit() acquire
> dev->xmit_lock before calling hard_start_xmit().
> 
> Is that assumption wrong? I think I even rely on that in one of my
> drivers.

Afaik, no, it is right.

This part of the r8169 driver handles the window starting where qdisc_run()
tests netif_queue_stopped() to the spin_trylock(&dev->xmit_lock) in
qdisc_restart: the lock is not taken and dev->hard_start_xmit() will happen
in the near future ("near" or "preempt safe near" is not relevant here).
The driver must wait for the late newcomer to do its whole work before
it can release the Tx ring, whence the former synchronize_kernel().

r8169_down() looks a bit baroque because it can race with the irq handler
or dev->poll() or the recovery timer and none of those spin_locks either.

I may have missed something though. Feel free to educate.

--
Ueimor

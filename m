Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbSKHD4i>; Thu, 7 Nov 2002 22:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbSKHD4i>; Thu, 7 Nov 2002 22:56:38 -0500
Received: from holomorphy.com ([66.224.33.161]:59559 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266749AbSKHD4h>;
	Thu, 7 Nov 2002 22:56:37 -0500
Date: Thu, 7 Nov 2002 19:57:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, mbligh@aracnet.com, ahu@ds9a.nl,
       peter@chubb.wattle.id.au, jw@pegasys.ws, linux-kernel@vger.kernel.org
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021108035724.GB22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Alexander Viro <viro@math.psu.edu>, mbligh@aracnet.com, ahu@ds9a.nl,
	peter@chubb.wattle.id.au, jw@pegasys.ws,
	linux-kernel@vger.kernel.org
References: <32290000.1036545797@flay> <Pine.GSO.4.21.0211051932140.6521-100000@steklov.math.psu.edu> <20021107230613.5194156c.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107230613.5194156c.rusty@rustcorp.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 11:06:13PM +1100, Rusty Russell wrote:
> Now, according to wli, there's a real problem with starvation by saturating
> the read side of the tasklist_lock so eg. the write_lock_irq(&tasklist_lock)
> in exit.c's release_task causes a CPU to spin for ages (forever?) with
> interrupts off.  This needs fixing, be it RCU or making that particular
> lock give way to writers, or some other effect.

One way to at least "postpone" having to do things like making a fair
tasklist_lock is to make readers well-behaved. /proc/ is the worst
remaining offender left with its quadratic (!) get_pid_list(). After
"kernel, you're being bad and spinning in near-infinite loops with the
tasklist_lock readlocked" is (completely?) solved, then we can wait for
boxen with higher cpu counts to catch fire anyway when the arrival rate
of readers * hold time of readers > 1, which will happen because arrival
rates are O(cpus), and cpus will grow without bound as machines advance.

I'm not sure RCU would help this any; I'd be very much afraid of the
writes being postponed indefinitely or just too long in the presence
of what's essentially perpetually in-progress read access. Does RCU
have a guarantee of forward progress for writers?

Thanks,
Bill

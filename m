Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310151AbSCAXBy>; Fri, 1 Mar 2002 18:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310152AbSCAXBp>; Fri, 1 Mar 2002 18:01:45 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:44292 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S310151AbSCAXB3>;
	Fri, 1 Mar 2002 18:01:29 -0500
Date: Sat, 2 Mar 2002 01:01:25 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, <kain@kain.org>
Subject: Re: OOPS: Multipath routing 2.4.17
In-Reply-To: <p73sn7jkixm.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0203020050220.1706-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On 1 Mar 2002, Andi Kleen wrote:

> #if 1
> 		if (power <= 0) {
> 			printk(KERN_CRIT "impossible 777\n");
> 			return;
> 		}
> #endif
>
> should stop it; making it just not work, but not crash.
> If he still gets a division by zero then something else is fishy.

	How oops is reached:

	2 CPUs enter fib_select_multipath while fib_power is 1.
Both see 1 at 'if (fi->fib_power <= 0) {', so no 777, CPU1 changes
fib_power from 1 to 0 before CPU2 reaches 'w = jiffies % fi->fib_power;'

	How 888 is printed:

both CPUs see 1 in 'w = jiffies % fi->fib_power;' but the first
changes nh_power and fib_power from 1 to 0. CPU2 sees 0 everywhere
and prints 888. I assume nobody plays with DEAD.

	If I understand correctly the locking (please correct me),
we can have many threads at the same time:

- many in ip_route_* calling fib_select_multipath

- one in rtnetlink playing with nh_*

> -Andi

Regards

--
Julian Anastasov <ja@ssi.bg>


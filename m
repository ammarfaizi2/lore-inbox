Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTICBDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTICBDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:03:22 -0400
Received: from dp.samba.org ([66.70.73.150]:35771 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261214AbTICBDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:03:18 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-reply-to: Your message of "Tue, 02 Sep 2003 07:51:44 +0100."
             <20030902065144.GC7619@mail.jlokier.co.uk> 
Date: Wed, 03 Sep 2003 10:14:48 +1000
Message-Id: <20030903010318.0A46B2C0FC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030902065144.GC7619@mail.jlokier.co.uk> you write:
> What happens after this sequence:
> 
> 	1. process A forks, making process B
> 	2. B does FUTEX_FD, or splits into threads and one does FUTEX_WAIT,
> 	   on a private page that has not been written to since the fork
> 	3. A does FUTEX_WAIT on the same address
> 	3. The page is swapped out
> 	4. B does FUTEX_WAKE at the same address
> 
> Won't the futex be hashed on the swap entry at step 4, so that
> both processes are woken, yet only the waiter in B should be woken?

Part of step (4) is to swap the page back in (see __pin_page).

> Related: could COW sharing after fork() explain the spurious wakeups I
> saw mentioned earlier in the thread?

In case others are sharing this misconception: there *are* no spurious
wakeups.  But if they were to happen, the current code doesn't handle
them correctly, unlike every other primitive I know of in the kernel,
which is why I fixed it while tidying the code.

I don't know of a rule which says "thou shalt not wake a random thread
in the kernel": for all I know wierd things like CPU hotplug or
software suspend may do this in the future.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

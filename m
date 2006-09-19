Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWISSPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWISSPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWISSPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:15:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030311AbWISSPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:15:48 -0400
Date: Tue, 19 Sep 2006 11:14:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Ayaz Abdulla <aabdulla@nvidia.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] forcedeth: hardirq lockdep warning
Message-Id: <20060919111448.9274c699.akpm@osdl.org>
In-Reply-To: <1158670522.3278.13.camel@taijtu>
References: <1158670522.3278.13.camel@taijtu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 14:55:22 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> BUG: warning at kernel/lockdep.c:1816/trace_hardirqs_on() (Not tainted)

I wonder what line that was.  DEBUG_LOCKS_WARN_ON(current->hardirq_context),
I suppose.

> Call Trace:
>  show_trace
>  dump_stack
>  trace_hardirqs_on
>  :forcedeth:nv_nic_irq_other
>  handle_IRQ_event
>  __do_IRQ
>  do_IRQ
>  ret_from_intr
> DWARF2 barf

It's good, isn't it?

>  default_idle
>  cpu_idle
>  rest_init
>  start_kernel
>  _sinittext
>  
> These 3 functions nv_nic_irq_tx(), nv_nic_irq_rx() and nv_nic_irq_other()
> are reachable from IRQ context and process context.

That's "fix deadlock", not "fix lockdep warning".  However it's often the
case that it's not really deadlockable because (often) the card's IRQ line
has been disabled.  That appears to be the case in nv_do_nic_poll()'s call
to nv_nic_irq_tx, for example.

> Make use of the 
> irq-save/restore spinlock variant.

So this perhaps is another lockdep workaround..

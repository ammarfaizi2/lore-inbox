Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWISTMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWISTMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWISTMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:12:25 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:36320 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750942AbWISTMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:12:24 -0400
Subject: Re: [PATCH] forcedeth: hardirq lockdep warning
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Ayaz Abdulla <aabdulla@nvidia.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@linux.intel.com>, Dave Jones <davej@redhat.com>
In-Reply-To: <20060919111448.9274c699.akpm@osdl.org>
References: <1158670522.3278.13.camel@taijtu>
	 <20060919111448.9274c699.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 21:12:10 +0200
Message-Id: <1158693131.28174.6.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 11:14 -0700, Andrew Morton wrote:
> On Tue, 19 Sep 2006 14:55:22 +0200
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > BUG: warning at kernel/lockdep.c:1816/trace_hardirqs_on() (Not tainted)
> 
> I wonder what line that was.  DEBUG_LOCKS_WARN_ON(current->hardirq_context),
> I suppose.

Correct indeed.

> > Call Trace:
> >  show_trace
> >  dump_stack
> >  trace_hardirqs_on
> >  :forcedeth:nv_nic_irq_other
> >  handle_IRQ_event
> >  __do_IRQ
> >  do_IRQ
> >  ret_from_intr
> > DWARF2 barf
> 
> It's good, isn't it?

Yeah, I hope we'll get it sorted out quickly....

> >  default_idle
> >  cpu_idle
> >  rest_init
> >  start_kernel
> >  _sinittext
> >  
> > These 3 functions nv_nic_irq_tx(), nv_nic_irq_rx() and nv_nic_irq_other()
> > are reachable from IRQ context and process context.
> 
> That's "fix deadlock", not "fix lockdep warning".  However it's often the
> case that it's not really deadlockable because (often) the card's IRQ line
> has been disabled.  That appears to be the case in nv_do_nic_poll()'s call
> to nv_nic_irq_tx, for example.

Yeah, I saw some of that. But I'm not well versed in the various netdev
irq receive paths nor in the driver. I couldn't find the actual
maintainer in the MAINTAINERS file nor in the source, thanks for
including him in the CC. Lets hope he can say if this is an actual fix
or just a workaround.




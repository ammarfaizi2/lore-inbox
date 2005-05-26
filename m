Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVEZTWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVEZTWZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVEZTWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:22:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:14294 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261703AbVEZTVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:21:55 -0400
Date: Thu, 26 May 2005 12:22:12 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: John Hawkes <hawkes@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] drop note_interrupt() for per-CPU for proper scaling
Message-ID: <20050526192212.GB1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <4295081B.MailKJ51120GH@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4295081B.MailKJ51120GH@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 04:19:55PM -0700, John Hawkes wrote:
> The "unhandled interrupts" catcher, note_interrupt(), increments a global
> desc->irq_count and grossly damages scaling of very large systems, e.g.,
> >192p ia64 Altix, because of this highly contented cacheline, especially
> for timer interrupts.  384p is severely crippled, and 512p is unuseable.
> 
> All calls to note_interrupt() can be disabled by booting with "noirqdebug",
> but this disables the useful interrupt checking for all interrupts.
> 
> I propose eliminating note_interrupt() for all per-CPU interrupts.
> This was the behavior of linux-2.6.10 and earlier, but in 2.6.11 a
> code restructuring added a call to note_interrupt() for per-CPU interrupts.
> Besides, note_interrupt() is a bit racy for concurrent CPU calls anyway,
> as the desc->irq_count++ increment isn't atomic (which, if done, would make
> scaling even worse).

Would it be reasonable for note_interrupt() to operate on per-CPU or
per-group-of-CPUs counters?  Each CPU (or group) could either separately
count and check, or, if accuracy is important (can't see why it would
be), the per-CPU (or group) counters could be added to a global counter
every 100 (or 1,000 or whatever) counts, and this global counter then
checked against the limit.

							Thanx, Paul

> Signed-off-by: John Hawkes <hawkes@sgi.com>
> ---
> 
> Index: linux/kernel/irq/handle.c
> ===================================================================
> --- linux.orig/kernel/irq/handle.c	2005-03-01 23:38:37.000000000 -0800
> +++ linux/kernel/irq/handle.c	2005-05-18 11:02:18.000000000 -0700
> @@ -118,8 +118,6 @@
>  		 */
>  		desc->handler->ack(irq);
>  		action_ret = handle_IRQ_event(irq, regs, desc->action);
> -		if (!noirqdebug)
> -			note_interrupt(irq, desc, action_ret);
>  		desc->handler->end(irq);
>  		return 1;
>  	}
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
> online with coworkers and clients while avoiding the high cost of travel and
> communications. There is no equipment to buy and you can meet as often as
> you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 

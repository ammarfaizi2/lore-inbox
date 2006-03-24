Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422998AbWCXDrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422998AbWCXDrr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 22:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWCXDrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 22:47:47 -0500
Received: from colin.muc.de ([193.149.48.1]:54797 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751537AbWCXDrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 22:47:46 -0500
Date: 24 Mar 2006 04:47:38 +0100
Date: Fri, 24 Mar 2006 04:47:38 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Rafal.Wysocki@fuw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-ID: <20060324034738.GA24453@muc.de>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <200603232317.50245.Rafal.Wysocki@fuw.edu.pl> <20060323160426.153fbea9.akpm@osdl.org> <1143161390.2299.36.camel@leatherman> <20060323172805.00926c13.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323172805.00926c13.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The above patch records the most-recent caller of local_irq_disable() in a
> global variable, then prints that out in the lost-ticks handler.  But how
> do we know that the global didn't get overwritten between the most-recent
> local_irq_enable() and the call to handle_lost_ticks()?

Because the overdue timer interrupt will trigger one instruction later.

> 
> I guess the code assumes that the local_irq_enable() will result in
> insta-entry into the timer IRQ handler.  Which is probably good enough, as
> interrupts from other sources won't be pending most times.

Yes. Actually irq 0 has higher priority than most interrupts,
but not all.


> 
> So why did we lose three ticks after __do_sortirq()'s local_irq_disable()? 
> Dunno.

It's a mistery. I put the patches in to trace a pattern.

But you're right they should at least be using per cpu variables
instead of globals which can be corrupted by other CPUs.

> (Is there any point in do_softirq() doing local_irq_save() instead of
> local_irq_disable()?  __do_softirq() will unconditionally enable anyway..)

The interrupt handling in there is quite messy and has some other
wards too. Could probably take a good cleanup. Problem is that
it will need a lot of editing of architectures to do properly.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVJXG21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVJXG21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 02:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVJXG21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 02:28:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:11498 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751018AbVJXG21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 02:28:27 -0400
Date: Sun, 23 Oct 2005 23:29:09 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/9] ipmi: use refcount in message handler
Message-ID: <20051024062909.GA10337@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051021144909.GA19532@i2.minyard.local> <20051024021931.GA9696@us.ibm.com> <20051024044217.GA32199@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024044217.GA32199@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2005 at 11:42:17PM -0500, Matt Domsch wrote:
> On Sun, Oct 23, 2005 at 07:19:32PM -0700, Paul E. McKenney wrote:
> > My guess is that this read-side critical section can be invoked from and
> > SMI, and that SMIs can occur even if interrupts are disabled.  If my guess
> > is wrong, please enlighten me.  And feel free to ignore the next few
> > paragraphs in that case, along with a number of my suggested changes,
> > since they all depend critically on my guess being correct.
> 
> Paul, it took me a bit to figure this out too, but Corey uses the TLA
> "SMI" to mean "Systems Management Interface", not "Systems Management
> Interrupt".   From Documentation/IPMI.txt:
> 
> ipmi_msghandler - This is the central piece of software for the IPMI
> system.  It handles all messages, message timing, and responses.  The
> IPMI users tie into this, and the IPMI physical interfaces (called
> System Management Interfaces, or SMIs) also tie in here.
> 
> 
> There are at least 4 basic types of physical hardware interfaces (BT,
> SMIC, KCS, and I2C), which may (or more often, may not) have their own
> hardware interrupt lines, but these are normal interrupts, not
> CPU-magic "systems management interrupts".  So I think this isn't a
> problem.

OK, thank you for the tutorial on the "other SMI"!

The comments about turning synchronize_rcu() into synchronize_sched()
and rcu_read_lock() into preempt_disable() do not apply, please ignore.

However, I still do not understand how using RCU on cmd_rcvrs helps,
given that all of the accesses that I could see were already protected
by cmd_rcvrs_lock.

Any further enlightenment available?

						Thanx, Paul

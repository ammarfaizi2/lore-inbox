Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbULFQKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbULFQKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULFQG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:06:26 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:61947 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261554AbULFQE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:04:59 -0500
Date: Mon, 6 Dec 2004 08:04:05 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Li Shaohua <shaohua.li@intel.com>
Subject: Re: Fw: [RFC] Strange code in cpu_idle()
Message-ID: <20041206160405.GB1271@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041205004557.GA2028@us.ibm.com> <20041206111634.44d6d29c.sfr@canb.auug.org.au> <20041205232007.7edc4a78.akpm@osdl.org> <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 02:38:33AM -0700, Zwane Mwaikambo wrote:
> Hi,
> 	The original intent to go with synchronize_kernel and RCU 
> protection was for simplicity's sake, as the alternative implementations 
> at the time looked like major overkill. Now in defense of this method, 
> when entering the idle thread and placing the processor in a holding state 
> (hlt) and an RCU grace period is begun, the processor in the holding state 
> will be unaware of the new RCU grace period until it exits the idle loop 
> callback (pm_idle) anyway, so the rcu_read will block the other processors 
> from making RCU grace period completion as much as the processor holding 
> state. This is true of all current pm_idle callbacks on i386, x86_64 and 
> ia64 with the exception of APM (but i'll conveniently ignore that for now 
> ;). When we do take an interrupt to exit the processor holding state and 
> run through rcu_check_callbacks we will notice that we are in a hard 
> interrupt and will defer marking of the processsor as quiescent. By that 
> point we will have exited the idle thread callback therefore making it 
> safe to use synchronize_kernel to protect removal of the callback.

I am not going to claim to thoroughly understand the power-management
code, but do have an additional question.

What happens if the processor became aware of a new grace period just
before entering pm_idle?  I could imagine this code simply refusing
to power down the processor if there was a pending grace period, but
I don't see any sign of this.  I could also imagine somehow deferring
interrupts until pm_idle exits.  I don't see anything that looks like
it does this, but don't claim to be any sort of power-management
expert.

						Thanx, Paul

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbUKSVDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUKSVDs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKSVCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:02:40 -0500
Received: from motgate8.mot.com ([129.188.136.8]:49398 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261566AbUKSVBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:01:44 -0500
In-Reply-To: <419E550B.7030107@colorfullife.com>
References: <419E550B.7030107@colorfullife.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2A6C102E-3A6E-11D9-B023-000393C30512@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: Jason McMullan <jason.mcmullan@timesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] MII bus API for PHY devices
Date: Fri, 19 Nov 2004 15:01:21 -0600
To: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 19, 2004, at 14:18, Manfred Spraul wrote:

> Hi,
>
> I don't like the polling/interrupt setup part:
> - for a nic driver, there is no irq line that could be requested by 
> mii_phy_irq_enable().
> - if the mii bus driver uses it's own timers, then locking within the 
> nics will be more difficult.

I'm not sure I accept the argument that locking will be more difficult. 
  Jason's patch requires that a callback be registered for the interrupt 
or the polling (My update has a similar scheme).  The function you 
register is essentially like an extra interrupt, except it is never 
invoked at interrupt time.  All the function has to do is react 
properly to link state.  If, previously, you checked link state in your 
interrupt handler, you could still do it there, I suspect.

>
> Could you make that part optional? For a nic driver, I would prefer if 
> I could just call the ->startup part without the request_irq. If the 
> nic irq handler notices that the nic got an event, then it would call 
> an appropriate mii_bus function.

I think it would be doable to arrange the interface such that drivers 
could adopt only the PHY configuration infrastructure, and not any of 
the polling/interrupt infrastructure.  Of course, as it is, it is at 
least WHOLLY optional, so no driver has to use it at all.

>
> This also applies for something like /dev/phy/xy: With natsemi, it 
> would be very tricky to add proper locking. The nic as an internal phy 
> and an external mii bus. The internal phy is partially visible on the 
> external bus and any accesses to the phy id of the internal phy on the 
> external bus cause lockups. No big deal, I just move the internal phy 
> around [the phy id doesn't matter], but I would prefer if I have to do 
> that just for ethtool, not for multiple interfaces.

I agree with this point -- Accessing the PHY through /dev registers is 
a recipe for some mess.  Though I could be convinced that it is 
manageable.  I do think, however, that the ethtool interface is 
sufficient to the task.


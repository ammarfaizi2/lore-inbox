Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVHVX1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVHVX1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVHVX1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:27:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:49548 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751221AbVHVX1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:27:12 -0400
Subject: Re: suspicious behaviour in pcwd driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050822183006.GB27344@redhat.com>
References: <20050822183006.GB27344@redhat.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 09:26:22 +1000
Message-Id: <1124753182.5189.63.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Export machine_power_off() on ppc64, as the pcwd watchdog driver needs it.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.12/arch/ppc64/kernel/setup.c~	2005-08-09 17:37:36.000000000 -0400
> +++ linux-2.6.12/arch/ppc64/kernel/setup.c	2005-08-09 17:37:53.000000000 -0400
> @@ -706,6 +706,7 @@ void machine_power_off(void)
>  	local_irq_disable();
>  	while (1) ;
>  }
> +EXPORT_SYMBOL(machine_power_off);
>  
>  void machine_halt(void)
>  {
> 

In fact, we need that for the G5 thermal driver too. I wonder why/how
this export got removed ... Some over-zealous janitors ?

Hrm... /me plays with gitk

Ahhh, ok, so that is this patch:

<<
machine_restart, machine_halt and machine_power_off are machine
    specific hooks deep into the reboot logic, that modules
    have no business messing with.  Usually code should be calling
    kernel_restart, kernel_halt, kernel_power_off, or
    emergency_restart. So don't export machine_restart,
    machine_halt, and machine_power_off so we can catch buggy users.
>>

Well, I think for now, it's safe for therm_pm72 to call
machine_power_off() in case of critical overtemp. I'll have a look at
kernel_* equivalents later.

Can you still slip that patch into 2.6.13 ?

Ben.



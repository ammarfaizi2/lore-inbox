Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVA1Wna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVA1Wna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVA1Wn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:43:29 -0500
Received: from cantor.suse.de ([195.135.220.2]:27026 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262805AbVA1WnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:43:18 -0500
Date: Fri, 28 Jan 2005 23:43:17 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] idle thread preemption fix
Message-ID: <20050128224317.GA6197@suse.de>
References: <200501082318.j08NI6Kg027877@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200501082318.j08NI6Kg027877@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jan 08, Linux Kernel Mailing List wrote:

> ChangeSet 1.2316, 2005/01/08 13:53:41-08:00, mingo@elte.hu
> 
> 	[PATCH] idle thread preemption fix
> 	
> 	The early bootup stage is pretty fragile because the idle thread is not yet
> 	functioning as such and so we need preemption disabled.  Whether the bootup
> 	fails or not seems to depend on timing details so e.g.  the presence of
> 	SCHED_SMT makes it go away.
> 	
> 	Disabling preemption explicitly has another advantage: the atomicity check
> 	in schedule() will catch early-bootup schedule() calls from now on.
> 	
> 	The patch also fixes another preempt-bkl buglet: interrupt-driven
> 	forced-preemption didnt go through preempt_schedule() so it resulted in
> 	auto-dropping of the BKL.  Now we go through preempt_schedule() which
> 	properly deals with the BKL.
> 	
> 	Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

> diff -Nru a/init/main.c b/init/main.c
> --- a/init/main.c	2005-01-08 15:18:18 -08:00
> +++ b/init/main.c	2005-01-08 15:18:18 -08:00
> @@ -373,6 +373,12 @@
>  {
>  	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
>  	numa_default_policy();
> +	/*
> +	 * Re-enable preemption but disable interrupts to make sure
> +	 * we dont get preempted until we schedule() in cpu_idle().
> +	 */
> +	local_irq_disable();
> +	preempt_enable_no_resched();
>  	unlock_kernel();
>   	cpu_idle();
>  } 

Whats the purpose of local_irq_disable() here? Locks up my toys in
atkbd_init or IP hash foo functions.



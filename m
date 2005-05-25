Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVEYMYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVEYMYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 08:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVEYMYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 08:24:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:52125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262313AbVEYMYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 08:24:53 -0400
Date: Wed, 25 May 2005 05:24:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
Message-Id: <20050525052400.46bccf26.akpm@osdl.org>
In-Reply-To: <20050524154230.GA17814@elte.hu>
References: <20050524121541.GA17049@elte.hu>
	<20050524140623.GA3500@elte.hu>
	<4293420C.8080400@yahoo.com.au>
	<20050524150537.GA11829@elte.hu>
	<42934748.8020501@yahoo.com.au>
	<20050524152759.GA15411@elte.hu>
	<20050524154230.GA17814@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> ..
>
> this patch (ontop of the current -mm scheduler patchset) tweaks 
> cpu_idle() semantics a bit: it changes the idle loops (that do 
> preemption) to call the first schedule() unconditionally.
> 
> the advantage is that as a result we dont have to set the idle thread's 
> NEED_RESCHED flag in init_idle(), which in turn makes cond_resched() 
> even more of an invariant: it can be called even from init code without 
> it having any effect. A cond resched in the init codepath hangs 
> otherwise.
> 
> this patch, while having no negative side-effects, enables wider use of 
> cond_resched()s. (which might happen in the stock kernel too, but it's 
> particulary important for voluntary-preempt) (note that for now this 
> patch only covers architectures that use kernel/Kconfig.preempt, but all 
> other architectures will work just fine too.)
> 
> --- linux/arch/x86_64/kernel/process.c.orig
> +++ linux/arch/x86_64/kernel/process.c
> @@ -162,6 +162,8 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
>   */
>  void cpu_idle (void)
>  {
> +	set_tsk_need_resched(current);
> +
>  	/* endless idle loop with no priority at all */
>  	while (1) {
>  		while (!need_resched()) {

ia64 needed this treatment also to fix a hang during boot.  u o me 3 hrs.

Are all the other architectures busted as well?

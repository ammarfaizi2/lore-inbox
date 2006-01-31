Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWAaWtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWAaWtO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWAaWtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:49:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750725AbWAaWtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:49:13 -0500
Date: Tue, 31 Jan 2006 14:50:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
Cc: ananth@in.ibm.com, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       systemtap@sources.redhat.com, jkenisto@us.ibm.com,
       linux-kernel@vger.kernel.org, sugita@sdl.hitachi.co.jp,
       soshima@redhat.com, haoki@redhat.com
Subject: Re: [PATCH][2/2] kprobe: kprobe-booster against 2.6.16-rc1 for i386
Message-Id: <20060131145053.235e27e4.akpm@osdl.org>
In-Reply-To: <43DEB290.1050000@sdl.hitachi.co.jp>
References: <43DE0A4D.20908@sdl.hitachi.co.jp>
	<43DEB290.1050000@sdl.hitachi.co.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp> wrote:
>
> +#ifdef CONFIG_PREEMPT
> +	unsigned pre_preempt_count = preempt_count();
> +#endif /* CONFIG_PREEMPT */
> 
>  	/*
>  	 * We don't want to be preempted for the entire
> @@ -240,6 +291,21 @@ static int __kprobes kprobe_handler(stru
>  		/* handler has already set things up, so skip ss setup */
>  		return 1;
> 
> +	if (p->ainsn.boostable == 1 &&
> +#ifdef CONFIG_PREEMPT
> +	    !(pre_preempt_count) && /*
> +				       * This enables booster when the direct
> +				       * execution path aren't preempted.
> +				       */
> +#endif /* CONFIG_PREEMPT */
> +	    !p->post_handler && !p->break_handler ) {
> +		/* Boost up -- we can execute copied instructions directly */
> +		reset_current_kprobe();
> +		regs->eip = (unsigned long)&p->ainsn.insn;
> +		preempt_enable_no_resched();
> +		return 1;
> +	}
> +

These preempt tricks look rather nasty.  Can you please describe what the
problem is, precisely?  And how this code avoids it?  Perhaps we can find
something cleaner.

Also, the patch adds a preempt_enable() but I don't see a corresponding
preempt_disable().  Am I missing something?

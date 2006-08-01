Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWHASM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWHASM0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWHASM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:12:26 -0400
Received: from mga07.intel.com ([143.182.124.22]:50322 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751744AbWHASMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:12:25 -0400
X-IronPort-AV: i="4.07,203,1151910000"; 
   d="scan'208"; a="73442680:sNHT74978428"
Date: Tue, 1 Aug 2006 11:01:47 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: synchronous signal in the blocked signal context
Message-ID: <20060801110147.A9822@unix-os.sc.intel.com>
References: <20060731191449.B4592@unix-os.sc.intel.com> <Pine.LNX.4.64.0607312152240.4168@g5.osdl.org> <20060801144403.GA1291@us.ibm.com> <Pine.LNX.4.64.0608010806100.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0608010806100.4168@g5.osdl.org>; from torvalds@osdl.org on Tue, Aug 01, 2006 at 08:25:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 08:25:12AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 1 Aug 2006, Paul E. McKenney wrote:
> > > 
> > > Paul? Should I just revert, or did you have some deeper reason for it?
> > 
> > I cannot claim any deep thought on this one, so please do revert it.
> 
> Well, I do have to say that I like the notion of trying to have the _same_ 
> semantics for "force_sig_info()" and "force_sig_specific()", so in that 
> way your patch is fine - I just missed the fact that it changed it back to 
> the old broken ones (that results in endless SIGSEGV's if the SIGSEGV 
> happens when setting up the handler for the SIGSEGV and other 
> "interesting" issues, where a bug can result in the user process hanging 
> instead of just killing it outright).
> 
> However, I wonder if the _proper_ fix is to just either remove 
> "force_sig_specific()" entirely, or just make that one match the semantics 
> of "force_sig_info()" instead (rather than doing it the other way - change 
> for_sig_specific() to match force_sig_info()).
> 
> force_sig_info() has only two uses, and both should be ok with the 
> force_sig_specific() semantics, since they are for SIGSTOP and SIGKILL 
> respectively, and those should not be blockable unless you're a kernel 
> thread (and I don't think either of them could validly ever be used with 
> kernel threads anyway), so doing it the other way around _should_ be ok.
> 
> Paul, Suresh, would something like this work for you instead?

Yes.

Acked-by: Suresh Siddha <suresh.b.siddha@intel.com>

> 
> 		Linus
> ----
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 7fe874d..bfdb568 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -791,22 +791,31 @@ out:
>  /*
>   * Force a signal that the process can't ignore: if necessary
>   * we unblock the signal and change any SIG_IGN to SIG_DFL.
> + *
> + * Note: If we unblock the signal, we always reset it to SIG_DFL,
> + * since we do not want to have a signal handler that was blocked
> + * be invoked when user space had explicitly blocked it.
> + *
> + * We don't want to have recursive SIGSEGV's etc, for example.
>   */
> -
>  int
>  force_sig_info(int sig, struct siginfo *info, struct task_struct *t)
>  {
>  	unsigned long int flags;
> -	int ret;
> +	int ret, blocked, ignored;
> +	struct k_sigaction *action;
>  
>  	spin_lock_irqsave(&t->sighand->siglock, flags);
> -	if (t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
> -		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
> -	}
> -	if (sigismember(&t->blocked, sig)) {
> -		sigdelset(&t->blocked, sig);
> +	action = &t->sighand->action[sig-1];
> +	ignored = action->sa.sa_handler == SIG_IGN;
> +	blocked = sigismember(&t->blocked, sig);
> +	if (blocked || ignored) {
> +		action->sa.sa_handler = SIG_DFL;
> +		if (blocked) {
> +			sigdelset(&t->blocked, sig);
> +			recalc_sigpending_tsk(t);
> +		}
>  	}
> -	recalc_sigpending_tsk(t);
>  	ret = specific_send_sig_info(sig, info, t);
>  	spin_unlock_irqrestore(&t->sighand->siglock, flags);
>  

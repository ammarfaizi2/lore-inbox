Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbWHASMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWHASMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWHASMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:12:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39379 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751753AbWHASMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:12:53 -0400
Date: Tue, 1 Aug 2006 11:13:32 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: synchronous signal in the blocked signal context
Message-ID: <20060801181331.GF1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060731191449.B4592@unix-os.sc.intel.com> <Pine.LNX.4.64.0607312152240.4168@g5.osdl.org> <20060801144403.GA1291@us.ibm.com> <Pine.LNX.4.64.0608010806100.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608010806100.4168@g5.osdl.org>
User-Agent: Mutt/1.4.1i
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

I guess I am glad I was not -totally- insane when submitting the
original patch.  ;-)

> However, I wonder if the _proper_ fix is to just either remove 
> "force_sig_specific()" entirely, or just make that one match the semantics 
> of "force_sig_info()" instead (rather than doing it the other way - change 
> for_sig_specific() to match force_sig_info()).

One question -- the original (2.6.14 or thereabouts) version of
force_sig_info() would do the sigdelset() and recalc_sig_pending()
even if the signal was not blocked, while your patch below would
do sigdelset()/recalc_sig_pending() only if the signal was blocked,
even if it was not ignored.  Not sure this matters, but thought I
should ask.

> force_sig_info() has only two uses, and both should be ok with the 

s/force_sig_info/force_sig_specific/?  I see >100 uses of force_sig_info().

> force_sig_specific() semantics, since they are for SIGSTOP and SIGKILL 
> respectively, and those should not be blockable unless you're a kernel 
> thread (and I don't think either of them could validly ever be used with 
> kernel threads anyway), so doing it the other way around _should_ be ok.

OK, SIGSTOP and SIGKILL cannot be ignored or blocked.  So wouldn't
they end up skipping the recalc_sig_pending() in the new code,
where they would have ended up executing it in the 2.6.14 version
of force_sig_specific()?

Assuming I am at least semi-sane, one possible way to fix shown below.

						Thanx, Paul

> Paul, Suresh, would something like this work for you instead?
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

	int alwaysfatal;

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

	alwaysfatal = sig == SIGKILL || sig == SIGSTOP;

> +	blocked = sigismember(&t->blocked, sig);
> +	if (blocked || ignored) {

	if (blocked || ignored || alwaysfatal) {

> +		action->sa.sa_handler = SIG_DFL;
> +		if (blocked) {

		if (blocked || alwaysfatal) {

> +			sigdelset(&t->blocked, sig);
> +			recalc_sigpending_tsk(t);
> +		}
>  	}
> -	recalc_sigpending_tsk(t);
>  	ret = specific_send_sig_info(sig, info, t);
>  	spin_unlock_irqrestore(&t->sighand->siglock, flags);
>  

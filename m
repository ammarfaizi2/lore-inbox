Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWHASXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWHASXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWHASXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:23:36 -0400
Received: from mga07.intel.com ([143.182.124.22]:23331 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751769AbWHASXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:23:32 -0400
X-IronPort-AV: i="4.07,203,1151910000"; 
   d="scan'208"; a="73445860:sNHT43461243"
Date: Tue, 1 Aug 2006 11:13:04 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: synchronous signal in the blocked signal context
Message-ID: <20060801111304.B9822@unix-os.sc.intel.com>
References: <20060731191449.B4592@unix-os.sc.intel.com> <Pine.LNX.4.64.0607312152240.4168@g5.osdl.org> <20060801144403.GA1291@us.ibm.com> <Pine.LNX.4.64.0608010806100.4168@g5.osdl.org> <20060801181331.GF1291@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060801181331.GF1291@us.ibm.com>; from paulmck@us.ibm.com on Tue, Aug 01, 2006 at 11:13:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 11:13:32AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 01, 2006 at 08:25:12AM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Tue, 1 Aug 2006, Paul E. McKenney wrote:
> > > > 
> > > > Paul? Should I just revert, or did you have some deeper reason for it?
> > > 
> > > I cannot claim any deep thought on this one, so please do revert it.
> > 
> > Well, I do have to say that I like the notion of trying to have the _same_ 
> > semantics for "force_sig_info()" and "force_sig_specific()", so in that 
> > way your patch is fine - I just missed the fact that it changed it back to 
> > the old broken ones (that results in endless SIGSEGV's if the SIGSEGV 
> > happens when setting up the handler for the SIGSEGV and other 
> > "interesting" issues, where a bug can result in the user process hanging 
> > instead of just killing it outright).
> 
> I guess I am glad I was not -totally- insane when submitting the
> original patch.  ;-)
> 
> > However, I wonder if the _proper_ fix is to just either remove 
> > "force_sig_specific()" entirely, or just make that one match the semantics 
> > of "force_sig_info()" instead (rather than doing it the other way - change 
> > for_sig_specific() to match force_sig_info()).
> 
> One question -- the original (2.6.14 or thereabouts) version of
> force_sig_info() would do the sigdelset() and recalc_sig_pending()
> even if the signal was not blocked, while your patch below would
> do sigdelset()/recalc_sig_pending() only if the signal was blocked,
> even if it was not ignored.  Not sure this matters, but thought I
> should ask.
> 
> > force_sig_info() has only two uses, and both should be ok with the 
> 
> s/force_sig_info/force_sig_specific/?  I see >100 uses of force_sig_info().
> 
> > force_sig_specific() semantics, since they are for SIGSTOP and SIGKILL 
> > respectively, and those should not be blockable unless you're a kernel 
> > thread (and I don't think either of them could validly ever be used with 
> > kernel threads anyway), so doing it the other way around _should_ be ok.
> 
> OK, SIGSTOP and SIGKILL cannot be ignored or blocked.  So wouldn't
> they end up skipping the recalc_sig_pending() in the new code,
> where they would have ended up executing it in the 2.6.14 version
> of force_sig_specific()?

I don't think it matters.
signal_wake_up() in the path of specific_send_sig_info() should anyhow
do that.

thanks,
suresh

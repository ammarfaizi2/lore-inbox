Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVFZCdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVFZCdd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 22:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVFZCda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 22:33:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13218 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261435AbVFZCbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 22:31:00 -0400
Date: Sun, 26 Jun 2005 04:30:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, raybry@engr.sgi.com,
       torvalds@osdl.org
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable for other purposes
Message-ID: <20050626023053.GA2871@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net> <20050625025122.GC22393@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506242311220.7971@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506242311220.7971@graphe.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It includes whitespace changes and most of patch is nice cleanup that
> > should probably go in separately. (Hint hint :-). 
> 
> > Previous code had important property: try_to_freeze was optimized away
> > in !CONFIG_PM case. Please keep that.
> > 
> > Best way is to introduce macros and cleanup the code to use the
> > macros, without actually changing any object code. That can go in very
> > fast. Then we can switch to atomic_t ... yeah I think that's
> > neccessary, but I'd like cleanups first.
> 
> Here is such a patch:
> 
> ---
> Cleanup patch for freezing against 2.6.12-git5.
> 
> 1. Establish a simple API for process freezing defined in linux/include/sched.h:
> 
> frozen(process)		Check for frozen process
> freezing(process)	Check if a process is being frozen
> freeze(process)		Tell a process to freeze (go to refrigerator)
> thaw_process(process)	Restart process
> frozen_process(process)		Process is frozen now
> 
> 2. Remove all references to PF_FREEZE and PF_FROZEN from all
>    kernel sources except sched.h
> 
> 3. Fix numerous locations where try_to_freeze is manually done by a driver
> 
> 4. Remove the argument that is no longer necessary from two function
> calls.

Can you just keep the argument? Rename it to int unused or whatever,
but if you do it, it stays backwards-compatible (and smaller patch,
too).

> 5. Some whitespace cleanup
> 
> 6. Clear potential race in refrigerator (provides an open window of PF_FREEZE
>    cleared before setting PF_FROZEN, recalc_sigpending does not check 
>    PF_FROZEN).
> 
> This patch does not address the problem of freeze_processes() violating the rule
> that a task may only modify its own flags by setting PF_FREEZE. This is not clean
> in an SMP environment. freeze(process) is therefore not SMP safe!
> 
> Signed-off-by: Christoph Lameter <christoph@lameter.com>

Looks mostly good but:

> Index: linux-2.6.12/arch/i386/kernel/signal.c
> ===================================================================
> --- linux-2.6.12.orig/arch/i386/kernel/signal.c	2005-06-25 05:01:26.000000000 +0000
> +++ linux-2.6.12/arch/i386/kernel/signal.c	2005-06-25 05:01:28.000000000 +0000
> @@ -608,10 +608,8 @@ int fastcall do_signal(struct pt_regs *r
>  	if (!user_mode(regs))
>  		return 1;
>  
> -	if (current->flags & PF_FREEZE) {
> -		refrigerator(0);
> +	if (try_to_freeze)
>  		goto no_signal;
> -	}
>  

This is not good. Missing ().

							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

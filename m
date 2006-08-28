Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWH1KpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWH1KpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWH1KpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:45:03 -0400
Received: from cantor.suse.de ([195.135.220.2]:55523 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964787AbWH1KpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:45:01 -0400
Date: Mon, 28 Aug 2006 12:44:59 +0200
From: Nick Piggin <npiggin@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] select_bad_process: cleanup 'releasing' check
Message-ID: <20060828104459.GA14010@wotan.suse.de>
References: <20060827182538.GA1779@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060827182538.GA1779@oleg>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2006 at 10:25:38PM +0400, Oleg Nesterov wrote:
> On top of "select_bad_process: kill a bogus PF_DEAD/TASK_DEAD check"
> 
> No logic changes, but imho easier to read.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.18-rc4/mm/oom_kill.c~	2006-08-27 20:56:23.000000000 +0400
> +++ 2.6.18-rc4/mm/oom_kill.c	2006-08-27 21:58:32.000000000 +0400
> @@ -205,7 +205,6 @@ static struct task_struct *select_bad_pr
>  	do_posix_clock_monotonic_gettime(&uptime);
>  	do_each_thread(g, p) {
>  		unsigned long points;
> -		int releasing;
>  
>  		/*
>  		 * skip kernel threads and tasks which have already released
> @@ -227,16 +226,15 @@ static struct task_struct *select_bad_pr
>  		 * the process of exiting and releasing its resources.
>  		 * Otherwise we could get an OOM deadlock.
>  		 */
> -		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
> -						p->flags & PF_EXITING;
> -		if (releasing) {
> -			if (p->flags & PF_EXITING && p == current) {
> -				chosen = p;
> -				*ppoints = ULONG_MAX;
> -				break;
> -			}
> -			return ERR_PTR(-1UL);
> -		}
> +		if ((p->flags & PF_EXITING) && p == current) {
> +			chosen = p;
> +			*ppoints = ULONG_MAX;
> +			break;
> +		}
> +		if ((p->flags & PF_EXITING) ||
> +				test_tsk_thread_flag(p, TIF_MEMDIE))
> +			return ERR_PTR(-1UL);
> +

Hmm, actually I think I spot a bug in the original logic: we don't want
to have more than 1 task with TIF_MEMDIE at once, becaues that gives it
access to memory reserves (but I saw it first in the new formulation, so
maybe that does suggest it is more readable ;)

What I think should be done is the check for TIF_MEMDIE (and return -1)
first, and then the PF_EXITING test. At which point, if current is found to
be exiting, it should be chosen but not break... that way a subsequent MEMDIE
or EXITING task has the chance to trigger the -1 return.

Anyway, if you don't want to do all that, I will when my hand gets better.
Otherwise the 3 patches you sent look good, they could all have an

Acked-by: Nick Piggin <npiggin@suse.de>

Thanks,
Nick

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVEKSGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVEKSGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVEKSGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:06:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27619 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261224AbVEKSGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:06:30 -0400
Date: Wed, 11 May 2005 20:04:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Kirill Korotaev <dev@sw.ru>, seife@suse.de
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Software suspend and recalc sigpending bug fix
Message-ID: <20050511180411.GB1866@elf.ucw.cz>
References: <428222CF.3070002@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428222CF.3070002@sw.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 11-05-05 19:20:47, Kirill Korotaev wrote:
> This patch fixes recalc_sigpending() to work correctly
> with tasks which are being freezed. The problem is that
> freeze_processes() sets PF_FREEZE and TIF_SIGPENDING
> flags on tasks, but recalc_sigpending() called from
> e.g. sys_rt_sigtimedwait or any other kernel place
> will clear TIF_SIGPENDING due to no pending signals queued
> and the tasks won't be freezed until it recieves a real signal
> or freezed_processes() fail due to timeout.
> 
> Signed-Off-By: Kirill Korotaev <dev@sw.ru>
> Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>

This should fix our problems with mysqld, right? Yes, patch looks good
(modulo missing whitespace around &)). I'll apply it to my tree. (Or
andrew, if you prefer, just take it...
								Pavel

> --- ./kernel/signal.c.freezesigrec	2005-05-10 16:10:40.000000000 +0400
> +++ ./kernel/signal.c	2005-05-10 18:10:08.000000000 +0400
> @@ -212,6 +212,7 @@ static inline int has_pending_signals(si
>  fastcall void recalc_sigpending_tsk(struct task_struct *t)
>  {
>  	if (t->signal->group_stop_count > 0 ||
> +	    (t->flags&PF_FREEZE) ||
>  	    PENDING(&t->pending, &t->blocked) ||
>  	    PENDING(&t->signal->shared_pending, &t->blocked))
>  		set_tsk_thread_flag(t, TIF_SIGPENDING);


-- 
Boycott Kodak -- for their patent abuse against Java.

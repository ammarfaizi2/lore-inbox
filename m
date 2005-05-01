Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVEAJcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVEAJcc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 05:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVEAJcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 05:32:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:3477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261574AbVEAJca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 05:32:30 -0400
Date: Sun, 1 May 2005 02:31:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, maneesh@in.ibm.com, jk@blackdown.de,
       benh@kernel.crashing.org
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
Message-Id: <20050501023149.6908c573.akpm@osdl.org>
In-Reply-To: <42748B75.D6CBF829@tv-sign.ru>
References: <42748B75.D6CBF829@tv-sign.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> When __mod_timer() changes timer's base it waits for the completion
>  of timer->function. It is just stupid: the caller of __mod_timer()
>  can held locks which would prevent completion of the timer's handler.
> 
>  Solution: do not change the base of the currently running timer.

OK, fingers crossed.  Juergen, it would be great if you could test Oleg's
patch sometime.

Oleg, could you please review the changelog in
timers-fixes-improvements.patch sometime, make sure that it's all accurate
and complete?

Also, please review the comments in timer.c - some of the info which you
placed in that changelog really should be brought into the code itself so
people can understand the data structures and their interactions without
having to trawl the changelogs and mailing list archives.

For example, in __mod_timer:

	if (timer_pending(timer)) {
		detach_timer(timer, 0);
		ret = 1;
	}

	new_base = &__get_cpu_var(tvec_bases);

	if (base != &new_base->t_base) {
		/*
		 * We really need a comment here explaining what
		 * (base != &new_base->t_base) *means*
		 */
		if (unlikely(base->running_timer == timer)) {
			/*


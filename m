Return-Path: <linux-kernel-owner+w=401wt.eu-S1752724AbWLQOkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbWLQOkh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 09:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbWLQOkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 09:40:37 -0500
Received: from mail.screens.ru ([213.234.233.54]:46369 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724AbWLQOkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 09:40:36 -0500
Date: Sun, 17 Dec 2006 17:40:19 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kill_something_info: misc cleanups
Message-ID: <20061217144019.GA110@tv-sign.ru>
References: <20061216200510.GA5535@tv-sign.ru> <20061217101856.GA1285@infradead.org> <m18xh6u5pz.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xh6u5pz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17, Eric W. Biederman wrote:
>
> I am sitting here wondering why we bother to ignore init, as init
> is protected from all signals it doesn't explicitly setup a signal
> handler for.
> ...
>                       So I believe we can delete we can delete
> the is_init check entirely without changing anything and with a less
> surprising if anyone ever cares.

is_init() is very cheap. But if we send a signal and it is not ignored
we will wake up /sbin/init without good reason, just to complete unneded
do_signal(). Also, we may have a special setup so that this signal really
means something for init (and it has a handler for). In that case the
caller of kill(-1, sig) will be surprised.

Btw, de_thread() already takes care about multithread init, but
get_signal_to_deliver() does not:

	if (current == child_reaper(current))
		continue;

	// handle sig_kernel_stop()/sig_fatal()

This doesn't protect init from SIGKILL if we send it to sub-thread (and
this can happen even if we use kill(1, sig), not tkill). Yes, the main
thread will survive, but still this is not what we want. SIGSTOP will
manage to stop entire group because sub-thread sets ->group_stop_count.

> > Christoph Hellwig <hch@infradead.org> writes:
> >
> > This also looks rather unreadable, an
> >
> >       } else if (pid) {
> >               ret = kill_pgrp_info(sig, info, find_pid(-pid));
> >       } else {
> >               ret = kill_pgrp_info(sig, info, task_pgrp(current));
> >       }
> >
> > might be slightly more code, but also a lot more readable.

I personally disagree, but this is matter of taste.

Ok, it was a cleanup only, let's forget it.

Still I don't like "p->pid > 1" check. And I don't think we need a new
helper (pid_leader or such) now. When we have multiple pid namespaces
we should rework kill(-1, sig) anyway. Right now this check means
"skip init", nothing more.

Oleg.


Return-Path: <linux-kernel-owner+w=401wt.eu-S1754599AbWLRVYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbWLRVYl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607AbWLRVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:24:41 -0500
Received: from mail.screens.ru ([213.234.233.54]:54170 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754599AbWLRVYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 16:24:40 -0500
Date: Tue, 19 Dec 2006 00:24:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kill_something_info: misc cleanups
Message-ID: <20061218212424.GB520@tv-sign.ru>
References: <20061216200510.GA5535@tv-sign.ru> <20061217101856.GA1285@infradead.org> <m18xh6u5pz.fsf@ebiederm.dsl.xmission.com> <20061217144019.GA110@tv-sign.ru> <m1irg9s64t.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1irg9s64t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > Btw, de_thread() already takes care about multithread init, but
> > get_signal_to_deliver() does not:
> >
> > 	if (current == child_reaper(current))
> > 		continue;
> 
> Probably just: current->group_leader == child_reaper(current).

No. deadlock on exec.

> Can we do the ignore in send_signal?

No. It is not possible immediately with the current implemantation,
but the main reason is that we want to retain the "init is protected
from all signals it doesn't explicitly setup a signal handler for"
property. Consider init doing

	signal(SIGTERM, handler);
	...
	signal(SIGTERM, SIG_DFL);	<----- SIGTERM comes

so we should do something for init on receive-signal path. Yes, yes,
we _can_ solve this in other way (say, change sys_rt_sigaction), but
this is nasty and doesn't solve other problems.

> > This doesn't protect init from SIGKILL if we send it to sub-thread (and
> > this can happen even if we use kill(1, sig), not tkill). Yes, the main
> > thread will survive, but still this is not what we want. SIGSTOP will
> > manage to stop entire group because sub-thread sets ->group_stop_count.
> 
> Yep.  We need to fix this.  It doesn't happen today because we don't
> have a multi-threaded init.  But as soon as untrusted users can have
> their own init this becomes we need to handle everything properly.

This is a longstanding problem, an it is connected to other longstanding
problems (say, fatal signal may be lost on exec). I wish I had a time to
at least try to find a solution.

Probably I'll find some time at the beginning of January, I have some
vague ideas. Hmm... at least I had :)

> We need two specific helpers.
> 1) To detect the real machine init and the special things we have to
>    do for it.
> 2) To detect the init of a pid namespace for user visible semantic
>    purposes like signal handling (is there anything else).

Yes, I understand. My intent was to push this cleanup before multiple
pid namespaces will change kill_something_inf(). But as I said it is
minor, and since you and Christoph don't like it (for whatever reason)
please forget it.

Oleg.


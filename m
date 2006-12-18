Return-Path: <linux-kernel-owner+w=401wt.eu-S1753971AbWLRNKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbWLRNKR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbWLRNKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:10:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57566 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbWLRNKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:10:15 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kill_something_info: misc cleanups
References: <20061216200510.GA5535@tv-sign.ru>
	<20061217101856.GA1285@infradead.org>
	<m18xh6u5pz.fsf@ebiederm.dsl.xmission.com>
	<20061217144019.GA110@tv-sign.ru>
Date: Mon, 18 Dec 2006 06:09:06 -0700
In-Reply-To: <20061217144019.GA110@tv-sign.ru> (Oleg Nesterov's message of
	"Sun, 17 Dec 2006 17:40:19 +0300")
Message-ID: <m1irg9s64t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 12/17, Eric W. Biederman wrote:
>>
>> I am sitting here wondering why we bother to ignore init, as init
>> is protected from all signals it doesn't explicitly setup a signal
>> handler for.
>> ...
>>                       So I believe we can delete we can delete
>> the is_init check entirely without changing anything and with a less
>> surprising if anyone ever cares.
>
> is_init() is very cheap. But if we send a signal and it is not ignored
> we will wake up /sbin/init without good reason, just to complete unneded
> do_signal(). 

kill(-1, SIGXXX) is sufficiently expensive and rare that waking up an
additional process doesn't matter.

> Also, we may have a special setup so that this signal really
> means something for init (and it has a handler for). In that case the
> caller of kill(-1, sig) will be surprised.

If it exists sure.  My quick glance suggested that nothing in user
space cares.  My thinking about it suggests that have a different
rule for ignoring signals for kill(-1,..) and every other kill
function is confusing.  So we may be doing the wrong thing.

> Btw, de_thread() already takes care about multithread init, but
> get_signal_to_deliver() does not:
>
> 	if (current == child_reaper(current))
> 		continue;

Yep.  That looks like something that needs to be fixed.  Looks like
I missed it when I realized multi-threaded init was a problem.
Probably just: current->group_leader == child_reaper(current).

Hmm.  If the code already has a child_reaper(current) tests in the
signal delivery that is probably the idiom we should use to start
with to detect init for signal handling purposes.

Hmm.  I don't like that test there at all.  I think this is quite
likely something I got wrong the first time through.

The desired action is: kill(1, SIGKILL) is ignored, kill(75, SIGKILL)
is delivered, even if both of those refer to the same process
the difference being in perspective which pid namespace we are
coming from.

Can we do the ignore in send_signal?

I definitely need to look at signal deliver more.

> 	// handle sig_kernel_stop()/sig_fatal()
>
> This doesn't protect init from SIGKILL if we send it to sub-thread (and
> this can happen even if we use kill(1, sig), not tkill). Yes, the main
> thread will survive, but still this is not what we want. SIGSTOP will
> manage to stop entire group because sub-thread sets ->group_stop_count.

Yep.  We need to fix this.  It doesn't happen today because we don't
have a multi-threaded init.  But as soon as untrusted users can have
their own init this becomes we need to handle everything properly.

>> > Christoph Hellwig <hch@infradead.org> writes:
>> >
>> > This also looks rather unreadable, an
>> >
>> >       } else if (pid) {
>> >               ret = kill_pgrp_info(sig, info, find_pid(-pid));
>> >       } else {
>> >               ret = kill_pgrp_info(sig, info, task_pgrp(current));
>> >       }
>> >
>> > might be slightly more code, but also a lot more readable.
>
> I personally disagree, but this is matter of taste.
>
> Ok, it was a cleanup only, let's forget it.
>
> Still I don't like "p->pid > 1" check. And I don't think we need a new
> helper (pid_leader or such) now. When we have multiple pid namespaces
> we should rework kill(-1, sig) anyway. Right now this check means
> "skip init", nothing more.

We need two specific helpers.
1) To detect the real machine init and the special things we have to
   do for it.
2) To detect the init of a pid namespace for user visible semantic
   purposes like signal handling (is there anything else).

I really don't care much about them so long as they are separate
functions.  The reason I care is that we are in the middle of
implementing the pid namespace.

Eric


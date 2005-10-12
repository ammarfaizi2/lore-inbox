Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVJLRVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVJLRVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVJLRVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:21:07 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:3474 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932440AbVJLRVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:21:06 -0400
Message-ID: <434D48FA.FD0439AA@tv-sign.ru>
Date: Wed, 12 Oct 2005 21:33:46 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Process with many NPTL threads terminates slowly on core dump signal
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kerrisk wrote:
>
> Following up (belatedly) from my earlier message, I took Daniel 
> Jacobowitz's suggestion to investigate the result from booting 
> with "profile=2".  When running my program (shwon below) on 
> 2.6.14-rc4 to create 100 threads, and sending a core dump signal, 
> the program takes 90 seconds to terminate, and readprofile shows 
> the following:

I think the coredumping code in __group_complete_signal() is bogus
and what happens is:

group_send_sig_info(P, SIGQUIT):

	adds SIGQUIT to ->shared_pending

	__group_complete_signal:

		->signal->group_exit_task = P;

		for_each_thread(t) {
			P->signal->group_stop_count ++;
			// sets TIF_SIGPENDING
			signal_wake_up(t)
		}
	

Now, P receives the signal:

get_signal_to_deliver:

	if (->signal->group_stop_count > 0) // YES
		handle_group_stop():
			if (->signal->group_exit_task == current) { // YES
				->signal->group_exit_task = NULL
				return 0;
			}

	signr = dequeue_signal(); // SIGQUIT

	do_coredump:

		->signal->flags = SIGNAL_GROUP_EXIT;

		coredump_wait:

			yield();


Now all other threads do:

get_signal_to_deliver:

	if (->signal->group_stop_count > 0) // YES
		handle_group_stop();
			if (->signal->flags & SIGNAL_GROUP_EXIT) // YES
				return 0;

	signr = dequeue_signal(); // no pending signals
		// recalc_sigpending_tsk() DOES NOT clear TIF_SIGPENDING,
		// because it sees ->group_stop_count != 0.
	
	return 0;

TIF_SIGPENDING is not cleared, so get_signal_to_deliver() will be
called again on return to userspace. When all threads will eat their
->time_slice, P will return from yield() and kill all threads.

Could you try this patch (added to mm tree):
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112887453531139
? It does not solve the whole problem, but may help.

Please report the result, if possible.

Oleg.

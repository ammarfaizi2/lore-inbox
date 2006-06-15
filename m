Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWFNVY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWFNVY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 17:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWFNVY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 17:24:29 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:64713 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932357AbWFNVY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 17:24:28 -0400
Date: Thu, 15 Jun 2006 05:24:29 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: [RFC][PATCH] Avoid race w/ posix-cpu-timer and exiting tasks
Message-ID: <20060615012429.GA16951@oleg>
References: <20060614024909.GA563@oleg> <1150239945.5799.14.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150239945.5799.14.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13, john stultz wrote:
>
> The tsk->signal check from the patch above looks like it would avoid
> this as well. Is there a specific benefit to checking that over
> exit_state?

->exit_state is protected by tasklist_lock, and it would be nice to
avoid it in run_posix_cpu_timers(). (I guess we could remove it right
now, but I forgot the code). Yes, currently it doesn't matter because
tsk == current.

Personally I dislike the testing of ->exit_state != 0 because unlike
PF_EXITING or ->sighand/->signal it is changed from 0 to 1 in the middle
of do_exit() path. Imho it should be used only by do_exit/do_wait path,
but maybe this is just me.

Btw, I think there is another problem,

	check_process_timers:

			t = tsk;
			do {

				...
				
				do {
					t = next_thread(t);
				} while (unlikely(t->flags & PF_EXITING));
			} while (t != tsk);


This can hang if the local timer interrupt happens right after do_exit()
sets PF_EXITING ?

Oleg.


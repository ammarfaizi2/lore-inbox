Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSFQVCG>; Mon, 17 Jun 2002 17:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317016AbSFQVCF>; Mon, 17 Jun 2002 17:02:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6419 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317013AbSFQVCE>; Mon, 17 Jun 2002 17:02:04 -0400
Date: Mon, 17 Jun 2002 14:02:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v2.5.22 - add wait queue function callback support
In-Reply-To: <20020617165340.F1457@redhat.com>
Message-ID: <Pine.LNX.4.44.0206171357450.875-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jun 2002, Benjamin LaHaise wrote:
>
> Anyways, the patch below changes add_wait_queue_cond
> to use spin_locks directly.

Can you do one more thing for me: change the "NULL" in the wake function
to be a "default_wake_function()" that looks something like

	int default_wake_function(task_t *p, unsigned int mode, int sync)
	{
		return (p->state & mode) && try_to_wake_up(p, sunc);
	}

and then you just make the code in __wake_up_common() do

	list_for_each(tmp, &q->task_list) {
		curr = list_entry(tmp, wait_queue_t, task_list);
		p = curr->task;
		if (curr->func(p, mode, sync) &&
		    ((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
			break;
	}

instead of having separate code-paths for the "func" and the default
wake-up action.

In short, the event "func" could never be NULL, and would always return
whether the wakeup/event was "successful" from an exclusivity standpoint.

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVCNTnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVCNTnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVCNTns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:43:48 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:62733
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S261770AbVCNTku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:40:50 -0500
Date: Mon, 14 Mar 2005 11:40:36 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] del_timer_sync scalability patch
In-Reply-To: <42343C61.6A1210C0@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0503141134240.31933@server.graphe.net>
References: <4231E959.141F7D85@tv-sign.ru> <42343C61.6A1210C0@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 Mar 2005, Oleg Nesterov wrote:

> I suspect that del_timer_sync() in its current form is racy.
>
> CPU 0						CPU 1
>
> __run_timers() sets timer->base = NULL
>
> 						del_timer_sync() starts, calls del_timer(), it returns
> 						because timer->base == NULL.
>
> 						waits until the run is complete:
> 							while (base->running_timer == timer)
> 								preempt_check_resched();
>
> 						calls schedule(), or long interrupt happens.
>
> timer reschedules itself, __run_timers()
> exits.
>
> 						base->running_timer == NULL, end of loop.
>
> next timer interrupt, __run_timers() picks
> this timer again, sets timer->base = NULL
>
> 						if (timer_pending(timer))	// no, timer->base == NULL

timer->base is != NULL because the timer has rescheduled itself.
__mod_timer sets timer->bBase

> 							goto del_again;		// not taken

Yes it is taken!

>
> 						del_timer_sync() returns
>
> timer runs.

Nope.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVCMMHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVCMMHv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 07:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVCMMHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 07:07:51 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:37608 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261168AbVCMMHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 07:07:44 -0500
Message-ID: <42343C61.6A1210C0@tv-sign.ru>
Date: Sun, 13 Mar 2005 16:13:05 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Christoph Lameter <christoph@lameter.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] del_timer_sync scalability patch
References: <4231E959.141F7D85@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect that del_timer_sync() in its current form is racy.

CPU 0						CPU 1

__run_timers() sets timer->base = NULL

						del_timer_sync() starts, calls del_timer(), it returns
						because timer->base == NULL.

						waits until the run is complete:
							while (base->running_timer == timer)
								preempt_check_resched();
						
						calls schedule(), or long interrupt happens.

timer reschedules itself, __run_timers()
exits.

						base->running_timer == NULL, end of loop.

next timer interrupt, __run_timers() picks
this timer again, sets timer->base = NULL

						if (timer_pending(timer))	// no, timer->base == NULL
							goto del_again;		// not taken

						del_timer_sync() returns

timer runs.

No?

Oleg.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVCOQO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVCOQO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVCOQO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:14:29 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:17577 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261367AbVCOQON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:14:13 -0500
Message-ID: <4237192B.7E8AA85A@tv-sign.ru>
Date: Tue, 15 Mar 2005 20:19:39 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/2] del_timer_sync: proof of concept
References: <4231E959.141F7D85@tv-sign.ru> <Pine.LNX.4.58.0503111254270.25992@server.graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> If we're prepared to rule that a timer handler is not allowed to do
> add_timer_on() then a recurring timer is permanently pinned to a CPU, isn't
> it?
>
> That should make things simpler?

In that case I think that both problems (race and scalability)
can be solved without increasing sizeof(timer_list).

What if timer_list had ->pending field? Then we can do:

timer_pending:
	return timer->pending;

__mod_timer:
	internal_add_timer(new_base, timer);
	timer->base = new_base;
	timer->pending = 1;

__run_timers:
	list_del(&timer->entry);
	set_running_timer(base, timer);

	/* do not change timer->base */
	timer->pending = 0;

	spin_unlock(base->lock);
	timer->function();

del_timer:
	if (!timer->pending)
		return 0;
	base = timer->base;
	...

del_timer_sync:
	base = timer->base;
	if (!base)
		return 0;
	spin_lock(base->lock);

	if (base != timer->base)
		goto del_again;
	if (base->running_timer == timer)
		goto del_again;

	if (timer->pending)
		list_del(&timer->entry);

	timer->pending = 0;
	timer->base = NULL;

The ->pending flag could live in the least significant bit of
timer->base, this way we:
	1. do not waste the space
	2. can read/write base+pending atomically

These patches are incomplete/suboptimal, just a proof of concept.

Oleg.

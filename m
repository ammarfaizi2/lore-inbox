Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWHMM6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWHMM6L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 08:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWHMM6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 08:58:11 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:35459 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751163AbWHMM6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 08:58:10 -0400
Date: Sun, 13 Aug 2006 21:21:54 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_sched_setscheduler: don't take tasklist_lock
Message-ID: <20060813172154.GA1918@oleg>
References: <20060813170340.GA1913@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813170340.GA1913@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13, Oleg Nesterov wrote:
>
> We don't need to take tasklist_lock or disable irqs for
> find_task_by_pid() + get_task_struct(). Use RCU locks
> instead.

On the other hand, I think sched_setscheduler() does need tasklist_lock!

It is unsafe do dereference ->signal unless tasklist_lock or ->siglock
is held (or p == current). Yes, we pin the task structure, but this can't
prevent from release_task()->__exit_signal() which sets ->signal = NULL.

So, I think this patch

	[PATCH] Drop tasklist lock in do_sched_setscheduler
	commit e74c69f46d93d29eea0ad8647863d1c6488f0f55

is not correct.

Am I missed something?

Oleg.


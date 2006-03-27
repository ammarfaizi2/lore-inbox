Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWC0U6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWC0U6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWC0U6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:58:41 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:45227 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751127AbWC0U6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:58:40 -0500
Date: Tue, 28 Mar 2006 03:55:30 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 2/2] hrtimer
Message-ID: <20060327235530.GA7024@oleg>
References: <20060325121219.172731000@localhost.localdomain> <20060325121223.966390000@localhost.localdomain> <20060325183213.63ab667c.akpm@osdl.org> <1143411016.5344.139.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143411016.5344.139.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also think this is racy.

CPU_0					CPU_1

hrtimer_wakeup:

	task = t->task;
	t->task = NULL;

	<--- INTERRUPT --->

					task is woken by signal,
					do_nanosleep() sees t->task == NULL,
					returns without hrtimer_cancel(),
					and __exits__.

	<--- RESUME --->

	wake_up_process(task);

Instead of exit(), 'task' can go to TASK_STOPPED or TASK_UNINTERRUPTIBLE
after return from do_nanosleep(), it will be awakened by hrtimer_wakeup()
unexpectedly.

Oleg.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVKFNSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVKFNSk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 08:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVKFNSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 08:18:40 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:10917 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750810AbVKFNSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 08:18:39 -0500
Message-ID: <436E1401.920A83EE@tv-sign.ru>
Date: Sun, 06 Nov 2005 17:32:33 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       mingo@elte.hu, suzannew@cs.pdx.edu
Subject: Posix timers vs exec problems
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland, George, I think posix timers have problems with de_thread().

First, when non-leader thread does exec it calls release_task(->group_leader)
before calling exit_itimers(). This means that send_group_sigqueue() can oops
after taking tasklist_lock while doing spin_lock_irqsave(->sighand->siglock).
This is easy to fix.

cpu-timers have another problem. In !CPUCLOCK_PERTHREAD() case we attach the
timer to ->signal->cpu_timers, so these timers (when created by another process)
will survive after exec. However they will continue to profile execed process
only if it was group_leader who did exec, otherwise posix_cpu_timer_schedule()
will notice that timer->it.cpu.task has ->signal == NULL and stop this timer.

So, should de_thread() call posix_cpu_timers_exit_group() after exit_itimers()
thus stoping cpu-timers after exec? Another option is to change ->it.cpu.task for
each timer in ->signal->cpu_timers, this way cpu-timers will continue to work.
But this is not trivial.

Oleg.

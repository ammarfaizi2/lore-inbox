Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVHWKmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVHWKmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 06:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVHWKmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 06:42:17 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:50143
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932120AbVHWKmQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 06:42:16 -0400
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <430A012E.1CAF0A2F@tv-sign.ru>
References: <20050818060126.GA13152@elte.hu>
	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
	 <43076138.C37ED380@tv-sign.ru>
	 <1124617458.23647.643.camel@tglx.tec.linutronix.de>
	 <43085E97.4EC3908B@tv-sign.ru>
	 <1124659468.23647.695.camel@tglx.tec.linutronix.de>
	 <1124661032.23647.698.camel@tglx.tec.linutronix.de>
	 <4309731E.ED621149@tv-sign.ru>
	 <1124698127.23647.716.camel@tglx.tec.linutronix.de>
	 <43099235.65BC4757@tv-sign.ru>
	 <1124705208.23647.737.camel@tglx.tec.linutronix.de>
	 <430A012E.1CAF0A2F@tv-sign.ru>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 23 Aug 2005 12:42:48 +0200
Message-Id: <1124793768.23647.800.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 20:45 +0400, Oleg Nesterov wrote:
> But I know nothing about kernel/posix-cpu-timers.c, I doubt it will work
> for posix_cpu_timer_del(). I don't have time to study posix-cpu-timers now.
> However, I see that __exit_signal() calls posix_cpu_timers_exit_xxx(), so
> may be it can work?

timer->it.cpu.task is set to NULL by posix_cpu_timers_exit(), so the
code in posix_cpu_timer_del returns before accessing tasklist_lock.


The exit functions do not take any locks, but it is not necessary
there. 

posix_run_cpu_timers(p) is called with p=current() and we have
interrupts disabled, so the timer interrupt can not run on this CPU. The
current exiting process can not run at the same time on a different CPU,
so no race and lockup possible here.

tglx




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTKIAVT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 19:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTKIAVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 19:21:18 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:16140
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261947AbTKIAVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 19:21:17 -0500
Subject: Re: Linux kernel preemption (kernel 2.6 of course)
From: Robert Love <rml@tech9.net>
To: oleg_orel@yahoo.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031108012755.41882.qmail@web80007.mail.yahoo.com>
References: <20031108012755.41882.qmail@web80007.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1068337282.27320.198.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 08 Nov 2003 19:21:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-07 at 20:27, Oleg OREL wrote:
> I was browsing linux kernel to undetsnand how kernel preemption does
> work. I was hacking around schedulee_tick and other functions called
> out of timer interrupt and was unable to found any call to schedule()
> or switch_to() to peempt currently running task, instead just mangling
> around current and inactive runqueues.

Linux rarely forces a reschedule, because interrupt handlers cannot
block.  So we have the need_resched variable (in 2.6, a flag in
thread_info) to note if a reschedule is pending.

The scheduler is then invoked asap.

> That leads me to a thought that currently running task wont be
> preempted within time-tick, instead it might happends in the next call
> to preempt_schedule out of spin_lock for instance.

Yes, this is true.  With kernel preemption enabled, if a task is
executing in the kernel, and an interrupt occurs that marks
need_resched, the reschedule will take place immediately on return from
interrupt UNLESS a lock is held.  In which case the reschedule will
occur when the lock is released (specifically, when preempt_count hits
zero).

Without kernel preemption, the reschedule will not take place until the
executing task in the kernel blocks and a return to user-space occurs.

	Robert Love



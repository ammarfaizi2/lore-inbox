Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263384AbVFYJvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbVFYJvt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 05:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbVFYJvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 05:51:49 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:21961 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263384AbVFYJvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 05:51:03 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Driver writer's guide to sleeping
Date: Sat, 25 Jun 2005 12:50:18 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506251250.18133.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm working on a Linux wireless driver.

I compiled a little guide for myself about waiting primitives.
I would appreciate if you look thru it. Maybe I'm wrong somewhere.

udelay(us)
	Busywaits for specified amount of usecs.
	Ok to call in IRQ-disabled regions.
	May be preempted (if not in atomic region).
    Q: how precise is it? (can it sometimes wait much longer?
    If yes, is that happens only if preempted?)

mdelay(ms)
	Same as udelay but for msecs.

schedule()
	switch to other runnable task, if any. CPU
	will be returned to us as soon as no other runnable tasks
	with higher dynamic prio are left. This means
	that sometimes schedule() returns practically at once.

yield()
	like schedule() but also drop our dynamic prio
	to the minimum. result: all other runnable tasks will
	run before CPU is returned to us. Yet, yield may return
	at once if there is no runnable tasks.

schedule_timeout(timeout)
	Whee, it has a comment! :)
 * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
 * pass before the routine returns. The routine will return 0
 *
 * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
 * delivered to the current task. In this case the remaining time
 * in jiffies will be returned, or 0 if the timer expired in time
 *
 * The current task state is guaranteed to be TASK_RUNNING when this
 * routine returns.
	Thus:
	set_current_state(TASK_[UN]INTERRUPTIBLE);
	schedule_timeout(timeout_in_jiffies)

msleep(ms)
	Sleeps at least ms msecs.
	Equivalent to:
	set_current_state(TASK_UNINTERRUPTIBLE);
	schedule_timeout(timeout)
    Q: why implementation does while(timeout) timeout = schedule_timeout(timeout)?
    Does that mean that	schedule_timeout's comment (see above) is not true?!

msleep_interruptible(ms)
	Sleeps ms msecs (or more) unless has been woken up (signal, waitqueue...).
    Q: exact list of possible waking events? (I'm a bit overwhelmed by multitude
    of slightly different waitqueues, tasklets, softirqs, bhs...)

ssleep(s)
	Same as msleep but in seconds

need_resched()
	returns true if for some reason kernel would like to schedule
	another task. Useful to check under lock for lock breaking.

cond_resched()
	basically: while(need_resched()) schedule();
	returns 1 if scheduled at least once.
--
vda


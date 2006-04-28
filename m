Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWD1LXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWD1LXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWD1LXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:23:34 -0400
Received: from farside.demon.co.uk ([83.104.247.136]:3576 "EHLO
	lorenz.farside.org.uk") by vger.kernel.org with ESMTP
	id S965008AbWD1LXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:23:33 -0400
Date: Fri, 28 Apr 2006 12:23:31 +0100
From: Malcolm Rowe <malcolm-linux@farside.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Can't change priority via sys_sched_setscheduler()?
Message-ID: <20060428112331.GA9702@lorenz.farside.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this is probably a silly question, but what's the correct way to
adjust (reduce, in my case) the priority of a SCHED_NORMAL/SCHED_OTHER
pthread?

glibc translates calls to pthread_setschedprio and pthread_setschedparam
into sys_sched_setparam and sys_sched_setscheduler respectively, which
both end up at sched_setscheduler(), which does:

        /*
         * Valid priorities for SCHED_FIFO and SCHED_RR are
         * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL and
         * SCHED_BATCH is 0.
         */
        if (param->sched_priority < 0 ||
            (p->mm && param->sched_priority > MAX_USER_RT_PRIO-1) ||
            (!p->mm && param->sched_priority > MAX_RT_PRIO-1))
                return -EINVAL;
        if ((policy == SCHED_NORMAL || policy == SCHED_BATCH)
                                        != (param->sched_priority == 0))
                return -EINVAL;

So calls to (for example)
  struct sched_param sp = {9};
  pthread_setschedparam(scthread, SCHED_OTHER, &sp);

Will fail with EINVAL.  Yet calls to setpriority(PRIO_PROCESS, 0, 9)
within the thread will work as expected.

I suspect I'm missing something - what is it?

Thanks,
Malcolm
(please cc: me, I'm not subscribed)

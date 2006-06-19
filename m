Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWFSIHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWFSIHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWFSIHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:07:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23186 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932252AbWFSIHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:07:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm_timer: remove a racy and obsolete PF_EXITING check
In-Reply-To: Oleg Nesterov's message of  Thursday, 15 June 2006 20:12:02 +0400 <20060615161202.GA21463@oleg>
Emacs: well, why *shouldn't* you pay property taxes on your editor?
Message-Id: <20060619080656.42097180049@magilla.sf.frob.com>
Date: Mon, 19 Jun 2006 01:06:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this and your other two patches are fine fixes.  Thanks, Oleg.

> However, for some reason it does so only for CPUCLOCK_PERTHREAD
> case (which is imho wrong).

For a process CPU clock timer, ->it.cpu.task is the thread group leader.
The group leader can exit and will be a lingering zombie for as long as
other threads in the group live.  The process timers need to keep getting
armed and working both during and after the group leader's exit processing.

> Also, this check is not reliable, PF_EXITING could be set on
> another cpu without any locks/barriers just after the check,
> so it can't prevent from attaching the timer to the exiting
> task.
> 
> The previous patch makes this check unneeded.

Thanks for cleaning that up.  The original rationale behind the checking
for exiting threads was an attempt to avoid process_timer_rebalance
counting a dead thread as live and setting all the live threads' expiry
timers too short, as well as avoiding setting it_*_expires after do_exit
cleared them.  The latter didn't suffice anyway and you've fixed it another
way.  The former doesn't really do any harm, since it just means a
possibility of early wakeup and recheck in the remaining live threads.


Thanks,
Roland


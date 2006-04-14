Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWDNLgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWDNLgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 07:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWDNLgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 07:36:37 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:31445 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751144AbWDNLgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 07:36:37 -0400
Date: Fri, 14 Apr 2006 19:33:36 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH rc1-mm 2/3] coredump: shutdown current process first
Message-ID: <20060414153336.GB131@oleg>
References: <20060409001127.GA101@oleg> <20060410070840.26AE41809D1@magilla.sf.frob.com> <20060410140131.GB85@oleg> <m1hd4w4m84.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hd4w4m84.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > On 04/10, Roland McGrath wrote:
> >>
> >> I would be inclined to restructure the inner loop something like this:
> >> 
> >> 		p = g;
> >> 		while (unlikely(p->mm == NULL)) {
> >> 			p = next_thread(p);
> >> 			if (p == g)
> >> 				break;
> >> 		}
> >> 		if (p->mm == mm) {
> >> 			/*
> >> 			 * p->sighand can't disappear, but
> >> 			 * may be changed by de_thread()
> >> 			 */
> >> 			lock_task_sighand(p, &flags);
> >> 			zap_process(p);
> >> 			unlock_task_sighand(p, &flags);
> >> 		}
> >
> > Yes, I agree, this is much more understandable.
> 
> There is one piece of zap_threads that still makes me uncomfortable.
> 
> task_lock is used to protect p->mm.
> Therefore killing a process based upon p->mm == mm is racy
> with respect to sys_unshare I believe if we don't take
> task_lock.

Well, unshare(CLONE_VM) is not yet supported. Currently (as I see
it) mm->mmap_sem is enough to protect against changing ->mm. Yes,
exit_mm/exec_mmap take task_lock too, so it can be used as well.
Please correct my understanding.

I think it is better to take ->mmap_sem in sys_unshare, this path
is rare.

Oleg.

